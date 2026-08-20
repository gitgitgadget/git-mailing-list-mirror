Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CC446BF1
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231915; cv=none; b=iaIScRMCt7a1y56VeBnkNJ/qjMcf5kaa74Txu39HdoM0NzjKBKEp4aWsuU61OHAd9x6x8wZHqBq503hQcXlQjk2jQ7M2QJX+H/SKuyerLRAc8ncQ85V29CcnxF3NP78ugy/Et7fS7utVcjAg9q9EpEarU4nZVvr+G86lh1VA4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231915; c=relaxed/simple;
	bh=eEdcobM25l72014I9weTszAetMPT+IgATUn/LE0uWuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6FOIlUCElTz95XlGw8xSjUivMiJ7WYItmNDTrbrmeWo2+Y+ehTA1q96jqcd/sc8Hedro/rf5OfP/KX66RO5+kzPU8gGbtACrh6Kd0LGX+emke7UTr6fDogoRp89iWQMMFkFF3KQZPovgXvqOGR3c4aKJyB5FJEpfTMBBAhfJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejml5paL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejml5paL"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836cda225c1so31468417b3.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231913; x=1787836713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m1rngUSmYGqq7F79X3k+MmvHbg8dTZbE8BTfndYo7fc=;
        b=Ejml5paLd8fne9FVrokRSP6dXJ3/zacbDKcAItC4Vx5C+BVgAKoOFQTrbQrTPkuLgn
         uBh4JoQDYh0WfD1llqxALANF7ZMtqEthXArPiBEUxPsdICmYOo0Gpb8fHDCn0riS4bEv
         uUIfdSwSyI4X9e2fDWq8n2XrjBIcC1J4pdzQRsWQk33pBcCAH6MGSB2TJqPkp9jBZs5X
         7j9wdDIuC8jpvsPFivRHOJalJGatvQaytXFHjBw7BD9NZkyk/6GMtH4ci98EZLXe5bAH
         AsKLxkPKYGZH4revQvr4sljmt99pPbI4wjCTKWDOM5ybUq2eUByi9ceaqFOqI3SPhg1W
         mZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231913; x=1787836713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1rngUSmYGqq7F79X3k+MmvHbg8dTZbE8BTfndYo7fc=;
        b=rER4tuXIEBeIaVVpLAAvoO6MubtsIN6+Y2iB2GyvTWnqhWCOng4jK0cXtbLluu3ABP
         XT+mS3GoBAK4J/S47PDhWS4BXg+OXzBv1kg4kjYr/X5UpYP7Ch6v8N1bhJkw9gxcXAM0
         7wr3HtIIGHxGKXiqvWQWU4XHtGtnqh4m7Pb7+ASBU5uDzLpxSBArE18Rt+2wCl74NxJM
         bzbF82IDUWxcUXnm5lda0QgvaXWsDjRrTCOLnhI5FGZr2NhGEPr5I+UKTxqnLJcvYxVO
         puBecc6MrIQsxb56r9kOVAwVz0qYu37nVSt424kaPsAf5I50Bic21+TeF4iBqgN56+Bs
         nf8w==
X-Gm-Message-State: AFuF++lKEHyxEtqWMhVjUGnNA72EMK/KCq7d+6v8Vg6+wox1hhVV3lUP
	xqth9lHM09Rgc5c8+51mMD8IEP7XFEM9ppTvIi55c9AEGpFg2RBufovwtRtTyrNTuI8=
