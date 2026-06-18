Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774F33F8D9
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810741; cv=none; b=dAH+cSIf7M3DTHLlOqF7Wk2nC2eGuZLUEHG5QI4/dQ84QPg48O2lEcqMnmZddUCWbxl+auYg8DlvOv1Zix/6HXswx3lPoFNswZ8E/pADWi/ZG3jKlnXkrjqMcSAvzDw1jKoKtrcuaLx/N//JfFFsZW7gfzBKmSuK5wkRN5ffK+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810741; c=relaxed/simple;
	bh=/O1ELsM0IuWgoGoXS8YcWKe8Q34wztMLJ2IHmEa3Nys=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cd50vEUNlu/GsOuzmLruNndCobQgtFLn3OjRcBQ8IwUaSFlwaUGhc2AZTre3rld0EXT0LhSzymLNTXAsF52Shr3cohB9JQbHkUafY8j5J2zEuaBuh8YByPUIGtVcxXBRTiUjl1rZO2WZlqlRs8JdgIoB1WMqrYOMjnBx28EEgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzDQrgVr; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzDQrgVr"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8dd3fe9cf10so10116396d6.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810739; x=1782415539; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWHTDGDN//gxFqQAucoDT+Px6rlgU4fdtGCCh5+SLVg=;
        b=qzDQrgVraX2VPe63Hi7dfhJevW1NZYdMrIUWFRwGZTFbbgUKIK+C18JZgTTwQVd5vy
         f0qUvZLUoYoYuevXMQygeXmhP2yQKhysWOtb9vUHZuqw2kOHsw0z0XVS6z04PAcNTfD5
         /GNJcFigVZu5QEd2calPLgjDrnPNL+No+vp21FYSaSvm0tDLdBroNd4md7rAZ+0FTNC3
         m0kiloBMgXdNZHv3tteM/sl1T/Kk5+pYajYHzzUjRDPHkhigph5ihi3N/JyMSYhdC62M
         zvbZ9BvRc48104yqMW9xZdM84NRKURmDKe223F0G57ZqU9ux+3YFol//PembYXQyRLJ5
         Xi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810739; x=1782415539;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oWHTDGDN//gxFqQAucoDT+Px6rlgU4fdtGCCh5+SLVg=;
        b=PFV2rGQ13lqX7kD4tD5dRSPr5NNa69d+tWgXB4BJHn7o36v6ec78JZwdPsGveyC1h0
         tgAn0A29wl6JY/UicLDPJ+qnWu+HsQq49kiGjYQaWG0JE5mJxtHUPIAmVlcQ5v8PI2FT
         ErGS4CH/EFwMG6k0FlNwQ+SaRT0mgJAKOzC+vIxAK2NdRm+B/GO4iGxyPs++SzMn9JrV
         araUjcbuk9yUpliqYX7Hh+CT9vYgQGX6De5X4D752GHcrMqf22u/HJo5RxcuWaPj2dMT
         cDdbQ0l7EjjY42mq8EnJwdu8z0qU9WPVWQbz94Cy9Tb9azayOctgnzIV6mt+qoW88o7A
         1buA==
X-Gm-Message-State: AOJu0YwK16fuS7wKFkHv4ewcuAT+EdYkH48jsqcihPW2+J+SJPSwQQQP
	Wj5V9O/fSerPe9go4SOuyuiiAQlx/MkOUo4+OdNcHaALZuUMpyuZaAZjnzvAtg==
X-Gm-Gg: AfdE7cmM8KIrD2hJ0XDAfTG8kxAfzYs8lI7PMGBN6rYZYpXn0PCbN8zhzrLTBOPSYlw
	6y9laxj0/N4kuNXj0aNllyAgwIAJaLhhdSz+KwG4zZgcSeq4sQ12OQpr3n/S8MCskk44DwMlet9
	fFQz4FurWC3SYWC0XijBWLz4X/UjncuBtogCOERRj5iL2cnAdtk30Lil8sqD3sLD/0F4ZzHk51K
	I+J18agfT3rE2kMgYRHGfsE6tZP8W0ndFOMKw3EJw+jvVn6rHf/kVFoHxxun5SWt6UwhBKS/G3o
	xvR9SC8Zlds0JMy6Tzb6naYIEAHTMNuuhdu/LNP206gKxZISgTKGHdwNcLONIGYwBixmnRfXdgI
	bhsyJ8whfVT6of8OB5VQiyNxFHwULNiG7tNOGiHFN/MLrgDTmDlquXo2TtyaKtMtusWmfPns933
	Re0rb7HxFy2lhK6QA+rQ8zlNsjFw==
