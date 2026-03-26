Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72708401A12
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538099; cv=none; b=F71KJrRk2KSr5/ifHJB2Bs8I8Ov6kRvM86aN/VIV3ukXTzKbjIMOBsPX/jtlrwxhVw2JW0alh6IdtuiSLB9EvxchpWJuBeMVJPD7+3J+V5tJ0hKq23fwHWC4JTpVPILFxlaqva3Dhss6CboIi0yfvd9i88BDfTlCcFL6Qh9SoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538099; c=relaxed/simple;
	bh=4I/26K96YHq6JuC24wdKxCUFWECblLCAs/4DHC0EmIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=buBKJTOAXZG+vA3q4889ON4YULce1/cLFQNY0igRkt48FNen4V2c9/YanzxsUQZ0zlLDpw5+kL6X11/S3s9KuCsE4yQ/5GjT5LsZ52s32c7WhzkWN3bAHF0FjKPNO8MV9QD40F8UXAvMnu3B/hCTfiwnm1FdLOefeO2lKiYTUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4JQwFjX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4JQwFjX"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89cc638496aso10459376d6.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538096; x=1775142896; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLYX6/bAm3/FzrZu57I1+sWOK1E7barZNFv2ixqjbho=;
        b=a4JQwFjXRdrlkYX7hMHncsOJ0Mgq0OsllGkU7zhtqSYzQiTvujT/N1L/W/D0pRVNLL
         9uObeTBjPV1xyop30KEx9q2M0PIRdXqBvp2EjaUHMZKHzZsb230hV9nx+XqO6hW8Qwg0
         /5RgoaPoB5zWsgwa/Ln55/lIdeU9ZNws5SUsURLOMawxULS1DWzWl8kmMtWe0tH7GPjD
         0D5qwWQ88umT7F7xWravqYI+71qsuFUqQKFyd/8aJpVMSVPEyP4CNIQxp9xfDI18HAx6
         WyY2l2AxZ+llOhzTCK5HEPQT69ChUdiXdegpfh+SQNxYKQ8ea+/o9HxNSqflJblXxLc6
         qJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538096; x=1775142896;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLYX6/bAm3/FzrZu57I1+sWOK1E7barZNFv2ixqjbho=;
        b=LORkQ09JP+fMMQZbzdzSa3ruCdafrsa/xNkUcGrhxbpSeThrH5WnTi8OCVe+8uAOnb
         cvl+5jnZx9j9RSCOy49RlZEYVeg2/pr9thDhhNLDF+FpV2fLmnUblmMERWpCO1wyJNH+
         9pA9xE8cobmRkio4mobvV/OFc7tYKg3iKnHiAiACBbWrDmXRk/CrMj+dV5KaVX98sxOc
         xZTXFhZeOerPdGjmLGnFE7s8pqLQAiaUp6QaUbtxX3Yvxy2IQ0uG+3ptcL42SeDIFKxQ
         N9AfoXvDt1b7EVNXgCxl2N/t7IWt1E+wKaADArIfRkXikW8e0uKWsFT26aUUFZY3uQqj
         DiqA==
X-Gm-Message-State: AOJu0Yx5VRD6DTvWusTbpFHKXXFYBCAIb4ukbRzNkyk7s+4JtGHjV4DW
	Z4eQpJfknCgC9pxciY9hucN4ic+COF0CjMVOTvbLBxehcxn9wUOiKmQkcg8TOQ==
