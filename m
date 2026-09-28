Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C74A64CE
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610697; cv=none; b=CEkuk0AZaWLjyfFgQWeIvBBgBD1MHpKtNKc4ntXSBNDp6Qb7lztKZJ+eA9LoO7DUqxh0nZHXKhXobvC1TzW5rapEa/XzmrPx3L7jEx7GtE9ZqiEX3ch9Eu/feEPD7GJIbO7wUvv76w+vcANh9Sa/U0I+2AdcR3nZeIIrv8rCC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610697; c=relaxed/simple;
	bh=zCdjiYZSqUKeSxFsvp2S7D/0i8Ro8uHLThSoxFjnIYU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ihBAI2AfJ6AewplY5NO+EPL/KNs76bA8B8kuwEuI3gWAub/0ZjFQMoKB5k9/I+Mag+qK3xdwT1muN7LBV/f52Uzhl2Qx3Y1fJauq7E+xdAsJCSm2jtXOz0mGHKtcoKf81vAU0nSjXGpswWVA/Tq4bucVnL3zctWXg/COeZHMxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXTWGClQ; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXTWGClQ"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso811040a91.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610695; x=1791215495; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n/tRvpOdUx/vzRG4PcHmRMxLyJNwO9QGmr9DQn4rAKM=;
        b=CXTWGClQI3bqe8y1YazpZ/nrc1nF3UhJy4pdAULjQwXui52LMZ7F7gZvkUFoj5UQIw
         OFeMneV34GLnMPw3kW5OvaLb+tkkmp5/qGZC89SV0j0hSa0GfQO9eKsZQMDMmmujn3mP
         RdO6uC9fzysRcFS2GMqYULnuYR1smgmDR6wGZ3/WW9C3u+Qwh47fJNQnyrM/klYrV4P0
         tZUJGjSdcdzObe9+NeAq50fR5Zn+7Qvq2KFUTzQGmEvViTy/0OsiBnDbi4LUgNRRzBpw
         /R1ImmcksWyZSV5Drx1xjVpU8vdJRNOpwUHixVq71DtkESqRgryoZfVtWSBy9zNDVU/B
         11vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610695; x=1791215495;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n/tRvpOdUx/vzRG4PcHmRMxLyJNwO9QGmr9DQn4rAKM=;
        b=MugV2m8SniB7MPWlDKtCbz3y0X2rLTsNEofhaOLMW00OSEYCiYBPmiNEcPt34dFobz
         nPoIV/l6rpH7stI0uaSk5xSPLe8tZUD73nfw3103WFMdGJpILqqoFWPMWAySwzJTtMYG
         8MG47HgEuaLkvjUeFL2tUYLveKgS/qr4fQjLXjqIbg/UgxlKRYaWowZ70P2/YGqwd1kO
         8vOrerO4a/lvc80IsVW5HGU6AJ7P0LT2IqakhDwmj9skSaHQ1poZ3drbCZ8SlQ/q6wgC
         XadQ3E5f9PUNgjNTz0P8qU8T1zJoIRNue5QhAAY0ACiO1aCQrQIbDj5xZr613IGbj/F2
         Gyzg==
X-Gm-Message-State: AFq9FYL9l2eu4cuNNnnryMLr2qJ0SfamdKoxBvoj/7yN3tFm26zCKnm5
	IlXDAWqHoFg9DL8+pIzaoEIDLr6bc93f1rulM8l8Zyrc04XwoCClq989r0WEbg7v
X-Gm-Gg: AYBFou1EaM58FNXxEH0ixqUQRBF3SBIGze3DgyOW5UTuMUhx7QGBpT5ou4ZhodGp2fk
	jCkUQ+qgU+ythjl7divPzjNsFseqBIjE9Ukttt3KbBg6XDzDp+TsPWAWyBzlZlAUHcnfk3GAbfy
	4dXIPjSozzk2dO2oSPwU3iEV/JwPSNvVZKb/HqxkMX7lhiabDYI4kPs9kX+pCPdPlOv18bK6zjF
	Oi1RK+pKQLHtqEiwwamhzCBACAe4/SSNgk3oJ+U/Xdqm5/95TwtU0mHAFZO+EOqqAd/0ARnZ73T
	SMosCaLdElf7xs2nImKJZCn+ozo4JWMuhyZspUfSGGKgcxXCMs02EJ97FwQ5b8hQR490Z6ecVg/
	TK8dZHV/+Mg/rL3ri4Mb94mms5990OdVqnVpIlQ4FtTfXJ3NjLb0JrPxuArXAx5e9g/zhIzNJKR
	NihwvBcuFFMrw32ZVxz9rj3pe4Yt6DayOFpasw6SHA+N9HASz7UZIdphR8OwlFn0lugt++WsBaS
	p0=
