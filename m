Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176F3D6465
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965757; cv=none; b=Vw0pM5PsGild+kgXxBr/xE5eKT7GUU2zhqq94CAU3QfEoK0Q7RaKZxHhtWMqinUpLR6tOQ42TneoGTP2Pkpbk/zutcd/t5T0MU8TuzTmUroP2gh1SMABf/1nY9CaPQJz1MBt9agxsKHBhdDj7mXtsibfsjttck33cSijihypTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965757; c=relaxed/simple;
	bh=Ilh3Mb3uoxV6vb0c0SdV8r1r6zbxNuD1o6dt36wgQcE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I7qjVSZzbmlJQguoG1Eye2CuizUFEwS/GF8GAXeo4FsY3cDP5vuBCmdX3pcmbQhbwpjkFeFMzQCfKCoF+dS0GUh91xmNyKPi7osVX66mOhQZpGRItow0ezAghzRZgKQfpIZduo4AqlW5n8OUydophassuN+ymKKoSn5hSB3OEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGDipwcL; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGDipwcL"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so45221486d6.2
        for <git@vger.kernel.org>; Tue, 05 May 2026 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965753; x=1778570553; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU4dxBFnPoHYAZqLsi2fNuRJHZ+shQgsjrZLFWnhMaI=;
        b=JGDipwcLnjRI6A7pFLxbAbp3XJagfk8trxFN7LnIe1iQah4i1aNl/V254M97yWUaWx
         /1W4reOcwkfZn2BKDC9hTWv2Jv8MrG02AhoEpFlMeyJ6dAea8PjpuFEwo3ga3FGv7Oud
         K/kf/yl8/Efevg9DOHs2OtM/aXQvO9DzEMmQd40ojCwI9PVPZKRNLYHTCCJ83QLCYp+W
         cfiSvqjp9hRo9LPunBjMd4l7jvoeOEa8kZa0b45XHV2nHtcI9GO9lUESnvt0odc7i5ml
         TbeLzpgOof6HV2qFboSo+gEdKZWtYPlcJD3Iso7LvpIKHpQLeaPHadup5zqk7Kj2hTDp
         oi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965753; x=1778570553;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zU4dxBFnPoHYAZqLsi2fNuRJHZ+shQgsjrZLFWnhMaI=;
        b=SW6t30ji5AfSFeYXLfVGaFErzAUzfkgjHECtJkUulVn0KAks6uDx3KYuofR3ilgJeo
         xhEP/M65WJZ9Bwb6Ekd/yCc1PdD81raZ5CMqm+awUkAtcQvS13UhRMlSV0sWful9jCHA
         myjLDbPwtx9V3oTuRH/xh0N0sf8DXOqXPWzEye94GSNcTvzLR7x/jQsLO+E9Z/zcun6W
         9JdAVI8TYAcvTkrkxkAdBuIYkIec7OVAzFP4mODWecQagcQB7Iu6YtIvcOcLq+qIIEVz
         wkf2SX8UHbWX914556X5i+16IryITSOYBaU62uRbAHqHQosznI4msaNFLMyrCYht1Jmw
         18zQ==
X-Gm-Message-State: AOJu0YzdQNHxfpJEgjma6AsoxwbEy1sSGf9p719VraUKt3VUkS8DXraI
	fSy26Do4jetNZUCZc4gdGvZ03E3nHVqCeQDK8g/Hl4hwlQirXhV4nRZ585Ehk/Q3
X-Gm-Gg: AeBDiesaKy2rNe0JnKrEjKe8F2vOl7v0ycVq5IjGh51J/3wh4TOegXpvYOJmVcxVbxJ
	n1ojwTgX+ALbxJSP8N086rEB3DMKC7AXTikyuDupGRgE9TyTwOaWAVEEgUh5aGpgesHTAfJNxB7
	he5prP3nycySRGsz0AJtSIgRsx6mLWO0EHtzTQ4Cexpy0p/lxindDqMeXiWswdi0K8tru3qmlxl
	O+nnRQ7AB5yjeYssLnCcEMvFsLIjjRzG/uv/v9jZwhK2z0C6/2uDjoOakk83zHh++jkoY94n2jt
	GRDb0ncl1L0tHTSrFS1aAI9SI/AxMv1yuaARRoHQCkbptLmg4PjJca/fIq6W0rT0Sebm+mm1cs5
	vUjOZFFaqOHJXRmjPap1+cxAJpnmHeJupo0GdzFudzVTqP1mxqWh85MEhRThnXBxjxBFRR3/DRh
	f8VqBmCK7K+1umP2adVp0lsMWL1sjihYUA/l6s6XB8aH8bihQ=
