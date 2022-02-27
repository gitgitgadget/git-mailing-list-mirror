Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90CC433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 15:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiB0PNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 10:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiB0PNn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 10:13:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7913EAE
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 07:13:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so4448794wmj.0
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dA4t+a9iWDJM3S9aKv6y70iw9RChI45dO8CoJSkMnWs=;
        b=McX1AMpHK4l6rht3st0EbMsHJEYOWsXKHdEhBR0oIjZ0QBR+ueDI/ZMgEtR/GQyJyT
         +MSMsVH644o+JILugWRa7gBaONZxbr5m2lub0m3gCA3pHibDufMIbNrsSvG3tIcItZrU
         Ww1I0tNcwM0ISVQap5m0s6lBQoqxA+e2DjoPEhW1K/dr1wG7hqHsrEnfJD4J6iYxE2Wu
         K85+4n5ppYUKkKAyXmDclJqkJaGMaiANWnJoEg9rCkvufnCyxsO/zMB5uNs/k7s6C1Qp
         VfhTPbtDMceVgWQ3Avx9AgzjU+7hDY1p5z7T+55Ohy4gxFikkM/pPBZGPxmo/hbMJKEO
         kg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dA4t+a9iWDJM3S9aKv6y70iw9RChI45dO8CoJSkMnWs=;
        b=IHC/j/ni/pC0zNueBm7Ex8Z2Dl67pgFR9zjLMjjE25TfpsFIYGeUaEd6dOAcAfcb9b
         DG3YNQPqLTi1qspHiTWePQj7/xkFsWHU9pey700D8pE5Ho/eZEBleeJr8gz2x11vetyd
         DK6KqoxyBSaQk2dQJe+jpQ6tzDvr88NDDVfUZm3bbQXOng7Fg+Klkz/f7xIqCBu5aCJy
         rCzm/dg21RhAGy0Bfu4bnnjXTHcDE7QnEFDyaLmHkCvZgEdIVwsltA9WZXJVaq6FpkgI
         W2iDdMfVqM6xYIfIZo0dnIdC40WEiwNIwgwfBZFzPDDDQe1yv9h9BCTAA3Yh9Jkb9LXK
         eSow==
X-Gm-Message-State: AOAM530oZeNl5ADFwEafpTatoQwpQYV24UGemv2ZvvEq/hFpUuSsPu31
        BFeJiFhwxPvk6cqkjX0j6tM69gEB4OA=
X-Google-Smtp-Source: ABdhPJyezdxv+0b0QWUvvj2NwBArEOWQCrnFHVyYEsOOpdE/5KAQ/wOp0BHaALZQ6bXXfbEpaUFEvw==
X-Received: by 2002:a05:600c:384b:b0:381:10bc:9e43 with SMTP id s11-20020a05600c384b00b0038110bc9e43mr5343865wmr.181.1645974783777;
        Sun, 27 Feb 2022 07:13:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a7bc7d0000000b00381004c643asm11628183wmk.30.2022.02.27.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:13:03 -0800 (PST)
Message-Id: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v3.git.1645960973798.gitgitgadget@gmail.com>
References: <pull.985.v3.git.1645960973798.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 15:13:02 +0000
Subject: [PATCH v4] untracked-cache: support '--untracked-files=all' if
 configured
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Untracked cache was originally designed to only work with
'-untracked-files=normal', but this causes performance issues for UI
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
    Support untracked cache with '--untracked-files=all' if configured
    
    Resending this patch from a few months ago (with better standards
    compliance) - it hasn't seen any comments yet, I would dearly love some
    eyes on this as the change can make a big difference to hundreds of
    windows users in my environment (and I'd really rather not start
    distributing customized git builds!)
    
    This patch aims to make it possible for users of the -uall flag to git
    status, either by preference or by need (eg UI tooling), to benefit from
    the untracked cache when they set their 'status.showuntrackedfiles'
    config setting to 'all'. This is very important for large repos in
    Windows.
    
    More detail on the change and context in the commit message, I assume
    repeating a verbose message here is discouraged.
    
    These changes result from a couple of conversations,
    81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com and
    CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com>.
    
    The test suite passes, but as a n00b I do have questions:
    
     * Is there any additional validation that could/should be done to
       confirm that "-uall" untracked data can be cached safely?
       * It looks safe from following the code
       * It seems from discussing briefly with Elijah Newren in the thread
         above that thare are no obvious red flags
       * Manual testing, explicitly and implicitly through months of use,
         yields no issues
     * Is it OK to check the repo configuration in the body of processing?
       It seems to be a rare pattern
     * Can anyone think of a way to test this change?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-985%2FTaoK%2Ftaok-untracked-cache-with-uall-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-985/TaoK/taok-untracked-cache-with-uall-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/985

