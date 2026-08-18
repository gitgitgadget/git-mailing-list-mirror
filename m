Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0F3AAF43
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065224; cv=none; b=LGMHkXpqjRqc3zqiiqJVBnwL8+iNeXxa/zDWpXkcTke+NBFClbHXJ3iqSkFxKYX9WCH66lDJ/pmtLlJhgyunjIT16QX4e3GMx50JhKhSDgM3Vtx2e0HDtfTVB7XtR5tLO0GI/a4jC2c24AJO6hlntl4LFI7YcVk9cJeiKdEd2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065224; c=relaxed/simple;
	bh=s87B2CIxnUeq3m/9TO+z5P3ZOfsTO81ffaNqgAA9lMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txaSL82Wgl2djKGpVlqZwMRJmpdr+s9O5aqGfRfikLbK17l50jfm3UDRGzDRCbTxhGWK1S3+AU4qHQ+JR1HqzLXMOPlZrlZ9MlVy9eeMWZls1GVQLyrbl1CGMyUSjS40mQb9DxP/Lbkre7ERG5kcQo3QukX7vGnZyqXmXU61o9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il/Wn7Z5; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il/Wn7Z5"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66807ba2f0fso11913d50.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065221; x=1787670021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6EPVmvllkvRCy7dtOrrx+so6gyZIRQzMbChAJy6fHk4=;
        b=Il/Wn7Z5vktTLQaeg4QUmJ3KJBoUmUPMhOyJs5EFBSyJZORQdadZM4QxLzeuxkU+tA
         f8beP8Y/6fIZHrIhLvbjpnD7WZJ2L3XzucelyR8uZ4Es8Mli3MYSbUxs1FoDlAaViFw6
         k2+YElQyXX+H+soPYmZYK+5lu2EhBlbHUq2hYFt3V2b23rzphg1i2KU+CrQ11FS9LhnP
         JmTtLrd1q3/rtgb2bzhPYMsAVyydiIQM/BaFFZaXcubnA8rSBV8RZJ4CzOE3dYyLCjG8
         gmtccUJ5WDtpQu+6DgLOLxVf6kKJogzbzeNzhMRm80E58Z5E/g6Ha1JfDzFWfsR1CVln
         bDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065221; x=1787670021;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EPVmvllkvRCy7dtOrrx+so6gyZIRQzMbChAJy6fHk4=;
        b=QRGknfkdGTqFu9d4j2KWYqo0GjGJVbQPw82AYzpxXgrw0NpSzu7ouo2tMRQ8SZc7TK
         JSDCc4iS32KOam61wXqF2N0IG0AhGs64bfoxnLF9TsZGGe60d4EWIq+cMqNxbJfzgK8z
         /2v3GftuEfl0RIdHLIEv0jjLTeyWpmsBc/sanJFUfAPAWGyxpSZrdgWb1cZzxMzOiB7N
         GmFdcCl0hXZUYC704RowaQm/9MENCaDgBktzoAA3WNtgskJllapdbIWIj8k5VVrhGD3v
         YTe93aOD5P79g0ZZlRyGMXcU7/PVH7hMr4wT03zVN4p5JvFAk0KNGhF+NQy8cMnu19n0
         4Bkw==
X-Gm-Message-State: AOJu0YzvLF6P5+piG4UUWZHpVMme1+cIooZAeB+wmRX40HxbO1U+fW/d
	qFXvOCoEy8+hddclzzip4u6Mm8kV1M9jxSpSmSQp4CnZWdqwcWjJnJjcn6QTiCzB
X-Gm-Gg: AR+sD10Zti0ZmIN9WjIHakqBwGSPazoRw6NENcPFfuO2NeRqcJHb/w+tXAaAJel73i9
	xjLb9ZboIFHg8AxFinTXdHjLXOkGlUIVq5M2B8dL5WHTiCQ80wl4wzr89jO4VRswcP5JrDdEyTb
	SmGIz4M/CrP9EspPeClA0ZGlMXygUdHqXWZYFAWIbLHNYqT7B4dzVbNFn1E4Zs0hXJI+MSixRlk
	vURLkeumnCEXLzesTk6jt/yjYdRuzEXE6Ui64StRFLLhJMCzxztS4D2FSz4spMA21YlVa2F141y
	Zb6P/U5rIy1rLLyXDoPb9HLgf/Kz8KrEEDZOQXRDotedlIcKVrAucigNGGgQlEQKOSDIsY4QfO3
	+anFP3VzWHYXdIBUPjnpNZojlh9xNP9zLZ0aW/YgXXH9rPg+YMAft6JM7WHDUAQJR96G7AJJlhG
	7NDOGxoiLj4Xashw59fcfBnW/QLPbcFex0NyYckYplErQ3usBUSmUMb25A4l9aiBbXb+F1IxYUP
	5Tnwsh6yhM0cP29HXYsTMgiRCQ9meMu3njqkJoRIBf2OgEZ1l/r5Ux1YJ3IbPCKo7jcJvMBW75S
	ugsV19HK+Fk=
