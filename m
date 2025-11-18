Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DC2F7477
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509803; cv=none; b=jtSiyjSVsacPBATAX3jCe8Dg+iJLXjSBq4IQQDG3OMRX4PsjoXDmwNsVdHzKXJUwpHBAe1ytIY7eIC/52YSyihGBzmV7Md+6IZ5Hneld9NL6i6T8S6WsoACjOABl40bSf/h7rWr8wZyVYnW1MgkPjy/GMbTyphLMCRGoSMPjDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509803; c=relaxed/simple;
	bh=M7yTU5IGt62locgWIBpCfDD4rKs311Di/h7HZi2+MWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZpiQ4M2YY06xGzfYzx1pG0RPgKKLiHxFLnP+VvWD8Vfd108BMHOoMLAQGceQ2vVN3bHyx5SjkYwMEohCqMxRAWVkr8tEKWPTc5KxCPwzCbI7pXuihPDfedjXdYTIju5nta+gpUfVQzLrZeeL+cNqoiqj+uoTKkqnfw3piwoTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=UH9ZCex5; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="UH9ZCex5"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id LVPLvt5evEAJ1LVPNvdmn5; Tue, 18 Nov 2025 23:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1763509609; bh=x2MeqQa07uvs9Mm4fp/3SasD16TJUwmeo3cUanJPj5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UH9ZCex5rvcR8oLRWgY41PS3CSb1Yi2NqS82tC2xlPfxMSLD+f3ul93p2pkhV9OiZ
	 joICc6qQym8/tbVCZMLjWc6s9eOPmKnbo4c0JM0tBSynVm/6ryf3O+4tBmKI89JL7k
	 eMRWorSUn9X0BxGjdIrsZiYx5YXDUCQRSIHAxP6ymghc8+D09NeFx5/J2ZQLL21Ups
	 GecRtv3rIWulHHBtDV7Zhm96XaCMr2S2qkrbROuy4U3ciDvwtLIiMibBCiuC+jhLUs
	 evpAW6SawbBnB5W58GnzAd4jaIUIJLBZVzi+a5N/9YFJ0rXls/0FKLsfcTNWgZxFhI
	 dCGTCxHS5EEkQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NOl2+F6g c=1 sm=1 tr=0 ts=691d0569
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=1StWMtfbPirchfnQ7w8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <9c7a7d09-2cc0-40f7-b37a-befef5339d76@ramsayjones.plus.com>
Date: Tue, 18 Nov 2025 23:46:47 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] doc: define unambiguous type mappings across C
 and Rust
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>,
 Chris Torek <chris.torek@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
 <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
 <8b56bf117289ca3be25533a36da1ea0c178ccfca.1763505262.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <8b56bf117289ca3be25533a36da1ea0c178ccfca.1763505262.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGAGHwj8+K9jWmy/5Hib2DJuN/3dcOaRkHFVj0BHJrOn067rZ2fGA/quwaEPg3QzAjEF8yLfTX2SJSReNiYPXikmofJlDYM0PZcfaUrZDj8g1dxu+GJg
 D00KbCh5fyBiKO2CluDF1Q1qTMovjtOESqxBDaceq7cgg9+F+MqyDzlefArj41GFTxUZfy0+ds3woV0VvySd3TArbBr1qsNrvcE=



On 18/11/2025 10:34 pm, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Document other nuances when crossing the FFI boundary. Other language
> mappings may be added in the future.
> 
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  Documentation/Makefile                        |   1 +
>  Documentation/technical/meson.build           |   1 +
>  .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 Documentation/technical/unambiguous-types.adoc
> 
[snip]

> diff --git a/Documentation/technical/unambiguous-types.adoc b/Documentation/technical/unambiguous-types.adoc
> new file mode 100644
> index 0000000000..9a4990847c
> --- /dev/null
> +++ b/Documentation/technical/unambiguous-types.adoc
> @@ -0,0 +1,224 @@
> += Unambiguous types
> +
> +Most of these mappings are obvious, but there are some nuances and gotchas with
> +Rust FFI (Foreign Function Interface).
> +
> +This document defines clear, one-to-one mappings between primitive types in C,
> +Rust (and possible other languages in the future). Its purpose is to eliminate
> +ambiguity in type widths, signedness, and binary representation across
> +platforms and languages.
> +
> +For Git, the only header required to use these unambiguous types in C is
> +`git-compat-util.h`.
> +
> +== Boolean types
> +[cols="1,1", options="header"]
> +|===
> +| C Type | Rust Type
> +| bool^1^       | bool
> +|===
> +
> +== Integer types
> +
> +In C, `<stdint.h>` (or an equivalent) must be included.
> +
> +[cols="1,1", options="header"]
> +|===
> +| C Type | Rust Type
> +| uint8_t    | u8
> +| uint16_t   | u16
> +| uint32_t   | u32
> +| uint64_t   | u64
> +
> +| int8_t     | i8
> +| int16_t    | i16
> +| int32_t    | i32
> +| int64_t    | i64
> +|===
> +
> +== Floating-point types
> +
> +Rust requires IEEE-754 semantics.
> +In C, that is typically true, but not guaranteed by the standard.
> +
> +[cols="1,1", options="header"]
> +|===
> +| C Type | Rust Type
> +| float^2^      | f32
> +| double^2^     | f64
> +|===
> +
> +== Size types
> +
> +These types represent pointer-sized integers and are typically defined in
> +`<stddef.h>` or an equivalent header.
> +
> +Size types should be used any time pointer arithmetic is performed e.g.
> +indexing an array, describing the number of elements in memory, etc...
> +
> +[cols="1,1", options="header"]
> +|===
> +| C Type | Rust Type
> +| size_t^3^     | usize
> +| ptrdiff_t^3^  | isize
> +|===
> +
> +== Character types
> +
> +This is where C and Rust don't have a clean one-to-one mapping.
> +
> +A C `char` and a Rust `u8` share the same bit width, so any C struct containing
> +a `char` will have the same size as the corresponding Rust struct using `u8`.
> +In that sense, such structs are safe to pass over the FFI boundary, because
> +their fields will be laid out identically. However, beyond bit width, C `char`
> +has additional semantics and platform-dependent behavior that can cause
> +problems, as discussed below.
> +
> +The C language leaves the signedness of `char` implementation defined. Because
> +our developer build enables -Wsign-compare, comparison of a value of `char`
> +type with either signed or unsigned integers may trigger warnings from the
> +compiler.

Yep, much better. Thanks!

ATB,
Ramsay Jones


