Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46BD2D0C78
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505267; cv=none; b=OgdixQFDPurUan4kfdgud+I7G+ispMDaEu+hbvQ5pAZsPk0C3r+bcx+j2bq7X4EXsK2bzLggI95DlPJMCFcCcv8B3/bdx2k3joCJkdKioVCpbqo8WgIPmVO8gEoFBuozt5S0I4yd/XHlieEi/OqPwzxKMYWkwUs8Gr4kuo6o+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505267; c=relaxed/simple;
	bh=Ic8QymN6DzwFJkW0auJvrQfYLtsVGtP1UTYFkrvZXbE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HtXzdtqua3yIvZ94qfH1LKggBILfLNFqmvt5X7HJg+6UqxMa61d/Zu5DtzORSQ0T3CJ7Z4hj2t0G93qHfzY+P1R/i975071QqT3/sZ8BC0J8ItSjhbxJhr0jcmiaWhhFEod0ma1ZSBE0LcBnly6TxZMcXknxvXhGFEwNjRaFme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeTWBkuk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeTWBkuk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so5092234a91.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505265; x=1764110065; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1dV4ZiSviLvgb8pU3V6EqWFSvYIWT92nASRkGeWaRs=;
        b=SeTWBkukMJmeH8kZcLu51e6dDj4JUAL6MbkX1okP40a7A5TvuehKNw0oC4BWMz8N5Q
         A2ChxDLh9CbkdUUvOI9izmQgQ17/iHR0s4OldUxng/je+KVHsuyDoRixx+j0UnE+EM+e
         DaFNx6KAYD27LfkG7uCmW/UcgItGoOTqF83a5NB+09vKWs8mTakxsYWF1/E5bXKSilU+
         L4ke2uuWmAq2/0xru9h97NhmdvwRKykmPFWTPQHtZk7xiOBn+ufBqlkjBlUEv/rBcvY1
         rGps/xOJPlVxwJHJZVn4TEl5RuIC6dfcacrdk9mkhrMOFKdTrgAxAEUEAJuQtRgHBrOJ
         6MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505265; x=1764110065;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D1dV4ZiSviLvgb8pU3V6EqWFSvYIWT92nASRkGeWaRs=;
        b=no6IRvhfOiCEn/28u0IRyqhe94ZxU+MuFfe69fCtmq3H0zN3qY4EslAkxK7RlfY7x5
         kioP6KSGT6Cg6ZcRGCqIOL4SJmcDkxK7d1mJfNafT2MvoPKgY5pcaev3jbGbv5cnTX6+
         xkYBAcMY9HPFHsEci3l/aceH5FkikzzbfY8fGuaZsGvvol+OAlPB/nVlm85Pn5RWQ4p6
         D/hzPjukniEH7uWC7arYA81eLjV6I8Iz4psyhD8GkDmWbU4K5sT0NFmMFROO1zyJaAfi
         C7oCrvFVP3v6pCVfKfs0sAG1VaDPpvgLCio/z5X+NlEfssnSYj7lZU3F8/w/Nt6x6TRr
         vWCA==
X-Gm-Message-State: AOJu0Yzbe53BD2gPxXP1bWPUJ+gQar2Fp5fddkQiecAMFPNpqywG/GSB
	uL+oxMynUBWu8Inu7ksKwFLRLAlbFIYfA9rdYgk+AuoZm+6g5D8rHIEfjSne0A==
X-Gm-Gg: ASbGncuUo5T/jbPrXBTxC8Eok8EjvZznp0arGD3lMxqqpLW6RtCqzggcrN9xuX0+/rH
	7n/QdYujTdfbk6LQZSMur6G7eACt/qns/iEkPMPrx2v56I3j7TGwD53HJ3JPjvZaUIXC3vZfm9t
	XuiLG1ZxXFpSiLrd4xWrL3o5Vn9hw+c2iQQMeC23T5CJkSqd2olbeeV/pvLLMiTS5ei+HqhLXMK
	N33Wih+DPnMxwYs78LTjVmJILtn6zHWj6QRov4euLIRDWC6lqxCp8B50THdvLG0yshhBsbCcVBp
	j3VxmiflIErQwGv5fhF2sWjH/G/wSdzLqiwBpY8HT50bAphnZ8CFCabMw59hx+M1DMrwtvcZbBt
	oMtCh6gfqE9/1DA/w0SYJKdvxBJDx/mFp6pRzOA6/F6AhJCczqTF/eppJ2Emiaqhg+oJgx/OuTg
	QfYIidqYcRHU6STSKs88NOxxt0UtDw1YZXKg==
