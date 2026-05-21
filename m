Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05482D6E5A
	for <git@vger.kernel.org>; Thu, 21 May 2026 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403215; cv=none; b=jCQyruzK3zQW4M1jErx7/UnlQOJn29pgJMuoNe1X0QPuIk588mKsx06pFGhtACrVegAQAsR8tVG7oEK7WhFONeDsZBu3PZY0uQoLHyYyiDTtqNBjmVihP9YsCaXrhNXL5hf7B5oC8NvoReV8TQiA7djyX7xSxkODnkKalmVkljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403215; c=relaxed/simple;
	bh=wIAbGFM80Mnfwx4NPHLO6vYG0XFDjutcWQ62PODi7xE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OdXQ7PQcY2eJs4Cy4lb62gDVffAtr4R4LS4yUld4eKoEEJXcADLu/vroi5+8La00KHEQQClxMCdgH1EqEAaWJNgaKdzv5+/9DkAPFDQ4Uy5+962ZEDOk5An6lLfrNWaM7Y6Ft5eUrqnL+j7QHbWXItlbtnjERz/yEwzJwzFJhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNsXWO7O; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNsXWO7O"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ee990e8597so16404813eec.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779403213; x=1780008013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9bHCqLmn1Wz1x0FsWRbzA7dFqCHXV04PB14zk5TmLM=;
        b=TNsXWO7O+LCsAdgIY0tte+TK2jNRoToyus3UMyyWQ9Phy+zcM61yAksEpXA4sQiYXt
         XF7fIXEq++ZAs6LFSZpNyxfIildMBD2czciFlZH/wwByswBQuCqB6nr+7wgw7XTRGulU
         61tkA2DPVJ5SfLRUTw4II/jePDM+SLosrIthqVVeIm8veFWqWpw4Q2DtYzI/sox7LNoJ
         Xc3AIzUSrYtlqVqDaVGwir9q5+wgFhonAxzEejwbvDk1nsdqI8cB+efiaPeYBKx600A9
         7gQ40RSdYkFY/LO5QE47JnjPqdkUWTn4P6u9a2hayAijI47oUA1ko/IQ1pbaCvQRlaOT
         5ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779403213; x=1780008013;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9bHCqLmn1Wz1x0FsWRbzA7dFqCHXV04PB14zk5TmLM=;
        b=rvxg/JjsFKPsJ1QASvKnZDqCntSdxXQe2e6dF0G0tasMJ2wCHblDzj2s8sZWXw/1LD
         hRnYJ48NVLiB6Yo0ROFXYsURbfz84ZurLrArHEjZ4JSmZWBbJtlQKQ0MKKGiVLWMx8+n
         2hzqHnV2FWRpEYh9WOclEzxOkW29mrTDiUGg5omTZ5ueRyFv0UtQ3lyxdX/7DPZB5YRq
         m98lasB8iJSWnr5zhqfJMT1yfu7CMqQs5TsGG5Jn/ah/Q96Bsy5nUEermQcrUrm9D+Ms
         WejGlWY2AmP7qFVyFC4VLWkribDA+RMW0kqJ0xJny1jPUYaQ+yAuhZo+A/iMHOl7ULEb
         4CDA==
X-Gm-Message-State: AOJu0YwSaiL2KbJFupgz1mFFqB7FiU5MsaNSxJPU6JpAXSp8mP0xTyIL
	mCfsCVZTii/rQ2C9hHMkpC7I01ui3LpfW2SqYzOSGtYsEv+QMtDtLhlLgkOP/g==
X-Gm-Gg: Acq92OGV+g9BIaQPsp0zrnmCFCmGUCwnAQfdfHQ9j0ZCBuhekT2OueVGLbmB7npNNDm
	5v2t7k6GXh/K5ty6XYhSGCVrx6w6Xh8OwRiVa/iOnTGYaiPltZbnFE107hhtYNmT+kQAwSx/Tr0
	w6whHi5NgUG7jDW8OczuYtwMxFIa9gxn5dGFNgK2mHU66pun8zgj6GqPSgrdE8P84FXHTCHnZIP
	5kFeNEBGWwFWVu8SHGAE0LCstZ38O7fLR0H661pvVwCUSdlL14jNQTl57yZ2/RZxqfo6s4o9jwf
	zlw4ifvQF+r90EKPTv9diLXcpO3TovYFHEdm09/W5fYf/STUwh3p8sdVKTPzuxx8JXA4Owb060p
	MjAcWU/H2/KjgvMzQOxmhkYLPqh/nZD+rmhdOCdQsTZh0bLwj9PHBwQtu1XJYfr9/t5OB3bL5aL
	sG4kXXf/+67GehS4R3uYVs6EmKUQ==
X-Received: by 2002:a05:693c:3018:b0:2c0:e404:8b08 with SMTP id 5a478bee46e88-3044912f801mr657504eec.29.1779403213097;
        Thu, 21 May 2026 15:40:13 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.62.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044b33cd46sm386062eec.0.2026.05.21.15.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:40:12 -0700 (PDT)
