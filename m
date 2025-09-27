Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF832AD02
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931673; cv=none; b=XKrUo7ytt+nJ8DZl39DiW+GDmRLkg+u0PvVusMaVIYWtIfG8X4BKUUpQlzaEIgYwSGKgZMmJrq9tEs6bI0mWIYMOKBteMz/xP/BFqUz9mowjIDlVbv7zBWUqS7M8yOvynydelD4eUQTPEeoiNQBr4GjAobmAzv3hY8PcEHsoUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931673; c=relaxed/simple;
	bh=9wYr0jJHVxzd0YnKZgcPYPKzBmVdFoB3juYWjuQRv34=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Evk0+bLZPe+vnqGige7Htib4sK4Jjky095iFuJxypwvd39WdEhi4LVLs0pLQ3aeTfLnyucGVqQikJiLePoMQ2yb2yWzlsN65+0ULrXETTDfkGP85zZJk52C81zjQ/yMjjv+TR8pkMcsOFlLai5/lP1vU1QZMhWW4EIehMhKXKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg+9Xa23; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg+9Xa23"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-86302b5a933so84606285a.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758931670; x=1759536470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3sqfjx55ZiICZ9DzKoT4sGfJCLS493DtHBd7vD1b4M=;
        b=Pg+9Xa23DbDY2BSCSNAesnl6cQEZwOmW+rpAviiwhgbrBqL8aQewwafV3K3buKjh7b
         GR54oocxWz1JPD01+fpp7HDYfzEx9DMPiH8FhHTMrYdCLKVN4IafBkYDVanYEbRMQVOF
         v8830lfoIF8bTXcpSP3MWZgm3ZKc+KbfF3hLhj7ryD3Il7Bg3hroFKTjEmcY/jUyXC3D
         ju+GUGcs+FFfl6nlw4aXQhUbOFYa2f8zLRMseSt67kMGuhyvLJE7XlsOEBIw7QjD1Kij
         gAqJxUcOTXyJvnP2RlmRIkMuJ5sawDmu8QIuLbzjliCT/Vl+4Z+aV0Sa2mYPZFFSKh+d
         5eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931670; x=1759536470;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3sqfjx55ZiICZ9DzKoT4sGfJCLS493DtHBd7vD1b4M=;
        b=JDAbiY2a46vJ3UeOBAvem/djihrapRItK1P60TQGLrlmPBrbtGPtjAFTLnqZ+3z+/Z
         bfzRjlDGNALN02nm9h2/a5aPDxwCkMFgyEJoY+2HkO42TUDlAOoP9qHV/Hhik+4gHPWu
         Y7RFSqk6T4K3cSsqgxuvi9JgdrAIrZMXP2CglyP3h7GvY5Q1KYxUR4TV/IZb61yK0Yb3
         zdx7PTDWPvq8/eH5m1Z6Ax/t3nJktRY0EGr/ITNHG2Fo4xdGF5fd5Qu/Zz/qjwTRMgmV
         D0nqfaQbfWTre52HeiypkPENw3C5E7z2j8/mTFK+l64WK125EYkJWF2Q6lOJkrPFP4R7
         wKbA==
X-Gm-Message-State: AOJu0Yzj7M5Q57BA933+D4jZANxyP9iY460Qoq0jJL4nGtOG3pANiq5S
	u+Fr/ChahrS7mO0h0NsvDIpvzEHIv3bX9ZcNTBAItEIs3LvNwjKvWpzCMBjPHjgk
X-Gm-Gg: ASbGncsbcAR2C9vYov2rYKCoMhMBrEp2gfaGIj/x7l4uM9EMCow3Xj2xrPCGW/k15/Q
	RjbwRA/ymQKMe4vgVUdiXsIIAFd4cTw5TFOqVPLpySsCHT3hF25ZNJ3S8760Jql3b+Z2kbaR0oK
	rLEUZcslxZjA8TUSHM48x4Kn4pqjfAmQGsRBXn+pEWiPPlBwFJr9XbMygoFQilQN9gjpoxoMppb
	dskJRJggW/4jkIoqsG7GaG5gqEH6zk8y/BeNFK9pSKF0DZEpz2aUsBztnOBxOIa8R+I2NT0oZDW
	HklD6s60ps3vEcf/lW5y7wjDe0mCoChGPg2yidFyOStXtxJpAVfdSEPMDnfsvUtrU25jxA3KqiW
	nImcQ9guus377oeNl5YqyGUP+Mg==
X-Google-Smtp-Source: AGHT+IGv55gVDpCQI8BgsnZrUidL28WqC1G5fU3KVzr/0yU37wKJMFqRObRKxfzAOxQOspfzyg1V9w==
X-Received: by 2002:a05:620a:2988:b0:857:9a62:170b with SMTP id af79cd13be357-85ade9629a6mr1230504785a.3.1758931669786;
        Fri, 26 Sep 2025 17:07:49 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c3218f0b9sm365880485a.48.2025.09.26.17.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:07:48 -0700 (PDT)
