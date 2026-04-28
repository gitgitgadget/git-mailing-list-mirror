Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB40390235
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401558; cv=none; b=O+GZoEj0RMSuHzjxx5VyEYy2yS8BdF9Oz4lFRR0SneMBIOuLF5AtL2+f7t7tRoU5AbuGrLq5SXrxEorp5aFqEqrDVlv1Q09VxCHWCBaSBPDOgTT4XWssEeG9lwHGwaFPFzYqeO5JqW4Kyn7OIPiSrGwl9TyKzja/ZXI+lz140Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401558; c=relaxed/simple;
	bh=2og9n4urrZPhuq2FaeIBiPLXekp0Reafikp5XKkHkZY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q2XzA3IMC9bl1inlXUuSnPEkxitvaXag7nZOhmxs6T1SGGyKKrsGurHb8YtlImZCYcvDE+dv3vr2woyquqn+i2Uw0hFuEqdmXI98+4KTQeHisYeMcHVAvW7N+dNTCX/b9NY0LkXV9ccfYMzLx/2vs2+/1gl862D8QK65QCMGdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwnRsA9o; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwnRsA9o"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c15849aa2cso15753309eec.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777401555; x=1778006355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSIGO5UKIKFK4e78it75EXOvE+FGC3svBOEVINuTfXU=;
        b=kwnRsA9oIgiGQQ/YuF1qX6YnOBnQYjQaqmtIrNu8Diafkilb9MZ8JaA1Pq2jTVqwA8
         Kh6Q9jQv8wQeWUIOcLsGs9rmoymzIVkXZamUwKvp9thXFI6b6Nge++nNpl2coVP63rUK
         f36bQhH6Sqm/XaZfbe3C82M3JbS2i8xTGbyNG4dMMF7BIm38knsUiVmUhtYx+EJr+RON
         Mv5jH7jS7SY1aGIEAevAPcAaSo7eThIjD5+IBeePu8EQemyKuZwwu9uA0Kbo+nETUnHs
         n0H1zfbcdYnaHgZ23v+Sz4x9K4USb04axKbC+m3mj2CPlBGfAGUfnDzAhoa75RsIz5Lw
         pdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401555; x=1778006355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSIGO5UKIKFK4e78it75EXOvE+FGC3svBOEVINuTfXU=;
        b=aXR5tKNF/aq/BJ1ZA0Jk/46fdCHNf4nn7j4GCEB2WEgNiTrJrmnLWiwPTPxlSZi0OV
         X76rpB/VOTrTejmihRXyOSxtaESMT3FovLHlIb9394J0+yHbSnidPnH+TMy6w+ISTOf+
         90crrdSH0Xvn6XK9jBEn4015PoM65ygKXse62CBGLfkIEoa18A6Y8Vm3bnoM1jf7Y756
         y8qzCgF9agZQCTNXSo0dUl5ZgrgeESPNEkhECPv8E9tqFQe76Lr05LYHU9lV9SUrPPqe
         LaJbq0XPeR3txzn3cM3j4tO6KPDA3fvFOPH79Ov/hf0zy198Dd/Y7Sec/N9kYclverZe
         V6XA==
X-Gm-Message-State: AOJu0YyVinyfkYyH4FCrIo69bhPMyhbVqzNETyS54Pdo8BQr10oJqBtx
	yEs7CTWy7JViRBTmxel1Xu4KKsw+ooBmosS/hs0Q5Dh+8KRRTEhVn/AJyTi/Ug==
X-Gm-Gg: AeBDiesjXmCqTAxq23ohT/q6nUtmQACUTgbil6Kfvt/wvgczpeRcQAEECu52mDwmpGf
	7N1zN6MTcJLLKFlDF/DdZpB39qIaI9p7odFZTJiXIeqcNG4gsdjQKyoYzgN0SsaQzBYZISr76cC
	RaVi2qkYX3QzFALAvc854AhTFEThbodnSo1p3PwBMP08/tFavTeBGK311WBpPyNK4ZBBRDCq/L/
	G2aKkQpXZXMccMw2SBf17xWdA98h6BcMV9wCsfqhPWnYL1+7aiB2dpsPEwfEltsqX8QvPIa3M3G
	UVpi3or9bkw5Z8ijrA5uoY2dCNrOvgyI/VbF8Rge6GVmIgEWB0fDBAN8VJNwyaFq/vdvJKboSLN
	mUVQMnDmXQxTwfmW/SidGbCIbsyXlVCGUCVPHG2sqnXxu56kGNHG6WwKvWZ+FiiaxBSqbLvSrby
	yr34IKHj0ok+VcSnmlT/Q/dnfyUPpOrH2HzNas
X-Received: by 2002:a05:7300:f18f:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-2ed09fde4cbmr1957213eec.3.1777401555074;
        Tue, 28 Apr 2026 11:39:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.83.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a0ce710sm2861648eec.19.2026.04.28.11.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:39:14 -0700 (PDT)
