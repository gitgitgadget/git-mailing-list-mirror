Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107719C561
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234191; cv=none; b=hKOKcxB2Rx7VQUdtkYKMLLG5Z7z3VLAWLY7s5NJ4PxTyGcQl+o7/eT2Uw+veMMg3QLgQe51xgm69iZPa8Obtd1/uCYL+B/KJUAFGsJ64QbH9357Jl+lKeF6XIVHA1oE69Ygm3hQRUkO6qUYlvTalOt7d0D8KPEXDCZnFfhUsPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234191; c=relaxed/simple;
	bh=/k/6gOPNTPXCkLY2nZWYBpLrOqLdAZHxUvvCg1+bjD4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tp6QAiej+o7EMQSU2C5BqT5QsI/NKNyShgJRIJAq9/3ZKWrd89yJK0Lq2/202XqyAzmwo015LygXZ4qWuRD2nGRIqIr7Xsdj7iFLBEo0GIO1xyTmUxQqvCuuICP4PCr3bWK9Ric4u/LsnESafEeEGYY0WpxnzcqmS+5Wu4/ctUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJn4F4tv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJn4F4tv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43618283d48so4502365e9.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 02:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738234188; x=1738838988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjvsS87OH4viq/BrRiCIxEUM31ZIomcs2xD9vcJimFE=;
        b=LJn4F4tvWijJeF/7DOQY27yu6NmLN9tNq9tu09SL1A8NIskeMB0RIUacIqDVMCPL2N
         w1nzyIEDLY3q1zZrr9n/ppoPPn8tHVo5U0Q79/AfaOiMUEVwfwnRFy5knag6ok6oH72q
         DTmZanbuQgTO9sTHBXt1uam1AVwA3VNX2emSyDDU2cd40+vIGv5LMoqYMfC8oBWNLyc4
         14SsWVim7LpHnOXCP2uwKIHyNJI7k/sETyr/fikdanWUUJuDRRoHFT2wntsebAxnJzWp
         w1gZH1Dv5vvCPeQ5bWsc4B2dwRMFzw1et+m47LYcktVCI0QFnfCFr4UT+2vGcouYCCNi
         i2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738234188; x=1738838988;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjvsS87OH4viq/BrRiCIxEUM31ZIomcs2xD9vcJimFE=;
        b=UJPCDDTAxKhEqoc61GPDkX91op407a0tSrkolwA4izDu/DxMZiyzvsU2PXZ+COPywV
         +SeiFGMM+Y8AbcXOonOKyzI/UOvEFUQRBwP5z4obFVDLyP/vE5XqPiHTvPg1vk2DeyrK
         bEqz+VG0KQvPUE/N3VvK+DAZ8SWXHUdI8PC205UruipahdGmQd1dpAxWnXdRcqh3A1Un
         H7KAL9PWIGpi25p1HBoDxYXuIsJGrvVc99NuFm+fxgSkkckhdCzNMgeBlEIkPdzSxpvS
         +V6RZrcEY3DBR+HU8/qGHrvR16T5p1jZkQYLViDicIsQc8TC0vkbt7T7IhjAFzvAF2+U
         yQXg==
X-Forwarded-Encrypted: i=1; AJvYcCUkdkOHUNMjn7yCyL2GJNMU5NwsCOUT3p5moG7lAHHEClbbFsMGQVqDUtZOOxRciHHsDoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQ+zCzqvkThTmVz11OtGnSIOTnT8F4TF+qvZA3bYrHuxtfYqp
	UU6Dsc4qmuyZPlZfBwY/fkosU0m/NQvLkbmTWtGpUoS/qA22EGi3
X-Gm-Gg: ASbGnctLfijOJDW/GLeNG5TgiZCE4xV7PR0Lb26+GQ+sfMD4UZwtwL/sF4kuiU27+ug
	JHbgjovt2tR09J2Hd+03/sWeJxqI7Dk3zoM4qh9iRN1dp2J5RqEZOWYzbDqjH/CsNOzLvg7DCg8
	HtX5WsL1WfdZMGy7IMdN+6C7eXNBdmQXTppVDPiBrpXx0VGwxEze+2bX2+T1XkOJcM8/8gZSlD4
	k/v1CfelZWDp338PSNPCBiZVrbYWHPAr0aA1SdGx6doO6XWtvWuaslAWmqwME3TZ1hZDg0TLxm5
	HijgmHgH1dLre7cThqtZ4vSWjHozyTcJD8q3PFoSZoAvwDigng63jaa8MpfykU8L7i0kMw==
X-Google-Smtp-Source: AGHT+IH8ZVUdi/sAGiS3Ym/dlVm+502UlHbea196ZFH8svnLSlMnempVhemvZ373QoP9RJvGBTbS+g==
X-Received: by 2002:a05:6000:400d:b0:38a:a074:9f3c with SMTP id ffacd0b85a97d-38c5194b023mr6464217f8f.16.1738234187314;
        Thu, 30 Jan 2025 02:49:47 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b574fsm1596414f8f.70.2025.01.30.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 02:49:46 -0800 (PST)
