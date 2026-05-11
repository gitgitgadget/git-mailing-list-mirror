Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487B3BF667
	for <git@vger.kernel.org>; Mon, 11 May 2026 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492697; cv=none; b=DWhnt6UmLyMEAu6C5B+6P4f6mYU4Orytd51OWQV/RUmacPUr/+VAog5jJtN6P9rFSABW2ZfLaEeYylAhFzvrOAewGboFvwvLlXcQ2E0cyCkw6YAZu2dgTSXAQFUAi7QUOmQHktvghC6yisWzisS+1zWw5t0c6Qt1UhzjPebYGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492697; c=relaxed/simple;
	bh=Moct5RncryYFPgCOMMsvsGOGW8WKfqpMclIm7piEvyw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W07S5ZSA0U+RniyGBlIH8C1fP9kzPFTkeWfCy2y1HY+fmjY5vEa5AFVk0+qtBFPtTn3TYtcNarQSIGjzctSzwhPBWf0dvKo5fc4MOP5ivFuJsT8dowRgy/aL4/nS6vnNhM8B7Ni0m3bJqzAVd3MGO0cBzQCm2duQjTfRg1nGbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXjliME9; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXjliME9"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c8f9846c8so5663009c88.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778492694; x=1779097494; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiW/uVzcTgHjuv2cQKJYavnugH75CZMWHutDrFALeSY=;
        b=oXjliME9wg8aK0QFvO24A0k6KnmXpQQHfF2UBU5Ag/kTE/U6VPuT9/hNGcM/AplPVX
         OvygzyOmOJNWhn5AtPKcp1ZyneQNKG54ofc614OxMYZFOWaJMZf4CSDUzVs80+sUhUIz
         vQrQU7G7LOBu/I5jT6oSWuEGbsQA38zHwpn6NFmJbI870SbtQUVJybfmplZyAXPzEXlw
         Eqtb7bADi52w9R5jeQ2u0boy5ny89HUSv8pPCJFNz8sEqE7hDu/Aw1OmM6gJsmCMSH8W
         BN5aDRNIfLticCNGI1hxIS7NG7xZXIccpexrmNVII2RPFVVCqXC33azuzqdWABerBQyS
         iM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492694; x=1779097494;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UiW/uVzcTgHjuv2cQKJYavnugH75CZMWHutDrFALeSY=;
        b=E96SoOZuktFUPvFEhbdzlCcumJPDuvwGvhafIsAWBxCBsB739QJIJu05ZUJoAsj+G4
         RmO+9Smr5T+aFS/HzfqxNt1T2/J99Kf6mP+xHQL93hEu8i802t2+tBN4wqBdzpLjG7lz
         t9Qeog1gp9E86up64TvDNxx4a3ag7Ny6gRx6LD17S5cBG4ZeUsXpakpdn99X8Gn9A8ZM
         OULAThGLDtLUNIodO/UcDqt1vA1wtoq2X4f/pjjHsKIBJ0RzBNS6f9eRGHOA7XCwVcGp
         tPcCxQfoBqrjN5wMEIdjqikGxoNJ1sU8R7V21S4vTKs5TWu3Cj1yfo/ht55T2VQxBtHl
         yr/g==
X-Gm-Message-State: AOJu0YyneVIagc5exQ1remVsv5qmBAZMZLJRWpwC/lgyBT95wlfHI5sq
	xFHMHJjS8D33eMUj2lR7qad+wpHbQnz9qWFUDwA3betR2HvDYtj7cS+XtQDXnQ==
X-Gm-Gg: Acq92OH8yynfz8xDmGP/W2cC31N/WlItIEMrcjH6+y5xzW52XyKc4EoJdO1rY6M2YyM
	6sLrVNZfjI8HO614Re6mCFkDR2yd/dmAt3VOcRP4wiuiUjGrI0w619UClko1LkNbnb6snR8yJni
	zdiHke1mcvjsvr5Z8gBlcxcjkXMZ3+UH3tvZShzCiC0BXqZvBHCgAcP/PSSWWRogEvZLvDVNkzJ
	UXiMucEEYcI5IUtcTCQnFxcCkSqDg3QgixcGoVAmLfwOTv5fPWLbV5Yo6xFkTpKu6MGQMMWMqJj
	ZCEM5EXM+lX1dBwsRaZ/P+wbmoz7TJW/Y7NrcnQzyCyztRsKZmq5bimOldXO9ERW6vhPt6tJVv8
	PZbhUoq02KmoboBE2hnxcbPlp3F/rjVk0kHjZ9BnwlJ7v/Y4I6LFFAwSAuLPJnLjV0JEt4QY3A9
	HsRaHiDG7Wo4YMQx4auIYeTaBgp3w2
