Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E023183C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776394; cv=none; b=fpbQELVCBJfCHBQEy7quZZ8oYCvitOL4Dxk18uOhH3PtLv60VJePkJeoPbEwS+YpJPrEz0PsRKvDxX9ahsEtaLdXkroGoyvNUPSPgd1gYKAF5aast9Nm5fFYwueuz3oIoYPB6wmUqDHjF9CfaISqEMCev4/wIzUnQJdks1C3SD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776394; c=relaxed/simple;
	bh=YZN8QViHGfxU16xvatzPb7dgj5dPgWtCuD9cIJIwi7s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b0FInodhWf7SXaYq3UuLUpcSeScFsLnKCtEHS/zw5Qtuf1Ty92zmHtRYlYTnyKkgVFoB8+ROVOg6gNyYdh+JJCM1+binCwaJjw3D+tPEJkEc1NmoKy7dRHpqAeUtdmad+rzPDFmz6IRtUYnUX5k3NEFvSvbe29Ph7vFr6HTmJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki9nixzN; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki9nixzN"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430da72d67bso7345015ab.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776391; x=1762381191; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5xfO80/xG0NnY+boW3WKJkET5VB8eDN2ZPxO/KNzkg=;
        b=ki9nixzNZAMG/FVdJM1xenmADkAMb8uEOmqmPMqZcxZS9dmfqotu8OZgFWi678taSb
         XoqqTqFnGenpvg3B767wSJQ8b+dySM8Zu8nckL6Z6wIAE+qPSQPFlHM1ogbaZOHE8z82
         l1XBbVel9+/0Srn2IhFW1hC5vByfbwkGE5+Eo1Y29syTqqIdVOVaRAUtD8CLqhvX6DsH
         TjXilAwKW1svg4sHu0McE774PBO8RknWEx94cShtismCtt6UZdh16awXb4JPZtFerswq
         H/3v04MLBNMLB+xwtiowHFqCdTYVEg3BE2rAcw2ZAl0g/uEFD8kdyZBMvGrui03qwx1P
         RUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776391; x=1762381191;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5xfO80/xG0NnY+boW3WKJkET5VB8eDN2ZPxO/KNzkg=;
        b=FIfGjHF3QYOfhwiLp7vhEKLUbBULa2dEsasQFZfx2UosobUWBt7+H5P9GB5J+3qbVv
         teO7omyqJjT/YCK9qHIh04k8H7V6UG1BJ0S0x2gtnSoDhQSnFeW6F7X0ynjzg0cv0S1J
         gK8/6uR7wSZxeAVyrRG0QV2m13MCyaBGAlhUj0ILMKg9VOOXOre8fuAXgUsfJv/8mZpe
         P7q0MGlu9tX+0CQIxxUigCx/GtLNJJ/SK/pr8ihvrbCzw6tqoL2AtFWcpedzgeMw0xOH
         ThwyQpF+TwaqvE9dTsG+w9852fbmbRe8XbU/5cODM/GyPXI+pkJNJcDfyeBiWZJ7x4St
         OAGw==
X-Gm-Message-State: AOJu0YwLn+sWkuN4fvTnAJSOkwnXR/k9kyBHWeituDLSpKLy/4Wz7sHB
	DDMZq0X/4FO2skIVZ9ecZop9Jg/di6aGhgRg9mqoRObOsZFHJtuZ9U8tGrqwkA==
X-Gm-Gg: ASbGnctIT7BCv2LtQF3t1v8/lwOv/n1SK77CxoA8Lx2QV6Jb8pjztNW3bigPPTS26qt
	+EiUA2IOtpzFh2qM4L79w3cnfrvgMBo/XPbK8+jXvcOKdQdxf1tz0aVVbN8suBcGfL/zXsNNn1k
	HX4U6JrHbOrMOsLNmXPX6KKIytIc3JeWyx+Cz3OYb+591el0ROb7QOkWonCYQ1JekYbSxDzbd3k
	ea4DjXlPmCoAqTYUfDnnyi0frpxxRnWcLOEtDsNu4UW9ljvQA90rgrclm6ew2eZPaRdfd5AreDt
	Wt2iUIwUuXsHksVeV3yqQ7vIS5GOWJBNJ5GB+dAwCI+CcFK3qkz8LEITyHySyVBOw+4R+x2YFn3
	pm4TiEZ8/+b+PR2N3XTe3N9eb96KGrQe3qLDwbcsmRswYtjBRZE7UXmAWvf9ZRk+1fganrMtfZu
	LJOAKk4hbESAMk
X-Google-Smtp-Source: AGHT+IG3gw0e4Qr3KM5RPOsbY8IoYMNQhf0Ly4oa/V3GW+Pin0NVMtne0EQN4PLNM6J6QNgKTEQ55w==
X-Received: by 2002:a05:6e02:19cc:b0:432:fbe2:3610 with SMTP id e9e14a558f8ab-433011d71f6mr17878695ab.2.1761776391285;
        Wed, 29 Oct 2025 15:19:51 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea73dbe1bsm5954269173.9.2025.10.29.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:50 -0700 (PDT)