Message-Id: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 18:39:07 +0000
Subject: [PATCH v16 0/5] checkout: 'autostash' for branch switching
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * Updated the git checkout and git switch docs to show the actual output
   when using -m to carry local changes across a branch switch, and changed
   "would carry" to "will carry".
 * Rewrote the merge-conflict example in both docs to match the new, more
   concise message printed on autostash conflicts.
 * Replaced the show_unpack_errors flag and old_commit parameter in
   merge_working_tree()/init_topts() with a plain quiet boolean, so the
   caller decides directly whether to suppress unpack errors.
 * Tightened the 'checkout -m with dirty tree' test by replacing a printf
   with a heredoc.
 * Made the 'checkout -m creates a recoverable stash on conflict' test also
   assert the reflog subject of the new stash entry.
 * Replaced two test_grep calls in the 'checkout -m which would overwrite
   untracked file' test with a single test_cmp, which also catches a
   regression where the "would be overwritten" message could end up printed
   twice.

Harald Nordgren (5):
  stash: add --label-ours, --label-theirs, --label-base for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: rollback lock on early returns in merge_working_tree
  checkout -m: autostash when switching branches

 Documentation/git-checkout.adoc |  55 +++++------
 Documentation/git-stash.adoc    |  11 ++-
 Documentation/git-switch.adoc   |  36 ++++---
 builtin/checkout.c              | 166 +++++++++++++++-----------------
 builtin/commit.c                |   3 +-
 builtin/merge.c                 |  15 ++-
 builtin/stash.c                 |  28 ++++--
 sequencer.c                     |  69 +++++++++----
 sequencer.h                     |   7 +-
 t/t3420-rebase-autostash.sh     |  16 +--
 t/t3903-stash.sh                |  24 +++++
 t/t7201-co.sh                   |  71 +++++++++++++-
 t/t7600-merge.sh                |   3 +-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 16 files changed, 343 insertions(+), 180 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v16
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v16
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v15:

 1:  aba8e6a9dc = 1:  aba8e6a9dc stash: add --label-ours, --label-theirs, --label-base for apply
 2:  89e0bfa803 = 2:  89e0bfa803 sequencer: allow create_autostash to run silently
 3:  a428ce7328 = 3:  a428ce7328 sequencer: teach autostash apply to take optional conflict marker labels
 4:  f358424085 = 4:  f358424085 checkout: rollback lock on early returns in merge_working_tree
 5:  96b14db827 ! 5:  07d25fda91 checkout -m: autostash when switching branches
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
       
      -You can give the `-m` flag to the command, which would try a
      -three-way merge:
     -+You can give the `-m` flag to the command, which would carry your local
     ++You can give the `-m` flag to the command, which will carry your local
      +changes to the new branch:
       
       ------------
       $ git checkout -m mytopic
      -Auto-merging frotz
     ++Applied autostash.
      +Switched to branch 'mytopic'
     ++The following paths have local changes:
     ++M	frotz
       ------------
       
      -After this three-way merge, the local modifications are _not_
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
       
      -When a merge conflict happens during switching branches with
      -the `-m` option, you would see something like this:
     -+When the `--merge` (`-m`) option is in effect and the locally
     -+modified files overlap with files that need to be updated by the
     -+branch switch, the changes are stashed and reapplied after the
     -+switch.  If this process results in conflicts, a stash entry is saved
     -+and made available in `git stash list`:
     ++When the `--merge` (`-m`) option is given and the local changes
     ++overlap with the changes in the branch we're switching to, the
     ++changes are stashed and reapplied after the switch.  If this
     ++process results in conflicts, the stash entry is saved and a
     ++message is printed:
       
       ------------
       $ git checkout -m mytopic
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
      -ERROR: Merge conflict in frotz
      -fatal: merge program failed
      -------------
     -+Your local changes are stashed, however, applying it to carry
     -+forward your local changes resulted in conflicts:
     - 
     +-
      -At this point, `git diff` shows the changes cleanly merged as in
      -the previous example, as well as the changes in the conflicted
      -files.  Edit and resolve the conflict and mark it resolved with
      -`git add` as usual:
     -+ - You can try resolving them now.  If you resolved them
     -+   successfully, discard the stash entry with "git stash drop".
     - 
     -+ - Alternatively you can "git reset --hard" if you do not want
     -+   to deal with them right now, and later "git stash pop" to
     -+   recover your local changes.
     - ------------
     +-
     +-------------
      -$ edit frotz
      -$ git add frotz
     --------------
     -+
     -+You can try resolving the conflicts now.  Edit the conflicting files
     -+and mark them resolved with `git add` as usual, then run `git stash
     -+drop` to discard the stash entry.  Alternatively, you can clear the
     -+working tree with `git reset --hard` and recover your local changes
     -+later with `git stash pop`.
     ++Your local changes are stashed, however applying them
     ++resulted in conflicts.  You can either resolve the conflicts
     ++and then discard the stash with "git stash drop", or, if you
     ++do not want to resolve them now, run "git reset --hard" and
     ++apply the local changes later by running "git stash pop".
     + ------------
       
       CONFIGURATION
     - -------------
      
       ## Documentation/git-switch.adoc ##
      @@ Documentation/git-switch.adoc: variable.
     @@ Documentation/git-switch.adoc: $ git switch mytopic
       
      -You can give the `-m` flag to the command, which would try a three-way
      -merge:
     -+You can give the `-m` flag to the command, which would carry your local
     ++You can give the `-m` flag to the command, which will carry your local
      +changes to the new branch:
       
       ------------
       $ git switch -m mytopic
      -Auto-merging frotz
     ++Applied autostash.
      +Switched to branch 'mytopic'
     ++The following paths have local changes:
     ++M	frotz
       ------------
       
      -After this three-way merge, the local modifications are _not_
     @@ builtin/checkout.c: struct checkout_opts {
       	char *name; /* The short name used */
       	char *path; /* The full name of a real branch */
      @@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
     + 	branch->path = strbuf_detach(&buf, NULL);
     + }
       
     - static void init_topts(struct unpack_trees_options *topts, int merge,
     +-static void init_topts(struct unpack_trees_options *topts, int merge,
     ++static void init_topts(struct unpack_trees_options *topts,
       		       int show_progress, int overwrite_ignore,
      -		       struct commit *old_commit)
     -+		       struct commit *old_commit, bool show_unpack_errors)
     ++		       bool quiet)
       {
       	memset(topts, 0, sizeof(*topts));
       	topts->head_idx = -1;
     @@ builtin/checkout.c: static void init_topts(struct unpack_trees_options *topts, i
       	topts->update = 1;
       	topts->merge = 1;
      -	topts->quiet = merge && old_commit;
     -+	topts->quiet = merge && old_commit && !show_unpack_errors;
     ++	topts->quiet = quiet;
       	topts->verbose_update = show_progress;
       	topts->fn = twoway_merge;
       	topts->preserve_ignored = !overwrite_ignore;
     @@ builtin/checkout.c: static void init_topts(struct unpack_trees_options *topts, i
       static int merge_working_tree(const struct checkout_opts *opts,
       			      struct branch_info *old_branch_info,
       			      struct branch_info *new_branch_info,
     --			      int *writeout_error)
     -+			      int *writeout_error,
     -+			      bool show_unpack_errors)
     ++			      bool quiet,
     + 			      int *writeout_error)
       {
       	int ret;
     - 	struct lock_file lock_file = LOCK_INIT;
      @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 		}
       
       		/* 2-way merge to the new branch */
     - 		init_topts(&topts, opts->merge, opts->show_progress,
     +-		init_topts(&topts, opts->merge, opts->show_progress,
      -			   opts->overwrite_ignore, old_branch_info->commit);
     -+			   opts->overwrite_ignore, old_branch_info->commit,
     -+			   show_unpack_errors);
     ++		init_topts(&topts, opts->show_progress,
     ++			   opts->overwrite_ignore, quiet);
       		init_checkout_metadata(&topts.meta, new_branch_info->refname,
       				       new_branch_info->commit ?
       				       &new_branch_info->commit->object.oid :
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	if (do_merge) {
      -		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
     -+					 &writeout_error, false);
     ++					 opts->merge, &writeout_error);
      +		if (ret == MERGE_WORKING_TREE_UNPACK_FAILED && opts->merge) {
      +			strbuf_addf(&autostash_msg,
      +				    "autostash while switching to '%s'",
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +					     autostash_msg.buf, true);
      +			created_autostash = 1;
      +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
     -+						 &writeout_error, true);
     ++						 false, &writeout_error);
      +		}
      +		if (created_autostash) {
      +			if (opts->conflict_style >= 0) {
     @@ t/t7201-co.sh: test_expect_success 'checkout -m with dirty tree' '
       	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
       
      -	printf "M\t%s\n" one >expect.messages &&
     -+	printf "The following paths have local changes:\nM\t%s\n" one >expect.messages &&
     ++	cat >expect.messages <<-\EOF &&
     ++	The following paths have local changes:
     ++	M	one
     ++	EOF
       	test_cmp expect.messages messages &&
       
       	fill "M	one" "A	three" "D	two" >expect.main &&
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	test_grep "git stash drop" actual &&
      +	test_grep "git stash pop" actual &&
      +	test_grep "The following paths have local changes" actual &&
     -+	git show --format=%B --diff-merges=1 refs/stash >actual &&
     ++	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
      +	sed /^index/d actual >actual.trimmed &&
      +	cat >expect <<-EOF &&
     ++	autostash while switching to ${SQ}side${SQ}
      +	On main: autostash while switching to ${SQ}side${SQ}
      +
      +	diff --git a/one b/one
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	>another-file.t &&
      +	fill 1 2 3 4 5 >one &&
      +	test_must_fail git checkout -m @{-1} 2>err &&
     -+	test_grep "would be overwritten by checkout" err &&
     -+	test_grep "another-file.t" err
     ++	q_to_tab >expect <<-\EOF &&
     ++	error: The following untracked working tree files would be overwritten by checkout:
     ++	Qanother-file.t
     ++	Please move or remove them before you switch branches.
     ++	Aborting
     ++	Applied autostash.
     ++	EOF
     ++	test_cmp expect err
      +'
      +
       test_expect_success 'switch to another branch while carrying a deletion' '

-- 
gitgitgadget
