Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D603AB289
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344028; cv=none; b=maT/3tUQvUKiZnhX8A0DdTTuStgOQK+/wkykD3kws544hTkZRRm9bp159n89jKLCAC1tdMRdteRq7fpqNptzBYHdJkODu6kRKi6JNzLZIAKGceXARWoMfBXQvlkuNrPc0GtjuZx0o7OQzqTfDFZyjgFUvQjTf3eemagswBk1lfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344028; c=relaxed/simple;
	bh=8JKDmJhdJL4XMlHnzbZUyy/b65BQAKdkDA8iUXwoJAU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lv71Qb8UuHzEsSI8G17Yh8AfoUp7EcLOelrjWQmIW68wt3em02s9CkDfPiYsB0loUxSng/D832FxlCxkQIvg92tvKZlV/XtWhJA2/48a4zlx17krNK5eKWhHfnBdD8EjWUL4LWpUbNqGlnS+7JMCRvbOhPFbN6b5Q2m8YEi327o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z19SS5rP; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z19SS5rP"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d556c1a79eso1556240a34.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773344024; x=1773948824; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8rXr7xfhXYb5GwDTYnLtPNk6UiCF6xC7/cF69mJMoI=;
        b=Z19SS5rPYB+wC5nK81oYjc34yleRoDUAij2R1rlD6I85yOVe8nF30C2bvkT7nvkBBB
         C5usyZvJNOs7u/b76XYahk1s/uhYmEuyo+ZuigxLZIV+wddbrf/kG1K6a/JnsjAfYib7
         xKPMNIOqPsTOIEFaR52d5t/g4JN8LKGeZjqbDDvrTZRsxXnaWk0dwKqNVpXD5ilfjpP6
         2Gy+CmrA/9uKg/i/1Y44k3wqPMMYT2v+GXMP+Bjq5cVjvwRPfc2vk0T7b77apqHKCKc2
         voroOQpl+oqf4qzbzht6ISdT7ezjimieh9sF9zCaRl5vxEirbLZqwp4Ba2B4LPw/xfp7
         kjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344024; x=1773948824;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8rXr7xfhXYb5GwDTYnLtPNk6UiCF6xC7/cF69mJMoI=;
        b=tc3cOgVJ51dXaryIENJ9U3++S3PGRshC/XJMcREZ8s5zKlUpfjoS8ARgo4JiHjCoH+
         Vg2A8jk9YjxZX+oiYJz6cxGRIWA4arkLwoZsan6NYGgY6ZKYKg5UBxSEtF3dEQ8E+IhE
         8t9/CYvPaZA81pxX/pT7P4S2yEzXoXsASh+K3u/PKyLFBnrA0aJ/a5t9VVs33GJYQg/K
         Wp5ABJuVTiEG6GWV6DcUyOwyUbhgP5kaxk1OKnFnN16jDsX7xCU5FFsAGlF2LDPImvf3
         j1XT88ykeq87GIesGIwv8Vn90OCeMqIY3gb4ISNDHc9XyTUUsEmMRCehoDOTQEA43psn
         Ykkw==
X-Gm-Message-State: AOJu0Yy7FkmD7KNW8usmBc6oo7hThy3Kl4eYjFfA5fxQpbaStlVo/7Ix
	TVP3jSCXMd27kZFdTJMkF7OVvLZiKbjV51eo82f/oylMioHjz8krpjETdNVmWQ==
