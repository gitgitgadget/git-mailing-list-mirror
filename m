Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7FC344D88
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782635354; cv=none; b=beAZBgjq+O2TsvUHehjtsqJdpklDlRe5/EHSJx/G/657757i2CSy49BrrquGGoBiCWsl8KBW0huu5L/PfVEdhnDG9t8JbSOPQVIZudMAFAPi5F+Lr9YFFaya7V/2RohXoY33yuYbEI5W2uH/gM21kZO6OjAmjTaYxlM9T/XqSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782635354; c=relaxed/simple;
	bh=6eet+l5Symhgto11infPwUypHYobF/le6ZkJ19iEpq4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lLJRi6JKNg68bjJKCxErhqtTLekPUbShTJ2IPfbG/UkMzDso4syETtF6rcs1uRA4YHEPjyiPJUwq6PzxERnzFnyks+TMm7Z4VO+P3k4/Ey+jwpJ/cLzr5FPdwXEjlkrT0JQlK6bxrGyIzGi7+H9DAVIyOgBKQYEeNkrsqXXUi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5kR53Xs; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5kR53Xs"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13986d61b4eso5812906c88.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782635352; x=1783240152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg/PBg0SdxxHYnxVo3Yx/zwW7gMcMGtcZLme0U0jG4k=;
        b=M5kR53Xs30u8fQLbf9uJAQIpCn/ZnbqJcWiqxVb0KkjklCkTPxZt0qp1d1ZQZ0finZ
         k7xFzy4fAmic2lB7ekGuq/lFb96iShg3/ulIl4vGizwRn4p9WybQE/rLkSRFEa/yb+ln
         vxPgbiw08ucWtbAISmeVD73wDjqbYa1EzMTFFw+kbYS2EhFbVqMwDEmyfsHvWI57fTyV
         jDDRdYO01MDKU1VDi0P2QABgUWwxubhGg1ZkHOnpBvpkA/gAlEoM+FdzpCNK72EACQUo
         hEJmDXYc1KrgRShdKiHTjp5A09lnoTac615hAF5v0hOxiUFUf9lV4zVbg9jhGqNYv4jV
         279A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782635352; x=1783240152;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qg/PBg0SdxxHYnxVo3Yx/zwW7gMcMGtcZLme0U0jG4k=;
        b=YvoiEBUZVV0M/QPaQT2H8M+t3E+gXU40RZxTrmkDDy7vxgq3MU2+PT72k2J8RA+tq0
         VdQ+geIv+ImjTxf28D/uPvHZi++anv9Q7YOOjo/l1YiBae1ZpJb8OFMOwtwlXKpcXyIo
         k68mU86OyI9nukVcbxwxPayRbme+SfZCiPjnUUgzhY8VBJ4b3OuirJtEJz2bS/mNlRAQ
         vtIlH403cOTeU4cAphcR3xEqT5ewD6GMoNc0J5V5xqiO2ESUOe0Fo5xyxMhIcKhx304L
         okCu+K2MtKDgFNCKf8q7Ezh0Ja1u8x7m3GkYt9OgPvzPMV5FUtanVQk4VkRq5/yi+AkZ
         Wptg==
X-Gm-Message-State: AOJu0YzjSRPUbcdBflMJg0fpSlj/XC78c5PNeEOpqdxUNACH79JmuyEV
	S0oJedoMOREYzI/2hjJ/F555YQ7R6ySX04gqkeW9yUfYg8EAo5LBsZ8oWB6c9w==
X-Gm-Gg: AfdE7ckHaFvWrUB2CG1hSy7cYyen5uGgnw5495kblKT8orIK73kICwYrOpCcGVKEzhJ
	RhqXOIqogUH7hBW6Lj3pQFim2ykKM7p80tw5To45jQtu7OliFjJaD2nzx73dOl4TLa6mVo6JE3a
	7fQ2NeW+Mbyt0lIgcUJtGzIDTRHq9il9zrn4fVYbNUIEst7H9FoAY7Rd4d+nxNXYukCskcyIL8t
	+xBRDE/qtg3n+mZGmC1ItxqN1sJBA8FIwkwgel877ZN8Z9KIU/x86+l1wh437tYME92ojCtXOlk
	aC97P2RQfzAr2M5ZdZ0PJcPhYMpVteUWluu7k0oLs6udYMjjHeergIuqr3Om8+XcexzTEUmCLvM
	Q1ZRQ9I30kitYPTDzPnmqdrD+NUJPSY3n4Li9PMHa1t1zBHCnfaSiTTCv+v+KWKnuyAVKlRSpWN
	HdtzKQN3aEtwHxbw==