Message-Id: <43784e3ff991929b5c314ad5b9ab6573e6ca48c4.1758931659.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
	<pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 00:07:39 +0000
Subject: [PATCH v2 3/3] libgit-rs: address review feedback for get_bool()
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

- Use git_configset_get_bool() C function instead of reimplementing parsing
- Fix libgit_configset_get_bool() function signature in bindings
- Improve .expect() error messages to be more descriptive
- Add comprehensive boolean tests including edge cases (00, 100, 007)

This addresses feedback from Phillip Wood and Chris Torek about using
Git's actual boolean parsing logic rather than duplicating it in Rust.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 contrib/libgit-rs/src/config.rs    | 33 ++++++++++++++++--------------
 contrib/libgit-rs/testdata/config3 |  4 +---
 contrib/libgit-rs/testdata/config4 | 10 +++++++++
 contrib/libgit-sys/src/lib.rs      |  6 ++++++
 4 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 contrib/libgit-rs/testdata/config4

diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
index 3f4a32c72d..b280b952b2 100644
--- a/contrib/libgit-rs/src/config.rs
+++ b/contrib/libgit-rs/src/config.rs
@@ -69,24 +69,18 @@ impl ConfigSet {
         }
     }
 
+    /// Load the value for the given key and attempt to parse it as a boolean. Dies with a fatal error
+    /// if the value cannot be parsed. Returns None if the key is not present.
     pub fn get_bool(&mut self, key: &str) -> Option<bool> {
-        let key = CString::new(key).expect("Couldn't convert key to CString");
-        let mut val: *mut c_char = std::ptr::null_mut();
+        let key = CString::new(key).expect("config key should be valid CString");
+        let mut val: c_int = 0;
         unsafe {
-            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
-            {
+            if libgit_configset_get_bool(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
                 return None;
             }
-            let borrowed_str = CStr::from_ptr(val);
-            let owned_str =
-                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
-            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
-            match owned_str.to_lowercase().as_str() {
-                "true" | "yes" | "on" | "1" => Some(true),
-                "false" | "no" | "off" | "0" => Some(false),
-                _ => None,
-            }
         }
+
+        Some(val != 0)
     }
 }
 
@@ -115,6 +109,7 @@ mod tests {
             Path::new("testdata/config1"),
             Path::new("testdata/config2"),
             Path::new("testdata/config3"),
+            Path::new("testdata/config4"),
         ]);
         // ConfigSet retrieves correct value
         assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
@@ -122,8 +117,16 @@ mod tests {
         assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
         // ConfigSet returns None for missing key
         assert_eq!(cs.get_string("foo.bar"), None);
-        // Test boolean parsing
-        assert_eq!(cs.get_bool("test.booleanValue"), Some(true));
+        // Test boolean parsing - comprehensive tests
+        assert_eq!(cs.get_bool("test.boolTrue"), Some(true));
+        assert_eq!(cs.get_bool("test.boolFalse"), Some(false));
+        assert_eq!(cs.get_bool("test.boolYes"), Some(true));
+        assert_eq!(cs.get_bool("test.boolNo"), Some(false));
+        assert_eq!(cs.get_bool("test.boolOne"), Some(true));
+        assert_eq!(cs.get_bool("test.boolZero"), Some(false));
+        assert_eq!(cs.get_bool("test.boolZeroZero"), Some(false)); // "00" → false
+        assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
+        assert_eq!(cs.get_bool("test.boolSeven"), Some(true)); // "007" → true
         // Test missing boolean key
         assert_eq!(cs.get_bool("missing.boolean"), None);
     }
diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
index 83a474ccef..3ea5b96f12 100644
--- a/contrib/libgit-rs/testdata/config3
+++ b/contrib/libgit-rs/testdata/config3
@@ -1,4 +1,2 @@
 [trace2]
-	eventNesting = 3
-[test]
-	booleanValue = true
+	eventNesting = 3
\ No newline at end of file
diff --git a/contrib/libgit-rs/testdata/config4 b/contrib/libgit-rs/testdata/config4
new file mode 100644
index 0000000000..5b75385c38
--- /dev/null
+++ b/contrib/libgit-rs/testdata/config4
@@ -0,0 +1,10 @@
+[test]
+	boolTrue = true
+	boolFalse = false
+	boolYes = yes
+	boolNo = no
+	boolOne = 1
+	boolZero = 0
+	boolZeroZero = 00
+	boolHundred = 100
+	boolSeven = 007
diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
index 4bfc650450..b104fda8f6 100644
--- a/contrib/libgit-sys/src/lib.rs
+++ b/contrib/libgit-sys/src/lib.rs
@@ -43,6 +43,12 @@ extern "C" {
         dest: *mut *mut c_char,
     ) -> c_int;
 
+    pub fn libgit_configset_get_bool(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut c_int,
+    ) -> c_int;
+
 }
 
 #[cfg(test)]
-- 
gitgitgadget
