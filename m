Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A03CF03F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512633; cv=none; b=Y+IQt3sCAHCeju8zhSZh4DBT7qbhx4Iz1LyV4Jq2+wMUMM8gckcT1vDZl565IXE0g9nZJGFBhBtXzU0rS2LsTWtAdwtfD+s0iOVMVcVBJwh5YEtNvHHkgH/nEQXbHbiHM4Tf1I3Nr9/3VdxSrcEFgXP0yLY7DiZgL/awFje9cY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512633; c=relaxed/simple;
	bh=IDDNE2yFgtoroH317E7hI9zU/UG6JWh4dho2OYJwX9U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KWvQcweQ3aiMem0uMFoENykkxyPLiQc0Nwa3X8VjUNX9sy4xRUC7TQDrADyHgO7zeVrpbgTPifqJkJIK+PQfZV26oMAtQG3yEt/FroGV0CGcJnzM/r24XTohEr4vAh24yOy6xIxZzUzmPj/cayZj4rIoPualNqYuwrB79OK/Iak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8yAJ9/n; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8yAJ9/n"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915ab38ac14so445056885a.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781512627; x=1782117427; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miOndXAafkZ4OCHEgcfK03ZYqpCDvtUXAgyVIdDoF2U=;
        b=Z8yAJ9/nJpv1sd/8+5cTyJIUPmg9rdAIN6vafS+U2HZ6EI8sLPQtfO2k0FtjHO3fhq
         SN7kZFlvYN6OaRk+dsB1Y94YeUyMegcyxvQUvoneuqI8Fii18gKqYBmMgyeCt4wEMqYi
         Lv7hbCPVmg2zrrXN2N5G/HZuTubOsAyZ6zfpAbKShiavk1O8iAVMJlplLAfPQHCmVOHp
         W4oas6OzmFkCo7oz+tGi/E5JeNFTKPX1sABHSS0ozLKLdY8GOi1Q7tKUNpE7qrMcTTmq
         5CGtdP62m0HedL/yvYt/vhaJCak1NXFFbOaPNIuupYMt/m0TU4ZgAdrYTTx6BOPfr2tZ
         oW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512627; x=1782117427;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miOndXAafkZ4OCHEgcfK03ZYqpCDvtUXAgyVIdDoF2U=;
        b=oj9Za2klI1fpwaxjCQmKpFdmUUByvS+BhvA9wcHNV/a/QhDOdQaz2Q+RUhjlT9QrSt
         yVReqLtyfiOiJtkYNFtdYPCcbwWl90ET4wfm8H8o3PRKkiby3s+U0ycLyTeKGG4OilLz
         yOxBLpljnOA8XGMKHGZfj/DwvliP4IARy6YjyqdrB+Lob2oa0gxIWOUabWkOMzY4WYND
         OySyLWlgAS1KsSvcNvN5eDtmdP5v3huF7V3hxH4oFdTwjzE8+Tx4AQaDAo1YZA6wYeNe
         3+TAU9tp8uVPzFQI+bYRqGwsCSgWoZqNX36m7MeYEiqJ3tM+W/kH72qGh+gc9hIxMl6x
         575A==
X-Gm-Message-State: AOJu0Yw5aSlsJ8NcAeCcNwpLWuNNHbQ7aSjCiAnuB+Y1hLTDqOd6/HyY
	SA7JFb3Oj+rqME/LsI5Vfsp7bIZR7FKTQxB5IUS/I8rretwglRs2WdXwx8TdFA==
