Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0C44BCAC
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053513; cv=none; b=G7zFkfYuPJLagVUtZuj1zmvv69PTfeAqg2vKn5MmdNELBi5UIXxW+4K+i8HSF56QoQ9TpFVtbWaRolu1ClAaj79tWAC8uVPYbcZ6cD2lo4OLiLH65l8GPVjwVAvQ+dzYxyxBKPLZ0YXFuGOSTNlRQlogswR2r8Kw8m7/g4035+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053513; c=relaxed/simple;
	bh=3FHNcHenFVQSPWfegHQ+rUI646XBpdWg44dB5s6ZkyM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EGpwA32cBHyxkvczVmyd5Otys5wZ+e2bECtaTItLAIhnowR2GM9R4FPDT7/Cov1TspRqFfp2yDJfAc7BOwRrHsjiec0HGCyQvAMhv7CuE2l6ocMvrCf+3v6LBdr4+dCZNR3Cve2FKBcG6r9fRHaWRUd2KuW2wVqFGRNo29CYRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPJ0FCpp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPJ0FCpp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceab75934dso39480085ad.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053507; x=1784658307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qCzER9GGKsOkYceE1CJ61Br4n71x9e5T1QXB/CeS8Sc=;
        b=OPJ0FCppX0D6mZSb3zALuQCaLv2zODPWJR/HksxzfQ+QBDyI8FfKiCXdOUm2WAmjWG
         cKX8Nd/4l/pB+QxX+2fBTHDrJCwFLLGCrCDiCPzxuykmbxWCjMz+coS+z3UU30hNRYVT
         MwRwOZUVJjFzT9fGiR57HuLLWlVgClW+Jo6/+COoiubw+kgZJpa4nH0YGwXFdnBUJ7eB
         mp8GhLgMJ8299V+Lxp3o0aRsl6BJScuTimue3arB0nSqt7uMa/Aq0hybHEDTx+I0AK1c
         vg9eVAgV3TKgzNfe3nM4ge+0XgZVsOeNDh/1gfg9wlYss0TZbixrHCNotUNHkwZ9T0Yh
         qkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053507; x=1784658307;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCzER9GGKsOkYceE1CJ61Br4n71x9e5T1QXB/CeS8Sc=;
        b=ctJoUvqkqz42RSat8aqizskyHy2r0JdFs67YuFiD05Cvq8S7KE5AOqKe3qdQgk5tTz
         wQVHJuwoBFwO4q3IMms/W67vi0mZFCX8RPYKJ0x6b3dC/bVY0X6tUKB6PTYDe1W7kRWM
         wd/rX+8jzz9j71WJrFYAITOFb5z/TPpu1NxRE9Vg9CgCCWzP3HyI0JRW+HwskF2TUsmO
         wOm2WrYhBFMuj/bI63cT486Xz9RBkZpjQHhyKrC7s2iWiOfZIIDidKYyCy99BZ82rAxj
         gJEdFmftxbbcrVDfa60qQsrhEu/YN3xyxta4UnpH93jvu1Anc6P5XLFiihOe9hsXmwaa
         f2mg==
X-Gm-Message-State: AOJu0YyLB/E9p3R3FVStMTX0ucYdrAvpARzb/RjfrJ3ismAX7NDFupm/
	KG2xXHrXPntVC/aaHVxI0aR/ouG4d4Epu7lvhw5L0aSVxRhjgJO/jFIzvCRKOg==
X-Gm-Gg: AfdE7ckK9UpWT5gsKeZmDQe7D9B/7hvCkQ0Vhd7N7FfAH/kSU0T8wcAYprjIe/232ay
	iDgx4ditqszdbrbG2dk1p0dzRKg2ksfqiym6Ude+WVLMC+kpk1JUPrJhltnc/vnMsJYwsLo/nV2
	JbIv8BbqeYdXdz6BdnUyAUU8owgJHTlAf3Wo8Gf80J/NmObXC2g0FsH9GuF98iq7lWjRoXgkknl
	cDNusDELFOVivD/ctgGVgOMEfg9B5mJ/0orofac1r9OOOGkVe4fJHYvRu7aO3WcNjRBiR/UZTF0
	fKVtTHc5yl5aG+kZqGxw8mp9xtxDXoZ8VkP8G3EHhoqVuRh+bgwyvDJ4OCYEWEmha1De2wRcWMu
	mTgonlE24wdg3m3qhrpcQHp7lQcrS3BGttyiyGpP0CetdbuSX6idudXLo099l/PxqS1Vid5YxEe
	f7fe1oh6spRXj1pOpI
X-Received: by 2002:a05:6a21:6e86:b0:3b4:9168:d9e6 with SMTP id adf61e73a8af0-3c1108993b5mr15185127637.37.1784053506888;
        Tue, 14 Jul 2026 11:25:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f81f17eesm7176275eec.31.2026.07.14.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:25:06 -0700 (PDT)
Message-Id: <7aa9d5db144f6e9d9246f1609c67336398e629d7.1784053493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:24:53 +0000
Subject: [PATCH v19 7/7] branch: add --dry-run for --delete-merged
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git branch --dry-run --delete-merged ..." prints one line per ref that
would be deleted without modifying refs or branch configuration.

--dry-run is only meaningful together with --delete-merged and is
rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 +++++-
 builtin/branch.c              | 54 +++++++++++++++++++++++------------
 t/t3200-branch.sh             | 35 ++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index ffb39811ab..633031f248 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch (--delete-merged <branch>)... [<pattern>...]
