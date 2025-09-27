Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB21F63D9
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758945121; cv=none; b=rv8g04nMsxmm+JvqPciYvyldojSmbVd/ENRMQXxAspVqKBZZTeRVfIM5Y3kOYjhvj8XM0N7SbQrSZ7CeXgIJc5RTxsFp23QS8n1w1rP1kLdSnfJAE8+8xXpl7bLmCEqIxDsHXWqJ8WuZpOGA4/VScru5BzJNQZHcDzR9dwltmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758945121; c=relaxed/simple;
	bh=KqwkCBMlwRQStJwX0RvnzBfEYM1oCh3I21hPzwUo5fY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bizKV9KwUBB4T16Zt/L90LFkM31h8auOzs5cO6IUn1RGXqBRpwQsxE7RAZQtgbD1bttbKkfMk7pR06jNgpp1eaMNh1duEH0edy3Wpx1GFI8mHhbZA5bxx8qfQRW05GMLOSYPDLtwqY5yuv+1PaCbIqdL8U3lwZBeFkhcm0Lb+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TskS3Wvs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TskS3Wvs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78104c8cbb4so2819169b3a.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 20:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758945118; x=1759549918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsdjWM1LNn7ZhgKrFx8sJwmKUeN7Md3H7khE5UL7elk=;
        b=TskS3WvsdEDdAwdG9ze4aBY6gbNdidIj37b3UurK5v1BkuT6fTUSM5rNygXtuVgS9w
         wE6cdOn4tAfp1ERNsheh7w8ea0jMFguNw0clf/syLZIRznC4ZYXCAIw0VDbHtd4s9pNh
         K7joJyvP6lUN4Z87w7kEy04rul4nIL1HERFebJdDE/3pJpHvJWfpRMWyPT4XYjmvIDYG
         UskCsvLkNbxNPjI6PvLCJA/VnVglGq1pcOxHnFxkDveDkJpI2Flku14nTdbzSK5x7c/K
         /KWU6rIt2Ac5SCWN7vio4vsO1DsrMk/1DYXdXiqP8N0Q1X8kZdUDtGP/SZ/oFtkLMeeN
         70fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758945118; x=1759549918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsdjWM1LNn7ZhgKrFx8sJwmKUeN7Md3H7khE5UL7elk=;
        b=B5iLu4sdVk/1vPDhIs7EdA6ImGsSc0VN/QS/I33x9kyWuH2rgeokRa9JgKRUsXEQdd
         S/3tFk6knKvB23gCEhBe1/USKNuFtCnuriAOL29skM070RWsW0pjkzmYpS1MHa6uuB3y
         ee4IGfw3CIe50Rpr3nBa/H67HZfvmzvL8KFMmo0BknFA4Srquni/JZfsH0Zg7uwie/5a
         ejl3L+Uy0Wrs1ioBP1pLlrVqQHXos3KV9EIaLDrE1dXFm+fV134LLbzKdEEVxxmKIYpw
         UisriJiWv3wG43YA4DHWHEliawiJuvzXWBl2ncT0/j6WlbF+9kh6pF9539DKd+owYvcQ
         qEFA==
X-Gm-Message-State: AOJu0YyhC/haq57ofFdM013jhoT6SJ0Q+lXfsWjWtttcy47jBjoAAry3
	O3PbkxGUwb+uekICi+IjxC16aPsbpw6V4jUL9dcjbCC0/zWnFdO8d7qquoR1p2iN
X-Gm-Gg: ASbGncvSAoZHWGinfvU6znYm+YTFVw6UhFHZu8LMs+DZBAREwq2cKSQVvQDX2G0DBt8
	izKRQ0ILzhvfcsrL7qDJRxrAV6JNgthJThIyZmhSNg7FvlfxamXrjC81J9FU4y48pukcCTvA8ak
	o1QjfK2kKYP2sunkRC3H2Oa6QoidVy+fLjRKTXPyZ0HmgWdlOlJ+c7Q3QoYxU9KsBqdKipga5By
	Bd1A43jrGCLWq4k98Z49i34Avu96ijGV1AiqLktIyQf0ESdvuWEfTFGjFptLnmp19eR1ZGqdlQN
	LJhk5m+sKlLT9Or8/PDjz/7Roee3vzN1ORi10uaoOE9hatVkLcC4vq5mhZ7tsurs6URnAVm0jeW
	tnveEGCGmZsdALBxgRCe01XE+nWZuFiuduxfF
X-Google-Smtp-Source: AGHT+IG5A0JCYF24aoy9EFAelnP7uinmKVDlnEApn48M/46+mYFknlfPXfaoA2bBVC7TYIvoLYcfMw==
X-Received: by 2002:a05:6a00:3906:b0:77f:40ce:9c4 with SMTP id d2e1a72fcca58-780fcf12f65mr12348828b3a.32.1758945118375;
        Fri, 26 Sep 2025 20:51:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.218.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c26d4sm5707559b3a.37.2025.09.26.20.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:51:57 -0700 (PDT)
Message-Id: <1ac8d768194b15eaf536000ed5f76f36dd0a39b2.1758945111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
References: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
	<pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 03:51:51 +0000
Subject: [PATCH v3 3/3] libgit-rs: add get_ulong() and get_pathname() methods
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
    ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Expand the ConfigSet API with additional configuration value types:

- get_ulong(): Parse unsigned long integers for large numeric values
- get_pathname(): Parse file paths, returning PathBuf for type safety

