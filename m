Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65723410D36
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542058; cv=none; b=lMgRZOQsmH2mYtQomjjaiSYMKj+kqy0pnQ+DfObdZ6Gq5h7381z/q1Ylz0+zP9d/ams2+W7MObi9zPx1mU1awZ3fKDedrVYdUthWqSD9f7144G1GYj0oHrS6TuBbLSxtLldeH5dxtkxE2pnwa9RqDhoeTI6zDVZES3XYXBvKaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542058; c=relaxed/simple;
	bh=oY2DLGMsJuGnNR7GOej3Fs55OpYYAwESnIe0iHrNhDY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n03lKpyi3UgwUAKGTQnBRVUpO2ovtiTCvz+pdZa1+apzxtMiOKTqvwx82cxgER7FPNsDYF1U0wPuOLQiVX4AgofjXBVaTr5NRExmv3iUzmjscaTk/dDGIzLYfBh/5XEghxEgedAxZgRfz0M6tfDlI8Sij/ovjJyiffiT0QRocX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWgroJu1; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWgroJu1"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1363fe80fe8so5154431c88.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542055; x=1782146855; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyVFYHYi4wRuMC/i3p9QFt5gjHuFj0XIpQ2X0bKlv28=;
        b=MWgroJu1h0liTjTkTslX2lKUqtbV+h7NSmn+9aP2OFYGQhSzqeqWzWUziV0ZV5P/lj
         5mO3qJVd2AX8+AJTSVVX0owq1V+yRiAT7FSTZD+ZOIn+rMtmwKCNB2wsbd5DeyYdxx/v
         2eDrw0pRtcj80OmcznpuW5uTXnaLL6zt8I0rYIXlnig4MEyAo2BlEJ8WfEQgVFR+21fW
         qaNdxAbQhiw3IhsxedR8jBX1N6CMZR1Icu6VbFKMtjhp3xagi+9vq04f4nD6+0CpsTkF
         cgWjOx5zcfLKkiauSCMTyL2Qc3gCEAUJasG9qVR5s+ps4qVi3k9NKo94EaRzZXZAYA9t
         /8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542055; x=1782146855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyVFYHYi4wRuMC/i3p9QFt5gjHuFj0XIpQ2X0bKlv28=;
        b=W1+H6ndZ/225/eTGQyOfzgJ3F2c3V7FXzs0kJMaZH/QM5XfmspHAHGJIxZuV4H8mG4
         y1d9TgaJzQs9V/mXC9rrkFOysnBRLSHX9X9dS2c9piKv272Lvqyf4tc6UQetQrQwUtSR
         xP1pnZ6ljhQ8LFeAQ+G0HARpxYgR5HcpAJYilP2N9QrsQeQRO/U+mmNjI6EUAp//Me9l
         e5zzfcZCQAKXd32QC6QBbL83Hr4Xn/Gz054cyjahm/HfR4IS6k34g+++7SEIX9Rx3sR2
         RKoUsQ0QFY+5SABWS7OWBSow7EEVBlmTzMnX5tywS473mfT7thjuEQ5NQmmn66veoLcs
         D4qw==
X-Gm-Message-State: AOJu0YzaNczGk3SWTGDeQ8Ak242VyBoy4QEYGEJCSxADmNTE87C0596z
	AxRYA2cZPsOla9iKo3Do4q4q6UFAB2CjcqkTF/IVNywUzrFTV5SmxuIxTCawLA==
X-Gm-Gg: Acq92OFHUrz5SrhkO4FZDszePQhGpiGIU9tc9snkx/YcwCzsoFk5L2+TIRIwNFyoEOO
	wuorlGSDGdX8ZYAFWmCtw8bKcLSbjZIl9XhMDpvTDrrUgYvjx3UXwFBfPl/7Uy/Kdwe0W5nwgJp
	UuQ5EXsI+B816bO4Bt0sccSC9e8iLfpoA2Vgchm/stmsogLue4KUPZ4GrQrho64P1AdS5Teu1Oq
	q0DOgO0D2/Vr7wt1Tyv9c99Mslzd2FmGBo+h1TJxG96P83C6dZu8vEmdAgFATeHlXfrMYARyns6
	pKtFyFds0LvYSLAjN2xHD/exrs0ug0KtPLTZShL6BCh1NOySSWjZ/WqICLtycwIzXfImBeJqaP9
	iKtqwyLW/q983ssnLD6kKVTueWzd9P5Oi3uDiEDbFzItp2T1N3AfexbWmRURzJPHqLqFAR0f5LP
	5DVx5IWu+jKPTgPJM2/gwJaXAUnrsliy/Bh70=
