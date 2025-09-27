Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBF1F5820
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758945116; cv=none; b=ECf9R/2XdtqC68kaTXiTT1bx72cGAY+UqjQKxRhRgOjj9CXNMB2cm+OOqRR2xB/Ca0Q9XR1LxacwWZin3IMmlOHgxHe+cL7EV5ThChSvfE8YJMLcLd5xrZCwwJ/6iDFTbvbQYXoJ2uL6D7jKDIPdObSCI3sYQPstT98WoOgFlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758945116; c=relaxed/simple;
	bh=Vnl3F61wLTYC2C4vyyLle4IPy1vI++wFxv0PtupjGn8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EKAUATjte5AS4wTbCyHAjPwEGG0zbK9VuX3YA3yCYnG60WOGQtQr591T+CGQPQGNSsIeDGKfOmaVoJYm/ef5c56RONq+CyNR0B4YelMpf1MawgpkWzjoQw6MxcV1JVus1QiGajfEJQL8ddOsFXxvTb3Y8NK+4rsVp9+vUaF7SM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP/BDw75; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP/BDw75"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2570bf6058aso40972435ad.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 20:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758945113; x=1759549913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmKL4cTTdV3MQ0J6k8lMVzasXoOjNykpUNuAGgIwLpU=;
        b=eP/BDw75v8cGn8zeyiaD0LioVxJFBg/Lfj5mUaLYOGlJwgFMZTAmw63NAfQ0lmEGqA
         0TyRq5tluyA2aWTIrbCUtLy1zr7IdDnQ6SE61sm8tN2vA2FGb6wYcMhZ3aWduFzot+js
         rUymeML89sW2odvlyGqP4vDR5cNfsplRDmZVFVuSSjpyjpKU/J3rwTyzEcz7J3v4XRRH
         8es/OLNVmU/P907d/mGSYJB1IP+KwqtDeoOJ6PaLXR8arcjf5NkU6wjbvlWxT7DvvCfk
         PNiry5N3wcDkdCyVSowLV6R23peaGNQPzMqWOTV//f0prvgdRoSu3D6vgq1+Oplef7ht
         OAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758945113; x=1759549913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmKL4cTTdV3MQ0J6k8lMVzasXoOjNykpUNuAGgIwLpU=;
        b=GrBGmyX05MOZKfwXQY3Se6ek91nqbz4u0BRtQzdtu6FeUK2+2THlHXPCmUIgKuKa8J
         jgYxPgaSkGyyFHuhO3qCligqaVvOnXIuHVlO31RfNCdkoSkPyAoy1Owxk7O1hJ79dfzq
         2XJF6Ve+BlO2TgD4d74/6puznj4fB8VtZSeovmtegDPDBmdscPYTtfP0dL0MkuwFJ/HC
         1AXA6MssfQTRjk3Zlxl7Zzo34jIOQNndfip7dTx7MJlR/5DxQRW4e5zW96+V02JTSxio
         RTRbuAvDS8tHZ+vXDREKJ4Y7GOUgI4/qvulwGKPbuKCgfBc7u4xLfaJBoP8MgAV9ZL/c
         f8FA==
X-Gm-Message-State: AOJu0YyaSeRbZDmP/76LuFnWCdJnA6XCixxNY/8/mECOjlAIQaVvt6uW
	dm6bADCMhAC64l5OClVRsN5LaiTLeZLUWAo9sEdbzFJmqr5VwXq7qa5iOhnIag==
X-Gm-Gg: ASbGncuXfVkAwUuYH7D9BBo2bRHrzgVM8DXEdRhFhiT6pJo2nqEXVMfUSjEj64uagrn
	OXx0rm+m5pedDIeRBvKA9nRB6+IhkCoIcZUD8gRIFK+E4g1o8k6WZwKIXz1EWyN01/zznR2u7Vt
	cNac+wu7NZH+NauXB972gMSG5i+/FIdwme7tnZ/HLDWEFwY41Svcw9s3UPzTCLbZvBV1lRHxOx5
	llh/e6Si0rAWG3WYPcLFjkur7q3Q4L+XoDiwHaOg7ByyI5fvXT/ZgpIDDzwfsZ38QUMs/rSx8+i
	ZrpbUt58ruHhBqQw5vcD6nU6Yr/uPqLcOZdWX4Xch1L/6IGOkK4X/qc1HbCT9v4EX6cRSew3uj6
	KxJ589lz/DS9ekoUdzgmAH7eHj3MpJuk9JE6I
