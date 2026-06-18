Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34686BA34
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810734; cv=none; b=EUGP2arY6cwZO5r0dCMaKihSKn2vxmO/WsjGRwu/IZnlr6wgpF9jmy6lxNY86Fm0neZyhbubX8H7NCtK7nBPvwdfudlH960ml2ptBZv+nz1nIRM2WVViXtV3CsqjbgL17lT9KlVRSs5PqXGA3nUkMR2YhoaPot1C4p0menaFxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810734; c=relaxed/simple;
	bh=UEVHdzUHDxsZUelSNvyHRQcfPfr3nw7vqoeUAhv1wg8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mKx2HE+6XEFDa2t8IwQxaLQL0F/ZtwFtZNt35pLwiSGx/ZvNEY9JTKUr3KGSH9B7EtSxIUUAOfrPs4Mzwx6npmhtICYdE3E5Wqjg2lENrkW1kFnZSgIYI8UCdHkDQGcLpGoLFpiBz350zF4I9l6NHHgiayYL3mJKPNTB4ryB+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqDKYhiL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqDKYhiL"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8dd6e530061so12481726d6.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810731; x=1782415531; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+vGDzkoJ+GpQtL4mqTBw2GwHFnW95yEnkzA006bOX8=;
        b=TqDKYhiLDLEz5/laygQtrZzDm2ozvCUXYgeay3nJYJ/EOpNSNFEPx8vT/EwfDCOd0m
         QijYWdZw0ium4QHikGnV49Npst5i1rPdBHQuuGvGVidqPykmSQofbnpJDR1UGqYM2Q6B
         8ss9neGsOzMpeLkB766B4YtUVZXjw0srQO3mW1lMHbGgCvMo2l/kUo5/Y4iANRErpGcr
         FPmRfrBEWmPqQ3PJo1iq0jh1Goc3ASdb+1aNy4NJAALTlgjsqLhazqWsbvy5ksAvWxvl
         OyHiO/5XmoFY9dqrqyF1Amr34q9Vbxoe2eT6JUFP9FH8tlwbRiEfJgVy2RsoiYLAB0X6
         HoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810731; x=1782415531;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+vGDzkoJ+GpQtL4mqTBw2GwHFnW95yEnkzA006bOX8=;
        b=IyiOY3bhe+kZUm5s3iHhqz3BVYDs3a6gGylO0iBnOdp50rqCbO5sq5QGPQPCEKhq+0
         eJ67YPqF27MPuyMWY8qLCBqpy76Nh8MdzmKXkIjd+FmdmbIFYRFWBWD6BN/s8xao7geU
         68hNbW+2mTb/g0r6pNgcf94d6+a76pWo3kdZntksV+pHMx+FoHLf0LbeFj+cIw2/sis/
         tX+KcrXPhxRvpWmeHuUSoNPztNvQFx0Edaeac8aGRyosUilmcV1R9/vCmLT4pR4AEgAS
         lmX6q8gnIN8Z6Apoh02YzqFA/9ebBCV3y5EbfIJmbJdE+bN5E9bCuBON7g35G8wFHkKb
         Ztuw==
X-Gm-Message-State: AOJu0YyaAK0X/oroAKSx8ksxy3ORE/2qr0X1aBoHDzSPQniDWf7AvkBv
	gkM+rL9ItpmIxGqCZCLhmv6OlyzZE+hT0t8km2Onyj0BbW4Gqbl3Cu1H0W4TQQ==
X-Gm-Gg: AfdE7cnN8lxB+6iSBIH14DHBc7VPmSFFX2zoGg8tJNd7UbNg5l2d2zC85+86g5ASpFC
	fUaxoFnsYCMDu/yeuVc+3DVYKOdVP0D18RvSyaLhs1qN0HIGfpfsnYr8h0yn5c2UzWSMUNecg6L
	7bnAhx8D49tiK0eDLQvWqUconvO6Zt3ubC5zow3Erel2losURhjryEW4e/XT/2Xjfg5dLFLJuwd
	7c4kFf0SjgkXvBTxVbqE/cGSkQx4a6BPcwe68odm481Qh2TOnCelGju7U2q050B0WH2bZ+Ex77j
	Gtiif+gkeiEuugXgHLw7c+Tk3YXVEO5PfeZ5BMgMgyCoN8m6b2wIimXcIJlSmEg1kC2PCKyzfHG
	PJUm8vJPg34pTR84cYhXPBq80mi/y6vKGFDc3oG9lQH/rMj5oSwjO9aQhX6kE4T4hghZFL3q4Oo
	cSWXN/U14tLHIFqgrqMe9CD2CwQw==
