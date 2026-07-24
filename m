Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA33A6EED
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921382; cv=none; b=gHVpnU7f3dHLWTz1MFaQXjruha4QeH/xwwQRaosPLB7otUxrL7E6s1QhsauFJXlqwjLhTa4r8iuLZWXi8rPLlo81HiY1Llye/KkjwAKsGw3UKVhxxYGGsvKOqjcFIiFguevOhkdGuQMCxXXyPEHG5FsSIt6imwQeSsias9Mskw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921382; c=relaxed/simple;
	bh=M0oK1lfe7pwYsnyOSeTBNDbbX8F0Zw/fNcvg9UTMuOk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hcdu++SbSdbpBKZXXS1cFDNQ2uXh6/JwKbXswiQFspKLYNQOJsXJYIfbXCAavwYaYrcCCd+rE5mvKkEOpRAQOVs53ZA8EQoextauvbWKNt/h6x11FAfMDKTjEimOH50r6iIJe2a83zl/ulR7zalJ2bgXFn9Gmdmq+XQXBYJr7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgnpZ13J; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgnpZ13J"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e58034d05so871002a91.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921377; x=1785526177; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XaOnE6Q0ZyaZkQjw2zc3uH2/2bVIoprkGc3roUgubxs=;
        b=IgnpZ13JZlyh9KFY9WDP7OWyXuv7tPmJsCHLXoBbWnsn2MN3kYXsan5Ee6Hv2NmlRM
         CEnqhAK3bpLqcFBWbBUk4xoSudQf3OgBo2a7WD43lcmpKh2/Taljvquma+1ER3WoPnSN
         kItRAmJ0Uv6wSbm9pV13Ilj2t/l6AytfaxDS1xuZqe1Az9BYoskuJ2o334BkJrjihtbP
         7t9EWwG6yFil/4wYLDt9XRmwRhzrVItfHcmVvV3BQYlkAVQZ6bVlgPzPCO361b4UXWUL
         9QJ+32hI9hJuX9sdXj10lgkonMBG9h6L5+I/m3tDWxeSqvZH+6tV2jqgKmDjXKWx1CDg
         A9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921377; x=1785526177;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaOnE6Q0ZyaZkQjw2zc3uH2/2bVIoprkGc3roUgubxs=;
        b=l+0AMJNJ9b/lEk6mCGgrEbTP6v3J7vY/LxhPm4VGwRFhhzZUPQHkQGj2IfXrwdKexz
         zzvoMsUOnQqFamA1ncXRVS92dk25E/tHCi+txjL9kiHHH8O11T4TWkl0eLA16oOKg7jX
         u4l0oQtkUdX0mrWQ/daGVthWAoRuNsEhrw3q8IEFAuYk2eO8kHL3sHO45fe6gklfUSib
         +2/4kCkae43xxioImsGVx2ZTace0ndehn+2NPHrSLe8jjZ6b6c58VoyrOD4Xh6wvvOt4
         B6HCqa9+VCSK83+XxmNZxrOs9peuCnzUtw3d0LCHD8T3yMGV/KgGR6oePefkpTbX7H/f
         Oa7A==
X-Gm-Message-State: AOJu0YxksQj1tQiT8rIw0abFsiPN1uD8iwAGtp+lqydG4w/m3s6v9yC6
	SHtqQMt+gwPXmn6FEJZBX7txaKnJYlhBUklDxqG7Sq8cGkYun7GojTVm0SA3Og==
X-Gm-Gg: AR+sD13G4MZMcqGPjD82O4gsL4i5DuY/XRUPIFa+FWgCLvTUqq3rqwWHU3dobU7wjfa
	vGyC4h8UuKzVxDe7iygSms+H0dWHfNVnNnilzBW5BYWvbKMfZRwsKlQUWKdFtvoZ1F/g+FpsjEj
	0OjtnTSKJOc4cn9rq0HTZZzX7rgvqXtQFblRyciUuvjeOZ4iIQE9DatEctlwDw79gk3u4WFamyY
	0bLEZY2zEBQox/Y8ZPwQENVpXz3r+tw8gSZs8kEszcDWgDGuns+RwpvEG71Gfna1Dz7/pOkhlWR
	kHU+4OZ4+l6ZSIiubRX1asvrcckI/UV4jFOWRKyC3bcyYW8EfVAIk5GqCqUH6L9K8YBP5/86UZh
	1v/Ca6yxAQC279ZU10tcKnnB8kaVOEjd71CswNTd7wz5HmjiD+nQIUXkFd4UrgOQY4lBdtfz+kp
	t6NUiSzg==
X-Received: by 2002:a17:90b:1643:b0:38e:7297:a931 with SMTP id 98e67ed59e1d1-38ec6a9cff2mr8235124a91.43.1784921377113;
        Fri, 24 Jul 2026 12:29:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.211.27])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130cc5ebsm37267515c88.12.2026.07.24.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:29:36 -0700 (PDT)
Message-Id: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 19:29:28 +0000
Subject: [PATCH v22 0/7] branch: delete-merged
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v22
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v22
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v21:

 1:  90aa528bef = 1:  90aa528bef branch: add --forked filter for --list mode
 2:  048c002cb4 = 2:  048c002cb4 branch: convert delete_branches() to a flags argument
 3:  bb93303df3 = 3:  bb93303df3 branch: let delete_branches skip unmerged branches on bulk refusal
 4:  e70e64c866 = 4:  e70e64c866 branch: prepare delete_branches for a bulk caller
 5:  598e68751e ! 5:  7dbfc6e243 branch: add --delete-merged <branch>
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	filter.name_patterns = argv;
      +	filter_refs(&candidates, &filter, filter.kind);
      +
     -+	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
     ++	for (int i = 0; i < candidates.nr; i++) {
      +		const char *branch_refname = candidates.items[i]->refname;
      +		const char *branch_name;
      +		struct branch *branch;
 6:  ac63689d8a = 6:  6f27770b9f branch: add branch.<name>.deleteMerged opt-out
 7:  73c3281b6f = 7:  4a42b6f5f9 branch: add --dry-run for --delete-merged

-- 
gitgitgadget
