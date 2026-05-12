Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7D494A03
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574239; cv=none; b=YLcNv/w/Za9KXu2+3M1yxhUyq/4txAAUuIUaANzwFT2AmL17GN8DRg5+oh1ojvTF6X5WuPTwjWLMa2XS3ubqiYjAQO01/hyGL531mQohjV2ZahAyraoh6Vk6fmXwPaVhFwzB2KP1Rjm6KSu+Hz5Am0Z0r7jN0FAqKHNr4d124+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574239; c=relaxed/simple;
	bh=g+8Fsj6XkNfkQPN5s1NuzCCKbCYgLrRk8QgD0Mk7+i0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qWm5Rf/GJQJU9V5BbwSwwCKaHh+IoQa80t5txjZmdMhnz/+YGrM/ExcEJZMFD0Qi1ltDz7fCnbI06ndHBzfjE/W0vjhmhESTIcB7kxnZdglIWKyYmPqZQhq74kJUnfdCuh9J2Ek3QqV5n8eKnfx8Sp9F3KZyTFD0RpXoYkb+1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orxrWi6M; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orxrWi6M"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8eea23d01f7so717653585a.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778574232; x=1779179032; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpkHQlIzYolQBnKRs4+SRRU0vYvmpNYA1qiTnP+XX/A=;
        b=orxrWi6M7fm2t9f84e3HQzVDTvH4RRm46cHGMPgKKAMcTlpP6Q7xdle50HSahM5ply
         U6X8KqcgZfGIc3QupJgVlnC3915D8D2avklEUnEy+vYUY1VRIOytwGn7AHw8j+48pRDI
         vSW/ljeIqWpr4Icfd9NqMtZx6ftTrZEKYWZyVIDQ7ulwNjn9wd+Gzipx2YL1IJyp/zsB
         kMPEEOWCyB1h+SCjL50qrIu4o7hvmnQvhEt8YPnI0k2NUslR5UR4aPHMMP2UZhvOW8vU
         9lr5w3cMGGWvYV729dskaGS9RLhdPYQVed1Fvagr3NVkQBL9HsTKM2nm+/64exrDoRZn
         RxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574232; x=1779179032;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpkHQlIzYolQBnKRs4+SRRU0vYvmpNYA1qiTnP+XX/A=;
        b=i3AgK6H1E1gbXQzwZ9vnto+g+UszOADD3XnwvHlNIT0eu1THWy9ANu+0bIUhH9KwZB
         f0ysM8kR1/ElVuujFAdzqiJk2htg+jMsJ5H6tcIdfLK6w9IiVymT1pe9g5qqSKolibJB
         Ex0RZZg9Lc1tC0DzN+uyp3h8iywg6bSuSHWWije2W3etdCKuts89EDxo7R58pAqbR9Il
         6OFUH1oPqO5lnBOIYMillAx5Uymx32xOCBOpEVTNu5Ypy1HwNqL2FrSJGTuM22IfW5Cz
         rj9rw2Uaua0SMASDJIAo910S0vgRMloZwvRP+h3tbtlCBPNYE0zuGONCAK8s+kD8vL8J
         zFYw==
X-Gm-Message-State: AOJu0Yzj6bM77/49MdRKLni+CrPgqmT+BFe2jdEpW5Q4mxFkh9wevdzy
	CwJYF7M0gh9q9uSOHdfhFWVBXI1AJ6X4S+1oQrebx9nysWTazHPcyk8hutYZuA==
