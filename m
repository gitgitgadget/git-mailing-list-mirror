Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663D3E715F
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919263; cv=none; b=B47lngEYioCa2zQs6vmOkiHJTVNH36PkfOgx9w77npoCQ3trlYJjypoZ5t0VQrBC7QCx6yQekq7nsQABypHW5F59KMi5v7W8JKqUdbhNEuuvl3ksV2DIwJfMMMvwLE54PjuFybPZOpe+j6Qy2x6dFGEcfiTESE052GkDP0NkvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919263; c=relaxed/simple;
	bh=spy1j0DIMe5ech66haeHbKRj9/CRqke8gpQK90fzeSk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZYOnfrGdQo1TteFcH9Bae6dM4KswTADhQW0ie3yPdIYohhMvInjUGl1CMrQ2AipvZf8V65TYq3/CNkbp9pGW690WEaNxMQ3vwslcoTQS6OWD/MW8cJoB/FfzmtMZcAWHnOrzgpy5ZNw4vodLwXkCeD7lEUkPBTEzIfW01NN8DFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ3TvzQs; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ3TvzQs"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso47534261cf.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919261; x=1778524061; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qXYZLB+bil8HDyvBqdj37BchbyvYJLqFOAsco5zUnk=;
        b=UZ3TvzQsrz6P+w2SlkvLPHfss+DQg2auWMYmXu/INAp8pypjOYy+y9VPfcEZJHkUDv
         dixGKJounloWMCNKahBIKI0pbexMN12OFwa0YJK+ZjbymJ+92cvEUxoXiAPwVpOEpTxF
         AGIhZIbEC8UllaYWwnGfJ52cz7O98MFSWvhENRMEVE7GcNgGIZtdgw266VR5ifS9iVkY
         3GLo1dueldXwkSfMLw2d7V22GFW3GQXwi575A+XQw7vw0JBQPIcDrZQMlpd/bzgN3Xbt
         m48xrCVknvV114UsPJsPgnBrqV3LnDQYjZduNB4ajx/wCvLqgl6IHhw77jZ6EPZBJVvc
         9Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919261; x=1778524061;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5qXYZLB+bil8HDyvBqdj37BchbyvYJLqFOAsco5zUnk=;
        b=oOoytb/smIXSFyVr/I0GNKVAUyXhogeo0DuwLtHaiDmXDYAQi2qpvtIv4VeAh1vWjl
         bg8YL/G+2SAKHOXKk1Zdi7jMO8WdKO15jIeavsZ28E0MW06PCG+a9R4xoC37JWiCIHu7
         gR5of1GgHTa64v/a+mxXlrgnXH3r0PVLOYskp/Z8UDKqh0mzOkkdYakqSfZyoPMsYiA2
         yoRAePgPti82SuuzjNVJIsQM/LMpNhcRAoMaOtEtLcOrtkcYMYHw2TymX9SBRv8v7GO9
         enJ5SI22NYZtMudUTVzoYmmD0FIZTi1/IV44Dpu0wf9Z18gtTgmArFnQ0IMtqLWo4Il0
         YJ7Q==
X-Gm-Message-State: AOJu0YxQ9y16WEkNhvLb71YEK6qTx3XSW4/NhbJdlX/Z5dPURL2iAA1i
	8TnmMWXYQED4HFu8JXalUB6m31clpNy7ycLP4UEWk5Ge5PTKoT3cTGakmByM2w==
X-Gm-Gg: AeBDievthpD57LT4hQs3ycDFgutMypFLrteR1SHJ43NqO3H3CPwNEaG07Q2UirqB6OU
	iUh4QzcS31go4gNKtwzdZaYHrEGJdPsWwXRIdOnp/A5HjPTyiPpcNo68bZXgkqAqa2a90ve6AgJ
	arlYBLK3+uoD47i8ke+brtvP2MeFt3rxojy+3aDuwCVBkWctv1LFK3bS5OjtcSP14nxjwzrw1iy
	t0NcpXpVDKq1gTpmt+k2HSQNNqGWHo+tNA6+nRDSjxWGrxUYhtaY6CGNqB5BhoXkPGJo4w/UEMW
	rxPcyAF5V/pjdF5GArFE92HfIUQUaoUCSHxE/Je4SABWcKtmswvWM+LvwID9bLsOs7CPoYz0nL+
	FUOcHDh4MuIDKvh6Ub9vpTRbwiJy8qW/CuqjfqR88wFbwaFf0jvQOHul/W+dpOdkNrN8eZkuVLg
	Jw3Pe7kteIn7oUb3VkM8mtkUM4dz1gx22qUYQ=
X-Received: by 2002:a05:622a:110e:b0:50d:9f33:9a5 with SMTP id d75a77b69052e-5104be3aec2mr160988601cf.23.1777919260473;
        Mon, 04 May 2026 11:27:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.30.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040ba8acdsm105901861cf.31.2026.05.04.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:27:39 -0700 (PDT)
Message-Id: <66dac9762638d6d62be7beec518c3b4d45c74955.1777919250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 18:27:30 +0000
Subject: [PATCH v2 6/6] branch: add --all-remotes flag
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Combined with --forked or --prune-merged, --all-remotes acts on
every configured remote, in addition to any explicit <remote>
arguments. Used alone, it errors out.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  9 ++++++--
 builtin/branch.c              | 40 ++++++++++++++++++++++++-----------
 t/t3200-branch.sh             | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 8d3e13d785..87efdefccb 100644
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
index 74c8f1aedf..3d70357cf7 100644
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
@@ -754,7 +761,7 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static void collect_forked_set(int argc, const char **argv,
+static void collect_forked_set(int argc, const char **argv, int all_remotes,
 			       struct string_list *out)
 {
 	struct string_list remote_names = STRING_LIST_INIT_NODUP;
@@ -766,6 +773,8 @@ static void collect_forked_set(int argc, const char **argv,
 	};
 
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+	if (all_remotes)
+		for_each_remote(collect_remote_name, &remote_names);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
@@ -776,15 +785,15 @@ static void collect_forked_set(int argc, const char **argv,
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
 
-	collect_forked_set(argc, argv, &out);
+	collect_forked_set(argc, argv, all_remotes, &out);
 	for_each_string_list_item(item, &out)
 		puts(item->string);
 
@@ -792,8 +801,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int force,
-				 int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int all_remotes, int force, int quiet)
 {
 	struct string_list candidates = STRING_LIST_INIT_DUP;
 	struct strvec deletable = STRVEC_INIT;
@@ -801,10 +810,10 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	int n_not_merged = 0;
 	int ret = 0;
 
-	if (!argc)
-		die(_("--prune-merged requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, &candidates);
+	collect_forked_set(argc, argv, all_remotes, &candidates);
 
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
@@ -911,6 +920,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int all_remotes = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -968,6 +978,9 @@ int cmd_branch(int argc,
 			N_("list local branches forked from the given <remote>s")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
+			N_("with --forked or --prune-merged, act on every configured remote"),
+			PARSE_OPT_NONEG),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1011,6 +1024,9 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (all_remotes && !forked && !prune_merged)
+		die(_("--all-remotes requires --forked or --prune-merged"));
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1064,10 +1080,10 @@ int cmd_branch(int argc,
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
index 2127cf1fa5..fa7570d178 100755
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
+	test_grep "neither a configured remote nor a remote-tracking ref" err
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
@@ -1892,4 +1913,23 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
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