X-Gm-Gg: ATEYQzznzuco1KIJLkLXwQ6HWdEnEla/GF5/AJuv1ITsuwcgbZyMhasJyOjts6v/sXi
	k94APpF6OI8GBW8FLTKHhfW/b93I6GvObTF12APY1vptpXw4UnHyF6959iQVG8ibm4vzOEHIy6i
	N9nQYI3VlsnfuhJQ6H1T2I8OuOCwrwDi27UG1n2OZGqrmP5+piWngh1+frynjbooe4GbEJJlZ5a
	4A0luurtjR6kBX80ieD/UaGYkaetpB/kzcKw2zBnwGmUWbphHte6dSjuEMV6Wtj+7E4gXaUb4/1
	99lw3qczTDRG5IBsMsUFRXaiH866oRitYcVgNAmDblz6icGWK9vrdwwH0IJnW5tsa+3SDjFRWgl
	vdgFisGfG7LC9BzWo8CGoRxS77NMTCVbNqgYUilQ5gxffMSnS/xzQnfxRZEUSE64gDTv9kJqueT
	6veG5kcezcuTQWbtBmyJz4DfsGbg==
X-Received: by 2002:a05:6830:3817:b0:7d4:ba98:63e6 with SMTP id 46e09a7af769-7d7825cdf5bmr403657a34.28.1773344024187;
        Thu, 12 Mar 2026 12:33:44 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.82.131])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac8975csm4601586a34.8.2026.03.12.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:33:43 -0700 (PDT)
Message-Id: <pull.2234.v2.git.git.1773344022931.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
References: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 19:33:42 +0000
Subject: [PATCH v2] checkout: add --autostash option for branch switching
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When switching branches, local modifications in the working tree can
prevent the checkout from succeeding.  While "git rebase" and "git
merge" already support --autostash to handle this case automatically,
"git checkout" and "git switch" require users to manually stash and
unstash their changes.

Teach "git checkout" and "git switch" to accept --autostash and
--no-autostash options that automatically create a temporary stash
entry before the branch switch begins and apply it after the switch
completes.  If the stash application results in conflicts, the stash
entry is saved to the stash list so the user can resolve them later.

