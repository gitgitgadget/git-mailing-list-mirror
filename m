Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FE372067
	for <git@vger.kernel.org>; Wed, 13 May 2026 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700887; cv=none; b=lE+rLWAs5fdruON3KkM9hW163LYhfExTm19ey4ZwMp5QdbJC2ZUaVAQ6CQPUfJpZHGmTjnOry6hL9Qj6q8TGCdyzyY3DG6e2P4CqvxVmL5SvoPQNag3VUdi9g9JAkRE9mILNmtdxEljuXOVy78kotnkk6/7nvLHucrHTs9uNhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700887; c=relaxed/simple;
	bh=hy/TmYfNWTTgqgMD77Hy7X57EVY9oBZj/Ch4//A229c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u7FxXI12ZyTESjw8PPBCuJREKtm7IORQ27/4VGwUMsonnZ1Xga5PRciBPXW0tXb9tOTOZ4N3dVey+qgkpFtgW5amkVne9NE9o3vnWxvv3i+qKT1T3BvziFGp44HUCMo5bpt6a40dPM/Akmkb0ukYxAqRGN5vxxzmkRSyMKdqwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ3OpWP5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ3OpWP5"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91066394ef8so44256485a.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700884; x=1779305684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx+ybaj/YPOKai1p0cKeSWsZojHfxH9BRKKBb3twe+s=;
        b=BQ3OpWP5goOFXrXuovD/wnIIxxWnIfvcuEgF0xmrkPbvbEByKHVLPunvGJsxYk3Liu
         FLzisvQalKxXdCzHp8LDvEPC7axiVr0sMh/CjofVS7wsJHI0L+5t+AW977JQePZuMVpK
         AVzPdiTr1CLnZzNWstiqyuTD9nUcAKfvdxTJE6dt40qCdbs+u9LqDvKjoVYbTRQJRaaz
         hbQ7xKM60TbVEyfQ5lFJtXbZ6RePN37mPFx+xeCmiLpftKRF56CbsinyAwAKQdEl8tUI
         bNjk2EkJfOUvmYRsLiCGS3g7pERJH+ps78skcabgRzDtingBcX66iwOfffWWGuByW8Yk
         P6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700884; x=1779305684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fx+ybaj/YPOKai1p0cKeSWsZojHfxH9BRKKBb3twe+s=;
        b=dNPXfcSlQ5xmppHcbnQ54lOWZ8ELvsKIsqyxxOCyUGLFS7yKowYB5m1CDjh7aHo71t
         iGpk0ShlP+QLLvReXjcX3YCzJUaThPfRMq8GAGap3zCYbZDGKZuAVckK3Bz2ToUSFMwD
         4De2ZF2WJ0I9XTzVBsHz4NlYCD6qBiRpQAErWWWjqqdhavECvYe5c/wn8SpTdZ7Zt4hc
         ezeNuEyyJBCY2vGWyV2MpjodalRWyEGVzQvywkgOFzFSlu5iuJeRCTFjdk2DbX0/DfFT
         tuwca2/+jiqDiQcLBXOGo7fmfHpUJGi2Gebc7fQhCfx6w7wjId9dT8GsvohkpVoChOG2
         zjyA==
X-Gm-Message-State: AOJu0Yy3e0JyfsSubF3btCV5HiRvbU3y6McoUgchAa5LRZfJXX+irDWx
	LZB/HZXl9r3tmZPwdHcCDJ0yk3IxNI6LfHtsGRuoIJ14o+Gbp4hBjJUxNjRl9w==
X-Gm-Gg: Acq92OEIC9OkqDIEj7dTLKDdkfSoJX58wmjA/u2HJsYwtJBOAUOyAJyG672/3sIj3Ih
	Td7EaUyQerRKkKsOfsPw5OFdxdFYx+1TUN9/dqZK4xhfAFftS9ISVkc55Xvd7hLV/6ZfKpatuLE
	RBPhbpaw9d6ZQjCM4Xr7Eo3v4VeMj+3aE3XtzlwTH83yFgLoryUjHNTU0asC3JKAYyU9bwqS1QB
	uzYWsB14Z9hUeXrg8DJyT8pzegT2K4O3M5v5v/thz8dwAPle+BJkaGFNUy44BYSggrB9junjQlT
	7knRcC764fUCHctHGhzLBNhYhQcRS+1uAyMIu1mt+10hmCu54emO6VdKlZQUbBLu9EMxOpr4jrk
	rM/qmayRqOl1dW2uIuMjI3e8zjjgbcBQsq3RAr5pKk3CoaOpAeZ94fsm2Hf7sugyZPRqZ3mneMG
	CGdf9NOT1mU+VTrGeb7xk8AGI96Ep5nDPG2ro=
X-Received: by 2002:a05:620a:4713:b0:910:87f4:9a05 with SMTP id af79cd13be357-91087f49d79mr261212485a.1.1778700884297;
        Wed, 13 May 2026 12:34:44 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm45569085a.20.2026.05.13.12.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:34:43 -0700 (PDT)
