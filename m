Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E9E1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfA3Jtz (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:55 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34753 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3Jtz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:55 -0500
Received: by mail-pg1-f173.google.com with SMTP id j10so10136507pga.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0C2+vNUhOiWdN6YZh0BDfKfDYG9CF4JpSjpQlOtQTqI=;
        b=hfr3MjVmz+Qo5Cm3aaD2b25P+qjhPGjQye5eZHAEbpBfGtCu3kwfU7EZuZFjL46/AX
         TVaoJiH9EvyJM2+DNIizgSTrfk6rNG7yoKRrHgmnjonch02f1rE9+bxfhJzAml2GCMJ9
         NWQzNlcv6CjiTyQpoZARn9Dx27vY5brfQzaiXs1Y1I5Goe4Lvyq+0RyyWZcw/VN/ZQcL
         CDZYi31JL1f+rW/r00kkp5eyi6z78JlCTN4qvpWLWgWK27yOxns8xZKh7UixkRgkZSv8
         u7lqeYZqBf7ri7a47z6Npmiyss80L49tOu3IcID0YcSUNWyR7cBOLw8Yln76MmjY4mV9
         26RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0C2+vNUhOiWdN6YZh0BDfKfDYG9CF4JpSjpQlOtQTqI=;
        b=WKbmLz1X/yN07fhfaKoBuPUNue8md0noziqNLdeNPBs2umKsmQXXEG1e+zAdQkpATr
         u7AMTDK/TpLowbGjUL1leXHW8g04cdUc746miO2sYl8f4hbYtNQDP116l/6d7YbcLw0T
         HQ8a+XhXZiP/wyS2VQdlb5Qvo5Zmz1Cc2zd8bAh/Nu1YYx+AJ6uwnhR9WW/ujKABN/PL
         gTf0KuY8oYtw8auPxqADXIIR8N8WaONxYvMZYO7kjSMGrBIFF3JKMHO8XkHZ0327bpnW
         k7QtB9cuXKqzBlU26/FnADMVQyeBjK1xERXrlKRli6kjhifiQVxPH+OLI1HsBHBAxKUg
         ZVLQ==
X-Gm-Message-State: AJcUukeR7xDZMxNG6n/dU3BKc39TKL6EcP7IxfCMwweinLkPXTbJsymZ
        nRXMH/2RB2ox00fbAe2gg6L/3JIe
X-Google-Smtp-Source: ALg8bN5DpRs1qCxS+JagoYDW9vC2FBrE3tJIov8cnxxjTOyxHpePnlM8pKULpB9o7Z80hQx4c1rYfg==
X-Received: by 2002:a63:3c58:: with SMTP id i24mr27348961pgn.284.1548841793445;
        Wed, 30 Jan 2019 01:49:53 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 202sm1790418pfy.87.2019.01.30.01.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/19] switch: no worktree status unless real branch switch happens
Date:   Wed, 30 Jan 2019 16:48:28 +0700
Message-Id: <20190130094831.10420-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we switch from one branch to another, it makes sense to show a
summary of local changes since there could be conflicts, or some files
left modified.... When switch is used solely for creating a new
branch (and "switch" to the same commit) or detaching, we don't really
need to show anything.

"git checkout" does it anyway for historical reasons. But we can start
with a clean slate with switch and don't have to.