X-Gm-Gg: Acq92OGkJiNbSuRq9zmB8nq5cgXEcU7otvley4mdTZf4b7IWJpL0woW42aPFC4fOl4u
	vs2T5u8TK85ob61juxTSKrNMUbNwp2IJSY11yfp7yZrRPCjqMf5ukwzA9sdjttjbVCiAWMLGHk7
	TDNt+di5LsgzQSNPBsZgALGu7oTqojSJzDU6Rj/sUNpbYKpxmkyDzFcRswLfhit5ueqnepC+IGh
	AUQrdoy10zT7p7/qMb3brXc5Npn3HwPjLxlET1C6uFiRDbhQp8S97WSu0AX8gIOaP5zRGgmrdFG
	QSrng2ZhuWkMf0Jg2KtqA85kZ3iBCdCdqsKxKAp2xNAnS9GbpFVVRjpH3llXe8o9gXzhPBvZaZa
	ISXzW5eqz6yKq1o0ZTwjl51/VbRZBcV1o7K8c7BiI1ZScJVt0IBWE2t5ePnz36+CW4SWMhlFsPB
	oS+4u3xaFYJvLACU9uDVyZEQta
X-Received: by 2002:a05:620a:4089:b0:8ed:d906:a8da with SMTP id af79cd13be357-90cfb8a9591mr256943885a.18.1778574231486;
        Tue, 12 May 2026 01:23:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b87c02fbsm1403573585a.25.2026.05.12.01.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:23:50 -0700 (PDT)
Message-Id: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
References: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 08:23:44 +0000
Subject: [PATCH v7 0/5] branch: prune-merged
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

 * --prune-merged now checks if a branch is merged into its own upstream
   first. If the upstream is gone, it checks against the remote's default
   branch instead. If neither exists, the branch is refused (use --force to
   delete anyway).

Harald Nordgren (5):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  33 +++
 builtin/branch.c                 | 332 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 280 ++++++++++++++++++++++++++
 4 files changed, 635 insertions(+), 17 deletions(-)


