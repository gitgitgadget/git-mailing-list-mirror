Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B833EAED
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810745; cv=none; b=VBuiSDKJoheq/+kAoHuVTTexwS7ZYXoJ1uHVBdxMHNSj+Qzzvy0HZ8eLg3Te9UFNiqYvMCQpMLwy/G7ZLmOW6FdI1oFPZWfZf25ldcovM2dC+DR2VmjT9sFgrXTmo1KDyVfERUbRZjHboHpTJ7XVrajDzx/scLR7jiy/7fOs1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810745; c=relaxed/simple;
	bh=pIJ8Kv4N5C82VxHyCz4vCFKWHfef0CFCHttTzXAM2AI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ssPPxzeNgrm3+0oboo3TNff+g+dcslCsheX3S2yXOxSEiGQd7WeHddwKk2Ir1pxoF6V95HmTy0MElAuNcL3SRMyrmMFOCGDtjNoqrMsnVqB9D3Blxr55bW39N1omDstR8EW8+IC7Jgwhww8t4ceSJkeF+aF+fEyv6RGQFuU/McY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4ZfhDgt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ZfhDgt"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91574384cc2so163955885a.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810742; x=1782415542; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ukNgfHJKgDBL//fi1GXTQtsdhH2WX68nY4R0pQzAHw=;
        b=X4ZfhDgtdcv2tfNx8FoRfG/XkUMqa+7uGRQXlEnLezA542Z4G7pxMSPGasBNtoRRSJ
         t4UohbgMex/gDs9FnqHXjTkBlF92ywY/K4jzCwPnHGrDVO702cnq2kETNSxd01iu+aMp
         k/KB63f+YRZ2gSlApPUmt5nQ/IoZq4k3qj4XNPxjYpukIORqa+RfA8FYQ1j7gX9ebzui
         4a1OIjXWFBLiaHLnOTbUWhcWcMdpybEeHly67otzRx5LEwm4oDYyO3f6MRNO7tBYSeOG
         8gTZufn7eRoFLdby5Zq9iryhTmT4eFoMCvctNz6dIqY92DOBrgxDWPrzg+w6qibG88DY
         G/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810742; x=1782415542;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ukNgfHJKgDBL//fi1GXTQtsdhH2WX68nY4R0pQzAHw=;
        b=QZi5hTrCYJYBkNVE46hPG//4LvUUdx7Rjx8iA10kw4vMmlPkFwpTQSn8JP6cQ7E0tN
         tYYryu9zu1sEOGKQINdoPGuzO6zZti+IklCd2G8iq91bWGupDPWzIXgVBjEVARR6I3uF
         qQs+caz5XHxunRiSPS/a/GlhAlkmsmQdUHalpiGtpV3eT5mfB4ZMsB1XKxIuBFuQfx8R
         E5CVVNIPcw3wQr/dYV2KPX7vGvVE0RLefOIl6xm5lwfSNegoavpzhkNgxpjhO+32f+l/
         d3xkw3+GODYI62BKrVw5JR3brxc8JXcDQ72AZ6YkTDjMQks4/uEayQLCKfQyFHj4MPXv
         xLZQ==
X-Gm-Message-State: AOJu0YyD3wQq098bp1wVFN43kAj+OAKKazTc+SDyg03pG51he55Zf0El
	9eYOQaOpfqWEK8fix3G7odXVL2CrZ/iNl8U3lHapQ05XoXWsvS+6OyX+ZDRQaw==
X-Gm-Gg: AfdE7cnM1yBeaukcQkhiUPdimQzFFEIH91TVczLwXct0a9oWFZ4lDrtxdO/4O/hlUbj
	Ibdi5PnOCz70BQEj1K9YheYSxleO+Zbyg+aOLKB6EKHlNAYu2BNGJEfqqhCLTBfew+M+YO25aHp
	Hc1rKMbI9p8EQdv7a4lwKHsT6W9Z27FWhyOvGQP5cbhkTYEf/ARDQiJV4dfczLBayGspPWQEn26
	oUOYa/YidKy+lBdxb6SJSOp3JkPqF51lOPBgTIqPb8kXakMtO6WAJ5zkYuAZMy+P+x3TJkS4CXq
	DRTh4w1C4bB4yC9HjopbLvwuXZ1vDNlo6siwgO4RSlQ7nvzks6TNlf2vo9TeZ+lkNTDwuF7gt2j
	P2QHNVEqBiDqCf2fWV4x7Us3mwc2tGFswTBoYwJ2wdgQ/tf2VJnF+qzKAfeTmq31h/uDzcIsG0o
	BdZ++kXij7tPlmnvQ=
X-Received: by 2002:a05:620a:1b81:b0:90c:be8b:3676 with SMTP id af79cd13be357-92091d59081mr44440085a.56.1781810742443;
        Thu, 18 Jun 2026 12:25:42 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a4c5d743sm1156485a.40.2026.06.18.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:25:41 -0700 (PDT)
Message-Id: <6d5c52353e0bec2cba058f37b267a00a7b4f07ec.1781810729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
References: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
	<pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:25:29 +0000
Subject: [PATCH v16 7/7] branch: add --dry-run for --delete-merged
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
 builtin/branch.c              |  9 ++++++++-
 t/t3200-branch.sh             | 11 ++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 91700f2e8a..09063d74f2 100644
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
@@ -226,6 +226,12 @@ A branch whose work has not yet been merged into its upstream is
 silently skipped. Delete it with `git branch -D` if you want to
 remove it anyway.
 
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
index 942e2297c8..f67d0949fe 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -826,6 +826,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int delete_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -881,6 +882,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "delete-merged", &delete_merged,
 			N_("delete local branches whose upstream matches <branch> and are merged")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -943,6 +946,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -983,7 +989,8 @@ int cmd_branch(int argc,
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
index 09cecfaff5..4a71845c76 100755
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
@@ -1970,4 +1974,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
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
