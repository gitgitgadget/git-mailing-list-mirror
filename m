Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611179;
	b=ux3ttjm+jmAopeuXoiyOddxE1I0GHZ5lNqiLnWR5yhd7zn2NbAWvpFcC+6qqNygGF2xx
	 oSDCJCktnSJ7R+Bf+eJqaUdFyuoObTJzcSbNDmDtTkOQfBUHwBTE6tdAEfBFZ6Tuy1jTf
	 5x3u8wmosOl7MfekEQr9wKaXsUHPPVRZYlc9it5efstPf74AHUb55Py3ZK3yUhyO75MAm
	 MO55KB5q8eV+iGoboQ62EkLuUd9rrQbrCefm7r9qx7LrlXwKzXxgAm8pcfq2ygped7XvH
	 ZtB7/yoTqWUbT5Qrr9Vb+sgFs9r/BfF+pQS6NrOwrPzXJyi9/N47Hhm7POpyY5NOxxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ejL+To5+I60oaHRaG+hTNQKsH6+6G8WqCpXad0i1SnM=;
	b=3hv+p5Dvl062sOPrDNaQDMNftN61vzkaZ5OA1yjBjHqR33Uwv/JXJKWnrN6FMew9m4BR
	 GbdgEb4GY0lA+kRMDswTW85veT7p+dYMQRnI7NRVkBzJCEA41OHnJEIwXh+Hd3fBMYkPH
	 H2Gj0xTZphqiP4oETNyGTaev+7WlNfJhhsbJSbCcn+hIBUHdk44cifeP6Zb3AlKML6LPk
	 EM8mPVOB4wtlT6qYPaHBL31dgdQLXV+vWiDEd4XMoo48hcm6G2CJ7EJ61i2gQFgad/DE2
	 6e9trnX7PAQMo0fjuE/u4rlnjQ7eWyZTIAL57FWnMJqS4INDvK/bAGmxIgC0VYk5pzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q1atqjSa;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B8606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5B8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q1atqjSa
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48eee44b908so3349913fac.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 04:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795611178; x=1796215978; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ejL+To5+I60oaHRaG+hTNQKsH6+6G8WqCpXad0i1SnM=;
        b=Q1atqjSaQjM1BD9WEYXjqpn4KhDzhcg/emClKPFzYhlKyvj+8j3hBuS2AIS1YHjQu1
         HRjukma1jocVzIFtQiHYtx9RV4YMYaN2WGj35InfAk68ywXeDbagx2qImAvlA9QqwN76
         1Pa2IhI8RZCbh5zE8wYuRSA3P4mXzdch/myUTXcvacLAZmqowSmYCjbqOjDP71sH5oHt
         xrhHSxclePLQSn+awqg2kyjKhr6hiHcPYn41pyv7fxtl+XyQmGKuzI4eUXGvbiawjeNZ
         ileAUT06zQqO68BgLa5FZ0gFap51SMQKsHdSL7eONz9FA7Xp8UxlmzLWT0PqKt4wnBRh
         xY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611178; x=1796215978;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejL+To5+I60oaHRaG+hTNQKsH6+6G8WqCpXad0i1SnM=;
        b=SBQ5F6+uNe8m5S9/guhzfgPzekMKDOnspzV17vJYjw6r4P6wOQ5FRj2kadrhWcy7Pl
         5x7LM4HE5VJHb4zmxtem3ezmxTf8ZJyn+XudGbbreFLLQiuUePT7pb3uNN+13ePGJGPW
         9IaEZO/Y33se20j3akm+hTOXHNr6gsdWR88KCg3oYdSmttgYWlmYjHWnPaQaoqMDQ1eb
         mOQ9sRfTI0BFNNOC8btX835MD/Bmg4GSlCa7erODY29s55gLq4JlAhLVpBYA+bvmAkUW
         nEeARM3wEeM9J99A/l5Bl0UlWcvVnFn2ppAiRasA/oD2d4EhUkI6UAGsYlFcsHDX8MqS
         +B6A==
X-Gm-Message-State: APuU4Z8KQI4DssYpzIal3VHNCeKwdxJrowUNzfHm6i1sCp6g1QK9jad1
	hyFsmK7tndHECUaOmu+j9FRbQe0vwK52JqkZWnybbOTqVt7SLAIVVJBa1zY+0oZp
