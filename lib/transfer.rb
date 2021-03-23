require "pry"
class Transfer
   attr_accessor :status, :bankaccount 
   attr_reader :amount, :sender, :receiver

  def initialize(sender, receiver, status, amount = 50)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && @status == "pending" && amount < @sender.balance
        @sender.balance -= amount
        @receiver.balance += amount
        @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
      end
  end

  def reverse_transfer
    if valid? && @receiver.balance > amount && @status == "complete"
      @receiver.balance = @receiver.balance - amount
      @sender.balance = @sender.balance + amount
      @status = "reversed"
    end
  end
end