X-Received: by 2002:a05:6214:260a:b0:8ae:5f40:a135 with SMTP id 6a1803df08f44-8b668a25ac8mr223976646d6.39.1777965752863;
        Tue, 05 May 2026 00:22:32 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm138944446d6.47.2026.05.05.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:22:31 -0700 (PDT)
Message-Id: <49dc8534037937e1a7f73fa06d3dcb66675c9ffe.1777965747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
References: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
	<pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 07:22:24 +0000
Subject: [PATCH v3 3/6] branch: add --prune-merged <remote>
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

Delete the local branches that --forked <remote> would list,
refusing any whose tip is not reachable from its upstream
remote-tracking branch. With --force, delete unconditionally.
The currently checked-out branch in any worktree is always
preserved.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 16 ++++++
 builtin/branch.c              | 97 ++++++++++++++++++++++++++++++-----
 t/t3200-branch.sh             | 81 +++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5773104cd3..80b20a55eb 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <remote>...
+git branch [-f] --prune-merged <remote>...
 
 DESCRIPTION
 -----------
@@ -211,6 +212,21 @@ Each _<remote>_ may be either the name of a configured remote
 `refs/remotes/origin/*` ref) or a specific remote-tracking branch
 (e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
 
+`--prune-merged`::
+	Delete the local branches that `--forked` would list for
+	the same _<remote>_ arguments, but only when the branch's
+	push destination remote-tracking branch (the branch `git push`
+	would update; see `branch_get_push` semantics) no longer
+	resolves locally. In other words: the branch was pushed
+	under some name on _<remote>_, and that name has since
+	been pruned upstream.
++
+By default, the local tip must also be reachable from the
+upstream remote-tracking branch (see `--no-merged`); branches with
+unpushed commits are refused. With `--force` (or `-f`), delete
+them regardless. The currently checked-out branch in any worktree
+is always preserved.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1941f8a9ad..d3ca320d4d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -21,6 +21,7 @@
 #include "branch.h"
 #include "path.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "column.h"
 #include "utf8.h"
 #include "ref-filter.h"
@@ -753,36 +754,101 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static void collect_forked_set(int argc, const char **argv,
+			       struct string_list *out)
 {
 	struct string_list remote_names = STRING_LIST_INIT_NODUP;
 	struct string_list tracking_refs = STRING_LIST_INIT_DUP;
-	struct string_list out = STRING_LIST_INIT_DUP;
-	struct string_list_item *item;
 	struct forked_cb cb = {
 		.remote_names = &remote_names,
 		.tracking_refs = &tracking_refs,
-		.out = &out,
+		.out = out,
 	};
 
-	if (!argc)
-		die(_("--forked requires at least one <remote>"));
-
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
 
-	string_list_sort(&out);
-	for_each_string_list_item(item, &out)
-		puts(item->string);
+	string_list_sort(out);
 
 	string_list_clear(&remote_names, 0);
 	string_list_clear(&tracking_refs, 0);
+}
+
+static int list_forked_branches(int argc, const char **argv)
+{
+	struct string_list out = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	if (!argc)
+		die(_("--forked requires at least one <remote>"));
+
+	collect_forked_set(argc, argv, &out);
+	for_each_string_list_item(item, &out)
+		puts(item->string);
+
 	string_list_clear(&out, 0);
 	return 0;
 }
 
+static int prune_merged_branches(int argc, const char **argv, int force,
+				 int quiet)
+{
+	struct string_list candidates = STRING_LIST_INIT_DUP;
+	struct strvec deletable = STRVEC_INIT;
+	struct string_list_item *item;
+	int n_not_merged = 0;
+	int ret = 0;
+
+	if (!argc)
+		die(_("--prune-merged requires at least one <remote>"));
+
+	collect_forked_set(argc, argv, &candidates);
+
+	for_each_string_list_item(item, &candidates) {
+		const char *short_name = item->string;
+		struct strbuf full = STRBUF_INIT;
+		struct branch *branch;
+		const char *push_ref;
+
+		strbuf_addf(&full, "refs/heads/%s", short_name);
+		if (branch_checked_out(full.buf)) {
+			strbuf_release(&full);
+			continue;
+		}
+		strbuf_release(&full);
+
+		branch = branch_get(short_name);
+		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
+		if (!push_ref)
+			continue;
+		if (refs_ref_exists(get_main_ref_store(the_repository),
+				    push_ref))
+			continue;
+
+		strvec_push(&deletable, short_name);
+	}
+
+	if (deletable.nr)
+		ret = delete_branches(deletable.nr, deletable.v, force,
+				      FILTER_REFS_BRANCHES, quiet,
+				      1, &n_not_merged);
+
+	if (n_not_merged && !quiet)
+		fprintf(stderr,
+			Q_("Skipped %d branch that is not fully merged; "
+			   "re-run with --force to delete it anyway.\n",
+			   "Skipped %d branches that are not fully merged; "
+			   "re-run with --force to delete them anyway.\n",
+			   n_not_merged),
+			n_not_merged);
+
+	strvec_clear(&deletable);
+	string_list_clear(&candidates, 0);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -825,6 +891,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +947,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches forked from the given <remote>s")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -924,7 +993,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -933,7 +1003,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -977,6 +1047,9 @@ int cmd_branch(int argc,
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
 		goto out;
+	} else if (prune_merged) {
+		ret = prune_merged_branches(argc, argv, force, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 24a3ec44ee..e6e6eab482 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,4 +1771,85 @@ test_expect_success '--forked requires at least one <remote>' '
 	test_grep "at least one <remote>" err
 '
 
+test_expect_success '--prune-merged: setup' '
+	test_create_repo pm-upstream &&
+	test_commit -C pm-upstream base &&
+	git -C pm-upstream branch one base &&
+	git -C pm-upstream branch two base
+'
+
+test_expect_success '--prune-merged deletes branches whose push ref is gone' '
+	test_when_finished "rm -rf pm-clean" &&
+	git clone pm-upstream pm-clean &&
+	git -C pm-clean branch one --track origin/one &&
+	git -C pm-clean branch two --track origin/two &&
+
+	git -C pm-clean update-ref -d refs/remotes/origin/one &&
+	git -C pm-clean branch --prune-merged origin &&
+
+	test_must_fail git -C pm-clean rev-parse --verify refs/heads/one &&
+	git -C pm-clean rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged spares in-flight branches whose push ref still exists' '
+	test_when_finished "rm -rf pm-inflight" &&
+	git clone pm-upstream pm-inflight &&
+	git -C pm-inflight branch one --track origin/one &&
+
+	git -C pm-inflight branch --prune-merged origin &&
+
+	git -C pm-inflight rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged skips branches with unpushed commits' '
+	test_when_finished "rm -rf pm-unmerged" &&
+	git clone pm-upstream pm-unmerged &&
+	git -C pm-unmerged checkout -b one --track origin/one &&
+	test_commit -C pm-unmerged unpushed &&
+	git -C pm-unmerged checkout - &&
+
+	git -C pm-unmerged update-ref -d refs/remotes/origin/one &&
+	git -C pm-unmerged branch --prune-merged origin 2>err &&
+	test_grep "not fully merged" err &&
+	test_grep "Skipped 1 branch" err &&
+	test_grep "re-run with --force" err &&
+	test_grep ! "If you are sure you want to delete it" err &&
+	git -C pm-unmerged rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged --force deletes branches with unpushed commits' '
+	test_when_finished "rm -rf pm-force" &&
+	git clone pm-upstream pm-force &&
+	git -C pm-force checkout -b one --track origin/one &&
+	test_commit -C pm-force unpushed &&
+	git -C pm-force checkout - &&
+
+	git -C pm-force update-ref -d refs/remotes/origin/one &&
+	git -C pm-force branch --force --prune-merged origin &&
+
+	test_must_fail git -C pm-force rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged never deletes the checked-out branch' '
+	test_when_finished "rm -rf pm-head" &&
+	git clone pm-upstream pm-head &&
+	git -C pm-head checkout -b one --track origin/one &&
+
+	git -C pm-head update-ref -d refs/remotes/origin/one &&
+	git -C pm-head branch --force --prune-merged origin &&
+
+	git -C pm-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged deletes when push ref differs from upstream' '
+	test_when_finished "rm -rf pm-pushdiff" &&
+	git clone pm-upstream pm-pushdiff &&
+	git -C pm-pushdiff config push.default current &&
+	git -C pm-pushdiff branch --track topic-a origin/main &&
+
+	git -C pm-pushdiff branch --force --prune-merged origin &&
+
+	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
+'
+
 test_done
-- 
gitgitgadget