X-Received: by 2002:a05:690e:250:b0:668:2e0a:ba97 with SMTP id 956f58d0204a3-66c72b66e72mr8928857d50.13.1787065221246;
        Tue, 18 Aug 2026 08:00:21 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f3d1fb12sm20201097b3.48.2026.08.18.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:00:19 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 0/3] Convert USE_NSEC to runtime config
Date: Tue, 18 Aug 2026 10:59:44 -0400
Message-ID: <cover.1787065125.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1786103607.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Topic name: dk/use-nsec-runtime (applied)

Topic summary: Expose USE_NSEC as a runtime configuration, since
build-time is too early for distributing Git [1]. As a result, common
index-related options, like git-diff, are less likely to hit "racy git"
problems on supported filesystems.

[1]: https://git.github.io/rev_news/2026/07/31/edition-137/

Built on master (2c78326f81 (The 11th batch, 2026-08-05)).

Changes in v3:

- #ifdef out use_nanosec when NO_NSEC is requested

As I have heard no comments about the "Todo" lines below, which perhaps
could more clearly be marked "RFC"/"RFH", I've added this line to call
them out ;) and renamed them "Comments welcome"

Changes in v2:

- move Best-viewed-with trailer into message body as descriptive
  text.
- read core.useNanosec through struct repo instead of parsing
  config strings. The test suite passes locally this way, though that
  skipped 151 tests.
    - CI run: https://github.com/benknoble/git/actions/runs/31701945211

Original cover letter:

Hi all, this series follows up on the previous racy Git/USE_NSEC
conversations.

- The first patch is a mostly-unrelated documentation fix for Meson, but
  it came out of something I spotted while reviewing the outputs of the
  final (main) patch.
- The second patch is a preliminary no-op reorganization of
  repo_config_values_init.
- The third patch is the meat, converting USE_NSEC into core.useNanosec.

There is a small textual and semantic conflict with
'ty/repo-config-cleanups' in 'seen', since that branch removes the
comments in 'struct repo_config_values' which this series adds to. (The
semantic conflict is that, if we drop those comments, we should probably
not add them to repo_config_values_init like I do in patch 2.)

Comments welcome: I haven't touched any tests; I saw a bunch of hits for
"git grep racy t" but wasn't sure how to fit this particular change in,
especially since it won't be equally valid on all systems? Advice
welcome.

Comments welcome: I wonder if "useNanosec" paints us into too much of a
corner; that is (slightly more abstractly), we are using *extended
precision* in the index. Maybe the name and documentation should reflect
that, so we aren't too committed to "nanoseconds"?
    - Some platforms could offer extended precision that is not as
      precise as nanoseconds
    - Some could offer precision _beyond_ nanoseconds

idk.

v1: <cover.1786103607.git.ben.knoble@gmail.com>
v2: <cover.1786710807.git.ben.knoble@gmail.com>

[1/3] meson: expose knob for xmlto relative links in manuals
[2/3] environment: align repo_config_values_init with struct declaration
[3/3] core: convert build-time USE_NSEC into runtime core.useNanosec

 Documentation/config/core.adoc        |  6 ++++++
 Documentation/meson.build             |  7 ++++++-
 Documentation/technical/racy-git.adoc | 11 +++++-----
 Makefile                              | 12 +----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         | 29 ++++++++++++++++++++-------
 environment.h                         |  1 +
 meson_options.txt                     |  2 ++
 read-cache.c                          | 16 ++++++++++-----
 statinfo.c                            | 14 +++++++------
 12 files changed, 64 insertions(+), 43 deletions(-)