Both functions follow the same pattern as existing get_* methods,
using Git's C functions for consistent parsing behavior.

Add comprehensive tests covering normal cases, edge cases, and
error handling for all new functionality.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 contrib/libgit-rs/src/config.rs    | 57 ++++++++++++++++++++++++++++--
 contrib/libgit-rs/testdata/config4 |  4 +++
 contrib/libgit-sys/src/lib.rs      | 18 +++++++++-
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
index 72ee88801b..ffd9f311b6 100644
--- a/contrib/libgit-rs/src/config.rs
+++ b/contrib/libgit-rs/src/config.rs
@@ -1,8 +1,8 @@
 use std::ffi::{c_void, CStr, CString};
-use std::path::Path;
+use std::path::{Path, PathBuf};
 
 #[cfg(has_std__ffi__c_char)]
-use std::ffi::{c_char, c_int};
+use std::ffi::{c_char, c_int, c_ulong};
 
 #[cfg(not(has_std__ffi__c_char))]
 #[allow(non_camel_case_types)]
@@ -12,6 +12,10 @@ type c_char = i8;
 #[allow(non_camel_case_types)]
 type c_int = i32;
 
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+type c_ulong = u64;
+
 use libgit_sys::*;
 
 /// A ConfigSet is an in-memory cache for config-like files such as `.gitmodules` or `.gitconfig`.
@@ -82,6 +86,41 @@ impl ConfigSet {
 
         Some(val != 0)
     }
+
+    /// Load the value for the given key and attempt to parse it as an unsigned long. Dies with a fatal error
+    /// if the value cannot be parsed. Returns None if the key is not present.
+    pub fn get_ulong(&mut self, key: &str) -> Option<u64> {
+        let key = CString::new(key).expect("config key should be valid CString");
+        let mut val: c_ulong = 0;
+        unsafe {
+            if libgit_configset_get_ulong(self.0, key.as_ptr(), &mut val as *mut c_ulong) != 0 {
+                return None;
+            }
+        }
+        Some(val as u64)
+    }
+
+    /// Load the value for the given key and attempt to parse it as a file path. Dies with a fatal error
+    /// if the value cannot be converted to a PathBuf. Returns None if the key is not present.
+    pub fn get_pathname(&mut self, key: &str) -> Option<PathBuf> {
+        let key = CString::new(key).expect("config key should be valid CString");
+        let mut val: *mut c_char = std::ptr::null_mut();
+        unsafe {
+            if libgit_configset_get_pathname(self.0, key.as_ptr(), &mut val as *mut *mut c_char)
+                != 0
+            {
+                return None;
+            }
+            let borrowed_str = CStr::from_ptr(val);
+            let owned_str = String::from(
+                borrowed_str
+                    .to_str()
+                    .expect("config path should be valid UTF-8"),
+            );
+            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
+            Some(PathBuf::from(owned_str))
+        }
+    }
 }
 
 impl Default for ConfigSet {
@@ -128,5 +167,19 @@ mod tests {
         assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
         // Test missing boolean key
         assert_eq!(cs.get_bool("missing.boolean"), None);
+        // Test ulong parsing
+        assert_eq!(cs.get_ulong("test.ulongSmall"), Some(42));
+        assert_eq!(cs.get_ulong("test.ulongBig"), Some(4294967296)); // > 32-bit int
+        assert_eq!(cs.get_ulong("missing.ulong"), None);
+        // Test pathname parsing
+        assert_eq!(
+            cs.get_pathname("test.pathRelative"),
+            Some(PathBuf::from("./some/path"))
+        );
+        assert_eq!(
+            cs.get_pathname("test.pathAbsolute"),
+            Some(PathBuf::from("/usr/bin/git"))
+        );
+        assert_eq!(cs.get_pathname("missing.path"), None);
     }
 }
diff --git a/contrib/libgit-rs/testdata/config4 b/contrib/libgit-rs/testdata/config4
index c0755a32be..bd621ab480 100644
--- a/contrib/libgit-rs/testdata/config4
+++ b/contrib/libgit-rs/testdata/config4
@@ -7,3 +7,7 @@
 	boolZero = 0
 	boolZeroZero = 00
 	boolHundred = 100
+	ulongSmall = 42
+	ulongBig = 4294967296
+	pathRelative = ./some/path
+	pathAbsolute = /usr/bin/git
diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
index b104fda8f6..07386572ec 100644
--- a/contrib/libgit-sys/src/lib.rs
+++ b/contrib/libgit-sys/src/lib.rs
@@ -1,7 +1,7 @@
 use std::ffi::c_void;
 
 #[cfg(has_std__ffi__c_char)]
-use std::ffi::{c_char, c_int};
+use std::ffi::{c_char, c_int, c_ulong};
 
 #[cfg(not(has_std__ffi__c_char))]
 #[allow(non_camel_case_types)]
@@ -11,6 +11,10 @@ pub type c_char = i8;
 #[allow(non_camel_case_types)]
 pub type c_int = i32;
 
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+pub type c_ulong = u64;
+
 extern crate libz_sys;
 
 #[allow(non_camel_case_types)]
@@ -49,6 +53,18 @@ extern "C" {
         dest: *mut c_int,
     ) -> c_int;
 
+    pub fn libgit_configset_get_ulong(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut c_ulong,
+    ) -> c_int;
+
+    pub fn libgit_configset_get_pathname(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut *mut c_char,
+    ) -> c_int;
+
 }
 
 #[cfg(test)]
-- 
gitgitgadget
