Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603D429014
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889392; cv=none; b=pIP6Y6xrh9dwDj/57FyiVfmoARN5WmiaFDQmZSJoWrCgLySzswBE7oIjO+9dyTqvNI5oFy/WL0I6v2G3IOAcm1UW6jSHi2mzTkLxJuFFY6ool5DJWXqzDXkEwVIncXW047YwmsUitoA6vbuv8Zk5N+NzMa5FaSPOZ7f2LrVyzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889392; c=relaxed/simple;
	bh=PiEorzH6EdlWRy4ed5WHuoXjuEIc/x7e+WK1gmDKfYc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UTq9VecSlLYnyoLUwh7UsGcJL5AOw8NRlWpgnUFvVrQRlow6C6PTMAlxsPG+nK89d/4O7BIeg14SULTehlytg/D87EdH7cQszZn+0DgdWxbG1GFIA65rNNF8vAUsfyrE00hEmkJFVZLP74PF2WhgiM4qcg6O54C68ZsT9U+fydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+Q2kbPs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+Q2kbPs"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cee9b74ee1so2194705ad.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889390; x=1785494190; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dLN8nP/jAQIE4AYHU/F6XUPbMk4RLT1aks5xaiKC5qk=;
        b=b+Q2kbPsYnmGnYkVs/gm0kR0LG8bKa/sOY+zZ35YzUW9eR53kBurm+YhRsyYwzh1z9
         1uMtXOhsVlnlFZPsIkq5r5mOawy8ZAmRU+USSc3dmtH4Hbk8uNZnLWik21a7YwcJBzcC
         Ry6yB26YQsUG0qJuXcn0UizOj7rH4lLPPEK8zQO1KgTBaLAfauzMCAHlFcSvmDQBmLqD
         2XI+sjClke2iC/fi3JTfE65J3mhzqOp2msfoKdKCTwtcL+oRyLGf4CDqjKvhsaQlH2Bv
         GTYNe7YrkdN2/14cfEzKjbgZ0iV9V7dzwxPgXJNHbuT75jpSb9As2Ca7o7cCmuPnVIU+
         bL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889390; x=1785494190;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLN8nP/jAQIE4AYHU/F6XUPbMk4RLT1aks5xaiKC5qk=;
        b=i4MleFna75kK5euLlXFzqUgW72IUCn2F9ENxtkqw63kx915eq1WigsD3Z3cyPMBP2i
         +pEUFh04OVFmH4ueultowuRz0oKhP7QFzkmWUe9fkvgWiincGDM82sxn+XF8e+GhzrHo
         X6ooc8sajIoZIdi1QkN0tNRvx1//br6jQF1SDqrivsb6sMqKDO0xj8no+NQmAzKgMY37
         wwZdLkkV5OUBbCd+vbvEGzb+fnGxg0Y51w6WemS/Lh2RBCbQX10jqBoMVjUXQuxTRmma
         DRjCUXfhqj+M7V6TD+4BrJETq4o1ZBQyOCZTDq8daLvSt4GBHPjKKtRjyHiYHLzakCE+
         Vy+Q==
X-Gm-Message-State: AOJu0Yx/+St5Z+cFaRCvaHNT39jC1TS8UMHqB28B/SjauXgwn4GL9cac
	kb9yzh/wLScUDP8iGhLpY9H7bpfAncwtZHkIuNjAELpVEmOXCXVVoCJ3j1mOXw==
X-Gm-Gg: AR+sD10//Et/88Z5yarUCFrqhzllQY9ju/z2rFXF8Oh8otYkmbbKKSFUiy3UBx3C6sg
	wztNM26ZcPIqSNd9TRPdq7m2rf1P/Qdb8c8xm8q/F9784B/SmYEk3snxWQOAgG65p86dawm1TAL
	H3BeRJNgqsJuk5CjBezvaEwyZ6t1LV065ZN5fKMxaPtWsgrYnybK8rMZAbMmIxOZVRXv9HA9PJl
	KZoXfA0PWYsvcTQSIM0oBzvkJScsVO9cgjzGwjdzMZ3kDwCPGTFjjxkVZ3yXe4pdGuoiZ08wpbO
	dmfukHD8Jbbosq3CcOnBcbb7GksQytzaYIptrZ7AwsHh19j5r0eTrgHbmGw9wRZ0hHq1Xp2Imc0
	CxU9AuWS+rsCExiUgYInuYxx3LLF9LrTRRmVMtmFaoCdRRbMjiZn9hIIozl8s8ehV6+RSCeJ/dd
	ogJml9Ag==
X-Received: by 2002:a17:903:2351:b0:2cf:906c:7d1 with SMTP id d9443c01a7336-2cfa71de7c3mr78111395ad.20.1784889390548;
        Fri, 24 Jul 2026 03:36:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5e8esm49961255ad.49.2026.07.24.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:29 -0700 (PDT)
Message-Id: <73c3281b6fb263b0bd68b6ac5a9d68d2c447ade4.1784889377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:17 +0000
Subject: [PATCH v21 7/7] branch: add --dry-run for --delete-merged
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
index b8aa5054cb..a09694bc5c 100644
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
@@ -922,6 +930,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -978,6 +987,8 @@ int cmd_branch(int argc,
 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
 			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1040,6 +1051,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged.nr)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1080,7 +1094,8 @@ int cmd_branch(int argc,
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
