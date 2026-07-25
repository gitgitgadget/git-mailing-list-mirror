Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9666327C09
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979143; cv=none; b=DVXnUPg5MvdlF0n7vDTv/27YqKg4FHdZulG2/K/nOuh2mF0wVnTA8o69h6lg1U+KKGJZIBvislxdSxKouyYJrVTHDq0mrAF6Tblovq+//YA5m/TZ6ZnvZNFzyPRCdm5n/A3G6jEjvZIC7nZKsJ9Mmu63ILn52cJcQSe7nx3VoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979143; c=relaxed/simple;
	bh=CEs0Hd09f0tGWI4L9AdnKtNTQYkDKhGpxxb0qfrlNYA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W1yBPJpKznpKwsPyxDXl3bRKQgpMU+cnhzyN99wMS1OnHFXGrnZTCfyyPEigk3X01Xjk4MeVbUkKa/Xu6C3rwZWloG/44/KPBTnUAtNYI9+sLt84NrDBPl5eeP3Jmrc1+7Vb0+JoUV5lUh0qk2s9Vby/5zSrelkW5e4cIRzrwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKvLJFZZ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKvLJFZZ"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6aae36ea5c4so700718eaf.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784979140; x=1785583940; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iTKfp+oLzvssGuYxciuJlIma9AGuKXh1fR1UGNyXNXQ=;
        b=hKvLJFZZ562eHYIDAmkvzRocyzAtU8O4pxzHbO/hXSwbBf7rGZAfCSJUuNsxJ6xRu0
         suOkOOx4rbcMTcfdaCQAIjbpmIWZzUYApz6gOVy6MouAo27KjiZEe/KKtXtaVe6W/LwE
         xPRVfYYxoJlcpU3VwMjX1SeOnU2Ofi74TMHqTftsQKt3Qq4YdDHFbIXPEvAoDHQLNnH4
         bckG/HUDHqjfNz7/QDwLQpt4zWX2Od7vU+FftxjfjZE4s8RHuqhOnyzKm2o+sfzJtf+H
         x+TijmjxLSJo1erhHeHAKo2CafXZpEHYcIEBm25iBTln3HnzKMa0yQL2P/YeS3lrO6zV
         QSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979140; x=1785583940;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTKfp+oLzvssGuYxciuJlIma9AGuKXh1fR1UGNyXNXQ=;
        b=jLHbwX/xRPF82xDUnEvwO0xSXmBbIi2DtewCHN9pzkYiNOECFD0FzzyAxD2vl85JY+
         NLhyr6EYV+CUyWs+Md1jtFnC11a/3Pmc0Xye+aP19XGhbkkcvKU9OXIQZ12hsUa15YsN
         4ewja4DhujEn0NNR1iWosbFyZNTSZxNkLszhfYhzmkS6jekKfVLX3t5zvQnjEfoKwOKm
         WX54b75GNao84Gzjf+bivzoWiS3VOPprK3DoZjSkDcODudPs0m4zyHTWmwA4b37jnY9Z
         +h0ILxmq7YAt8z/MBCVK0mcANFmlHulj2FCVrcnx9KH5QX2F/N06fSkF2c5oF+wqdjnZ
         N/Ow==
X-Gm-Message-State: AOJu0YxmlPOUL0bBoc4/eWsoYJMwS99L9oOVK6WkyPQHWSWqYtAMEgwW
	v5fExTZECr8W9U6x7HAPUA+xkajt5wXHfX8Oa7U1pq6P6cESFAAR4oP5f/O0bw==