This essentially reverts fa655d8411 (checkout: optimize "git checkout
-b <new_branch>" - 2018-08-16) and make it default for switch,
but also for -B and --detach. Users of big repos are encouraged to
move to switch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config/checkout.txt |   8 --
 builtin/checkout.c                | 127 +++---------------------------
 t/t1090-sparse-checkout-scope.sh  |  14 ----
 3 files changed, 9 insertions(+), 140 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index fc211eca58..2fe24049fe 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -17,14 +17,6 @@ and by linkgit:git-worktree[1] when 'git worktree add' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
 
-checkout.optimizeNewBranch::
-	Optimizes the performance of "git checkout -b <new_branch>" when
-	using sparse-checkout.  When set to true, git will not update the
-	repo based on the current sparse-checkout settings.  This means it
-	will not update the skip-worktree bit in the index nor add/remove
-	files in the working directory to reflect the current sparse checkout
-	settings nor will it show the local changes.
-
 checkout.overlayMode::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cdd07f6aba..8b4aabd6db 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -25,8 +25,6 @@
 #include "submodule.h"
 #include "advice.h"
 
-static int checkout_optimize_new_branch;
-
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
@@ -55,11 +53,7 @@ struct checkout_opts {
 	int dwim_new_local_branch;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
-
-	/*
-	 * If new checkout options are added, skip_merge_working_tree
-	 * should be updated accordingly.
-	 */
+	int only_merge_on_switching_branches;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -556,104 +550,6 @@ static void setup_branch_path(struct branch_info *branch)
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
-/*
- * Skip merging the trees, updating the index and working directory if and
- * only if we are creating a new branch via "git checkout -b <new_branch>."
- */
-static int skip_merge_working_tree(const struct checkout_opts *opts,
-	const struct branch_info *old_branch_info,
-	const struct branch_info *new_branch_info)
-{
-	/*
-	 * Do the merge if sparse checkout is on and the user has not opted in
-	 * to the optimized behavior
-	 */
-	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
-		return 0;
-
-	/*
-	 * We must do the merge if we are actually moving to a new commit.
-	 */
-	if (!old_branch_info->commit || !new_branch_info->commit ||
-		!oideq(&old_branch_info->commit->object.oid,
-		       &new_branch_info->commit->object.oid))
-		return 0;
-
-	/*
-	 * opts->patch_mode cannot be used with switching branches so is
-	 * not tested here
-	 */
-
-	/*
-	 * opts->quiet only impacts output so doesn't require a merge
-	 */
-
-	/*
-	 * Honor the explicit request for a three-way merge or to throw away
-	 * local changes
-	 */
-	if (opts->merge || opts->force)
-		return 0;
-
-	/*
-	 * --detach is documented as "updating the index and the files in the
-	 * working tree" but this optimization skips those steps so fall through
-	 * to the regular code path.
-	 */
-	if (opts->force_detach)
-		return 0;
-
-	/*
-	 * opts->writeout_stage cannot be used with switching branches so is
-	 * not tested here
-	 */
-
-	/*
-	 * Honor the explicit ignore requests
-	 */
-	if (!opts->overwrite_ignore || opts->ignore_skipworktree ||
-		opts->ignore_other_worktrees)
-		return 0;
-
-	/*
-	 * opts->show_progress only impacts output so doesn't require a merge
-	 */
-
-	/*
-	 * opts->overlay_mode cannot be used with switching branches so is
-	 * not tested here
-	 */
-
-	/*
-	 * If we aren't creating a new branch any changes or updates will
-	 * happen in the existing branch.  Since that could only be updating
-	 * the index and working directory, we don't want to skip those steps
-	 * or we've defeated any purpose in running the command.
-	 */
-	if (!opts->new_branch)
-		return 0;
-
-	/*
-	 * new_branch_force is defined to "create/reset and checkout a branch"
-	 * so needs to go through the merge to do the reset
-	 */
-	if (opts->new_branch_force)
-		return 0;
-
-	/*
-	 * A new orphaned branch requrires the index and the working tree to be
-	 * adjusted to <start_point>
-	 */
-	if (opts->new_orphan_branch)
-		return 0;
-
-	/*
-	 * Remaining variables are not checkout options but used to track state
-	 */
-
-	return 1;
-}
-
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
@@ -1011,6 +907,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+	int do_merge = 1;
+
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
@@ -1027,16 +925,12 @@ static int switch_branches(const struct checkout_opts *opts,
 		if (!new_branch_info->commit)
 			die(_("You are on a branch yet to be born"));
 		parse_commit_or_die(new_branch_info->commit);
+
+		if (opts->only_merge_on_switching_branches)
+			do_merge = 0;
 	}
 
-	/* optimize the "checkout -b <new_branch> path */
-	if (skip_merge_working_tree(opts, &old_branch_info, new_branch_info)) {
-		if (!checkout_optimize_new_branch && !opts->quiet) {
-			if (read_cache_preload(NULL) < 0)
-				return error(_("index file corrupt"));
-			show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
-		}
-	} else {
+	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
 			free(path_to_free);
@@ -1058,11 +952,6 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 {
 	struct checkout_opts *opts = cb;
 
-	if (!strcmp(var, "checkout.optimizenewbranch")) {
-		checkout_optimize_new_branch = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "checkout.overlaymode")) {
 		opts->overlay_mode = git_config_bool(var, value);
 		return 0;
@@ -1587,6 +1476,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
+	opts.only_merge_on_switching_branches = 0;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 
@@ -1620,6 +1510,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
 
 	options = parse_options_dup(switch_options);
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 090b7fc3d3..40cc004326 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -31,20 +31,6 @@ test_expect_success 'perform sparse checkout of master' '
 	test_path_is_file c
 '
 
-test_expect_success 'checkout -b checkout.optimizeNewBranch interaction' '
-	cp .git/info/sparse-checkout .git/info/sparse-checkout.bak &&
-	test_when_finished "
-		mv -f .git/info/sparse-checkout.bak .git/info/sparse-checkout
-		git checkout master
-	" &&
-	echo "/b" >>.git/info/sparse-checkout &&
-	test "$(git ls-files -t b)" = "S b" &&
-	git -c checkout.optimizeNewBranch=true checkout -b fast &&
-	test "$(git ls-files -t b)" = "S b" &&
-	git checkout -b slow &&
-	test "$(git ls-files -t b)" = "H b"
-'
-
 test_expect_success 'merge feature branch into sparse checkout of master' '
 	git merge feature &&
 	test_path_is_file a &&
-- 
2.20.1.682.gd5861c6d90

