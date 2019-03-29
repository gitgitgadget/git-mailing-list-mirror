Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0965C20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfC2KmL (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:42:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36544 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2KmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so1036759pgc.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5E5sdMHnb/567s0nG/Ul3Mrtif5AYHcaRdj7B9sJq4c=;
        b=EwELfHN5/X8/D0dBHi5YYO/gbCpTbvP2cr88vINu50MG2bMWEajjgTopzJIIABLoop
         5FXwUJt+5kK16PgFPGpdenNiYjjyiGA7FtIOd/vxkApMzS05RZJy0h05TQ8D9UvgrJBf
         f8VmEwCfLrwZxvNWTVkD6beaebFR3y6rRI3fuzAqjEvHf3QDGvTmICN7yUTeyp0dpE7b
         g7/s/JBtap6CdHldyedTJ2TEDxs0PZBppiWLCvmyNeU6ipeOkJks9gIe9BSLSaUt8Ocb
         hYv4yBwPHk3gRjMz8xA8/8wdx1aW0oWfAPuFZL3lGFK5mxmoICx6Zf2gFbr60P3t4x9S
         fDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5E5sdMHnb/567s0nG/Ul3Mrtif5AYHcaRdj7B9sJq4c=;
        b=tEAD70Txwj1DHHKpfbFBr5g8A7Ee4KGj3CqFPD75Nt9TrEwjRos0Tl3SLi8XHFvLRv
         jZbz935OocD3Qb41E4oQHXGSfTSsO39t9k0p/RBf3gdzX9jJihoBEb9cP/4DRWhvB8jk
         CRqNRoNcAmx+nSJ58VJ2PLLlx5ERdpKds0YChODIfkIqloyp5n6UJ14YthJvpDdhwAkR
         33LDWDytKXS8nilhu7uhMo9TugyFZFfZ2iK0W0X4jA48AFt+3muBE2ntiT2TXQk89Of6
         ZF1qCpP+NlbAKtBXk3pYB4pi+v/uMn9DOHT5hSq8YjRKc4+d44p51D7xGP79/IbtngWY
         7sAQ==
X-Gm-Message-State: APjAAAViAEu3useBz/IH8WB/4FWMafFvWm/NuRLY643eaBQ7+XZyEjvb
        ELnTGatGpJle9ZeE/MTWfwk=
X-Google-Smtp-Source: APXvYqw7WUzGfomt8aOoXGjYJMqh3ItFI8MZKyFTjAMtQz6R8RXZjzyT9zmEv0EH4pWN3Skz0FPhaA==
X-Received: by 2002:a62:4481:: with SMTP id m1mr47194361pfi.253.1553856127282;
        Fri, 29 Mar 2019 03:42:07 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id b16sm3163586pfo.168.2019.03.29.03.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:42:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:42:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 22/27] switch: no worktree status unless real branch switch happens
Date:   Fri, 29 Mar 2019 17:39:14 +0700
Message-Id: <20190329103919.15642-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
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
 builtin/checkout.c                | 134 ++----------------------------
 t/t1090-sparse-checkout-scope.sh  |  14 ----
 3 files changed, 8 insertions(+), 148 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index d6872ffa83..6b646813ab 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -16,11 +16,3 @@ will checkout the '<something>' branch on another remote,
 and by linkgit:git-worktree[1] when 'git worktree add' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
-
-checkout.optimizeNewBranch::
-	Optimizes the performance of "git checkout -b <new_branch>" when
-	using sparse-checkout.  When set to true, git will not update the
-	repo based on the current sparse-checkout settings.  This means it
-	will not update the skip-worktree bit in the index nor add/remove
-	files in the working directory to reflect the current sparse checkout
-	settings nor will it show the local changes.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ff9b96993d..f7967cdb7c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -26,8 +26,6 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
-static int checkout_optimize_new_branch;
-
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
@@ -57,11 +55,7 @@ struct checkout_opts {
 	int discard_changes;
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
@@ -565,112 +559,6 @@ static void setup_branch_path(struct branch_info *branch)
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
-	 /*
-	  * Do the merge if this is the initial checkout. We cannot use
-	  * is_cache_unborn() here because the index hasn't been loaded yet
-	  * so cache_nr and timestamp.sec are always zero.
-	  */
-	if (!file_exists(get_index_file()))
-		return 0;
-
-	return 1;
-}
-
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
@@ -1028,6 +916,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+	int do_merge = 1;
 
 	trace2_cmd_mode("branch");
 
@@ -1047,16 +936,12 @@ static int switch_branches(const struct checkout_opts *opts,
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
@@ -1076,11 +961,6 @@ static int switch_branches(const struct checkout_opts *opts,
 
 static int git_checkout_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "checkout.optimizenewbranch")) {
-		checkout_optimize_new_branch = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "diff.ignoresubmodules")) {
 		struct checkout_opts *opts = cb;
 		handle_ignore_submodules_arg(&opts->diff_options, value);
@@ -1631,6 +1511,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
+	opts.only_merge_on_switching_branches = 0;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 
@@ -1666,6 +1547,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.dwim_new_local_branch = 1;
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
2.21.0.479.g47ac719cd3

