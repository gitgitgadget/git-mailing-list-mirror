Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CE41A553
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921391; cv=none; b=hek/cbU3ommAQhyHTqK50qeBdqh1p71JIvWWHDuXxlgOZ0Eq1JdQnq/yjuBtvMr4BwGeupz+dvjIoMVxitmG7WbluMyoeGcRpN79aK82GtdU5FZEZe8rmrbiAZCFIGRI6LWQF55b+xvfFe+FVStvcgVRoi2Lgr5zXZShr+vh0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921391; c=relaxed/simple;
	bh=K/qsjITLBgG+Tp7vKQfzglSB0X+A8WX1XfOFBEbUGW4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LhaMlBZhLb5vgLJEf4/K5fd5Pxu3LbngzdqgIMYIGct3AbjRTebudB524GSudd9zeISbsXdKMIbc1uoidhP3uAZN2eA6gwKA2ME5R2pKrBfYA+xtjRFsVfItQ9KeE1dHnf2wFRnL8fybMLDGAndDSMNsC8h9xjRq4oFcYgiZJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmaG2dzL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmaG2dzL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381b831d535so895340a91.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921386; x=1785526186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M+uFQilHA+8v/W4//grHxVJ25sWgKIY0/Miu9bmzzps=;
        b=CmaG2dzLfBywgKe2DED0VpjE7FAziL5Wn2PuEBJ6ghE4nQif4jShgpwZz+zVgfxFJK
         +DVdyg/O1hfEWGstheO0W1yxBvBRxZr3cVRfFUJSZeSSqH3mkShisFeXqV090VEct8bV
         Jl8Ckl4DEOgK7UhuXk6EO0AUHoiEkqT+1GS2x/4BBqBjQe2I8JwgkhSCHdtPxs8qHMtA
         sIQuZRqOwTwOLhk28hp/U2fvo0WNRdT4tsSRk1l9ZEKO6mdj7gzscdYfmUK1EjeZrVnc
         R/nDJIER7gJcgg5ea1Pwdrr0A5AU4VCpg6iKs+pWXHUBBmdet07ullpH4q08Q28cKf3B
         1t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921386; x=1785526186;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+uFQilHA+8v/W4//grHxVJ25sWgKIY0/Miu9bmzzps=;
        b=T9b+W4H3nu5WTve3UGMtjg5k660ULd9sjgEXv17iDc1uE/Ggt4POXrqYAtufc4972J
         m3CiyvE2iIY3EkewtUZIrM95Az3uMOk3mcgGS5kiyWrVOUGB9O0ey/ByzQsdtey1WSp3
         WNjKC1rIjVLV6sDou3CNe9fPK01mQxTIP2mF7AoxkUXMewSZZnlFiEH7QR2nWYVcGRSR
         6BkzjpZEk0c+WrQ5se4EURkB/iCPrCe3wDVnscjn7+ZCTApoS74Bba50Hrn4WbfOR3qP
         ufCoYFJo7OHzRK2xkBos37IJ+IJthEYcZu6j++mAWBwDozhiC+zpMe8v0kXwZJzMiI7Y
         J0TQ==
X-Gm-Message-State: AOJu0YyaBa5oAf1g7MD7iiM+Hd4sIfUAHaV/LYNZtO09pZfNUDF0/iPT
	9NeEi6mqkb8xMHl7NZRAXNLA9Dx19imuMr7VOssp/1FhbHNCWFm79eXR7RSWVQ==
X-Gm-Gg: AR+sD12hrrnL7ddYvcGhW2dbmOib7Wh0p5lGfEW+k+maWwOgVgfGugWuZweB7wVO5Bm
	7cVbau2tNP9MiGMWnXYBKEjSaT6+kYfZPk04udtUhgwgcu4hFXFQEQfZ7qp3l+feVdQQnmC/ptJ
	1uV1HlGdwPAmOP4d7XoirKoqe7E6otqBI1IOh9h98bFhy9WDfvjNx0e8harlwx0rdTHIToPAcqf
	o4kWzJmG2tapgTgtPOFYHTvZEw3GkMQpMk6kSIn0cnIaG+oLMCxtVhuwRrc7y2MGHxbmJCth7VR
	Q7iUtHp9c/X5RIEIX28sFJPRfKBOfV8l+hBNsj4V7pgAzRrk0OBtAkgPEpJExN/LsDQuh2ko8Is
	5Wj5rSUo5Wg80YoNJ7Lehn3WhmR5J8gbwa2udVcAsKv3otIQE+YyVTYX0K6oqTc+OqkSd+0ky9P
	rbC1Jf7A==
X-Received: by 2002:a17:90b:2b88:b0:384:5b5b:3465 with SMTP id 98e67ed59e1d1-38ec68771a6mr8899855a91.29.1784921386422;
        Fri, 24 Jul 2026 12:29:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.211.27])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm48377690c88.2.2026.07.24.12.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:29:45 -0700 (PDT)
Message-Id: <4a42b6f5f9385999e45e7e912ca78a4cfea2b2a9.1784921375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
References: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
	<pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 19:29:35 +0000
Subject: [PATCH v22 7/7] branch: add --dry-run for --delete-merged
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
index dc1d74077b..e0e91743ca 100644
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