X-Received: by 2002:a05:6214:14b4:b0:8dd:c36c:8cbd with SMTP id 6a1803df08f44-8de3f88341dmr6820956d6.16.1781810738482;
        Thu, 18 Jun 2026 12:25:38 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12c6dasm616316d6.8.2026.06.18.12.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:25:37 -0700 (PDT)
Message-Id: <998fb6a68cef85a71420446c62ff7cdc909913d5.1781810729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
References: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
	<pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:25:27 +0000
Subject: [PATCH v16 5/7] branch: add --delete-merged <branch>
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

	git branch --delete-merged <branch>...

deletes the local branches that "--forked <branch>" would list,
keeping only those whose tip is reachable from their configured
upstream. The work has already landed on the upstream they track,
so the local copy is no longer needed.

Three kinds of branches are not deleted:

  * any branch checked out in any worktree
  * any branch whose upstream remote-tracking branch no longer
    exists, since a missing upstream is not by itself a sign of
    integration
  * any branch whose push destination equals its upstream
    (<branch>@{push} is the same as <branch>@{upstream}), such as
    a local "main" that tracks and pushes to "origin/main". Right
    after a pull it just looks "fully merged", so it is kept. Only
    branches that push somewhere other than their upstream,
    typically topics in a fork workflow, are candidates.

