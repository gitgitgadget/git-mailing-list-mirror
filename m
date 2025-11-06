Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACD27FB0E
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422939; cv=none; b=EBpcNWR6IcfE57LBU+RF4FHBmJqAbaiKu2ANKFZnjEQGlcg30RJtXju9XauObErHWhcRaTw6iG1/8/e3v8Uo+LNgF3SOwrUzdCFofqiQWJfYViDf4aXYk/tJ5d/Mf0hg2geX3hdh/2wXyo27Ya9kkyGoiIVpTxZPTxnY3NeNm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422939; c=relaxed/simple;
	bh=tIucWvr019OYjQVnCxjSQtO/W5cP807WeKggFYLF8fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPg0XvaXRAnFyAU6THsGmD5+O6i9qAAerUyt1NqfYQk2SS3JUozMXA8ltOmQKm6Z15YTQJ4lv5y6s1qJDDWjd31VHbzsA7RqhJIV9kvHFQ8dX8FtHvPQWlZqpcGL8odDHZAktl2wOtgQ0l3tr10klgLW2rcGygBTBhbL4ZicKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJbjpW83; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJbjpW83"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563bcbbcso3616105e9.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422935; x=1763027735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy52WU0m+ibHSit7XawZKUg3deCSYVbNSQ3c2mEnKmA=;
        b=BJbjpW83wVaptuV0wo5OPPSqUqPrufbCBm/9R2qvV6pECHVMFSwCTsBcpdpCOnyPKo
         7JvlCO3IL1/yNwGS4x6mhApkWx76YXkAINO16DQ4nXU5tF3Sr2Nldbom0pBXkVcTpUdE
         f7Knh30o39Z4pRnq+zg7rUmId8TIdLpx1X+tSx256Mp9fp3zIOmdDcvV/1lmTkd6uiaV
         qhOpgDP1v9bwCdYTe9SmHeyjRHtBMI6OK3Mhs+B3XhApsw0/KakfPjM1fHeK2mze3Z9Y
         xTh2869iW0iJRd2d7XSxVyJH9aCCeNMQkuR6i2q/UpcQ39yxlxzJ/5nfUYE5IS5MpBHR
         JExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422935; x=1763027735;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xy52WU0m+ibHSit7XawZKUg3deCSYVbNSQ3c2mEnKmA=;
        b=jYhRIgkfeG6z0tLO237R1BjQV1alpxjMMP0KZMJDaX/i2DMLPI7gAWS3lw660tCHXd
         xQxACTuI7RSRcnMdfg3d1oG4+Ibc/LdBKgfeul5w9AagUq2kJY3Q0wG8h/Xy0xD87sNv
         WuvTa5lkR1uWDM/CESIlXifEvY+QmZ6vSwbY+ZU0m8YkvOeTmhex8DZW0c1ngl84HAvc
         JH8ZmcrsemTcLJiY1YIQ70g84+XFQc2ftFl02uSt+j9GD2+/CMpmPLSd5yrXrloiZeQf
         1ZR2yFSXKjfAoa5hBVV14L+XTS4MOipNlPLACSDNj3bFoRihPqYBZx5q6hBZKiAxF/pH
         33Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUvxTv4dh3m6Xy3gig7iySvuYL46F08mqIZXXXTlWhppVH9B1V8ue2jng7u1XlYelI8mto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnfoRTxBK9fE/YiKlFRCopNlYfaSe2OvxSmRDUAXU/jbz6xuf
	MTYKklg03qhKH/TGR8fwQghA3WWxC8UNAyxwD0vkJh9SMMkxKfjdig+uO305/g==
