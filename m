Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0401991C9
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757258819; cv=none; b=Jwtp+n5QhqVAr5vKj8lBXz6Bz2CH8cwzXwfZ/ys5zkyxcNELOhF/bhrgy4Dcfmbmhe6xxAG/DB0GSW4stBM1/u3626SWeJiVPLnewXvRbZZ/Lj8HRCX23+zBWQIQFa+HFXcj5K2gxVMBQzp028bOgQsR71O1nrLTtCd5NW7q5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757258819; c=relaxed/simple;
	bh=j/2bl2uBUvwPPhV0YHKV0yMKD78k2wcj/2CojpxLk8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiNtGhJ+IPs2zhMzpYoGpdJUIvWX7IA+mwuI5A19TaZN7Yps41AnVQBB7GOVh8qwHjlSYr17eCx/V8D2Yw8rMF103NnU9hSMqECLblb0hy6ih/FP0jM0eSYOzllBcMUX7eQtxVcgJ30zu6GvQbAVckZX3nV0O3R+/CX81gY0USY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKzYv5W/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKzYv5W/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e2055ce973so1832766f8f.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757258816; x=1757863616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUI09G5G7Qy1+LRUCwCcHvMx9NAhUlpkNgmUqt19bQ=;
        b=iKzYv5W/ZhHl16qc6KgDWa+7rx1pQ4YSdhcal4mHIXmALfeY1w9ROlVWWMht3+bogN
         LybKd+v8KGWpGYLBxY8wjSOvKCvjHTf6pPaRtpx8eEIj6Za0VzXeTxq3D75MkEF78A9Q
         wnACQev9SzMbPlG1AZYiTOXiwhfMhCZ9u/DqVWdzBeTwyN402hXzwYcxMdoAGrB0f8D3
         xs/ywRku46zcb+y40ue/RQyjgZSjZSfxJZYk2xtBuH6zxFoZ4O4BrJKFE4P79Nbcgn2w
         YhS/bJB0jYDZEL1H3Zncdr2VmCxUBPy58f0kT/cc6tLY2ckQGUHRPyxebKy0jomBTMHY
         4S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757258816; x=1757863616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjUI09G5G7Qy1+LRUCwCcHvMx9NAhUlpkNgmUqt19bQ=;
        b=rPB0ARgJ3tn/5mWHjXVVmhZZvbkhaava7y7lqP54iVZCQ8bJPjkwdY08IepHLWMupf
         ENVtN7ULNOwBuRsLPW2YAUeKL2rxD/Cn6mNbdjLp/+F/L5Hph12O7Kz8zrkv0QgNfl+U
         4JdkYnBELDx1VVTq5c0wKZkmZ2wk8olfVmzpQD3wF97aOmwlze4u+WZqU9Q24TRt8WFp
         n0cyULaxGWSxW4uy01twejjZTLo1WRBld0ofa+lj16Wh7a/FRiwOns8lqUFWMGqZsWJh
         qNzUf6Yo9TpFdpUtURb6bmJ01ziB1tbRN3dqPMYxCDexFwIuRDloeu1mWu2XAh/hfqjC
         ywFQ==
X-Gm-Message-State: AOJu0YzegGB8hss8mpsPrlewzdkyuYnI/ydKD1zvx1lBW3bJXp8QSGD2
	t6bUN9ye+Zks1CnMA703aD2Y8M8bh+9Nw+x+lalRlSAOyr1aJwl7a0/i
X-Gm-Gg: ASbGncut84Z0onZhOZNLXvKcrdXkOgGlTdxCjydgpbulVoVdt6BWB7yK4Dazz9e73Dw
	IuaZ9EIXfUx+5eryE8PSZdJr6YJsGrGecm/OFvji/ompM2Rx8B1q1vwCfd7sNwHC8H3oFMu0x2t
	W4YtwPAnZyWbfGFh621Yh81N7obrqH586LbT8/RlO0uKEmAF/q1rdZUfdZgDMnh38yyqli6Nb4d
	9VUgOKthA4iZ4F82cco3rPPHKznZhTxZ46Sd+ypulWtJWuzvKv18ai2iWb6FBP/GoyFy45PXtE1
	lqHlK8bT58G3GB2O1+XjhyY4AeyztK2lvCSvsT0d2pcHGGx2WbrkgZWs5h8rjVM3TuVQkdN+260
	agK4IlQnavqz2vlK3Uovxe5A/pzGJJzsYljMlggHTqHXNLyAG5Pas
X-Google-Smtp-Source: AGHT+IHk/e2gJNd+83SI2pcCgI1sHB66tR9iUm6aU10ErFfTVQi4NFtKRRCgRtyniy2RVNxrtphsnw==
X-Received: by 2002:a05:6000:3107:b0:3e7:48c4:9704 with SMTP id ffacd0b85a97d-3e748c497b9mr553048f8f.44.1757258815539;
        Sun, 07 Sep 2025 08:26:55 -0700 (PDT)
