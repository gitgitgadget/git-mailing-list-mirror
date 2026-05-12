Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225F385D64
	for <git@vger.kernel.org>; Tue, 12 May 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605665; cv=none; b=pHvyWYLGQqAgGUYVUBGsaD0xeUA9SQEQ6ph5MJy/sEuMTYxMRJ1Wpgjc0gEECyF/HAXKhGqOWPOCBGHfhj59VbsPCh2kKHUdiJcZ3dRoINAwfqZfGRgAj2qlVdOdr3qKAdHBW/l2SMKnVfGVvzF40kUugBFz1CJOaI1vNXjjxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605665; c=relaxed/simple;
	bh=98lUCgaRCIqGmWIxVwA7K+Ox+9wCZi1BJ+Gf/LU/CQ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M9twsCH5JquhfTXURhp67Vw2y2McApqUXj6S++NZ7OeP64UCOB/b+/E2AmjxyN2ckocquX5hYU2x6JoAYQxXIHApyTUbcSnuW4h6hxLy7z52h1BkQUNkL3XBdLrG/ntHD98yk+LYBgUem6lXTLBOl9uRA82CpvVnod88GNiT/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWWE5nQo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWWE5nQo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba856db1c0so39553905ad.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605661; x=1779210461; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNWUGVcXobY+N8WOzU3HX4jv3/h7LtfbkDGF35tJoVc=;
        b=DWWE5nQohXvvUwXjtQg19BdcMjev7A8/9bwtFqdC7lcxBYKCvSxOfs5ktxxWTo1hM4
         2toWtxUTz1+rJSiYmK0ciPR+JL5FJyC0YceOf8kHHB9H2bqt+x71BJGOHhjhjPUlQ5B6
         +nrEKx3DB0SJGOwZ2YeQPdV4n+06oDUxtxTFx9zO+eFdMm7QyL7165JjS5XN4vi95QYI
         PRZV+TmJNbpT51iWnCk1L+Wx/TaMEqTIhwCuCr7T3RFMdkP1Rn0sj3r8c6XYpfCCGNnp
         ZHj9tOC90JtKUDxcbvKIhNfF/ggCP8wec61GBI+cuXGOecn9iJvHSqdWky2m9QVApLwy
         FwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605661; x=1779210461;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNWUGVcXobY+N8WOzU3HX4jv3/h7LtfbkDGF35tJoVc=;
        b=qRjYj0eP31a1kAj9X3K1We6AiW5ZgtmmYCtzbW3IOHymaZufggdxIjbdqz6d12zs8t
         Z3aQQadi0T4qSCKFHtsCUYxq++9U0yXtWIwCsZCZvHHkIyECrzwsWPbf/AgfSQaGxQuJ
         Kjk732ZLz5kDU+l5ZZFE78Q3Lb4SYZsdAZbhoaHtTE2hqsCoKs8F7Gzkwnu1+W2G8o7M
         ooxbd8zdAoaClCFLwKJ2w5Zo6NbsMl0KEqdZVJMwipctc7C0sBeFncgjT24b+36jNt4N
         xslOxKICd4kZ4hjPN3dk52Gk1RcxvcOPMqISin8tw6sgeqkRPKYs9s47WrO2HMuxEQBh
         3tEg==
X-Gm-Message-State: AOJu0YzFtDFSEVPz9rVSePSQAZYRJEWRX2U/F1M2q8ALUwL4Zq6ryGCA
	SU44HpMAwQIIllszGf3tncYgC5SStzcWQ7pO9MWez0i4Z0OEM/5sVGL6CAZZbg==
