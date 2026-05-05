Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415C3CF67F
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009055; cv=none; b=b+EsZ6JyBGdm3boXJMYsXJUIAoP/nVDghaSocMvxgg8IAs7ljzRsf752hsD5OZKnWsYz+p6NjuYcnRkTvA7cn+bUaJdPmcG1DFeTtPSAZDPCpwHzxHuFkT0zxEgCohsqZbxR2TFFwCxrN1FqM/jJNAd/RJacQmCtNEA76pmnsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009055; c=relaxed/simple;
	bh=E6Jgf9yv+XaGFbd4hnCDUgZJ3INMTqSJZr2ObBnRp9A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sg1oTj1hb4WQirLFyc3QxbBu/k0xL16XwnENVQ0R3NpzEFa/ZawqvhDyzkdd7W1vn8U2sC/9ph+zFjQ88SfRRCc7Hc+SR9BNAagjqmIzkrgtL8W+AVYtDM10XUxNQxOnC3GDMUSrAzOJCw2/dQqv4vviojAICi07a26d91msVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7Rtvetg; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Rtvetg"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6966d0665baso3242701eaf.1
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009050; x=1778613850; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBneQqXE4MQuQ3UtH8wZc28rmakyDLMxkB5d9YCxxvY=;
        b=g7RtvetgT72xPHGsHVzpeUzj8nxYoWuI63mPUdYDPy8TKFvjyf+eTNBZm7trzx6XAl
         lnfsTU1QEQZAZOa2LWeAQSnDnzxi8XveMYcB7WaTomMt8ONRZNqyNXBqOuRpCmRZmeLc
         xxW/Pg+4dzd/lLHXpirwLpfvsg0HAoJK0XucqoTZD5euqF4zkASvo8mNlrzzOjqaoXNR
         p+NjmsDX5WbW/STRUc7mlMkrOqReUnFpDodLoJd83Gcq/xpfn3OTGjaMHdoz+Q1j9W/B
         IfynTv653UCsFQnqxnW0ki1R9sWkMGXQ4qIxfArJ29r1ekmYlBLUXuU4SyWVGCqriWcS
         0mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009050; x=1778613850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBneQqXE4MQuQ3UtH8wZc28rmakyDLMxkB5d9YCxxvY=;
        b=nCwnp38ieYLAM8BFovtBs4FhNGO9Xn226ebSv8gQ0B3CYXYI+wOr7/aO2t5nJViVQf
         0fKkOu5qpKFgI2bDbARlwrdTgAAKA7B56GI22vDprtawmq3adYWoPj2K8jL/dc65SsQV
         P3zThPoKMM510jxIayhJNBMBZuYHLaMLPklK/KLmRQCoXpjz46iYXf8PQmDQ8gCOfmW2
         i4Z1S53Xlp0CQKDpRkPlt3En4lNJkfjbaMigvWy0R88iByQlXeGy7bdKdNed1cdfnP0C
         UxFNhPlbLvPp/dxEfTVLgjDyl9zu2YL7ihp+mpYPlQIG+8GbCKVFeFqO0b6xdZkaRkls
         wFLA==
X-Gm-Message-State: AOJu0Yy/DpNKB2HX/dWGfRbTboUYzaIc5XF5QBgBPBrwQbPQK9CCzYi6
	xRhoV3OokHqGggdS2ytMTJ6cdSy8WR2bMK6iuHNtYYx0LF6X4OJj25kSz1+snA==
X-Gm-Gg: AeBDievR0nKb6jDHXv1rioKK5mMcg9mijQDpnpl70cRARTXFnhe+gck+hy+z+ZHhTJw
	jKrumrQfULisc3EGdWc3AVQThVWw21n0+XqlxRvxmUWJnix2s/xJ5Jaa2IWbKPJfumJFCrne3U6
	3v5UCFYIA1d7I/VcdiCCKt5lybrTWkdpAIM5MYwTM6Tte/nHZMGXvwQt4Oz3yGttSSuqgPyj+SS
	JUMVQtGAMffWLYyG0cIkNctgS8gvHF1lFiHIBBw0qdQhUgxBtOcHMp9lDPp4xXdsO+dWVFXlF1B
	8a7XF65v6a++xwqVTbFi2ThPpG0OL86MM63DYkdgLc+CddgV4IgsvspNHN/1ZEW+zJ/0JFcggBn
	/e/Vpzt0obWIFEM85yroodAm7cUA2KBt6v2PzKY9D/JnhkD/pAj+gtPiMmIcuWuOByOl4hTQXhG
	hE8TDG/JaJAUjJ44B2cpzY7HFabdpb+I4Bihd9
