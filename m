Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9E1C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiFNT1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiFNT1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:27:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9ADFF3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so6784988wmq.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=leF1fWGaFOxRNfrDlM6lZUnWWj4PiNZ07mDUCPS2KhI=;
        b=ppVQ7Lyuk5GWNw18bDgE9aS8m6VDcxkQ+XZ1khgyUy2GN3oCvtRIPp+N0OisPyGEJg
         HlUpn+9q9n17DiHdP3WSpwC2VsAEClIBbQnWgc+7QBrgK/xnmpcWWbNq5d2rFLrLt3Us
         h7fGU2cPmY2hGU5Gb0G8YX0ibFmDq39c2kXkgQguuevA02hxM+WrpN/IRK/UWiSn8V2f
         1iXW37q1vQxwlTfgwvGfx+i9Fujskt55oQdKAofR0RNzfMUlfHbAOz4Q+eJWmEymIFEh
         6/4uj3GHxhEya+jDDtXKA/zIrZgGJ03i9+WtePIJ0dPcJXtXI0Wls3H6m1UYpiKhOs8P
         RnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=leF1fWGaFOxRNfrDlM6lZUnWWj4PiNZ07mDUCPS2KhI=;
        b=PbaqXJkEc7hQFQeGelE8U6uzi+z3YUpiJWuxqggvcv5VXz+47TXdt6Uv4Xjm751dkj
         YYB2umv3D1U1Y8YgUAgrmhYmFUotjyeOpGAIkEsAVCPYvbvo09WeK5NK3O7oUJTA/SmC
         K8h3lAT3CyOVYU3oGH8B2yiojHyy7kV6dUzjwoaQlaz4L2TqrBo7VkdQv6OXA9JZPED1
         vI/FqI54q31v64A4wyLvzzTLC4pnpxuRoY/4XMEUP7/XRl/Ik3na47Z9IV/vlf/nL5zP
         H/QiUuWuwmaFg4WyiI70fe489psvuh0lLGUYVuYoXG4gNe10nnLzYJgO5iy/N8eB6v7y
         qGfg==
X-Gm-Message-State: AOAM530xHgPTCwNdXBsl5v3/UH+S6yOxT/R6O9LQfWLQWmgwwazxdKec
        wHTBbL4JO2DpcVZ5Bbc4H/p1++BWW4iBew==
X-Google-Smtp-Source: ABdhPJx5vICRxbuhN2NpUdSGZwwQdHbhKpvgzBjrxUgGLCJCQdI7uir13iwkdZmKJfuNR8dlQulKxQ==
X-Received: by 2002:a7b:c758:0:b0:39c:44ce:f00f with SMTP id w24-20020a7bc758000000b0039c44cef00fmr5826356wmk.167.1655234854737;
        Tue, 14 Jun 2022 12:27:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21-20020a1c5455000000b0039c2e2d0502sm17933533wmi.4.2022.06.14.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:27:34 -0700 (PDT)
Message-Id: <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 19:27:28 +0000
Subject: [PATCH v2 0/5] Create branch_checked_out() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a replacement for some patches from v2 of my 'git rebase
--update-refs' topic [1]. After some feedback from Philip, I've decided to
pull that topic while I rework how I track the refs to rewrite [2]. This
series moves forward with the branch_checked_out() helper that was a bit
more complicated than expected at first glance. This series is a culmination
of the discussion started by Junio at [3].

[1]
https://lore.kernel.org/git/pull.1247.v2.git.1654634569.gitgitgadget@gmail.com
[2]
https://lore.kernel.org/git/34264915-8a37-62db-f954-0b5297639b34@github.com/
[3] https://lore.kernel.org/git/xmqqr140t9am.fsf@gitster.g/