X-Gm-Gg: Acq92OHnq6KFpvX4kC9B98Erji9e6zGq/N3gOgnbAsenyy2BCsMBEqG0QpuNxOgDj/g
	Mvdcqn18byVTpVIVH7EvM0SfM3opLe5h/c/plDBgvz+XftCyPBSDd3zXvdi3rYuZGgq1FAAQ5tn
	74B1jkshqT2LccbWRT5rYiuDyyEMehhoXHp8//2ioKgO7GwTHwX6e/rt3Zm1vxt76SW1ADJELhs
	tYNZwrvYQuGStqj/vgLTvQw2sZnrO6awWKFhwvEgTQ7Pp72RK+t8QQptmM0MPUL+8AJEjZoe2OZ
	58gPX35+iPM/Hlx3Z4uCA/VlEyckqJ53xL6nXdELpKBXro4l+tkbt/HChuzPB0cOhHgEk+XV++t
	SLqAbmqFL7b0NosWShUIaC1u/vJGBo7wOC60CWdUjQj4K7EhG3MvBlQu7cHj9JZxTlp/ck34J2w
	k2p+XP/m1NasNnE3Nsp0X5KC17OpEw
X-Received: by 2002:ad4:5c4b:0:b0:8bf:6a92:84b2 with SMTP id 6a1803df08f44-8d44ce619f4mr165683996d6.13.1781512626641;
        Mon, 15 Jun 2026 01:37:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.157.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30570c794sm106189066d6.47.2026.06.15.01.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:37:06 -0700 (PDT)
Message-Id: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 08:37:03 +0000
Subject: [PATCH v2 0/2] rebase: add --squash to fold a range into its first commit
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Rename to rebase --squash.

