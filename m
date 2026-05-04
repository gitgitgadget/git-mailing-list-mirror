Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49313E6DF5
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919256; cv=none; b=ti3WpKGaSMDqdgxPTEF9yQ05Yr9MTvb9OG0sUeFV4QDKsvLl1huFDuJduS3e2e13WBKmZ2HnckSHUUxNxGiNpsC4RoRiFjkII8sVJlPHKDS7GD+XPD1U4I3vwZ42gBavkR1XEcqiLEjkCOHEtvxAqUewfJA5iYR2V8C7BzUOTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919256; c=relaxed/simple;
	bh=Xq5JMYs/KbycyfzBQmLLqx1brraIsRmmWde9t6MiFtQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JPDUxfj1nCXTCeBFRbpc/Ye+MRjp2bJqHocwn0r2CcebbEI+4eXKyRq5qqn0GNgjfnPAueJ6gg4aiii1q6pqCai32RqXw3cxRoUUaRsbwvt2oZV3DUcWa4ph+E4fJqDywozdagN8rjOhL/+ECpqKuCLI/14DDH824B5oAiSKkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8Ymj/xp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8Ymj/xp"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e5c7eb565so45426861cf.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919253; x=1778524053; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6aEazxgRuYP5E9m2TTMm47w8zp11EibiDa5PPmgudM=;
        b=H8Ymj/xp3sFhfjqQ0rKi/+gbAF5bOZ2fvZhYZTOPG/xkPFyVdAZ0alggBRTo9O775L
         NNTMQ96o4d2ofCwzwUWlo/cMzfS00VHxhiucZK42lcc4fDaFyzvC0illgLTK1NfFIxR8
         a52fyHTypMWECBCgVQzHkSwqH84pOlY8qbUh7pOWg6QfGCK9R4siuqvgEV1Z/zMClexI
         AByjVXzvbnvIFXppnoBpmWWJop6M9vdVT9sFV49vfVycaK8KRXsye+yxmITuE76x3oi2
         FkJNEgSOrI3pcgwg4R5N/yQrr4bR24WHXAPKblngSGD1B7vlI86Z3JtR92bhp3pWQWXC
         dvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919253; x=1778524053;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6aEazxgRuYP5E9m2TTMm47w8zp11EibiDa5PPmgudM=;
        b=jAIti+lauE9Eku488Pld+ZLDi3KqbjAS+nKCTCHvdHTgzZtWLTLp0FGDXm4frxDox3
         SEr3jHblDZ/QkOidm3JaXxgUr/wqJF5d7IJehY3Zf9byTABzm8cf0fEQsAHPoGBbfQVT
         nFDzEzNExiNHL721rFT2OPcW5s1i9RSXqWM5trwedmYYaK6ua47nNyXShqZunXpYT9Xy
         XIqXnGS8taJZlN7S4mNMDe0rvyPQWfqXWRCn1Gh2hYAjtTcBVdnn6Emf/3xzVuJQO/H9
         NXnjQI8qVBMDAKjyuOUbHlcQGAx53nN4FB9Ge5BL2HmRjBF6tcNz9Sm51VE51T5hyg8F
         9n8Q==
X-Gm-Message-State: AOJu0YzLJ20Y6g8tkfPGYGkOSnSK1rBz1yIKAD8iMD393xBYLwXochci
	uIysfOB6A4ff9sPmLrCegx82QClruUlXy04i3KBzoTeLrGaxqE5Dy9QuWiSyxQ==
X-Gm-Gg: AeBDies+oaomBbRgKMgOZ5Lhkp0Ags6tIVJYBa+TtHgpQZ1HGGcPs+Ij2wZ7ZnC+Hoz
	FAX/JXKtSJMWPZ8AZmThB1FoksU4UWi2ikUxXYsaljVm5JVxaUMpRWMFE/T5MzQQLqdz3W0PY5W
	bfUKeYODhZpiGRk6AaKDXYssLMLBe9R2SnatvC66BvBCTM0FXQJMIk3SsDtjDCWADIhR5kB2ZI4
	HARG4RScOcW8QXN4upOeY53UJ3LPn41Qj2Szxd8TixYBvq2e7Wh7/NksIZMW7SHuep4tDUeU4AD
	CXLEg5EZcAl74ney2usLiM+sSZHDm/cGX0tzwv6i6CKWkLBQ6TpinWj2+Ppr7zc5UUypJdny3Kz
	bPAJfKjouKCXrtqgJPO1TzY0AFz7LA3Ty1NN6YqVzhTOuJod3Pm3V0oTWoawIP4oaKq5DKaO7Ak
	O1qNG+V956f4Ixmb9UAXTCiwDTgIyqKTD0B8o=
X-Received: by 2002:a05:622a:13cc:b0:50d:8e6b:96ac with SMTP id d75a77b69052e-5104bfebe1bmr159783521cf.58.1777919252715;
        Mon, 04 May 2026 11:27:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.30.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040931552sm103523261cf.12.2026.05.04.11.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:27:32 -0700 (PDT)
Message-Id: <e9f8d06a2bbab155b66e89c467aaeb2f37d808ed.1777919250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 18:27:25 +0000
Subject: [PATCH v2 1/6] branch: add --forked <remote>
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

List local branches whose configured upstream falls within any of
the given <remote> arguments. <remote> may be either a configured
remote name (matching all of its remote-tracking refs) or a single
remote-tracking ref. Multiple <remote> arguments are unioned.