X-Received: by 2002:a05:7300:2203:b0:305:56a:c38f with SMTP id 5a478bee46e88-30cab3855f1mr6993902eec.26.1782635351531;
        Sun, 28 Jun 2026 01:29:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.186.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30cf86deed5sm14109427eec.1.2026.06.28.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:29:10 -0700 (PDT)
Message-Id: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 08:29:05 +0000
Subject: [PATCH v6 0/4] history: add squash subcommand to fold a range
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

Adds git history squash <revision-range> to fold a range of commits.

Changes in v6:

 * git history squash now accepts multiple revision arguments, read like the
   arguments to git-rev-list, so a compound range such as @~3.. ^topic
   works.
 * The base to reparent onto is now the oldest in-range commit's parent; a
   boundary other than that base means the range has more than one base and
   is rejected. This also fixes the earlier overly-restrictive handling of
   merges and side branches.
 * A single-commit range (e.g. @^!) is rejected with "nothing to squash"
   (this also covers the @^!-style example that previously succeeded
   silently).
 * Commit messages reworded: the squash commit now gives an overview of
   fixup!/squash!/amend! handling, rewording, merge-parent and ref behavior.

Changes in v5:

 * The range walk now uses --ancestry-path, so only commits descended from
   the base are folded; a single revision such as HEAD or HEAD~1 is now
   rejected as "not a <base>..<tip> range" rather than treated as a squash
   down to the root.
 * This adopts the --ancestry-path suggestion; the multi-base rejection is
   unchanged, so a side branch that forked before the base and merged in is
   still refused.
 * Added tests covering more merge topologies: two interior merges, a nested
   merge, an octopus merge, an octopus arm forked before the base, a merge
   among the descendants replayed above the range, and a ref pointing at an
   interior merge commit.