X-Gm-Gg: ASbGnctqmEDlxZGdY87AZtrixxEroThjVMSbwksq9GEcZhBibY0NycLsseBQVH89b0P
	79ExMTijQ4dDmh4z5jCy4xdIw0/33nbpYkWVYFFHEugIv+FvkJBkEWMqQOdpbq5gzoQ4/fhyfZN
	uPLCkWHBbCv84YQzZOMNRer4qipYxB4zKznTC6kIoEAbFROJsRYpzEZRZNH13j3Lsd8W8yh+P6h
	VQ83hvSHUqyG6iaPicJ+a2Dg+oAl1svqmziFrgfc4QB7sPHxzHQtOwxXL6s/Z7bzLI6fa+0/4tb
	RI/9jkfCB5kuiOdSxQruptyt0C0HylmhvhUSwtHzGoYzo0sVk1eEzRWMHWhZfkFB2JH1bhH0GRe
	7OhjLeHWo2z98iPl//Vb5lcJB8tU8y8zosoNIgQV2445R8WFSyDxHWh5BpGYhX77Qasl93fTfDZ
	e4H16tqkewMX9eNcjoOZevviMxy4g2CgXUhI63CWXDCsUDoDUJ+XyHCmdKJQ0VXeOFKg==
X-Google-Smtp-Source: AGHT+IH9PoIkrftzfNsjkToE3jn6MoyefFd5DX4l6MN0WRTWvFKpNWO4m07xwk8jQDraCritnRRPKg==
X-Received: by 2002:a05:600c:450b:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-4775cdad63cmr55185845e9.4.1762422935077;
        Thu, 06 Nov 2025 01:55:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:7b5:6701:5a25:209b:be41:f23f? ([2a0a:ef40:7b5:6701:5a25:209b:be41:f23f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763da0242sm12224685e9.0.2025.11.06.01.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:55:34 -0800 (PST)
Message-ID: <995f77a3-b94c-46df-87d3-22c7b2a3c762@gmail.com>
Date: Thu, 6 Nov 2025 09:55:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/10] doc: define unambiguous type mappings across C
 and Rust
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <88133848d1a317f8a95c19ee5482b828a3f8705f.1761776388.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <88133848d1a317f8a95c19ee5482b828a3f8705f.1761776388.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Document other nuances with crossing the FFI boundary. Other language
> mappings may be added in the future.

Thanks for adding this, I've left a few comments below. Overall I 
thought it was very well written. I tried building an html version of 
this but even after adding it to the list of TECH_DOCS in 
Documentation/Makefile with

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 47208269a2e..2699f0b24af 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -143,6 +143,7 @@ TECH_DOCS += technical/shallow
  TECH_DOCS += technical/sparse-checkout
  TECH_DOCS += technical/sparse-index
  TECH_DOCS += technical/trivial-merge
+TECH_DOCS += technical/unambiguous-types
  TECH_DOCS += technical/unit-tests
  SP_ARTICLES += $(TECH_DOCS)
  SP_ARTICLES += technical/api-index

it fails with

$ make -C Documentation/ technical/unambiguous-types.html 
                                       Merge branch 
'ps/object-source-loose' into seen
make: Entering directory '/home/phil/src/git/Documentation'
     GEN asciidoc.conf
     * new asciidoc flags
     ASCIIDOC technical/unambiguous-types.html
asciidoc: ERROR: unambiguous-types.adoc: line 139: undefined filter 
attribute in command: source-highlight --gen-version -f xhtml -s 
{language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}} 
{args=}
asciidoc: ERROR: unambiguous-types.adoc: line 162: undefined filter 
attribute in command: source-highlight --gen-version -f xhtml -s 
{language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}} 
{args=}
asciidoc: ERROR: unambiguous-types.adoc: line 177: undefined filter 
attribute in command: source-highlight --gen-version -f xhtml -s 
{language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}} 
{args=}
asciidoc: ERROR: unambiguous-types.adoc: line 187: undefined filter 
attribute in command: source-highlight --gen-version -f xhtml -s 
{language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}} 
{args=}
asciidoc: ERROR: unambiguous-types.adoc: line 199: undefined filter 
attribute in command: source-highlight --gen-version -f xhtml -s 
{language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}} 
{args=}
asciidoc: ERROR: unambiguous-types.adoc: line 213: undefined filter 
attribute in command: source-highlight --gen-version -f xhtml -s 
{language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}} 
{args=}
asciidoc: ERROR: unambiguous-types.adoc: line 224: undefined filter 
attribute in command: source-highlight --gen-version -f xhtml -s 
{language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}} 
{args=}
make: *** [Makefile:396: technical/unambiguous-types.html] Error 1
make: *** Deleting file 'technical/unambiguous-types.html'
make: Leaving directory '/home/phil/src/git/Documentation'