X-Gm-Gg: Acq92OGTiJ0FiSfVVgg/0h7Er8gHy3mIUpYtZldWfF4BaOn9zdzQ1gZLlGaMiuyolt9
	3mnDDNJilZA+F8/bErS8yQUxJXq3zrr8T2qXon8WASEb6XWwca57lK14TbL6tS2U+nKQGyOgHZY
	/BkOWL31VW6k5C5JobguHwK0we4D9y327pSwd/+fOF/fGdAd49LlI3fzwVZaKi4uERk8ggQHaxi
	Kryokb3QBjH9+o94L1mDL/bp9nvHv7aPagcZhnbexX/5rDuQgiS9JowStoT5pU5U97gva4ylQyI
	Y3vhus/TlnYaT51c9jMC08Odp/bUNb5uqcwWJFqoVU6t4Gi22eI7idRgyQnOVD1Dm0otXIb1BoL
	WlQt4oPJZGIwzW4OZej2vLEtr2q6s77+h7DFUwuAp05Kw/1yATirt0t2I46RsBIB9zoMJF8O6kd
	AVjQGODflMFplVIGM0e2uFACoxpO4e/7OkeCwaEA==
X-Received: by 2002:a17:902:ebca:b0:2b4:5aff:de60 with SMTP id d9443c01a7336-2bc7aa13879mr175764315ad.22.1778605661218;
        Tue, 12 May 2026 10:07:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.246.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead938sm149342085ad.73.2026.05.12.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:07:40 -0700 (PDT)
Message-Id: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
References: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 17:07:33 +0000
Subject: [PATCH v8 0/5] branch: prune-merged
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

 * Delete only when the branch's work is actually reachable from its
   upstream
 * Skip branches whose upstream is gone (even with --force)
 * Simplified the internal safety flag to live in one place

Harald Nordgren (5):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  38 ++++
 builtin/branch.c                 | 291 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 235 +++++++++++++++++++++++++
 4 files changed, 555 insertions(+), 16 deletions(-)


