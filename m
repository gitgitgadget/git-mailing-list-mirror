Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB33890E8
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704252; cv=none; b=asSroHfsavs1rKJ5KSx+jz1A4sQX6v28HQZyRN5m12rRwtfmCGxYovorY80JV3EnyjScJcKh77mjsbeNf//6n/GzJF7aNYlsmDF2gQIPB51D8pufEwzzmi4sOMnAugNvOq4eH/H3JDCUlQym5OfMUw+frhhg8w44j+neS2bBtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704252; c=relaxed/simple;
	bh=hXajTagpNEhLAvQqfQf8YWqKoh7kdtNR5cA0cjvFqiM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GSKpTebFWBetMnXSxAxqh7G6O57iPIyk5sgx1TYauBTBmMBEiTKj6WiPozHFVIcVXXJ//G+ev5xtPnPPNOizKeU43djccU3xleFndlBQJXowCwRgWD2ETKS0IMx8oEPsHrKNmVkD9yRrMmptGsREM3E8+IEyb6m1OPypVJwtM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiC6t7Tt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiC6t7Tt"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0c68aa31so89023071cf.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704248; x=1785309048; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQe4TN8L4qkTXLaYFosFvyZB2fiGFM+BwZUAX6KnPJA=;
        b=GiC6t7Ttq8MQ6g8mYtFBfgzUJSA8aVeABula6cIYqhhbb56fFogf6i9B1zFKPHiRlt
         +L8yGMTz/MRIf+JNOy9P1m6U3aTFrlYys9iV6Ffv/J1Dg0BessCHP4deepYn/XpEUiSL
         mvU9rCpG91Daws58DJg7VEMRG/o7L+CePo+vOI/a6cBa2rP1xzG4zRalab2sO4Ajv/LO
         vUPUQdIPCaqsYNKtM6L8xsOMUFQJfJ2EG4DSogMIlNqmU4LDWZ1h5MqNHVr2tNbAxGwb
         BPFth6Qwtw0VN4w3x65zYNbt4S2trREAX01iDTKUbyAwTQRO/7g7HUe97DPQFISoiJWG
         LOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704248; x=1785309048;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQe4TN8L4qkTXLaYFosFvyZB2fiGFM+BwZUAX6KnPJA=;
        b=K7m2dZ+q4U/bUYz1hzaFv7bNOz+Mmhjwua1T9TAIcy+4IpeiAt88R6IT0ghMkxWtZq
         IIr5sVzUjpclwCK1nJVFupCpcD3ylAg3XCNwRJQG8w50Pwamw8okeZnQeZ9K+nxibi80
         h67bcGxvRpLG/3C/i1+7QyBcRdtnOKZVIR/lPxvMG0R+tyMmp3VBST4m7T27YkSL2Qut
         LfYj3+S+8pU+CYQwMcHBxNUH78nVfjs93r8vmveoOQw2xMvIyV6uwz5HKt2NHkqsSKi+
         V415WHzUTcZnsHAAgG6Dakh51ok1dVTb/3T+9tqPGo5R3mWkmr+Fct5iHnnZXjKcXtW5
         qErg==
X-Gm-Message-State: AOJu0YxiUTO/zAOru7cONM+6J01HtTNrbx14R5sziOFBy3BEunW23L1R
	AV7mr2xOx96BHcKDXMogO2ELhMDZslHywDX1XMwpQSZvHkM3Nz7s6HAzX5W2Cw==
X-Gm-Gg: AR+sD10QPnuSKUXHbOX2T427AzJdKI9hfX25JgRUIrWr48Ld0UHZyfJN7tJcIZ53nUY
	oXEat+BObZYTEbct0uKlF3K3nfwS/dXZoe4IqfDajM4VBkt0FVYZb8hLTt0T5tfLyQ52gwUK2Ts
	qYU+kL1WtsyV5RLOLamwL7TlpvSWn3iyNIWRFfEkOWTi2p9bav28nN8I5rOlDt9+w1yRWtTCE4X
	COIQI92cImVDm5IYvAmzCr+UzR0FT7Fh91khMt6Svu5Ji+k4fZaer38hUX6Ie+dV0i2iuqvr29g
	z0JwXRv9WaRA/QWliUAbH+qL4e8QA/TqRAxYRxEDAA5fzwNdF9d8rIyxbO26GmVpPXH67STu5Bi
	x/oPxts8SV1S15REoXBKRyd+fxjLww8n/wBPgrHmTAwYpxGT5rJjJtgfjT5duseCUh1Gk8pWW/R
	/TEiU5ZvnfRM8g8Q==
X-Received: by 2002:a05:622a:4d93:b0:51c:7b12:5ff8 with SMTP id d75a77b69052e-5213d7ab878mr211429841cf.84.1784704247687;
        Wed, 22 Jul 2026 00:10:47 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d06700b1sm10358021cf.2.2026.07.22.00.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:10:47 -0700 (PDT)
Message-Id: <13bac431a30f1302b2466b7a81ee95d86188f737.1784704238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 07:10:38 +0000
Subject: [PATCH v20 7/7] branch: add --dry-run for --delete-merged
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
 Documentation/git-branch.adoc |  8 +++++++-
 builtin/branch.c              | 21 ++++++++++++++++---
 t/t3200-branch.sh             | 38 ++++++++++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 2b206e8689..51dda15114 100644
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
@@ -232,6 +232,12 @@ A branch that a surviving branch depends on through a chain of local
 upstreams is kept, so a branch is never deleted out from under stacked
 work.
 
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
index 6573ad7027..237eadb401 100644
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
@@ -923,6 +931,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -979,6 +988,8 @@ int cmd_branch(int argc,
 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
 			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1041,6 +1052,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged.nr)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1081,7 +1095,8 @@ int cmd_branch(int argc,
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
index 7111306150..eb1c57a5ca 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1938,6 +1938,19 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
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
@@ -1986,9 +1999,12 @@ test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
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
@@ -2016,6 +2032,21 @@ test_expect_success '--delete-merged keeps the upstream chain of a surviving bra
 		git checkout -b tip mid --track &&
 		git commit --allow-empty -m "tip work" &&
 
+		git branch --dry-run --delete-merged origin/next \
+			--delete-merged lower >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
+		cat >expect <<-\EOF &&
+		branch.lower.remote origin
+		branch.lower.merge refs/heads/next
+		branch.mid.remote .
+		branch.mid.merge refs/heads/lower
+		branch.tip.remote .
+		branch.tip.merge refs/heads/mid
+		EOF
+		test_cmp expect actual &&
+
 		git branch --delete-merged origin/next \
 			--delete-merged lower >actual 2>&1 &&
 		test_must_be_empty actual &&
@@ -2112,4 +2143,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
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