X-Google-Smtp-Source: AGHT+IG8zZPmXX73sFUfrsWQW22BatygoYH+6UCAlIaI+WScJjQaLhp1IATnCqSwpXqunNQmc9ik2Q==
X-Received: by 2002:a17:90b:33c6:b0:340:d578:f298 with SMTP id 98e67ed59e1d1-343f9d90cadmr18362486a91.8.1763505264741;
        Tue, 18 Nov 2025 14:34:24 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bbfc8d6esm497575a91.1.2025.11.18.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:24 -0800 (PST)
Message-Id: <8b56bf117289ca3be25533a36da1ea0c178ccfca.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:13 +0000
Subject: [PATCH v5 01/10] doc: define unambiguous type mappings across C and
 Rust
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Document other nuances when crossing the FFI boundary. Other language
mappings may be added in the future.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 Documentation/technical/unambiguous-types.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 04e9e10b27..bc1adb2d9d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -142,6 +142,7 @@ TECH_DOCS += technical/shallow
 TECH_DOCS += technical/sparse-checkout
 TECH_DOCS += technical/sparse-index
 TECH_DOCS += technical/trivial-merge
+TECH_DOCS += technical/unambiguous-types
 TECH_DOCS += technical/unit-tests
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index be698ef22a..89a6e26821 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -32,6 +32,7 @@ articles = [
   'sparse-checkout.adoc',
   'sparse-index.adoc',
   'trivial-merge.adoc',
+  'unambiguous-types.adoc',
   'unit-tests.adoc',
 ]
 
