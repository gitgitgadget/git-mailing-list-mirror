Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB61367285
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574246; cv=none; b=oaWZjTzj/9/70l5KNXy2aAHNHU5iPtPiLrOOq8eiOj8cgIGoP372IXkmr69EigGbatHwG44sTikd1//uxpvxgNSE1Om3AIrimkrNiYUc98rloFw6yhiREk2nIhosZh8q103KV84QCMUdvk6ekaSaqTh7taxPoPX4Rlcfz997J1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574246; c=relaxed/simple;
	bh=fRbGcJkna3WVT8cAG+1t+/PbVsqDVHWtC9clM2iFb28=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LQjGoyQCfiWqiPBhCbjTFDjjOQX9BOTUK8PWvmAEyqEo9xvTiY+g4wdxW+IhcV71Nkuelu39jaE9hCC3jPvYn7dnemTSDI+9Lt0DtySZjtazfS3zpk9loS+MZhOPtxjaLVpqD5nIyB5EBzuVXjMdWuMLJ84F3/HZCzIUiJi+r1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBpWHh5x; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBpWHh5x"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e614fdb42so40985771cf.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778574240; x=1779179040; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B55itX0s1Dc/F5Jfy7OiV+GsR1BremCzEsivkTeRgsQ=;
        b=hBpWHh5xVnBGWVk+MAVGSjYlO0prhnBLrrlFNk7qr3bbQOZpvXs4RGRM5wvDn+XYOW
         cmK7fEw9q6FG9iWtE10FdmwHwQyt6uwcYUK5jYSRq8VYXDTYl8o4HohORFEpXF34F0IV
         +6EpsFIF+o7l6iOYegikrjp+eZMIPNTU7w/UBkm4cW5Ms5yCGbyKbONVQNgqjTeAZ1Rz
         2Njbdpepy3QM8emodTQI2hXTI+xrkZ0gHCFWE2Z/jpMNBkWJEOjV60eFlIOieIKCPE32
         dEDvfACcClXPm7so3/yJqmgXWOZ9E+HxNKoi7rwhkFs+ZajrHd1qYsLuvib66cBsx2uu
         dFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574240; x=1779179040;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B55itX0s1Dc/F5Jfy7OiV+GsR1BremCzEsivkTeRgsQ=;
        b=HA3XFEFtVafEoWu1hZ+HGJHL++vl7fTmbhxEr4A66A+ZQTZuSpf12QiI8Vs348jeug
         c9KEETK5K2u0gdTocUKE9BP7bQynINhZb2kqjxWV+yzho/hV2ZKq3xPmc37sOdZFTSvU
         zFRNjuPmLTjoPaMuNi8mcIXuIgUssIWl0OpOrbQ/8vHSFq6tgvsXYQOHJzMA3I+KVFZD
         NUgaBapdae08yS+UX6d62W+mKnPJAS5Y6pSE+dY2UqTeRxhBbDxmlovGjeSv+XqsFtgG
         GZTyKy2ZxtMPDDal3hzWrVY/XxEmL6IIXmpXrY/m/bFl+o85bzvLaNBOZY4CZy15CgPl
         FRDQ==
X-Gm-Message-State: AOJu0YylFilKeLy3MQXiISnhsqt492IOW+CVr6OoOg0D2bFcKUyxJraX
	IDRk6o3chDep9zLt7B0hmktk9418TiEKSn2+FbiXbTvDWHW4X3pFR1NSlXsvLw==
X-Gm-Gg: Acq92OH+vaAJo0vG7FVEfkVaKja7u53ecLn+RD5H87VsNGoVKCOFeMfmv8tL90ITHWm
	kNxs0SFeIKeYvqeXFcLMDu0UY2YoXYP3z61n6Il/UWXlPJG0pSawV2WLlaL9Td9rYhRaLCfvMl4
	eMDu+8nGlIk/tWkLVhUVlQnNUugno4VsGKEHReNq5o4GdmCa5NPZHPW79RDMtZ/mYepEiQRRRIA
	N2P5fPO3gUmUuOvTkFmjvfxGtbhSd0OblPadWEw0oGiPS2ajbHgkpc06y425cJMDXQDAP/ovqgG
	wipr0b18NvAZ31osYcrwPzo00OoM2veYnBQOTHmOP2w7IHYarmGV3ga3qRHmETJJNfpu3zxVBlE
	TjDuILRk/0tzZf1pL0cvDpZMs7Wrc71KLa5AAjBHB2WaokGfpx+ax7KfcJHVmvMmIIMNEQBkeWw
	hPdD0MbHRxxQsw+8nwh7LpqCKw
X-Received: by 2002:a05:622a:424a:b0:50f:bb01:985e with SMTP id d75a77b69052e-514a0b81971mr188829921cf.48.1778574239881;
        Tue, 12 May 2026 01:23:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3f4fsm111497491cf.21.2026.05.12.01.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:23:58 -0700 (PDT)
Message-Id: <f79707ce7c6a3c5cd5308c4e3c43b52cfa585b2a.1778574229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
References: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
	<pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 08:23:49 +0000
Subject: [PATCH v7 5/5] branch: add --all-remotes flag
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
index 87a26da0cc..6fde8f642e 100644
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
@@ -227,6 +227,11 @@ With `--force` (or `-f`), delete refused branches regardless. The
 currently checked-out branch in any worktree is always preserved,
 as is any branch with `branch.<name>.pruneMerged` set to `false`.
 
+`--all-remotes`::
+	With `--forked` or `--prune-merged`, act on every
+	configured remote in addition to any explicit _<remote>_
+	arguments.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index c48af54301..22c30164ca 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -715,6 +715,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
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
@@ -804,7 +811,7 @@ static void collect_default_branch_refs(const struct string_list *remote_names,
 	}
 }
 
-static void collect_forked_set(int argc, const char **argv,
+static void collect_forked_set(int argc, const char **argv, int all_remotes,
 			       struct string_list *protected_default_refs,
 			       struct string_list *out)
 {
@@ -817,6 +824,8 @@ static void collect_forked_set(int argc, const char **argv,
 	};
 
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+	if (all_remotes)
+		for_each_remote(collect_remote_name, &remote_names);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
@@ -830,15 +839,15 @@ static void collect_forked_set(int argc, const char **argv,
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
 
@@ -846,8 +855,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int force,
-				 int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int all_remotes, int force, int quiet)
 {
 	struct string_list candidates = STRING_LIST_INIT_DUP;
 	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
@@ -856,10 +865,11 @@ static int prune_merged_branches(int argc, const char **argv, int force,
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
@@ -983,6 +993,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int all_remotes = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1040,6 +1051,9 @@ int cmd_branch(int argc,
 			N_("list local branches forked from the given <remote>s")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
+			N_("with --forked or --prune-merged, act on every configured remote"),
+			PARSE_OPT_NONEG),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1083,6 +1097,9 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (all_remotes && !forked && !prune_merged)
+		die(_("--all-remotes requires --forked or --prune-merged"));
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1136,10 +1153,10 @@ int cmd_branch(int argc,
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
index 23b82615f5..4bd92fe430 100755
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
@@ -1957,4 +1978,23 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
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
