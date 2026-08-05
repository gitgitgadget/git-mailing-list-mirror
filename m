Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E19387345
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939907; cv=none; b=h//8bZdAlif4dWrtCYnOqRruQ7c+o14Syzfhs3ce3dMAn4nM/Sxa5mVw8KwlezfySToglDznrYXIYYkGD8ybJuw6Qmj5uQ61d3BFIXkaXkyyjH/lqY/xFR+FcZzWp75OizaAxwMWQTMrB3Rup8cmst5MZIANXG/7jd+NKi4PSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939907; c=relaxed/simple;
	bh=yY5W+mtcm/Jw8TOF42ShfJRyjCeldM1/zHnfEOZjvLg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XNRY14DqhmJVUnW5muIzB5gOPWnVcJMt/DVsfP1g1fTt+A6FhSoMOdw8thfmSza4973vu4UG07hFTAQAwbqqS2gtGkkNPwJBNf874Mt473x74VYeAHOtC73FXi37DghTVJj174JgH+7MZBU1r4roNamUBu6FMKkLlZSK+uLPjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQGTVLCI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQGTVLCI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so15843445ad.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939893; x=1786544693; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AkXSZEh4fu5UnvEGAbspfnINl49PPVKfm0ldaIaKss0=;
        b=IQGTVLCIIJTGSCD5fAnRqTJ5sqzJuPSpNQjOJpExcn8LhgbeRCr3d5T/MS5FgXjH6y
         yc/sO6MRyTbigPv7msHLLtIUpf8dDQGtUW8UPSvzxT1dTmV0Ba5xZZD4ShpO+awMtvCa
         jIFu6H1OTNJyExTufXSuSzibykQHIEmQzlaBtxRW33rRXTiVsQ4MsiX2sRkS/jnjY0Cl
         tjsxp7vv70d1KxanAz8QXtQq/vg0+s168ppp185zcnamaNqqh9pbfFluSXe89FNPc0NP
         ECEhHGDdQSrOrJgznHumOqEpSQlNoIyEHIX6Ylgz6MSLc6cF1rk1oEYjuoc+NbePLJKF
         R4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939893; x=1786544693;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkXSZEh4fu5UnvEGAbspfnINl49PPVKfm0ldaIaKss0=;
        b=k2r8GumF6TtUv19LnI6fnYNu/qetnnLpD/9htQ+mxcrn4Xy5kZSgdjE4Lr7s5JpDhX
         Ivhh6nX/9TpSo2bj8z74pTFnG4R/5X0T45p5iAY9P48MMEdkofivySCPTdl4oVib9vYv
         EVLhwnQ4vQaI6bJHf0MCuUoyVqLCyRCoGk0CV282t1IvR5ZAnY9GQdQNMYVWooSF4oW5
         YZs6R/P5KnNP1kUoIdZVlntO8JYxmnu4mOpUiTDqtB91AFkCKsjbyqtitldB9xTSvy7d
         9nDWrinP+97WjkEWKbf0X5R/+Pw3ruvdZjqAueGYmJBChV3XVKG+kzu6Xmnfcc7KEB8L
         J05g==
X-Gm-Message-State: AOJu0YydmI5w3bqx5UonQrUpSpvdp0BA5oYtPYTFCEyX0n7f9ZAkn69v
	xiZNNqyrS345Cbe5n31yUTjUPxbCPngPWmKZC01qhs07WkPMNtvysd4tE5n2rw==
X-Gm-Gg: AR+sD12U7Rj5VPIAxejL43dV580Wgzj8Vvupm7/tIvcPH1vWaeYo/5KCdPzDNT9YNPJ
	o9yzi28OGJNpdNlgrvWADiwXIFj4B2zw3veuNgKD6FHfFggdmqutDDgl4/Oed/eNkj/q9/WZpaJ
	k11E98B2Jqti0/plnJqeZ3DjnbsLumuRAOGIVh/PeD5vkdkSFB23csUtWDcJvAxWISf6FMncmoV
	tDGNevWazYdJaf3z8oY4cIv5uvQu/1SRsjR42QbCNu60wZsZpZsXXRWNpcL8DCEc0ZE63OQAlJB
	+/yM/EytftorJ1sYx5xecoKcQJJS+pX/fO5uP2Wba5x7XI6KtFfK6WmxQ3Pa+gmlHj7cZnJzXMt
	NaQNZExqKUBiidPdLqQX4LPtPSW2rk/CTSjJvuUGzlQxrS6c7yqzx4bIJ9b7ZW49UDPG0qJfqpq
	+gZ1oDqfnvkqyGn3Nr38/kHkF9c97HPAMjaQk/141utNnE40tRykntScEK8SKtMS9zJjlvHDnfs
	HuOFQ==
X-Received: by 2002:a17:903:98d:b0:2cf:ccc2:6088 with SMTP id d9443c01a7336-2d0ca710d32mr91807335ad.4.1785939892968;
        Wed, 05 Aug 2026 07:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be4dsm22360865eec.16.2026.08.05.07.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:52 -0700 (PDT)
Message-Id: <5a936bcb93f04bed0db33cf4cce19e194324e11e.1785939877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:24:37 +0000
Subject: [PATCH v25 7/7] branch: add --dry-run for --delete-merged
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
 Documentation/git-branch.adoc |  8 ++++++-
 builtin/branch.c              | 23 ++++++++++++++++----
 t/t3200-branch.sh             | 41 ++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 6 deletions(-)

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
index 31ca1719d9..43fea342d1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1952,6 +1952,20 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
 		git checkout -b tracks-other --track other/main &&
 		sha=$(git rev-parse --short merged) &&
 
+		git branch --dry-run --delete-merged origin/next merged \
+			>actual 2>&1 &&
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
@@ -2018,9 +2032,12 @@ test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
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
@@ -2049,6 +2066,23 @@ test_expect_success '--delete-merged clears the deleted upstream of a protected
 		git commit --allow-empty -m "tip work" &&
 		sha=$(git rev-parse --short lower) &&
 
+		git branch --dry-run --delete-merged origin/next \
+			--delete-merged lower >actual 2>&1 &&
+		echo "Would delete branch lower (was $sha)." >expect &&
+		test_cmp expect actual &&
+
+		pattern="branch\\.(lower|mid|tip)\\.(merge|remote)" &&
+		git config --local --get-regexp "$pattern" >actual &&
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
 		echo "Deleted branch lower (was $sha)." >expect &&
@@ -2139,4 +2173,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
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