X-Gm-Gg: AZFdTZeX41THKHaYCPWfpj+QKVt0PywPpNQn4Sm9GcbhzaAWqQ6SJj/9yE/skutfgTt
	KBPz8GvhULW199nHqvGKxtQR1zzugeL+MuDLFrydfFv9tQbSd6aEN35y9BN6NXEEU9IYAMxqLV1
	ReiNBMPk4yk4tALHRrTlUaivwLjtXGp8xw10JfspfFn2BxAgzqAzxKpgCUXmd1LjH8cNgvfDiUL
	/ZUZ6vtQETYnGPcS3SQPlYIoCINGa735J0IFxuXbNjN7IGfqdIbCqrHlR4ibQTZFa2Sry0p1jKD
	6rBGY0YH3BlEQybC3obYVA0SrwJWXcaZ3Da/wi2PXk7lpjsUGvYPxv/RXuM4GHHzQyWUx/4Dw3L
	MJdTn8t0nUeIB+4Q+q/Uh7joRDRIa3V3fyrZ3jIPS4pmfI3qm4N7F5rtqod5dT1ELne5/Hl8uZP
	UCiIywlNhw+djoOGFxX7t/yTpqZDSVrMpv2bAOVdL6dZlPYNbN/8FygeUMp36eGw2AyOQIvIhzr
	oYXj/8NV0akKMOMsVdBAApiGDHtt9IK8Af+Q/YHxqMNTAONCOuzYrfgD4s49cEOcg/VotittVwu
	6uTTiAsDlaRP67hFQkVLV717IZvZHFyz
X-Received: by 2002:a05:6870:1581:b0:459:fe2:ef54 with SMTP id 586e51a60fabf-4bc7d56f2abmr17157339fac.1.1795611177697;
        Wed, 25 Nov 2026 04:52:57 -0800 (PST)
Received: from [127.0.0.1] ([20.12.245.213])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm15291480fac.0.2026.11.25.04.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:52:56 -0800 (PST)
Message-Id: <pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 12:52:50 +0000
Subject: [PATCH v11 0/5] branch: let --delete-merged find squash merged branches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
never deleted by git branch --delete-merged, because their tips are not
reachable from the upstream. This adds git branch --delete-integrated
<pattern>, which works like --delete-merged and also deletes such a branch
when some upstream commit contains all of its changes. It names that commit
in the output:

Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).


Changes in v11:

 * --dry-run with an operation that does not delete branches now names that
   operation in its error, for example --dry-run is not supported for branch
   renaming. It used to say --dry-run can only be used when deleting
   branches.
 * The --dry-run documentation says that other operations do not support it.

Changes in v10:

 * The file merge is now a plain text merge that ignores merge drivers set
   in .gitattributes. With a driver that favors one side, such as union, a
   branch could be deleted although its change was nowhere upstream. This
   also drops the index read added in v6.
 * Fix a branch that replaced a file or a submodule with a directory never
   being found as landed.
 * New commit: --dry-run also works with -d and -D. It is still rejected
   with options that do not delete branches.
 * Print the "Deleted" and "Would delete" messages in delete_branches() from
   one table of templates.
 * Rename branch_opted_out() to opted_out_of_delete_merged().
 * Reword the subject of the --delete-integrated commit to say "rebased or
   squash-merged branches".
 * Add tests for --dry-run, --quiet and branch.<name>.deleteMerged=false
   with --delete-integrated.

Changes in v9:

 * Fix --delete-integrated dying with "unable to read blob object" when a
   path was a submodule at the fork point and both the branch and upstream
   replaced it with different regular files. Such a branch is now kept.
 * Add a test for that case.

Changes in v8:

 * Reword commit messages.

Changes in v7:

 * Added a test that --delete-integrated keeps a branch whose changes did
   not land.
 * Read the index once before the walk in find_landed_commits(), instead of
   for every file merge at every candidate commit.
 * The commit message now says the merge uses this repository's attributes
   from the working tree and the index.

Changes in v6:

 * Read the index before the file merge, so .gitattributes that are only in
   the index are honored too.
 * Renamed the diff_options variables from opt to diffopt.