Message-ID: <2217da71-d18a-446f-a7a1-6db4d358bbe5@gmail.com>
Date: Thu, 30 Jan 2025 10:49:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 0/4] Introduce libgit-rs, a Rust wrapper around
 libgit.a
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com,
 gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738187176.git.steadmon@google.com>
Content-Language: en-US
In-Reply-To: <cover.1738187176.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

The range-diff looks good. It's really nice to see this being added to git.

Best Wishes

Phillip

On 29/01/2025 21:50, Josh Steadmon wrote:
> This series provides two small Rust wrapper libraries around parts of
> Git: "libgit-sys", which exposes a few functions from libgit.a, and
> "libgit", which provides a more Rust-friendly interface to some of those
> functions. In addition to included unit tests, at $DAYJOB we have tested
> building JJ[1] with our library and used it to replace some of the
> libgit2-rs uses.
> 
> [1] https://github.com/jj-vcs/jj
> 
> There is known NEEDSWORK, but I feel that they can be addressed in
> follow-up changes, rather than in this series. If you feel otherwise,
> please let me know:
> 
> * Investigate alternative methods of managing symbol visibility &
>    renaming.
> 
> * Figure out symbol versioning
> 
> Changes in V9:
> * Properly initialize Makefile var LIBGIT_PUB_OBJS.
> 
> * Pass the correct pointer to free in libgit_configset_free().
> 
> Changes in V8:
> * Define a private libgit_config_set struct to avoid excessive casting
>    in public_symbol_export.c.
> 
> * Style fixes: merge some Makefile rules, limit rule line length by
>    defining intermediate variables, add initial empty comment line, add
>    linebreaks in function definitions.
> 
> Changes in V7:
> * Moved the ConfigSet implementation in libgit-rs to a `config` module.
> 
> * Added doc comments for ConfigSet and its methods.
> 
> * Fix meson builds by adding new object files to `libgit_sources`
> 
> * Moved INCLUDE_LIBGIT_RS Makefile changes earlier in the series, so
>    that we can make it optional to compile some of the libgitpub sources.
>    Squashed V6 patch 5/5 into this series' patch 4/4.
> 
> * Don't publicly export FFI types in libgit-rs.
> 
> * Removed extraneous `-r` argument to $(RM) in the clean rules.
> 
> * Added TODO reminder in Cargo.toml about removing Cargo.lock once we
>    hit a certain minimum supported Rust version.
> 
> * Style cleanup in public_symbol_export.c
> 
> Changes in V6:
> * Rebased onto current master, since V5 was several months old.
> 
> * Move libgit-sys out of libgit-rs; while this sort of nesting is common
>    in Rust crates with standalone repositories, it doesn't make as much
>    sense when they're contained in the larger Git project's repo.
> 
> * Standardize the naming of some of the Makefile targets to always
>    include a dash in the "-rs" or "-sys" suffixes.
> 
> * Clean up READMEs and crate descriptions in preparation for
>    uploading to crates.io.
> 
> Changes in V5:
> * When building with INCLUDE_LIBGIT_RS defined, add
>    "-fvisibility=hidden" to CFLAGS. This allows us to manage symbol
>    visibility in libgitpub.a without causing `make all` to rebuild from
>    scratch due to changing CFLAGS.
> 
> * Avoid using c_int in the higher-level Rust API.
> 
> * Remove libgitpub.a and intermediate files with `make clean`.
> 
> Changes in V4:
> * Drop V3 patch #3, which added wrappers around repository
>    initialization and config access. These are not well-libified, and
>    they are not necessary for JJ's proof-of-concept use case, so let's
>    avoid exporting them for now.
> 
> * Set a minimum supported Rust version of 1.63. Autodetect whether our
>    Rust version has c_int and c_char types; if not, define them
>    ourselves.
> 
> * When building libgitpub.a via build.rs, set DEVELOPER=1 to catch
>    additional errors at build time.
> 
> * In build.rs, use the make_cmd crate to portable select the correct
>    invocation of GNU Make.
> 
> * Follow naming standards for _alloc() and _free() functions.
> 
> * Use String instead of CString in higher-level API.
> 
> * Move libgit_configset_alloc() and libgit_configset_free() out of
>    upstream Git, to the libgitpub shim library.
> 
> * In libgitpub, initialize libgit_config_set structs in the _alloc()
>    function rather than with a separate _init() function.
> 
> * Remove unnecessary comments in libgit-sys showing where the wrapped
>    functions were originally defined.
> 
> * Fix clippy lint: don't reborrow configfile path references.
> 
> * Various typo fixes and `cargo fmt` fixes.
> 
> Changes in V3:
> * Renamed cgit-rs to libgit-rs and cgit-sys to libgit-sys
> 
> * Makefile cleanup, particularly adding config.mak options that
>    developers can set to run Rust builds and tests by default (Patch 6)
> 
> * Provide testdata configs for unit tests
> 
> * ConfigSet API now uses &Path instead of &str -- more ergonomic for
>    Rust users to pass in and errors out if the path string isn't UTF-8
> 
> * Fixed unresolved dependency on libz in Cargo.toml
> 
> 
> Calvin Wan (1):
>    libgit: add higher-level libgit crate
> 
> Josh Steadmon (3):
>    common-main: split init and exit code into new files
>    libgit-sys: introduce Rust wrapper for libgit.a
>    libgit-sys: also export some config_set functions
> 
>   .gitignore                                |   2 +
>   Makefile                                  |  50 ++++++++++
>   common-exit.c                             |  26 ++++++
>   common-init.c                             |  63 +++++++++++++
>   common-init.h                             |   6 ++
>   common-main.c                             |  83 +----------------
>   contrib/libgit-rs/Cargo.lock              |  77 ++++++++++++++++
>   contrib/libgit-rs/Cargo.toml              |  17 ++++
>   contrib/libgit-rs/README.md               |  13 +++
>   contrib/libgit-rs/build.rs                |   4 +
>   contrib/libgit-rs/src/config.rs           | 106 ++++++++++++++++++++++
>   contrib/libgit-rs/src/lib.rs              |   1 +
>   contrib/libgit-rs/testdata/config1        |   2 +
>   contrib/libgit-rs/testdata/config2        |   2 +
>   contrib/libgit-rs/testdata/config3        |   2 +
>   contrib/libgit-sys/Cargo.lock             |  69 ++++++++++++++
>   contrib/libgit-sys/Cargo.toml             |  19 ++++
>   contrib/libgit-sys/README.md              |   4 +
>   contrib/libgit-sys/build.rs               |  35 +++++++
>   contrib/libgit-sys/public_symbol_export.c |  59 ++++++++++++
>   contrib/libgit-sys/public_symbol_export.h |  18 ++++
>   contrib/libgit-sys/src/lib.rs             |  79 ++++++++++++++++
>   meson.build                               |   2 +
>   t/Makefile                                |  15 +++
>   24 files changed, 673 insertions(+), 81 deletions(-)
>   create mode 100644 common-exit.c
>   create mode 100644 common-init.c
>   create mode 100644 common-init.h
>   create mode 100644 contrib/libgit-rs/Cargo.lock
>   create mode 100644 contrib/libgit-rs/Cargo.toml
>   create mode 100644 contrib/libgit-rs/README.md
>   create mode 100644 contrib/libgit-rs/build.rs
>   create mode 100644 contrib/libgit-rs/src/config.rs
>   create mode 100644 contrib/libgit-rs/src/lib.rs
>   create mode 100644 contrib/libgit-rs/testdata/config1
>   create mode 100644 contrib/libgit-rs/testdata/config2
>   create mode 100644 contrib/libgit-rs/testdata/config3
>   create mode 100644 contrib/libgit-sys/Cargo.lock
>   create mode 100644 contrib/libgit-sys/Cargo.toml
>   create mode 100644 contrib/libgit-sys/README.md
>   create mode 100644 contrib/libgit-sys/build.rs
>   create mode 100644 contrib/libgit-sys/public_symbol_export.c
>   create mode 100644 contrib/libgit-sys/public_symbol_export.h
>   create mode 100644 contrib/libgit-sys/src/lib.rs
> 
> Range-diff against v8:
> 1:  cd0cb9aa04 = 1:  cd0cb9aa04 common-main: split init and exit code into new files
> 2:  3588a3c3fc ! 2:  8793ff64a7 libgit-sys: introduce Rust wrapper for libgit.a
>      @@ Makefile: $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GIT
>       +all:: libgit-sys
>       +endif
>       +
>      -+LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
>      ++LIBGIT_PUB_OBJS =
>      ++LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
>       +LIBGIT_PUB_OBJS += libgit.a
>       +LIBGIT_PUB_OBJS += reftable/libreftable.a
>       +LIBGIT_PUB_OBJS += xdiff/lib.a
> 3:  f4452fffe6 ! 3:  ab32bd1d07 libgit-sys: also export some config_set functions
>      @@ contrib/libgit-sys/public_symbol_export.c
>       +void libgit_configset_free(struct libgit_config_set *cs)
>       +{
>       +	git_configset_clear(&cs->cs);
>      -+	free(&cs->cs);
>      ++	free(cs);
>       +}
>       +
>       +int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
> 4:  ada9fc0a13 ! 4:  1bf8c5392c libgit: add higher-level libgit crate
>      @@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
>       +all:: libgit-sys libgit-rs
>        endif
>        
>      - LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
>      + LIBGIT_PUB_OBJS =
>       
>        ## contrib/libgit-rs/Cargo.lock (new) ##
>       @@
> 
> base-commit: 757161efcca150a9a96b312d9e780a071e601a03