Received: from localhost (84-236-78-205.pool.digikabel.hu. [84.236.78.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e329475a13sm10265709f8f.14.2025.09.07.08.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 08:26:54 -0700 (PDT)
Date: Sun, 7 Sep 2025 17:26:53 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 2/7] Makefile: introduce infrastructure to build
 internal Rust library
Message-ID: <aL2kPUokmioiXCOG@szeder.dev>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>

On Fri, Sep 05, 2025 at 01:50:58PM +0200, Patrick Steinhardt wrote:
> Introduce infrastructure to build the internal Rust library. This
> mirrors the infrastructure we have added to Meson in the preceding
> commit. Developers can enable the infrastructure by passing the new
> `WITH_RUST` build toggle.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitignore |  2 ++
>  Cargo.toml |  9 +++++++++
>  Makefile   | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 54 insertions(+), 2 deletions(-)

> diff --git a/Makefile b/Makefile
> index 555b7f4dc3..e7b3c8e57b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -483,6 +483,14 @@ include shared.mak
>  # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
>  # in /foo/bar/include and /foo/bar/lib directories.
>  #
> +# == Optional Rust support ==
> +#
> +# Define WITH_RUST if you want to include features and subsystems written in
> +# Rust into Git. For now, Rust is still an optional feature of the build
> +# process. With Git 3.0 though, Rust will always be enabled.
> +#
> +# Building Rust code requires Cargo.
> +#
>  # == SHA-1 and SHA-256 defines ==
>  #
>  # === SHA-1 backend ===
> @@ -918,6 +926,11 @@ TEST_SHELL_PATH = $(SHELL_PATH)
>  LIB_FILE = libgit.a
>  XDIFF_LIB = xdiff/lib.a
>  REFTABLE_LIB = reftable/libreftable.a
> +ifdef DEBUG
> +RUST_LIB = target/debug/libgit.a
> +else
> +RUST_LIB = target/release/libgit.a
> +endif
>  
>  GENERATED_H += command-list.h
>  GENERATED_H += config-list.h
> @@ -1387,8 +1400,12 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  
>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
>  
> -# xdiff and reftable libs may in turn depend on what is in libgit.a
> -GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
> +GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
> +ifdef WITH_RUST
> +GITLIBS += $(RUST_LIB)
> +endif
> +# Other libs may in turn depend on what is in libgit.a.
> +GITLIBS += $(LIB_FILE)
>  EXTLIBS =
>  
>  GIT_USER_AGENT = git/$(GIT_VERSION)
> @@ -1411,6 +1428,19 @@ BASIC_LDFLAGS =
>  ARFLAGS = rcs
>  PTHREAD_CFLAGS =
>  
> +# Rust flags
> +CARGO_ARGS =
> +ifndef V
> +CARGO_ARGS += --quiet
> +endif
> +ifndef DEBUG
> +CARGO_ARGS += --release
> +endif
> +
> +ifdef WITH_RUST
> +BASIC_CFLAGS += -DWITH_RUST
> +endif
> +
>  # For the 'sparse' target
>  SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
>  SP_EXTRA_FLAGS =
> @@ -2918,6 +2948,16 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
>  $(LIB_FILE): $(LIB_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>  
> +$(RUST_LIB): FORCE

Why is this target FORCE-d instead of declaring its dependencies?

> +	@OLD_STAT="$$(stat $@ 2>/dev/null)"; \
> +	    cargo build $(CARGO_ARGS); \
> +	    if test $$? != 0 || test x"$$OLD_STAT" != x"$$(stat $@ 2>/dev/null)"; then \
> +		echo '   ' CARGO $@; \
> +	    fi

This hides 'cargo's exit code from 'make', so a failure to build the
Rust components won't abort the build.  So once we have a successfully
built Rust library and were to inadvertently introduce a syntax error
into the Rust code:

  $ echo foo >src/varint.rs 
  $ make WITH_RUST=1
  error: expected one of `!` or `::`, found `<eof>`
   --> src/varint.rs:1:1
    |
  1 | foo
    | ^^^ expected one of `!` or `::`

  error: could not compile `git` (lib) due to previous error
      CARGO target/release/libgit.a
      SUBDIR git-gui
      SUBDIR gitk-git
      SUBDIR templates
  $ echo $?
  0

Also note that the error message is printed before the command that
produced that error; it should be the other way around.

> +
> +.PHONY: rust
> +rust: $(RUST_LIB)
> +
>  $(XDIFF_LIB): $(XDIFF_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>  
> @@ -3768,6 +3808,7 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) $(FUZZ_PROGRAMS)
>  	$(RM) $(SP_OBJ)
>  	$(RM) $(HCC)
> +	$(RM) -r target/ Cargo.lock
>  	$(RM) version-def.h
>  	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
>  	$(RM) $(test_bindir_programs)
> 
> -- 
> 2.51.0.417.g1ba7204a04.dirty
> 