+git branch [--dry-run] (--delete-merged <branch>)... [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -233,6 +233,12 @@ kept, so a branch is never deleted out from under one stacked on top
 of it. If that kept branch in turn tracks a branch that is being
 deleted, its now-stale upstream configuration is cleared.
 
+`--dry-run`::
+	With `--delete-merged`, print which branches would be
+	deleted and exit without touching any ref.  Useful for
+	sanity-checking a wide pattern like `'origin/*'` before
+	committing to the deletion.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 61f414b3c7..117af854a0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -199,6 +199,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -340,13 +341,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (flags & DELETE_BRANCH_DRY_RUN) {
+			if (!(flags & DELETE_BRANCH_QUIET))
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!(flags & DELETE_BRANCH_QUIET))
 				printf(remote_branch
@@ -736,7 +744,8 @@ static int spare_stacked_base(const struct reference *ref, void *cb_data)
  * base is itself merged, so when its own upstream is also going away
  * (no surviving branch tracks it), clear the base's now-stale upstream.
  */
-static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
+static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable,
+				unsigned int flags)
 {
 	struct strset spared = STRSET_INIT;
 	struct spare_data data = { .deletable = deletable, .spared = &spared };
@@ -746,21 +755,23 @@ static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable
 
 	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
 
-	strset_for_each_entry(&spared, &iter, entry) {
-		struct branch *branch = branch_get(entry->key);
-		const char *upstream = branch_get_upstream(branch, NULL);
-		const char *up_short;
+	if (!(flags & DELETE_BRANCH_DRY_RUN)) {
+		strset_for_each_entry(&spared, &iter, entry) {
+			struct branch *branch = branch_get(entry->key);
+			const char *upstream = branch_get_upstream(branch, NULL);
+			const char *up_short;
 
-		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
-		    !strset_contains(deletable, up_short))
-			continue;
+			if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
+			    !strset_contains(deletable, up_short))
+				continue;
 
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.merge", branch->name);
-		repo_config_set_gently(the_repository, key.buf, NULL);
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.remote", branch->name);
-		repo_config_set_gently(the_repository, key.buf, NULL);
+			strbuf_reset(&key);
+			strbuf_addf(&key, "branch.%s.merge", branch->name);
+			repo_config_set_gently(the_repository, key.buf, NULL);
+			strbuf_reset(&key);
+			strbuf_addf(&key, "branch.%s.remote", branch->name);
+			repo_config_set_gently(the_repository, key.buf, NULL);
+		}
 	}
 
 	strbuf_release(&key);
@@ -843,7 +854,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		strset_add(&deletable, short_name);
 	}
 
-	spare_stacked_bases(refs, &deletable);
+	spare_stacked_bases(refs, &deletable, flags);
 
 	strset_for_each_entry(&deletable, &iter, entry)
 		strvec_push(&to_delete, entry->key);
@@ -905,6 +916,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -961,6 +973,8 @@ int cmd_branch(int argc,
 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
 			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1023,6 +1037,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged.nr)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1063,7 +1080,8 @@ int cmd_branch(int argc,
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
-					     quiet ? DELETE_BRANCH_QUIET : 0);
+					     (quiet ? DELETE_BRANCH_QUIET : 0) |
+					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 54292bfbdf..c055bc8287 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1900,6 +1900,19 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
 		git checkout -b tracks-other other/main --track &&
 		sha=$(git rev-parse --short merged) &&
 
+		git branch --dry-run --delete-merged origin/next merged >actual 2>&1 &&
+		echo "Would delete branch merged (was $sha)." >expect &&
+		test_cmp expect actual &&
+		git rev-parse --verify refs/heads/merged &&
+
+		check_branches <<-\EOF &&
+		also-merged
+		main
+		merged
+		tracks-other
+		unmerged
+		EOF
+
 		git branch --delete-merged origin/next merged >actual 2>&1 &&
 		echo "Deleted branch merged (was $sha)." >expect &&
 		test_cmp expect actual &&
@@ -1948,9 +1961,12 @@ test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
 		git checkout -b topic feature --track &&
 		git commit --allow-empty -m "topic work" &&
 
-		git branch --delete-merged origin/next 2>err &&
+		git branch --dry-run --delete-merged origin/next >out &&
+		test_grep ! "feature" out &&
 
+		git branch --delete-merged origin/next 2>err &&
 		test_must_be_empty err &&
+
 		check_branches <<-\EOF &&
 		feature
 		main
@@ -1978,6 +1994,18 @@ test_expect_success '--delete-merged clears the deleted upstream of a spared bra
 		git checkout -b tip mid --track &&
 		git commit --allow-empty -m "tip work" &&
 
+		git branch --dry-run --delete-merged origin/next \
+			--delete-merged lower &&
+
+		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
+		cat >expect <<-\EOF &&
+		branch.mid.remote .
+		branch.mid.merge refs/heads/lower
+		branch.tip.remote .
+		branch.tip.merge refs/heads/mid
+		EOF
+		test_cmp expect actual &&
+
 		git branch --delete-merged origin/next \
 			--delete-merged lower &&
 
@@ -2036,4 +2064,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	)
 '
 
+test_expect_success '--dry-run without --delete-merged is rejected' '
+	test_must_fail git -C forked branch --dry-run 2>err &&
+	test_grep "requires --delete-merged" err
+'
+
 test_done
-- 
gitgitgadget