Message-Id: <88133848d1a317f8a95c19ee5482b828a3f8705f.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:39 +0000
Subject: [PATCH v2 01/10] doc: define unambiguous type mappings across C and
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Document other nuances with crossing the FFI boundary. Other language
mappings may be added in the future.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .../technical/unambiguous-types.adoc          | 229 ++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 Documentation/technical/unambiguous-types.adoc

diff --git a/Documentation/technical/unambiguous-types.adoc b/Documentation/technical/unambiguous-types.adoc
new file mode 100644
index 0000000000..658a5b578e
--- /dev/null
+++ b/Documentation/technical/unambiguous-types.adoc
@@ -0,0 +1,229 @@
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
+| ptrdiff_t^4^  | isize
+|===
+
+== Character types
+
+This is where C and Rust don't have a clean one-to-one mapping. A C `char` is
+an 8-bit type that is signless (neither signed nor unsigned) which causes
+problems with e.g. `make DEVELOPER=1`. Rust's `char` type is an unsigned 32-bit
+integer that is used to describe Unicode code points. Even though a C `char`
+is the same width as `u8`, `char` should be converted to u8 where it is
+describing bytes in memory. If a C `char` is not describing bytes, then it
+should be converted to a more accurate unambiguous type.
+
+While you could specify `char` in the C code and `u8` in Rust code, it's not as
+clear what the appropriate type is, but it would work across the FFI boundary.
+However the bigger problem comes from code generation tools like cbindgen and
+bindgen. When cbindgen see u8 in Rust it will generate uint8_t on the C side
+which will cause differ in signedness warnings/errors. Similaraly if bindgen
+see `char` on the C side it will generate `std::ffi::c_char` which has its own
+problems.
+
+=== Notes
+^1^ This is only true if stdbool.h (or equivalent) is used. +
+^2^ C does not enforce IEEE-754 compatibility, but Rust expects it. If the
+platform/arch for C does not follow IEEE-754 then this equivalence does not
+hold. Also, it's assumed that `float` is 32 bits and `double` is 64, but
+there may be a strange platform/arch where even this isn't true. +
+^3^ C also defines uintptr_t, but this should not be used in Git. +
+^4^ C also defines ssize_t and intptr_t, but these should not be used in Git. +
+
+== Problems with std::ffi::c_* types in Rust
+TL;DR: They're not guaranteed to match C types for all possible C
+compilers/platforms/architectures.
+
+Only a few of Rust's C FFI types are considered safe and semantically clear to
+use: +
+
+* `c_void`
+* `CStr`
+* `CString`
+
+Even then, they should be used sparingly, and only where the semantics match
+exactly.
+
+The std::os::raw::c_* (which is deprecated) directly inherits the problems of
+core::ffi, which changes over time and seems to make a best guess at the
+correct definition for a given platform/target. This probably isn't a problem
+for all platforms that Rust supports currently, but can anyone say that Rust
+got it right for all C compilers of all platforms/targets?
+
+On top of all of that we're targeting an older version of Rust which doesn't
+have the latest mappings.
+
+To give an example: c_long is defined in
+footnote:[https://doc.rust-lang.org/1.63.0/src/core/ffi/mod.rs.html#175-189[c_long in 1.63.0]]
+footnote:[https://doc.rust-lang.org/1.89.0/src/core/ffi/primitives.rs.html#135-151[c_long in 1.89.0]]
+
+=== Rust version 1.63.0
+
+[source]
+----
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
+----
+
+=== Rust version 1.89.0
+
+[source]
+----
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
+----
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
+[source]
+----
+let mut x: std::ffi::c_char = 0;
+x -= 1;
+----
+
+=== Inconsistent shift behavior
+
+`x` will be 0xC0 for platforms that use i8, but will be 0x40 where it's u8.
+
+[source]
+----
+let mut x: std::ffi::c_char = 0x80;
+x >>= 1;
+----
+
+=== Equality fails to compile on some platforms
+
+The following will not compile on platforms that define c_char as i8, but will
+if it's u8. You can cast x e.g. `assert_eq!(x as u8, b'a');`, but then you get
+a warning on platforms that use u8 and a clean compilation where i8 is used.
+
+[source]
+----
+let mut x: std::ffi::c_char = 0x61;
+assert_eq!(x, b'a');
+----
+
+== Enum types
+Rust enum types should not be used as FFI types. Rust enum types are more like
+C union types than C enum's. For something like:
+
+[source]
+----
+#[repr(C, u8)]
+enum Fruit {
+    Apple,
+    Banana,
+    Cherry,
+}
+----
+
+It's easy enough to make sure the Rust enum matches what C would expect, but a
+more complex type like.
+
+[source]
+----
+enum HashResult {
+    SHA1([u8; 20]),
+    SHA256([u8; 32]),
+}
+----
+
+The Rust compiler has to add a discriminant to the enum to distinguish between
+the variants. The width, location, and values for that discriminant is up to
+the Rust compiler and is not ABI stable.
-- 
gitgitgadget

