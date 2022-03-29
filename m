Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189ECC433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 11:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiC2L1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiC2L1W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 07:27:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89A1AD395
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:25:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r7so10076411wmq.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aISJyg7tlxr45T/VQKYjKkYgnM3P9nM2LFRivrnIReY=;
        b=huxhM7FqC771e5nhJxSePvEqaVCLVZFjER5GGc9eBYx6inAAOduBk6WUlNSCh+BaZS
         jsCgevgQ7j60qc+Z544uToUeICm7QEn3oMWLSfASzRTP4q+BtZYYd8sYKHulgUv+wmoB
         Pku8pSy9mMBhAKdnKDRwbAnuGkWbOERyU6t/TklHuxdwCS45EeADHjSmwa96jPG0i+wm
         1YWldexGs/jjQG8qy0+adIO9iIyjPvjEUkxDjzv6cJmvR2/2QdA7h/p7qJmk8ISipUvc
         FBWBZOUwvMetus5CBeBOrQbrGle3nz71D6r5gsgLrEo+11D2Ub2hN1dw07OnRVH+QI1e
         EqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aISJyg7tlxr45T/VQKYjKkYgnM3P9nM2LFRivrnIReY=;
        b=wjA8oE9Gx5mn589lnQ3//tnj8ZS+WWW7U/jOBOfbbtBBJVkHXhcJF5/io++3hBqMdm
         ZIhR5jB0nbkxAyA2g863gFbizRHmBqEHa6+pvOLIw212QLYMTt9uoN6AcU7Bp/1lgk1S
         84QotSjfJjsjiXLgHOfp69wcjYME4xykEwr/f0c/YU4ad7LXV0tcuEzID6c2QqmV192d
         R4u3Uqp/UGAkI81J+yhxE0agltMx2DvHdjQOD3QOzQ92U2lJQHaMQ6dTXJ8ij666Hh5D
         b8SxFpYXU5t52kdWGsZn0xyMIgdEc89I38yMzTt9HT4vmOuzaihZhJo+V9+KkmAXC9xV
         e4/w==
X-Gm-Message-State: AOAM531VMDr/4ojELHb5TeoBG740H+zobtiYIk9yF4YMSx0Ec5RBZzgm
        BoPPZ6hmXdOCxusJFK2rQ2apKIbuE8I=
X-Google-Smtp-Source: ABdhPJyaC6CUXnP4G+xAzW/4ubtZajYWki66R8R3+589atdymCw/2EGNHhta164sIgqgi/35eWYP5A==
X-Received: by 2002:a05:600c:4608:b0:38c:6ba3:1c9f with SMTP id m8-20020a05600c460800b0038c6ba31c9fmr6372957wmo.39.1648553137896;
        Tue, 29 Mar 2022 04:25:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b00203f51aa12asm14556604wrq.55.2022.03.29.04.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:25:37 -0700 (PDT)
Message-Id: <f60d2c6e36c3218f9b19d7ce62a090d7d6e0e7f6.1648553134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
        <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 11:25:34 +0000
Subject: [PATCH v5 2/2] untracked-cache: support '--untracked-files=all' if
 configured
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Untracked cache was originally designed to only work with
'--untracked-files=normal', but this causes performance issues for UI
tooling that wants to see "all" on a frequent basis. On the other hand,
the conditions that prevented applicability to the "all" mode no
longer seem to apply.

The disqualification of untracked cache has a particularly significant
impact on Windows with the defaulted fscache, where the introduction
of fsmonitor can make the first and costly directory-iteration happen
in untracked file detection, single-threaded, rather than in
preload-index on multiple threads. Improving the performance of a
"normal" 'git status' run with fsmonitor can make
'git status --untracked-files=all' perform much worse.

To partially address this, align the supported directory flags for the
stored untracked cache data with the git config. If a user specifies
an '--untracked-files=' commandline parameter that does not align with
their 'status.showuntrackedfiles' config value, then the untracked
cache will be ignored - as it is for other unsupported situations like
when a pathspec is specified.

