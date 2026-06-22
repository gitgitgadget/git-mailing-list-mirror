Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0036923B
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113405; cv=none; b=sBhxQvng6ZNMIGFa+VXX451rUXv+gsHNfl1Gd9Ox/Yhzc0XZAPngBsyyZbUvoQtJWkH7sKikAFby6AMdRU6ViUCht4Bpy2eIoN+GpqexBLbBteb5d2Az1ie4o+oLQ9eaNMnMxVfLw4mVdtxFN1M7LvfpntTfjdhdzl4wHNgDFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113405; c=relaxed/simple;
	bh=vPVZnfrUG4vmWBcFHHnLKn7+ABIKZF0Ql3jTU1paqQI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U6HOL2OwiMA3bywtRVvf2WBUZ5/H+ilti5QyQOXsxYyQQOOgmJusULLE37NMMro2t2uTThJ07wPZf3B3EVgWl3TF9fc23NCAHGbESdX/dz2X+Iy0di4GqE29eToVkX+NCPyjW1WjY4HNWQD7y7JzJgvSLUC1iU7ataOClb43vmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJWsDeOR; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJWsDeOR"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c23abc62eso1671390eec.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113403; x=1782718203; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/zajrlRSNwRqOTY739+LDwJwygutA5UoyY3qO9bcVc=;
        b=KJWsDeORAnW+lAwW4cBQ1Q3TNGUNGjCpHXaHhMuo53jbAebo6XPcL3aYsX70wjiCh8
         u5nFb2Uzu99WZl6hV94ZYfFlqZtgFaLYu/jPtAj/x6+sPyKr3pB0as/uy3jrWdgqKDtD
         S2egD0+tiamar7wv1doUvnnMG9BvRJSaZy7Gl/dZicY9bwkO2hKqmvF3OuRpFX3RldTO
         kYAuqmcXUQDaQx06e88eBCxQH/cadN7NKhLMoTZz3OC6DISLzZC7SwKxtMtjMlIPNuCC
         0WprVEVKdkx/ZwPwZqqqDjbY3SbOyi/Y3nTE6bQXSobqO0k4BqXTGm74tKpKsvtK2Krs
         3adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113403; x=1782718203;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/zajrlRSNwRqOTY739+LDwJwygutA5UoyY3qO9bcVc=;
        b=FJpdpuI+ZbjMZRY87JRaX/ZpjCEhoW4QDJ7iz605iXFiWOrqGJDHZStmCcnDOuNVuO
         uVpiiFgVj1xZf1Qeu/SnUkpSlCpXSLHKG6LzE0O68xvpoTAziVz3BbH6bw9pyfPzZT1I
         jW2+U0RDaAltbY48+mXObKVCqKagrbVxhQn0rUomk1scHNO/UMABBk7LDLSTJkxhwKxe
         YTRavZnyerJdhkv11749/FVKPAlK8GBL8zQ+vLJqmbq2le6ogVgciZvmVYQJMSqiUedw
         5hIzlsBUvjP0hnL4suu+YmR1gsPJYzHqoQTF5+v9cjyuVQH9y3x1x1ThxfEfbiex7XGV
         qSAw==
X-Gm-Message-State: AOJu0Yx4zeCAhtIGcEGWA2CRQjQYib4wC9hYuxOxAN799RJ1e1EwNIn1
	w9msT+vmmbxsM7xPhiCQRF/lr6fgGv1K538iGDPwYxr95v7A5w/ImXqiV7iuMw==
X-Gm-Gg: AfdE7cnIQeoKfqR6HfELXzL21Ciljiw561pb1zNCKRE2sVhG8Wb9zGsQu/kreubdKyU
	rgaX/ydvf7P3yxI0hUwz/Ey25sklX6Y2XSajchZP2Os0e0TvOqvC0GdtKWyf3M12pvT/wLxF4aN
	kiLWTbrH1Y9feDaNyEoQmrEn0fJkD0a30e+K90DxByMDmrjpcv9/EHG3Em2kNaqP4+D2gaIFKOm
	ExaPZYUWfz9+w/NGqESVrLgIJmkroprNMhmMtlUkWxWsSHK2dX8Yz576LiOEBDQGfDeon4oWPiK
	hMY5FH8x1PUpMhoXAveCwFSU4u/rvL86g4byntXGbFKcjiexoUWLdV3qAAPvN18ByYIy5fM+6Fk
	ZUfMWlHwWSqDazZYgbqVtwfnlNyDRhrTkkOCx8mYlrlrNjGDIDPCwMtZiehpLRGmYo7b8lPmamo
	KKYGGpnsqiWXO5eNWmt8NDsVtjYn4c
X-Received: by 2002:a05:7300:641a:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-30c06d7b0cbmr9404004eec.0.1782113402676;
        Mon, 22 Jun 2026 00:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1b4f7d81sm9247932eec.0.2026.06.22.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:30:01 -0700 (PDT)
Message-Id: <49c1bcf1fb5a2f2bb45444658a5eb5c03ae509e3.1782113388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
	<pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:48 +0000
Subject: [PATCH v17 7/7] branch: add --dry-run for --delete-merged
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

With --dry-run, --delete-merged prints the local branches it would
delete, one "Would delete branch <name>" line each, and exits
without touching any ref. The same filtering applies, so the output
is exactly the set that the real run would delete.

--dry-run is only meaningful together with --delete-merged and is
rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 +++++++-
 builtin/branch.c              | 22 +++++++++++++++++++---
 t/t3200-branch.sh             | 11 ++++++++++-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 59ea3f471a..e9f43ffa9e 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --delete-merged <branch>...
+git branch [--dry-run] --delete-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -230,6 +230,12 @@ A branch that another, surviving branch still tracks as its upstream
 is kept, so a branch is never deleted out from under one stacked on
 top of it.
 
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
index 5ea610efa1..5e326e6c30 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -199,6 +199,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -248,6 +249,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	bool quiet = flags & DELETE_BRANCH_QUIET;
 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
 	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
+	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -346,13 +348,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!dry_run &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (dry_run) {
+			if (!quiet)
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
@@ -878,6 +887,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int delete_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -933,6 +943,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "delete-merged", &delete_merged,
 			N_("delete local branches whose upstream matches <branch> and are merged")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -995,6 +1007,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1035,7 +1050,8 @@ int cmd_branch(int argc,
 		goto out;
 	} else if (delete_merged) {
 		ret = delete_merged_branches(argc, argv,
-					     quiet ? DELETE_BRANCH_QUIET : 0);
+					     (quiet ? DELETE_BRANCH_QUIET : 0) |
+					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b80d558b4a..211e13481c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1892,8 +1892,12 @@ test_expect_success '--delete-merged deletes merged branches and spares the rest
 	) &&
 	sha=$(git -C repo rev-parse --short merged) &&
 
-	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
+	git -C repo branch --dry-run --delete-merged origin/next >actual 2>&1 &&
+	echo "Would delete branch merged (was $sha)." >expect &&
+	test_cmp expect actual &&
+	git -C repo rev-parse --verify refs/heads/merged &&
 
+	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
 	echo "Deleted branch merged (was $sha)." >expect &&
 	test_cmp expect actual &&
 	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
@@ -2016,4 +2020,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	test_must_fail git -C repo rev-parse --verify refs/heads/kept
 '
 
+test_expect_success '--dry-run without --delete-merged is rejected' '
+	test_must_fail git -C forked branch --dry-run 2>err &&
+	test_grep "requires --delete-merged" err
+'
+
 test_done
-- 
gitgitgadget