Diff-intervalle contre v2 :
1:  d612de6c2d = 1:  d612de6c2d meson: expose knob for xmlto relative links in manuals
2:  5693baa992 = 2:  5693baa992 environment: align repo_config_values_init with struct declaration
3:  2d1424732a ! 3:  48fceb4b57 core: convert build-time USE_NSEC into runtime core.useNanosec
    @@ Commit message
     
      ## Notes (benknoble/commits) ##
         Related benchmarks: <https://lore.kernel.org/git/CALnO6CBm4g27mWBvD9m6yL0e5YZu3M9_zcUeLZk7QwTgnxMLQA@mail.gmail.com/>
    -    CI: <https://github.com/benknoble/git/actions/runs/31701945211>
    +    CI: <https://github.com/benknoble/git/actions/runs/32137191115>
    +
    +    v3:
    +        We could perhaps be cute in read-cache.c:is_racy_stat() by writing
    +        the preprocessor directive like
    +
    +    		return (istate->timestamp.sec &&
    +    	#ifndef NO_NSEC
    +    			/* nanosecond timestamped files can also be racy! */
    +    			use_nsec
    +    			? (istate->timestamp.sec < sd->sd_mtime.sec ||
    +    			   (istate->timestamp.sec == sd->sd_mtime.sec &&
    +    			    istate->timestamp.nsec <= sd->sd_mtime.nsec))
    +    			:
    +    	#endif
    +    			istate->timestamp.sec <= sd->sd_mtime.sec
    +
    +        but that seemed maybe too clever?
     
      ## Documentation/config/core.adoc ##
     @@ Documentation/config/core.adoc: core.trustctime::
    @@ environment.c: int git_default_core_config(const char *var, const char *value,
      		return 0;
      	}
      
    ++#ifndef NO_NSEC
     +	if (!strcmp(var, "core.usenanosec")) {
     +		cfg->use_nanosec = git_config_bool(var, value);
     +		return 0;
     +	}
    ++#endif
     +
      	/* Add other config variables here and to Documentation/config.adoc. */
      	return platform_core_config(var, value, ctx, cb);
    @@ environment.c: void repo_config_values_init(struct repo_config_values *cfg)
      	cfg->ignore_case = 0;
      	cfg->trust_executable_bit = 1;
      	cfg->has_symlinks = platform_has_symlinks();
    ++#ifndef NO_NSEC
     +	cfg->use_nanosec = 0;
    ++#endif
      
      	/* section "sparse" config values */
      	cfg->sparse_expect_files_outside_of_patterns = 0;
    @@ read-cache.c: static int ce_match_stat_basic(const struct cache_entry *ce, struc
      static int is_racy_stat(const struct index_state *istate,
      			const struct stat_data *sd)
      {
    ++#ifndef NO_NSEC
     +	int use_nsec = repo_config_values(istate->repo)->use_nanosec;
    ++#endif
     +
      	return (istate->timestamp.sec &&
     -#ifdef USE_NSEC
    @@ read-cache.c: static int ce_match_stat_basic(const struct cache_entry *ce, struc
     -		(istate->timestamp.sec < sd->sd_mtime.sec ||
     -		 (istate->timestamp.sec == sd->sd_mtime.sec &&
     -		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
    --#else
    --		istate->timestamp.sec <= sd->sd_mtime.sec
    --#endif
    ++#ifndef NO_NSEC
     +		/* nanosecond timestamped files can also be racy! */
     +		use_nsec
     +		? (istate->timestamp.sec < sd->sd_mtime.sec ||
     +		   (istate->timestamp.sec == sd->sd_mtime.sec &&
     +		    istate->timestamp.nsec <= sd->sd_mtime.nsec))
     +		: istate->timestamp.sec <= sd->sd_mtime.sec
    - 		);
    - }
    - 
    + #else
    + 		istate->timestamp.sec <= sd->sd_mtime.sec
    + #endif
     
      ## statinfo.c ##
     @@ statinfo.c: int match_stat_data(const struct stat_data *sd, struct stat *st)
    @@ statinfo.c: int match_stat_data(const struct stat_data *sd, struct stat *st)
     -	if (cfg->trust_ctime && cfg->check_stat &&
     -	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
     -		changed |= CTIME_CHANGED;
    --#endif
    ++#ifndef NO_NSEC
     +	if (cfg->use_nanosec) {
     +		if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
     +			changed |= MTIME_CHANGED;
    @@ statinfo.c: int match_stat_data(const struct stat_data *sd, struct stat *st)
     +		    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
     +			changed |= CTIME_CHANGED;
     +	}
    + #endif
      
      	if (cfg->check_stat) {
    - 		if (sd->sd_uid != (unsigned int) st->st_uid ||

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.860.g4b6b3295ed.dirty

