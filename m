Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FA192598
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791905; cv=none; b=u9xCQ8TFBVWag8I0MSk2ua5EvGqGTrLXfeHPYpijVSl7jyFskLgchQvKwfqoWJhz/aftfblDYYhlHwYzbiERN7D95fZvcz0NtZ61KlktR8xVdxB3AvhPQ4ObkDem8sZPoG+WPEOT7eUclSIGd4FXRCBT7b8UWIssuJBGpMKfERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791905; c=relaxed/simple;
	bh=bmqRT22KyZj+V1vGJIb+ugo3A0TAKsMnRYDYqJlph1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4KEUvb8ldTTjaoLzmTtQPJA7mwwul3M0coblo6xAPYGWS09hXSK/e0JAp/kTLODx9KSfvHRg7EWNwUWQXy6y9Ryy6aWUoIgZpACsM3zP6POnU05munDlkWR+k/XcFs1vKBaEvDJryc8jtZWaPiYXxRPOU/z3/qIKQT9Q9zoQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=JeZpOqfP; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="JeZpOqfP"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e767ce72eso15198367b3.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752791902; x=1753396702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGziDPykVYR96SRDwMhRdeH2gMja9Tn1Zu7zIAtskOg=;
        b=JeZpOqfPHByfyMDq1AlOYc6OBQIUb6Z+324w3c8S4C/2bzofWN1KDIDbtYetYV65Pe
         ceN/an9q0QBZIUaatz64URL9BiTlt0QDFGGlmxCPycHW4h3Pk2f0QKQc7a/d0QVbo2wI
         ItBJQVcyp4gd3QSXQMW6cvLt9q+95z4cAKgZ3dEncikCPktl8hNPW4zxqDmrjlg4knms
         ydaKmRA6cbaeDb0h4l3DSzoahKGTaoIUwvSnAoT5c35WOACcODRA4858Ms46N/LrhvKo
         S2h5Unfr/yw1FAn+WKlbrpTdyTqP2y4HOwjehgSEfYL11+8VcPtkeXy9B54qoWiNxsPv
         /g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752791902; x=1753396702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGziDPykVYR96SRDwMhRdeH2gMja9Tn1Zu7zIAtskOg=;
        b=iImn/S9T0Afw2AassOenjLwzsFZahhCtgUCn4U3w9+xXDYUFNVsBH5q1WU8uibGut7
         maocGUiJvMXOd4w7KFX2Hbsm6OHUaMaQRnefXSvqxJzRNbbgdAIoDn93z2hx3fYvSUMp
         QzpW68tMfCg8Scjir1NxCvH6zysF1QAJ5GppJobz58MkZHn8l7I88XHzwbtFOQrO5Ii8
         EqH+fKDgfgQyqdchQ4CX0PKLuUt9JYTJG/jmhHvCLmBBke8pBfgGIc/MNdrt/+xq0bmF
         KuM+MqX58vAzCE4/pf91I90+XP9AeckzTMavFZNvWdyekgAO7azG43InohW4FxMQhr0k
         e05A==
X-Gm-Message-State: AOJu0YyYnyz+YXBhxSxaNoBcdiaa1pLYlT94ueuZN1qJ9a8zBdfuXofZ
	NR2E6aYNJS47de+jAw5kWK1OjDlg+6452QXmfCOj8jHQF7wkjm/H8l/Nf/AI3WuZs8o=
X-Gm-Gg: ASbGncvwhGJZQkIoqE5U/CNBfpzTh40qGMfRMHYuj96BCyCWg9hxtpErikdXv4+xddJ
	2lcybfujo/PnbxA/FIixRM5bq5zsQpPzXMfyK2G0M/r7G3p8X5LFgg/kyYU8dI/0jrAr1Gy25sa
	4/M9cVjB71+4ERm4Jwm8MbBzcgkbMnFEqsWD54N+GtTc6QdYpxPLsjeqgwQieXiabDWs1H2wikN
	IU6BE4GOtYdhkVdWSjKdd61jSe8tMeuyU670bV5UMv0sWsUKUv0PgEtP8DzzmMWh3Actb8VGC8U
	okRnVw/opEKFzJAuuR19Cwz4GDqqHkCFn6164spZzLExJZvP1CX5hSUg5aNQXaq1R0JXyKXt6Z7
	2qSvkC6c4J9mjQ0DChGC6y++plhWxXF2SuVNG7rPXNXvFSihRRaHtboYolZR7B8Xt67WXWg==
X-Google-Smtp-Source: AGHT+IGCFfwfeHBUlczuY0uzW2VcivM3oZK+GN3N0/i4/jh/9ipvF3YhbsYuZzc73/7+5QX6aZTGLQ==
X-Received: by 2002:a05:690c:a058:b0:718:344f:73d0 with SMTP id 00721157ae682-71836ca9a8amr88753707b3.3.1752791902159;
        Thu, 17 Jul 2025 15:38:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7195319821bsm445747b3.49.2025.07.17.15.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:38:21 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:38:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