Also add a checkout.autoStash configuration option that enables this
behavior by default, which can be overridden with --no-autostash on
the command line.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: 'autostash' for branch switching

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v2
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v1:

 1:  12194f6fbe ! 1:  be2b697c54 checkout: add --autostash option for branch switching
     @@ Documentation/config/checkout.adoc: with a small number of cores, the default se
       well the parallel version performs.
       
      +`checkout.autoStash`::
     -+	When set to true, automatically create a temporary stash entry
     -+	before the operation begins, and apply it after the operation
     -+	ends.  This means that you can run `git checkout` or `git switch`
     -+	on a dirty worktree.  However, use with care: the final stash
     -+	application after a successful branch switch might result in
     -+	non-trivial conflicts.
     ++	When set to true, enable autostash for `git checkout` and
     ++	`git switch` branch switching operations.  When a branch
     ++	switch would fail because local changes (in the index or the
     ++	working tree) overlap with paths that differ between the
     ++	current and target branch, a temporary stash entry is
     ++	automatically created before the switch and applied after
     ++	it completes.  If the local changes do not overlap with the
     ++	branch difference, the switch proceeds normally without
     ++	stashing.
      +	This option can be overridden by the `--no-autostash` and
      +	`--autostash` options of linkgit:git-checkout[1] and
      +	linkgit:git-switch[1].
     @@ Documentation/git-checkout.adoc: When switching branches with `--merge`, staged
       
      +`--autostash`::
      +`--no-autostash`::
     -+	When switching branches, automatically create a temporary stash
     -+	entry before the operation begins, and apply it after the
     -+	operation ends.  This means that you can switch branches on a
     -+	dirty worktree.  However, use with care: the final stash
     -+	application after a successful branch switch might result in
     -+	non-trivial conflicts.
     ++	When switching branches, if any of the paths that differ
     ++	between the current branch and the target branch have local
     ++	changes (in the index or the working tree), automatically
     ++	create a temporary stash entry before the operation begins,
     ++	and apply it after the operation ends.  If the local changes
     ++	do not overlap with the branch difference, the switch proceeds
     ++	without stashing.  When a stash entry is created and the
     ++	subsequent application results in conflicts, the stash entry
     ++	is saved so that you can use `git stash pop` to recover and
     ++	`git stash drop` when done.  Use with `--force` to always
     ++	stash local changes regardless of conflicts.
      +
       `-p`::
       `--patch`::
     @@ Documentation/git-switch.adoc: should result in deletion of the path).
       
      +`--autostash`::
      +`--no-autostash`::
     -+	Automatically create a temporary stash entry before the
     -+	operation begins, and apply it after the operation ends.
     -+	This means that you can switch branches on a dirty worktree.
     -+	However, use with care: the final stash application after a
     -+	successful branch switch might result in non-trivial
     -+	conflicts.
     ++	When switching branches, if any of the paths that differ
     ++	between the current branch and the target branch have local
     ++	changes (in the index or the working tree), automatically
     ++	create a temporary stash entry before the operation begins,
     ++	and apply it after the operation ends.  If the local changes
     ++	do not overlap with the branch difference, the switch proceeds
     ++	without stashing.  When a stash entry is created and the
     ++	subsequent application results in conflicts, the stash entry
     ++	is saved so that you can use `git stash pop` to recover and
     ++	`git stash drop` when done.  Use with `--force` to always
     ++	stash local changes regardless of conflicts.
      +
       `-q`::
       `--quiet`::
     @@ builtin/checkout.c: struct checkout_opts {
       	int empty_pathspec_ok;
       	int checkout_index;
       	int checkout_worktree;
     +@@ builtin/checkout.c: static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
     + 	release_revisions(&revs);
     + }
     + 
     ++static int checkout_would_clobber_changes(struct branch_info *old_branch_info,
     ++					  struct branch_info *new_branch_info)
     ++{
     ++	struct tree_desc trees[2];
     ++	struct tree *old_tree, *new_tree;
     ++	struct unpack_trees_options topts;
     ++	struct index_state tmp_index = INDEX_STATE_INIT(the_repository);
     ++	const struct object_id *old_commit_oid;
     ++	int ret;
     ++
     ++	if (!new_branch_info->commit)
     ++		return 0;
     ++
     ++	old_commit_oid = old_branch_info->commit ?
     ++		&old_branch_info->commit->object.oid :
     ++		the_hash_algo->empty_tree;
     ++	old_tree = repo_parse_tree_indirect(the_repository, old_commit_oid);
     ++	if (!old_tree)
     ++		return 0;
     ++
     ++	new_tree = repo_get_commit_tree(the_repository,
     ++					new_branch_info->commit);
     ++	if (!new_tree)
     ++		return 0;
     ++	if (repo_parse_tree(the_repository, new_tree) < 0)
     ++		return 0;
     ++
     ++	memset(&topts, 0, sizeof(topts));
     ++	topts.head_idx = -1;
     ++	topts.src_index = the_repository->index;
     ++	topts.dst_index = &tmp_index;
     ++	topts.initial_checkout = is_index_unborn(the_repository->index);
     ++	topts.merge = 1;
     ++	topts.update = 1;
     ++	topts.dry_run = 1;
     ++	topts.quiet = 1;
     ++	topts.fn = twoway_merge;
     ++
     ++	init_tree_desc(&trees[0], &old_tree->object.oid,
     ++		       old_tree->buffer, old_tree->size);
     ++	init_tree_desc(&trees[1], &new_tree->object.oid,
     ++		       new_tree->buffer, new_tree->size);
     ++
     ++	ret = unpack_trees(2, trees, &topts);
     ++	discard_index(&tmp_index);
     ++
     ++	return ret != 0;
     ++}
     ++
     + static int switch_branches(const struct checkout_opts *opts,
     + 			   struct branch_info *new_branch_info)
     + {
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       			do_merge = 0;
       	}
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +	if (opts->autostash) {
      +		if (repo_read_index(the_repository) < 0)
      +			die(_("index file corrupt"));
     -+		create_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
     ++		if (opts->discard_changes ||
     ++		    checkout_would_clobber_changes(&old_branch_info,
     ++						   new_branch_info))
     ++			create_autostash_ref(the_repository,
     ++					     "CHECKOUT_AUTOSTASH");
      +	}
      +
       	if (do_merge) {
     @@ t/t2061-switch-autostash.sh (new)
      +	git checkout main
      +'
      +
     -+test_expect_success 'switch --autostash on dirty worktree' '
     ++test_expect_success 'switch --autostash skips stash when no conflict' '
      +	git branch branch1 other-branch &&
      +	echo dirty >file0 &&
      +	git switch --autostash branch1 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty >expected &&
      +	test_cmp expected file0 &&
      +	git switch main
      +'
      +
     -+test_expect_success 'checkout --autostash on dirty worktree' '
     ++test_expect_success 'checkout --autostash skips stash when no conflict' '
      +	git branch branch2 other-branch &&
      +	echo dirty >file0 &&
      +	git checkout --autostash branch2 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty >expected &&
      +	test_cmp expected file0 &&
      +	git checkout main
      +'
      +
     -+test_expect_success 'switch: checkout.autostash config' '
     ++test_expect_success 'switch: checkout.autostash config skips stash when no conflict' '
      +	git branch branch3 other-branch &&
      +	echo dirty >file0 &&
      +	test_config checkout.autostash true &&
      +	git switch branch3 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty >expected &&
      +	test_cmp expected file0 &&
      +	git switch main
      +'
      +
     -+test_expect_success 'checkout: checkout.autostash config' '
     ++test_expect_success 'checkout: checkout.autostash config skips stash when no conflict' '
      +	git branch branch4 other-branch &&
      +	echo dirty >file0 &&
      +	test_config checkout.autostash true &&
      +	git checkout branch4 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty >expected &&
      +	test_cmp expected file0 &&
      +	git checkout main
     @@ t/t2061-switch-autostash.sh (new)
      +	echo dirty >file0 &&
      +	test_config checkout.autostash false &&
      +	git switch --autostash branch6 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty >expected &&
      +	test_cmp expected file0 &&
      +	git switch main
      +'
      +
     -+test_expect_success 'autostash with dirty index' '
     ++test_expect_success 'autostash with non-conflicting dirty index' '
      +	git branch branch7 other-branch &&
      +	echo dirty-index >file0 &&
      +	git add file0 &&
      +	git switch --autostash branch7 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty-index >expected &&
      +	test_cmp expected file0 &&
      +	git checkout -- file0 &&
     @@ t/t2061-switch-autostash.sh (new)
      +	git switch main
      +'
      +
     -+test_expect_success '--autostash with --merge stashes and switches' '
     ++test_expect_success '--autostash with --merge skips stash when no conflict' '
      +	git branch branch10 other-branch &&
      +	echo dirty >file0 &&
      +	git switch --autostash --merge branch10 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty >expected &&
      +	test_cmp expected file0 &&
      +	git switch main
     @@ t/t2061-switch-autostash.sh (new)
      +	git switch main
      +'
      +
     -+test_expect_success '--autostash with new branch creation' '
     ++test_expect_success '--autostash with new branch creation skips stash' '
      +	echo dirty >file0 &&
      +	git switch --autostash -c branch13 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	echo dirty >expected &&
      +	test_cmp expected file0 &&
      +	git switch main &&
      +	git branch -D branch13
      +'
      +
     ++test_expect_success 'autostash with conflicting changes that apply cleanly' '
     ++	git branch branch14 other-branch &&
     ++	echo file1other >file1 &&
     ++	git switch --autostash branch14 >actual 2>&1 &&
     ++	test_grep "Created autostash" actual &&
     ++	test_grep "Applied autostash" actual &&
     ++	echo file1other >expected &&
     ++	test_cmp expected file1 &&
     ++	git switch main
     ++'
     ++
      +test_done
      
       ## t/t9902-completion.sh ##


 Documentation/config/checkout.adoc |  15 +++
 Documentation/git-checkout.adoc    |  14 +++
 Documentation/git-switch.adoc      |  14 +++
 builtin/checkout.c                 |  69 +++++++++++
 t/meson.build                      |   1 +
 t/t2061-switch-autostash.sh        | 184 +++++++++++++++++++++++++++++
 t/t9902-completion.sh              |   1 +
 7 files changed, 298 insertions(+)
 create mode 100755 t/t2061-switch-autostash.sh

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/checkout.adoc
index e35d212969..268b7b1b8b 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -36,6 +36,21 @@ with a small number of cores, the default sequential checkout often performs
 better. The size and compression level of a repository might also influence how
 well the parallel version performs.
 
+`checkout.autoStash`::
+	When set to true, enable autostash for `git checkout` and
+	`git switch` branch switching operations.  When a branch
+	switch would fail because local changes (in the index or the
+	working tree) overlap with paths that differ between the
+	current and target branch, a temporary stash entry is
+	automatically created before the switch and applied after
+	it completes.  If the local changes do not overlap with the
+	branch difference, the switch proceeds normally without
+	stashing.
+	This option can be overridden by the `--no-autostash` and
+	`--autostash` options of linkgit:git-checkout[1] and
+	linkgit:git-switch[1].
+	Defaults to false.
+
 `checkout.thresholdForParallelism`::
 	When running parallel checkout with a small number of files, the cost
 	of subprocess spawning and inter-process communication might outweigh
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..19da63c5be 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -272,6 +272,20 @@ When switching branches with `--merge`, staged changes may be lost.
 	`merge.conflictStyle` configuration variable.  Possible values are
 	`merge` (default), `diff3`, and `zdiff3`.
 
+`--autostash`::
+`--no-autostash`::
+	When switching branches, if any of the paths that differ
+	between the current branch and the target branch have local
+	changes (in the index or the working tree), automatically
+	create a temporary stash entry before the operation begins,
+	and apply it after the operation ends.  If the local changes
+	do not overlap with the branch difference, the switch proceeds
+	without stashing.  When a stash entry is created and the
+	subsequent application results in conflicts, the stash entry
+	is saved so that you can use `git stash pop` to recover and
+	`git stash drop` when done.  Use with `--force` to always
+	stash local changes regardless of conflicts.
+
 `-p`::
 `--patch`::
 	Interactively select hunks in the difference between the
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..6028479fef 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -142,6 +142,20 @@ should result in deletion of the path).
 	`merge.conflictStyle` configuration variable.  Possible values are
 	`merge` (default), `diff3`, and `zdiff3`.
 
