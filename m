Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D549C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiCaQEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbiCaQEI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921501B695A
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:02:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c7so523788wrd.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Z1EOdtXRofhe1+kWqEbQ3vv6+3YSUaNxtLziCJ/kDw=;
        b=E5rWe4VqrtsPxfqKOpGHkhNpl4mp9AnQabl0129aOUH9atDzye2nMr75yjzE63v4AW
         M9FvN9wHbv23sTOZSr5jWOgBYGsExmusUlVYE92AAh71QhAWwvxe2a080D2eLZexUoft
         MCMOcBIXPvFr0HpM+14H6LW0TQReYtO/O7osYhi+H1M4F/PBFaaEi9oRVOwXLRHKnk04
         99egW3o+kEB4kbHBBC5TbfFLh6mfTsorVdyJvSA1zweqWACQCh9ok8qjX93+f3PGT2fO
         VVrdWVI1Ku3Xkrs585dgn/urPG3DRdh0dJXXWfXg1SyiQ4yG1syutAJrZ7Si8SmoEcF2
         ooOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Z1EOdtXRofhe1+kWqEbQ3vv6+3YSUaNxtLziCJ/kDw=;
        b=ZCLaHJ4cGkxF4hptmKbIbEeI7V49TpU5GbgEHWOIPYxs/Kt6jv2TATVUPZf9mk0rJA
         RiC4Uc1/8Tc80J7RSR7/wwCGvHZRb/iqWdMARBxUn19peK+jkzGe0MoNnyMgTKSFzBUV
         HevennQpm3AdfX0YD0jicRgQxTKNt2AqfiUYGw4YHlCq4Xk5/yZEsHRdfSR41tRWXUMC
         VHJfZPGwYO9f+gV4/FRe1SzDoOlDYEQkB2DxR7pPa0CxDKngdmx9V393u1symJB17PJh
         tzEycT7BrRnzC5Jd+xpQi5wRzaUl+XA4zLXlYJqkyrOzDEE0lB6S+q3BexMv2xPSqomx
         6cOw==
X-Gm-Message-State: AOAM5326sEy3STare9beUvw3AStdSXjrIkdfxuda8uWywT+tawTaL+yc
        G78HYGb20us/sUwDupI+XlNv7R7oaLs=
X-Google-Smtp-Source: ABdhPJyRiO63vvmp25ewoefFrRcMQoUazA+CvbbcVJ99qNErh9RfxGg+uK3AMN8hlBhoa2CBAKLuZA==
X-Received: by 2002:a5d:5690:0:b0:203:f727:362 with SMTP id f16-20020a5d5690000000b00203f7270362mr4746508wrv.717.1648742538692;
        Thu, 31 Mar 2022 09:02:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm7929346wme.39.2022.03.31.09.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:02:18 -0700 (PDT)
Message-Id: <0095ec49c5f3a3fc60c8fa0487dbeb04b0e1385d.1648742535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v6.git.1648742535.gitgitgadget@gmail.com>
References: <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
        <pull.985.v6.git.1648742535.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 16:02:15 +0000
Subject: [PATCH v6 2/2] untracked-cache: support '--untracked-files=all' if
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
"--untracked-files=normal", and is bypassed when
"--untracked-files=all" is requested, but this causes performance
issues for UI tooling that wants to see "all" on a frequent basis.

On the other hand, the conditions that altogether prevented
applicability to the "all" mode no longer seem to apply, after
several major refactors in recent years; this possibility was
discussed in
81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com and
CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com,
and somewhat confirmed experimentally by several users using a
version of this patch to use untracked cache with -uall for about a
year.

When 'git status' runs without using the untracked cache, on a large
repo, on windows, with fsmonitor, it can run very slowly. This can
make GUIs that need to use "-uall" (and therefore currently bypass
untracked cache) unusable when fsmonitor is enabled, on such large
repos.

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
 dir.c                             | 88 +++++++++++++++++++++++++------
 t/t7063-status-untracked-cache.sh | 81 ++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index f2b0f242101..26c4d141ab9 100644
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
@@ -2847,6 +2859,50 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
+	/*
+	 * If the untracked structure we received does not have the same flags
+	 * as requested in this run, we're going to need to either discard the
+	 * existing structure (and potentially later recreate), or bypass the
+	 * untracked cache mechanism for this run.
+	 */
+	if (dir->flags != dir->untracked->dir_flags) {
+		/*
+		 * If the untracked structure we received does not have the same flags
+		 * as configured, then we need to reset / create a new "untracked"
+		 * structure to match the new config.
+		 *
+		 * Keeping the saved and used untracked cache consistent with the
+		 * configuration provides an opportunity for frequent users of
+		 * "git status -uall" to leverage the untracked cache by aligning their
+		 * configuration - setting "status.showuntrackedfiles" to "all" or
+		 * "normal" as appropriate.
+		 *
+		 * Previously using -uall (or setting "status.showuntrackedfiles" to
+		 * "all") was incompatible with untracked cache and *consistently*
+		 * caused surprisingly bad performance (with fscache and fsmonitor
+		 * enabled) on Windows.
+		 *
+		 * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
+		 * to not be as bound up with the desired output in a given run,
+		 * and instead iterated through and stored enough information to
+		 * correctly serve both "modes", then users could get peak performance
+		 * with or without '-uall' regardless of their
+		 * "status.showuntrackedfiles" config.
+		 */
+		if (dir->untracked->dir_flags != new_untracked_cache_flags(istate)) {
+			free_untracked_cache(istate->untracked);
+			new_untracked_cache(istate, dir->flags);
+			dir->untracked = istate->untracked;
+		}
+		else {
+			/*
+			 * Current untracked cache data is consistent with config, but not
+			 * usable in this request/run; just bypass untracked cache.
+			 */
+			return NULL;
+		}
+	}
+
 	if (!dir->untracked->root) {
 		/* Untracked cache existed but is not initialized; fix that */
 		FLEX_ALLOC_STR(dir->untracked->root, name, "");
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index b89be8dc6d6..9936cc329ec 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -222,6 +222,87 @@ test_expect_success 'untracked cache remains after bypass' '
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
+# Bypassing the untracked cache here is not desirable from an
+# end-user perspective, but is expected in the current design.
+# The untracked cache data stored for a -all run cannot be
+# correctly used in a -unormal run - it would yield incorrect
+# output.
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