X-Gm-Gg: AR+sD10v0U+/EvpB/P6v11kUTjNtcUWz0cO/AeQXeBm1E1k7m9VMX3MqYIVgyGJLZTR
	FRwjw+9JKmijL7Pb+lMjg4/CjQ3gD1m5FY3Uw/8ZFn8WsH8hS9WXUDkolSNKVCDr5lpBye5MJoe
	DYGdiGzrpBB9eqO+CbWgaMAiyRj1jcABf4gTh+/hgfQGk2ulmlKX+V+t96TNk2V1ru1wclOaOWP
	hJd7UQnh/1xHYVRItNwUJ6puJ03n91KyUC0npIp+MHhVH9H6xcXHwKrS0oYLRWDN+mba1Zn9W1U
	RoaIvgGVDauFT4irOLfervzrAPdc1+FGY8jfUfoEudwXvSfI0mOOVjxignBBwh4LlnLL1Q1sZ2g
	f3WwRtxD0cONqMvN3QfGuyWVg0ZD+IpL0LGuSgtFsNtIqI8vcTy6mJVa2oEtFiw2GADuQvt25tM
	HBqOqaPt+sk9iMmXp1GoXAYlcAQZ07RPSlYj8DsV9z0VW6hGbJ2kl21X7Ks55BygX22WpE20Wag
	a4n3hMDKN+YwLjHC7rLlIZCyN2TGM+iNP1sCEZv/et22n97YMlNgMJ//7TUkRbZ3oeUiJqYJl8S
	geQLnibiInc=
X-Received: by 2002:a05:690c:3612:b0:81d:d38c:56b5 with SMTP id 00721157ae682-844df63d1b9mr57033837b3.4.1787231912594;
        Thu, 20 Aug 2026 06:18:32 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-847ccd8b6cbsm8021807b3.27.2026.08.20.06.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:18:31 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v4 0/3] Convert USE_NSEC to runtime config
Date: Thu, 20 Aug 2026 09:18:06 -0400
Message-ID: <cover.1787231825.git.ben.knoble@gmail.com>
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

Changes in v4:

- fix message typo
- change #ifdef strategy: only ignore the config variable.
  Otherwise, use the use_nanosec member unconditionally. Also clarify
  that config might be ignore depending on build options in the docs.
- mention potential platform unsafety directly in config doc in
  addition to the link to Racy Git

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
v3: <cover.1787065125.git.ben.knoble@gmail.com>

[1/3] meson: expose knob for xmlto relative links in manuals
[2/3] environment: align repo_config_values_init with struct declaration
[3/3] core: convert build-time USE_NSEC into runtime core.useNanosec

 Documentation/config/core.adoc        |  7 +++++++
 Documentation/meson.build             |  7 ++++++-
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         | 27 ++++++++++++++++++++-------
 environment.h                         |  1 +
 meson_options.txt                     |  2 ++
 read-cache.c                          | 15 ++++++---------
 statinfo.c                            | 14 +++++++-------
 12 files changed, 57 insertions(+), 48 deletions(-)