If the previously stored flags no longer match the current
configuration, but the currently-applicable flags do match the current
configuration, then discard the previously stored untracked cache
data.

For most users there will be no change in behavior. Users who need
'--untracked-files=all' to perform well will now have the option of
setting "status.showuntrackedfiles" to "all" for better / more
consistent performance.

Users who need '--untracked-files=all' to perform well for their
tooling AND prefer to avoid the verbosity of "all" when running
git status explicitly without options... are out of luck for now (no
change).

Users who have the "status.showuntrackedfiles" config set to "all"
and yet frequently explicitly call
'git status --untracked-files=normal' (and use the untracked cache)
are the only ones who will be disadvantaged by this change. Their
"--untracked-files=normal" calls will, after this change, no longer
use the untracked cache.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 dir.c                             | 85 ++++++++++++++++++++++++-------
 t/t7063-status-untracked-cache.sh | 78 ++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index f2b0f242101..c5b513ddd2a 100644
--- a/dir.c
+++ b/dir.c
@@ -2747,13 +2747,33 @@ static void set_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
-static void new_untracked_cache(struct index_state *istate)
+static unsigned new_untracked_cache_flags(struct index_state *istate)
+{
+	struct repository *repo = istate->repo;
+	char *val;
+
+	/*
+	 * This logic is coordinated with the setting of these flags in
+	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
+	 * of the config setting in commit.c#git_status_config()
+	 */
+	if (!repo_config_get_string(repo, "status.showuntrackedfiles", &val) &&
+	    !strcmp(val, "all"))
+		return 0;
+
+	/*
+	 * The default, if "all" is not set, is "normal" - leading us here.
+	 * If the value is "none" then it really doesn't matter.
+	 */
+	return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+}
+
+static void new_untracked_cache(struct index_state *istate, int flags)
 {
 	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, 100);
 	uc->exclude_per_dir = ".gitignore";
-	/* should be the same flags used by git-status */
-	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	uc->dir_flags = flags >= 0 ? flags : new_untracked_cache_flags(istate);
 	set_untracked_ident(uc);
 	istate->untracked = uc;
 	istate->cache_changed |= UNTRACKED_CHANGED;
@@ -2762,11 +2782,11 @@ static void new_untracked_cache(struct index_state *istate)
 void add_untracked_cache(struct index_state *istate)
 {
 	if (!istate->untracked) {
-		new_untracked_cache(istate);
+		new_untracked_cache(istate, -1);
 	} else {
 		if (!ident_in_untracked(istate->untracked)) {
 			free_untracked_cache(istate->untracked);
-			new_untracked_cache(istate);
+			new_untracked_cache(istate, -1);
 		}
 	}
 }