diff --git a/Documentation/technical/unambiguous-types.adoc b/Documentation/technical/unambiguous-types.adoc
new file mode 100644
index 0000000000..9a4990847c
--- /dev/null
+++ b/Documentation/technical/unambiguous-types.adoc
@@ -0,0 +1,224 @@
+= Unambiguous types
+
+Most of these mappings are obvious, but there are some nuances and gotchas with
+Rust FFI (Foreign Function Interface).
+
+This document defines clear, one-to-one mappings between primitive types in C,
+Rust (and possible other languages in the future). Its purpose is to eliminate
+ambiguity in type widths, signedness, and binary representation across
+platforms and languages.
+
+For Git, the only header required to use these unambiguous types in C is
+`git-compat-util.h`.
+
+== Boolean types
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| bool^1^       | bool
+|===
+
+== Integer types
+
+In C, `<stdint.h>` (or an equivalent) must be included.
+
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| uint8_t    | u8
+| uint16_t   | u16
+| uint32_t   | u32
+| uint64_t   | u64
+
+| int8_t     | i8
+| int16_t    | i16
+| int32_t    | i32
+| int64_t    | i64
+|===
+
+== Floating-point types
+
+Rust requires IEEE-754 semantics.
+In C, that is typically true, but not guaranteed by the standard.
+
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| float^2^      | f32
+| double^2^     | f64
+|===
+
+== Size types
+
+These types represent pointer-sized integers and are typically defined in
+`<stddef.h>` or an equivalent header.
+
+Size types should be used any time pointer arithmetic is performed e.g.
+indexing an array, describing the number of elements in memory, etc...
+
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| size_t^3^     | usize
+| ptrdiff_t^3^  | isize
+|===
+
+== Character types
+
+This is where C and Rust don't have a clean one-to-one mapping.
+
+A C `char` and a Rust `u8` share the same bit width, so any C struct containing
+a `char` will have the same size as the corresponding Rust struct using `u8`.
+In that sense, such structs are safe to pass over the FFI boundary, because
+their fields will be laid out identically. However, beyond bit width, C `char`
+has additional semantics and platform-dependent behavior that can cause
+problems, as discussed below.
+
+The C language leaves the signedness of `char` implementation defined. Because
+our developer build enables -Wsign-compare, comparison of a value of `char`
+type with either signed or unsigned integers may trigger warnings from the
+compiler.
+
+Note: Rust's `char` type is an unsigned 32-bit integer that is used to describe
+Unicode code points.
+
+=== Notes
+^1^ This is only true if stdbool.h (or equivalent) is used. +
+^2^ C does not enforce IEEE-754 compatibility, but Rust expects it. If the
+platform/arch for C does not follow IEEE-754 then this equivalence does not
+hold. Also, it's assumed that `float` is 32 bits and `double` is 64, but
+there may be a strange platform/arch where even this isn't true. +
+^3^ C also defines uintptr_t, ssize_t and intptr_t, but these types are
+discouraged for FFI purposes. For functions like `read()` and `write()` ssize_t
+should be cast to a different, and unambiguous, type before being passed over
+the FFI boundary. +
+
+== Problems with std::ffi::c_* types in Rust
+TL;DR: In practice, Rust's `c_*` types aren't guaranteed to match C types for
+all possible C compilers, platforms, or architectures, because Rust only
+ensures correctness of C types on officially supported targets. These
+definitions have changed over time to match more targets which means that the
+c_* definitions will differ based on which Rust version Git chooses to use.
+
+Current list of safe, Rust side, FFI types in Git: +
+
+* `c_void`
+* `CStr`
+* `CString`
+
+Even then, they should be used sparingly, and only where the semantics match
+exactly.
+
+The std::os::raw::c_* directly inherits the problems of core::ffi, which
+changes over time and seems to make a best guess at the correct definition for
+a given platform/target. This probably isn't a problem for all other platforms
+that Rust supports currently, but can anyone say that Rust got it right for all
+C compilers of all platforms/targets?
+
+To give an example: c_long is defined in
+footnote:[https://doc.rust-lang.org/1.63.0/src/core/ffi/mod.rs.html#175-189[c_long in 1.63.0]]
+footnote:[https://doc.rust-lang.org/1.89.0/src/core/ffi/primitives.rs.html#135-151[c_long in 1.89.0]]
+
+=== Rust version 1.63.0
+
+```
+mod c_long_definition {
+    cfg_if! {
+        if #[cfg(all(target_pointer_width = "64", not(windows)))] {
+            pub type c_long = i64;
+            pub type NonZero_c_long = crate::num::NonZeroI64;
+            pub type c_ulong = u64;
+            pub type NonZero_c_ulong = crate::num::NonZeroU64;
+        } else {
+            // The minimal size of `long` in the C standard is 32 bits
+            pub type c_long = i32;
+            pub type NonZero_c_long = crate::num::NonZeroI32;
+            pub type c_ulong = u32;
+            pub type NonZero_c_ulong = crate::num::NonZeroU32;
+        }
+    }
+}
+```
+
+=== Rust version 1.89.0
+
+```
+mod c_long_definition {
+    crate::cfg_select! {
+        any(
+            all(target_pointer_width = "64", not(windows)),
+            // wasm32 Linux ABI uses 64-bit long
+            all(target_arch = "wasm32", target_os = "linux")
+        ) => {
+            pub(super) type c_long = i64;
+            pub(super) type c_ulong = u64;
+        }
+        _ => {
+            // The minimal size of `long` in the C standard is 32 bits
+            pub(super) type c_long = i32;
+            pub(super) type c_ulong = u32;
+        }
+    }
+}
+```
+
+Even for the cases where C types are correctly mapped to Rust types via
+std::ffi::c_* there are still problems. Let's take c_char for example. On some
+platforms it's u8 on others it's i8.
+
+=== Subtraction underflow in debug mode
+
+The following code will panic in debug on platforms that define c_char as u8,
+but won't if it's an i8.
+
+```
+let mut x: std::ffi::c_char = 0;
+x -= 1;
+```
+
+=== Inconsistent shift behavior
+
+`x` will be 0xC0 for platforms that use i8, but will be 0x40 where it's u8.
+
+```
+let mut x: std::ffi::c_char = 0x80;
+x >>= 1;
+```
+
+=== Equality fails to compile on some platforms
+
+The following will not compile on platforms that define c_char as i8, but will
+if it's u8. You can cast x e.g. `assert_eq!(x as u8, b'a');`, but then you get
+a warning on platforms that use u8 and a clean compilation where i8 is used.
+
+```
+let mut x: std::ffi::c_char = 0x61;
+assert_eq!(x, b'a');
+```
+
+== Enum types
+Rust enum types should not be used as FFI types. Rust enum types are more like
+C union types than C enum's. For something like:
+
+```
+#[repr(C, u8)]
+enum Fruit {
+    Apple,
+    Banana,
+    Cherry,
+}
+```
+
+It's easy enough to make sure the Rust enum matches what C would expect, but a
+more complex type like.
+
+```
+enum HashResult {
+    SHA1([u8; 20]),
+    SHA256([u8; 32]),
+}
+```
+
+The Rust compiler has to add a discriminant to the enum to distinguish between
+the variants. The width, location, and values for that discriminant is up to
+the Rust compiler and is not ABI stable.
-- 
gitgitgadget

