Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFC2E0902
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338123; cv=none; b=hw2t87x2cY0n0rFLtJzqwpb0mXWSZxFoozymbPSOS6NIkjmiFGPkbs8VHNA0rw7EA+3psfpraO6RFh5MpNVXuOn7LEeVbPfvdUqP/F1HKqS25/Fq+J16NYLyqdjJWALgjosbGkPqMctssfWkRE+Imt+J8L1tHBeCvtQWFoYT5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338123; c=relaxed/simple;
	bh=cDl4dqo3BX859WtOE/pQiGoZbJUf+QBumWsGQFnR02A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S+X/djz7WiZr5/bCAPwojl68eskHNxwcmMV4lqKhPORaelcI1vkHweNtImgpO9U0hwx4lOAnxBgwlGOYkznSdzehe8CQgWAnecTTmuodn+icQvoM/bJEsjkQM/OEA4dDjk7qYe7tI/zndwyBa+mlGiWdQHrDcSfUs2wl1WqGhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myrWeE1l; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myrWeE1l"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so3245558eec.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338121; x=1782942921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K148r5Y5uY71TgMe3WtT9kpRRiwruZGMSfEWm1WBCNs=;
        b=myrWeE1lKMsf9WOzMyaPiZMPl2VW7EQv/uo0voCV6oeQhyEP3bx/7DA4ctgmToyd/c
         vEqHIbke+mcEPZtSDWb1w9ojzNscJWqVo11r9hFZld2AzjauPYpVoX9TXczL8LEnzJC7
         98+svUyNeewiSNAqJ4J2p91CVQpgyEbz1gfA2U+1Smmi3B2EIpJ/VEx8YhAI7Xhs87u7
         DFUw9gGDWTxZHnUmE41NUve8nZctUwPnfJLu+dmijNLWB8r5xQ+SyWKgOeyEsbpwcZHJ
         piJjr3RDZSD/PEeWGC94XDSCekj4bmiCQSiWP16wcovIowSx8APQs5EvFQJlvAQMKEBA
         L3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338121; x=1782942921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K148r5Y5uY71TgMe3WtT9kpRRiwruZGMSfEWm1WBCNs=;
        b=Xo4W55mhdvk2vy1GR1rmNxrJ6eFsqgScstsQllNw2GSMD5p/m/pFZBZsphMhIkWRz0
         x4vWObliuv6+am9WsEWmjCiLsoc27r7VAgG61k/eV1R12EZazLVJAwvNIXdClkVCzKaP
         xEeUHqaWt/YTVcxwh1Mj3P1q9tJQ2ePUFVoKuluCVTGpdK0eex+1NVOIdqyuSvlMOFrn
         duysQaZ90g/IRcewzfGWL+bfhw9yIyjMqZ+cd9T+OT4vHo2NVKpLBVRPa30Ghrsfj0CS
         2zC3Nuf1kgWOHBWBo3VRbLVgnXjvUZCsWnzQAwdTv9qTob97WK2iglcXnTMvrDRD6Z98
         txBg==
X-Gm-Message-State: AOJu0Yz9T3IIlFENMIbZpgq0nvuuox/cH2INmuHlhKmazGwSCLK6M8eL
	Md1mzA6FbGCyqKUFJPOs1jiN3suRy3EobSfG5RhEVklH2H+8UHSeYqzkdBP9Vhhj
X-Gm-Gg: AfdE7cm0HqgEq2GyC30L0GmjJ0Jjz9EkPueIOvQjX8vJfOTLpe140amtqz8WFtKG6/S
	+/sOnyRnWkA5NKL7iKb/ijpSO1ahZc4L43/F9/MFl8fuA99+OoUE5pfYW+gXuh6tqdZu+P0SYc1
	FrMh0CGA5pzwlVEorvGymKmiT7d3Nu1fOCEbzQEWHohLGFrSuiDFdDA6mCuKpHrcspY37zQydMn
	PGtFaKIxOkeq25lTnx3GtssKSwG9mYVUq12YXTnDBSuad0huELLNT93Aq4q6GjhFsdGyPd59tpi
	2wqBW2wu00P+2jrENzSCTyV+13GRHcC/+jIaiMkMvTMnUVb3hvQnFvPR8fAqcjoy1nuRyw4w52d
	BiwgTfzsmu3BZTSoAqxpW4FDxMxgdbhMX1ZjTOQssCKt9kf5ah2ozm9ADI1EczFABMu10iDoJIc
	sqr5LxS+19cBWXGq1g
X-Received: by 2002:a05:7300:1483:b0:30c:689b:c59d with SMTP id 5a478bee46e88-30c84b4f99bmr25960eec.5.1782338119976;
        Wed, 24 Jun 2026 14:55:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c58831asm1816680eec.13.2026.06.24.14.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:19 -0700 (PDT)
Message-Id: <8d0323f4b30cdfed134ff2840cc8a9ab32f9db53.1782338106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
	<pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:06 +0000
Subject: [PATCH v18 7/7] branch: add --dry-run for --delete-merged
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
index d482cded3d..00d6192e6a 100644
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
@@ -231,6 +231,12 @@ kept, so a branch is never deleted out from under one stacked on top
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
index bce85cb52e..e7763437fb 100644
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
@@ -897,6 +906,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int delete_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -952,6 +962,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "delete-merged", &delete_merged,
 			N_("delete local branches whose upstream matches <branch> and are merged")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1014,6 +1026,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1054,7 +1069,8 @@ int cmd_branch(int argc,
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
index b7595610d9..cddcde341d 100755
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
@@ -2050,4 +2054,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
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
