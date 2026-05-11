Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11C2D5922
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482722; cv=none; b=eqM5Af3gY155404F2KkTJSP+hZh5PNPpIPtJPCx2BeaiyWC3ZZ+VZiPcGWjcrC4X3Io2XCyxQ2qG2BxdPTW71HYyZsbLgEHLhfM3r9fXsRlg6YqVwioySU913gwZpKqF3aXacJGLbLQP5wOXRiRz4pYbnQynXBAD1T77qMZpX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482722; c=relaxed/simple;
	bh=E6Jgf9yv+XaGFbd4hnCDUgZJ3INMTqSJZr2ObBnRp9A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ky+rhQbaJuJCZwrrWSXZYTpuvHRZopfm4OrRRLYIW8AmHBsFn5ybXzEN8wLWaYq90G6D7/cbbiHCPwKw4LLQ9LvhWxvViDB91ZYhD+sYpzKXDkhkPEQ6ZkpMxuxEt1NNGJP1v0M2/4pYV0FXYXWK1rb4iGtt2Fvsu9hTCUxzKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltGfhvg2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltGfhvg2"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cbc593a67aso357927085a.2
        for <git@vger.kernel.org>; Sun, 10 May 2026 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778482719; x=1779087519; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBneQqXE4MQuQ3UtH8wZc28rmakyDLMxkB5d9YCxxvY=;
        b=ltGfhvg2pYLe1fBAwyoZk88/vHhMoupFv81sQU8DEWt1m6lyI/IOojg02MSs3Um03n
         QckcXldNWdP+E11yQPiCRtdPK0aukLc6SiMU/Lcw+v8fc1f6DwDUadKHVRkq2ZgckfN2
         yDv1T5V0H3gZLMMAYKk3A4iQ7urZrZoNw2fJsN+ISO7iF+u1cjQsQYexsGeagftUWT7w
         MvsGiWDgyyTF60nyj4rBRiyEWB41XUv8nu/wXtW+uaNl+g5yP4Dkg59RXjLLPo85KdN/
         QsnyZagBEf/uo6kPOPzCPFCQ0WCANAouCEu4OPh967NHGXlBDOGrqBak7mueijrwAfEC
         EX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482719; x=1779087519;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBneQqXE4MQuQ3UtH8wZc28rmakyDLMxkB5d9YCxxvY=;
        b=jWs52Xun6ctLOydjCzL+UqXSFygYb8aQNKqwnLlEEj6rlJOuxK1o9bt9y47M0+YKhB
         AqMkZ05KRciPNPnCuaDEcS5NO+TvKBK2IoXwnnHPX8OUiAK0DVO1DT5oslLFnjZ5lY3O
         IULFzbWRvJdhr4cNPGm+SnW8qONIr55haITvPvafjv4eyYZD13qhFawUgDTuWQGluUlQ
         YMNB+nFvoC9QTnF0p0ZoUBA79IDBStgMX7FKOBDcuE+KXKV4nyg+0wWDQpX9EHw1Qsm+
         sB8+MIjjVUXuKc/67wicQIWoj4QldRhgqh/F/nBZ82BHY5v+ToioQsVDFr+0CKnpZN5r
         mvTA==
X-Gm-Message-State: AOJu0YyU5Z5DEbx3uPS6ostTsYEOEiGQcxsJ0zzZsPn10lUoBEc+S0mx
	1ODIi6Zui3N1KStufjFHtuq2GauiVAf1UsZ3owhxC/QfpTCnsmdkCs3ka8nWmYk1
X-Gm-Gg: Acq92OFK649PBX+GDG9pUjcUBmmHTyDEsc2r4+PxWenKEObvR1X3T903DE0UHatGYt8
	PkWxSDI0eqp5DL1D3g7DQpH8n1LaluoItpaf3BF3GvIhhZKyGQDZqmJzwp7BJ5h6WkYIDgytXgi
	LMGXUqs6xpDlUYawMVCIYPf/1kjz7XFu2ohA87bGGixPbnXpNlu8zYgov4gVt8Bug2IqfgAPFn7
	E0VzejLuE/LWssSYhmecxyuvxCS8XgxeduXci8Cvxt6076w4a8jR0kSKgu1kscfm6JUPmDXJyxX
	hWopIM1jRMSDJIv0O3u0Jc7BniEST2V6H9edQdKBVG1NnTT0VZJzjMZYm9wB9pvwJSqRfEPDMCi
	5rr/jk9gvqNn1BHodOm1H6qXktxWou/XFyDssh745LHCvnkRutR2zch597bQvWDwc/wyQkquCBs
	OfEgMIeJCmlQ4vrKJC6pWtpBOHQGA=
X-Received: by 2002:a05:620a:2906:b0:8cd:b2e9:7f6f with SMTP id af79cd13be357-9090fa77985mr1230404985a.33.1778482719259;
        Sun, 10 May 2026 23:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.236.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd7dsm2993264285a.37.2026.05.10.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:58:38 -0700 (PDT)
Message-Id: <f2cee8c79b1ac3111410309c262283c645a1aae6.1778482708.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
References: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
	<pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 06:58:28 +0000
Subject: [PATCH v5 5/5] branch: add --all-remotes flag
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