X-Received: by 2002:a05:7022:5f0d:b0:138:407c:1d24 with SMTP id a92af1059eb24-1384bba4679mr3643633c88.36.1781542055254;
        Mon, 15 Jun 2026 09:47:35 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b9815a6sm11084751c88.15.2026.06.15.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:47:34 -0700 (PDT)
Message-Id: <5899013b8ff40aaa84183914df9b64959700c12c.1781542042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 16:47:20 +0000
Subject: [PATCH v15 5/7] branch: add --delete-merged <branch>
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
 Documentation/git-branch.adoc |  24 ++++
 builtin/branch.c              |  66 ++++++++++-
 t/t3200-branch.sh             | 200 ++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+), 2 deletions(-)

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
index 1d3f28e4cb..f01e03cc26 100644
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
+				 int quiet)
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
+				      (quiet ? DELETE_BRANCH_QUIET : 0));
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
 
@@ -907,6 +966,9 @@ int cmd_branch(int argc,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
+	} else if (delete_merged) {
+		ret = delete_merged_branches(argc, argv, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fac2ad55ac..b74e119d3b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1830,4 +1830,204 @@ test_expect_success '--forked narrows a <pattern> argument' '
 	test_cmp expect actual
 '
 
+test_expect_success '--delete-merged: setup' '
+	test_create_repo pm-upstream &&
+	test_commit -C pm-upstream base &&
+	git -C pm-upstream checkout -b next &&
+	test_commit -C pm-upstream one-commit &&
+	test_commit -C pm-upstream two-commit &&
+	git -C pm-upstream branch one HEAD~ &&
+	git -C pm-upstream branch two HEAD &&
+	git -C pm-upstream branch wip main &&
+	git -C pm-upstream checkout main &&
+	test_create_repo pm-fork
+'
+
+test_expect_success '--delete-merged deletes branches integrated into upstream' '
+	test_when_finished "rm -rf pm-merged" &&
+	git clone pm-upstream pm-merged &&
+	git -C pm-merged remote add fork ../pm-fork &&
+	test_config -C pm-merged remote.pushDefault fork &&
+	test_config -C pm-merged push.default current &&
+	git -C pm-merged branch one one-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next one &&
+	git -C pm-merged branch two two-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next two &&
+
+	git -C pm-merged branch --delete-merged "origin/*" &&
+
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--delete-merged accepts a literal upstream' '
+	test_when_finished "rm -rf pm-literal" &&
+	git clone pm-upstream pm-literal &&
+	git -C pm-literal remote add fork ../pm-fork &&
+	test_config -C pm-literal remote.pushDefault fork &&
+	test_config -C pm-literal push.default current &&
+	git -C pm-literal branch one one-commit &&
+	git -C pm-literal branch --set-upstream-to=origin/next one &&
+
+	git -C pm-literal branch --delete-merged origin/next &&
+
+	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--delete-merged unions multiple <branch> arguments' '
+	test_when_finished "rm -rf pm-union" &&
+	git clone pm-upstream pm-union &&
+	git -C pm-union remote add fork ../pm-fork &&
+	test_config -C pm-union remote.pushDefault fork &&
+	test_config -C pm-union push.default current &&
+	git -C pm-union branch one one-commit &&
+	git -C pm-union branch --set-upstream-to=origin/next one &&
+	git -C pm-union branch two base &&
+	git -C pm-union branch --set-upstream-to=origin/main two &&
+	git -C pm-union checkout --detach &&
+
+	git -C pm-union branch --delete-merged origin/next origin/main &&
+
+	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--delete-merged accepts a local upstream' '
+	test_when_finished "rm -rf pm-local" &&
+	git clone pm-upstream pm-local &&
+	git -C pm-local remote add fork ../pm-fork &&
+	test_config -C pm-local remote.pushDefault fork &&
+	test_config -C pm-local push.default current &&
+	git -C pm-local checkout -b mainline &&
+	git -C pm-local branch one one-commit &&
+	git -C pm-local branch --set-upstream-to=mainline one &&
+	git -C pm-local merge --ff-only one-commit &&
+
+	git -C pm-local branch --delete-merged mainline &&
+
+	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--delete-merged silently skips un-integrated commits' '
+	test_when_finished "rm -rf pm-unmerged" &&
+	git clone pm-upstream pm-unmerged &&
+	git -C pm-unmerged remote add fork ../pm-fork &&
+	test_config -C pm-unmerged remote.pushDefault fork &&
+	test_config -C pm-unmerged push.default current &&
+	git -C pm-unmerged checkout -b wip origin/wip &&
+	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-unmerged local-only &&
+	git -C pm-unmerged checkout - &&
+
+	git -C pm-unmerged branch --delete-merged "origin/*" 2>err &&
+	test_grep ! "not fully merged" err &&
+	git -C pm-unmerged rev-parse --verify refs/heads/wip
+'
+
+test_expect_success '--delete-merged is silent about not-merged-to-HEAD' '
+	test_when_finished "rm -rf pm-nohead" &&
+	git clone pm-upstream pm-nohead &&
+	git -C pm-nohead remote add fork ../pm-fork &&
+	test_config -C pm-nohead remote.pushDefault fork &&
+	test_config -C pm-nohead push.default current &&
+	git -C pm-nohead branch topic one-commit &&
+	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
+
+	git -C pm-nohead branch --delete-merged "origin/*" 2>err &&
+
+	test_grep ! "not yet merged to HEAD" err &&
+	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
+'
+
+test_expect_success '--delete-merged skips branches whose upstream is gone' '
+	test_when_finished "rm -rf pm-upstream-gone" &&
+	git clone pm-upstream pm-upstream-gone &&
+	git -C pm-upstream-gone remote add fork ../pm-fork &&
+	test_config -C pm-upstream-gone remote.pushDefault fork &&
+	test_config -C pm-upstream-gone push.default current &&
+	git -C pm-upstream-gone branch one one-commit &&
+	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
+
+	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
+	git -C pm-upstream-gone branch --delete-merged "origin/*" &&
+
+	git -C pm-upstream-gone rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--delete-merged never deletes the checked-out branch' '
+	test_when_finished "rm -rf pm-head" &&
+	git clone pm-upstream pm-head &&
+	git -C pm-head remote add fork ../pm-fork &&
+	test_config -C pm-head remote.pushDefault fork &&
+	test_config -C pm-head push.default current &&
+	git -C pm-head checkout -b one one-commit &&
+	git -C pm-head branch --set-upstream-to=origin/next one &&
+
+	git -C pm-head branch --delete-merged "origin/*" &&
+
+	git -C pm-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--delete-merged spares branches that push back to their upstream' '
+	test_when_finished "rm -rf pm-push-eq" &&
+	git clone pm-upstream pm-push-eq &&
+	git -C pm-push-eq checkout --detach &&
+
+	git -C pm-push-eq branch --delete-merged "origin/*" &&
+
+	git -C pm-push-eq rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--delete-merged spares a per-branch pushRemote==upstream remote' '
+	test_when_finished "rm -rf pm-push-branch" &&
+	git clone pm-upstream pm-push-branch &&
+	git -C pm-push-branch remote add fork ../pm-fork &&
+	test_config -C pm-push-branch remote.pushDefault fork &&
+	test_config -C pm-push-branch push.default current &&
+	test_config -C pm-push-branch branch.main.pushRemote origin &&
+	git -C pm-push-branch checkout --detach &&
+
+	git -C pm-push-branch branch --delete-merged "origin/*" &&
+
+	git -C pm-push-branch rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--delete-merged prunes when @{push} differs from @{upstream}' '
+	test_when_finished "rm -rf pm-push-diff" &&
+	git clone pm-upstream pm-push-diff &&
+	git -C pm-push-diff remote add fork ../pm-fork &&
+	test_config -C pm-push-diff remote.pushDefault fork &&
+	test_config -C pm-push-diff push.default current &&
+	git -C pm-push-diff branch topic one-commit &&
+	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
+	git -C pm-push-diff checkout --detach &&
+
+	git -C pm-push-diff branch --delete-merged "origin/*" &&
+
+	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
+'
+
+test_expect_success '--delete-merged requires at least one <branch>' '
+	test_must_fail git -C forked branch --delete-merged 2>err &&
+	test_grep "requires at least one <branch>" err
+'
+
+test_expect_success '--delete-merged takes positional <branch> arguments' '
+	test_when_finished "rm -rf pm-positional" &&
+	git clone pm-upstream pm-positional &&
+	git -C pm-positional remote add fork ../pm-fork &&
+	test_config -C pm-positional remote.pushDefault fork &&
+	test_config -C pm-positional push.default current &&
+	git -C pm-positional branch one one-commit &&
+	git -C pm-positional branch --set-upstream-to=origin/next one &&
+	git -C pm-positional branch two base &&
+	git -C pm-positional branch --set-upstream-to=origin/main two &&
+	git -C pm-positional checkout --detach &&
+
+	git -C pm-positional branch --delete-merged origin/next origin/main &&
+
+	test_must_fail git -C pm-positional rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
+'
+
 test_done
-- 
gitgitgadget