@@ -2781,9 +2801,9 @@ void remove_untracked_cache(struct index_state *istate)
 }
 
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
-						      int base_len,
-						      const struct pathspec *pathspec,
-						      struct index_state *istate)
+							    int base_len,
+							    const struct pathspec *pathspec,
+							    struct index_state *istate)
 {
 	struct untracked_cache_dir *root;
 	static int untracked_cache_disabled = -1;
@@ -2814,17 +2834,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (base_len || (pathspec && pathspec->nr))
 		return NULL;
 
-	/* Different set of flags may produce different results */
-	if (dir->flags != dir->untracked->dir_flags ||
-	    /*
-	     * See treat_directory(), case index_nonexistent. Without
-	     * this flag, we may need to also cache .git file content
-	     * for the resolve_gitlink_ref() call, which we don't.
-	     */
-	    !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||
-	    /* We don't support collecting ignore files */
-	    (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
-			   DIR_COLLECT_IGNORED)))
+	/* We don't support collecting ignore files */
+	if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
+			DIR_COLLECT_IGNORED))
 		return NULL;
 
 	/*
@@ -2847,6 +2859,41 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
+	/*
+	 * We don't support using or preparing the untracked cache if
+	 * the current effective flags don't match the configured
+	 * flags.
+	 */
+	if (dir->flags != new_untracked_cache_flags(istate))
+		return NULL;
+
+	/*
+	 * If the untracked structure we received does not have the same flags
+	 * as configured, but the configured flags do match the effective flags,
+	 * then we need to reset / create a new "untracked" structure to match
+	 * the new config.
+	 * Keeping the saved and used untracked cache in-line with the
+	 * configuration provides an opportunity for frequent users of
+	 * "git status -uall" to leverage the untracked cache by aligning their
+	 * configuration (setting "status.showuntrackedfiles" to "all" or
+	 * "normal" as appropriate), where previously this option was
+	 * incompatible with untracked cache and *consistently* caused
+	 * surprisingly bad performance (with fscache and fsmonitor enabled) on
+	 * Windows.
+	 *
+	 * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
+	 * to not be as bound up with the desired output in a given run,
+	 * and instead iterated through and stored enough information to
+	 * correctly serve both "modes", then users could get peak performance
+	 * with or without '-uall' regardless of their
+	 * "status.showuntrackedfiles" config.
+	 */
+	if (dir->flags != dir->untracked->dir_flags) {
+		free_untracked_cache(istate->untracked);
+		new_untracked_cache(istate, dir->flags);
+		dir->untracked = istate->untracked;
+	}
+
 	if (!dir->untracked->root) {
 		/* Untracked cache existed but is not initialized; fix that */
 		FLEX_ALLOC_STR(dir->untracked->root, name, "");
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index c44b70b96e4..b52fd937156 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -220,6 +220,84 @@ test_expect_success 'untracked cache remains after bypass' '
 	test_cmp ../dump.expect ../actual
 '
 
+test_expect_success 'if -uall is configured, untracked cache gets populated by default' '
+	test_config status.showuntrackedfiles all &&
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
+	test_cmp ../status_uall.expect ../status.iuc &&
+	test_cmp ../status_uall.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
+	cat >../trace.expect <<EOF &&
+ ....path:
+ ....node-creation:3
+ ....gitignore-invalidation:1
+ ....directory-invalidation:0
+ ....opendir:4
+EOF
+	test_cmp ../trace.expect ../trace.relevant
+'
+
+cat >../dump_uall.expect <<EOF &&
+info/exclude $EMPTY_BLOB
+core.excludesfile $ZERO_OID
+exclude_per_dir .gitignore
+flags 00000000
+/ $ZERO_OID recurse valid
+three
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse valid
+three
+/dtwo/ $ZERO_OID recurse valid
+two
+EOF
+
+test_expect_success 'if -uall was configured, untracked cache is populated' '
+	test-tool dump-untracked-cache >../actual &&
+	test_cmp ../dump_uall.expect ../actual
+'
+
+test_expect_success 'if -uall is configured, untracked cache is used by default' '
+	test_config status.showuntrackedfiles all &&
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+	git status --porcelain >../actual &&
+	iuc status --porcelain >../status.iuc &&
+	test_cmp ../status_uall.expect ../status.iuc &&
+	test_cmp ../status_uall.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
+	cat >../trace.expect <<EOF &&
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:0
+EOF
+	test_cmp ../trace.expect ../trace.relevant
+'
+
+# Bypassing the untracked cache here is not desirable, but it expected
+# in the current implementation
+test_expect_success 'if -uall is configured, untracked cache is bypassed with -unormal' '
+	test_config status.showuntrackedfiles all &&
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+	git status -unormal --porcelain >../actual &&
+	iuc status -unormal --porcelain >../status.iuc &&
+	test_cmp ../status.expect ../status.iuc &&
+	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
+	cat >../trace.expect <<EOF &&
+ ....path:
+EOF
+	test_cmp ../trace.expect ../trace.relevant
+'
+
+test_expect_success 'repopulate untracked cache for -unormal' '
+	git status --porcelain
+'
+
 test_expect_success 'modify in root directory, one dir invalidation' '
 	: >four &&
 	test-tool chmtime =-240 four &&
-- 
gitgitgadget