Here is the patch outline:

 1. Add a basic form of branch_checked_out() that only looks at the HEAD of
    each worktree. Since this doesn't look at BISECT_HEAD or REBASE_HEAD,
    the helper isn't linked to any consumer in this patch. A test script is
    added that verifies the current behavior checks that are implemented,
    even if they are not connected yet.
 2. Make branch_checked_out() actually look at BISECT_HEAD and REBASE_HEAD.
    Add tests for those cases, which was previously untested in the Git test
    suite. Use branch_checked_out() in 'git branch -f' to demonstrate this
    helper works as expected.
 3. Use branch_checked_out() in 'git fetch' when checking refs that would be
    updated by the refspec. Add tests for that scenario, too.
 4. Use branch_checked_out() in 'git branch -D' to prevent deleting refs
    from under an existing checkout. The commit message here describes some
    barriers to removing other uses of find_shared_symref() that could be
    good investigations for later.
 5. Be careful when constructing the strmap to free old values, even though
    this should only happen in error scenarios. Add tests that verify this
    behavior.


Updates in v2
=============

 * branch_checked_out() has a new prototype where it returns a 'const char
   *' instead of copying the path.
 * The test script is marked with TEST_PASSES_SANITIZE_LEAK and test are
   careful to avoid using 'git rebase' or 'git bisect' when possible.
 * Tests that cannot avoid memory-loss from 'git fetch' are marked with the
   "!SANITIZE_LEAK" prereq.
 * A previous replacement of 'wt->current' with 'path' is removed. This
   changes an error message, but it is a very rare scenario where this error
   would be output.

Thanks, -Stolee

Derrick Stolee (5):
  branch: add branch_checked_out() helper
  branch: check for bisects and rebases
  fetch: use new branch_checked_out() and add tests
  branch: use branch_checked_out() when deleting refs
  branch: fix branch_checked_out() leaks

 branch.c                  |  76 +++++++++++++++++++---
 branch.h                  |   7 +++
 builtin/branch.c          |   7 +--
 builtin/fetch.c           |  22 +++----
 t/t2407-worktree-heads.sh | 129 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 215 insertions(+), 26 deletions(-)
 create mode 100755 t/t2407-worktree-heads.sh


base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1254%2Fderrickstolee%2Fbranch-checked-out-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1254/derrickstolee/branch-checked-out-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1254