X-Google-Smtp-Source: AGHT+IGf4ek6F2FAPseOUFQ7IepPDe3q7W+Yt4GobmKM8znRPB9u0BKX1hZYYIM31otv0+orweTy9A==
X-Received: by 2002:a17:902:e5c4:b0:27e:da3a:32bc with SMTP id d9443c01a7336-27eda3a38b2mr82558785ad.33.1758945113069;
        Fri, 26 Sep 2025 20:51:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.218.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6700ccdsm67284795ad.37.2025.09.26.20.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:51:52 -0700 (PDT)
Message-Id: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
References: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
From: "ions via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 03:51:48 +0000
Subject: [PATCH v3 0/3] libgit-rs: add get_bool() method to ConfigSet
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    ions <zara.leonardo@gmail.com>

Purpose

This pull request introduces a get_bool() method to the ConfigSet module in
the libgit-rs library. The goal is to enhance the functionality of ConfigSet
by providing a way to fetch and handle boolean configuration values more
easily and consistently.

Implementation Details

• Added a get_bool() method to the ConfigSet module.

• The method retrieves configuration values as boolean values, ensuring
proper parsing and error handling.

• This addition simplifies the process of working with boolean
configurations for developers using the ConfigSet module.

Testing

• Added unit tests to verify the correctness of the get_bool() method.

• Tested edge cases to ensure robustness.

ionnss (3):
  po: fix escaped underscores in README.md
  libgit-rs: add get_bool() method to ConfigSet
  libgit-rs: add get_ulong() and get_pathname() methods

 contrib/libgit-rs/src/config.rs    | 83 +++++++++++++++++++++++++++++-
 contrib/libgit-rs/testdata/config3 |  2 +-
 contrib/libgit-rs/testdata/config4 | 13 +++++
 contrib/libgit-sys/src/lib.rs      | 24 ++++++++-
 po/README.md                       |  6 +--
 5 files changed, 121 insertions(+), 7 deletions(-)
 create mode 100644 contrib/libgit-rs/testdata/config4


base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1977%2Fionnss%2Fadd-rust-configset-get-bool-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1977/ionnss/add-rust-configset-get-bool-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1977

