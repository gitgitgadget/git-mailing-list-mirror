Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55694156DC
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053503; cv=none; b=GuroPVl+s4I7Dr0y+G7OtvBrXn+L55WU4hKuf5zBceXvgWu+myt4RLh14oOE8/5eB2fwbjn6w0DCU1h6pa34tLB0IL8z2YnKcT/HlUiorZoRkYylQOp0fJpQcfFLSe9b5b6myuLnASMts3+C+7m9uigrMv5ZBZPW3BM32xKNKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053503; c=relaxed/simple;
	bh=ROfiOuTCmzmXRJ5jGIp7lItNuUslBfHtOaayMxFKz4s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hUqJ3/RXeaVwoMeM88xmz0+sriSUGdOeQe14TyMlkz1YAj5FMbVdg1Xoa60+IvBhaKy2xDGDE3SneOngzDj4at8vEnz9OXL/HV8Dc3dwW62sC/wc/XTMn/r8SHwZV/SfljYeE6+dfH8HA75UhrOSWuZXD0PgMDNXKpRjkuzR0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tE8QUQ5R; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tE8QUQ5R"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3302354a91.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053496; x=1784658296; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rUW8CaFjjok6/JDp6MrhREfokNxfUG2V/iqyOdXkuBM=;
        b=tE8QUQ5R9MktNDwwKjj+aQKXJZPYUAvRBIarBl5Vt8R64+IPRL5Pxt0j83hbaKizQb
         v0bveUFcZPRAn46cl2JEbgPI0E6PTrZ/DgMXllnKMOqs3CtGW7pI17StFnBCf6/J14Vd
         2d6ry2drSXWs3HW5RwnE5b0bGgQP4x+goFDsEy2nyne/h2/GrJPR6pb2QBNI0mgs/xpy
         KgO9lFM3Z+f7h8CGuzI9wQo8PMaYZ+SEuey5ljJeDoKs2XXy9BzABxi2o/pekS7zKnGW
         aXurIS0e7qdtAJq2g/sKlFWWAkhJYR/0M25Qkyt5fhEyuPwg5u0p5lnddx3CC07ppQue
         za2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053496; x=1784658296;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUW8CaFjjok6/JDp6MrhREfokNxfUG2V/iqyOdXkuBM=;
        b=Hg4/X8MM7i+88yV2Us/AXp/WDQf7LvGyXpTjk4a6Fqj+jzqDwH3tt2UC+gGDa3bpT1
         wWrI2WCMF4aci4h9/RYUj3UtanyPWiQTYfu+Plg+AMSiv/skkZUYje32lftk/MB5fNqY
         R96Of8c3HzJbss3FFpNuTgE56HH7WRAzK9TJx5bZJBmQMBVpCLr82oHOvXjVN6Usug54
         YlpuctCoIt6ES3w253IEdpnYnXiPwZeWP3/VMdCT1qd0s9RKz2f+sw0fnvszUrQt5URC
         ItxDYow/5UyP6NyqV20P2HTeBpO6pIby5B87ALx8aHTx6XpBg4zDD/gLVsocpUNt6FtQ
         8ULg==
X-Gm-Message-State: AOJu0YwKKJSLNOmPOsI8pFw5M749laNqmpL+YvnBcFyLHWj6Y+CHAZPf
	BdhRaOEonIbAJdslU+BouwAzYPbt1VtfVdHq53pDKlapuI2nOo2Vz84IA3exAg==
X-Gm-Gg: AfdE7clkU3PDm3OdhBj4SgoSyvo/SZT8OrkbznPuqVXfnppfGhFhcdKepZCqKdnA1mw
	1+yKF64PUHjfXQr4qhiI3XbJXIvlzOFZhepf6ZYvud/MfRlkOaxEXSdUQOglVExmQBv5ZrOl1IP
	ciDq+llkp8dJ47ktjS0zxi7LcRh86gr/OU6b+6pjqXUlVVuzjFK6HvC4CMeDU2mLGrggGYyqaGS
	wrOIU9gYLusG0EDy8AgKG9Z393oDsfFLTu83bC8SwSxYbBcvShVTaNoZO1Kg7E427lZ31g0knON
	lr+dPH3z/LwIv9wNd6Zh+9YVb4afV1GLzC4IF/OZOYkEW6jrKgY5H1dUoWCxTbyzSUp5Nx4ac6f
	lQLJ4iNutCeiXlmCxSHC1d6QxDsyVhP0D4iWlZetq6BIBA3YpFHyz4+q3FCBTqzBXaB/KF5d/YP
	yMQBtKTqDuzlz3ynie
X-Received: by 2002:a17:90b:35c8:b0:387:e0cb:c8dc with SMTP id 98e67ed59e1d1-38e1b00c165mr3467110a91.37.1784053495441;
        Tue, 14 Jul 2026 11:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm50855596eec.7.2026.07.14.11.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:24:54 -0700 (PDT)
Message-Id: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:24:46 +0000
Subject: [PATCH v19 0/7] branch: delete-merged
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Delete branches that have already been merged on upstream.

Changes in v19:

 * Fix bug where dry-run would still remove config, added test coverage.
 * Redesigned --delete-merged as a repeatable upstream selector with
   optional positional patterns limiting deletion scope.
 * Protect same-name upstream branches independently of push-default
   configuration.
 * Simplified flags handling where local caching became complicated when
   mutating values.
 * Clarified assertions in tests.

Changes in v18:

 * Instead of keeping the whole chain of upstream branches, keep only the
   ones an unmerged branch still needs. When a kept (merged) branch in turn
   tracks a branch that is being deleted, clear its now-stale upstream
   config.
 * Rework spare_stacked_bases() to record the kept bases and, in a second
   pass, clear the upstream of any whose own base is going away. Build the
   to-delete list with strset_for_each_entry() instead of re-walking the
   candidate array.

Changes in v17:

 * Keep a merged branch when another surviving branch still tracks it as its
   upstream, so --delete-merged no longer deletes a branch out from under
   one stacked on top of it.
 * Move the --dry-run and branch.<name>.deleteMerged opt-out fully into
   their own commits.

Changes in v16:

 * Convert delete_merged_branches() to take an unsigned int flags argument
   instead of separate quiet/dry_run booleans, matching delete_branches()
 * Reuse the strbuf across the skip-config loop (strbuf_reset per iteration,
   single strbuf_release after) instead of allocating and freeing it each
   time
 * Rewrite the --delete-merged tests as integration tests: branches that
   land commits upstream, with deletion and the checked-out, upstream-gone,
   and push-equals-upstream safety cases exercised together in one run and
   output asserted via test_cmp
 * Collapse the many per-aspect test repos into a single reused repo set up
   by a setup_repo_for_delete_merged helper, and rename helpers off the old
   pm_/prune naming
 * Nest single-repo setup sequences in ( cd ... ) subshells instead of
   prefixing every command with -C

