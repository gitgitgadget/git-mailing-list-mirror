Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C49720248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfCUNTh (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36259 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfCUNTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so4289747pff.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adXp0HDtYLUhVDIeybYBZS94RPKqMxZ+m0Ui/JuGIRg=;
        b=t33jqNMj450bAEou0naXCVWNBeiQpcxp6e5OstbyvgLWTMq14sSIJMIPBE4JtmgewQ
         6Yh0lbB2Z7cxxGietb8+14iYnvlEkcL1TG4VcqTKF1z8/vJH173S2VHJJA7u3pIqgvuQ
         3QdI3TvvyokOdAb9sb4spiVanqlY7juEBRYp8oEy9pI5tVpaOOVx8Mcge3R4fjZUPZXm
         5fuTYE8Js/Jajm3/7Dj+VsVFKgLKhcHsGPZItgfMJdTw+MI1lP1PhyMrHLTRRBLawdyz
         8IKnV7ucmXWji61GAsCJAqP2Qn/plsOU8ErM9SySwYdc2GsCK0zNB6cBO4etXvl4sgE3
         +S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adXp0HDtYLUhVDIeybYBZS94RPKqMxZ+m0Ui/JuGIRg=;
        b=lJKIQqS+g+OkkgDgmIRi8cUW19msUHm+Xk0KT0yA4w9NHugEyf8eMEnf43yIPoCwAK
         k9LFjxSqmBC2+1N7oWgXZ2nOh/ZFe6fPxYQnShY5iVB1zr9rcyabVP7UudjzeAAPbKV7
         n6zPkG4eS0BST+cioSVAJTP4pCyKG5aA3ybIrZPMwuN3CkSHgXDUqjxe1Wn+9TSnuhQI
         1B/qf4PIjAURtHjvNIPvP8dn+JUlzqeMVAciSLfPQapsNYYIRIVCxkC6nVt9rVywOI1i
         PkPZLNO12tGp1zrGqJoDtZB+wr1+ny2lHxjkTOglR+6dYOWTaVQtzCWm1TzteB0JldTI
         dnrw==
X-Gm-Message-State: APjAAAUmYZuGA0rhYLZ+bO5ouHeO6JxlGUx3DzJyZWC5v3gMGDn4lemV
        +iGZ+jv2HtxWzU4+U5+2EZ4=
X-Google-Smtp-Source: APXvYqwEGga3tIJAVqaMvu/O2k0l+Jsd1ufgovZ+tveMg0ktCIkLqEuTwUVGdD+zb8lZqvOu4X342w==
X-Received: by 2002:a17:902:282b:: with SMTP id e40mr3505374plb.111.1553174376489;
        Thu, 21 Mar 2019 06:19:36 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 6sm5821236pfi.53.2019.03.21.06.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 21/26] switch: no worktree status unless real branch switch happens
Date:   Thu, 21 Mar 2019 20:16:50 +0700
Message-Id: <20190321131655.15249-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
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
index ee74379038..2aeaac092d 100644
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
2.21.0.548.gd3c7d92dc2

