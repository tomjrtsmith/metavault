// SPDX-License-Identifier: MIT
pragma solidity >=0.7.2;

import {ReentrancyGuardUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {Vault} from "../libraries/Vault.sol";

abstract contract OptionsVaultStorageV1 is
    ReentrancyGuardUpgradeable,
    OwnableUpgradeable,
    ERC20Upgradeable
{
    /// @notice Stores the user's pending deposit for the round
    mapping(address => Vault.DepositReceipt) public depositReceipts;

    /// @notice On every round's close, the pricePerShare value of an rTHETA token is stored
    /// This is used to determine the number of shares to be returned
    /// to a user with their DepositReceipt.depositAmount
    mapping(uint256 => uint256) public roundPricePerShare;

    /// @notice Stores pending user withdrawals
    mapping(address => Vault.Withdrawal) public withdrawals;

    Vault.VaultParams public vaultParams;

    Vault.VaultState public vaultState;

    address public feeRecipient;

    // role in charge of weekly vault operations such as rollToNextOption and burnRemainingOTokens
    // no access to critical vault changes
    address public keeper;

    uint256 public performanceFee;

    uint256 public managementFee;
}

// We are following Compound's method of upgrading new contract implementations
// When we need to add new storage variables, we create a new version of OptionsVaultStorage
// e.g. OptionsVaultStorageV<versionNumber>, so finally it would look like
// contract OptionsVaultStorage is OptionsVaultStorageV1, OptionsVaultStorageV2
abstract contract OptionsVaultStorage is OptionsVaultStorageV1 {

}