+`--autostash`::
+`--no-autostash`::
+	When switching branches, if any of the paths that differ
+	between the current branch and the target branch have local
+	changes (in the index or the working tree), automatically
+	create a temporary stash entry before the operation begins,
+	and apply it after the operation ends.  If the local changes
+	do not overlap with the branch difference, the switch proceeds
+	without stashing.  When a stash entry is created and the
+	subsequent application results in conflicts, the stash entry
+	is saved so that you can use `git stash pop` to recover and
+	`git stash drop` when done.  Use with `--force` to always
+	stash local changes regardless of conflicts.
+
 `-q`::
 `--quiet`::
 	Quiet, suppress feedback messages.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1d1667fa4c..4a251a8732 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -30,6 +30,7 @@
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "sequencer.h"
 #include "setup.h"
 #include "submodule.h"
 #include "symlinks.h"
@@ -68,6 +69,7 @@ struct checkout_opts {
 	int only_merge_on_switching_branches;
 	int can_switch_when_in_progress;
 	int orphan_from_empty_tree;
+	int autostash;
 	int empty_pathspec_ok;
 	int checkout_index;
 	int checkout_worktree;
@@ -1157,6 +1159,55 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	release_revisions(&revs);
 }
 
+static int checkout_would_clobber_changes(struct branch_info *old_branch_info,
+					  struct branch_info *new_branch_info)
+{
+	struct tree_desc trees[2];
+	struct tree *old_tree, *new_tree;
+	struct unpack_trees_options topts;
+	struct index_state tmp_index = INDEX_STATE_INIT(the_repository);
+	const struct object_id *old_commit_oid;
+	int ret;
+
+	if (!new_branch_info->commit)
+		return 0;
+
+	old_commit_oid = old_branch_info->commit ?
+		&old_branch_info->commit->object.oid :
+		the_hash_algo->empty_tree;
+	old_tree = repo_parse_tree_indirect(the_repository, old_commit_oid);
+	if (!old_tree)
+		return 0;
+
+	new_tree = repo_get_commit_tree(the_repository,
+					new_branch_info->commit);
+	if (!new_tree)
+		return 0;
+	if (repo_parse_tree(the_repository, new_tree) < 0)
+		return 0;
+
+	memset(&topts, 0, sizeof(topts));
+	topts.head_idx = -1;
+	topts.src_index = the_repository->index;
+	topts.dst_index = &tmp_index;
+	topts.initial_checkout = is_index_unborn(the_repository->index);
+	topts.merge = 1;
+	topts.update = 1;
+	topts.dry_run = 1;
+	topts.quiet = 1;
+	topts.fn = twoway_merge;
+
+	init_tree_desc(&trees[0], &old_tree->object.oid,
+		       old_tree->buffer, old_tree->size);
+	init_tree_desc(&trees[1], &new_tree->object.oid,
+		       new_tree->buffer, new_tree->size);
+
+	ret = unpack_trees(2, trees, &topts);
+	discard_index(&tmp_index);
+
+	return ret != 0;
+}
+
 static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