Range-diff vs v1:

 1:  dbb7eae390c ! 1:  bf701119edc branch: add branch_checked_out() helper
     @@ branch.c: int validate_branchname(const char *name, struct strbuf *ref)
      +	free_worktrees(worktrees);
      +}
      +
     -+int branch_checked_out(const char *refname, char **path)
     ++const char *branch_checked_out(const char *refname)
      +{
     -+	const char *path_in_set;
      +	prepare_checked_out_branches();
     -+
     -+	path_in_set = strmap_get(&current_checked_out_branches, refname);
     -+	if (path_in_set && path)
     -+		*path = xstrdup(path_in_set);
     -+
     -+	return !!path_in_set;
     ++	return strmap_get(&current_checked_out_branches, refname);
      +}
      +
       /*
     @@ branch.h: void create_branches_recursively(struct repository *r, const char *nam
       				 int dry_run);
      +
      +/*
     -+ * Returns true if the branch at 'refname' is checked out at any
     -+ * non-bare worktree. The path of the worktree is stored in the
     -+ * given 'path', if provided.
     ++ * If the branch at 'refname' is currently checked out in a worktree,
     ++ * then return the path to that worktree.
      + */
     -+int branch_checked_out(const char *refname, char **path);
     ++const char *branch_checked_out(const char *refname);
      +
       /*
        * Check if 'name' can be a valid name for a branch; die otherwise.
     @@ t/t2407-worktree-heads.sh (new)
      +
      +test_description='test operations trying to overwrite refs at worktree HEAD'
      +
     ++TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
      +
      +test_expect_success 'setup' '
     ++	test_commit init &&
     ++	git branch -f fake-1 &&
     ++	git branch -f fake-2 &&
     ++
      +	for i in 1 2 3 4
      +	do
      +		test_commit $i &&
 2:  18bad9b0c49 ! 2:  9347303db89 branch: check for bisects and rebases
     @@ branch.c: static void prepare_checked_out_branches(void)
       	}
       
       	free_worktrees(worktrees);
     -@@ branch.c: int branch_checked_out(const char *refname, char **path)
     +@@ branch.c: const char *branch_checked_out(const char *refname)
        */
       int validate_new_branchname(const char *name, struct strbuf *ref, int force)
       {
      -	struct worktree **worktrees;
      -	const struct worktree *wt;
      -
     -+	char *path;
     ++	const char *path;
       	if (!validate_branchname(name, ref))
       		return 0;
       
     @@ branch.c: int validate_new_branchname(const char *name, struct strbuf *ref, int
      -	worktrees = get_worktrees();
      -	wt = find_shared_symref(worktrees, "HEAD", ref->buf);
      -	if (wt && !wt->is_bare)
     -+	if (branch_checked_out(ref->buf, &path))
     ++	if ((path = branch_checked_out(ref->buf)))
       		die(_("cannot force update the branch '%s' "
       		      "checked out at '%s'"),
      -		    ref->buf + strlen("refs/heads/"), wt->path);
     @@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: checked out
       '
       
      +test_expect_success 'refuse to overwrite: worktree in bisect' '
     -+	test_when_finished test_might_fail git -C wt-4 bisect reset &&
     ++	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
      +
     -+	(
     -+		git -C wt-4 bisect start &&
     -+		git -C wt-4 bisect bad HEAD &&
     -+		git -C wt-4 bisect good HEAD~3
     -+	) &&
     ++	touch .git/worktrees/wt-4/BISECT_LOG &&
     ++	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
      +
     -+	test_must_fail git branch -f wt-4 HEAD 2>err &&
     -+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
     ++	test_must_fail git branch -f fake-2 HEAD 2>err &&
     ++	grep "cannot force update the branch '\''fake-2'\'' checked out at.*wt-4" err
      +'
      +
     -+. "$TEST_DIRECTORY"/lib-rebase.sh
     -+
      +test_expect_success 'refuse to overwrite: worktree in rebase' '
     -+	test_when_finished test_might_fail git -C wt-4 rebase --abort &&
     ++	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
      +
     -+	(
     -+		set_fake_editor &&
     -+		FAKE_LINES="edit 1 2 3" \
     -+			git -C wt-4 rebase -i HEAD~3 >rebase &&
     -+		git -C wt-4 status
     -+	) &&
     ++	mkdir -p .git/worktrees/wt-3/rebase-merge &&
     ++	touch .git/worktrees/wt-3/rebase-merge/interactive &&
     ++	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
     ++	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
      +
     -+	test_must_fail git branch -f wt-4 HEAD 2>err &&
     -+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
     ++	test_must_fail git branch -f fake-1 HEAD 2>err &&
     ++	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
      +'
      +
       test_done
 3:  4540dbeed38 ! 3:  1c764bfcfe4 fetch: use new branch_checked_out() and add tests
     @@ Commit message
          concurrent updates to the filesystem. Thus, it is beneficial to keep
          that extra check for the sake of defense-in-depth. However, we should
          not attempt to test the check, as the effort required is too
     -    complicated to be worth the effort.
     +    complicated to be worth the effort. This use in update_local_ref()
     +    also requires a change in the error message because we no longer have
     +    access to the worktree struct, only the path of the worktree. This error
     +    is so rare that making a distinction between the two is not critical.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
       {
       	struct commit *current = NULL, *updated;
      -	const struct worktree *wt;
     -+	char *path = NULL;
       	const char *pretty_ref = prettify_refname(ref->name);
       	int fast_forward = 0;
       
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      -	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
      -	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
      +	    !is_null_oid(&ref->old_oid) &&
     -+	    branch_checked_out(ref->name, &path)) {
     ++	    branch_checked_out(ref->name)) {
       		/*
       		 * If this is the head, and it's not okay to update
       		 * the head, and the old value of the head isn't empty...
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      -			       wt->is_current ?
      -				       _("can't fetch in current branch") :
      -				       _("checked out in another worktree"),
     -+			       path ? _("can't fetch in current branch") :
     -+				      _("checked out in another worktree"),
     ++			       _("can't fetch into checked-out branch"),
       			       remote, pretty_ref, summary_width);
     -+		free(path);
       		return 1;
       	}
     - 
      @@ builtin/fetch.c: cleanup:
       	return result;
       }
     @@ builtin/fetch.c: cleanup:
      +static void check_not_current_branch(struct ref *ref_map)
       {
      -	const struct worktree *wt;
     -+	char *path;
     ++	const char *path;
       	for (; ref_map; ref_map = ref_map->next)
       		if (ref_map->peer_ref &&
       		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
      -		    (wt = find_shared_symref(worktrees, "HEAD",
      -					     ref_map->peer_ref->name)) &&
      -		    !wt->is_bare)
     -+		    branch_checked_out(ref_map->peer_ref->name, &path))
     ++		    (path = branch_checked_out(ref_map->peer_ref->name)))
       			die(_("refusing to fetch into branch '%s' "
       			      "checked out at '%s'"),
      -			    ref_map->peer_ref->name, wt->path);
     @@ t/t2407-worktree-heads.sh: test_expect_success 'setup' '
      +	done &&
      +
      +	# Create a server that updates each branch by one commit
     -+	git clone . server &&
     ++	git init server &&
     ++	test_commit -C server initial &&
      +	git remote add server ./server &&
      +	for i in 1 2 3 4
      +	do
     -+		git -C server checkout wt-$i &&
     ++		git -C server checkout -b wt-$i &&
      +		test_commit -C server A-$i || return 1
     ++	done &&
     ++	for i in 1 2
     ++	do
     ++		git -C server checkout -b fake-$i &&
     ++		test_commit -C server f-$i || return 1
       	done
       '
       
     -@@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: checked out in worktree' '
     - 	done
     +@@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: worktree in rebase' '
     + 	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
       '
       
     -+test_expect_success 'refuse to overwrite during fetch' '
     ++test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
      +	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
      +	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
      +
     @@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: checked out
      +	grep "refusing to fetch into branch" err
      +'
      +
     - test_expect_success 'refuse to overwrite: worktree in bisect' '
     - 	test_when_finished test_might_fail git -C wt-4 bisect reset &&
     - 
     -@@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: worktree in bisect' '
     - 	) &&
     - 
     - 	test_must_fail git branch -f wt-4 HEAD 2>err &&
     --	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
     -+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err &&
     ++test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect' '
     ++	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
      +
     -+	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
     -+	grep "refusing to fetch into branch '\''refs/heads/wt-4'\''" err
     - '
     - 
     - . "$TEST_DIRECTORY"/lib-rebase.sh
     -@@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: worktree in rebase' '
     - 	) &&
     - 
     - 	test_must_fail git branch -f wt-4 HEAD 2>err &&
     --	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
     -+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err &&
     ++	touch .git/worktrees/wt-4/BISECT_LOG &&
     ++	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
     ++
     ++	test_must_fail git fetch server +refs/heads/fake-2:refs/heads/fake-2 2>err &&
     ++	grep "refusing to fetch into branch" err
     ++'
     ++
     ++test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in rebase' '
     ++	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
     ++
     ++	mkdir -p .git/worktrees/wt-4/rebase-merge &&
     ++	touch .git/worktrees/wt-4/rebase-merge/interactive &&
     ++	echo refs/heads/fake-1 >.git/worktrees/wt-4/rebase-merge/head-name &&
     ++	echo refs/heads/fake-2 >.git/worktrees/wt-4/rebase-merge/onto &&
     ++
     ++	test_must_fail git fetch server +refs/heads/fake-1:refs/heads/fake-1 2>err &&
     ++	grep "refusing to fetch into branch" err
     ++'
      +
     -+	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
     -+	grep "refusing to fetch into branch '\''refs/heads/wt-4'\''" err
     - '
     - 
       test_done
 4:  af645b43032 ! 4:  d7e63f9dfd6 branch: use branch_checked_out() when deleting refs
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      -			const struct worktree *wt =
      -				find_shared_symref(worktrees, "HEAD", name);
      -			if (wt) {
     -+			char *path;
     -+			if (branch_checked_out(name, &path)) {
     ++			const char *path;
     ++			if ((path = branch_checked_out(name))) {
       				error(_("Cannot delete branch '%s' "
       					"checked out at '%s'"),
      -				      bname.buf, wt->path);
      +				      bname.buf, path);
     -+				free(path);
       				ret = 1;
       				continue;
       			}
 -:  ----------- > 5:  0aa9478bc38 branch: fix branch_checked_out() leaks

-- 
gitgitgadget