Changes in v4:

 * git history squash now detects when another ref points at a commit inside
   the range being folded and refuses, with an advice.historyUpdateRefs hint
   to use --update-refs=head.
 * A merge inside the range is folded fine as long as the range has a single
   base; a range with merge commit at the tip or base also folds correctly.
   Only a range with more than one base is rejected.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (4):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  history: add squash subcommand to fold a range
  history: re-edit a squash with every message

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  29 ++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 357 +++++++++++++++++---
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 550 +++++++++++++++++++++++++++++++
 7 files changed, 905 insertions(+), 38 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 6c3d7b73556db708feb3b16232fab1efc4353428
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v6
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v5:

 1:  0f1ae9b05a = 1:  fea6b79e60 history: extract helper for a commit's parent tree
 2:  a97ffab1e6 = 2:  e2674e0bc4 history: give commit_tree_ext a message template
 3:  04e18ef979 ! 3:  811e393ab4 history: add squash subcommand to fold a range
     @@ Commit message
      
          Add "git history squash <revision-range>" to do this directly. It folds
          every commit in the range into the oldest one, keeping that commit's
     -    message and authorship and taking the tree of the newest commit, so the
     -    range collapses into a single commit. Commits above the range are
     -    replayed on top of the result.
     +    message and authorship and taking the tree of the newest commit, then
     +    replays the commits above the range on top. fixup!, squash! and amend!
     +    commits are folded like any other and are not interpreted, so the
     +    squashed message comes from the oldest commit, or from an editor with
     +    --reedit-message.
      
     -    The range is given as <base>..<tip>, so "git history squash @~3.."
     -    folds the three most recent commits and "git history squash @~5..@~2"
     -    squashes an interior range. A merge inside the range is folded like any
     -    other commit, but the range must have a single base, so a range with
     -    more than one entry point is rejected.
     -
     -    The folded commits leave the history, so by default the command refuses
     -    when another ref points at one of them. Use "--update-refs=head" to
     -    rewrite only the current branch and leave those refs untouched.
     +    The range is read like the arguments to "git rev-list", so several
     +    arguments such as "@~3.. ^topic" are allowed. A merge inside the range
     +    is folded when its other parent is reachable from the base, otherwise
     +    the range has more than one base and is rejected. By default the command
     +    also refuses when a ref points at a commit that the fold would discard.
     +    Use --update-refs=head to rewrite only the current branch instead.
      
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +the commit just below the oldest commit to squash. For example, `git
      +history squash @~3..` folds the three most recent commits into one, and
      +`git history squash @~5..@~2` squashes an interior range while leaving
     -+the two newest commits in place.
     ++the two newest commits in place. _<revision-range>_ is read like the
     ++arguments to linkgit:git-rev-list[1], so several arguments may be given,
     ++for example `@~3.. ^topic` to additionally exclude what is already on
     ++`topic`.
      ++
      +The oldest commit's message and authorship are preserved by default,
      +unless you specify `--reedit-message`. A merge commit inside the range is
     @@ builtin/history.c: out:
      + * but the range must have a single base and must not reach a root commit.
      + */
      +static int resolve_squash_range(struct repository *repo,
     -+				const char *range,
     ++				const char **argv,
      +				struct commit **base_out,
      +				struct commit **oldest_out,
      +				struct commit **tip_out,
     @@ builtin/history.c: out:
      +{
      +	struct rev_info revs;
      +	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
     ++	struct commit_list *boundaries = NULL, *b;
      +	struct strvec args = STRVEC_INIT;
      +	size_t i;
      +	int ret;
     @@ builtin/history.c: out:
      +	strvec_push(&args, "--topo-order");
      +	strvec_push(&args, "--boundary");
      +	strvec_push(&args, "--ancestry-path");
     -+	strvec_push(&args, range);
     ++	strvec_pushv(&args, argv);
      +	setup_revisions_from_strvec(&args, &revs, NULL);
      +	if (args.nr != 1) {
     -+		ret = error(_("'%s' does not name a revision range"), range);
     ++		ret = error(_("unrecognized argument: %s"), args.v[1]);
      +		goto out;
      +	}
      +
      +	/*
     -+	 * A squash needs a base to reparent onto, so the argument has to
     -+	 * exclude something, as in "<base>..<tip>". A single revision has no
     -+	 * such bottom commit and cannot be squashed.
     ++	 * A squash needs a base to reparent onto, so the range has to exclude
     ++	 * something, as in "<base>..<tip>". A revision range with no such
     ++	 * bottom commit cannot be squashed.
      +	 */
      +	for (i = 0; i < revs.cmdline.nr; i++)
      +		if (revs.cmdline.rev[i].flags & UNINTERESTING)
      +			break;
      +	if (i == revs.cmdline.nr) {
     -+		ret = error(_("'%s' is not a '<base>..<tip>' range"), range);
     ++		ret = error(_("not a '<base>..<tip>' revision range"));
      +		goto out;
      +	}
      +
     @@ builtin/history.c: out:
      +
      +	while ((commit = get_revision(&revs))) {
      +		if (commit->object.flags & BOUNDARY) {
     -+			if (base) {
     -+				ret = error(_("range '%s' has more than one base; "
     -+					      "cannot squash"), range);
     -+				goto out;
     -+			}
     -+			base = commit;
     ++			commit_list_insert(commit, &boundaries);
      +			continue;
      +		}
      +		if (!oldest)
     @@ builtin/history.c: out:
      +	}
      +
      +	if (!oldest) {
     -+		ret = error(_("the range '%s' is empty"), range);
     ++		ret = error(_("the revision range is empty"));
     ++		goto out;
     ++	}
     ++
     ++	if (oldest == tip) {
     ++		ret = error(_("the revision range holds a single commit; "
     ++			      "nothing to squash"));
      +		goto out;
      +	}
      +
     -+	if (!base)
     -+		BUG("a non-empty range must have a boundary commit");
     ++	if (!oldest->parents)
     ++		BUG("an in-range commit must have a parent");
     ++	base = oldest->parents->item;
     ++
     ++	/*
     ++	 * A boundary other than the base is an in-range commit reaching a
     ++	 * commit outside the range, so the range has more than one base.
     ++	 */
     ++	for (b = boundaries; b; b = b->next) {
     ++		if (b->item != base) {
     ++			ret = error(_("the revision range has more than one base; "
     ++				      "cannot squash"));
     ++			goto out;
     ++		}
     ++	}
      +
      +	*base_out = base;
      +	*oldest_out = oldest;
     @@ builtin/history.c: out:
      +	ret = 0;
      +
      +out:
     ++	commit_list_free(boundaries);
      +	reset_revision_walk();
      +	release_revisions(&revs);
      +	strvec_clear(&args);
     @@ builtin/history.c: out:
      +	int ret;
      +
      +	argc = parse_options(argc, argv, prefix, options, usage, 0);
     -+	if (argc != 1) {
     -+		ret = error(_("command expects a single revision range"));
     ++	if (!argc) {
     ++		ret = error(_("command expects a revision range"));
      +		goto out;
      +	}
      +	repo_config(repo, git_default_config, NULL);
     @@ builtin/history.c: out:
      +	if (action == REF_ACTION_DEFAULT)
      +		action = REF_ACTION_BRANCHES;
      +
     -+	ret = resolve_squash_range(repo, argv[0], &base, &oldest, &tip,
     ++	ret = resolve_squash_range(repo, argv, &base, &oldest, &tip,
      +				   &interior);
      +	if (ret < 0)
      +		goto out;
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'errors on missing range argument' '
      +	test_must_fail git history squash 2>err &&
     -+	test_grep "command expects a single revision range" err
     -+'
     -+
     -+test_expect_success 'errors on too many arguments' '
     -+	test_must_fail git history squash start.. HEAD 2>err &&
     -+	test_grep "command expects a single revision range" err
     ++	test_grep "expects a revision range" err
      +'
      +
      +test_expect_success 'errors on an empty range' '
      +	test_must_fail git history squash HEAD..HEAD 2>err &&
     -+	test_grep "the range .* is empty" err
     ++	test_grep "the revision range is empty" err
      +'
      +
      +test_expect_success 'errors on a single revision that is not a range' '
      +	test_must_fail git history squash HEAD 2>err &&
     -+	test_grep "is not a .*range" err &&
     ++	test_grep "not a .*range" err &&
      +	test_must_fail git history squash HEAD~1 2>err &&
     -+	test_grep "is not a .*range" err
     ++	test_grep "not a .*range" err
     ++'
     ++
     ++test_expect_success 'errors on a range holding a single commit' '
     ++	git reset --hard three &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash "HEAD^!" 2>err &&
     ++	test_grep "single commit; nothing to squash" err &&
     ++	test_cmp_rev "$head_before" HEAD
     ++'
     ++
     ++test_expect_success 'accepts multiple revision arguments with an exclusion' '
     ++	git reset --hard three &&
     ++	git branch -f keep HEAD~2 &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash start..HEAD ^keep &&
     ++
     ++	git log --format="%s" start..HEAD >actual &&
     ++	cat >expect <<-\EOF &&
     ++	two
     ++	one
     ++	EOF
     ++	test_cmp expect actual &&
     ++	test_cmp_rev keep HEAD~1 &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++
     ++	git branch -D keep
     ++'
     ++
     ++test_expect_success 'squashes a branch the current branch is not on' '
     ++	git reset --hard three &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++	git checkout -b off-history start &&
     ++	test_commit --no-tag off-one off a &&
     ++	test_commit --no-tag off-two off b &&
     ++	git checkout "$main" &&
     ++
     ++	git history squash start..off-history &&
     ++
     ++	git rev-list --count start..off-history >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test_cmp_rev "$head_before" HEAD &&
     ++
     ++	git branch -D off-history
      +'
      +
      +test_expect_success 'squashes a range into a single commit without changing the tree' '
     @@ t/t3455-history-squash.sh (new)
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
      +
     -+test_expect_success 'squashing a single-commit range replays the rest' '
     -+	git reset --hard three &&
     -+	tip_tree=$(git rev-parse HEAD^{tree}) &&
     -+
     -+	git history squash start..@~2 &&
     -+
     -+	git log --format="%s" start..HEAD >actual &&
     -+	cat >expect <<-\EOF &&
     -+	three
     -+	two
     -+	one
     -+	EOF
     -+	test_cmp expect actual &&
     -+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
     -+'
      +
      +test_expect_success 'reuses the message of a fixup! commit in the range' '
      +	git reset --hard start &&
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'squashes a range whose internal merge has a single base' '
      +	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
      +	test_commit --no-tag before-side file b &&
      +	git checkout -b inner-side &&
      +	test_commit --no-tag on-inner-side inner x &&
     -+	git checkout - &&
     ++	git checkout "$main" &&
      +	test_commit --no-tag after-side file c &&
      +	git merge --no-ff -m merge inner-side &&
      +	git branch -D inner-side &&
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'folds a merge of a branch that forked at the base' '
      +	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
      +	git checkout -b base-fork-side &&
      +	test_commit --no-tag base-fork-side side x &&
     -+	git checkout - &&
     ++	git checkout "$main" &&
      +	test_commit --no-tag base-fork-main file b &&
      +	git merge --no-ff -m "merge base-fork-side" base-fork-side &&
      +	git branch -D base-fork-side &&
     @@ t/t3455-history-squash.sh (new)
      +	test_path_is_file side
      +'
      +
     ++test_expect_success 'refuses a merge whose other parent is outside the range' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	git checkout -b outside-parent &&
     ++	test_commit --no-tag outside-parent outside x &&
     ++	git checkout "$main" &&
     ++	test_commit --no-tag outside-main file b &&
     ++	base=$(git rev-parse HEAD) &&
     ++	test_commit --no-tag outside-mid file c &&
     ++	git merge --no-ff -m "merge outside-parent" outside-parent &&
     ++	git branch -D outside-parent &&
     ++	merged=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash "$base.." 2>err &&
     ++	test_grep "more than one base" err &&
     ++	test_cmp_rev "$merged" HEAD
     ++'
     ++
      +test_expect_success 'folds a range whose tip is a merge commit' '
      +	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
      +	test_commit --no-tag tipmerge-base file b &&
      +	git checkout -b tipmerge-side &&
      +	test_commit --no-tag tipmerge-side side x &&
     -+	git checkout - &&
     ++	git checkout "$main" &&
      +	test_commit --no-tag tipmerge-main file c &&
      +	git merge --no-ff -m "merge tipmerge-side" tipmerge-side &&
      +	git branch -D tipmerge-side &&
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'folds a range whose base is a merge commit' '
      +	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
      +	git checkout -b basemerge-side &&
      +	test_commit --no-tag basemerge-side side x &&
     -+	git checkout - &&
     ++	git checkout "$main" &&
      +	test_commit --no-tag basemerge-main file b &&
      +	git merge --no-ff -m "merge basemerge-side" basemerge-side &&
      +	git branch -D basemerge-side &&
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'refuses to squash a range with more than one base' '
      +	git reset --hard start &&
     -+	head_before=$(git rev-parse HEAD) &&
     ++	main=$(git symbolic-ref --short HEAD) &&
      +	git checkout -b forked-before &&
      +	test_commit forked-side fside x &&
     -+	git checkout - &&
     -+	test_commit forked-main file b &&
     ++	git checkout "$main" &&
     ++	test_commit forked-base file b &&
     ++	base=$(git rev-parse HEAD) &&
     ++	test_commit forked-main file c &&
      +	git merge --no-ff -m merge forked-before &&
      +	merged=$(git rev-parse HEAD) &&
      +
     -+	test_must_fail git history squash forked-main.. 2>err &&
     ++	test_must_fail git history squash "$base.." 2>err &&
      +	test_grep "more than one base" err &&
      +	test_cmp_rev "$merged" HEAD
      +'
      +
      +test_expect_success 'folds a range with two interior merges' '
      +	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
      +	test_commit --no-tag two-merge-a file a1 &&
      +	git checkout -b two-merge-s1 &&
      +	test_commit --no-tag two-merge-s1 s1 x &&
     -+	git checkout - &&
     ++	git checkout "$main" &&
      +	git merge --no-ff -m "merge s1" two-merge-s1 &&
      +	test_commit --no-tag two-merge-b file b1 &&
      +	git checkout -b two-merge-s2 &&
      +	test_commit --no-tag two-merge-s2 s2 y &&
     -+	git checkout - &&
     ++	git checkout "$main" &&
      +	git merge --no-ff -m "merge s2" two-merge-s2 &&
      +	git branch -D two-merge-s1 two-merge-s2 &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
     @@ t/t3455-history-squash.sh (new)
      +test_expect_success 'refuses when a descendant above the range is a merge' '
      +	git reset --hard start &&
      +	main=$(git symbolic-ref --short HEAD) &&
     -+	test_commit --no-tag desc-base file b &&
     ++	test_commit --no-tag desc-one file b &&
     ++	test_commit --no-tag desc-two file c &&
      +	git tag desc-tip &&
      +	git checkout -b desc-above &&
      +	test_commit --no-tag desc-above above x &&
      +	git checkout "$main" &&
     -+	test_commit --no-tag desc-main file c &&
     ++	test_commit --no-tag desc-main file d &&
      +	git merge --no-ff -m "merge desc-above" desc-above &&
      +	git branch -D desc-above &&
      +	head_before=$(git rev-parse HEAD) &&
 4:  a758e1f084 ! 4:  4edf012b77 history: re-edit a squash with every message
     @@ Commit message
      
          Gather the messages of every commit in the range, oldest first, and use
          them as the editor template when re-editing, mirroring how "git rebase
     -    -i" presents a squash. The combined message is built before the
     -    descendant walk so it is not disturbed by the flags that walk leaves on
     -    the commits.
     +    -i" presents a squash.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-history.adoc ##
     -@@ Documentation/git-history.adoc: history squash @~3..` folds the three most recent commits into one, and
     - `git history squash @~5..@~2` squashes an interior range while leaving
     - the two newest commits in place.
     +@@ Documentation/git-history.adoc: arguments to linkgit:git-rev-list[1], so several arguments may be given,
     + for example `@~3.. ^topic` to additionally exclude what is already on
     + `topic`.
       +
      -The oldest commit's message and authorship are preserved by default,
      -unless you specify `--reedit-message`. A merge commit inside the range is

-- 
gitgitgadget