This is the building block for --prune-merged, which deletes the
listed branches.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  12 ++++
 builtin/branch.c              | 110 +++++++++++++++++++++++++++++++++-
 t/t3200-branch.sh             |  54 +++++++++++++++++
 3 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..a79f5552dd 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,6 +24,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch --forked <remote>...
 
 DESCRIPTION
 -----------
@@ -199,6 +200,17 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--forked`::
+	List local branches that fork from any of the given _<remote>_
+	arguments, that is, those whose configured upstream
+	(`branch.<name>.merge`) is one of those remotes' remote-tracking
+	refs.
++
+Each _<remote>_ may be either the name of a configured remote
+(e.g. `origin`, meaning any branch tracking a
+`refs/remotes/origin/*` ref) or a specific remote-tracking ref
+(e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..03b15452e9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -38,6 +38,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --forked <remote>..."),
 	NULL
 };
 
@@ -673,6 +674,105 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static void parse_forked_args(int argc, const char **argv,
+			      struct string_list *remote_names,
+			      struct string_list *tracking_refs)
+{
+	int i;
+
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		struct remote *remote;
+		struct object_id oid;
+		char *full_ref = NULL;
+
+		remote = remote_get(arg);
+		if (remote && remote_is_configured(remote, 0)) {
+			string_list_insert(remote_names, remote->name);
+			continue;
+		}
+
+		if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
+				  &full_ref, 0) == 1 &&
+		    starts_with(full_ref, "refs/remotes/")) {
+			string_list_insert(tracking_refs, full_ref);
+			free(full_ref);
+			continue;
+		}
+		free(full_ref);
+
+		die(_("'%s' is neither a configured remote nor a "
+		      "remote-tracking ref"), arg);
+	}
+}
+
+static int branch_is_forked(const char *short_name,
+			    const struct string_list *remote_names,
+			    const struct string_list *tracking_refs)
+{
+	struct branch *branch = branch_get(short_name);
+	const char *upstream;
+
+	if (!branch || !branch->remote_name)
+		return 0;
+
+	if (string_list_has_string(remote_names, branch->remote_name))
+		return 1;
+
+	upstream = branch_get_upstream(branch, NULL);
+	if (upstream && string_list_has_string(tracking_refs, upstream))
+		return 1;
+
+	return 0;
+}
+
+struct forked_cb {
+	const struct string_list *remote_names;
+	const struct string_list *tracking_refs;
+	struct string_list *out;
+};
+
+static int collect_forked_branch(const struct reference *ref, void *cb_data)
+{
+	struct forked_cb *cb = cb_data;
+
+	if (ref->flags & REF_ISSYMREF)
+		return 0;
+	if (branch_is_forked(ref->name, cb->remote_names, cb->tracking_refs))
+		string_list_append(cb->out, ref->name);
+	return 0;
+}
+
+static int list_forked_branches(int argc, const char **argv)
+{
+	struct string_list remote_names = STRING_LIST_INIT_NODUP;
+	struct string_list tracking_refs = STRING_LIST_INIT_DUP;
+	struct string_list out = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct forked_cb cb = {
+		.remote_names = &remote_names,
+		.tracking_refs = &tracking_refs,
+		.out = &out,
+	};
+
+	if (!argc)
+		die(_("--forked requires at least one <remote>"));
+
+	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+
+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
+				 collect_forked_branch, &cb);
+
+	string_list_sort(&out);
+	for_each_string_list_item(item, &out)
+		puts(item->string);
+
+	string_list_clear(&remote_names, 0);
+	string_list_clear(&tracking_refs, 0);
+	string_list_clear(&out, 0);
+	return 0;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -714,6 +814,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int forked = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -767,6 +868,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "forked", &forked,
+			N_("list local branches forked from the given <remote>s")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -811,7 +914,7 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !forked && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -820,7 +923,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!forked;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -860,6 +963,9 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 		goto out;
+	} else if (forked) {
+		ret = list_forked_branches(argc, argv);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..3e4c8e4473 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,58 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success '--forked: setup' '
+	test_create_repo forked-upstream &&
+	test_commit -C forked-upstream base &&
+	git -C forked-upstream branch one base &&
+	git -C forked-upstream branch two base &&
+
+	test_create_repo forked-other &&
+	test_commit -C forked-other other-base &&
+	git -C forked-other branch foreign other-base &&
+
+	git clone forked-upstream forked &&
+	git -C forked remote add other ../forked-other &&
+	git -C forked fetch other &&
+	git -C forked branch --track local-one origin/one &&
+	git -C forked branch --track local-two origin/two &&
+	git -C forked branch --track local-foreign other/foreign &&
+	git -C forked branch detached
+'
+
+test_expect_success '--forked <remote-name> lists branches tracking that remote' '
+	git -C forked branch --forked origin >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <remote-tracking-ref> lists only matching branches' '
+	git -C forked branch --forked origin/one >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked unions multiple <remote> arguments' '
+	git -C forked branch --forked origin/one other >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked rejects unknown remote/ref' '
+	test_must_fail git -C forked branch --forked nope 2>err &&
+	test_grep "neither a configured remote nor a remote-tracking ref" err
+'
+
+test_expect_success '--forked requires at least one <remote>' '
+	test_must_fail git -C forked branch --forked 2>err &&
+	test_grep "at least one <remote>" err
+'
+
 test_done
-- 
gitgitgadget