Range-diff vs v3:

 1:  49cf90bfab5 ! 1:  5da418e5c60 untracked-cache: support '--untracked-files=all' if configured
     @@ dir.c: static void set_untracked_ident(struct untracked_cache *uc)
       }
       
      -static void new_untracked_cache(struct index_state *istate)
     -+static unsigned configured_default_dir_flags(struct index_state *istate)
     ++static unsigned configured_default_dir_flags(struct repository *repo)
      +{
     -+	/* This logic is coordinated with the setting of these flags in
     ++	/*
     ++	 * This logic is coordinated with the setting of these flags in
      +	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
      +	 * of the config setting in commit.c#git_status_config()
      +	 */
      +	char *status_untracked_files_config_value;
     -+	int config_outcome = repo_config_get_string(istate->repo,
     -+								"status.showuntrackedfiles",
     -+								&status_untracked_files_config_value);
     ++	int config_outcome = repo_config_get_string(repo,
     ++						    "status.showuntrackedfiles",
     ++						    &status_untracked_files_config_value);
      +	if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
      +		return 0;
      +	} else {
     @@ dir.c: static void new_untracked_cache(struct index_state *istate)
       	if (!istate->untracked) {
      -		new_untracked_cache(istate);
      +		new_untracked_cache(istate,
     -+				configured_default_dir_flags(istate));
     ++				    configured_default_dir_flags(istate->repo));
       	} else {
       		if (!ident_in_untracked(istate->untracked)) {
       			free_untracked_cache(istate->untracked);
      -			new_untracked_cache(istate);
      +			new_untracked_cache(istate,
     -+					configured_default_dir_flags(istate));
     ++					    configured_default_dir_flags(istate->repo));
       		}
       	}
       }
      @@ dir.c: void remove_untracked_cache(struct index_state *istate)
     + }
       
       static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
     - 						      int base_len,
     +-						      int base_len,
      -						      const struct pathspec *pathspec)
     -+						      const struct pathspec *pathspec,
     -+							  struct index_state *istate)
     ++							    int base_len,
     ++							    const struct pathspec *pathspec,
     ++							    struct index_state *istate)
       {
       	struct untracked_cache_dir *root;
       	static int untracked_cache_disabled = -1;
     -+	unsigned configured_dir_flags;
     - 
     - 	if (!dir->untracked)
     - 		return NULL;
      @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
       	if (base_len || (pathspec && pathspec->nr))
       		return NULL;
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
       		return NULL;
       	}
       
     -+	/* We don't support using or preparing the untracked cache if
     ++	/*
     ++	 * We don't support using or preparing the untracked cache if
      +	 * the current effective flags don't match the configured
      +	 * flags.
      +	 */
     -+	configured_dir_flags = configured_default_dir_flags(istate);
     -+	if (dir->flags != configured_dir_flags)
     ++	if (dir->flags != configured_default_dir_flags(istate->repo))
      +		return NULL;
      +
     -+	/* If the untracked structure we received does not have the same flags
     ++	/*
     ++	 * If the untracked structure we received does not have the same flags
      +	 * as configured, but the configured flags do match the effective flags,
      +	 * then we need to reset / create a new "untracked" structure to match
      +	 * the new config.
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
      +	 */
      +	if (dir->flags != dir->untracked->dir_flags) {
      +		free_untracked_cache(istate->untracked);
     -+		new_untracked_cache(istate, configured_dir_flags);
     ++		new_untracked_cache(istate, dir->flags);
      +		dir->untracked = istate->untracked;
      +	}
      +


 dir.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index d91295f2bcd..57a7d42482f 100644
--- a/dir.c
+++ b/dir.c
@@ -2746,13 +2746,34 @@ static void set_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
-static void new_untracked_cache(struct index_state *istate)
+static unsigned configured_default_dir_flags(struct repository *repo)
+{
+	/*
+	 * This logic is coordinated with the setting of these flags in
+	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
+	 * of the config setting in commit.c#git_status_config()
+	 */
+	char *status_untracked_files_config_value;
+	int config_outcome = repo_config_get_string(repo,
+						    "status.showuntrackedfiles",
+						    &status_untracked_files_config_value);
+	if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
+		return 0;
+	} else {
+		/*
+		 * The default, if "all" is not set, is "normal" - leading us here.
+		 * If the value is "none" then it really doesn't matter.
+		 */
+		return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	}
+}
+
+static void new_untracked_cache(struct index_state *istate, unsigned flags)
 {
 	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, 100);
 	uc->exclude_per_dir = ".gitignore";
-	/* should be the same flags used by git-status */
-	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	uc->dir_flags = flags;
 	set_untracked_ident(uc);
 	istate->untracked = uc;
 	istate->cache_changed |= UNTRACKED_CHANGED;
@@ -2761,11 +2782,13 @@ static void new_untracked_cache(struct index_state *istate)
 void add_untracked_cache(struct index_state *istate)
 {
 	if (!istate->untracked) {
-		new_untracked_cache(istate);
+		new_untracked_cache(istate,
+				    configured_default_dir_flags(istate->repo));
 	} else {
 		if (!ident_in_untracked(istate->untracked)) {
 			free_untracked_cache(istate->untracked);
-			new_untracked_cache(istate);
+			new_untracked_cache(istate,
+					    configured_default_dir_flags(istate->repo));
 		}
 	}
 }
@@ -2780,8 +2803,9 @@ void remove_untracked_cache(struct index_state *istate)
 }
 
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
-						      int base_len,
-						      const struct pathspec *pathspec)
+							    int base_len,
+							    const struct pathspec *pathspec,
+							    struct index_state *istate)
 {
 	struct untracked_cache_dir *root;
 	static int untracked_cache_disabled = -1;
@@ -2812,17 +2836,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
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
@@ -2845,6 +2861,41 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
+	/*
+	 * We don't support using or preparing the untracked cache if
+	 * the current effective flags don't match the configured
+	 * flags.
+	 */
+	if (dir->flags != configured_default_dir_flags(istate->repo))
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
 	if (!dir->untracked->root)
 		FLEX_ALLOC_STR(dir->untracked->root, name, "");
 
@@ -2916,7 +2967,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		return dir->nr;
 	}
 
-	untracked = validate_untracked_cache(dir, len, pathspec);
+	untracked = validate_untracked_cache(dir, len, pathspec, istate);
 	if (!untracked)
 		/*
 		 * make sure untracked cache code path is disabled,

base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
-- 
gitgitgadget
