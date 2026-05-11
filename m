Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C03BED23
	for <git@vger.kernel.org>; Mon, 11 May 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492698; cv=none; b=a+tio6CGG7N5kZ4JuHDJpS0Vyvb1msInwILq30tWTtIlplAUhUyVcbBnqRYLYMBieABNWLudVjVTvcR5bYfIN9crPj//MnmFjbLdOW0aZq8ZqSa2KttHWpUD8rUcIf9O/4Pf4BslY8BNT0n8P/ACEehKkVDlkDJ4AUkJ5AnoiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492698; c=relaxed/simple;
	bh=bsPBW2zprvMLkpNQwV1GE8hy6SGkdwl4MIdRfEaITpY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k36W/pXCjMj90trGx+ygrCeWRyuy/GZn/M/svihDIrLKAdS2s8MJ9t5IJSai7Hb/Yilq0CjLWMZ05d+loPRnsTZ3VRRQHyhXrUBZA7uQGUpyQowI9c69ilye7owyLxH/toGfdwGXX7fwokA1SBODjMGq+e+zJLCYiddK6ylPO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI0kmUUm; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI0kmUUm"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso6291097eec.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778492696; x=1779097496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5btTfE1nEFMRlfaUQ7E/YIBxw2kjfzyMERY7EtkcRA=;
        b=lI0kmUUm2598IlRoU5+N3Xh3+5GYezjjZWqqarELUJxYNxRfaqKHwQb3/nVpwYfU1a
         blc/RyAQYYUZq/0GpzG26S4ZSg3c6h13ksAsPj0Z75dZ5ppUnEe/jEo20iKDaQwDoA1o
         +QoQwZgRwfFNDgOixE6E8D8nAu64leGOKTyViLUCepRP66Inrtj/dvT8+q67aUs0vZmh
         UaX2fHARu0JIftEOnsQxnxOM4vzj8iGY/Ku7ZmMO9Aw4YasgShkDX0F6+P6sJ6GvaAek
         bIlIGi8eEKMGtja7L3+mJgTEkBpyPpwKbv4erQ3UfJkvXibSPyH/8rdKY+CnALX9Jir2
         kz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492696; x=1779097496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5btTfE1nEFMRlfaUQ7E/YIBxw2kjfzyMERY7EtkcRA=;
        b=sMBXJl0pTGza+iqaLXqblFVQi3CfGHfAVEDsQqQb09Lzfr4vLs7nFpxmtL58el+snm
         XwdMk++CKVcsnrHE+y9eXV3DwlO/nNqBOntTQccFhi2+f8GpnrawdqJ36Wli/Xm/vJXb
         JDQsWHULhAwzuPI4D2+6ZhY9bui0bGi4sQja/d9i/vTiIu2O/On7egc6cB4wdAMGS3iY
         iUkb3SYX5FKe8t/FeemwUlTA1VrWIVKqjb2G4O44bYDIj3ixLDooBYpUcdYO+UgAhtZz
         d2c+AGQ4+cz1jvap8ODVnhpa8zYNG+6rMHy0/QIcW+oo/WoUhJxJJOE/7dDZtN8cWwyh
         D+gQ==
X-Gm-Message-State: AOJu0Yw5s5q2O+acKg5PVDVEP01qUO3dLABe/77WTdnnpL7Nxyn0L5WU
	1qWBVlM4BaEapR/4NtKO9Tv2Gtw2H3s5DkFgLt7htO6CivWIcAvz86jId+Z+TqVh
X-Gm-Gg: Acq92OHidfRi392SGUpFc6usFPMTaKXe7kYM0c8/po70Os7y3L2VL6biDFBo9oQMxgM
	EK9qqN+zzB4e8DFjLWH2zBDMlS92t98XPYjUdTtI31LhGMwuARZlnXgQ/p/tO7ZLppNqXGjGoKU
	jnQIMXHoI2c0d2by99kr9SwiQ+3T2zKMBZuUmUbXmviwd0EDdjMLc6fIoTCgzpIVlgsWt/BmPEp
	Isw4D7nAXzcUTLEWYT4w7QKvxqEGVe/4MS1lXRbvmbB1Kt0zyruMssh7yNoobv7RoW//NNstOiQ
	JY0aJGE8WJu4FCzg7oY0WPNpTQXnItm5Eb7wi/+nW3kBULDBu0O2BbSOBYt6Yuzby4iuy7+yMl9
	iLdv+B6pqwj/uD6aJmEJdEvhgbHyGBDOUYJhRaKVnn826akbBo5VEKnyQy2wzgWsoiUvrbUGEdi
	klY93NWA4yO2aERN2q+oXn1ENIWVlr9Gqx4td+fIk=
X-Received: by 2002:a05:7301:1f15:b0:2bd:c285:2fe with SMTP id 5a478bee46e88-2fb3e2cb7f7mr3817345eec.9.1778492695691;
        Mon, 11 May 2026 02:44:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm13161151eec.2.2026.05.11.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:44:54 -0700 (PDT)
Message-Id: <fb9817b220f3b5a55a507decf85baee38d430f3f.1778492691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
References: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
	<pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 09:44:47 +0000
Subject: [PATCH v6 1/5] branch: add --forked <remote>
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