> +== Character types
> +
> +This is where C and Rust don't have a clean one-to-one mapping. A C `char` is
> +an 8-bit type that is signless (neither signed nor unsigned) 

I found this a bit confusing. Isn't the signedness of "char" 
implementation defined rather than it being "signless"

> which causes
> +problems with e.g. `make DEVELOPER=1`.

I'm not sure what this is referring to - maybe -Wsign-compare?

> Rust's `char` type is an unsigned 32-bit
> +integer that is used to describe Unicode code points. Even though a C `char`
> +is the same width as `u8`, `char` should be converted to u8 where it is
> +describing bytes in memory. 

I'm dreading the point where we start sharing "struct strbuf" with rust 
and have to change the "buf" member from "char*" to "uint8_t*". While it 
is not used in the xdiff code it is ubiquitous everywhere else and there 
are lots of places where be pass the "buf" member to functions expecting 
a "char*".

	git grep -E '(\.|->)buf\W'

has over 4000 matches

> If a C `char` is not describing bytes, then it
> +should be converted to a more accurate unambiguous type.

That's a good point.

> +While you could specify `char` in the C code and `u8` in Rust code, it's not as
> +clear what the appropriate type is, but it would work across the FFI boundary.
> +However the bigger problem comes from code generation tools like cbindgen and
> +bindgen. When cbindgen see u8 in Rust it will generate uint8_t on the C side
> +which will cause differ in signedness warnings/errors. Similaraly if bindgen
> +see `char` on the C side it will generate `std::ffi::c_char` which has its own
> +problems.

Yeah, we definitely don't want to be using "std::ffi::c_char" in our 
rust implementations. I do wonder if we might want to use it (or CStr) 
judiciously in function parameters and immediately convert it to u8 in 
the function body where the function is called from C though.

> +=== Notes
> +^1^ This is only true if stdbool.h (or equivalent) is used. +
> +^2^ C does not enforce IEEE-754 compatibility, but Rust expects it. If the
> +platform/arch for C does not follow IEEE-754 then this equivalence does not
> +hold. Also, it's assumed that `float` is 32 bits and `double` is 64, but
> +there may be a strange platform/arch where even this isn't true. +
> +^3^ C also defines uintptr_t, but this should not be used in Git. +
> +^4^ C also defines ssize_t and intptr_t, but these should not be used in Git. +

[u]intptr_t and ssize_t are used in git already. As Junio has pointed 
out there are sane uses for these types but we don't want to use them in 
structs or function parameters where the struct or function is shared 
with rust.

> +
> +== Problems with std::ffi::c_* types in Rust
> +TL;DR: They're not guaranteed to match C types for all possible C
> +compilers/platforms/architectures.

Is this official policy of the rust project?

Thanks

Phillip