Changes in v15:

 * Renamed --prune-merged to --delete-merged throughout. Not necessarily
   final, but something to advance the discussion.
 * --delete-merged now silently skips not-yet-merged branches instead of
   warning.
 * Initialized the delete_branches() flag locals where declared. Only force
   stays deferred.
 * delete_branches()/check_branch_commit() doc and code cleanups: redundant
   branch NULL checks dropped, ref_array candidates = { 0 }, a BUG() for the
   unreachable non-branch ref, and reworked --delete-merged doc wording.
 * Broadened the --forked tests (local commits for realism, remote add -f,
   --forked coverage), renamed the misleading trunk fixture, and replaced
   the misnamed detached branch with git checkout --detach.

Changes in v14:

 * Fixed a git branch -d -r regression (broke t5404/t5505/t5514): the
   remotes path set a local force but not the DELETE_BRANCH_FORCE bit that
   check_branch_commit() reads, so it wrongly ran the merge check.
 * Made flags the single source of truth in delete_branches() so the bit and
   the derived locals can't disagree.
 * Works locally, but GitHub CI has problems that are there for other
   branches too, hopefully not related
   (https://github.com/git/git/pull/2285).

Changes in v13:

 * Reworked --forked into a real ref-filter applied in apply_ref_filter()
   instead of a post-pass, so non-matching branches are never allocated.
 * Match exact --forked patterns on full refnames (only globs use the
   abbreviated upstream), and dropped the old helper machinery, forward
   declaration, and string_list in favor of a strvec.
 * Replaced the boolean parameters of
   delete_branches()/check_branch_commit() with a single unsigned int flags.
 * --prune-merged now collects candidates via filter_refs() rather than its
   own branch walk.
 * --prune-merged now takes its patterns as positional arguments (e.g. git
   branch --prune-merged origin/main 'feature*') instead of repeating the
   option.

Changes in v12:

 * Reworked --forked from a standalone action into a --list-mode filter.
 * Switched --forked and --prune-merged to repeatable OPT_STRING_LIST
   options.
 * Dropped the bare-remote-name resolution for --forked, the argument is now
   a ref or a glob.

Changes in v11:

 * The flags now take a branch, not a remote. --forked and --prune-merged
   accept a literal upstream short name like origin/main or a wildmatch
   pattern like origin/. The old --all-remotes flag is gone, since origin/
   covers that case.
 * The prune guard now compares @{push} against @{upstream}. A branch is
   spared when these are equal. That is the trunk like case, such as local
   main tracking and pushing to origin/main, where "fully merged to
   upstream" cannot be told apart from "just pulled". Only branches that
   push somewhere other than their upstream, typically fork based topics,
   are candidates. The earlier /HEAD by name guard that the reviewer
   rejected is gone.
 * New --dry-run for --prune-merged.

Changes in v10:

 * --forked / --prune-merged now take a branch glob instead of a remote name
   — origin, origin/*, origin/release-- all work. This replaces the
   remote-only form and subsumes the old --all-remotes flag, which has been
   dropped.
 * New --dry-run for --prune-merged.

Changes in v9:

 * --force no longer has special meaning with --prune-merged; reachability
   is always enforced. Use git branch -D to delete an unmerged branch.
   Matches how git branch's other read/safe actions treat --force.
 * Synopsis drops [-f]; "not fully merged" hint points at git branch -D.
 * Dropped the --prune-merged --force tests.

Changes in v8:

 * Delete only when the branch's work is actually reachable from its
   upstream
 * Skip branches whose upstream is gone (even with --force)
 * Simplified the internal safety flag to live in one place

Changes in v7:

 * --prune-merged now checks if a branch is merged into its own upstream
   first. If the upstream is gone, it checks against the remote's default
   branch instead. If neither exists, the branch is refused (use --force to
   delete anyway).

Changes in v6:

 * --prune-merged now measures merged-ness against the remote's default
   branch instead of the candidate's upstream — so the decision no longer
   depends on which branch happens to be checked out locally.
 * delete_branches() / check_branch_commit() gained a per-candidate override
   that lets a caller substitute a different "what counts as merged"
   reference (or skip the check). branch -d callers pass NULL and keep their
   existing semantics.
 * prune_merged_branches() resolves each candidate's push-remote HEAD and
   threads it through, so --prune-merged --all-remotes measures each
   candidate against its own remote rather than a single global reference.

Changes in v5:

 * Drop commit 'fetch: add --prune-merged'

Changes in v4:

 * Resolve each remote's HEAD and collect the targets into a
   protected_default_refs set in collect_forked_set.
 * In prune_merged_branches, skip a candidate when its upstream is a
   protected default ref and the local branch name matches the default
   branch's leaf name (so a local main tracking origin/main is spared, but a
   renamed trunk tracking origin/main is not).
 * Also skip when the candidate's push ref points at a protected default
   ref, so a topic branch configured to push to origin/main is never pruned.
 * Tests: spare the local default branch; only protect by matching leaf name
   (not by upstream alone); spare a branch whose push ref is the remote
   default.

Changes in v3:

 * s/remote-tracking refs/remote-tracking branches/g

Changes in v2:

 * The whole feature moved out of git fetch and into git branch. git fetch
   --prune-merged now just calls git branch --prune-merged after fetching.
 * The fetch.pruneLocalBranches and remote..pruneLocalBranches config
   options are gone, replaced by per-branch opt-out via branch..pruneMerged.
 * New git branch --forked lists local branches whose upstream lives on the
   given remote (read-only building block).
 * New git branch --prune-merged deletes those branches, but only if their
   tip is reachable from the upstream tracking ref; --force skips that
   safety check.
 * New git branch --all-remotes lets --forked/--prune-merged operate across
   every configured remote at once.
 * The currently checked-out branch in any worktree is always preserved.
 * branch..pruneMerged=false lets you exempt a branch (e.g. a long-running
   topic branch) even with --force; doesn't affect explicit git branch -d.
 * delete_branches() got a warn_only mode so bulk deletion prints a one-line
   warning per skipped branch instead of the noisy four-line hint that git
   branch -d shows.
 * New section in git-branch docs; git-fetch docs trimmed to just mention
   --prune-merged.
 * New tests in t3200-branch.sh for the new branch flags; t5510-fetch.sh
   shrunk since most logic moved.

Harald Nordgren (7):
  branch: add --forked filter for --list mode
  branch: convert delete_branches() to a flags argument
  branch: let delete_branches skip unmerged branches on bulk refusal
  branch: prepare delete_branches for a bulk caller
  branch: add --delete-merged <branch>
  branch: add branch.<name>.deleteMerged opt-out
  branch: add --dry-run for --delete-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  50 ++++-
 builtin/branch.c                 | 284 ++++++++++++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 352 +++++++++++++++++++++++++++++++
 6 files changed, 742 insertions(+), 31 deletions(-)


base-commit: f60db8d575adb79761d363e026fb49bddf330c73
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v19
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v19
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v18:

 1:  3e29ff17bd ! 1:  562648132d branch: add --forked filter for --list mode
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	(
      +		cd forked &&
      +		git remote add -f other ../forked-other &&
     -+		git remote set-head origin one &&
      +		git branch local-base &&
      +		git branch --track local-one origin/one &&
      +		git branch --track local-two origin/two &&
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +		git checkout local-one &&
      +		test_commit --no-tag local-one-work local-one.t &&
      +		git checkout local-foreign &&
     -+		test_commit --no-tag local-foreign-work local-foreign.t &&
     -+		git checkout --detach
     ++		test_commit --no-tag local-foreign-work local-foreign.t
      +	)
      +'
      +
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked composes with --no-merged' '
     -+	test_when_finished "git -C forked checkout --detach" &&
     -+	git -C forked checkout local-one &&
     -+	test_commit -C forked local-only &&
      +	git -C forked branch --forked "origin/*" --no-merged origin/one \
      +		--format="%(refname:short)" >actual &&
      +	echo local-one >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked rejects unknown branch/pattern' '
     -+	test_must_fail git -C forked branch --forked nope 2>err &&
     -+	test_grep "not a valid branch or pattern" err
     -+'
     -+
     -+test_expect_success '--forked requires a value' '
     -+	test_must_fail git -C forked branch --forked 2>err &&
     -+	test_grep "requires a value" err
     -+'
     -+
      +test_expect_success '--forked <remote> uses the branch <remote>/HEAD points at' '
      +	git -C forked branch --forked origin --format="%(refname:short)" >actual &&
     -+	echo local-one >expect &&
     ++	echo main >expect &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success '--forked rejects unknown branch/pattern' '
     ++	test_must_fail git -C forked branch --forked nope 2>err &&
     ++	test_grep "not a valid branch or pattern" err
     ++'
     ++
     ++test_expect_success '--forked requires a value' '
     ++	test_must_fail git -C forked branch --forked 2>err &&
     ++	test_grep "requires a value" err
     ++'
      +
       test_done
 2:  cdd4fea4a7 ! 2:  c7ebd9344c branch: convert delete_branches() to a flags argument
     @@ Metadata
       ## Commit message ##
          branch: convert delete_branches() to a flags argument
      
     -    delete_branches() and check_branch_commit() take a pair of int
     -    booleans (force and quiet) that the next commits would grow further.
     -    Replace them with a single "unsigned int flags" argument and an
     -    enum, splitting the bits back into named bool locals so the body
     -    keeps reading the same named values.
     +    delete_branches() takes separate force and quiet parameters, while
     +    check_branch_commit() takes force. The next commits would grow this
     +    collection further. Replace them with a single unsigned flags argument
     +    and an enum.
     +
     +    Test the FORCE and QUIET bits directly from flags at each use site so
     +    that mutating or forwarding flags cannot leave cached values stale.
      
          No change in behavior.
      
     @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
      -			       int kinds, int force)
      +			       int kinds, unsigned int flags)
       {
     -+	bool force = flags & DELETE_BRANCH_FORCE;
       	struct commit *rev = lookup_commit_reference(the_repository, oid);
     - 	if (!force && !rev) {
     +-	if (!force && !rev) {
     ++	if (!(flags & DELETE_BRANCH_FORCE) && !rev) {
       		error(_("couldn't look up commit object for '%s'"), refname);
     + 		return -1;
     + 	}
     +-	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     ++	if (!(flags & DELETE_BRANCH_FORCE) &&
     ++	    !branch_merged(kinds, branchname, rev, head_rev)) {
     + 		error(_("the branch '%s' is not fully merged"), branchname);
     + 		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
     + 				  _("If you are sure you want to delete it, "
      @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       	strbuf_release(&buf);
       }
     @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       {
       	struct commit *head_rev = NULL;
       	struct object_id oid;
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     - 	int i;
     - 	int ret = 0;
     - 	int remote_branch = 0;
     -+	bool force;
     -+	bool quiet = flags & DELETE_BRANCH_QUIET;
     - 	struct strbuf bname = STRBUF_INIT;
     - 	enum interpret_branch_kind allowed_interpret;
     - 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
       		remote_branch = 1;
       		allowed_interpret = INTERPRET_BRANCH_REMOTE;
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       	}
       	branch_name_pos = strcspn(fmt, "%");
       
     -+	force = flags & DELETE_BRANCH_FORCE;
     -+
     - 	if (!force)
     +-	if (!force)
     ++	if (!(flags & DELETE_BRANCH_FORCE))
       		head_rev = lookup_commit_reference(the_repository, &head_oid);
       
       	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
       
       	next:
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 		char *name = item->string;
     + 		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     + 			char *refname = name + branch_name_pos;
     +-			if (!quiet)
     ++			if (!(flags & DELETE_BRANCH_QUIET))
     + 				printf(remote_branch
     + 					? _("Deleted remote-tracking branch %s (was %s).\n")
     + 					: _("Deleted branch %s (was %s).\n"),
      @@ builtin/branch.c: int cmd_branch(int argc,
       	if (delete) {
       		if (!argc)
 3:  a0fd5b4a6c ! 3:  0c4f3358e3 branch: let delete_branches skip unmerged branches on bulk refusal
     @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
       
       static int check_branch_commit(const char *branchname, const char *refname,
      @@ builtin/branch.c: static int check_branch_commit(const char *branchname, const char *refname,
     - 			       int kinds, unsigned int flags)
     - {
     - 	bool force = flags & DELETE_BRANCH_FORCE;
     -+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
     - 	struct commit *rev = lookup_commit_reference(the_repository, oid);
     - 	if (!force && !rev) {
     - 		error(_("couldn't look up commit object for '%s'"), refname);
     - 		return -1;
       	}
     - 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     + 	if (!(flags & DELETE_BRANCH_FORCE) &&
     + 	    !branch_merged(kinds, branchname, rev, head_rev)) {
      -		error(_("the branch '%s' is not fully merged"), branchname);
      -		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
      -				  _("If you are sure you want to delete it, "
      -				  "run 'git branch -D %s'"), branchname);
     -+		if (!skip_unmerged) {
     ++		if (!(flags & DELETE_BRANCH_SKIP_UNMERGED)) {
      +			error(_("the branch '%s' is not fully merged"),
      +			      branchname);
      +			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
     @@ builtin/branch.c: static int check_branch_commit(const char *branchname, const c
       		return -1;
       	}
       	return 0;
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 	int remote_branch = 0;
     - 	bool force;
     - 	bool quiet = flags & DELETE_BRANCH_QUIET;
     -+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
     - 	struct strbuf bname = STRBUF_INIT;
     - 	enum interpret_branch_kind allowed_interpret;
     - 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
       		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
       		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
       					flags)) {
      -			ret = 1;
     -+			if (!skip_unmerged)
     ++			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
      +				ret = 1;
       			goto next;
       		}
 4:  a56d8fe93e ! 4:  64a202526a branch: prepare delete_branches for a bulk caller
     @@ Metadata
       ## Commit message ##
          branch: prepare delete_branches for a bulk caller
      
     -    Teach delete_branches() two new modes for the upcoming
     -    --delete-merged: one that asks only whether a branch is merged into
     -    its upstream, without falling back to HEAD when there is no
     -    upstream, and one that rehearses the deletions without removing any
     -    ref. Existing callers keep their current behavior.
     +    Teach delete_branches() a new mode for the upcoming --delete-merged
     +    caller that checks whether a branch is merged into its upstream without
     +    falling back to HEAD when there is no upstream. Existing callers keep
     +    their current behavior.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/branch.c: enum delete_branch_flags {
       
       static int check_branch_commit(const char *branchname, const char *refname,
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 	bool force;
     - 	bool quiet = flags & DELETE_BRANCH_QUIET;
     - 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
     -+	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
     - 	struct strbuf bname = STRBUF_INIT;
     - 	enum interpret_branch_kind allowed_interpret;
     - 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 
     - 	force = flags & DELETE_BRANCH_FORCE;
     + 	}
     + 	branch_name_pos = strcspn(fmt, "%");
       
     --	if (!force)
     -+	if (!force && !no_head_fallback)
     +-	if (!(flags & DELETE_BRANCH_FORCE))
     ++	if (!(flags & DELETE_BRANCH_FORCE) &&
     ++	    !(flags & DELETE_BRANCH_NO_HEAD_FALLBACK))
       		head_rev = lookup_commit_reference(the_repository, &head_oid);
       
       	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 5:  a84c555d99 ! 5:  a6caa5b397 branch: add --delete-merged <branch>
     @@ Metadata
       ## Commit message ##
          branch: add --delete-merged <branch>
      
     -            git branch --delete-merged <branch>...
     +        git branch (--delete-merged <branch>)... [<pattern>...]
      
     -    deletes the local branches that "--forked <branch>" would list,
     -    keeping only those whose tip is reachable from their configured
     -    upstream. The work has already landed on the upstream they track,
     -    so the local copy is no longer needed.
     +    deletes local branches matching the optional patterns when their
     +    configured upstream matches one of the --delete-merged arguments and
     +    their tip is reachable from that upstream. The work has already landed
     +    on the upstream they track, so the local copy is no longer needed.
     +
     +    The option can be repeated to widen the upstream match. Keeping the
     +    candidate patterns as positional arguments lets users bound the set of
     +    local branches that may be deleted independently of the upstream
     +    selection.
      
          A branch is not deleted when:
      
            * it is checked out in any worktree
     -      * its upstream remote-tracking branch no longer exists, since a
     -        missing upstream is not by itself a sign of integration
     -      * its push destination equals its upstream (<branch>@{push} is
     -        the same as <branch>@{upstream}), such as a local "main" that
     -        tracks and pushes to "origin/main". Right after a pull it just
     -        looks "fully merged", so it is kept. Only branches that push
     -        somewhere other than their upstream, typically topics in a fork
     -        workflow, are candidates.
     +      * its configured upstream ref no longer exists, since a missing
     +        upstream is not by itself a sign of integration
     +      * pushing it by name to the remote configured by
     +        branch.<name>.remote would update its upstream, as determined by
     +        mapping the branch ref through that remote's fetch refspec. For
     +        example, a local "main" that tracks "origin/main" is kept even when
     +        remote.pushDefault names a fork. Right after a pull it merely looks
     +        fully merged.
      
          A branch whose work is not yet merged into its upstream is silently
          skipped, so one unmerged topic does not abort the whole sweep.
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     -+git branch --delete-merged <branch>...
     ++git branch (--delete-merged <branch>)... [<pattern>...]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
       	Print the name of the current branch. In detached `HEAD` state,
       	nothing is printed.
       
     -+`--delete-merged <branch>...`::
     -+	Delete the local branches that `--forked` would list for the
     -+	given _<branch>_ arguments, but only those whose tip is
     -+	reachable from their configured upstream. In other words, the
     -+	work on the branch has already landed on the upstream it
     -+	tracks, so the local copy is no longer needed. Several
     -+	_<branch>_ patterns may be given, e.g. `git branch
     -+	--delete-merged origin/main 'feature*'`.
     ++`--delete-merged <branch>`::
     ++	Delete local branches whose configured upstream matches
     ++	_<branch>_, but only when their tip is reachable from that
     ++	upstream. In other words, the work on the branch has already
     ++	landed on the upstream it tracks, so the local copy is no longer
     ++	needed. The option can be repeated to widen the upstream match.
     ++	Optional _<pattern>_ arguments limit which local branches are
     ++	considered, e.g. `git branch --delete-merged 'origin/*'
     ++	'topic-*'`.
      ++
      +A branch is not deleted when:
      ++
      +--
     -+* its upstream remote-tracking branch no longer exists,
     ++* its configured upstream ref no longer exists,
      +* it is checked out in any worktree, or
     -+* its push destination (`<branch>@{push}`) equals its upstream
     -+  (`<branch>@{upstream}`), so it cannot be distinguished from a
     -+  branch that just looks "fully merged" right after a pull.
     ++* pushing it by name to the remote configured by
     ++  `branch.<name>.remote` would update its upstream, so it cannot be
     ++  distinguished from a branch that just looks "fully merged" right
     ++  after a pull.
      +--
      ++
      +A branch whose work has not yet been merged into its upstream is
     @@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
       	N_("git branch [<options>] [-r | -a] [--points-at]"),
       	N_("git branch [<options>] [-r | -a] [--format]"),
     -+	N_("git branch [<options>] --delete-merged <branch>..."),
     ++	N_("git branch [<options>] (--delete-merged <branch>)... [<pattern>...]"),
       	NULL
       };
       
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	strset_clear(&spared);
      +}
      +
     -+static int delete_merged_branches(int argc, const char **argv,
     -+				 unsigned int flags)
     ++static int branch_pushes_to_upstream(struct branch *branch,
     ++				     const char *upstream)
     ++{
     ++	struct remote *remote = remote_get(remote_for_branch(branch, NULL));
     ++	char *tracking = NULL;
     ++	int ret = 0;
     ++
     ++	if (remote)
     ++		tracking = apply_refspecs(&remote->fetch, branch->refname);
     ++	if (tracking && !strcmp(tracking, upstream))
     ++		ret = 1;
     ++
     ++	free(tracking);
     ++	return ret;
     ++}
     ++
     ++static int delete_merged_branches(const struct strvec *upstreams,
     ++				 const char **argv, unsigned int flags)
      +{
      +	struct ref_store *refs = get_main_ref_store(the_repository);
      +	struct ref_filter filter = REF_FILTER_INIT;
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	struct strvec to_delete = STRVEC_INIT;
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
     -+	int i, ret = 0;
     ++	size_t i;
     ++	int ret = 0;
      +
     -+	if (!argc)
     -+		die(_("--delete-merged requires at least one <branch>"));
     -+
     -+	for (i = 0; i < argc; i++)
     -+		if (ref_filter_forked_add(&filter, argv[i]) < 0)
     -+			die(_("'%s' is not a valid branch or pattern"), argv[i]);
     ++	for (i = 0; i < upstreams->nr; i++)
     ++		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
     ++			die(_("'%s' is not a valid branch or pattern"),
     ++			    upstreams->v[i]);
      +
      +	filter.kind = FILTER_REFS_BRANCHES;
     ++	filter.name_patterns = argv;
      +	filter_refs(&candidates, &filter, filter.kind);
      +
     -+	for (i = 0; i < candidates.nr; i++) {
     ++	for (i = 0; i < (size_t)candidates.nr; i++) {
      +		const char *full_name = candidates.items[i]->refname;
      +		const char *short_name;
      +		struct branch *branch;
     -+		const char *upstream, *push;
     ++		const char *upstream;
      +
      +		if (!skip_prefix(full_name, "refs/heads/", &short_name))
      +			BUG("filter returned non-branch ref '%s'", full_name);
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +		upstream = branch_get_upstream(branch, NULL);
      +		if (!upstream || !refs_ref_exists(refs, upstream))
      +			continue;
     -+		push = branch_get_push(branch, NULL);
     -+		if (!push || !strcmp(push, upstream))
     ++		if (branch_pushes_to_upstream(branch, upstream))
      +			continue;
      +		if (check_branch_commit(short_name, short_name,
      +					&candidates.items[i]->objectname, NULL,
     @@ builtin/branch.c: int cmd_branch(int argc,
       	/* possible actions */
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     -+	int delete_merged = 0;
     ++	struct strvec delete_merged = STRVEC_INIT;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
     @@ builtin/branch.c: int cmd_branch(int argc,
       		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
       		OPT_BOOL(0, "edit-description", &edit_description,
       			 N_("edit the description for the branch")),
     -+		OPT_BOOL(0, "delete-merged", &delete_merged,
     -+			N_("delete local branches whose upstream matches <branch> and are merged")),
     ++		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
     ++			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
     ++			PARSE_OPT_NONEG, parse_opt_strvec),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       
       	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
      -	    !show_current && !unset_upstream && argc == 0)
     -+	    !show_current && !unset_upstream && !delete_merged &&
     ++	    !show_current && !unset_upstream && !delete_merged.nr &&
      +	    argc == 0)
       		list = 1;
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
       			    !!show_current + !!list + !!edit_description +
      -			    !!unset_upstream;
     -+			    !!unset_upstream + !!delete_merged;
     ++			    !!unset_upstream + !!delete_merged.nr;
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
       				      (quiet ? DELETE_BRANCH_QUIET : 0));
       		goto out;
     -+	} else if (delete_merged) {
     -+		ret = delete_merged_branches(argc, argv,
     ++	} else if (delete_merged.nr) {
     ++		ret = delete_merged_branches(&delete_merged, argv,
      +					     quiet ? DELETE_BRANCH_QUIET : 0);
      +		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
       		ret = 0;
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 	ret = 0;
     + 
     + out:
     ++	strvec_clear(&delete_merged);
     + 	string_list_clear(&sorting_options, 0);
     + 	return ret;
     + }
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
     - 	test_cmp expect actual
     +@@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
     + 	test_grep "requires a value" err
       '
       
      +test_expect_success '--delete-merged: setup' '
     @@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
      +		cd repo &&
      +		git remote add fork ../fork &&
      +		git remote add other ../other &&
     -+		git config remote.pushDefault fork &&
      +		git config push.default current &&
      +		git fetch other
      +	)
      +}
      +
     -+merged_branch () {
     ++create_merged_branch () {
      +	(
      +		cd repo &&
     -+		git checkout -b "$1" "$2" &&
     ++		git checkout -b "$1" origin/next --track &&
      +		git commit --allow-empty -m "$1 work" &&
     -+		git push origin "$1:next" &&
     -+		git fetch origin &&
     -+		git branch --set-upstream-to="$2" "$1"
     ++		git push origin "$1:next"
      +	)
      +}
      +
     -+test_expect_success '--delete-merged deletes merged branches and spares the rest' '
     -+	test_when_finished "rm -rf repo" &&
     -+	setup_repo_for_delete_merged &&
     -+	merged_branch merged origin/next &&
     -+	(
     -+		cd repo &&
     -+		git checkout -b unmerged origin/next &&
     -+		git commit --allow-empty -m "unmerged work" &&
     -+		git branch --set-upstream-to=origin/next unmerged &&
     -+		git checkout -b tracks-other other/main &&
     -+		git branch --set-upstream-to=other/main tracks-other &&
     -+		git checkout --detach
     -+	) &&
     -+	sha=$(git -C repo rev-parse --short merged) &&
     -+
     -+	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
     -+
     -+	echo "Deleted branch merged (was $sha)." >expect &&
     -+	test_cmp expect actual &&
     -+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     -+	cat >expect <<-\EOF &&
     -+	main
     -+	tracks-other
     -+	unmerged
     -+	EOF
     ++check_branches () {
     ++	git for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     ++	cat >expect &&
      +	test_cmp expect actual
     -+'
     ++}
      +
     -+test_expect_success '--delete-merged deletes merged branches and spares protected ones' '
     -+	test_when_finished "rm -rf repo" &&
     ++test_expect_success '--delete-merged keeps cloned main without a default push remote' '
      +	setup_repo_for_delete_merged &&
     -+	merged_branch on-next origin/next &&
     -+	merged_branch checked-out origin/next &&
     -+	merged_branch upstream-gone origin/next &&
      +	(
      +		cd repo &&
     -+		git checkout -b mainline main &&
     -+		git checkout -b on-local mainline &&
     -+		git branch --set-upstream-to=mainline on-local &&
     -+		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
     -+		git branch --set-upstream-to=origin/topic upstream-gone &&
     -+		git update-ref -d refs/remotes/origin/topic &&
     -+		git branch --set-upstream-to=origin/main main &&
     -+		git config branch.main.pushRemote origin &&
     -+		git checkout -b tracks-other other/main &&
     -+		git branch --set-upstream-to=other/main tracks-other &&
     -+		git checkout checked-out
     -+	) &&
     ++		git checkout --detach &&
      +
     -+	git -C repo branch --delete-merged origin/next mainline &&
     ++		git branch --delete-merged */* &&
      +
     -+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     -+	cat >expect <<-\EOF &&
     -+	checked-out
     -+	main
     -+	mainline
     -+	tracks-other
     -+	upstream-gone
     -+	EOF
     -+	test_cmp expect actual
     ++		check_branches <<-\EOF
     ++		main
     ++		EOF
     ++	)
      +'
      +
     -+test_expect_success '--delete-merged requires at least one <branch>' '
     -+	test_must_fail git -C forked branch --delete-merged 2>err &&
     -+	test_grep "requires at least one <branch>" err
     ++test_expect_success '--delete-merged deletes only selected merged branches' '
     ++	setup_repo_for_delete_merged &&
     ++	create_merged_branch also-merged &&
     ++	create_merged_branch merged &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b unmerged origin/next --track &&
     ++		git commit --allow-empty -m "unmerged work" &&
     ++		git checkout -b tracks-other other/main --track &&
     ++		sha=$(git rev-parse --short merged) &&
     ++
     ++		git branch --delete-merged origin/next merged >actual 2>&1 &&
     ++		echo "Deleted branch merged (was $sha)." >expect &&
     ++		test_cmp expect actual &&
     ++
     ++		check_branches <<-\EOF
     ++		also-merged
     ++		main
     ++		tracks-other
     ++		unmerged
     ++		EOF
     ++	)
      +'
      +
     -+test_expect_success '--delete-merged keeps a branch that is an upstream' '
     -+	test_when_finished "rm -rf repo" &&
     ++test_expect_success '--delete-merged keeps main despite a different default push remote' '
      +	setup_repo_for_delete_merged &&
     -+	merged_branch feature origin/next &&
     ++	create_merged_branch on-next &&
     ++	create_merged_branch checked-out &&
     ++	create_merged_branch upstream-gone &&
      +	(
      +		cd repo &&
     -+		git checkout -b topic feature &&
     -+		git commit --allow-empty -m "topic work" &&
     -+		git branch --set-upstream-to=feature topic &&
     -+		git checkout --detach
     -+	) &&
     -+
     -+	git -C repo branch --dry-run --delete-merged origin/next >out &&
     -+	test_grep ! "feature" out &&
     -+
     -+	git -C repo branch --delete-merged origin/next 2>err &&
     -+
     -+	test_must_be_empty err &&
     -+	git -C repo rev-parse --verify refs/heads/feature &&
     -+	git -C repo rev-parse --verify refs/heads/topic &&
     -+	echo origin/next >expect &&
     -+	git -C repo rev-parse --abbrev-ref feature@{upstream} >actual &&
     -+	test_cmp expect actual &&
     -+	echo feature >expect &&
     -+	git -C repo rev-parse --abbrev-ref topic@{upstream} >actual &&
     -+	test_cmp expect actual
     ++		git config remote.pushDefault fork &&
     ++		git checkout -b local-to-delete main --track &&
     ++		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
     ++		git branch --set-upstream-to=origin/topic upstream-gone &&
     ++		git update-ref -d refs/remotes/origin/topic &&
     ++		git checkout -b tracks-other other/main --track &&
     ++		git checkout checked-out &&
     ++
     ++		git branch --delete-merged origin/* \
     ++			--delete-merged main &&
     ++
     ++		check_branches <<-\EOF
     ++		checked-out
     ++		main
     ++		tracks-other
     ++		upstream-gone
     ++		EOF
     ++	)
      +'
      +
     -+test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch' '
     -+	test_when_finished "rm -rf repo" &&
     ++test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
      +	setup_repo_for_delete_merged &&
     ++	create_merged_branch feature &&
      +	(
      +		cd repo &&
     -+		git branch b3 origin/next &&
     -+		git branch --set-upstream-to=origin/next b3 &&
     -+		git branch b2 origin/next &&
     -+		git branch --set-upstream-to=b3 b2 &&
     -+		git checkout -b b1 b2 &&
     -+		git commit --allow-empty -m "b1 work" &&
     -+		git branch --set-upstream-to=b2 b1 &&
     -+		git checkout --detach
     -+	) &&
     -+
     -+	git -C repo branch --delete-merged origin/next &&
     ++		git checkout -b topic feature --track &&
     ++		git commit --allow-empty -m "topic work" &&
      +
     -+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     -+	cat >expect <<-\EOF &&
     -+	b1
     -+	b2
     -+	b3
     -+	main
     -+	EOF
     -+	test_cmp expect actual
     ++		git branch --delete-merged origin/next 2>err &&
     ++
     ++		test_must_be_empty err &&
     ++		check_branches <<-\EOF &&
     ++		feature
     ++		main
     ++		topic
     ++		EOF
     ++
     ++		git config --local --get-regexp "branch\\.(feature|topic)\\.(merge|remote)" >actual &&
     ++		cat >expect <<-\EOF &&
     ++		branch.feature.remote origin
     ++		branch.feature.merge refs/heads/next
     ++		branch.topic.remote .
     ++		branch.topic.merge refs/heads/feature
     ++		EOF
     ++		test_cmp expect actual
     ++	)
      +'
      +
     -+test_expect_success '--delete-merged clears the upstream of a kept base whose own base is deleted' '
     -+	test_when_finished "rm -rf repo" &&
     ++test_expect_success '--delete-merged clears the deleted upstream of a spared branch' '
      +	setup_repo_for_delete_merged &&
      +	(
      +		cd repo &&
     -+		git branch lower origin/next &&
     -+		git branch --set-upstream-to=origin/next lower &&
     -+		git branch mid origin/next &&
     -+		git branch --set-upstream-to=lower mid &&
     -+		git checkout -b tip mid &&
     ++		git config remote.pushDefault fork &&
     ++		git branch lower origin/next --track &&
     ++		git branch mid lower --track &&
     ++		git checkout -b tip mid --track &&
      +		git commit --allow-empty -m "tip work" &&
     -+		git branch --set-upstream-to=mid tip &&
     -+		git checkout --detach
     -+	) &&
     -+
     -+	git -C repo branch --delete-merged origin/next lower &&
      +
     -+	test_must_fail git -C repo rev-parse --verify refs/heads/lower &&
     -+	git -C repo rev-parse --verify refs/heads/mid &&
     -+	test_must_fail git -C repo rev-parse mid@{upstream} &&
     -+	echo mid >expect &&
     -+	git -C repo rev-parse --abbrev-ref tip@{upstream} >actual &&
     -+	test_cmp expect actual
     ++		git branch --delete-merged origin/next \
     ++			--delete-merged lower &&
     ++
     ++		check_branches <<-\EOF &&
     ++		main
     ++		mid
     ++		tip
     ++		EOF
     ++
     ++		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
     ++		cat >expect <<-\EOF &&
     ++		branch.tip.remote .
     ++		branch.tip.merge refs/heads/mid
     ++		EOF
     ++		test_cmp expect actual
     ++	)
      +'
      +
     ++test_expect_success '--delete-merged requires a value' '
     ++	test_must_fail git -C forked branch --delete-merged 2>err &&
     ++	test_grep "requires a value" err
     ++'
       test_done
 6:  d52d717b70 ! 6:  734d27c908 branch: add branch.<name>.deleteMerged opt-out
     @@ Documentation/git-branch.adoc
      @@ Documentation/git-branch.adoc: A branch is not deleted when:
       +
       --
     - * its upstream remote-tracking branch no longer exists,
     + * its configured upstream ref no longer exists,
      -* it is checked out in any worktree, or
      +* it is checked out in any worktree,
     - * its push destination (`<branch>@{push}`) equals its upstream
     -   (`<branch>@{upstream}`), so it cannot be distinguished from a
     --  branch that just looks "fully merged" right after a pull.
     -+  branch that just looks "fully merged" right after a pull, or
     + * pushing it by name to the remote configured by
     +   `branch.<name>.remote` would update its upstream, so it cannot be
     +   distinguished from a branch that just looks "fully merged" right
     +-  after a pull.
     ++  after a pull, or
      +* `branch.<name>.deleteMerged` is set to `false`.
       --
       +
       A branch whose work has not yet been merged into its upstream is
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     +@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       	struct ref_array candidates = { 0 };
       	struct strset deletable = STRSET_INIT;
       	struct strvec to_delete = STRVEC_INIT;
      +	struct strbuf key = STRBUF_INIT;
       	struct hashmap_iter iter;
       	struct strmap_entry *entry;
     -+	bool quiet = flags & DELETE_BRANCH_QUIET;
     - 	int i, ret = 0;
     - 
     - 	if (!argc)
     -@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     + 	size_t i;
     +@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       		const char *short_name;
       		struct branch *branch;
     - 		const char *upstream, *push;
     + 		const char *upstream;
      +		int opt_out;
       
       		if (!skip_prefix(full_name, "refs/heads/", &short_name))
       			BUG("filter returned non-branch ref '%s'", full_name);
     -@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     +@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
       			continue;
       
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
      +		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
      +		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
      +		    !opt_out) {
     -+			if (!quiet)
     ++			if (!(flags & DELETE_BRANCH_QUIET))
      +				fprintf(stderr,
      +					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
      +					short_name, short_name);
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       		strset_add(&deletable, short_name);
       	}
       
     -@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     +@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       				      DELETE_BRANCH_NO_HEAD_FALLBACK |
       				      flags);
       
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       	ref_array_clear(&candidates);
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the upstream of a kept base whose ow
     - 	test_cmp expect actual
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged requires a value' '
     + 	test_must_fail git -C forked branch --delete-merged 2>err &&
     + 	test_grep "requires a value" err
       '
     - 
     ++
      +test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
     -+	test_when_finished "rm -rf repo" &&
      +	setup_repo_for_delete_merged &&
     -+	merged_branch deleted origin/next &&
     -+	merged_branch kept origin/next &&
     -+	git -C repo config branch.kept.deleteMerged false &&
     -+	git -C repo checkout --detach &&
     ++	create_merged_branch deleted &&
     ++	create_merged_branch kept &&
     ++	(
     ++		cd repo &&
     ++		git config branch.kept.deleteMerged false &&
     ++		git checkout --detach &&
      +
     -+	git -C repo branch --delete-merged origin/next 2>err &&
     ++		git branch --delete-merged origin/next 2>err &&
      +
     -+	test_grep "Skipping .kept." err &&
     -+	test_must_fail git -C repo rev-parse --verify refs/heads/deleted &&
     -+	git -C repo rev-parse --verify refs/heads/kept
     ++		test_grep "Skipping .kept." err &&
     ++		check_branches <<-\EOF
     ++		kept
     ++		main
     ++		EOF
     ++	)
      +'
      +
      +test_expect_success "branch -d still deletes a deleteMerged=false branch" '
     -+	test_when_finished "rm -rf repo" &&
      +	setup_repo_for_delete_merged &&
     -+	merged_branch kept origin/next &&
     -+	git -C repo config branch.kept.deleteMerged false &&
     -+	git -C repo checkout --detach &&
     ++	create_merged_branch kept &&
     ++	(
     ++		cd repo &&
     ++		git config branch.kept.deleteMerged false &&
     ++		git checkout --detach &&
     ++
     ++		git branch -d kept &&
      +
     -+	git -C repo branch -d kept &&
     -+	test_must_fail git -C repo rev-parse --verify refs/heads/kept
     ++		check_branches <<-\EOF
     ++		main
     ++		EOF
     ++	)
      +'
      +
       test_done
 7:  8d0323f4b3 ! 7:  7aa9d5db14 branch: add --dry-run for --delete-merged
     @@ Metadata
       ## Commit message ##
          branch: add --dry-run for --delete-merged
      
     -    With --dry-run, --delete-merged prints the local branches it would
     -    delete, one "Would delete branch <name>" line each, and exits
     -    without touching any ref. The same filtering applies, so the output
     -    is exactly the set that the real run would delete.
     +    "git branch --dry-run --delete-merged ..." prints one line per ref that
     +    would be deleted without modifying refs or branch configuration.
      
          --dry-run is only meaningful together with --delete-merged and is
          rejected otherwise.
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     --git branch --delete-merged <branch>...
     -+git branch [--dry-run] --delete-merged <branch>...
     +-git branch (--delete-merged <branch>)... [<pattern>...]
     ++git branch [--dry-run] (--delete-merged <branch>)... [<pattern>...]
       
       DESCRIPTION
       -----------
     @@ builtin/branch.c: enum delete_branch_flags {
       };
       
       static int check_branch_commit(const char *branchname, const char *refname,
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 	bool quiet = flags & DELETE_BRANCH_QUIET;
     - 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
     - 	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
     -+	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
     - 	struct strbuf bname = STRBUF_INIT;
     - 	enum interpret_branch_kind allowed_interpret;
     - 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
       		free(target);
       	}
       
      -	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     -+	if (!dry_run &&
     ++	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
      +	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
       		ret = 1;
       
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
       		char *describe_ref = item->util;
       		char *name = item->string;
      -		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     -+		if (dry_run) {
     -+			if (!quiet)
     ++		if (flags & DELETE_BRANCH_DRY_RUN) {
     ++			if (!(flags & DELETE_BRANCH_QUIET))
      +				printf(remote_branch
      +					? _("Would delete remote-tracking branch %s (was %s).\n")
      +					: _("Would delete branch %s (was %s).\n"),
      +					name + branch_name_pos, describe_ref);
      +		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
       			char *refname = name + branch_name_pos;
     - 			if (!quiet)
     + 			if (!(flags & DELETE_BRANCH_QUIET))
       				printf(remote_branch
     +@@ builtin/branch.c: static int spare_stacked_base(const struct reference *ref, void *cb_data)
     +  * base is itself merged, so when its own upstream is also going away
     +  * (no surviving branch tracks it), clear the base's now-stale upstream.
     +  */
     +-static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
     ++static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable,
     ++				unsigned int flags)
     + {
     + 	struct strset spared = STRSET_INIT;
     + 	struct spare_data data = { .deletable = deletable, .spared = &spared };
     +@@ builtin/branch.c: static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable
     + 
     + 	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
     + 
     +-	strset_for_each_entry(&spared, &iter, entry) {
     +-		struct branch *branch = branch_get(entry->key);
     +-		const char *upstream = branch_get_upstream(branch, NULL);
     +-		const char *up_short;
     ++	if (!(flags & DELETE_BRANCH_DRY_RUN)) {
     ++		strset_for_each_entry(&spared, &iter, entry) {
     ++			struct branch *branch = branch_get(entry->key);
     ++			const char *upstream = branch_get_upstream(branch, NULL);
     ++			const char *up_short;
     + 
     +-		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     +-		    !strset_contains(deletable, up_short))
     +-			continue;
     ++			if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
     ++			    !strset_contains(deletable, up_short))
     ++				continue;
     + 
     +-		strbuf_reset(&key);
     +-		strbuf_addf(&key, "branch.%s.merge", branch->name);
     +-		repo_config_set_gently(the_repository, key.buf, NULL);
     +-		strbuf_reset(&key);
     +-		strbuf_addf(&key, "branch.%s.remote", branch->name);
     +-		repo_config_set_gently(the_repository, key.buf, NULL);
     ++			strbuf_reset(&key);
     ++			strbuf_addf(&key, "branch.%s.merge", branch->name);
     ++			repo_config_set_gently(the_repository, key.buf, NULL);
     ++			strbuf_reset(&key);
     ++			strbuf_addf(&key, "branch.%s.remote", branch->name);
     ++			repo_config_set_gently(the_repository, key.buf, NULL);
     ++		}
     + 	}
     + 
     + 	strbuf_release(&key);
     +@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     + 		strset_add(&deletable, short_name);
     + 	}
     + 
     +-	spare_stacked_bases(refs, &deletable);
     ++	spare_stacked_bases(refs, &deletable, flags);
     + 
     + 	strset_for_each_entry(&deletable, &iter, entry)
     + 		strvec_push(&to_delete, entry->key);
      @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     - 	int delete_merged = 0;
     + 	struct strvec delete_merged = STRVEC_INIT;
      +	int dry_run = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 			 N_("edit the description for the branch")),
     - 		OPT_BOOL(0, "delete-merged", &delete_merged,
     - 			N_("delete local branches whose upstream matches <branch> and are merged")),
     + 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
     + 			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
     + 			PARSE_OPT_NONEG, parse_opt_strvec),
      +		OPT_BOOL(0, "dry-run", &dry_run,
      +			N_("with --delete-merged, only print which branches would be deleted")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     @@ builtin/branch.c: int cmd_branch(int argc,
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     -+	if (dry_run && !delete_merged)
     ++	if (dry_run && !delete_merged.nr)
      +		die(_("--dry-run requires --delete-merged"));
      +
       	if (recurse_submodules_explicit) {
     @@ builtin/branch.c: int cmd_branch(int argc,
       			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
      @@ builtin/branch.c: int cmd_branch(int argc,
       		goto out;
     - 	} else if (delete_merged) {
     - 		ret = delete_merged_branches(argc, argv,
     + 	} else if (delete_merged.nr) {
     + 		ret = delete_merged_branches(&delete_merged, argv,
      -					     quiet ? DELETE_BRANCH_QUIET : 0);
      +					     (quiet ? DELETE_BRANCH_QUIET : 0) |
      +					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
     @@ builtin/branch.c: int cmd_branch(int argc,
       		print_current_branch_name();
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes merged branches and spares the rest
     - 	) &&
     - 	sha=$(git -C repo rev-parse --short merged) &&
     - 
     --	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
     -+	git -C repo branch --dry-run --delete-merged origin/next >actual 2>&1 &&
     -+	echo "Would delete branch merged (was $sha)." >expect &&
     -+	test_cmp expect actual &&
     -+	git -C repo rev-parse --verify refs/heads/merged &&
     - 
     -+	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
     - 	echo "Deleted branch merged (was $sha)." >expect &&
     - 	test_cmp expect actual &&
     - 	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected merged branches' '
     + 		git checkout -b tracks-other other/main --track &&
     + 		sha=$(git rev-parse --short merged) &&
     + 
     ++		git branch --dry-run --delete-merged origin/next merged >actual 2>&1 &&
     ++		echo "Would delete branch merged (was $sha)." >expect &&
     ++		test_cmp expect actual &&
     ++		git rev-parse --verify refs/heads/merged &&
     ++
     ++		check_branches <<-\EOF &&
     ++		also-merged
     ++		main
     ++		merged
     ++		tracks-other
     ++		unmerged
     ++		EOF
     ++
     + 		git branch --delete-merged origin/next merged >actual 2>&1 &&
     + 		echo "Deleted branch merged (was $sha)." >expect &&
     + 		test_cmp expect actual &&
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
     + 		git checkout -b topic feature --track &&
     + 		git commit --allow-empty -m "topic work" &&
     + 
     +-		git branch --delete-merged origin/next 2>err &&
     ++		git branch --dry-run --delete-merged origin/next >out &&
     ++		test_grep ! "feature" out &&
     + 
     ++		git branch --delete-merged origin/next 2>err &&
     + 		test_must_be_empty err &&
     ++
     + 		check_branches <<-\EOF &&
     + 		feature
     + 		main
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstream of a spared bra
     + 		git checkout -b tip mid --track &&
     + 		git commit --allow-empty -m "tip work" &&
     + 
     ++		git branch --dry-run --delete-merged origin/next \
     ++			--delete-merged lower &&
     ++
     ++		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
     ++		cat >expect <<-\EOF &&
     ++		branch.mid.remote .
     ++		branch.mid.merge refs/heads/lower
     ++		branch.tip.remote .
     ++		branch.tip.merge refs/heads/mid
     ++		EOF
     ++		test_cmp expect actual &&
     ++
     + 		git branch --delete-merged origin/next \
     + 			--delete-merged lower &&
     + 
      @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
     - 	test_must_fail git -C repo rev-parse --verify refs/heads/kept
     + 	)
       '
       
      +test_expect_success '--dry-run without --delete-merged is rejected' '

-- 
gitgitgadget