X-Gm-Gg: ATEYQzy4Ip1CWQwuqtzNgcYo40mBmIc367eNMJ89rR5QImvJnWgiaj2IiNHl+SkP76L
	8zsTPzEE7Iv45q/6DM35gyAQbwFgQ6up6J/IWSOOS1G9pJe/XO1L6joRiwIrGuPP6++0IB9o5dj
	VTF79Exl+PigL44yU6+4QYIqHoWqhWHolB/U0XAcQkCLDCBAd2NsKoNx188JjLk3pYBl22Ls5RU
	PYxYZsX9qG6jk+Rb1qd4BGCXiTuV9nS4NcyTZNMqCXA4IzLmMmTcD4jWNf3vEdGONWI/UDnTrGj
	+rYbOYMnqRGyT+AJXUqJtL6NUCnKtSB25JPe1F2YsbPfXHt2TH2UU/C6LOC7IqfXbMloRUuuQq1
	7V4BCpy9nwzjHzIvrRNlG/pA/7mD0CHEiwQwHIG2xokm2+6slO8jBNyauuqDAXY5QI9l14vlBta
	q1CYPcTPlb/5ZvZNEavWrU3h5jKaaOkKkEmpWY
X-Received: by 2002:a05:6214:ac2:b0:89c:ba96:5fd7 with SMTP id 6a1803df08f44-89cc4b63128mr118305056d6.53.1774538095854;
        Thu, 26 Mar 2026 08:14:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a6a840sm26334526d6.36.2026.03.26.08.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:14:55 -0700 (PDT)
Message-Id: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 15:14:48 +0000
Subject: [PATCH v3 0/6] backfill: accept revision arguments
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
Cc: gitster@pobox.com,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

The git backfill command assists in downloading missing blobs for blobless
partial clones. However, its current version lacks some valuable
functionality. It currently:

 1. Only walks commits reachable from HEAD.
 2. It walks all reachable commits to the full history.
 3. It can focus on the current sparse-checkout definition, but otherwise it
    doesn't focus on a given pathspec.

All of these are being updated by this patch series, which allows rev-list
options to impact the path-walk. These include:

 1. Specifying a given refspec, including --all.
 2. Modifying the commit walk, including --first-parent, commit ranges, or
    recency using --since.
 3. Modifying the set of paths to download using pathspecs.

One particularly valuable situation here is that now a user can run git
backfill -- <path> to download all versions of a specific file or a specific
directory, accelerating history queries within that path without downloading
more than necessary. This can accelerate git blame or git log -L for these
paths, where normally those commands download missing blobs one-by-one
during its diff algorithms.

This patch series is organized in the following way:

 1. A missing #include is added to prevent future compilation issues.
 2. The test repo in t5620 is expanded to make later tests more interesting.
 3. The backfill builtin parses the rev-list arguments. We test the top
    arguments that work as expected, though the pathspec arguments need
    extra work.
 4. Update the path-walk logic to work efficiently with some pathspecs, such
    as fixed prefix pathspecs, accelerating the computation.
 5. For more complicated pathspecs, do a post-filter in builtin/backfill.c
    instead of restricting the walk in the path-walk API.

The main goal of this series is to make such customizations possible, and to
improve performance where common use cases are expected. I'm open to
feedback as to whether we should consider more detailed performance analysis
or whether we should wait for how users interact with these new options
before overoptimizing unlikely use cases.


Updates in v2
=============

 * Hard stops are replaced with a comma (and no punctuation) in the docs.
 * add_head_to_pending() simplifies some code.
 * My poor explanation of "starting commits" is updated.
 * Language around temporary prefix restriction is clarified.
 * Prefix match logic is simplified with dir_prefix().
 * Temporary memory leak (introduced in v1's patch 4 and removed in v1's
   patch 5) is removed in v2's patch 4.
 * Commit pruning is reenabled in v2's patch 5. There was no need for that
   with the way the logic works in the patch.
 * Add a new patch with a test demonstrating the new behavior that was being
   discussed in [1].

[1]
https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/


Updates in v3
=============

 * Fixed the argument checks to actually catch unknown arguments, because
   the revision machinery will skip unknown options starting with --.

Thanks, -Stolee