base-commit: 29bd7ed5127255713c1ac2f43b7c6f257d7b4594
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v7
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v6:

 1:  fb9817b220 = 1:  22fa8515df branch: add --forked <remote>
 2:  42a2f93d44 = 2:  b443f0f367 branch: let delete_branches warn instead of error on bulk refusal
 3:  604ecb8965 ! 3:  a245009893 branch: add --prune-merged <remote>
     @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a confi
      +	been pruned upstream.
      ++
      +As a safety check, branches with commits not yet integrated into
     -+the remote's default branch are refused. With `--force` (or `-f`),
     -+delete them regardless. The currently checked-out branch in any
     -+worktree is always preserved.
     ++their upstream remote-tracking branch are refused; if the upstream
     ++itself is gone, the remote's default branch is consulted instead.
     ++With `--force` (or `-f`), delete refused branches regardless. The
     ++currently checked-out branch in any worktree is always preserved.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c
       #include "column.h"
       #include "utf8.h"
       #include "ref-filter.h"
     +@@ builtin/branch.c: static const char *branch_get_color(enum color_branch ix)
     + }
     + 
     + static int branch_merged(int kind, const char *name,
     +-			 struct commit *rev, struct commit *head_rev)
     ++			 struct commit *rev, struct commit *head_rev,
     ++			 int no_head_fallback)
     + {
     + 	/*
     + 	 * This checks whether the merge bases of branch and HEAD (or
     +@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
     + 					 &oid, NULL)) != NULL)
     + 			reference_rev = lookup_commit_reference(the_repository,
     + 								&oid);
     ++
     ++		if (!reference_rev && no_head_fallback && upstream &&
     ++		    starts_with(upstream, "refs/remotes/")) {
     ++			const char *remote_name = upstream + strlen("refs/remotes/");
     ++			const char *slash = strchr(remote_name, '/');
     ++			if (slash) {
     ++				struct strbuf head_ref = STRBUF_INIT;
     ++				strbuf_add(&head_ref, "refs/remotes/", strlen("refs/remotes/"));
     ++				strbuf_add(&head_ref, remote_name, slash - remote_name);
     ++				strbuf_addstr(&head_ref, "/HEAD");
     ++				if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     ++							    head_ref.buf,
     ++							    RESOLVE_REF_READING,
     ++							    &oid, NULL))
     ++					reference_rev = lookup_commit_reference(the_repository,
     ++										&oid);
     ++				strbuf_release(&head_ref);
     ++			}
     ++		}
     + 	}
     +-	if (!reference_rev)
     ++	if (!reference_rev) {
     ++		if (no_head_fallback) {
     ++			free(reference_name_to_free);
     ++			return 0;
     ++		}
     + 		reference_rev = head_rev;
     ++	}
     + 
     + 	merged = reference_rev ? repo_in_merge_bases(the_repository, rev,
     + 						     reference_rev) : 0;
     +@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
     + 	 * any of the following code, but during the transition period,
     + 	 * a gentle reminder is in order.
     + 	 */
     +-	if (head_rev != reference_rev) {
     ++	if (!no_head_fallback && head_rev != reference_rev) {
     + 		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
     + 		if (expect < 0)
     + 			exit(128);
      @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
       
       static int check_branch_commit(const char *branchname, const char *refname,
       			       const struct object_id *oid, struct commit *head_rev,
     -+			       struct commit *head_rev_override,
     -+			       int use_head_rev_override,
     ++			       int no_head_fallback,
       			       int kinds, int force, int warn_only,
       			       int *n_not_merged)
       {
     - 	struct commit *rev = lookup_commit_reference(the_repository, oid);
     -+	int merged;
     -+
     - 	if (!force && !rev) {
     +@@ builtin/branch.c: static int check_branch_commit(const char *branchname, const char *refname,
       		error(_("couldn't look up commit object for '%s'"), refname);
       		return -1;
       	}
      -	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     -+	if (use_head_rev_override) {
     -+		if (!head_rev_override)
     -+			return 0;
     -+		merged = repo_in_merge_bases(the_repository, rev,
     -+					     head_rev_override);
     -+		if (merged < 0)
     -+			exit(128);
     -+	} else {
     -+		merged = branch_merged(kinds, branchname, rev, head_rev);
     -+	}
     -+	if (!force && !merged) {
     ++	if (!force && !branch_merged(kinds, branchname, rev, head_rev,
     ++				     no_head_fallback)) {
       		if (warn_only) {
       			warning(_("the branch '%s' is not fully merged"),
       				branchname);
     @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       
      -static int delete_branches(int argc, const char **argv, int force, int kinds,
      +static int delete_branches(int argc, const char **argv,
     -+			   struct commit **head_rev_overrides,
     ++			   int no_head_fallback,
      +			   int force, int kinds,
       			   int quiet, int warn_only, int *n_not_merged)
       {
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      -		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
      -					force, warn_only, n_not_merged)) {
      +		    check_branch_commit(bname.buf, name, &oid, head_rev,
     -+					head_rev_overrides ? head_rev_overrides[i] : NULL,
     -+					!!head_rev_overrides,
     ++					no_head_fallback,
      +					kinds, force, warn_only, n_not_merged)) {
       			if (!warn_only)
       				ret = 1;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
       	return 0;
       }
       
     -+static struct commit *resolve_remote_head(const char *remote_name)
     -+{
     -+	struct ref_store *refs = get_main_ref_store(the_repository);
     -+	struct strbuf head_ref = STRBUF_INIT;
     -+	struct object_id oid;
     -+	struct commit *commit = NULL;
     -+
     -+	strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remote_name);
     -+	if (refs_resolve_ref_unsafe(refs, head_ref.buf, RESOLVE_REF_READING,
     -+				    &oid, NULL))
     -+		commit = lookup_commit_reference(the_repository, &oid);
     -+	strbuf_release(&head_ref);
     -+	return commit;
     -+}
     -+
      +static int prune_merged_branches(int argc, const char **argv, int force,
      +				 int quiet)
      +{
      +	struct string_list candidates = STRING_LIST_INIT_DUP;
      +	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
      +	struct strvec deletable = STRVEC_INIT;
     -+	struct commit **head_rev_overrides = NULL;
     -+	size_t alloc = 0;
      +	struct string_list_item *item;
      +	int n_not_merged = 0;
      +	int ret = 0;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +		struct branch *branch;
      +		const char *push_ref;
      +		const char *upstream;
     -+		const char *remote_name;
     -+		const char *slash;
      +
      +		strbuf_addf(&full, "refs/heads/%s", short_name);
      +		if (branch_checked_out(full.buf)) {
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +		if (string_list_has_string(&protected_default_refs, push_ref))
      +			continue;
      +
     -+		ALLOC_GROW(head_rev_overrides, deletable.nr + 1, alloc);
     -+		remote_name = push_ref + strlen("refs/remotes/");
     -+		slash = strchr(remote_name, '/');
     -+		if (slash) {
     -+			char *name = xstrndup(remote_name, slash - remote_name);
     -+			head_rev_overrides[deletable.nr] = resolve_remote_head(name);
     -+			free(name);
     -+		} else {
     -+			head_rev_overrides[deletable.nr] = NULL;
     -+		}
      +		strvec_push(&deletable, short_name);
      +	}
      +
      +	if (deletable.nr)
      +		ret = delete_branches(deletable.nr, deletable.v,
     -+				      head_rev_overrides, force,
     ++				      1, force,
      +				      FILTER_REFS_BRANCHES, quiet,
      +				      1, &n_not_merged);
      +
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +			n_not_merged);
      +
      +	strvec_clear(&deletable);
     -+	free(head_rev_overrides);
      +	string_list_clear(&candidates, 0);
      +	string_list_clear(&protected_default_refs, 0);
      +	return ret;
     @@ builtin/branch.c: int cmd_branch(int argc,
       		if (!argc)
       			die(_("branch name required"));
      -		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     -+		ret = delete_branches(argc, argv, NULL, delete > 1, filter.kind,
     ++		ret = delete_branches(argc, argv, 0, delete > 1, filter.kind,
       				      quiet, 0, NULL);
       		goto out;
       	} else if (forked) {
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	test_must_fail git -C pm-force rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success '--prune-merged measures merged-ness against <remote>/HEAD, not local HEAD' '
     -+	test_when_finished "rm -rf pm-head-indep" &&
     -+	git clone pm-upstream pm-head-indep &&
     -+	git -C pm-head-indep branch one --track origin/one &&
     -+	git -C pm-head-indep update-ref -d refs/remotes/origin/one &&
     ++test_expect_success '--prune-merged falls back to remote default branch when upstream is gone' '
     ++	test_when_finished "rm -rf pm-fallback" &&
     ++	git clone pm-upstream pm-fallback &&
     ++	git -C pm-fallback branch one --track origin/one &&
     ++	git -C pm-fallback update-ref -d refs/remotes/origin/one &&
      +	# Detach HEAD to an unrelated commit so the candidate is not
     -+	# reachable from local HEAD; it is still reachable from
     -+	# refs/remotes/origin/HEAD, which is what should matter.
     -+	git -C pm-head-indep commit --allow-empty -m unrelated &&
     -+	git -C pm-head-indep checkout --detach &&
     -+	git -C pm-head-indep reset --hard HEAD^ &&
     ++	# reachable from local HEAD. The upstream origin/one is now
     ++	# gone; the merged-ness check should fall back to
     ++	# refs/remotes/origin/HEAD, against which "one" is reachable.
     ++	git -C pm-fallback commit --allow-empty -m unrelated &&
     ++	git -C pm-fallback checkout --detach &&
     ++	git -C pm-fallback reset --hard HEAD^ &&
      +
     -+	git -C pm-head-indep branch --prune-merged origin &&
     ++	git -C pm-fallback branch --prune-merged origin &&
      +
     -+	test_must_fail git -C pm-head-indep rev-parse --verify refs/heads/one
     ++	test_must_fail git -C pm-fallback rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success '--prune-merged skips merged-ness check when <remote>/HEAD is unset' '
     -+	test_when_finished "rm -rf pm-no-head" &&
     -+	git clone pm-upstream pm-no-head &&
     -+	git -C pm-no-head checkout -b one --track origin/one &&
     -+	test_commit -C pm-no-head unpushed &&
     -+	git -C pm-no-head checkout - &&
     ++test_expect_success '--prune-merged refuses when upstream and remote default are both gone' '
     ++	test_when_finished "rm -rf pm-both-gone" &&
     ++	git clone pm-upstream pm-both-gone &&
     ++	git -C pm-both-gone checkout -b one --track origin/one &&
     ++	test_commit -C pm-both-gone unpushed &&
     ++	git -C pm-both-gone checkout - &&
      +
     -+	git -C pm-no-head update-ref -d refs/remotes/origin/HEAD &&
     -+	git -C pm-no-head update-ref -d refs/remotes/origin/one &&
     -+	git -C pm-no-head branch --prune-merged origin &&
     ++	git -C pm-both-gone update-ref -d refs/remotes/origin/HEAD &&
     ++	git -C pm-both-gone update-ref -d refs/remotes/origin/one &&
     ++	git -C pm-both-gone branch --prune-merged origin 2>err &&
     ++	test_grep "not fully merged" err &&
      +
     -+	test_must_fail git -C pm-no-head rev-parse --verify refs/heads/one
     ++	git -C pm-both-gone rev-parse --verify refs/heads/one
      +'
      +
      +test_expect_success '--prune-merged never deletes the checked-out branch' '
 4:  717fc6758e ! 4:  2c3f751569 branch: add branch.<name>.pruneMerged opt-out
     @@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a confi
      +	that name has since been pruned upstream.
       +
       As a safety check, branches with commits not yet integrated into
     - the remote's default branch are refused. With `--force` (or `-f`),
     - delete them regardless. The currently checked-out branch in any
     --worktree is always preserved.
     -+worktree is always preserved, as is any branch with
     -+`branch.<name>.pruneMerged` set to `false`.
     + their upstream remote-tracking branch are refused; if the upstream
     + itself is gone, the remote's default branch is consulted instead.
     + With `--force` (or `-f`), delete refused branches regardless. The
     +-currently checked-out branch in any worktree is always preserved.
     ++currently checked-out branch in any worktree is always preserved,
     ++as is any branch with `branch.<name>.pruneMerged` set to `false`.
       
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       		struct branch *branch;
       		const char *push_ref;
       		const char *upstream;
     - 		const char *remote_name;
     - 		const char *slash;
      +		int opt_out = 0;
       
       		strbuf_addf(&full, "refs/heads/%s", short_name);
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      +		}
      +		strbuf_release(&key);
       
     - 		ALLOC_GROW(head_rev_overrides, deletable.nr + 1, alloc);
     - 		remote_name = push_ref + strlen("refs/remotes/");
     + 		strvec_push(&deletable, short_name);
     + 	}
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success '--prune-merged spares branches whose push ref is the defaul
 5:  be25572957 ! 5:  f79707ce7c branch: add --all-remotes flag
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: delete them regardless. The currently checked-out branch in any
     - worktree is always preserved, as is any branch with
     - `branch.<name>.pruneMerged` set to `false`.
     +@@ Documentation/git-branch.adoc: With `--force` (or `-f`), delete refused branches regardless. The
     + currently checked-out branch in any worktree is always preserved,
     + as is any branch with `branch.<name>.pruneMerged` set to `false`.
       
      +`--all-remotes`::
      +	With `--forked` or `--prune-merged`, act on every
     @@ builtin/branch.c: static void collect_forked_set(int argc, const char **argv,
       	for_each_string_list_item(item, &out)
       		puts(item->string);
       
     -@@ builtin/branch.c: static struct commit *resolve_remote_head(const char *remote_name)
     - 	return commit;
     +@@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
     + 	return 0;
       }
       
      -static int prune_merged_branches(int argc, const char **argv, int force,

-- 
gitgitgadget