Harald Nordgren (2):
  t3415: remove prepare-commit-msg hook after use
  rebase: add --squash to fold a range

 Documentation/git-rebase.adoc |  11 ++++
 builtin/rebase.c              |  16 ++++-
 sequencer.c                   |  24 ++++++-
 sequencer.h                   |   2 +-
 t/t3415-rebase-autosquash.sh  | 118 ++++++++++++++++++++++++++++++++++
 5 files changed, 166 insertions(+), 5 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v2
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v1:

 1:  c55b9cd6f7 = 1:  c55b9cd6f7 t3415: remove prepare-commit-msg hook after use
 2:  bd1bc62aa8 ! 2:  22d4276ff5 rebase: add --fixup-all to fold a range
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    rebase: add --fixup-all to fold a range
     +    rebase: add --squash to fold a range
      
          Folding a series of commits into one required either an interactive
          rebase where each commit after the first was hand-edited to "fixup", or
          a "git reset --soft" to the merge base followed by "git commit --amend".
      
     -    Add "git rebase --autosquash --fixup-all [<upstream>]" to do this
     -    directly. It keeps the first commit in the range as a "pick" and turns
     -    every later commit into a "fixup", so the whole range collapses into a
     -    single commit that reuses the first commit's message. With no <upstream>
     -    argument the range is "@{upstream}..HEAD", folding all unpushed commits
     -    into one.
     +    Add "git rebase --squash [<upstream>]" to do this directly. It keeps
     +    the first commit in the range as a "pick" and turns every later commit
     +    into a "fixup", so the whole range collapses into a single commit that
     +    reuses the first commit's message. With no <upstream> argument the range
     +    is "@{upstream}..HEAD", folding all unpushed commits into one.
      
     -    Fold the commits in their original order, so that any fixup!/squash!
     -    commits already present in the range are folded in as well. Allow the
     -    flag only together with --autosquash, and reject --rebase-merges since a
     -    merge commit cannot be folded into another commit.
     +    The option implies the merge backend, so it works on its own without
     +    --autosquash. Fold the commits in their original order, so that any
     +    fixup!/squash! commits already present in the range are folded in as
     +    well. Reject --rebase-merges since a merge commit cannot be folded into
     +    another commit.
      
     +    Inspired-by: Sergey Chernov <serega.morph@gmail.com>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-rebase.adoc ##
     @@ Documentation/git-rebase.adoc: option can be used to override that setting.
       +
       See also INCOMPATIBLE OPTIONS below.
       
     -+--fixup-all::
     -+	Valid only when used with `--autosquash`.  Keep the first commit in
     -+	the range as a `pick` and change every later commit to a `fixup`, so
     -+	the whole range is folded into a single commit that reuses the first
     -+	commit's message.  With no `<upstream>` argument this folds all commits
     -+	since `@{upstream}` into one.  The commits are folded in their original
     -+	order, so any `fixup!`/`squash!` commits already in the range are folded
     -+	in as well.  Cannot be combined with `--rebase-merges`, as a merge
     -+	commit cannot be folded into another commit.
     ++--squash::
     ++	Keep the first commit in the range as a `pick` and change every later
     ++	commit to a `fixup`, so the whole range is folded into a single commit
     ++	that reuses the first commit's message.  With no `<upstream>` argument
     ++	this folds all commits since `@{upstream}` into one.  The commits are
     ++	folded in their original order, so any `fixup!`/`squash!` commits
     ++	already in the range are folded in as well.  Cannot be combined with
     ++	`--rebase-merges`, as a merge commit cannot be folded into another
     ++	commit.
      +
       --autostash::
       --no-autostash::
     @@ Documentation/git-rebase.adoc: are incompatible with the following options:
        * --strategy
        * --strategy-option
        * --autosquash
     -+ * --fixup-all
     ++ * --squash
        * --rebase-merges
        * --interactive
        * --exec
     @@ builtin/rebase.c: struct rebase_options {
       	int allow_rerere_autoupdate;
       	int keep_empty;
       	int autosquash;
     -+	int fixup_all;
     ++	int squash;
       	char *gpg_sign_opt;
       	int autostash;
       	int committer_date_is_author_date;
     @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts,
       		shortrevisions, opts->onto_name, opts->onto,
       		&opts->orig_head->object.oid, &opts->exec,
      -		opts->autosquash, opts->update_refs, &todo_list);
     -+		opts->autosquash, opts->fixup_all, opts->update_refs,
     ++		opts->autosquash, opts->squash, opts->update_refs,
      +		&todo_list);
       
       cleanup:
     @@ builtin/rebase.c: int cmd_rebase(int argc,
       		OPT_BOOL(0, "autosquash", &options.autosquash,
       			 N_("move commits that begin with "
       			    "squash!/fixup! under -i")),
     -+		OPT_BOOL(0, "fixup-all", &options.fixup_all,
     ++		OPT_BOOL(0, "squash", &options.squash,
      +			 N_("fold all commits in the range into the first one")),
       		OPT_BOOL(0, "update-refs", &options.update_refs,
       			 N_("update branches that point to commits "
       			    "that are being rebased")),
     +@@ builtin/rebase.c: int cmd_rebase(int argc,
     + 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
     + 	    (options.action != ACTION_NONE) ||
     + 	    (options.exec.nr > 0) ||
     +-	    options.autosquash == 1) {
     ++	    options.autosquash == 1 ||
     ++	    options.squash) {
     + 		allow_preemptive_ff = 0;
     + 	}
     + 	if (options.committer_date_is_author_date || options.ignore_date)
      @@ builtin/rebase.c: int cmd_rebase(int argc,
       	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
       				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
       
     -+	if (options.fixup_all && options.autosquash != 1)
     -+		die(_("--fixup-all requires --autosquash"));
     -+
     -+	if (options.fixup_all && options.rebase_merges)
     ++	if (options.squash && options.rebase_merges)
      +		die(_("options '%s' and '%s' cannot be used together"),
     -+		    "--fixup-all", "--rebase-merges");
     ++		    "--squash", "--rebase-merges");
     ++
     ++	if (options.squash)
     ++		imply_merge(&options, "--squash");
      +
       	if (options.autosquash == 1) {
       		imply_merge(&options, "--autosquash");
     @@ sequencer.c: static int todo_list_add_update_ref_commands(struct todo_list *todo
       		    struct commit *onto, const struct object_id *orig_head,
       		    struct string_list *commands, unsigned autosquash,
      -		    unsigned update_refs,
     -+		    unsigned fixup_all, unsigned update_refs,
     ++		    unsigned squash, unsigned update_refs,
       		    struct todo_list *todo_list)
       {
       	char shortonto[GIT_MAX_HEXSZ + 1];
     @@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts,
       		return -1;
       
      -	if (autosquash && todo_list_rearrange_squash(todo_list))
     -+	if (fixup_all)
     ++	if (squash)
      +		todo_list_fixup_all_but_first(todo_list);
      +	else if (autosquash && todo_list_rearrange_squash(todo_list))
       		return -1;
     @@ sequencer.h: int complete_action(struct repository *r, struct replay_opts *opts,
       		    struct commit *onto, const struct object_id *orig_head,
       		    struct string_list *commands, unsigned autosquash,
      -		    unsigned update_refs,
     -+		    unsigned fixup_all, unsigned update_refs,
     ++		    unsigned squash, unsigned update_refs,
       		    struct todo_list *todo_list);
       int todo_list_rearrange_squash(struct todo_list *todo_list);
       
     @@ t/t3415-rebase-autosquash.sh: test_expect_success 'pick and fixup respect commit
       	test_commit_message HEAD -m "something"
       '
       
     -+test_expect_success '--fixup-all folds the range into the first commit' '
     ++test_expect_success '--squash folds the range into the first commit' '
      +	git reset --hard base &&
      +	test_commit --no-tag fold1 file_fold a &&
      +	test_commit --no-tag fold2 file_fold b &&
      +	test_commit --no-tag fold3 file_fold c &&
     -+	git rebase --autosquash --fixup-all HEAD~3 &&
     ++	git rebase --squash HEAD~3 &&
      +	test_cmp_rev base HEAD~1 &&
      +	test_commit_message HEAD -m "fold1" &&
      +	echo c >expect &&
      +	test_cmp expect file_fold
      +'
      +
     -+test_expect_success '--fixup-all folds smoothly when a fixup! commit is in the series' '
     ++test_expect_success '--squash folds smoothly when a fixup! commit is in the series' '
      +	git reset --hard base &&
      +	test_commit --no-tag foldA file_fold a &&
      +	test_commit --no-tag foldB file_fold b &&
      +	git commit --allow-empty --fixup HEAD~1 &&
     -+	git rebase --autosquash --fixup-all HEAD~3 &&
     ++	git rebase --squash HEAD~3 &&
      +	test_cmp_rev base HEAD~1 &&
      +	test_commit_message HEAD -m "foldA" &&
      +	echo b >expect &&
      +	test_cmp expect file_fold
      +'
      +
     -+test_expect_success '--fixup-all picks the first commit even if it is a fixup!' '
     ++test_expect_success '--squash picks the first commit even if it is a fixup!' '
      +	git reset --hard base &&
      +	test_commit --no-tag fixupbase file_fix a &&
      +	git commit --allow-empty --fixup HEAD &&
      +	test_commit --no-tag fixuptail file_fix b &&
     -+	git rebase --autosquash --fixup-all HEAD~3 &&
     ++	git rebase --squash HEAD~3 &&
      +	test_cmp_rev base HEAD~1 &&
      +	echo b >expect &&
      +	test_cmp expect file_fix
      +'
      +
     -+test_expect_success '--fixup-all with a single commit in range is a no-op' '
     ++test_expect_success '--squash with a single commit in range is a no-op' '
      +	git reset --hard base &&
      +	test_commit --no-tag solo file_solo a &&
      +	git rev-parse HEAD >expect &&
     -+	git rebase --autosquash --fixup-all HEAD~1 &&
     ++	git rebase --squash HEAD~1 &&
      +	git rev-parse HEAD >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--fixup-all with an empty range succeeds' '
     ++test_expect_success '--squash with an empty range succeeds' '
      +	git reset --hard base &&
     -+	git rebase --autosquash --fixup-all HEAD &&
     ++	git rebase --squash HEAD &&
      +	test_cmp_rev base HEAD
      +'
      +
     -+test_expect_success '--fixup-all skips a dropped commit in the range' '
     ++test_expect_success '--squash skips a dropped commit in the range' '
      +	git reset --hard base &&
      +	test_commit --no-tag fixdrop1 file_drop a &&
      +	git commit --allow-empty -m "empty in the middle" &&
      +	test_commit --no-tag fixdrop3 file_drop b &&
     -+	git rebase --autosquash --empty=drop --fixup-all HEAD~3 &&
     ++	git rebase --squash --empty=drop HEAD~3 &&
      +	test_cmp_rev base HEAD~1 &&
      +	test_commit_message HEAD -m "fixdrop1" &&
      +	echo b >expect &&
      +	test_cmp expect file_drop
      +'
      +
     -+test_expect_success '--fixup-all folds a merge commit in the middle of the range' '
     ++test_expect_success '--squash folds a merge commit in the middle of the range' '
      +	git reset --hard base &&
      +	test_commit --no-tag mid-first &&
      +	git checkout -b mid-side &&
     @@ t/t3415-rebase-autosquash.sh: test_expect_success 'pick and fixup respect commit
      +	git checkout - &&
      +	git merge --no-ff -m "merge mid-side" mid-side &&
      +	test_commit --no-tag mid-last &&
     -+	git rebase --autosquash --fixup-all base &&
     ++	git rebase --squash base &&
      +	test_cmp_rev base HEAD~1 &&
      +	test_commit_message HEAD -m "mid-first" &&
      +	test_path_is_file mid-merged.t
      +'
      +
     -+test_expect_success '--fixup-all keeps the first flattened commit when a merge sorts first' '
     ++test_expect_success '--squash keeps the first flattened commit when a merge sorts first' '
      +	git reset --hard base &&
      +	git checkout -b head-side &&
      +	test_commit --no-tag head-merged &&
      +	git checkout - &&
      +	git merge --no-ff -m "merge head-side" head-side &&
      +	test_commit --no-tag head-last &&
     -+	git rebase --autosquash --fixup-all base &&
     ++	git rebase --squash base &&
      +	test_cmp_rev base HEAD~1 &&
      +	test_commit_message HEAD -m "head-merged" &&
      +	test_path_is_file head-merged.t
      +'
      +
     -+test_expect_success '--fixup-all requires --autosquash' '
     ++test_expect_success '--squash takes precedence over --autosquash' '
      +	git reset --hard base &&
     -+	test_must_fail git rebase --fixup-all HEAD~1 2>err &&
     -+	test_grep "fixup-all requires --autosquash" err &&
     -+	test_must_fail git rebase --no-autosquash --fixup-all HEAD~1 2>err &&
     -+	test_grep "fixup-all requires --autosquash" err
     ++	test_commit --no-tag combo-first &&
     ++	test_commit --no-tag combo-mid &&
     ++	git commit --allow-empty --fixup HEAD~1 &&
     ++	test_commit --no-tag combo-last &&
     ++	git rebase --autosquash --squash base &&
     ++	test_cmp_rev base HEAD~1 &&
     ++	test_commit_message HEAD -m "combo-first"
     ++'
     ++
     ++test_expect_success '--squash folds the range with rebase.autosquash set' '
     ++	test_config rebase.autosquash true &&
     ++	git reset --hard base &&
     ++	test_commit --no-tag cfg-first &&
     ++	test_commit --no-tag cfg-last &&
     ++	git rebase --squash base &&
     ++	test_cmp_rev base HEAD~1 &&
     ++	test_commit_message HEAD -m "cfg-first"
      +'
      +
     -+test_expect_success '--fixup-all and --rebase-merges cannot be combined' '
     ++test_expect_success '--squash and --rebase-merges cannot be combined' '
      +	git reset --hard base &&
     -+	test_must_fail git rebase --autosquash --rebase-merges \
     -+		--fixup-all HEAD~1 2>err &&
     ++	test_must_fail git rebase --rebase-merges --squash HEAD~1 2>err &&
      +	test_grep "cannot be used together" err &&
      +	test_path_is_missing .git/rebase-merge
      +'

-- 
gitgitgadget