Message-ID: <aHl7W5bDOGsORLLO@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>

On Thu, Jul 17, 2025 at 08:32:18PM +0000, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Upcoming patches will accelerate and simplify xdiff, while also
> porting parts of it to Rust. In preparation, add some stubs and setup
> the Rust build. For now, it is easier to let cargo build rust and
> have make or meson merely link against the static library that cargo
> builds. In line with ongoing libification efforts, use multiple
> crates to allow more modularity on the Rust side. xdiff is the crate
> that this series will focus on, but we also introduce the interop
> crate for future patch series.
>
> In order to facilitate interoperability between C and Rust, introduce
> C definitions for Rust primitive types in git-compat-util.h.

Exciting ;-).

> diff --git a/Makefile b/Makefile
> index 70d1543b6b86..db39e6e1c28e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -919,6 +919,11 @@ TEST_SHELL_PATH = $(SHELL_PATH)
>
>  LIB_FILE = libgit.a
>  XDIFF_LIB = xdiff/lib.a
> +ifeq ($(DEBUG), 1)
> +RUST_LIB = rust/target/debug/libxdiff.a
> +else
> +RUST_LIB = rust/target/release/libxdiff.a
> +endif

We do have a DEBUG variable in our Makefile introduced via dce7d29551
(msvc: support building Git using MS Visual C++, 2019-06-25), but I
don't think that it is very widely used. Perhaps that is because I don't
build Git with MSVC, but I suspect that this is generally true.

Much more common is the DEVELOPER=1 setting, which adds more compiler
warnings and similar. I am not sure whether or not it would be
appropriate to use DEVELOPER here to determine which libxdiff.a to use.

In any event, our convention would be to treat the defined-ness of DEBUG
the same way that this patch treats DEBUG=1, so I might suggest
replacing your "ifeq" with "ifdef DEBUG".

>  REFTABLE_LIB = reftable/libreftable.a
>
>  GENERATED_H += command-list.h
> @@ -1392,6 +1397,8 @@ UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
>  GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
>  EXTLIBS =
>
> +GITLIBS += $(RUST_LIB)
> +
>  GIT_USER_AGENT = git/$(GIT_VERSION)
>
>  ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
> @@ -2925,6 +2932,14 @@ $(LIB_FILE): $(LIB_OBJS)
>  $(XDIFF_LIB): $(XDIFF_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
> +.PHONY: $(RUST_LIB)
> +$(RUST_LIB):
> +ifeq ($(DEBUG), 1)
> +	cd rust && RUSTFLAGS="-Aunused_imports -Adead_code" cargo build --verbose

A few thoughts here:

 - Does "cargo" support a flag similar to our -C? If so, I wonder if it
   might be worth writing "cargo -C rust build ..." instead of "cd rust
   && ...".

 - This conditional on DEBUG passes the "--verbose" option in both
   cases. Should we only pass the "--verbose" option when we have "V=1"?

 - Regardless of whether or not we condition passing "--release" (or
   not) on "DEBUG", this line should also be "ifdef DEBUG" similar to
   above.

> +else
> +	cd rust && RUSTFLAGS="-Aunused_imports -Adead_code" cargo build --verbose --release
> +endif
> +
>  $(REFTABLE_LIB): $(REFTABLE_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
> @@ -3756,7 +3771,10 @@ cocciclean:
>  	$(RM) -r .build/contrib/coccinelle
>  	$(RM) contrib/coccinelle/*.cocci.patch
>
> -clean: profile-clean coverage-clean cocciclean
> +rustclean:

I'm nitpicking, and we don't *really* have a convention here between
separating the clean target from "clean", as we have both
"profile-clean" and "cocciclean". I prefer the former, and think that it
would be nice to use that convention, but this is pretty much textbook
bike-shedding and not something that I really care about ;-).

> +	cd rust && cargo clean

Same question here about whether or not this could be written as "cargo
-C clean".

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4678e21c4cb8..82dc99764ac0 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -196,6 +196,23 @@ static inline int is_xplatform_dir_sep(int c)
>  #include "compat/msvc.h"
>  #endif
>
> +/* rust types */
> +typedef uint8_t   u8;
> +typedef uint16_t  u16;
> +typedef uint32_t  u32;
> +typedef uint64_t  u64;
> +
> +typedef int8_t    i8;
> +typedef int16_t   i16;
> +typedef int32_t   i32;
> +typedef int64_t   i64;
> +
> +typedef float     f32;
> +typedef double    f64;
> +
> +typedef size_t    usize;
> +typedef ptrdiff_t isize;
> +

Makes sense. Should we also have "bool" here (assuming that the series
declaring the "use bool" experiment a success lands)? I guess maybe not
either way, <stdbool.h> defines "bool" as the type name, identically to
Rust.

Thanks,
Taylor