Diff-intervalle contre v3 :
1:  d612de6c2d = 1:  d612de6c2d meson: expose knob for xmlto relative links in manuals
2:  5693baa992 = 2:  5693baa992 environment: align repo_config_values_init with struct declaration
3:  48fceb4b57 ! 3:  0aa0e9fc17 core: convert build-time USE_NSEC into runtime core.useNanosec
    @@ Commit message
         performance of commands like "git diff" in new worktrees [1]. We have
         long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
         precision when available, which mitigates most if not all racy issues,
    -    but most builds we know about it don't use it. In part, that's because
    +    but most builds we know about don't use it. In part, that's because
         someone distributing Git can't safely enable it at compile-time if they
         don't know exactly what platforms their distribution will be used on.
     
    @@ Commit message
     
      ## Notes (benknoble/commits) ##
         Related benchmarks: <https://lore.kernel.org/git/CALnO6CBm4g27mWBvD9m6yL0e5YZu3M9_zcUeLZk7QwTgnxMLQA@mail.gmail.com/>
    -    CI: <https://github.com/benknoble/git/actions/runs/32137191115>
    -
    -    v3:
    -        We could perhaps be cute in read-cache.c:is_racy_stat() by writing
    -        the preprocessor directive like
    -
    -    		return (istate->timestamp.sec &&
    -    	#ifndef NO_NSEC
    -    			/* nanosecond timestamped files can also be racy! */
    -    			use_nsec
    -    			? (istate->timestamp.sec < sd->sd_mtime.sec ||
    -    			   (istate->timestamp.sec == sd->sd_mtime.sec &&
    -    			    istate->timestamp.nsec <= sd->sd_mtime.nsec))
    -    			:
    -    	#endif
    -    			istate->timestamp.sec <= sd->sd_mtime.sec
    -
    -        but that seemed maybe too clever?
    +    CI: <https://github.com/benknoble/git/actions/runs/32365602564>
     
      ## Documentation/config/core.adoc ##
     @@ Documentation/config/core.adoc: core.trustctime::
    @@ Documentation/config/core.adoc: core.trustctime::
     +core.useNanosec::
     +	If true, use nanosecond precision for ctime and mtime
     +	comparisions between the index and the working tree (if Git
    -+	was compiled to store it).
    -+	See link:technical/racy-git.html[Racy Git]. False by default.
    ++	was compiled to respect this option).
    ++	This is unsafe on some platforms;
    ++	see link:technical/racy-git.html[Racy Git]. False by default.
     +
      core.splitIndex::
      	If true, the split-index feature of the index will be used.
    @@ environment.c: void repo_config_values_init(struct repo_config_values *cfg)
      	cfg->ignore_case = 0;
      	cfg->trust_executable_bit = 1;
      	cfg->has_symlinks = platform_has_symlinks();
    -+#ifndef NO_NSEC
     +	cfg->use_nanosec = 0;
    -+#endif
      
      	/* section "sparse" config values */
      	cfg->sparse_expect_files_outside_of_patterns = 0;
    @@ environment.h: struct repo_config_values {
      	int sparse_expect_files_outside_of_patterns;
     
      ## read-cache.c ##
    -@@ read-cache.c: static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
    - static int is_racy_stat(const struct index_state *istate,
    +@@ read-cache.c: static int is_racy_stat(const struct index_state *istate,
      			const struct stat_data *sd)
      {
    -+#ifndef NO_NSEC
    -+	int use_nsec = repo_config_values(istate->repo)->use_nanosec;
    -+#endif
    -+
      	return (istate->timestamp.sec &&
     -#ifdef USE_NSEC
     -		 /* nanosecond timestamped files can also be racy! */
     -		(istate->timestamp.sec < sd->sd_mtime.sec ||
     -		 (istate->timestamp.sec == sd->sd_mtime.sec &&
     -		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
    -+#ifndef NO_NSEC
    +-#else
    +-		istate->timestamp.sec <= sd->sd_mtime.sec
    +-#endif
    +-		);
     +		/* nanosecond timestamped files can also be racy! */
    -+		use_nsec
    -+		? (istate->timestamp.sec < sd->sd_mtime.sec ||
    -+		   (istate->timestamp.sec == sd->sd_mtime.sec &&
    -+		    istate->timestamp.nsec <= sd->sd_mtime.nsec))
    -+		: istate->timestamp.sec <= sd->sd_mtime.sec
    - #else
    - 		istate->timestamp.sec <= sd->sd_mtime.sec
    - #endif
    ++		(repo_config_values(istate->repo)->use_nanosec
    ++		 ? (istate->timestamp.sec < sd->sd_mtime.sec ||
    ++		    (istate->timestamp.sec == sd->sd_mtime.sec &&
    ++		     istate->timestamp.nsec <= sd->sd_mtime.nsec))
    ++		 : istate->timestamp.sec <= sd->sd_mtime.sec));
    + }
    + 
    + int is_racy_timestamp(const struct index_state *istate,
     
      ## statinfo.c ##
     @@ statinfo.c: int match_stat_data(const struct stat_data *sd, struct stat *st)
    @@ statinfo.c: int match_stat_data(const struct stat_data *sd, struct stat *st)
     -	if (cfg->trust_ctime && cfg->check_stat &&
     -	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
     -		changed |= CTIME_CHANGED;
    -+#ifndef NO_NSEC
    +-#endif
     +	if (cfg->use_nanosec) {
     +		if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
     +			changed |= MTIME_CHANGED;
    @@ statinfo.c: int match_stat_data(const struct stat_data *sd, struct stat *st)
     +		    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
     +			changed |= CTIME_CHANGED;
     +	}
    - #endif
      
      	if (cfg->check_stat) {
    + 		if (sd->sd_uid != (unsigned int) st->st_uid ||

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.860.g4b6b3295ed.dirty