X-Received: by 2002:a17:90b:4c82:b0:39e:6c68:1552 with SMTP id 98e67ed59e1d1-3a09896ee0fmr9090853a91.26.1790610694428;
        Mon, 28 Sep 2026 08:51:34 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.102.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498726d63sm22077a91.17.2026.09.28.08.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:51:33 -0700 (PDT)
Message-Id: <b1f30a6a05673c4094d59fda80c695472850d671.1790610691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 15:51:28 +0000
Subject: [PATCH 1/4] libgitcore: add `sha1dc` as an optional feature
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The new Rust crate `sha1dc` (https://crates.io/crates/sha1dc) promises
not only type safety but also much better performance compared to the
collision-detecting SHA-1 library Git uses at the moment. This
performance comes mostly from a SIMD-centric design that relies on
features provided by many x86_64 and aarch64 CPUs.

Let's optionally use this crate, toggled by the build option
`DC_SHA1_RS`.

To avoid requiring a shim around the `sha1dc_rs_final()` function just
to call `die()` upon a detected collision, pass a pointer to that
function to Rust and let it call it directly. This is safe: `die()` is a
variadic function, but the Rust code calls it with a simple string
without any interpolation required.

In a pretty unscientific test on a moderately busy Windows Ryzen 7
machine (UCRT64 GCC 16.2), Rust-backed `git-index-pack.exe` using
`sha1dc` 0.1.3 was over three times faster than the C backend by median
wall time. Here are the results running five iterations of the `sha1dc`
C, Rust v0.1.2, and Rust v0.1.3 backends in randomized, balanced order
with `--verify --no-rev-index --threads=1 --object-format=sha1`:

SHA1DC backend	Median	Best of five
--------------	------	------------
C (default)	32.9s	32.1s
Rust 0.1.2	10.9s	10.4s
Rust 0.1.3	10.7s	10.5s

Version 0.1.3 finished first in four of five triplets, but its median
advantage over 0.1.2 was only about 2.4%, and the best 0.1.2 run was
faster. In other words, the difference is mostly in the noise.

On the same machine, using WSL ("Windows Subsystem for Linux") with the
same packfile copied to Linux' ext4 filesystem:

SHA1DC backend	Median	Best of five
--------------	------	------------
C (default)	23.971s	23.435s
Rust 0.1.2	9.123s	8.492s
Rust 0.1.3	9.020s	8.491s

This is overall faster because of the ext4 vs NTFS performance
characteristics, but the same finding holds true: the Rust version of
`sha1dc` is dramatically faster.

Studying the runs with the Linux perf tools reveals that with the C
backend, over 70% of the total time is spent in `git_hash_update()`,
with either version of the Rust backend it is around 30%.

A comparable test on an M4 Mac yields these results:

SHA1DC backend 	Median 	Best of five
-------------- 	------ 	------------
C (default) 	8.035s 	8.009s
Rust 0.1.2 	4.359s 	4.338s
Rust 0.1.3 	4.361s 	4.268s

Note that the `sha1dc` crate still requires a significantly newer Rust
version than Git's existing Rust support requires: 1.87 instead of
1.63 (https://crates.io/api/v1/crates/sha1dc/0.1.3).

Assisted-by: GPT-6 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Cargo.toml       |  4 +++
 Makefile         | 29 +++++++++++++++++++
 hash.h           |  5 ++++
 sha1dc_rs.h      | 23 ++++++++++++++++
 src/lib.rs       |  2 ++
 src/sha1dc_rs.rs | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 135 insertions(+)
 create mode 100644 sha1dc_rs.h
 create mode 100644 src/sha1dc_rs.rs

diff --git a/Cargo.toml b/Cargo.toml
index 2f51bf5d5f..0a953dd481 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -8,3 +8,7 @@ rust-version = "1.49.0"
 crate-type = ["staticlib"]
 
 [dependencies]
+sha1dc = { version = "0.1.3", optional = true }
+
+[features]
+sha1dc-rs = ["sha1dc"]
diff --git a/Makefile b/Makefile
index c649c93c51..0c321494cf 100644
--- a/Makefile
+++ b/Makefile
@@ -567,6 +567,9 @@ include shared.mak
 # by the git project to migrate to using sha1collisiondetection as a
 # submodule.
 #
+# Define DC_SHA1_RS to use the sha1dc Rust crate instead of the default
+# C implementation. This requires Rust 1.87 or newer.
+#
 # === SHA-256 backend ===
 #
 # ==== Security ====
@@ -2137,6 +2140,23 @@ ifdef PPC_SHA1
 $(error the PPC_SHA1 flag has been removed along with the PowerPC-specific SHA-1 implementation.)
 endif
 
+ifdef DC_SHA1_RS
+ifdef NO_RUST
+$(error DC_SHA1_RS requires Rust support)
+endif
+ifneq ($(strip $(OPENSSL_SHA1)$(BLK_SHA1)$(APPLE_COMMON_CRYPTO_SHA1)),)
+$(error DC_SHA1_RS cannot be combined with another SHA-1 backend)
+endif
+ifdef DC_SHA1_EXTERNAL
+$(error Only set DC_SHA1_RS or DC_SHA1_EXTERNAL, not both)
+endif
+ifdef DC_SHA1_SUBMODULE
+ifneq ($(DC_SHA1_SUBMODULE),auto)
+$(error Only set DC_SHA1_RS or DC_SHA1_SUBMODULE, not both)
+endif
+endif
+endif
+
 ifdef OPENSSL_SHA1
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA1_OPENSSL
@@ -2150,6 +2170,14 @@ ifdef APPLE_COMMON_CRYPTO_SHA1
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	BASIC_CFLAGS += -DSHA1_DC
+ifdef DC_SHA1_RS
+	BASIC_CFLAGS += -DDC_SHA1_RS
+	CARGO_ARGS += --features sha1dc-rs
+	RUST_SOURCES += src/sha1dc_rs.rs
+ifeq ($(uname_S),MINGW)
+	EXTLIBS += -luserenv
+endif
+else
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
         ifdef DC_SHA1_SUBMODULE
@@ -2177,6 +2205,7 @@ endif
 endif
 endif
 endif
+endif
 
 ifdef OPENSSL_SHA1_UNSAFE
 ifndef OPENSSL_SHA1
diff --git a/hash.h b/hash.h
index cf94ad5700..dd2e66e1c9 100644
--- a/hash.h
+++ b/hash.h
@@ -12,8 +12,13 @@
 #    include "sha1/openssl.h"
 #  endif
 #elif defined(SHA1_DC)
+#ifdef DC_SHA1_RS
+#define SHA1_BACKEND "SHA1_DC-rs"
+#include "sha1dc_rs.h"
+#else
 #define SHA1_BACKEND "SHA1_DC"
 #include "sha1dc_git.h"
+#endif
 #else /* SHA1_BLK */
 #define SHA1_BACKEND "SHA1_BLK (No collision detection)"
 #include "block-sha1/sha1.h"
diff --git a/sha1dc_rs.h b/sha1dc_rs.h
new file mode 100644
index 0000000000..35e3865d72
--- /dev/null
+++ b/sha1dc_rs.h
@@ -0,0 +1,23 @@
+#ifndef SHA1DC_RS_H
+#define SHA1DC_RS_H
+
+#define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
+
+typedef struct sha1dc_rs_hasher *SHA1_CTX;
+
+void sha1dc_rs_init(SHA1_CTX *);
+void sha1dc_rs_clone(SHA1_CTX *, const SHA1_CTX *);
+void sha1dc_rs_update(SHA1_CTX *, const void *, size_t);
+void sha1dc_rs_final(unsigned char [20], SHA1_CTX *,
+		     void (*die_fn)(const char *, ...));
+void sha1dc_rs_discard(SHA1_CTX *);
+
+#define platform_SHA_CTX SHA1_CTX
+#define platform_SHA1_Init sha1dc_rs_init
+#define platform_SHA1_Update sha1dc_rs_update
+#define platform_SHA1_Final(hash, ctx) sha1dc_rs_final((hash), (ctx), die)
+#define SHA1_NEEDS_CLONE_HELPER
+#define platform_SHA1_Clone sha1dc_rs_clone
+#define platform_SHA1_Discard sha1dc_rs_discard
+
+#endif
diff --git a/src/lib.rs b/src/lib.rs
index 0c598298b1..a34f4d489c 100644
--- a/src/lib.rs
+++ b/src/lib.rs
@@ -1,4 +1,6 @@
 pub mod csum_file;
 pub mod hash;
 pub mod loose;
+#[cfg(feature = "sha1dc-rs")]
+mod sha1dc_rs;
 pub mod varint;
diff --git a/src/sha1dc_rs.rs b/src/sha1dc_rs.rs
new file mode 100644
index 0000000000..df075a5d83
--- /dev/null
+++ b/src/sha1dc_rs.rs
@@ -0,0 +1,72 @@
+use sha1dc::Hasher;
+use std::ffi::CString;
+use std::os::raw::c_char;
+use std::{ptr, slice};
+
+/// Initialize a collision-detecting SHA-1 context.
+///
+/// # Safety
+/// `ctx` must point to an uninitialized SHA-1 context.
+#[no_mangle]
+pub unsafe extern "C" fn sha1dc_rs_init(ctx: *mut *mut Hasher) {
+    *ctx = Box::into_raw(Box::new(Hasher::new()));
+}
+
+/// Replace a SHA-1 context with a clone of another.
+///
+/// # Safety
+/// Both contexts must be initialized.
+#[no_mangle]
+pub unsafe extern "C" fn sha1dc_rs_clone(dst: *mut *mut Hasher, src: *const *mut Hasher) {
+    let hasher = Box::new((**src).clone());
+    drop(Box::from_raw(*dst));
+    *dst = Box::into_raw(hasher);
+}
+
+/// Update the SHA-1 hasher with the given bytes.
+///
+/// # Safety
+/// `ctx` must be initialized and `data` must point to `len` bytes unless
+/// `len` is zero.
+#[no_mangle]
+pub unsafe extern "C" fn sha1dc_rs_update(ctx: *mut *mut Hasher, data: *const c_char, len: usize) {
+    if len != 0 {
+        (**ctx).update(slice::from_raw_parts(data.cast::<u8>(), len));
+    }
+}
+
+/// Finalize SHA-1, reporting detected collisions through `die`.
+///
+/// # Safety
+/// `ctx` must be initialized, `hash` must point to at least 20 bytes, and
+/// `die` must be a non-returning C variadic function.
+#[no_mangle]
+pub unsafe extern "C" fn sha1dc_rs_final(
+    hash: *mut u8,
+    ctx: *mut *mut Hasher,
+    die: unsafe extern "C" fn(*const c_char, ...) -> !,
+) {
+    let hasher = *Box::from_raw(*ctx);
+    *ctx = ptr::null_mut();
+    match hasher.finalize() {
+        Ok(digest) => ptr::copy_nonoverlapping(digest.as_bytes().as_ptr(), hash, 20),
+        Err(collision) => {
+            let message = CString::new(format!(
+                "SHA-1 appears to be part of a collision attack: {}",
+                collision.digest()
+            ))
+            .expect("collision message contains no NUL");
+            die(message.as_ptr());
+        }
+    }
+}
+
+/// Discard a SHA-1 context without producing a digest.
+///
+/// # Safety
+/// `ctx` must be initialized.
+#[no_mangle]
+pub unsafe extern "C" fn sha1dc_rs_discard(ctx: *mut *mut Hasher) {
+    drop(Box::from_raw(*ctx));
+    *ctx = ptr::null_mut();
+}
-- 
gitgitgadget

