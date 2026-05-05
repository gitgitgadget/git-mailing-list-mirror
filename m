Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566A357739
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965753; cv=none; b=rdn/VBA7tRLVRnJZqk2B/kuvOsiA7J2C3FfV43cB4Vpl3T30mW72zYsdhIGXkShU7Wus6iYO/Ztch7K6qUNJxGurDwBDQ1urNIWgiw3zt+pr1OHHbp57HVKPvnxqrJfbb3IuQRzMHkgUKNnWgWAjUFHf2/pfw9Yz7SavAhALJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965753; c=relaxed/simple;
	bh=bsPBW2zprvMLkpNQwV1GE8hy6SGkdwl4MIdRfEaITpY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JQxgbjN1/ejKV2M2ueky+RiT33W93KNJVDD6NzU6VQPh6H1nv/ZSEIMh1YDgs10hsbCE2cCRu+CTRNIsUidpX7+0TBlJZeu7MqFpQYZXuEq1tZSs8XWyHDiPv0GDbFgye8AeC06yn2ZtdBQsRWjoP0DukwnTyREUxCup1LfmLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNX/wi5A; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNX/wi5A"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b81586dff3so30205086d6.1
        for <git@vger.kernel.org>; Tue, 05 May 2026 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965750; x=1778570550; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5btTfE1nEFMRlfaUQ7E/YIBxw2kjfzyMERY7EtkcRA=;
        b=TNX/wi5AKolpemoZytICwqRuM7jRFJgC9ya0ONnvldxfx497XjxtQBzAdB/5JsTkVJ
         SUj4aIzoAkE8GwnKmOGPLGsAcv6tU+P09PZLxlTJ2u/YeEjuKXiFw8qE26K9OXxaZcPQ
         55qZyo7FR//9GEzIhnZX9QSYHbGK65F2TP9pzt/endYCMp9ExyQKdr8eCX1dU9C0KJLb
         hG+ozsYnDARkTLeZ+7mAGX88ojF4vw0AVnV22+l3sGhD6XREJncvvxh4ncEqwiml5zef
         DyObXzV6+wGYgvWZpck6+e8CmJZ3amU0KgcTsNXE2K54GVjcMI1K6B+ujkfg2P1pbbqt
         PcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965750; x=1778570550;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5btTfE1nEFMRlfaUQ7E/YIBxw2kjfzyMERY7EtkcRA=;
        b=FW9Q/aKqHKO/k5c7Rtyfy0YkynHEQRHAhrUuHksC6zgnLiWOA/4Xm0l7aZPah/4LgA
         Tb9lEWLmvUL3o7C6mfvx0hqi5+mtxQyomr24maSjcEfmdbzKSAiteH3wCU2/okDPtP7u
         DwqvXM7c0ZmP8dm0AZmsj7eRnhBZ5MdlENusw4OftTJX3KPCvlLWFknbstoQrAcFeeX2
         4hsAKQjO2xqH9MRLmPC8ZC81vVwZHsW19IlWfxqa6ZuzCFqwDj02Y12CL81XCNWA3sXI
         m3lxqgV/Cin3iyCI5Gah/MlpdN5kI4bDeW41hgfXzhmiWN//xHkCNysAj+yy43FGLX8x
         KRdQ==
X-Gm-Message-State: AOJu0YxEjCs6hc9mbixzMYVFjRUY3lcZF2lzdEzXVkIhtuFvhM41q8f5
	QG1TilWnV4QWqqQXWnPLjTdXgAnR4LUhDmXYopluMpEP8ptsENBkEym57SAXCA==
X-Gm-Gg: AeBDietrsRlrY1V1GfhJlLIO/tIRaIp5CYygHSzbt/iOHVSVeYUQz1fKaoiFXwJEQN2
	lddd3bB0jcS6i1kzyn8LA7GsxyXiQnUjOwFIDd6WMIbpunc9W+QEb3MGu4GJFASRpuEBJa4JdGU
	IqixnDXmrlSo1Den6fDMH9aXSeUlEWx/NcV9ArwhTrijcvgYV9jGiyJecZ5lqRi2+4r/Be1lpiO
	QvESz/qZ2O/GvxzRy52t6zUCng7xeAcCyepxj33OxuLh26G9E/rwtlXEvvQDtJ53ZG5OrPM5l4T
	05P4UlmUqvUJD45BJoTTtRRcsfXq5KDRnJIYVcr28KkxNqFS8zGh7R2PcS4WzagiD6mgJYUmJBu
	jwMA4mhhNPtYlXSBHvA4Q65lQxIR1GA22pxPw2i4fgL/bQ6XC1DwLMHpXQXmyqeUTVsJfVgCE2Q
	7bq5ZnI5juSii0FZlpKTvME5DQlowjFljSXL1Q
X-Received: by 2002:a0c:f002:0:b0:8b7:e680:95d0 with SMTP id 6a1803df08f44-8bada808b49mr27202536d6.14.1777965750259;
        Tue, 05 May 2026 00:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8123sm138994426d6.35.2026.05.05.00.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:22:29 -0700 (PDT)
Message-Id: <77e67d4b8b7da1b982b384c5ad6044c5637e161f.1777965747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
References: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
	<pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 07:22:22 +0000
Subject: [PATCH v3 1/6] branch: add --forked <remote>
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

List local branches whose configured upstream falls within any of
the given <remote> arguments. <remote> may be either a configured
remote name (matching all of its remote-tracking branches) or a
single remote-tracking branch. Multiple <remote> arguments are
unioned.

This is the building block for --prune-merged, which deletes the
listed branches.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  12 ++++
 builtin/branch.c              | 110 +++++++++++++++++++++++++++++++++-
 t/t3200-branch.sh             |  54 +++++++++++++++++
 3 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..5773104cd3 100644
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
+	branches.
++
+Each _<remote>_ may be either the name of a configured remote
+(e.g. `origin`, meaning any branch tracking a
+`refs/remotes/origin/*` ref) or a specific remote-tracking branch
+(e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..b3289a8875 100644
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
+		      "remote-tracking branch"), arg);
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
index e7829c2c4b..24a3ec44ee 100755
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
+test_expect_success '--forked <remote-tracking-branch> lists only matching branches' '
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
+	test_grep "neither a configured remote nor a remote-tracking branch" err
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