> +Only a few of Rust's C FFI types are considered safe and semantically clear to
> +use: +
> +
> +* `c_void`
> +* `CStr`
> +* `CString`
> +
> +Even then, they should be used sparingly, and only where the semantics match
> +exactly.
> +
> +The std::os::raw::c_* (which is deprecated) directly inherits the problems of
> +core::ffi, which changes over time and seems to make a best guess at the
> +correct definition for a given platform/target. This probably isn't a problem
> +for all platforms that Rust supports currently, but can anyone say that Rust
> +got it right for all C compilers of all platforms/targets?
> +
> +On top of all of that we're targeting an older version of Rust which doesn't
> +have the latest mappings.
> +
> +To give an example: c_long is defined in
> +footnote:[https://doc.rust-lang.org/1.63.0/src/core/ffi/mod.rs.html#175-189[c_long in 1.63.0]]
> +footnote:[https://doc.rust-lang.org/1.89.0/src/core/ffi/primitives.rs.html#135-151[c_long in 1.89.0]]
> +
> +=== Rust version 1.63.0
> +
> +[source]
> +----
> +mod c_long_definition {
> +    cfg_if! {
> +        if #[cfg(all(target_pointer_width = "64", not(windows)))] {
> +            pub type c_long = i64;
> +            pub type NonZero_c_long = crate::num::NonZeroI64;
> +            pub type c_ulong = u64;
> +            pub type NonZero_c_ulong = crate::num::NonZeroU64;
> +        } else {
> +            // The minimal size of `long` in the C standard is 32 bits
> +            pub type c_long = i32;
> +            pub type NonZero_c_long = crate::num::NonZeroI32;
> +            pub type c_ulong = u32;
> +            pub type NonZero_c_ulong = crate::num::NonZeroU32;
> +        }
> +    }
> +}
> +----
> +
> +=== Rust version 1.89.0
> +
> +[source]
> +----
> +mod c_long_definition {
> +    crate::cfg_select! {
> +        any(
> +            all(target_pointer_width = "64", not(windows)),
> +            // wasm32 Linux ABI uses 64-bit long
> +            all(target_arch = "wasm32", target_os = "linux")
> +        ) => {
> +            pub(super) type c_long = i64;
> +            pub(super) type c_ulong = u64;
> +        }
> +        _ => {
> +            // The minimal size of `long` in the C standard is 32 bits
> +            pub(super) type c_long = i32;
> +            pub(super) type c_ulong = u32;
> +        }
> +    }
> +}
> +----
> +
> +Even for the cases where C types are correctly mapped to Rust types via
> +std::ffi::c_* there are still problems. Let's take c_char for example. On some
> +platforms it's u8 on others it's i8.
> +
> +=== Subtraction underflow in debug mode
> +
> +The following code will panic in debug on platforms that define c_char as u8,
> +but won't if it's an i8.
> +
> +[source]
> +----
> +let mut x: std::ffi::c_char = 0;
> +x -= 1;
> +----
> +
> +=== Inconsistent shift behavior
> +
> +`x` will be 0xC0 for platforms that use i8, but will be 0x40 where it's u8.
> +
> +[source]
> +----
> +let mut x: std::ffi::c_char = 0x80;
> +x >>= 1;
> +----
> +
> +=== Equality fails to compile on some platforms
> +
> +The following will not compile on platforms that define c_char as i8, but will
> +if it's u8. You can cast x e.g. `assert_eq!(x as u8, b'a');`, but then you get
> +a warning on platforms that use u8 and a clean compilation where i8 is used.
> +
> +[source]
> +----
> +let mut x: std::ffi::c_char = 0x61;
> +assert_eq!(x, b'a');
> +----
> +
> +== Enum types
> +Rust enum types should not be used as FFI types. Rust enum types are more like
> +C union types than C enum's. For something like:
> +
> +[source]
> +----
> +#[repr(C, u8)]
> +enum Fruit {
> +    Apple,
> +    Banana,
> +    Cherry,
> +}
> +----
> +
> +It's easy enough to make sure the Rust enum matches what C would expect, but a
> +more complex type like.
> +
> +[source]
> +----
> +enum HashResult {
> +    SHA1([u8; 20]),
> +    SHA256([u8; 32]),
> +}
> +----
> +
> +The Rust compiler has to add a discriminant to the enum to distinguish between
> +the variants. The width, location, and values for that discriminant is up to
> +the Rust compiler and is not ABI stable.