X-Received: by 2002:a05:7023:b07:b0:130:6904:e81f with SMTP id a92af1059eb24-1318eb37fe8mr9785944c88.30.1778492693503;
        Mon, 11 May 2026 02:44:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327875a269sm13773602c88.13.2026.05.11.02.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:44:52 -0700 (PDT)
Message-Id: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
References: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 09:44:46 +0000
Subject: [PATCH v6 0/5] branch: prune-merged
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

Harald Nordgren (5):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  32 +++
 builtin/branch.c                 | 344 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 278 +++++++++++++++++++++++++
 4 files changed, 647 insertions(+), 14 deletions(-)


base-commit: 7760f83b59750c27df653c5c46d0f80e44cfe02c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v6
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v5:

 1:  77e67d4b8b = 1:  fb9817b220 branch: add --forked <remote>
 2:  807c9f981f = 2:  42a2f93d44 branch: let delete_branches warn instead of error on bulk refusal
 3:  77beb620d7 ! 3:  604ecb8965 branch: add --prune-merged <remote>
     @@ Commit message
          branch: add --prune-merged <remote>
      
          Delete the local branches that --forked <remote> would list,
     -    refusing any whose tip is not reachable from its upstream
     -    remote-tracking branch. With --force, delete unconditionally.
     -    The currently checked-out branch in any worktree is always
     -    preserved.
     +    refusing any whose tip is not reachable from the remote's default
     +    branch. With --force, delete unconditionally. The currently
     +    checked-out branch in any worktree is always preserved.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a confi
      +	under some name on _<remote>_, and that name has since
      +	been pruned upstream.
      ++
     -+By default, the local tip must also be reachable from the
     -+upstream remote-tracking branch (see `--no-merged`); branches with
     -+unpushed commits are refused. With `--force` (or `-f`), delete
     -+them regardless. The currently checked-out branch in any worktree
     -+is always preserved.
     ++As a safety check, branches with commits not yet integrated into
     ++the remote's default branch are refused. With `--force` (or `-f`),
     ++delete them regardless. The currently checked-out branch in any
     ++worktree is always preserved.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c
       #include "column.h"
       #include "utf8.h"
       #include "ref-filter.h"
     +@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
     + 
     + static int check_branch_commit(const char *branchname, const char *refname,
     + 			       const struct object_id *oid, struct commit *head_rev,
     ++			       struct commit *head_rev_override,
     ++			       int use_head_rev_override,
     + 			       int kinds, int force, int warn_only,
     + 			       int *n_not_merged)
     + {
     + 	struct commit *rev = lookup_commit_reference(the_repository, oid);
     ++	int merged;
     ++
     + 	if (!force && !rev) {
     + 		error(_("couldn't look up commit object for '%s'"), refname);
     + 		return -1;
     + 	}
     +-	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     ++	if (use_head_rev_override) {
     ++		if (!head_rev_override)
     ++			return 0;
     ++		merged = repo_in_merge_bases(the_repository, rev,
     ++					     head_rev_override);
     ++		if (merged < 0)
     ++			exit(128);
     ++	} else {
     ++		merged = branch_merged(kinds, branchname, rev, head_rev);
     ++	}
     ++	if (!force && !merged) {
     + 		if (warn_only) {
     + 			warning(_("the branch '%s' is not fully merged"),
     + 				branchname);
     +@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
     + 	strbuf_release(&buf);
     + }
     + 
     +-static int delete_branches(int argc, const char **argv, int force, int kinds,
     ++static int delete_branches(int argc, const char **argv,
     ++			   struct commit **head_rev_overrides,
     ++			   int force, int kinds,
     + 			   int quiet, int warn_only, int *n_not_merged)
     + {
     + 	struct commit *head_rev = NULL;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 		}
     + 
     + 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
     +-		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
     +-					force, warn_only, n_not_merged)) {
     ++		    check_branch_commit(bname.buf, name, &oid, head_rev,
     ++					head_rev_overrides ? head_rev_overrides[i] : NULL,
     ++					!!head_rev_overrides,
     ++					kinds, force, warn_only, n_not_merged)) {
     + 			if (!warn_only)
     + 				ret = 1;
     + 			goto next;
      @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref, void *cb_data)
       	return 0;
       }
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
       	return 0;
       }
       
     ++static struct commit *resolve_remote_head(const char *remote_name)
     ++{
     ++	struct ref_store *refs = get_main_ref_store(the_repository);
     ++	struct strbuf head_ref = STRBUF_INIT;
     ++	struct object_id oid;
     ++	struct commit *commit = NULL;
     ++
     ++	strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remote_name);
     ++	if (refs_resolve_ref_unsafe(refs, head_ref.buf, RESOLVE_REF_READING,
     ++				    &oid, NULL))
     ++		commit = lookup_commit_reference(the_repository, &oid);
     ++	strbuf_release(&head_ref);
     ++	return commit;
     ++}
     ++
      +static int prune_merged_branches(int argc, const char **argv, int force,
      +				 int quiet)
      +{
      +	struct string_list candidates = STRING_LIST_INIT_DUP;
      +	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
      +	struct strvec deletable = STRVEC_INIT;
     ++	struct commit **head_rev_overrides = NULL;
     ++	size_t alloc = 0;
      +	struct string_list_item *item;
      +	int n_not_merged = 0;
      +	int ret = 0;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +		struct branch *branch;
      +		const char *push_ref;
      +		const char *upstream;
     ++		const char *remote_name;
     ++		const char *slash;
      +
      +		strbuf_addf(&full, "refs/heads/%s", short_name);
      +		if (branch_checked_out(full.buf)) {
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +		if (string_list_has_string(&protected_default_refs, push_ref))
      +			continue;
      +
     ++		ALLOC_GROW(head_rev_overrides, deletable.nr + 1, alloc);
     ++		remote_name = push_ref + strlen("refs/remotes/");
     ++		slash = strchr(remote_name, '/');
     ++		if (slash) {
     ++			char *name = xstrndup(remote_name, slash - remote_name);
     ++			head_rev_overrides[deletable.nr] = resolve_remote_head(name);
     ++			free(name);
     ++		} else {
     ++			head_rev_overrides[deletable.nr] = NULL;
     ++		}
      +		strvec_push(&deletable, short_name);
      +	}
      +
      +	if (deletable.nr)
     -+		ret = delete_branches(deletable.nr, deletable.v, force,
     ++		ret = delete_branches(deletable.nr, deletable.v,
     ++				      head_rev_overrides, force,
      +				      FILTER_REFS_BRANCHES, quiet,
      +				      1, &n_not_merged);
      +
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +			n_not_merged);
      +
      +	strvec_clear(&deletable);
     ++	free(head_rev_overrides);
      +	string_list_clear(&candidates, 0);
      +	string_list_clear(&protected_default_refs, 0);
      +	return ret;
     @@ builtin/branch.c: int cmd_branch(int argc,
       		usage_with_options(builtin_branch_usage, options);
       
      @@ builtin/branch.c: int cmd_branch(int argc,
     + 	if (delete) {
     + 		if (!argc)
     + 			die(_("branch name required"));
     +-		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     ++		ret = delete_branches(argc, argv, NULL, delete > 1, filter.kind,
     + 				      quiet, 0, NULL);
     + 		goto out;
       	} else if (forked) {
       		ret = list_forked_branches(argc, argv);
       		goto out;
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	test_must_fail git -C pm-force rev-parse --verify refs/heads/one
      +'
      +
     ++test_expect_success '--prune-merged measures merged-ness against <remote>/HEAD, not local HEAD' '
     ++	test_when_finished "rm -rf pm-head-indep" &&
     ++	git clone pm-upstream pm-head-indep &&
     ++	git -C pm-head-indep branch one --track origin/one &&
     ++	git -C pm-head-indep update-ref -d refs/remotes/origin/one &&
     ++	# Detach HEAD to an unrelated commit so the candidate is not
     ++	# reachable from local HEAD; it is still reachable from
     ++	# refs/remotes/origin/HEAD, which is what should matter.
     ++	git -C pm-head-indep commit --allow-empty -m unrelated &&
     ++	git -C pm-head-indep checkout --detach &&
     ++	git -C pm-head-indep reset --hard HEAD^ &&
     ++
     ++	git -C pm-head-indep branch --prune-merged origin &&
     ++
     ++	test_must_fail git -C pm-head-indep rev-parse --verify refs/heads/one
     ++'
     ++
     ++test_expect_success '--prune-merged skips merged-ness check when <remote>/HEAD is unset' '
     ++	test_when_finished "rm -rf pm-no-head" &&
     ++	git clone pm-upstream pm-no-head &&
     ++	git -C pm-no-head checkout -b one --track origin/one &&
     ++	test_commit -C pm-no-head unpushed &&
     ++	git -C pm-no-head checkout - &&
     ++
     ++	git -C pm-no-head update-ref -d refs/remotes/origin/HEAD &&
     ++	git -C pm-no-head update-ref -d refs/remotes/origin/one &&
     ++	git -C pm-no-head branch --prune-merged origin &&
     ++
     ++	test_must_fail git -C pm-no-head rev-parse --verify refs/heads/one
     ++'
     ++
      +test_expect_success '--prune-merged never deletes the checked-out branch' '
      +	test_when_finished "rm -rf pm-head" &&
      +	git clone pm-upstream pm-head &&
 4:  cf69fb5767 ! 4:  717fc6758e branch: add branch.<name>.pruneMerged opt-out
     @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a confi
      +	the branch was pushed under some name on _<remote>_, and
      +	that name has since been pruned upstream.
       +
     --By default, the local tip must also be reachable from the
     --upstream remote-tracking branch (see `--no-merged`); branches with
     --unpushed commits are refused. With `--force` (or `-f`), delete
     --them regardless. The currently checked-out branch in any worktree
     --is always preserved.
     -+The local tip must also be reachable from the upstream
     -+remote-tracking branch; branches with unpushed commits are refused.
     -+With `--force` (or `-f`), delete them regardless. The currently
     -+checked-out branch in any worktree is always preserved, as is
     -+any branch with `branch.<name>.pruneMerged` set to `false`.
     + As a safety check, branches with commits not yet integrated into
     + the remote's default branch are refused. With `--force` (or `-f`),
     + delete them regardless. The currently checked-out branch in any
     +-worktree is always preserved.
     ++worktree is always preserved, as is any branch with
     ++`branch.<name>.pruneMerged` set to `false`.
       
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       		struct branch *branch;
       		const char *push_ref;
       		const char *upstream;
     + 		const char *remote_name;
     + 		const char *slash;
      +		int opt_out = 0;
       
       		strbuf_addf(&full, "refs/heads/%s", short_name);
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      +		}
      +		strbuf_release(&key);
       
     - 		strvec_push(&deletable, short_name);
     - 	}
     + 		ALLOC_GROW(head_rev_overrides, deletable.nr + 1, alloc);
     + 		remote_name = push_ref + strlen("refs/remotes/");
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success '--prune-merged spares branches whose push ref is the defaul
 5:  f2cee8c79b ! 5:  be25572957 branch: add --all-remotes flag
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: With `--force` (or `-f`), delete them regardless. The currently
     - checked-out branch in any worktree is always preserved, as is
     - any branch with `branch.<name>.pruneMerged` set to `false`.
     +@@ Documentation/git-branch.adoc: delete them regardless. The currently checked-out branch in any
     + worktree is always preserved, as is any branch with
     + `branch.<name>.pruneMerged` set to `false`.
       
      +`--all-remotes`::
      +	With `--forked` or `--prune-merged`, act on every
     @@ builtin/branch.c: static void collect_forked_set(int argc, const char **argv,
       	for_each_string_list_item(item, &out)
       		puts(item->string);
       
     -@@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
     - 	return 0;
     +@@ builtin/branch.c: static struct commit *resolve_remote_head(const char *remote_name)
     + 	return commit;
       }
       
      -static int prune_merged_branches(int argc, const char **argv, int force,

-- 
gitgitgadget