X-Gm-Gg: AR+sD11mSxBNLERjrSS4B05xHXryurSSzmbYJzSqdVcRuE3hXIfAY9IVt0+nBekx89O
	fk3XIILBSbBOsMQL9Yrgw7os582eWIQ7ytYFUDRDi452513anR0kmlVauYv3UHHeaINRqLSXq+3
	XCVS9c5m2+JO/1C+KtJq7kplOrx9wq8UROsKvWR7oiN9in8ct4X4Sf38Q0wEc+i0xySRn1G0n8I
	6cRH4LnmpqpTxnPSKvvAA+dYPnCD47vO5f8x65AsSLRt5YqhYP9xI4TvjQD1ThAMH5hnUbQUjAJ
	XrbKCeYkeDX4OCBOFKkmjmtV1vU8db21NCEs5jKx/7DRlQxNIVcRMMA0fXZFDsxtbhQFwXUDE3i
	PP4SioVteBuMTwhL6iSSiek6tQgwjFAaWrTHb/MS9wU9uFN2LQOowuakdxJAMEjg3tb6BePVuXK
	t/jWw9
X-Received: by 2002:a05:6820:169f:b0:6aa:edca:e171 with SMTP id 006d021491bc7-6aaff86142fmr1543648eaf.19.1784979139948;
        Sat, 25 Jul 2026 04:32:19 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.94.33])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf973036dsm1650518eaf.14.2026.07.25.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:32:18 -0700 (PDT)
Message-Id: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:32:09 +0000
Subject: [PATCH v23 0/7] branch: delete-merged
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

Changes in v23:

 * Use a loop-local size_t iterator for --forked patterns.
 * Simplify upstream-prefix stripping into an explicit fallback.

Changes in v22:

 * Loop variable int when appropriate to avoid typecast.

Changes in v21:

 * Change loop variables to prevent CI timeout.

Changes in v20:

 * Protect branches transitively required by a surviving local upstream
   stack. Traverse upstream chains once and defer delete-set mutation until
   traversal completes.
 * Make stacked-branch handling independent of ref iteration order and
   update the documentation accordingly.
 * Clarify variable names with regards to branch names (short) to reduce
   confusion.

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
 Documentation/git-branch.adoc    |  49 +++-
 builtin/branch.c                 | 275 ++++++++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 393 +++++++++++++++++++++++++++++++
 6 files changed, 773 insertions(+), 31 deletions(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v23
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v23
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v22:

 1:  90aa528bef ! 1:  0c4fe549cb branch: add --forked filter for --list mode
     @@ ref-filter.c: static int filter_exclude_match(struct ref_filter *filter, const c
      +static const char *short_upstream_name(const char *full_ref)
      +{
      +	const char *short_name = full_ref;
     -+	(void)(skip_prefix(short_name, "refs/heads/", &short_name) ||
     -+	       skip_prefix(short_name, "refs/remotes/", &short_name));
     ++
     ++	if (!skip_prefix(short_name, "refs/heads/", &short_name))
     ++		skip_prefix(short_name, "refs/remotes/", &short_name);
      +	return short_name;
      +}
      +
     @@ ref-filter.c: static int filter_exclude_match(struct ref_filter *filter, const c
      +	const char *short_name;
      +	struct branch *branch;
      +	const char *upstream;
     -+	int i;
      +
      +	if (!skip_prefix(refname, "refs/heads/", &short_name))
      +		return 0;
     @@ ref-filter.c: static int filter_exclude_match(struct ref_filter *filter, const c
      +	if (!upstream)
      +		return 0;
      +
     -+	for (i = 0; i < filter->forked.nr; i++) {
     ++	for (size_t i = 0; i < filter->forked.nr; i++) {
      +		const char *pattern = filter->forked.v[i];
      +		if (has_glob_specials(pattern)) {
      +			if (!wildmatch(pattern, short_upstream_name(upstream),
 2:  048c002cb4 = 2:  2d20015ba9 branch: convert delete_branches() to a flags argument
 3:  bb93303df3 = 3:  34b37aeb43 branch: let delete_branches skip unmerged branches on bulk refusal
 4:  e70e64c866 = 4:  606ce4082c branch: prepare delete_branches for a bulk caller
 5:  7dbfc6e243 = 5:  5fd74f0050 branch: add --delete-merged <branch>
 6:  6f27770b9f = 6:  6494be7c75 branch: add branch.<name>.deleteMerged opt-out
 7:  4a42b6f5f9 = 7:  7102c931e2 branch: add --dry-run for --delete-merged

-- 
gitgitgadget
