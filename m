Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2E3B7751
	for <git@vger.kernel.org>; Wed, 13 May 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700893; cv=none; b=OJpqu8SBV2Pgh8KUtWDbC6w8Y1WrVAwiRC1YMGoOMvybYS42oS33GtY0AsOEcYVX2/QP38X8Jhsh13FF7rpYHBabn+m6S9trwTSmZVzIs9Bl7gwyH+LEkb5VsevFKqucZaX2Q5EgRI3lsWYdhs//rg+R05xMhuA4mziGVJhxTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700893; c=relaxed/simple;
	bh=NQBHtYVazXeNBQ5050ZIy4TbuICStXxIQy9l7uG5BLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qQ+9W0gqgy2dy1UZaM2/qzBu1vcR7N0/uKyukommIDjbIXxNqfb9oqtP4MWJOFTzDr8MkWfDJrTkAhZBGvj7Uvb3fe3X9ILn0jtmmOR3IBkgKval2dv1c7sMuD6mpsbsO+SESPz9cnZtd26jWg7Q+vs49lX0rWXizwXkfuEbGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOWchVX2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOWchVX2"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d880e6fbbso70842171cf.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700890; x=1779305690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcf/OO4nCjSusZKdtHxY/9utgMmbstXgbQjz3hpTZzY=;
        b=UOWchVX2oMeWzIqieewp7zP0rr+L0uBCG1pkTDKnsTG7AjagySzeQqKFK8Zz4W7P26
         lrSfQuEKR/T5lf7UPT3RTSwY3KlzGOR6sRc0tQJACzxhb3g4+6FrAbLsirf171LiBBk3
         Fw7iIieen889dtnE7ox3+0c7S1J652wA9NYILSkdg6Js3/7mpTbVi/xktl2zF5+jr47M
         J7fMDxOdcekVw14M4eotDiwOoolsJXGWpE9ISaOBR4ZY6CnJJXByqfCx0DDaTkuwpsDk
         v1384s/zFyu6WJnQg5Np5keRIdGnquxQ97btupFKcUiS1jHZp7I9IO7k5J3iMiGBEs65
         gUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700890; x=1779305690;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qcf/OO4nCjSusZKdtHxY/9utgMmbstXgbQjz3hpTZzY=;
        b=Sjm39shUVR5503r4ch/FdMY/eATq4r3B/F8IX9irBpAO8n18rQibEZd+KH0KyiC32O
         jcaDb9s1IbjCilKvHJfR02BCB6NaI04q71QeNswASvrFzIu1uVtXDbikoZKrraKzOXuL
         urOpMJCL/OUNnlVkXYumETMNJ4hyxQlShzvcRfr1c9x2XQwe5JiZwKY0TQzWohB2fFNK
         R6DWJ6Xth61Ycdyr688D4c/8hO0BfPWI0oD/5PiL6MIHOTZfj3f5NAGN1leX1OA0OX+2
         w4M8AymS7q+4QxX6IJOpoIeQT8gvej0C87nZr81be4aAySme1tiLQqC/4PdXuUPp1ulB
         haNA==
X-Gm-Message-State: AOJu0Yx3S/8FDdhMjtB/iCdfDIQazRfBQGAJf1VFo0rEb39h8CPgwxk3
	GNCrpeLsJ07U53Y2PzJV5SqCIShZWXigieJPB9NTGMCfdg8fpHooKPQKhOt22w==
X-Gm-Gg: Acq92OFZfI60EdeIxjy45726AOc9QUX5etxU4khLfXT8xDkc1z1YPDZ6szdBJt5acT+
	JvGEzhrOB0LC2wdkEk7pU1gFhpLEh9SR9hjCNU8mwAMycA/JbxoMXp8v0+8HuxSsrQRzeoYsXiJ
	lTy3mSW/yc6kI2AGfZJrn3sKRDhkBOtlhZJHj9byYT412XLapyBEmROE3SMYrvWfWnZjivKDhs6
	7MwxHX6TPk47gnWuGwhkgxrMXvrLuij5L+2CIUSEjQzXTPwOm6MTmTh+nbFym+g8+jwCSUq2JLW
	JFYcP6I0AZzeuYgxQilsB0UW4IhI88A8DxUt993QId/sKPwMhFregYHw2ASmBfVEISgCFCEzfWS
	7vy0n0WKXqFfllEyy5G0VM1TuTOW/BMKb8JICtKD/4orp6Qd/dGiqqfbVh1a/Z8KNEG21XxBEbB
	t4b0uqs2qiPaqt4QqdcPPP/zjz
X-Received: by 2002:a05:622a:2588:b0:509:11bd:9d3 with SMTP id d75a77b69052e-516415f4efemr12048641cf.1.1778700890592;
        Wed, 13 May 2026 12:34:50 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149bf65846sm140391281cf.19.2026.05.13.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:34:49 -0700 (PDT)
Message-Id: <6ae95d3f98212ca449cb81d3cfe332e78b8011ea.1778700883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
	<pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 19:34:43 +0000
Subject: [PATCH v9 5/5] branch: add --all-remotes flag
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Combined with --forked or --prune-merged, --all-remotes acts on
every configured remote, in addition to any explicit <remote>
arguments. Used alone, it errors out.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  9 +++++--
 builtin/branch.c              | 41 +++++++++++++++++++++++---------
 t/t3200-branch.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 7435d38447..3cf3bf033f 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,8 +24,8 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --forked <remote>...