A branch whose work is not yet merged into its upstream is silently
skipped, so one unmerged topic does not abort the whole sweep.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  24 ++++++++
 builtin/branch.c              |  67 +++++++++++++++++++++-
 t/t3200-branch.sh             | 105 ++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index b0d66a6deb..f82cfa36d0 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch --delete-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -201,6 +202,29 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--delete-merged <branch>...`::
+	Delete the local branches that `--forked` would list for the
+	given _<branch>_ arguments, but only those whose tip is
+	reachable from their configured upstream. In other words, the
+	work on the branch has already landed on the upstream it
+	tracks, so the local copy is no longer needed. Several
+	_<branch>_ patterns may be given, e.g. `git branch
+	--delete-merged origin/main 'feature*'`.
++
+A branch is not deleted when:
++
+--
+* its upstream remote-tracking branch no longer exists,
+* it is checked out in any worktree, or
+* its push destination (`<branch>@{push}`) equals its upstream
+  (`<branch>@{upstream}`), so it cannot be distinguished from a
+  branch that just looks "fully merged" right after a pull.
+--
++
+A branch whose work has not yet been merged into its upstream is
+silently skipped. Delete it with `git branch -D` if you want to
+remove it anyway.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1d3f28e4cb..e7e4f1d27f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -38,6 +38,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --delete-merged <branch>..."),
 	NULL
 };
 
@@ -714,6 +715,60 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 	return 0;
 }
 
+static int delete_merged_branches(int argc, const char **argv,
+				 unsigned int flags)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array candidates = { 0 };
+	struct strvec deletable = STRVEC_INIT;
+	int i, ret = 0;
+
+	if (!argc)
+		die(_("--delete-merged requires at least one <branch>"));
+
+	for (i = 0; i < argc; i++)
+		if (ref_filter_forked_add(&filter, argv[i]) < 0)
+			die(_("'%s' is not a valid branch or pattern"), argv[i]);
+
+	filter.kind = FILTER_REFS_BRANCHES;
+	filter_refs(&candidates, &filter, filter.kind);
+
+	for (i = 0; i < candidates.nr; i++) {
+		const char *full_name = candidates.items[i]->refname;
+		const char *short_name;
+		struct branch *branch;
+		const char *upstream, *push;
+
+		if (!skip_prefix(full_name, "refs/heads/", &short_name))
+			BUG("filter returned non-branch ref '%s'", full_name);
+		if (branch_checked_out(full_name))
+			continue;
+
+		branch = branch_get(short_name);
+		upstream = branch_get_upstream(branch, NULL);
+		if (!upstream || !refs_ref_exists(refs, upstream))
+			continue;
+		push = branch_get_push(branch, NULL);
+		if (!push || !strcmp(push, upstream))
+			continue;
+
+		strvec_push(&deletable, short_name);
+	}
+
+	if (deletable.nr)
+		ret = delete_branches(deletable.nr, deletable.v,
+				      FILTER_REFS_BRANCHES,
+				      DELETE_BRANCH_SKIP_UNMERGED |
+				      DELETE_BRANCH_NO_HEAD_FALLBACK |
+				      flags);
+
+	strvec_clear(&deletable);
+	ref_array_clear(&candidates);
+	ref_filter_clear(&filter);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -755,6 +810,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int delete_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -808,6 +864,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "delete-merged", &delete_merged,
+			N_("delete local branches whose upstream matches <branch> and are merged")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -855,7 +913,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !delete_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -865,7 +924,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!delete_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -907,6 +966,10 @@ int cmd_branch(int argc,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
+	} else if (delete_merged) {
+		ret = delete_merged_branches(argc, argv,
+					     quiet ? DELETE_BRANCH_QUIET : 0);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3104c555f6..609a67bb5a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1839,4 +1839,109 @@ test_expect_success '--forked narrows a <pattern> argument' '
 	test_cmp expect actual
 '
 
+test_expect_success '--delete-merged: setup' '
+	git init -b main upstream &&
+	(
+		cd upstream &&
+		test_commit base &&
+		git checkout -b next &&
+		test_commit next-work &&
+		git checkout main
+	) &&
+	git init -b main other &&
+	test_commit -C other other-base &&
+	git init -b main fork
+'
+
+setup_repo_for_delete_merged () {
+	rm -rf repo &&
+	git clone upstream repo &&
+	(
+		cd repo &&
+		git remote add fork ../fork &&
+		git remote add other ../other &&
+		git config remote.pushDefault fork &&
+		git config push.default current &&
+		git fetch other
+	)
+}
+
+merged_branch () {
+	(
+		cd repo &&
+		git checkout -b "$1" "$2" &&
+		git commit --allow-empty -m "$1 work" &&
+		git push origin "$1:next" &&
+		git fetch origin &&
+		git branch --set-upstream-to="$2" "$1"
+	)
+}
+
+test_expect_success '--delete-merged deletes merged branches and spares the rest' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch merged origin/next &&
+	(
+		cd repo &&
+		git checkout -b unmerged origin/next &&
+		git commit --allow-empty -m "unmerged work" &&
+		git branch --set-upstream-to=origin/next unmerged &&
+		git checkout -b tracks-other other/main &&
+		git branch --set-upstream-to=other/main tracks-other &&
+		git checkout --detach
+	) &&
+	sha=$(git -C repo rev-parse --short merged) &&
+
+	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
+
+	echo "Deleted branch merged (was $sha)." >expect &&
+	test_cmp expect actual &&
+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	main
+	tracks-other
+	unmerged
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--delete-merged deletes merged branches and spares protected ones' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch on-next origin/next &&
+	merged_branch checked-out origin/next &&
+	merged_branch upstream-gone origin/next &&
+	(
+		cd repo &&
+		git checkout -b mainline main &&
+		git checkout -b on-local mainline &&
+		git branch --set-upstream-to=mainline on-local &&
+		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
+		git branch --set-upstream-to=origin/topic upstream-gone &&
+		git update-ref -d refs/remotes/origin/topic &&
+		git branch --set-upstream-to=origin/main main &&
+		git config branch.main.pushRemote origin &&
+		git checkout -b tracks-other other/main &&
+		git branch --set-upstream-to=other/main tracks-other &&
+		git checkout checked-out
+	) &&
+
+	git -C repo branch --delete-merged origin/next mainline &&
+
+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	checked-out
+	main
+	mainline
+	tracks-other
+	upstream-gone
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--delete-merged requires at least one <branch>' '
+	test_must_fail git -C forked branch --delete-merged 2>err &&
+	test_grep "requires at least one <branch>" err
+'
+
 test_done
-- 
gitgitgadget