Range-diff vs v2:

 1:  d7810781fc = 1:  d7810781fc po: fix escaped underscores in README.md
 3:  43784e3ff9 ! 2:  479c263bc1 libgit-rs: address review feedback for get_bool()
     @@ Metadata
      Author: ionnss <zara.leonardo@gmail.com>
      
       ## Commit message ##
     -    libgit-rs: address review feedback for get_bool()
     +    libgit-rs: add get_bool() method to ConfigSet
      
     -    - Use git_configset_get_bool() C function instead of reimplementing parsing
     -    - Fix libgit_configset_get_bool() function signature in bindings
     -    - Improve .expect() error messages to be more descriptive
     -    - Add comprehensive boolean tests including edge cases (00, 100, 007)
     +    Add support for parsing boolean configuration values using Git's
     +    git_configset_get_bool() C function. This ensures consistent behavior
     +    with Git's native boolean parsing logic.
      
     -    This addresses feedback from Phillip Wood and Chris Torek about using
     -    Git's actual boolean parsing logic rather than duplicating it in Rust.
     +    The method handles all Git boolean formats (true/false, yes/no, on/off,
     +    1/0) and edge cases like "00" and "100" correctly.
     +
     +    Includes comprehensive tests for various boolean formats and edge cases.
      
          Signed-off-by: ionnss <zara.leonardo@gmail.com>
      
       ## contrib/libgit-rs/src/config.rs ##
      @@ contrib/libgit-rs/src/config.rs: impl ConfigSet {
     +             Some(owned_str)
               }
           }
     - 
     ++
      +    /// Load the value for the given key and attempt to parse it as a boolean. Dies with a fatal error
      +    /// if the value cannot be parsed. Returns None if the key is not present.
     -     pub fn get_bool(&mut self, key: &str) -> Option<bool> {
     --        let key = CString::new(key).expect("Couldn't convert key to CString");
     --        let mut val: *mut c_char = std::ptr::null_mut();
     ++    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
      +        let key = CString::new(key).expect("config key should be valid CString");
      +        let mut val: c_int = 0;
     -         unsafe {
     --            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
     --            {
     ++        unsafe {
      +            if libgit_configset_get_bool(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
     -                 return None;
     -             }
     --            let borrowed_str = CStr::from_ptr(val);
     --            let owned_str =
     --                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
     --            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
     --            match owned_str.to_lowercase().as_str() {
     --                "true" | "yes" | "on" | "1" => Some(true),
     --                "false" | "no" | "off" | "0" => Some(false),
     --                _ => None,
     --            }
     -         }
     ++                return None;
     ++            }
     ++        }
      +
      +        Some(val != 0)
     -     }
     ++    }
       }
       
     + impl Default for ConfigSet {
      @@ contrib/libgit-rs/src/config.rs: mod tests {
                   Path::new("testdata/config1"),
                   Path::new("testdata/config2"),
     @@ contrib/libgit-rs/src/config.rs: mod tests {
               assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
               // ConfigSet returns None for missing key
               assert_eq!(cs.get_string("foo.bar"), None);
     --        // Test boolean parsing
     --        assert_eq!(cs.get_bool("test.booleanValue"), Some(true));
      +        // Test boolean parsing - comprehensive tests
      +        assert_eq!(cs.get_bool("test.boolTrue"), Some(true));
      +        assert_eq!(cs.get_bool("test.boolFalse"), Some(false));
     @@ contrib/libgit-rs/src/config.rs: mod tests {
      +        assert_eq!(cs.get_bool("test.boolZero"), Some(false));
      +        assert_eq!(cs.get_bool("test.boolZeroZero"), Some(false)); // "00" → false
      +        assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
     -+        assert_eq!(cs.get_bool("test.boolSeven"), Some(true)); // "007" → true
     -         // Test missing boolean key
     -         assert_eq!(cs.get_bool("missing.boolean"), None);
     ++        // Test missing boolean key
     ++        assert_eq!(cs.get_bool("missing.boolean"), None);
           }
     + }
      
       ## contrib/libgit-rs/testdata/config3 ##
      @@
       [trace2]
      -	eventNesting = 3
     --[test]
     --	booleanValue = true
      +	eventNesting = 3
       \ No newline at end of file
      
     @@ contrib/libgit-rs/testdata/config4 (new)
      +	boolZero = 0
      +	boolZeroZero = 00
      +	boolHundred = 100
     -+	boolSeven = 007
      
       ## contrib/libgit-sys/src/lib.rs ##
      @@ contrib/libgit-sys/src/lib.rs: extern "C" {
 2:  a5904a2ac0 ! 3:  1ac8d76819 libgit-rs: add get_bool() method to ConfigSet
     @@ Metadata
      Author: ionnss <zara.leonardo@gmail.com>
      
       ## Commit message ##
     -    libgit-rs: add get_bool() method to ConfigSet
     +    libgit-rs: add get_ulong() and get_pathname() methods
      
     -    Add support for parsing boolean configuration values in the Rust
     -    ConfigSet API. The method follows Git's standard boolean parsing
     -    rules, accepting true/yes/on/1 as true and false/no/off/0 as false.
     +    Expand the ConfigSet API with additional configuration value types:
      
     -    The implementation reuses the existing get_string() infrastructure
     -    and adds case-insensitive boolean parsing logic.
     +    - get_ulong(): Parse unsigned long integers for large numeric values
     +    - get_pathname(): Parse file paths, returning PathBuf for type safety
     +
     +    Both functions follow the same pattern as existing get_* methods,
     +    using Git's C functions for consistent parsing behavior.
     +
     +    Add comprehensive tests covering normal cases, edge cases, and
     +    error handling for all new functionality.
      
          Signed-off-by: ionnss <zara.leonardo@gmail.com>
      
       ## contrib/libgit-rs/src/config.rs ##
     +@@
     + use std::ffi::{c_void, CStr, CString};
     +-use std::path::Path;
     ++use std::path::{Path, PathBuf};
     + 
     + #[cfg(has_std__ffi__c_char)]
     +-use std::ffi::{c_char, c_int};
     ++use std::ffi::{c_char, c_int, c_ulong};
     + 
     + #[cfg(not(has_std__ffi__c_char))]
     + #[allow(non_camel_case_types)]
     +@@ contrib/libgit-rs/src/config.rs: type c_char = i8;
     + #[allow(non_camel_case_types)]
     + type c_int = i32;
     + 
     ++#[cfg(not(has_std__ffi__c_char))]
     ++#[allow(non_camel_case_types)]
     ++type c_ulong = u64;
     ++
     + use libgit_sys::*;
     + 
     + /// A ConfigSet is an in-memory cache for config-like files such as `.gitmodules` or `.gitconfig`.
      @@ contrib/libgit-rs/src/config.rs: impl ConfigSet {
     -             Some(owned_str)
     -         }
     + 
     +         Some(val != 0)
           }
      +
     -+    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
     -+        let key = CString::new(key).expect("Couldn't convert key to CString");
     ++    /// Load the value for the given key and attempt to parse it as an unsigned long. Dies with a fatal error
     ++    /// if the value cannot be parsed. Returns None if the key is not present.
     ++    pub fn get_ulong(&mut self, key: &str) -> Option<u64> {
     ++        let key = CString::new(key).expect("config key should be valid CString");
     ++        let mut val: c_ulong = 0;
     ++        unsafe {
     ++            if libgit_configset_get_ulong(self.0, key.as_ptr(), &mut val as *mut c_ulong) != 0 {
     ++                return None;
     ++            }
     ++        }
     ++        Some(val as u64)
     ++    }
     ++
     ++    /// Load the value for the given key and attempt to parse it as a file path. Dies with a fatal error
     ++    /// if the value cannot be converted to a PathBuf. Returns None if the key is not present.
     ++    pub fn get_pathname(&mut self, key: &str) -> Option<PathBuf> {
     ++        let key = CString::new(key).expect("config key should be valid CString");
      +        let mut val: *mut c_char = std::ptr::null_mut();
      +        unsafe {
     -+            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
     ++            if libgit_configset_get_pathname(self.0, key.as_ptr(), &mut val as *mut *mut c_char)
     ++                != 0
      +            {
      +                return None;
      +            }
      +            let borrowed_str = CStr::from_ptr(val);
     -+            let owned_str =
     -+                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
     ++            let owned_str = String::from(
     ++                borrowed_str
     ++                    .to_str()
     ++                    .expect("config path should be valid UTF-8"),
     ++            );
      +            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
     -+            match owned_str.to_lowercase().as_str() {
     -+                "true" | "yes" | "on" | "1" => Some(true),
     -+                "false" | "no" | "off" | "0" => Some(false),
     -+                _ => None,
     -+            }
     ++            Some(PathBuf::from(owned_str))
      +        }
      +    }
       }
       
       impl Default for ConfigSet {
      @@ contrib/libgit-rs/src/config.rs: mod tests {
     -         assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
     -         // ConfigSet returns None for missing key
     -         assert_eq!(cs.get_string("foo.bar"), None);
     -+        // Test boolean parsing
     -+        assert_eq!(cs.get_bool("test.booleanValue"), Some(true));
     -+        // Test missing boolean key
     -+        assert_eq!(cs.get_bool("missing.boolean"), None);
     +         assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
     +         // Test missing boolean key
     +         assert_eq!(cs.get_bool("missing.boolean"), None);
     ++        // Test ulong parsing
     ++        assert_eq!(cs.get_ulong("test.ulongSmall"), Some(42));
     ++        assert_eq!(cs.get_ulong("test.ulongBig"), Some(4294967296)); // > 32-bit int
     ++        assert_eq!(cs.get_ulong("missing.ulong"), None);
     ++        // Test pathname parsing
     ++        assert_eq!(
     ++            cs.get_pathname("test.pathRelative"),
     ++            Some(PathBuf::from("./some/path"))
     ++        );
     ++        assert_eq!(
     ++            cs.get_pathname("test.pathAbsolute"),
     ++            Some(PathBuf::from("/usr/bin/git"))
     ++        );
     ++        assert_eq!(cs.get_pathname("missing.path"), None);
           }
       }
      
     - ## contrib/libgit-rs/testdata/config3 ##
     + ## contrib/libgit-rs/testdata/config4 ##
     +@@
     + 	boolZero = 0
     + 	boolZeroZero = 00
     + 	boolHundred = 100
     ++	ulongSmall = 42
     ++	ulongBig = 4294967296
     ++	pathRelative = ./some/path
     ++	pathAbsolute = /usr/bin/git
     +
     + ## contrib/libgit-sys/src/lib.rs ##
      @@
     - [trace2]
     - 	eventNesting = 3
     -+[test]
     -+	booleanValue = true
     + use std::ffi::c_void;
     + 
     + #[cfg(has_std__ffi__c_char)]
     +-use std::ffi::{c_char, c_int};
     ++use std::ffi::{c_char, c_int, c_ulong};
     + 
     + #[cfg(not(has_std__ffi__c_char))]
     + #[allow(non_camel_case_types)]
     +@@ contrib/libgit-sys/src/lib.rs: pub type c_char = i8;
     + #[allow(non_camel_case_types)]
     + pub type c_int = i32;
     + 
     ++#[cfg(not(has_std__ffi__c_char))]
     ++#[allow(non_camel_case_types)]
     ++pub type c_ulong = u64;
     ++
     + extern crate libz_sys;
     + 
     + #[allow(non_camel_case_types)]
     +@@ contrib/libgit-sys/src/lib.rs: extern "C" {
     +         dest: *mut c_int,
     +     ) -> c_int;
     + 
     ++    pub fn libgit_configset_get_ulong(
     ++        cs: *mut libgit_config_set,
     ++        key: *const c_char,
     ++        dest: *mut c_ulong,
     ++    ) -> c_int;
     ++
     ++    pub fn libgit_configset_get_pathname(
     ++        cs: *mut libgit_config_set,
     ++        key: *const c_char,
     ++        dest: *mut *mut c_char,
     ++    ) -> c_int;
     ++
     + }
     + 
     + #[cfg(test)]

-- 
gitgitgadget