Changes in v5:

 * git branch -h lists --delete-integrated in the usage lines
 * Giving both --delete-merged and --delete-integrated dies with a short
   "cannot be used together" message instead of the full usage text

Changes in v4:

 * --delete-merged works as it does on master again: it only deletes
   branches whose tip is reachable from their upstream
 * New --delete-integrated <pattern> also deletes branches that were rebase
   or squash merged, including those squashed after upstream changed the
   same files. It replaces --squashed
 * New prep commit lets delete_branches() take a map of where each branch
   landed, so "landed as" is printed there
 * Added Junio's test that --delete-merged keeps a branch when an unrelated
   upstream commit adds an identical file
 * --dry-run works with either option, and the two options can't be combined

Changes in v3:

 * Split into multiple commits, one for rebase merges and one for squash
   merges.
 * By default a branch counts as merged when an upstream commit has its
   exact version of every file it changed. This never reads file contents,
   so it stays cheap in a partial clone. It finds rebase merges, and squash
   merges where upstream left those files alone.
 * Replace --no-squashed with an opt-in --squashed, which also finds
   branches merged after upstream changed the same files by merging those
   files.
 * Add a test for a rebase merge, and check that a squash onto changed files
   is kept without --squashed and deleted with it.

Changes in v2:

 * Diff each upstream commit once and share the result between all branches,
   faster than v1.
 * Fix a branch merged with a merge commit being reported as "landed as" the
   merge when another branch was searched first, and add a test for it. Show
   the topic commit itself in "landed as" for work that arrived through a
   merge.
 * Use git merge --squash as the example in the commit message and mention
   GitHub's squash and rebase buttons.
 * Add --no-squashed to skip the squash search.

cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com cc: "D. Ben
Knoble" ben.knoble@gmail.com cc: Phillip Wood phillip.wood123@gmail.com cc:
Jasper Mayone me@jaspermayone.com cc: Tuomas Ahola taahol@utu.fi

Harald Nordgren (5):
  branch: move the deleteMerged opt-out check into a helper
  branch: let delete_branches() name where a branch landed
  branch: let --dry-run preview -d and -D
  branch: add --delete-integrated for rebased or squash-merged branches
  branch: let --delete-integrated find branches merged onto changed
    files

 Documentation/config/branch.adoc |   8 +-
 Documentation/git-branch.adoc    |  27 +-
 builtin/branch.c                 | 407 ++++++++++++++++++++++---
 t/t3200-branch.sh                | 497 ++++++++++++++++++++++++++++++-
 4 files changed, 892 insertions(+), 47 deletions(-)


