module MyModule::ArcadiaID {
    use aptos_framework::signer;
    use std::string;

    /// Struct representing a user's identity record
    struct Identity has key, store {
        name: string::String,
        verified: bool,
    }

    /// Function to register a user's identity (initially unverified)
    public fun register_identity(user: &signer, name: string::String) {
        let identity = Identity {
            name,
            verified: false,
        };
        move_to(user, identity);
    }

    /// Function to verify a registered identity (by a trusted verifier)
    public fun verify_identity(verifier: &signer, user_addr: address) acquires Identity {
        let identity = borrow_global_mut<Identity>(user_addr);
        identity.verified = true;
    }
}