X-Received: by 2002:a05:6214:6108:b0:8ce:cad9:479a with SMTP id 6a1803df08f44-8de3fb730a2mr8351336d6.15.1781810730726;
        Thu, 18 Jun 2026 12:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm606806d6.10.2026.06.18.12.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:25:30 -0700 (PDT)
Message-Id: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
References: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:25:22 +0000
Subject: [PATCH v16 0/7] branch: delete-merged
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
 Documentation/git-branch.adoc    |  43 ++++-
 builtin/branch.c                 | 186 ++++++++++++++++++----
 ref-filter.c                     |  70 +++++++++
 ref-filter.h                     |  10 ++
 t/t3200-branch.sh                | 262 +++++++++++++++++++++++++++++++
 6 files changed, 550 insertions(+), 28 deletions(-)


base-commit: 4621f8ce5e9b97aa2e8d0d9ffe9d25df2471074d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v16
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v16
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v15:

 1:  da741b5ea7 ! 1:  1f6a758265 branch: add --forked filter for --list mode
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
       
      +test_expect_success '--forked: setup' '
      +	test_create_repo forked-upstream &&
     -+	test_commit -C forked-upstream base &&
     -+	git -C forked-upstream branch one base &&
     -+	git -C forked-upstream branch two base &&
     ++	(
     ++		cd forked-upstream &&
     ++		test_commit base &&
     ++		git branch one base &&
     ++		git branch two base
     ++	) &&
      +
      +	test_create_repo forked-other &&
     -+	test_commit -C forked-other other-base &&
     -+	git -C forked-other branch foreign other-base &&
     ++	(
     ++		cd forked-other &&
     ++		test_commit other-base &&
     ++		git branch foreign other-base
     ++	) &&
      +
      +	git clone forked-upstream forked &&
     -+	git -C forked remote add -f other ../forked-other &&
     -+	git -C forked remote set-head origin one &&
     -+	git -C forked branch local-base &&
     -+	git -C forked branch --track local-one origin/one &&
     -+	git -C forked branch --track local-two origin/two &&
     -+	git -C forked branch --track local-foreign other/foreign &&
     -+	git -C forked branch --track local-onbase local-base &&
     ++	(
     ++		cd forked &&
     ++		git remote add -f other ../forked-other &&
     ++		git remote set-head origin one &&
     ++		git branch local-base &&
     ++		git branch --track local-one origin/one &&
     ++		git branch --track local-two origin/two &&
     ++		git branch --track local-foreign other/foreign &&
     ++		git branch --track local-onbase local-base &&
      +
     -+	git -C forked checkout local-one &&
     -+	test_commit -C forked --no-tag local-one-work local-one.t &&
     -+	git -C forked checkout local-foreign &&
     -+	test_commit -C forked --no-tag local-foreign-work local-foreign.t &&
     -+	git -C forked checkout --detach
     ++		git checkout local-one &&
     ++		test_commit --no-tag local-one-work local-one.t &&
     ++		git checkout local-foreign &&
     ++		test_commit --no-tag local-foreign-work local-foreign.t &&
     ++		git checkout --detach
     ++	)
      +'
      +
      +test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
 2:  91c35f10cc = 2:  4f8af602ba branch: convert delete_branches() to a flags argument
 3:  e101dd2886 = 3:  efc891c255 branch: let delete_branches skip unmerged branches on bulk refusal
 4:  6c3534901a = 4:  b1ecd38fe3 branch: prepare delete_branches for a bulk caller
 5:  5899013b8f ! 5:  998fb6a68c branch: add --delete-merged <branch>
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
       }
       
      +static int delete_merged_branches(int argc, const char **argv,
     -+				 int quiet)
     ++				 unsigned int flags)
      +{
      +	struct ref_store *refs = get_main_ref_store(the_repository);
      +	struct ref_filter filter = REF_FILTER_INIT;
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +				      FILTER_REFS_BRANCHES,
      +				      DELETE_BRANCH_SKIP_UNMERGED |
      +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     -+				      (quiet ? DELETE_BRANCH_QUIET : 0));
     ++				      flags);
      +
      +	strvec_clear(&deletable);
      +	ref_array_clear(&candidates);
     @@ builtin/branch.c: int cmd_branch(int argc,
       				      (quiet ? DELETE_BRANCH_QUIET : 0));
       		goto out;
      +	} else if (delete_merged) {
     -+		ret = delete_merged_branches(argc, argv, quiet);
     ++		ret = delete_merged_branches(argc, argv,
     ++					     quiet ? DELETE_BRANCH_QUIET : 0);
      +		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
     @@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
       '
       
      +test_expect_success '--delete-merged: setup' '
     -+	test_create_repo pm-upstream &&
     -+	test_commit -C pm-upstream base &&
     -+	git -C pm-upstream checkout -b next &&
     -+	test_commit -C pm-upstream one-commit &&
     -+	test_commit -C pm-upstream two-commit &&
     -+	git -C pm-upstream branch one HEAD~ &&
     -+	git -C pm-upstream branch two HEAD &&
     -+	git -C pm-upstream branch wip main &&
     -+	git -C pm-upstream checkout main &&
     -+	test_create_repo pm-fork
     ++	git init -b main upstream &&
     ++	(
     ++		cd upstream &&
     ++		test_commit base &&
     ++		git checkout -b next &&
     ++		test_commit next-work &&
     ++		git checkout main
     ++	) &&
     ++	git init -b main other &&
     ++	test_commit -C other other-base &&
     ++	git init -b main fork
      +'
      +
     -+test_expect_success '--delete-merged deletes branches integrated into upstream' '
     -+	test_when_finished "rm -rf pm-merged" &&
     -+	git clone pm-upstream pm-merged &&
     -+	git -C pm-merged remote add fork ../pm-fork &&
     -+	test_config -C pm-merged remote.pushDefault fork &&
     -+	test_config -C pm-merged push.default current &&
     -+	git -C pm-merged branch one one-commit &&
     -+	git -C pm-merged branch --set-upstream-to=origin/next one &&
     -+	git -C pm-merged branch two two-commit &&
     -+	git -C pm-merged branch --set-upstream-to=origin/next two &&
     -+
     -+	git -C pm-merged branch --delete-merged "origin/*" &&
     -+
     -+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
     -+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
     -+'
     -+
     -+test_expect_success '--delete-merged accepts a literal upstream' '
     -+	test_when_finished "rm -rf pm-literal" &&
     -+	git clone pm-upstream pm-literal &&
     -+	git -C pm-literal remote add fork ../pm-fork &&
     -+	test_config -C pm-literal remote.pushDefault fork &&
     -+	test_config -C pm-literal push.default current &&
     -+	git -C pm-literal branch one one-commit &&
     -+	git -C pm-literal branch --set-upstream-to=origin/next one &&
     -+
     -+	git -C pm-literal branch --delete-merged origin/next &&
     -+
     -+	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one
     -+'
     -+
     -+test_expect_success '--delete-merged unions multiple <branch> arguments' '
     -+	test_when_finished "rm -rf pm-union" &&
     -+	git clone pm-upstream pm-union &&
     -+	git -C pm-union remote add fork ../pm-fork &&
     -+	test_config -C pm-union remote.pushDefault fork &&
     -+	test_config -C pm-union push.default current &&
     -+	git -C pm-union branch one one-commit &&
     -+	git -C pm-union branch --set-upstream-to=origin/next one &&
     -+	git -C pm-union branch two base &&
     -+	git -C pm-union branch --set-upstream-to=origin/main two &&
     -+	git -C pm-union checkout --detach &&
     -+
     -+	git -C pm-union branch --delete-merged origin/next origin/main &&
     -+
     -+	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
     -+	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
     -+'
     -+
     -+test_expect_success '--delete-merged accepts a local upstream' '
     -+	test_when_finished "rm -rf pm-local" &&
     -+	git clone pm-upstream pm-local &&
     -+	git -C pm-local remote add fork ../pm-fork &&
     -+	test_config -C pm-local remote.pushDefault fork &&
     -+	test_config -C pm-local push.default current &&
     -+	git -C pm-local checkout -b mainline &&
     -+	git -C pm-local branch one one-commit &&
     -+	git -C pm-local branch --set-upstream-to=mainline one &&
     -+	git -C pm-local merge --ff-only one-commit &&
     -+
     -+	git -C pm-local branch --delete-merged mainline &&
     -+
     -+	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
     -+'
     -+
     -+test_expect_success '--delete-merged silently skips un-integrated commits' '
     -+	test_when_finished "rm -rf pm-unmerged" &&
     -+	git clone pm-upstream pm-unmerged &&
     -+	git -C pm-unmerged remote add fork ../pm-fork &&
     -+	test_config -C pm-unmerged remote.pushDefault fork &&
     -+	test_config -C pm-unmerged push.default current &&
     -+	git -C pm-unmerged checkout -b wip origin/wip &&
     -+	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
     -+	test_commit -C pm-unmerged local-only &&
     -+	git -C pm-unmerged checkout - &&
     -+
     -+	git -C pm-unmerged branch --delete-merged "origin/*" 2>err &&
     -+	test_grep ! "not fully merged" err &&
     -+	git -C pm-unmerged rev-parse --verify refs/heads/wip
     -+'
     -+
     -+test_expect_success '--delete-merged is silent about not-merged-to-HEAD' '
     -+	test_when_finished "rm -rf pm-nohead" &&
     -+	git clone pm-upstream pm-nohead &&
     -+	git -C pm-nohead remote add fork ../pm-fork &&
     -+	test_config -C pm-nohead remote.pushDefault fork &&
     -+	test_config -C pm-nohead push.default current &&
     -+	git -C pm-nohead branch topic one-commit &&
     -+	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
     -+
     -+	git -C pm-nohead branch --delete-merged "origin/*" 2>err &&
     -+
     -+	test_grep ! "not yet merged to HEAD" err &&
     -+	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
     -+'
     -+
     -+test_expect_success '--delete-merged skips branches whose upstream is gone' '
     -+	test_when_finished "rm -rf pm-upstream-gone" &&
     -+	git clone pm-upstream pm-upstream-gone &&
     -+	git -C pm-upstream-gone remote add fork ../pm-fork &&
     -+	test_config -C pm-upstream-gone remote.pushDefault fork &&
     -+	test_config -C pm-upstream-gone push.default current &&
     -+	git -C pm-upstream-gone branch one one-commit &&
     -+	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
     -+
     -+	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
     -+	git -C pm-upstream-gone branch --delete-merged "origin/*" &&
     -+
     -+	git -C pm-upstream-gone rev-parse --verify refs/heads/one
     -+'
     -+
     -+test_expect_success '--delete-merged never deletes the checked-out branch' '
     -+	test_when_finished "rm -rf pm-head" &&
     -+	git clone pm-upstream pm-head &&
     -+	git -C pm-head remote add fork ../pm-fork &&
     -+	test_config -C pm-head remote.pushDefault fork &&
     -+	test_config -C pm-head push.default current &&
     -+	git -C pm-head checkout -b one one-commit &&
     -+	git -C pm-head branch --set-upstream-to=origin/next one &&
     -+
     -+	git -C pm-head branch --delete-merged "origin/*" &&
     -+
     -+	git -C pm-head rev-parse --verify refs/heads/one
     -+'
     -+
     -+test_expect_success '--delete-merged spares branches that push back to their upstream' '
     -+	test_when_finished "rm -rf pm-push-eq" &&
     -+	git clone pm-upstream pm-push-eq &&
     -+	git -C pm-push-eq checkout --detach &&
     -+
     -+	git -C pm-push-eq branch --delete-merged "origin/*" &&
     -+
     -+	git -C pm-push-eq rev-parse --verify refs/heads/main
     -+'
     -+
     -+test_expect_success '--delete-merged spares a per-branch pushRemote==upstream remote' '
     -+	test_when_finished "rm -rf pm-push-branch" &&
     -+	git clone pm-upstream pm-push-branch &&
     -+	git -C pm-push-branch remote add fork ../pm-fork &&
     -+	test_config -C pm-push-branch remote.pushDefault fork &&
     -+	test_config -C pm-push-branch push.default current &&
     -+	test_config -C pm-push-branch branch.main.pushRemote origin &&
     -+	git -C pm-push-branch checkout --detach &&
     ++setup_repo_for_delete_merged () {
     ++	rm -rf repo &&
     ++	git clone upstream repo &&
     ++	(
     ++		cd repo &&
     ++		git remote add fork ../fork &&
     ++		git remote add other ../other &&
     ++		git config remote.pushDefault fork &&
     ++		git config push.default current &&
     ++		git fetch other
     ++	)
     ++}
      +
     -+	git -C pm-push-branch branch --delete-merged "origin/*" &&
     ++merged_branch () {
     ++	(
     ++		cd repo &&
     ++		git checkout -b "$1" "$2" &&
     ++		git commit --allow-empty -m "$1 work" &&
     ++		git push origin "$1:next" &&
     ++		git fetch origin &&
     ++		git branch --set-upstream-to="$2" "$1"
     ++	)
     ++}
      +
     -+	git -C pm-push-branch rev-parse --verify refs/heads/main
     ++test_expect_success '--delete-merged deletes merged branches and spares the rest' '
     ++	test_when_finished "rm -rf repo" &&
     ++	setup_repo_for_delete_merged &&
     ++	merged_branch merged origin/next &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b unmerged origin/next &&
     ++		git commit --allow-empty -m "unmerged work" &&
     ++		git branch --set-upstream-to=origin/next unmerged &&
     ++		git checkout -b tracks-other other/main &&
     ++		git branch --set-upstream-to=other/main tracks-other &&
     ++		git checkout --detach
     ++	) &&
     ++	sha=$(git -C repo rev-parse --short merged) &&
     ++
     ++	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
     ++
     ++	echo "Deleted branch merged (was $sha)." >expect &&
     ++	test_cmp expect actual &&
     ++	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     ++	cat >expect <<-\EOF &&
     ++	main
     ++	tracks-other
     ++	unmerged
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success '--delete-merged prunes when @{push} differs from @{upstream}' '
     -+	test_when_finished "rm -rf pm-push-diff" &&
     -+	git clone pm-upstream pm-push-diff &&
     -+	git -C pm-push-diff remote add fork ../pm-fork &&
     -+	test_config -C pm-push-diff remote.pushDefault fork &&
     -+	test_config -C pm-push-diff push.default current &&
     -+	git -C pm-push-diff branch topic one-commit &&
     -+	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
     -+	git -C pm-push-diff checkout --detach &&
     -+
     -+	git -C pm-push-diff branch --delete-merged "origin/*" &&
     -+
     -+	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
     ++test_expect_success '--delete-merged deletes merged branches and spares protected ones' '
     ++	test_when_finished "rm -rf repo" &&
     ++	setup_repo_for_delete_merged &&
     ++	merged_branch on-next origin/next &&
     ++	merged_branch checked-out origin/next &&
     ++	merged_branch upstream-gone origin/next &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b mainline main &&
     ++		git checkout -b on-local mainline &&
     ++		git branch --set-upstream-to=mainline on-local &&
     ++		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
     ++		git branch --set-upstream-to=origin/topic upstream-gone &&
     ++		git update-ref -d refs/remotes/origin/topic &&
     ++		git branch --set-upstream-to=origin/main main &&
     ++		git config branch.main.pushRemote origin &&
     ++		git checkout -b tracks-other other/main &&
     ++		git branch --set-upstream-to=other/main tracks-other &&
     ++		git checkout checked-out
     ++	) &&
     ++
     ++	git -C repo branch --delete-merged origin/next mainline &&
     ++
     ++	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     ++	cat >expect <<-\EOF &&
     ++	checked-out
     ++	main
     ++	mainline
     ++	tracks-other
     ++	upstream-gone
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success '--delete-merged requires at least one <branch>' '
      +	test_must_fail git -C forked branch --delete-merged 2>err &&
      +	test_grep "requires at least one <branch>" err
      +'
     -+
     -+test_expect_success '--delete-merged takes positional <branch> arguments' '
     -+	test_when_finished "rm -rf pm-positional" &&
     -+	git clone pm-upstream pm-positional &&
     -+	git -C pm-positional remote add fork ../pm-fork &&
     -+	test_config -C pm-positional remote.pushDefault fork &&
     -+	test_config -C pm-positional push.default current &&
     -+	git -C pm-positional branch one one-commit &&
     -+	git -C pm-positional branch --set-upstream-to=origin/next one &&
     -+	git -C pm-positional branch two base &&
     -+	git -C pm-positional branch --set-upstream-to=origin/main two &&
     -+	git -C pm-positional checkout --detach &&
     -+
     -+	git -C pm-positional branch --delete-merged origin/next origin/main &&
     -+
     -+	test_must_fail git -C pm-positional rev-parse --verify refs/heads/one &&
     -+	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
     -+'
      +
       test_done
 6:  72aaca0666 ! 6:  a27d2724a2 branch: add branch.<name>.deleteMerged opt-out
     @@ Documentation/git-branch.adoc: A branch is not deleted when:
       A branch whose work has not yet been merged into its upstream is
      
       ## builtin/branch.c ##
     +@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     + 	struct ref_filter filter = REF_FILTER_INIT;
     + 	struct ref_array candidates = { 0 };
     + 	struct strvec deletable = STRVEC_INIT;
     ++	struct strbuf key = STRBUF_INIT;
     ++	bool quiet = flags & DELETE_BRANCH_QUIET;
     + 	int i, ret = 0;
     + 
     + 	if (!argc)
      @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       		const char *short_name;
       		struct branch *branch;
       		const char *upstream, *push;
     -+		struct strbuf key = STRBUF_INIT;
      +		int opt_out;
       
       		if (!skip_prefix(full_name, "refs/heads/", &short_name))
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
       		if (!push || !strcmp(push, upstream))
       			continue;
       
     ++		strbuf_reset(&key);
      +		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
      +		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
      +		    !opt_out) {
     @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
      +				fprintf(stderr,
      +					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
      +					short_name, short_name);
     -+			strbuf_release(&key);
      +			continue;
      +		}
     -+		strbuf_release(&key);
      +
       		strvec_push(&deletable, short_name);
       	}
       
     +@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     + 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     + 				      flags);
     + 
     ++	strbuf_release(&key);
     + 	strvec_clear(&deletable);
     + 	ref_array_clear(&candidates);
     + 	ref_filter_clear(&filter);
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged takes positional <branch> arguments' '
     - 	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged requires at least one <branch>' '
     + 	test_grep "requires at least one <branch>" err
       '
       
      +test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
     -+	test_when_finished "rm -rf pm-optout" &&
     -+	git clone pm-upstream pm-optout &&
     -+	git -C pm-optout remote add fork ../pm-fork &&
     -+	test_config -C pm-optout remote.pushDefault fork &&
     -+	test_config -C pm-optout push.default current &&
     -+	git -C pm-optout branch one one-commit &&
     -+	git -C pm-optout branch --set-upstream-to=origin/next one &&
     -+	git -C pm-optout branch two two-commit &&
     -+	git -C pm-optout branch --set-upstream-to=origin/next two &&
     -+	test_config -C pm-optout branch.one.deleteMerged false &&
     ++	test_when_finished "rm -rf repo" &&
     ++	setup_repo_for_delete_merged &&
     ++	merged_branch deleted origin/next &&
     ++	merged_branch kept origin/next &&
     ++	git -C repo config branch.kept.deleteMerged false &&
     ++	git -C repo checkout --detach &&
      +
     -+	git -C pm-optout branch --delete-merged "origin/*" 2>err &&
     ++	git -C repo branch --delete-merged origin/next 2>err &&
      +
     -+	git -C pm-optout rev-parse --verify refs/heads/one &&
     -+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
     -+	test_grep "Skipping .one." err
     ++	test_grep "Skipping .kept." err &&
     ++	test_must_fail git -C repo rev-parse --verify refs/heads/deleted &&
     ++	git -C repo rev-parse --verify refs/heads/kept
      +'
      +
     -+test_expect_success 'branch -d still deletes a deleteMerged=false branch' '
     -+	test_when_finished "rm -rf pm-optout-d" &&
     -+	git clone pm-upstream pm-optout-d &&
     -+	git -C pm-optout-d branch one one-commit &&
     -+	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
     -+	test_config -C pm-optout-d branch.one.deleteMerged false &&
     ++test_expect_success "branch -d still deletes a deleteMerged=false branch" '
     ++	test_when_finished "rm -rf repo" &&
     ++	setup_repo_for_delete_merged &&
     ++	merged_branch kept origin/next &&
     ++	git -C repo config branch.kept.deleteMerged false &&
     ++	git -C repo checkout --detach &&
      +
     -+	git -C pm-optout-d branch -d one &&
     -+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
     ++	git -C repo branch -d kept &&
     ++	test_must_fail git -C repo rev-parse --verify refs/heads/kept
      +'
      +
       test_done
 7:  7b2b01b988 ! 7:  6d5c52353e branch: add --dry-run for --delete-merged
     @@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into
       `--verbose`::
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const char *arg, int unset
     - }
     - 
     - static int delete_merged_branches(int argc, const char **argv,
     --				 int quiet)
     -+				 int quiet, int dry_run)
     - {
     - 	struct ref_store *refs = get_main_ref_store(the_repository);
     - 	struct ref_filter filter = REF_FILTER_INIT;
     -@@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
     - 				      FILTER_REFS_BRANCHES,
     - 				      DELETE_BRANCH_SKIP_UNMERGED |
     - 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     --				      (quiet ? DELETE_BRANCH_QUIET : 0));
     -+				      (quiet ? DELETE_BRANCH_QUIET : 0) |
     -+				      (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
     - 
     - 	strvec_clear(&deletable);
     - 	ref_array_clear(&candidates);
      @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     @@ builtin/branch.c: int cmd_branch(int argc,
       		if (!submodule_propagate_branches)
       			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 				      (quiet ? DELETE_BRANCH_QUIET : 0));
       		goto out;
       	} else if (delete_merged) {
     --		ret = delete_merged_branches(argc, argv, quiet);
     -+		ret = delete_merged_branches(argc, argv, quiet, dry_run);
     + 		ret = delete_merged_branches(argc, argv,
     +-					     quiet ? DELETE_BRANCH_QUIET : 0);
     ++					     (quiet ? DELETE_BRANCH_QUIET : 0) |
     ++					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a deleteMerged=false branch' '
     - 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes merged branches and spares the rest
     + 	) &&
     + 	sha=$(git -C repo rev-parse --short merged) &&
     + 
     +-	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
     ++	git -C repo branch --dry-run --delete-merged origin/next >actual 2>&1 &&
     ++	echo "Would delete branch merged (was $sha)." >expect &&
     ++	test_cmp expect actual &&
     ++	git -C repo rev-parse --verify refs/heads/merged &&
     + 
     ++	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
     + 	echo "Deleted branch merged (was $sha)." >expect &&
     + 	test_cmp expect actual &&
     + 	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
     +@@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
     + 	test_must_fail git -C repo rev-parse --verify refs/heads/kept
       '
       
     -+test_expect_success '--delete-merged --dry-run lists but does not delete' '
     -+	test_when_finished "rm -rf pm-dry" &&
     -+	git clone pm-upstream pm-dry &&
     -+	git -C pm-dry remote add fork ../pm-fork &&
     -+	test_config -C pm-dry remote.pushDefault fork &&
     -+	test_config -C pm-dry push.default current &&
     -+	git -C pm-dry branch one one-commit &&
     -+	git -C pm-dry branch --set-upstream-to=origin/next one &&
     -+	git -C pm-dry branch two two-commit &&
     -+	git -C pm-dry branch --set-upstream-to=origin/next two &&
     -+
     -+	git -C pm-dry branch --dry-run --delete-merged "origin/*" >actual &&
     -+	test_grep "Would delete branch one " actual &&
     -+	test_grep "Would delete branch two " actual &&
     -+
     -+	git -C pm-dry rev-parse --verify refs/heads/one &&
     -+	git -C pm-dry rev-parse --verify refs/heads/two
     -+'
     -+
     -+test_expect_success '--delete-merged --dry-run only lists branches the live run would delete' '
     -+	test_when_finished "rm -rf pm-dry-mixed" &&
     -+	git clone pm-upstream pm-dry-mixed &&
     -+	git -C pm-dry-mixed remote add fork ../pm-fork &&
     -+	test_config -C pm-dry-mixed remote.pushDefault fork &&
     -+	test_config -C pm-dry-mixed push.default current &&
     -+	git -C pm-dry-mixed checkout -b wip origin/next &&
     -+	git -C pm-dry-mixed branch --set-upstream-to=origin/next wip &&
     -+	test_commit -C pm-dry-mixed local-only &&
     -+	git -C pm-dry-mixed checkout - &&
     -+	git -C pm-dry-mixed branch merged one-commit &&
     -+	git -C pm-dry-mixed branch --set-upstream-to=origin/next merged &&
     -+
     -+	git -C pm-dry-mixed branch --dry-run --delete-merged "origin/*" >out &&
     -+	test_grep "Would delete branch merged" out &&
     -+	test_grep ! "Would delete branch wip" out &&
     -+	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&
     -+	git -C pm-dry-mixed rev-parse --verify refs/heads/merged
     -+'
     -+
      +test_expect_success '--dry-run without --delete-merged is rejected' '
      +	test_must_fail git -C forked branch --dry-run 2>err &&
      +	test_grep "requires --delete-merged" err

-- 
gitgitgadget