base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v11
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v10:

 1:  bccb3f4647 = 1:  ea62fc8787 branch: move the deleteMerged opt-out check into a helper
 2:  efdf710038 = 2:  15f4787502 branch: let delete_branches() name where a branch landed
 3:  43b6b02f69 ! 3:  339a1d1f2c branch: let --dry-run preview -d and -D
     @@ Commit message
          A branch that cannot be deleted, for example because it is checked out
          or not fully merged, gives the same error as without --dry-run.
      
     -    --dry-run is still rejected with options that do not delete branches,
     -    where there is nothing to preview.
     +    The other operations, such as creating, renaming or copying a branch,
     +    have no preview. --dry-run with one of them stops with a message that
     +    names the operation:
     +
     +        $ git branch --dry-run -m foo bar
     +        fatal: --dry-run is not supported for branch renaming
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: silently skipped. Delete it with `git branch -D`
      +	would be deleted and exit without touching any ref.  A branch
      +	that cannot be deleted is reported as an error, the same as
      +	without `--dry-run`.  Useful for sanity-checking a wide pattern
     -+	like `'origin/*'` before committing to the deletion.
     ++	like `'origin/*'` before committing to the deletion.  Other
     ++	operations, such as creating or renaming a branch, do not
     ++	support it.
       
       `-v`::
       `-vv`::
     @@ builtin/branch.c: int cmd_branch(int argc,
       
      -	if (dry_run && !delete_merged.nr)
      -		die(_("--dry-run requires --delete-merged"));
     -+	if (dry_run && !delete && !delete_merged.nr)
     -+		die(_("--dry-run can only be used when deleting branches"));
     ++	if (dry_run && !delete && !delete_merged.nr) {
     ++		if (rename)
     ++			die(_("--dry-run is not supported for branch renaming"));
     ++		if (copy)
     ++			die(_("--dry-run is not supported for branch copying"));
     ++		if (!noncreate_actions)
     ++			die(_("--dry-run is not supported for branch creation"));
     ++		die(_("--dry-run is not supported for this operation"));
     ++	}
       
       	if (recurse_submodules_explicit) {
       		if (!submodule_propagate_branches)
     @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=f
       '
       
      -test_expect_success '--dry-run without --delete-merged is rejected' '
     +-	test_must_fail git -C forked branch --dry-run 2>err &&
     +-	test_grep "requires --delete-merged" err
      +test_expect_success '--dry-run with -d and -D deletes nothing' '
      +	setup_repo_for_delete_merged &&
      +	create_merged_branch merged &&
     @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=f
      +	)
      +'
      +
     -+test_expect_success '--dry-run is rejected when not deleting branches' '
     - 	test_must_fail git -C forked branch --dry-run 2>err &&
     --	test_grep "requires --delete-merged" err
     -+	test_grep "can only be used when deleting branches" err
     ++test_expect_success '--dry-run is not supported when not deleting branches' '
     ++	(
     ++		cd forked &&
     ++		test_must_fail git branch --dry-run new-branch 2>err &&
     ++		test_grep "not supported for branch creation" err &&
     ++		test_must_fail git branch --dry-run -m new-name 2>err &&
     ++		test_grep "not supported for branch renaming" err &&
     ++		test_must_fail git branch --dry-run -c new-copy 2>err &&
     ++		test_grep "not supported for branch copying" err &&
     ++		test_must_fail git branch --dry-run 2>err &&
     ++		test_grep "not supported for this operation" err
     ++	)
       '
       
       test_done
 4:  d691a0463f ! 4:  4b8282f2a5 branch: add --delete-integrated for rebased or squash-merged branches
     @@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into
      -	would be deleted and exit without touching any ref.  A branch
      -	that cannot be deleted is reported as an error, the same as
      -	without `--dry-run`.  Useful for sanity-checking a wide pattern
     --	like `'origin/*'` before committing to the deletion.
     +-	like `'origin/*'` before committing to the deletion.  Other
     +-	operations, such as creating or renaming a branch, do not
     +-	support it.
      +	With `-d`, `-D`, `--delete-merged` or `--delete-integrated`,
      +	print which branches would be deleted and exit without touching
      +	any ref.  A branch that cannot be deleted is reported as an
      +	error, the same as without `--dry-run`.  Useful for
      +	sanity-checking a wide pattern like `'origin/*'` before
     -+	committing to the deletion.
     ++	committing to the deletion.  Other operations, such as creating
     ++	or renaming a branch, do not support it.
       
       `-v`::
       `-vv`::
     @@ builtin/branch.c: int cmd_branch(int argc,
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     --	if (dry_run && !delete && !delete_merged.nr)
     -+	if (dry_run && !delete && !delete_merged.nr && !delete_integrated.nr)
     - 		die(_("--dry-run can only be used when deleting branches"));
     - 
     - 	if (recurse_submodules_explicit) {
     +-	if (dry_run && !delete && !delete_merged.nr) {
     ++	if (dry_run && !delete && !delete_merged.nr && !delete_integrated.nr) {
     + 		if (rename)
     + 			die(_("--dry-run is not supported for branch renaming"));
     + 		if (copy)
      @@ builtin/branch.c: int cmd_branch(int argc,
       					     (quiet ? DELETE_BRANCH_QUIET : 0) |
       					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged honours branch.<name>.de
       test_expect_success "branch -d still deletes a deleteMerged=false branch" '
       	setup_repo_for_delete_merged &&
       	create_merged_branch kept &&
     -@@ t/t3200-branch.sh: test_expect_success '--dry-run is rejected when not deleting branches' '
     - 	test_grep "can only be used when deleting branches" err
     +@@ t/t3200-branch.sh: test_expect_success '--dry-run is not supported when not deleting branches' '
     + 	)
       '
       
      +test_expect_success '--delete-integrated cannot be combined with --delete-merged' '
 5:  5718110ba2 = 5:  daed6147ec branch: let --delete-integrated find branches merged onto changed files

-- 
gitgitgadget