X-Received: by 2002:a4a:e908:0:b0:696:22dc:b4db with SMTP id 006d021491bc7-69998d2c65bmr81383eaf.41.1778009049947;
        Tue, 05 May 2026 12:24:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.21])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-696896e7677sm8885337eaf.11.2026.05.05.12.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:24:09 -0700 (PDT)
Message-Id: <690242d89bdac6e04dbb7d00133193f8006c6f49.1778009038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
References: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
	<pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 19:23:58 +0000
Subject: [PATCH v4 6/6] branch: add --all-remotes flag
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
 Documentation/git-branch.adoc |  9 ++++++--
 builtin/branch.c              | 41 +++++++++++++++++++++++++----------
 t/t3200-branch.sh             | 40 ++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 9d4944d17e..5c5b91d9b6 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,8 +24,8 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --forked <remote>...
-git branch [-f] --prune-merged <remote>...
+git branch --forked (<remote>... | --all-remotes)
+git branch [-f] --prune-merged (<remote>... | --all-remotes)
 
 DESCRIPTION
 -----------
@@ -226,6 +226,11 @@ With `--force` (or `-f`), delete them regardless. The currently
 checked-out branch in any worktree is always preserved, as is
 any branch with `branch.<name>.pruneMerged` set to `false`.
 
+`--all-remotes`::
+	With `--forked` or `--prune-merged`, act on every
+	configured remote in addition to any explicit _<remote>_
+	arguments.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 07d867373f..37ea75ecc3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -685,6 +685,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
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
@@ -774,7 +781,7 @@ static void collect_default_branch_refs(const struct string_list *remote_names,
 	}
 }
 
-static void collect_forked_set(int argc, const char **argv,
+static void collect_forked_set(int argc, const char **argv, int all_remotes,
 			       struct string_list *protected_default_refs,
 			       struct string_list *out)
 {
@@ -787,6 +794,8 @@ static void collect_forked_set(int argc, const char **argv,
 	};
 
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+	if (all_remotes)
+		for_each_remote(collect_remote_name, &remote_names);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
@@ -800,15 +809,15 @@ static void collect_forked_set(int argc, const char **argv,
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
 
@@ -816,8 +825,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int force,
-				 int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int all_remotes, int force, int quiet)
 {
 	struct string_list candidates = STRING_LIST_INIT_DUP;
 	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
@@ -826,10 +835,11 @@ static int prune_merged_branches(int argc, const char **argv, int force,
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
@@ -952,6 +962,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int all_remotes = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1009,6 +1020,9 @@ int cmd_branch(int argc,
 			N_("list local branches forked from the given <remote>s")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
+			N_("with --forked or --prune-merged, act on every configured remote"),
+			PARSE_OPT_NONEG),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1052,6 +1066,9 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (all_remotes && !forked && !prune_merged)
+		die(_("--all-remotes requires --forked or --prune-merged"));
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1105,10 +1122,10 @@ int cmd_branch(int argc,
 				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
-		ret = list_forked_branches(argc, argv);
+		ret = list_forked_branches(argc, argv, all_remotes);
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, force, quiet);
+		ret = prune_merged_branches(argc, argv, all_remotes, force, quiet);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f9aca90f4d..3809bfe0ad 100755
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
@@ -1924,4 +1945,23 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --all-remotes covers every configured remote' '
+	test_when_finished "rm -rf pm-allremotes" &&
+	git clone pm-upstream pm-allremotes &&
+	test_create_repo pm-other &&
+	test_commit -C pm-other other-base &&
+	git -C pm-other branch foreign other-base &&
+	git -C pm-allremotes remote add other ../pm-other &&
+	git -C pm-allremotes fetch other &&
+	git -C pm-allremotes branch one --track origin/one &&
+	git -C pm-allremotes branch foreign --track other/foreign &&
+
+	git -C pm-allremotes update-ref -d refs/remotes/origin/one &&
+	git -C pm-allremotes update-ref -d refs/remotes/other/foreign &&
+	git -C pm-allremotes branch --force --prune-merged --all-remotes &&
+
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign
+'
+
 test_done
-- 
gitgitgadget