Message-Id: <c68d162e22ffb3544a65ff7ae6f55eb6105c80ee.1779403204.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 22:40:04 +0000
Subject: [PATCH v10 4/4] branch: add --dry-run for --prune-merged
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

With --dry-run, --prune-merged prints the branches it would
delete and exits without touching any ref. Useful for
sanity-checking a glob like 'origin/*' before letting it run.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  6 +++++-
 builtin/branch.c              | 26 ++++++++++++++++++++------
 t/t3200-branch.sh             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 247e4daeb8..349fbfc420 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <branch>...
-git branch --prune-merged <branch>...
+git branch --prune-merged [--dry-run] <branch>...
 
 DESCRIPTION
 -----------
@@ -228,6 +228,10 @@ The following branches are always preserved:
 * any branch whose upstream no longer resolves locally.
 --
 
+`--dry-run`::
+	With `--prune-merged`, print the branches that would be
+	deleted instead of deleting them.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index f995f257f0..b89fd56112 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -41,7 +41,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
 	N_("git branch [<options>] --forked <branch>..."),
-	N_("git branch [<options>] --prune-merged <branch>..."),
+	N_("git branch [<options>] --prune-merged [--dry-run] <branch>..."),
 	NULL
 };
 
@@ -231,7 +231,8 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet, int warn_only, int *n_not_merged)
+			   int quiet, int warn_only, int dry_run,
+			   int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -327,6 +328,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			goto next;
 		}
 
+		if (dry_run) {
+			printf(_("Would delete branch '%s'\n"),
+			       name + branch_name_pos);
+			goto next;
+		}
+
 		item = string_list_append(&refs_to_delete, name);
 		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
 				    : (flags & REF_ISSYMREF) ? target
@@ -802,7 +809,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int dry_run, int quiet)
 {
 	struct ref_store *refs = get_main_ref_store(the_repository);
 	struct string_list candidates = STRING_LIST_INIT_DUP;
@@ -855,7 +863,7 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 	if (deletable.nr)
 		ret = delete_branches(deletable.nr, deletable.v,
 				      0, FILTER_REFS_BRANCHES, quiet,
-				      1, &n_not_merged);
+				      1, dry_run, &n_not_merged);
 
 	if (n_not_merged && !quiet)
 		fprintf(stderr,
@@ -915,6 +923,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -972,6 +981,8 @@ int cmd_branch(int argc,
 			N_("list local branches whose upstream matches the given <branch>...")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches whose upstream matches the given <branch>... and that are merged into it")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --prune-merged, only print what would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1015,6 +1026,9 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (dry_run && !prune_merged)
+		die(_("--dry-run requires --prune-merged"));
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1065,13 +1079,13 @@ int cmd_branch(int argc,
 		if (!argc)
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
-				      quiet, 0, NULL);
+				      quiet, 0, 0, NULL);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, quiet);
+		ret = prune_merged_branches(argc, argv, dry_run, quiet);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b35189ce84..908b184e81 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1964,4 +1964,39 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --dry-run prints but does not delete' '
+	test_when_finished "rm -rf pm-dryrun" &&
+	git clone pm-upstream pm-dryrun &&
+	git -C pm-dryrun branch one one-commit &&
+	git -C pm-dryrun branch --set-upstream-to=origin/next one &&
+
+	git -C pm-dryrun branch --prune-merged --dry-run "origin/*" >out &&
+	test_grep "Would delete branch .one." out &&
+	git -C pm-dryrun rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged --dry-run skips un-integrated branches' '
+	test_when_finished "rm -rf pm-dryrun-unmerged" &&
+	git clone pm-upstream pm-dryrun-unmerged &&
+	git -C pm-dryrun-unmerged checkout -b wip origin/next &&
+	git -C pm-dryrun-unmerged branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-dryrun-unmerged local-only &&
+	git -C pm-dryrun-unmerged checkout - &&
+	git -C pm-dryrun-unmerged branch merged one-commit &&
+	git -C pm-dryrun-unmerged branch --set-upstream-to=origin/next merged &&
+
+	git -C pm-dryrun-unmerged branch --prune-merged --dry-run "origin/*" \
+		>out 2>err &&
+	test_grep "Would delete branch .merged." out &&
+	test_grep ! "Would delete branch .wip." out &&
+	test_grep "not fully merged" err &&
+	git -C pm-dryrun-unmerged rev-parse --verify refs/heads/wip &&
+	git -C pm-dryrun-unmerged rev-parse --verify refs/heads/merged
+'
+
+test_expect_success '--dry-run requires --prune-merged' '
+	test_must_fail git -C pm-upstream branch --dry-run 2>err &&
+	test_grep "requires --prune-merged" err
+'
+
 test_done
-- 
gitgitgadget