base-commit: 29bd7ed5127255713c1ac2f43b7c6f257d7b4594
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v8
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v7:

 1:  22fa8515df = 1:  22fa8515df branch: add --forked <remote>
 2:  b443f0f367 = 2:  b443f0f367 branch: let delete_branches warn instead of error on bulk refusal
 3:  a245009893 ! 3:  3032e9c39a branch: add --prune-merged <remote>
     @@ Metadata
       ## Commit message ##
          branch: add --prune-merged <remote>
      
     -    Delete the local branches that --forked <remote> would list,
     -    refusing any whose tip is not reachable from the remote's default
     -    branch. With --force, delete unconditionally. The currently
     -    checked-out branch in any worktree is always preserved.
     +    Delete the local branches that --forked <remote> would list, but
     +    only those whose tip is reachable from their configured upstream
     +    remote-tracking branch (branch.<name>.merge): the work has already
     +    landed on the upstream it tracks, so the local copy is no longer
     +    needed.
     +
     +    A branch whose upstream no longer resolves locally is left alone --
     +    its disappearance is not, on its own, evidence that the work was
     +    integrated. With --force, skip the reachability check and delete
     +    every branch in the candidate set. The currently checked-out
     +    branch in any worktree is always preserved, as is the local branch
     +    that mirrors <remote>'s default branch.
     +
     +    Reachability is read from whatever the remote-tracking refs say
     +    locally, so the natural workflow is
     +
     +            git fetch <remote>
     +            git branch --prune-merged <remote>
     +
     +    with no implicit cleanup driven by fetch itself.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a confi
       
      +`--prune-merged`::
      +	Delete the local branches that `--forked` would list for
     -+	the same _<remote>_ arguments, but only when the branch's
     -+	push destination remote-tracking branch (the branch `git push`
     -+	would update; see `branch_get_push` semantics) no longer
     -+	resolves locally. In other words: the branch was pushed
     -+	under some name on _<remote>_, and that name has since
     -+	been pruned upstream.
     ++	the same _<remote>_ arguments, but only those whose tip is
     ++	reachable from their configured upstream remote-tracking
     ++	branch (`branch.<name>.merge`). In other words: the work on
     ++	the branch has already landed on the upstream it tracks, so
     ++	the local copy is no longer needed.
     +++
     ++Run `git fetch` first so the upstream remote-tracking branches
     ++reflect the current state of _<remote>_; reachability is checked
     ++against whatever the remote-tracking refs say locally.
      ++
     -+As a safety check, branches with commits not yet integrated into
     -+their upstream remote-tracking branch are refused; if the upstream
     -+itself is gone, the remote's default branch is consulted instead.
     -+With `--force` (or `-f`), delete refused branches regardless. The
     -+currently checked-out branch in any worktree is always preserved.
     ++A branch whose upstream no longer resolves locally is left alone
     ++(its disappearance is not, on its own, evidence that the work was
     ++integrated). With `--force` (or `-f`), the reachability check is
     ++skipped and every branch in the candidate set is deleted. The
     ++currently checked-out branch in any worktree is always preserved,
     ++as is the local branch that mirrors _<remote>_'s default branch.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c
       #include "column.h"
       #include "utf8.h"
       #include "ref-filter.h"
     -@@ builtin/branch.c: static const char *branch_get_color(enum color_branch ix)
     - }
     - 
     - static int branch_merged(int kind, const char *name,
     --			 struct commit *rev, struct commit *head_rev)
     -+			 struct commit *rev, struct commit *head_rev,
     -+			 int no_head_fallback)
     - {
     - 	/*
     - 	 * This checks whether the merge bases of branch and HEAD (or
     -@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
     - 					 &oid, NULL)) != NULL)
     - 			reference_rev = lookup_commit_reference(the_repository,
     - 								&oid);
     -+
     -+		if (!reference_rev && no_head_fallback && upstream &&
     -+		    starts_with(upstream, "refs/remotes/")) {
     -+			const char *remote_name = upstream + strlen("refs/remotes/");
     -+			const char *slash = strchr(remote_name, '/');
     -+			if (slash) {
     -+				struct strbuf head_ref = STRBUF_INIT;
     -+				strbuf_add(&head_ref, "refs/remotes/", strlen("refs/remotes/"));
     -+				strbuf_add(&head_ref, remote_name, slash - remote_name);
     -+				strbuf_addstr(&head_ref, "/HEAD");
     -+				if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     -+							    head_ref.buf,
     -+							    RESOLVE_REF_READING,
     -+							    &oid, NULL))
     -+					reference_rev = lookup_commit_reference(the_repository,
     -+										&oid);
     -+				strbuf_release(&head_ref);
     -+			}
     -+		}
     - 	}
     --	if (!reference_rev)
     -+	if (!reference_rev) {
     -+		if (no_head_fallback) {
     -+			free(reference_name_to_free);
     -+			return 0;
     -+		}
     - 		reference_rev = head_rev;
     -+	}
     - 
     - 	merged = reference_rev ? repo_in_merge_bases(the_repository, rev,
     - 						     reference_rev) : 0;
      @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
       	 * any of the following code, but during the transition period,
       	 * a gentle reminder is in order.
       	 */
      -	if (head_rev != reference_rev) {
     -+	if (!no_head_fallback && head_rev != reference_rev) {
     - 		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
     +-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
     ++	if (head_rev && head_rev != reference_rev) {
     ++		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
       		if (expect < 0)
       			exit(128);
     -@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
     - 
     - static int check_branch_commit(const char *branchname, const char *refname,
     - 			       const struct object_id *oid, struct commit *head_rev,
     -+			       int no_head_fallback,
     - 			       int kinds, int force, int warn_only,
     - 			       int *n_not_merged)
     - {
     -@@ builtin/branch.c: static int check_branch_commit(const char *branchname, const char *refname,
     - 		error(_("couldn't look up commit object for '%s'"), refname);
     - 		return -1;
     - 	}
     --	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     -+	if (!force && !branch_merged(kinds, branchname, rev, head_rev,
     -+				     no_head_fallback)) {
     - 		if (warn_only) {
     - 			warning(_("the branch '%s' is not fully merged"),
     - 				branchname);
     + 		if (expect == merged)
      @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       	strbuf_release(&buf);
       }
     @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       			   int quiet, int warn_only, int *n_not_merged)
       {
       	struct commit *head_rev = NULL;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 	}
     + 	branch_name_pos = strcspn(fmt, "%");
     + 
     +-	if (!force)
     ++	if (!force && !no_head_fallback)
     + 		head_rev = lookup_commit_reference(the_repository, &head_oid);
     + 
     + 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
       		}
       
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      -		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
      -					force, warn_only, n_not_merged)) {
      +		    check_branch_commit(bname.buf, name, &oid, head_rev,
     -+					no_head_fallback,
      +					kinds, force, warn_only, n_not_merged)) {
       			if (!warn_only)
       				ret = 1;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +		const char *short_name = item->string;
      +		struct strbuf full = STRBUF_INIT;
      +		struct branch *branch;
     -+		const char *push_ref;
      +		const char *upstream;
      +
      +		strbuf_addf(&full, "refs/heads/%s", short_name);
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +
      +		branch = branch_get(short_name);
      +		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
     -+		if (upstream &&
     -+		    string_list_has_string(&protected_default_refs, upstream)) {
     ++		if (!upstream ||
     ++		    !refs_ref_exists(get_main_ref_store(the_repository),
     ++				     upstream))
     ++			continue;
     ++		if (string_list_has_string(&protected_default_refs, upstream)) {
      +			const char *leaf = strrchr(upstream, '/');
      +			if (leaf && !strcmp(leaf + 1, short_name))
      +				continue;
      +		}
      +
     -+		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
     -+		if (!push_ref)
     -+			continue;
     -+		if (refs_ref_exists(get_main_ref_store(the_repository),
     -+				    push_ref))
     -+			continue;
     -+		if (string_list_has_string(&protected_default_refs, push_ref))
     -+			continue;
     -+
      +		strvec_push(&deletable, short_name);
      +	}
      +
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +test_expect_success '--prune-merged: setup' '
      +	test_create_repo pm-upstream &&
      +	test_commit -C pm-upstream base &&
     -+	git -C pm-upstream branch one base &&
     -+	git -C pm-upstream branch two base
     -+'
     -+
     -+test_expect_success '--prune-merged deletes branches whose push ref is gone' '
     -+	test_when_finished "rm -rf pm-clean" &&
     -+	git clone pm-upstream pm-clean &&
     -+	git -C pm-clean branch one --track origin/one &&
     -+	git -C pm-clean branch two --track origin/two &&
     -+
     -+	git -C pm-clean update-ref -d refs/remotes/origin/one &&
     -+	git -C pm-clean branch --prune-merged origin &&
     -+
     -+	test_must_fail git -C pm-clean rev-parse --verify refs/heads/one &&
     -+	git -C pm-clean rev-parse --verify refs/heads/two
     ++	git -C pm-upstream checkout -b next &&
     ++	test_commit -C pm-upstream one-commit &&
     ++	test_commit -C pm-upstream two-commit &&
     ++	git -C pm-upstream branch one HEAD~ &&
     ++	git -C pm-upstream branch two HEAD &&
     ++	git -C pm-upstream branch wip main &&
     ++	git -C pm-upstream checkout main
      +'
      +
     -+test_expect_success '--prune-merged spares in-flight branches whose push ref still exists' '
     -+	test_when_finished "rm -rf pm-inflight" &&
     -+	git clone pm-upstream pm-inflight &&
     -+	git -C pm-inflight branch one --track origin/one &&
     ++test_expect_success '--prune-merged deletes branches integrated into upstream' '
     ++	test_when_finished "rm -rf pm-merged" &&
     ++	git clone pm-upstream pm-merged &&
     ++	git -C pm-merged branch one one-commit &&
     ++	git -C pm-merged branch --set-upstream-to=origin/next one &&
     ++	git -C pm-merged branch two two-commit &&
     ++	git -C pm-merged branch --set-upstream-to=origin/next two &&
      +
     -+	git -C pm-inflight branch --prune-merged origin &&
     ++	git -C pm-merged branch --prune-merged origin &&
      +
     -+	git -C pm-inflight rev-parse --verify refs/heads/one
     ++	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
     ++	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
      +'
      +
     -+test_expect_success '--prune-merged skips branches with unpushed commits' '
     ++test_expect_success '--prune-merged spares branches with un-integrated commits' '
      +	test_when_finished "rm -rf pm-unmerged" &&
      +	git clone pm-upstream pm-unmerged &&
     -+	git -C pm-unmerged checkout -b one --track origin/one &&
     -+	test_commit -C pm-unmerged unpushed &&
     ++	git -C pm-unmerged checkout -b wip origin/wip &&
     ++	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
     ++	test_commit -C pm-unmerged local-only &&
      +	git -C pm-unmerged checkout - &&
      +
     -+	git -C pm-unmerged update-ref -d refs/remotes/origin/one &&
      +	git -C pm-unmerged branch --prune-merged origin 2>err &&
      +	test_grep "not fully merged" err &&
      +	test_grep "Skipped 1 branch" err &&
      +	test_grep "re-run with --force" err &&
      +	test_grep ! "If you are sure you want to delete it" err &&
     -+	git -C pm-unmerged rev-parse --verify refs/heads/one
     ++	git -C pm-unmerged rev-parse --verify refs/heads/wip
      +'
      +
     -+test_expect_success '--prune-merged --force deletes branches with unpushed commits' '
     ++test_expect_success '--prune-merged --force deletes branches regardless of reachability' '
      +	test_when_finished "rm -rf pm-force" &&
      +	git clone pm-upstream pm-force &&
     -+	git -C pm-force checkout -b one --track origin/one &&
     -+	test_commit -C pm-force unpushed &&
     ++	git -C pm-force checkout -b wip origin/wip &&
     ++	git -C pm-force branch --set-upstream-to=origin/next wip &&
     ++	test_commit -C pm-force local-only &&
      +	git -C pm-force checkout - &&
      +
     -+	git -C pm-force update-ref -d refs/remotes/origin/one &&
      +	git -C pm-force branch --force --prune-merged origin &&
      +
     -+	test_must_fail git -C pm-force rev-parse --verify refs/heads/one
     ++	test_must_fail git -C pm-force rev-parse --verify refs/heads/wip
      +'
      +
     -+test_expect_success '--prune-merged falls back to remote default branch when upstream is gone' '
     -+	test_when_finished "rm -rf pm-fallback" &&
     -+	git clone pm-upstream pm-fallback &&
     -+	git -C pm-fallback branch one --track origin/one &&
     -+	git -C pm-fallback update-ref -d refs/remotes/origin/one &&
     -+	# Detach HEAD to an unrelated commit so the candidate is not
     -+	# reachable from local HEAD. The upstream origin/one is now
     -+	# gone; the merged-ness check should fall back to
     -+	# refs/remotes/origin/HEAD, against which "one" is reachable.
     -+	git -C pm-fallback commit --allow-empty -m unrelated &&
     -+	git -C pm-fallback checkout --detach &&
     -+	git -C pm-fallback reset --hard HEAD^ &&
     -+
     -+	git -C pm-fallback branch --prune-merged origin &&
     -+
     -+	test_must_fail git -C pm-fallback rev-parse --verify refs/heads/one
     -+'
     ++test_expect_success '--prune-merged skips branches whose upstream is gone' '
     ++	test_when_finished "rm -rf pm-upstream-gone" &&
     ++	git clone pm-upstream pm-upstream-gone &&
     ++	git -C pm-upstream-gone branch one one-commit &&
     ++	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
      +
     -+test_expect_success '--prune-merged refuses when upstream and remote default are both gone' '
     -+	test_when_finished "rm -rf pm-both-gone" &&
     -+	git clone pm-upstream pm-both-gone &&
     -+	git -C pm-both-gone checkout -b one --track origin/one &&
     -+	test_commit -C pm-both-gone unpushed &&
     -+	git -C pm-both-gone checkout - &&
     ++	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
     ++	git -C pm-upstream-gone branch --prune-merged origin &&
      +
     -+	git -C pm-both-gone update-ref -d refs/remotes/origin/HEAD &&
     -+	git -C pm-both-gone update-ref -d refs/remotes/origin/one &&
     -+	git -C pm-both-gone branch --prune-merged origin 2>err &&
     -+	test_grep "not fully merged" err &&
     -+
     -+	git -C pm-both-gone rev-parse --verify refs/heads/one
     ++	git -C pm-upstream-gone rev-parse --verify refs/heads/one
      +'
      +
      +test_expect_success '--prune-merged never deletes the checked-out branch' '
      +	test_when_finished "rm -rf pm-head" &&
      +	git clone pm-upstream pm-head &&
     -+	git -C pm-head checkout -b one --track origin/one &&
     ++	git -C pm-head checkout -b one one-commit &&
     ++	git -C pm-head branch --set-upstream-to=origin/next one &&
      +
     -+	git -C pm-head update-ref -d refs/remotes/origin/one &&
      +	git -C pm-head branch --force --prune-merged origin &&
      +
      +	git -C pm-head rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success '--prune-merged deletes when push ref differs from upstream' '
     -+	test_when_finished "rm -rf pm-pushdiff" &&
     -+	git clone pm-upstream pm-pushdiff &&
     -+	git -C pm-pushdiff config push.default current &&
     -+	git -C pm-pushdiff branch --track topic-a origin/one &&
     -+
     -+	git -C pm-pushdiff branch --force --prune-merged origin &&
     -+
     -+	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
     -+'
     -+
      +test_expect_success '--prune-merged spares the local default branch' '
      +	test_when_finished "rm -rf pm-default" &&
      +	git clone pm-upstream pm-default &&
     -+	git -C pm-default config push.default current &&
      +	git -C pm-default checkout --detach &&
     -+	git -C pm-default branch --prune-merged origin &&
     ++	git -C pm-default branch --force --prune-merged origin &&
      +	git -C pm-default rev-parse --verify refs/heads/main
      +'
      +
      +test_expect_success '--prune-merged protects only the default branch by name, not by upstream' '
      +	test_when_finished "rm -rf pm-default-alias" &&
      +	git clone pm-upstream pm-default-alias &&
     -+	git -C pm-default-alias config push.default current &&
      +	git -C pm-default-alias branch --track trunk origin/main &&
      +	git -C pm-default-alias checkout --detach &&
     -+	git -C pm-default-alias branch --force --prune-merged origin &&
     ++	git -C pm-default-alias branch --prune-merged origin &&
      +	git -C pm-default-alias rev-parse --verify refs/heads/main &&
      +	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
      +'
     -+
     -+test_expect_success '--prune-merged spares branches whose push ref is the default branch' '
     -+	test_when_finished "rm -rf pm-pushdefault" &&
     -+	git clone pm-upstream pm-pushdefault &&
     -+	git -C pm-pushdefault branch --track topic origin/one &&
     -+	git -C pm-pushdefault config --add remote.origin.push refs/heads/topic:refs/heads/main &&
     -+	git -C pm-pushdefault update-ref -d refs/remotes/origin/one &&
     -+	git -C pm-pushdefault update-ref -d refs/remotes/origin/main &&
     -+	git -C pm-pushdefault checkout --detach &&
     -+	git -C pm-pushdefault branch --prune-merged origin &&
     -+	git -C pm-pushdefault rev-parse --verify refs/heads/topic
     -+'
      +
       test_done
 4:  2c3f751569 ! 4:  dd33309344 branch: add branch.<name>.pruneMerged opt-out
     @@ Commit message
          branch: add branch.<name>.pruneMerged opt-out
      
          Setting branch.<name>.pruneMerged=false exempts that branch from
     -    --prune-merged (and from fetch --prune-merged), even with --force.
     -    Useful for keeping a topic branch around between rounds.
     +    --prune-merged, even with --force. Useful for keeping a topic
     +    branch around between rounds.
      
          Explicit deletion via 'git branch -d' is unaffected.
      
     @@ Documentation/config/branch.adoc: for details).
      +	Explicit deletion via `git branch -d` is unaffected.
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a configured remote
     - 	Delete the local branches that `--forked` would list for
     - 	the same _<remote>_ arguments, but only when the branch's
     - 	push destination remote-tracking branch (the branch `git push`
     --	would update; see `branch_get_push` semantics) no longer
     --	resolves locally. In other words: the branch was pushed
     --	under some name on _<remote>_, and that name has since
     --	been pruned upstream.
     -+	would update) no longer resolves locally. In other words:
     -+	the branch was pushed under some name on _<remote>_, and
     -+	that name has since been pruned upstream.
     - +
     - As a safety check, branches with commits not yet integrated into
     - their upstream remote-tracking branch are refused; if the upstream
     - itself is gone, the remote's default branch is consulted instead.
     - With `--force` (or `-f`), delete refused branches regardless. The
     --currently checked-out branch in any worktree is always preserved.
     -+currently checked-out branch in any worktree is always preserved,
     -+as is any branch with `branch.<name>.pruneMerged` set to `false`.
     +@@ Documentation/git-branch.adoc: A branch whose upstream no longer resolves locally is left alone
     + integrated). With `--force` (or `-f`), the reachability check is
     + skipped and every branch in the candidate set is deleted. The
     + currently checked-out branch in any worktree is always preserved,
     +-as is the local branch that mirrors _<remote>_'s default branch.
     ++as is any branch with `branch.<name>.pruneMerged` set to `false`,
     ++and the local branch that mirrors _<remote>_'s default branch.
       
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       		struct strbuf full = STRBUF_INIT;
      +		struct strbuf key = STRBUF_INIT;
       		struct branch *branch;
     - 		const char *push_ref;
       		const char *upstream;
      +		int opt_out = 0;
       
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       		}
       		strbuf_release(&full);
      @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int force,
     - 		if (upstream &&
     - 		    string_list_has_string(&protected_default_refs, upstream)) {
     + 		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
     + 		if (!upstream ||
     + 		    !refs_ref_exists(get_main_ref_store(the_repository),
     +-				     upstream))
     ++				     upstream)) {
     ++			strbuf_release(&key);
     + 			continue;
     ++		}
     + 		if (string_list_has_string(&protected_default_refs, upstream)) {
       			const char *leaf = strrchr(upstream, '/');
      -			if (leaf && !strcmp(leaf + 1, short_name))
      +			if (leaf && !strcmp(leaf + 1, short_name)) {
      +				strbuf_release(&key);
       				continue;
      +			}
     - 		}
     - 
     - 		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
     --		if (!push_ref)
     -+		if (!push_ref) {
     -+			strbuf_release(&key);
     - 			continue;
     -+		}
     - 		if (refs_ref_exists(get_main_ref_store(the_repository),
     --				    push_ref))
     -+				    push_ref)) {
     -+			strbuf_release(&key);
     -+			continue;
     -+		}
     -+		if (string_list_has_string(&protected_default_refs, push_ref)) {
     -+			strbuf_release(&key);
     - 			continue;
     --		if (string_list_has_string(&protected_default_refs, push_ref))
      +		}
      +
      +		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      +						  "(branch.%s.pruneMerged is false)\n"),
      +					short_name, short_name);
      +			strbuf_release(&key);
     - 			continue;
     -+		}
     ++			continue;
     + 		}
      +		strbuf_release(&key);
       
       		strvec_push(&deletable, short_name);
       	}
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--prune-merged spares branches whose push ref is the defaul
     - 	git -C pm-pushdefault rev-parse --verify refs/heads/topic
     +@@ t/t3200-branch.sh: test_expect_success '--prune-merged protects only the default branch by name, no
     + 	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
       '
       
      +test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
      +	test_when_finished "rm -rf pm-optout" &&
      +	git clone pm-upstream pm-optout &&
     -+	git -C pm-optout branch one --track origin/one &&
     -+	git -C pm-optout branch two --track origin/two &&
     ++	git -C pm-optout branch one one-commit &&
     ++	git -C pm-optout branch --set-upstream-to=origin/next one &&
     ++	git -C pm-optout branch two two-commit &&
     ++	git -C pm-optout branch --set-upstream-to=origin/next two &&
      +	git -C pm-optout config branch.one.pruneMerged false &&
      +
     -+	git -C pm-optout update-ref -d refs/remotes/origin/one &&
     -+	git -C pm-optout update-ref -d refs/remotes/origin/two &&
      +	git -C pm-optout branch --prune-merged origin 2>err &&
      +
      +	git -C pm-optout rev-parse --verify refs/heads/one &&
     @@ t/t3200-branch.sh: test_expect_success '--prune-merged spares branches whose pus
      +test_expect_success '--prune-merged --force still honours pruneMerged=false' '
      +	test_when_finished "rm -rf pm-optout-force" &&
      +	git clone pm-upstream pm-optout-force &&
     -+	git -C pm-optout-force checkout -b one --track origin/one &&
     -+	test_commit -C pm-optout-force unpushed &&
     ++	git -C pm-optout-force checkout -b wip origin/wip &&
     ++	git -C pm-optout-force branch --set-upstream-to=origin/next wip &&
     ++	test_commit -C pm-optout-force local-only &&
      +	git -C pm-optout-force checkout - &&
     -+	git -C pm-optout-force config branch.one.pruneMerged false &&
     ++	git -C pm-optout-force config branch.wip.pruneMerged false &&
      +
     -+	git -C pm-optout-force update-ref -d refs/remotes/origin/one &&
      +	git -C pm-optout-force branch --force --prune-merged origin &&
      +
     -+	git -C pm-optout-force rev-parse --verify refs/heads/one
     ++	git -C pm-optout-force rev-parse --verify refs/heads/wip
      +'
      +
      +test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
      +	test_when_finished "rm -rf pm-optout-d" &&
      +	git clone pm-upstream pm-optout-d &&
     -+	git -C pm-optout-d branch one --track origin/one &&
     ++	git -C pm-optout-d branch one one-commit &&
     ++	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
      +	git -C pm-optout-d config branch.one.pruneMerged false &&
      +
      +	git -C pm-optout-d branch -d one &&
 5:  f79707ce7c ! 5:  6e81ed3147 branch: add --all-remotes flag
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: With `--force` (or `-f`), delete refused branches regardless. The
     - currently checked-out branch in any worktree is always preserved,
     - as is any branch with `branch.<name>.pruneMerged` set to `false`.
     +@@ Documentation/git-branch.adoc: currently checked-out branch in any worktree is always preserved,
     + as is any branch with `branch.<name>.pruneMerged` set to `false`,
     + and the local branch that mirrors _<remote>_'s default branch.
       
      +`--all-remotes`::
      +	With `--forked` or `--prune-merged`, act on every
     @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=fa
       '
       
      +test_expect_success '--prune-merged --all-remotes covers every configured remote' '
     -+	test_when_finished "rm -rf pm-allremotes" &&
     ++	test_when_finished "rm -rf pm-allremotes pm-other" &&
      +	git clone pm-upstream pm-allremotes &&
      +	test_create_repo pm-other &&
      +	test_commit -C pm-other other-base &&
     -+	git -C pm-other branch foreign other-base &&
     ++	git -C pm-other checkout -b stable &&
     ++	test_commit -C pm-other foreign-commit &&
     ++	git -C pm-other branch foreign HEAD &&
     ++	git -C pm-other checkout main &&
     ++
      +	git -C pm-allremotes remote add other ../pm-other &&
      +	git -C pm-allremotes fetch other &&
     -+	git -C pm-allremotes branch one --track origin/one &&
     -+	git -C pm-allremotes branch foreign --track other/foreign &&
     ++	git -C pm-allremotes branch one one-commit &&
     ++	git -C pm-allremotes branch --set-upstream-to=origin/next one &&
     ++	git -C pm-allremotes branch foreign other/foreign &&
     ++	git -C pm-allremotes branch --set-upstream-to=other/stable foreign &&
      +
     -+	git -C pm-allremotes update-ref -d refs/remotes/origin/one &&
     -+	git -C pm-allremotes update-ref -d refs/remotes/other/foreign &&
     -+	git -C pm-allremotes branch --force --prune-merged --all-remotes &&
     ++	git -C pm-allremotes branch --prune-merged --all-remotes &&
      +
      +	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign

-- 
gitgitgadget