-git branch --prune-merged <remote>...
+git branch --forked (<remote>... | --all-remotes)
+git branch --prune-merged (<remote>... | --all-remotes)
 
 DESCRIPTION
 -----------
@@ -231,6 +231,11 @@ always preserved, as is any branch with `branch.<name>.pruneMerged`
 set to `false`, and the local branch that mirrors _<remote>_'s
 default branch.
 
+`--all-remotes`::
+	With `--forked` or `--prune-merged`, act on every
+	configured remote in addition to any explicit _<remote>_
+	arguments.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index bc4f4a4a18..7d45bada45 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -687,6 +687,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static int collect_remote_name(struct remote *remote, void *cb_data)
+{
+	struct string_list *remote_names = cb_data;
+	string_list_insert(remote_names, remote->name);
+	return 0;
+}
+
 static void parse_forked_args(int argc, const char **argv,
 			      struct string_list *remote_names,
 			      struct string_list *tracking_refs)
@@ -776,7 +783,7 @@ static void collect_default_branch_refs(const struct string_list *remote_names,
 	}
 }
 
-static void collect_forked_set(int argc, const char **argv,
+static void collect_forked_set(int argc, const char **argv, int all_remotes,
 			       struct string_list *protected_default_refs,
 			       struct string_list *out)
 {
@@ -789,6 +796,8 @@ static void collect_forked_set(int argc, const char **argv,
 	};
 
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+	if (all_remotes)
+		for_each_remote(collect_remote_name, &remote_names);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
@@ -802,15 +811,15 @@ static void collect_forked_set(int argc, const char **argv,
 	string_list_clear(&tracking_refs, 0);
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static int list_forked_branches(int argc, const char **argv, int all_remotes)
 {
 	struct string_list out = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 
-	if (!argc)
-		die(_("--forked requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--forked requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, NULL, &out);
+	collect_forked_set(argc, argv, all_remotes, NULL, &out);
 	for_each_string_list_item(item, &out)
 		puts(item->string);
 
@@ -818,7 +827,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int all_remotes, int quiet)
 {
 	struct string_list candidates = STRING_LIST_INIT_DUP;
 	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
@@ -827,10 +837,11 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 	int n_not_merged = 0;
 	int ret = 0;
 
-	if (!argc)
-		die(_("--prune-merged requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
+	collect_forked_set(argc, argv, all_remotes, &protected_default_refs,
+			   &candidates);
 
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
@@ -943,6 +954,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int all_remotes = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1000,6 +1012,9 @@ int cmd_branch(int argc,
 			N_("list local branches forked from the given <remote>s")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
+			N_("with --forked or --prune-merged, act on every configured remote"),
+			PARSE_OPT_NONEG),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1043,6 +1058,10 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (all_remotes && !forked && !prune_merged)
+		die(_("--all-remotes requires --forked or --prune-merged"));
+
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1096,10 +1115,10 @@ int cmd_branch(int argc,
 				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
-		ret = list_forked_branches(argc, argv);
+		ret = list_forked_branches(argc, argv, all_remotes);
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, quiet);
+		ret = prune_merged_branches(argc, argv, all_remotes, quiet);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 885a275e36..a36e5ee80a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,6 +1771,27 @@ test_expect_success '--forked requires at least one <remote>' '
 	test_grep "at least one <remote>" err
 '
 
+test_expect_success '--forked --all-remotes covers every configured remote' '
+	git -C forked branch --forked --all-remotes >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked --all-remotes still validates explicit <remote>' '
+	test_must_fail git -C forked branch --forked nope --all-remotes 2>err &&
+	test_grep "neither a configured remote nor a remote-tracking branch" err
+'
+
+test_expect_success '--all-remotes alone is rejected' '
+	test_must_fail git -C forked branch --all-remotes 2>err &&
+	test_grep "requires --forked or --prune-merged" err
+'
+
 test_expect_success '--prune-merged: setup' '
 	test_create_repo pm-upstream &&
 	test_commit -C pm-upstream base &&
@@ -1881,4 +1902,27 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --all-remotes covers every configured remote' '
+	test_when_finished "rm -rf pm-allremotes pm-other" &&
+	git clone pm-upstream pm-allremotes &&
+	test_create_repo pm-other &&
+	test_commit -C pm-other other-base &&
+	git -C pm-other checkout -b stable &&
+	test_commit -C pm-other foreign-commit &&
+	git -C pm-other branch foreign HEAD &&
+	git -C pm-other checkout main &&
+
+	git -C pm-allremotes remote add other ../pm-other &&
+	git -C pm-allremotes fetch other &&
+	git -C pm-allremotes branch one one-commit &&
+	git -C pm-allremotes branch --set-upstream-to=origin/next one &&
+	git -C pm-allremotes branch foreign other/foreign &&
+	git -C pm-allremotes branch --set-upstream-to=other/stable foreign &&
+
+	git -C pm-allremotes branch --prune-merged --all-remotes &&
+
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign
+'
+
 test_done
-- 
gitgitgadget