Message-Id: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 19:34:38 +0000
Subject: [PATCH v9 0/5] branch: prune-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * --force no longer has special meaning with --prune-merged; reachability
   is always enforced. Use git branch -D to delete an unmerged branch.
   Matches how git branch's other read/safe actions treat --force.
 * Synopsis drops [-f]; "not fully merged" hint points at git branch -D.
 * Dropped the --prune-merged --force tests.

Harald Nordgren (5):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  37 ++++
 builtin/branch.c                 | 292 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 208 ++++++++++++++++++++++
 4 files changed, 528 insertions(+), 16 deletions(-)


base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v9
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v8:

 1:  22fa8515df = 1:  9324b26091 branch: add --forked <remote>
 2:  b443f0f367 = 2:  2a13e5d4bc branch: let delete_branches warn instead of error on bulk refusal
 3:  3032e9c39a ! 3:  f87e96e99d branch: add --prune-merged <remote>
     @@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
       git branch --forked <remote>...
     -+git branch [-f] --prune-merged <remote>...
     ++git branch --prune-merged <remote>...
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a confi
      ++
      +A branch whose upstream no longer resolves locally is left alone
      +(its disappearance is not, on its own, evidence that the work was
     -+integrated). With `--force` (or `-f`), the reachability check is
     -+skipped and every branch in the candidate set is deleted. The
     -+currently checked-out branch in any worktree is always preserved,
     -+as is the local branch that mirrors _<remote>_'s default branch.
     ++integrated). The currently checked-out branch in any worktree is
     ++always preserved, as is the local branch that mirrors _<remote>_'s
     ++default branch.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
       	return 0;
       }
       
     -+static int prune_merged_branches(int argc, const char **argv, int force,
     -+				 int quiet)
     ++static int prune_merged_branches(int argc, const char **argv, int quiet)
      +{
      +	struct string_list candidates = STRING_LIST_INIT_DUP;
      +	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +
      +	if (deletable.nr)
      +		ret = delete_branches(deletable.nr, deletable.v,
     -+				      1, force,
     ++				      1, 0,
      +				      FILTER_REFS_BRANCHES, quiet,
      +				      1, &n_not_merged);
      +
      +	if (n_not_merged && !quiet)
      +		fprintf(stderr,
      +			Q_("Skipped %d branch that is not fully merged; "
     -+			   "re-run with --force to delete it anyway.\n",
     ++			   "delete it with 'git branch -D' if you are sure.\n",
      +			   "Skipped %d branches that are not fully merged; "
     -+			   "re-run with --force to delete them anyway.\n",
     ++			   "delete them with 'git branch -D' if you are sure.\n",
      +			   n_not_merged),
      +			n_not_merged);
      +
     @@ builtin/branch.c: int cmd_branch(int argc,
       		ret = list_forked_branches(argc, argv);
       		goto out;
      +	} else if (prune_merged) {
     -+		ret = prune_merged_branches(argc, argv, force, quiet);
     ++		ret = prune_merged_branches(argc, argv, quiet);
      +		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	git -C pm-unmerged branch --prune-merged origin 2>err &&
      +	test_grep "not fully merged" err &&
      +	test_grep "Skipped 1 branch" err &&
     -+	test_grep "re-run with --force" err &&
     ++	test_grep "git branch -D" err &&
      +	test_grep ! "If you are sure you want to delete it" err &&
      +	git -C pm-unmerged rev-parse --verify refs/heads/wip
      +'
      +
     -+test_expect_success '--prune-merged --force deletes branches regardless of reachability' '
     -+	test_when_finished "rm -rf pm-force" &&
     -+	git clone pm-upstream pm-force &&
     -+	git -C pm-force checkout -b wip origin/wip &&
     -+	git -C pm-force branch --set-upstream-to=origin/next wip &&
     -+	test_commit -C pm-force local-only &&
     -+	git -C pm-force checkout - &&
     -+
     -+	git -C pm-force branch --force --prune-merged origin &&
     -+
     -+	test_must_fail git -C pm-force rev-parse --verify refs/heads/wip
     -+'
     -+
      +test_expect_success '--prune-merged skips branches whose upstream is gone' '
      +	test_when_finished "rm -rf pm-upstream-gone" &&
      +	git clone pm-upstream pm-upstream-gone &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	git -C pm-head checkout -b one one-commit &&
      +	git -C pm-head branch --set-upstream-to=origin/next one &&
      +
     -+	git -C pm-head branch --force --prune-merged origin &&
     ++	git -C pm-head branch --prune-merged origin &&
      +
      +	git -C pm-head rev-parse --verify refs/heads/one
      +'
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	test_when_finished "rm -rf pm-default" &&
      +	git clone pm-upstream pm-default &&
      +	git -C pm-default checkout --detach &&
     -+	git -C pm-default branch --force --prune-merged origin &&
     ++	git -C pm-default branch --prune-merged origin &&
      +	git -C pm-default rev-parse --verify refs/heads/main
      +'
      +
 4:  dd33309344 ! 4:  19b6d94fa7 branch: add branch.<name>.pruneMerged opt-out
     @@ Documentation/config/branch.adoc: for details).
      +	Explicit deletion via `git branch -d` is unaffected.
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: A branch whose upstream no longer resolves locally is left alone
     - integrated). With `--force` (or `-f`), the reachability check is
     - skipped and every branch in the candidate set is deleted. The
     - currently checked-out branch in any worktree is always preserved,
     --as is the local branch that mirrors _<remote>_'s default branch.
     -+as is any branch with `branch.<name>.pruneMerged` set to `false`,
     -+and the local branch that mirrors _<remote>_'s default branch.
     +@@ Documentation/git-branch.adoc: against whatever the remote-tracking refs say locally.
     + A branch whose upstream no longer resolves locally is left alone
     + (its disappearance is not, on its own, evidence that the work was
     + integrated). The currently checked-out branch in any worktree is
     +-always preserved, as is the local branch that mirrors _<remote>_'s
     ++always preserved, as is any branch with `branch.<name>.pruneMerged`
     ++set to `false`, and the local branch that mirrors _<remote>_'s
     + default branch.
       
       `-v`::
     - `-vv`::
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int force,
     +@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
       	for_each_string_list_item(item, &candidates) {
       		const char *short_name = item->string;
       		struct strbuf full = STRBUF_INIT;
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       			continue;
       		}
       		strbuf_release(&full);
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int force,
     +@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
       		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
       		if (!upstream ||
       		    !refs_ref_exists(get_main_ref_store(the_repository),
     @@ t/t3200-branch.sh: test_expect_success '--prune-merged protects only the default
      +	test_grep "Skipping .one." err
      +'
      +
     -+test_expect_success '--prune-merged --force still honours pruneMerged=false' '
     -+	test_when_finished "rm -rf pm-optout-force" &&
     -+	git clone pm-upstream pm-optout-force &&
     -+	git -C pm-optout-force checkout -b wip origin/wip &&
     -+	git -C pm-optout-force branch --set-upstream-to=origin/next wip &&
     -+	test_commit -C pm-optout-force local-only &&
     -+	git -C pm-optout-force checkout - &&
     -+	git -C pm-optout-force config branch.wip.pruneMerged false &&
     -+
     -+	git -C pm-optout-force branch --force --prune-merged origin &&
     -+
     -+	git -C pm-optout-force rev-parse --verify refs/heads/wip
     -+'
     -+
      +test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
      +	test_when_finished "rm -rf pm-optout-d" &&
      +	git clone pm-upstream pm-optout-d &&
 5:  6e81ed3147 ! 5:  6ae95d3f98 branch: add --all-remotes flag
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
      -git branch --forked <remote>...
     --git branch [-f] --prune-merged <remote>...
     +-git branch --prune-merged <remote>...
      +git branch --forked (<remote>... | --all-remotes)
     -+git branch [-f] --prune-merged (<remote>... | --all-remotes)
     ++git branch --prune-merged (<remote>... | --all-remotes)
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: currently checked-out branch in any worktree is always preserved,
     - as is any branch with `branch.<name>.pruneMerged` set to `false`,
     - and the local branch that mirrors _<remote>_'s default branch.
     +@@ Documentation/git-branch.adoc: always preserved, as is any branch with `branch.<name>.pruneMerged`
     + set to `false`, and the local branch that mirrors _<remote>_'s
     + default branch.
       
      +`--all-remotes`::
      +	With `--forked` or `--prune-merged`, act on every
     @@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
       	return 0;
       }
       
     --static int prune_merged_branches(int argc, const char **argv, int force,
     --				 int quiet)
     +-static int prune_merged_branches(int argc, const char **argv, int quiet)
      +static int prune_merged_branches(int argc, const char **argv,
     -+				 int all_remotes, int force, int quiet)
     ++				 int all_remotes, int quiet)
       {
       	struct string_list candidates = STRING_LIST_INIT_DUP;
       	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int force,
     +@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
       	int n_not_merged = 0;
       	int ret = 0;
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       
      +	if (all_remotes && !forked && !prune_merged)
      +		die(_("--all-remotes requires --forked or --prune-merged"));
     ++
      +
       	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
       	    !show_current && !unset_upstream && !forked && !prune_merged &&
     @@ builtin/branch.c: int cmd_branch(int argc,
      +		ret = list_forked_branches(argc, argv, all_remotes);
       		goto out;
       	} else if (prune_merged) {
     --		ret = prune_merged_branches(argc, argv, force, quiet);
     -+		ret = prune_merged_branches(argc, argv, all_remotes, force, quiet);
     +-		ret = prune_merged_branches(argc, argv, quiet);
     ++		ret = prune_merged_branches(argc, argv, all_remotes, quiet);
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();

-- 
gitgitgadget