@@ -1202,9 +1253,20 @@ static int switch_branches(const struct checkout_opts *opts,
 			do_merge = 0;
 	}
 
+	if (opts->autostash) {
+		if (repo_read_index(the_repository) < 0)
+			die(_("index file corrupt"));
+		if (opts->discard_changes ||
+		    checkout_would_clobber_changes(&old_branch_info,
+						   new_branch_info))
+			create_autostash_ref(the_repository,
+					     "CHECKOUT_AUTOSTASH");
+	}
+
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
+			apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
 			branch_info_release(&old_branch_info);
 			return ret;
 		}
@@ -1215,6 +1277,8 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
+
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	branch_info_release(&old_branch_info);
 
@@ -1236,6 +1300,10 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.autostash")) {
+		opts->autostash = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
@@ -1745,6 +1813,7 @@ static struct option *add_common_switch_branch_options(
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is using this branch")),
+		OPT_AUTOSTASH(&opts->autostash),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
diff --git a/t/meson.build b/t/meson.build
index f66a73f8a0..0645253d25 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -275,6 +275,7 @@ integration_tests = [
   't2030-unresolve-info.sh',
   't2050-git-dir-relative.sh',
   't2060-switch.sh',
+  't2061-switch-autostash.sh',
   't2070-restore.sh',
   't2071-restore-patch.sh',
   't2072-restore-pathspec-file.sh',
diff --git a/t/t2061-switch-autostash.sh b/t/t2061-switch-autostash.sh
new file mode 100755
index 0000000000..d37d6f4b8b
--- /dev/null
+++ b/t/t2061-switch-autostash.sh
@@ -0,0 +1,184 @@
+#!/bin/sh
+
+test_description='checkout/switch --autostash tests'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo file0content >file0 &&
+	echo file1content >file1 &&
+	git add . &&
+	test_tick &&
+	git commit -m "initial commit" &&
+	git branch other-branch &&
+	echo file1main >file1 &&
+	git add . &&
+	test_tick &&
+	git commit -m "modify file1 on main" &&
+	git checkout other-branch &&
+	echo file1other >file1 &&
+	git add . &&
+	test_tick &&
+	git commit -m "modify file1 on other-branch" &&
+	echo file2content >file2 &&
+	git add . &&
+	test_tick &&
+	git commit -m "add file2 on other-branch" &&
+	git checkout main
+'
+
+test_expect_success 'switch --autostash skips stash when no conflict' '
+	git branch branch1 other-branch &&
+	echo dirty >file0 &&
+	git switch --autostash branch1 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'checkout --autostash skips stash when no conflict' '
+	git branch branch2 other-branch &&
+	echo dirty >file0 &&
+	git checkout --autostash branch2 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git checkout main
+'
+
+test_expect_success 'switch: checkout.autostash config skips stash when no conflict' '
+	git branch branch3 other-branch &&
+	echo dirty >file0 &&
+	test_config checkout.autostash true &&
+	git switch branch3 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'checkout: checkout.autostash config skips stash when no conflict' '
+	git branch branch4 other-branch &&
+	echo dirty >file0 &&
+	test_config checkout.autostash true &&
+	git checkout branch4 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git checkout main
+'
+
+test_expect_success '--no-autostash overrides checkout.autostash' '
+	git branch branch5 other-branch &&
+	echo dirty >file1 &&
+	test_config checkout.autostash true &&
+	test_must_fail git switch --no-autostash branch5 2>stderr &&
+	test_grep ! "Created autostash" stderr &&
+	git checkout -- file1
+'
+
+test_expect_success '--autostash overrides checkout.autostash=false' '
+	git branch branch6 other-branch &&
+	echo dirty >file0 &&
+	test_config checkout.autostash false &&
+	git switch --autostash branch6 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'autostash with non-conflicting dirty index' '
+	git branch branch7 other-branch &&
+	echo dirty-index >file0 &&
+	git add file0 &&
+	git switch --autostash branch7 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty-index >expected &&
+	test_cmp expected file0 &&
+	git checkout -- file0 &&
+	git switch main
+'
+
+test_expect_success 'autostash bypasses conflicting local changes' '
+	git branch branch8 other-branch &&
+	echo dirty >file1 &&
+	test_must_fail git switch branch8 2>stderr &&
+	test_grep "Your local changes" stderr &&
+	git switch --autostash branch8 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard &&
+	git switch main
+'
+
+test_expect_success 'autostash is a no-op with clean worktree' '
+	git branch branch9 other-branch &&
+	git switch --autostash branch9 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	git switch main
+'
+
+test_expect_success '--autostash with --merge skips stash when no conflict' '
+	git branch branch10 other-branch &&
+	echo dirty >file0 &&
+	git switch --autostash --merge branch10 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'autostash with staged conflicting changes' '
+	git branch branch11 other-branch &&
+	echo staged-change >file1 &&
+	git add file1 &&
+	git switch --autostash branch11 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard &&
+	git switch main
+'
+
+test_expect_success '--autostash with --force preserves dirty changes' '
+	git branch branch12 other-branch &&
+	echo dirty-force >file1 &&
+	git switch --autostash --force branch12 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard &&
+	git switch main
+'
+
+test_expect_success '--autostash with new branch creation skips stash' '
+	echo dirty >file0 &&
+	git switch --autostash -c branch13 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main &&
+	git branch -D branch13
+'
+
+test_expect_success 'autostash with conflicting changes that apply cleanly' '
+	git branch branch14 other-branch &&
+	echo file1other >file1 &&
+	git switch --autostash branch14 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo file1other >expected &&
+	test_cmp expected file1 &&
+	git switch main
+'
+
+test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..f33ca543a9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2602,6 +2602,7 @@ test_expect_success 'double dash "git checkout"' '
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
 	--auto-advance Z
+	--autostash Z
 	--progress Z
 	--guess Z
 	--no-guess Z

base-commit: 7f19e4e1b6a3ad259e2ed66033e01e03b8b74c5e
-- 
gitgitgadget