Derrick Stolee (6):
  revision: include object-name.h
  t5620: prepare branched repo for revision tests
  backfill: accept revision arguments
  backfill: work with prefix pathspecs
  path-walk: support wildcard pathspecs for blob filtering
  t5620: test backfill's unknown argument handling

 Documentation/git-backfill.adoc |   5 +-
 builtin/backfill.c              |  22 +++-
 path-walk.c                     |  43 +++++++
 path.c                          |   2 +-
 path.h                          |   6 +
 revision.h                      |   1 +
 t/t5620-backfill.sh             | 211 +++++++++++++++++++++++++++++++-
 7 files changed, 280 insertions(+), 10 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2070%2Fderrickstolee%2Fbackfill-revs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2070/derrickstolee/backfill-revs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2070

Range-diff vs v2:

 1:  fda0239103 = 1:  fda0239103 revision: include object-name.h
 2:  55a45b2fc8 = 2:  55a45b2fc8 t5620: prepare branched repo for revision tests
 3:  610a162973 = 3:  610a162973 backfill: accept revision arguments
 4:  f8f2c61326 ! 4:  7223124fb3 backfill: work with prefix pathspecs
     @@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
      +		if (ctx->revs->prune_data.nr) {
      +			struct pathspec *pd = &ctx->revs->prune_data;
      +			bool found = false;
     ++			int did_strip_suffix = strbuf_strip_suffix(&path, "/");
      +
     -+			/* remove '/' for these checks. */
     -+			path.buf[path.len - 1] = 0;
      +
      +			for (int i = 0; i < pd->nr; i++) {
      +				struct pathspec_item *item = &pd->items[i];
     @@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
      +				}
      +			}
      +
     -+			/* return '/' after these checks. */
     -+			path.buf[path.len - 1] = '/';
     ++			if (did_strip_suffix)
     ++				strbuf_addch(&path, '/');
      +
      +			/* Skip paths that do not match the prefix. */
      +			if (!found)
 5:  1168edfb96 ! 5:  1ea278bd10 path-walk: support wildcard pathspecs for blob filtering
     @@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
      +		if (ctx->revs->prune_data.nr && ctx->exact_pathspecs) {
       			struct pathspec *pd = &ctx->revs->prune_data;
       			bool found = false;
     - 
     + 			int did_strip_suffix = strbuf_strip_suffix(&path, "/");
      @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
       			return 0;
       	}
 6:  9699650aa7 ! 6:  b6423f9595 t5620: test backfill's unknown argument handling
     @@ Commit message
      
          Before the recent changes to parse rev-list arguments inside of 'git
          backfill', the builtin would take arbitrary arguments without complaint (and
     -    ignore them). This was noticed and a patch was sent [1] which motivates this
     -    change to encode this behavior in test.
     +    ignore them). This was noticed and a patch was sent [1] which motivates
     +    this change.
      
          [1] https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/
      
     +    Note that the revision machinery can output an "ambiguous argument"
     +    warning if a value not starting with '--' is found and doesn't make
     +    sense as a reference or a pathspec. For unrecognized arguments starting
     +    with '--' we need to add logic into builtin/backfill.c to catch leftover
     +    arguments.
     +
          Reported-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## builtin/backfill.c ##
     +@@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
     + 	repo_init_revisions(repo, &ctx.revs, prefix);
     + 	argc = setup_revisions(argc, argv, &ctx.revs, NULL);
     + 
     ++	if (argc > 1)
     ++		die(_("unrecognized argument: %s"), argv[1]);
     ++
     + 	repo_config(repo, git_default_config, NULL);
     + 
     + 	if (ctx.sparse < 0)
     +
       ## t/t5620-backfill.sh ##
      @@ t/t5620-backfill.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
     @@ t/t5620-backfill.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +	test_must_fail git backfill unexpected-arg 2>err &&
      +	test_grep "ambiguous argument .*unexpected-arg" err &&
      +
     -+	test_must_fail git backfill --all --firt-parent unexpected-arg 2>err &&
     -+	test_grep "ambiguous argument .*unexpected-arg" err
     ++	test_must_fail git backfill --all --unexpected-arg --first-parent 2>err &&
     ++	test_grep "unrecognized argument: --unexpected-arg" err
      +'
      +
       # We create objects in the 'src' repo.

-- 
gitgitgadget
