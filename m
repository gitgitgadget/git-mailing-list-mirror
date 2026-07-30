Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477044102E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419929; cv=none; b=oOzqFUvxwo7oZtxyqX9Y0Wmc859emnvQff9gde9bGDpu3e/ta8ui4AnAxmUfd7UgRylUiNvtk9lbE7YnGBLHI4zbPqDZ8wMblPj0flqaQrKn2dc3GxX7Sc9aAPMY/VuXmPHVbYHhcECuowrXn73rmF67+XgHI5GaIDSzdqA5Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419929; c=relaxed/simple;
	bh=bWFdC/UgpOWVXmrFdne41eImdo+DWrSI/q9ec5+3q1U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SyzgjuhERUhaVhpPX5XjU6vhSz04a0cP9S7gjEa+yFMi6mQFl8+19CZZ8gEwfQaJpntKZBNRrrTLrXr2Fpp7KYl3w/BF2WMtbmM3BXfaMKBGPgHd854i/zjXnE8fNS/G6c0w3nr8UxGYkuKI/V8JRqxT8KxbzZMqjM0UITuP1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/YrooLI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/YrooLI"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1288663a91.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419927; x=1786024727; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ru+oCI4hMc0/hTbJ+Ckxv9nkhfo7Vo8sSvtFd6xRJsg=;
        b=C/YrooLIF2RJhdXRPtLUuB5KpwSimHXio6NiBalrvPf3RTOO37tw2wKTw5nIkUOymO
         XwTsLi3vFO539Ct28DWF+QW142/GN7aVfRjSMDy+dSTXwoPpMCV9LmCTQ1fFeba2jsby
         83+s4rjea/iSZh+1nOiiyWH9yx4B5yNplDv453pwnmPBcQj5gwGr+/ucLJtFKp7p3kI4
         3BBh6pg5bfoiJ6hiiQ9D1RWWcttMVgBMQkqgwPrQadZ1n7FKK0W3pkWPnjb8SF3gzYUO
         c2ksbKu2hc4ueJljZsErBA+YzpEznWJ3O1pFISdTfQweVHQ1jJ5F+YxiW1nlEqCPg5s5
         3kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419927; x=1786024727;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ru+oCI4hMc0/hTbJ+Ckxv9nkhfo7Vo8sSvtFd6xRJsg=;
        b=cRcGkovj3URWlsC9QvlSarb6PP2WmNW8lNPc7Zc+hCctvPFnuNgEVxRPDSmBmMxR/z
         2LKfgVv5GMifFSFyB8OCmvyO+cUP+ZgMEUvDkOP2c4J/oiEAlt37VYmOs/LQqSJ8lEFc
         mKsMO58XuYEHMf/a0RSNldPB74VdvY5Li+Mzgj99Iob5ttHXU584r1vcmKwTsqvCfj2U
         E4c+WFjw2LueLNMsntFq6Nyjv4GYZzAvWBKh7g7TgJpq04iifTi9/AwXUrIOK8TCihqV
         cCZoEQfBN1JE0CSJifqYdILubQJpL2UkvoI9xJBdrZQTwgP4XuTsXBhaukvETYO1ZO0o
         Iqcw==
X-Gm-Message-State: AOJu0YzrATsDyoxHt6ojwhNVsMPblHOyXWsfiDm+h7iXLbJrjlwBcy9m
	4larNd4DcPDEsRbLcJEA4a/TIe8N6NHQRJy1TQF2IfcWzAwij8faw3k8gYSyDd0I
X-Gm-Gg: AR+sD13JHDc9mZ6yPMqKQuEm5VyHLIDRf83ualX91HN05FC25surQVXqTTiKzzRCvxj
	PuyCGDgw7no9X02Fabiezef08jQL7WNsQx1ZXfdu6oNdEXsonPM7Cd1mYxo80XJQQpHGqiE5Ak1
	UueGRkJB9Z7N5mvXA0DY6K4ssLMLi1YVUl7BFyvtUNYQ8dxkTPNqQ1nhzVlMJ6VnJVY/o2MAEV3
	/Y6o4jP2MStD6WoYbrDKbH6cTKeYIT560CEAeyDYv24APOAylHcdqJWsLq1DRE1aFcQhXkFXCtu
	cTOE79DnqWW3dpYeLGcBBOdYLE6pwYLPArbeul9lfGbnzxc92oKw1y4PkMJpwtQ3N2pV0Z2RFRW
	q1lau7xdMdQ/8e+ryKhuImSS93+ZlrsNueb+f7NAQXJ8tDjDTAJEOea6ptqVJq1/fLfQqgAlqC2
	vaqOe/51sBePK6tNgs0JptAa6NODJGVHRtvBsYbjJnjtVXXPyuz3jk2IG80t8WCFuu
X-Received: by 2002:a17:90b:1812:b0:38e:69ae:7148 with SMTP id 98e67ed59e1d1-38f9bece079mr2492871a91.24.1785419926824;
        Thu, 30 Jul 2026 06:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.230.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b72c596sm1155089a91.9.2026.07.30.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:46 -0700 (PDT)
Message-Id: <96ebfd6ec65253d9c86edcb2d8cee07f0dfd6af0.1785419916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
	<pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 13:58:36 +0000
Subject: [PATCH v24 7/7] branch: add --dry-run for --delete-merged
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
 builtin/branch.c              | 23 +++++++++++++++++----
 t/t3200-branch.sh             | 38 ++++++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index cfaac4b90f..bfdf459329 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch (--delete-merged <pattern>)... [<branch-pattern>...]
+git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
 -----------
@@ -235,6 +235,12 @@ A branch whose work has not yet been merged into its upstream is
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
index 2d0c4f51ea..57ee384d23 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -200,6 +200,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -342,13 +343,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
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
@@ -882,7 +890,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
-	if (!ret)
+	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
 					&deletable_branch_names);
 
@@ -960,6 +968,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1016,6 +1025,8 @@ int cmd_branch(int argc,
 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
 			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1078,6 +1089,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged.nr)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1118,7 +1132,8 @@ int cmd_branch(int argc,
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
index 50fd1d348c..942c7b63f8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1938,6 +1938,19 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
 		git checkout -b tracks-other --track other/main &&
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
@@ -2003,9 +2016,12 @@ test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
 		git checkout -b topic --track feature &&
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
@@ -2033,6 +2049,21 @@ test_expect_success '--delete-merged clears the deleted upstream of a protected
 		git commit --allow-empty -m "tip work" &&
 		sha=$(git rev-parse --short lower) &&
 
+		git branch --dry-run --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
+		echo "Would delete branch lower (was $sha)." >expect &&
+		test_cmp expect actual &&
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
 		git branch --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
 		echo "Deleted branch lower (was $sha)." >expect &&
 		test_cmp expect actual &&
@@ -2120,4 +2151,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
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
