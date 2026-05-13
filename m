Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132B3B7772
	for <git@vger.kernel.org>; Wed, 13 May 2026 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700895; cv=none; b=bLznGmBMlO1Xvlzi8/0L5OpMrpIpaVwA05j85HFAeElXscKr/7xX8nYXIjGcrumhq04tgFrjJRk45Jyp3EcB6JVjqeI+nxCI+GJgmOBTZMnZqqq3QXis13Ogeuvj+DCsOOXqndDV92S66Zh60jUTtmRTmY23/V/OAU9TkVRXTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700895; c=relaxed/simple;
	bh=UXfW9+Izgl1ZpVTRXbdh6MaoVHMvvF9eAq4sGSVZYIM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mjf3TAUTBGCBSleqnaYw+XYNu+6BXFkfQZfZY1cTD25TDG9x+KpZj8QGdqAkyEvluTGf9YRC/F+z+q4mcsaUJXJTXjeM3NhqDtYCY3UGsLLusB1aAEak1jzlGlNc1h3Ut6/3zwgc1PLwI+//YKZ9+B596njVPjPSPUZjw8wDy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6jqdrRh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6jqdrRh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5102582e23eso53835591cf.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700893; x=1779305693; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA/6PfFbUTXhmsirxCBwEdwNTM9jfBbtRMdD96nG4Fs=;
        b=j6jqdrRh+nx51yjYILnaKh+An2Iy00FPQAbKYxn7eZoTFcAUpB0j9RNEpq7TfnfiRM
         oOLcrEGMeHpNunTR/ISh3qmE4V4YC72PDJp2UOtrDcFEAinWUCQuVSvBmpBKFYm7dQyS
         WmhlwzaCMrs1N5eqw2QShdzrgw+RAi3ig6FXEiqkEtm3/SMMAJecCl6g3lk28FriAFbW
         DGTjI4dUak+6tIYRN7diZYqQcOM4483aO0VxI7ZAZY/heLcqs7HcoLz1SzXMPb53mYeO
         yx7kJymdfwO9d/8Pa9Zgp4qIBu8TWMDmbbhpFthlNZQCte2pWonjv5oWHBVV1BwsrL90
         uA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700893; x=1779305693;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oA/6PfFbUTXhmsirxCBwEdwNTM9jfBbtRMdD96nG4Fs=;
        b=aMQJiMsY9uwDzHVzcOVgba7AvdCmEY0FX549IVbIX39+elRR6Np2tT0ya4xVvoXWto
         3oUCCl9RL3VA1UwMZOWMVnLIZ9G2QAu4SqNweT5McqN3tUtWWHz7VQ1YTlrvfRYnFEZX
         IfEcBKO1awWwS+2OlbyQkgNR2OV0Dk0x6uFa1eme/66/5E8m5dD3P/H3SJGP/e2S+rAb
         1LyNLq7+iiArZ6BWPHTAZORwFSDPAvjD6iCkOe8o6WVnOI5XGWLPcJEoeDsAu958uU+G
         55ujHcrdoW/eKgsIWl83rG2EudxVk4EwFmRsuiegrb29Evxvr2MS9zsuaYg830gEDt12
         e06w==
X-Gm-Message-State: AOJu0YyyjW3tT/zBzJ6xXxaIbud0LXM13YpSWKrplMfYAocvjnqBNbFA
	l086d0qIGm0pvAHDirvVM6diYzDqsqsX64RWNehuUN5jP8PEUot+Qxwv9e+/Ig==
X-Gm-Gg: Acq92OGACXujoL/4jBYYy08rgvWUIaB2obOBqSiqaZayzkAYeRIuPGrP8LE7ZjuMRTY
	6tm1AOHAWUkb7C2DveR4cIOrZ0UdTo7Q0/9IJlsQSdxX29ffCp39g7YDbwkkbf9oeLY7erF2V8z
	MIj4aDdEu7islmtfQ0Dx3FCPb1caKpwgFOD7sFbG3qWEfsD8j2kR7p4YAyGUSbivC14GLCSButT
	5W48uGt5fOBgmSPkQfZwDW/kSiAG6IMDUnBgYaA2hb5FCDC6y3mtYDBEh1Pak8YAOuSAbsa24Ur
	MrVbC6XN6c+kk1za4r6B2YXsWac9fVEvv7ktNVZNz+XJpM4pLuELoKC8lHKQl8e5nkTarGQkIR/
	4wLYdOm8XCbGpdrQqGP0GjPHXEYBgseeMnQAP3tMyo7fNkLaB1Q0Hb7H7BonBheD1PcGztwXFZH
	VGnsZD62FR7X6Hkc9Cb+DX28yUIgeEs+fbhlA=
X-Received: by 2002:a05:622a:19a0:b0:50f:c2f8:406f with SMTP id d75a77b69052e-5162f4c7393mr62121421cf.25.1778700887903;
        Wed, 13 May 2026 12:34:47 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e82579fsm152814311cf.24.2026.05.13.12.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:34:47 -0700 (PDT)
Message-Id: <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
	<pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 19:34:41 +0000
Subject: [PATCH v9 3/5] branch: add --prune-merged <remote>
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

Delete the local branches that --forked <remote> would list, but
only those whose tip is reachable from their configured upstream
remote-tracking branch (branch.<name>.merge): the work has already
landed on the upstream it tracks, so the local copy is no longer
needed.

A branch whose upstream no longer resolves locally is left alone --
its disappearance is not, on its own, evidence that the work was
integrated. With --force, skip the reachability check and delete
every branch in the candidate set. The currently checked-out
branch in any worktree is always preserved, as is the local branch
that mirrors <remote>'s default branch.

Reachability is read from whatever the remote-tracking refs say
locally, so the natural workflow is

	git fetch <remote>
	git branch --prune-merged <remote>

with no implicit cleanup driven by fetch itself.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  19 +++++
 builtin/branch.c              | 143 +++++++++++++++++++++++++++++-----
 t/t3200-branch.sh             |  83 ++++++++++++++++++++
 3 files changed, 226 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5773104cd3..375a0a68da 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <remote>...
+git branch --prune-merged <remote>...
 
 DESCRIPTION
 -----------
@@ -211,6 +212,24 @@ Each _<remote>_ may be either the name of a configured remote
 `refs/remotes/origin/*` ref) or a specific remote-tracking branch
 (e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
 
+`--prune-merged`::
+	Delete the local branches that `--forked` would list for
+	the same _<remote>_ arguments, but only those whose tip is
+	reachable from their configured upstream remote-tracking
+	branch (`branch.<name>.merge`). In other words: the work on
+	the branch has already landed on the upstream it tracks, so
+	the local copy is no longer needed.
++
+Run `git fetch` first so the upstream remote-tracking branches
+reflect the current state of _<remote>_; reachability is checked
+against whatever the remote-tracking refs say locally.
++
+A branch whose upstream no longer resolves locally is left alone
+(its disappearance is not, on its own, evidence that the work was
+integrated). The currently checked-out branch in any worktree is
+always preserved, as is the local branch that mirrors _<remote>_'s
+default branch.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1941f8a9ad..6fe2ffd7e8 100644
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
@@ -171,8 +172,8 @@ static int branch_merged(int kind, const char *name,
 	 * any of the following code, but during the transition period,
 	 * a gentle reminder is in order.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -227,7 +228,9 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds,
+static int delete_branches(int argc, const char **argv,
+			   int no_head_fallback,
+			   int force, int kinds,
 			   int quiet, int warn_only, int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
@@ -262,7 +265,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -317,8 +320,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		}
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
-		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force, warn_only, n_not_merged)) {
+		    check_branch_commit(bname.buf, name, &oid, head_rev,
+					kinds, force, warn_only, n_not_merged)) {
 			if (!warn_only)
 				ret = 1;
 			goto next;
@@ -753,36 +756,131 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static void collect_default_branch_refs(const struct string_list *remote_names,
+					struct string_list *out)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, remote_names) {
+		struct strbuf head = STRBUF_INIT;
+		const char *target;
+
+		strbuf_addf(&head, "refs/remotes/%s/HEAD", item->string);
+		target = refs_resolve_ref_unsafe(refs, head.buf,
+						 RESOLVE_REF_NO_RECURSE,
+						 NULL, NULL);
+		if (target && starts_with(target, "refs/remotes/"))
+			string_list_insert(out, target);
+		strbuf_release(&head);
+	}
+}
+
+static void collect_forked_set(int argc, const char **argv,
+			       struct string_list *protected_default_refs,
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
+
+	if (protected_default_refs)
+		collect_default_branch_refs(&remote_names, protected_default_refs);
 
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
+	collect_forked_set(argc, argv, NULL, &out);
+	for_each_string_list_item(item, &out)
+		puts(item->string);
+
 	string_list_clear(&out, 0);
 	return 0;
 }
 
+static int prune_merged_branches(int argc, const char **argv, int quiet)
+{
+	struct string_list candidates = STRING_LIST_INIT_DUP;
+	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
+	struct strvec deletable = STRVEC_INIT;
+	struct string_list_item *item;
+	int n_not_merged = 0;
+	int ret = 0;
+
+	if (!argc)
+		die(_("--prune-merged requires at least one <remote>"));
+
+	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
+
+	for_each_string_list_item(item, &candidates) {
+		const char *short_name = item->string;
+		struct strbuf full = STRBUF_INIT;
+		struct branch *branch;
+		const char *upstream;
+
+		strbuf_addf(&full, "refs/heads/%s", short_name);
+		if (branch_checked_out(full.buf)) {
+			strbuf_release(&full);
+			continue;
+		}
+		strbuf_release(&full);
+
+		branch = branch_get(short_name);
+		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
+		if (!upstream ||
+		    !refs_ref_exists(get_main_ref_store(the_repository),
+				     upstream))
+			continue;
+		if (string_list_has_string(&protected_default_refs, upstream)) {
+			const char *leaf = strrchr(upstream, '/');
+			if (leaf && !strcmp(leaf + 1, short_name))
+				continue;
+		}
+
+		strvec_push(&deletable, short_name);
+	}
+
+	if (deletable.nr)
+		ret = delete_branches(deletable.nr, deletable.v,
+				      1, 0,
+				      FILTER_REFS_BRANCHES, quiet,
+				      1, &n_not_merged);
+
+	if (n_not_merged && !quiet)
+		fprintf(stderr,
+			Q_("Skipped %d branch that is not fully merged; "
+			   "delete it with 'git branch -D' if you are sure.\n",
+			   "Skipped %d branches that are not fully merged; "
+			   "delete them with 'git branch -D' if you are sure.\n",
+			   n_not_merged),
+			n_not_merged);
+
+	strvec_clear(&deletable);
+	string_list_clear(&candidates, 0);
+	string_list_clear(&protected_default_refs, 0);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -825,6 +923,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +979,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches forked from the given <remote>s")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -924,7 +1025,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -933,7 +1035,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -971,12 +1073,15 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+		ret = delete_branches(argc, argv, 0, delete > 1, filter.kind,
 				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
 		goto out;
+	} else if (prune_merged) {
+		ret = prune_merged_branches(argc, argv, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 24a3ec44ee..94ea493aee 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,4 +1771,87 @@ test_expect_success '--forked requires at least one <remote>' '
 	test_grep "at least one <remote>" err
 '
 
+test_expect_success '--prune-merged: setup' '
+	test_create_repo pm-upstream &&
+	test_commit -C pm-upstream base &&
+	git -C pm-upstream checkout -b next &&
+	test_commit -C pm-upstream one-commit &&
+	test_commit -C pm-upstream two-commit &&
+	git -C pm-upstream branch one HEAD~ &&
+	git -C pm-upstream branch two HEAD &&
+	git -C pm-upstream branch wip main &&
+	git -C pm-upstream checkout main
+'
+
+test_expect_success '--prune-merged deletes branches integrated into upstream' '
+	test_when_finished "rm -rf pm-merged" &&
+	git clone pm-upstream pm-merged &&
+	git -C pm-merged branch one one-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next one &&
+	git -C pm-merged branch two two-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next two &&
+
+	git -C pm-merged branch --prune-merged origin &&
+
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged spares branches with un-integrated commits' '
+	test_when_finished "rm -rf pm-unmerged" &&
+	git clone pm-upstream pm-unmerged &&
+	git -C pm-unmerged checkout -b wip origin/wip &&
+	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-unmerged local-only &&
+	git -C pm-unmerged checkout - &&
+
+	git -C pm-unmerged branch --prune-merged origin 2>err &&
+	test_grep "not fully merged" err &&
+	test_grep "Skipped 1 branch" err &&
+	test_grep "git branch -D" err &&
+	test_grep ! "If you are sure you want to delete it" err &&
+	git -C pm-unmerged rev-parse --verify refs/heads/wip
+'
+
+test_expect_success '--prune-merged skips branches whose upstream is gone' '
+	test_when_finished "rm -rf pm-upstream-gone" &&
+	git clone pm-upstream pm-upstream-gone &&
+	git -C pm-upstream-gone branch one one-commit &&
+	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
+
+	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
+	git -C pm-upstream-gone branch --prune-merged origin &&
+
+	git -C pm-upstream-gone rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged never deletes the checked-out branch' '
+	test_when_finished "rm -rf pm-head" &&
+	git clone pm-upstream pm-head &&
+	git -C pm-head checkout -b one one-commit &&
+	git -C pm-head branch --set-upstream-to=origin/next one &&
+
+	git -C pm-head branch --prune-merged origin &&
+
+	git -C pm-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged spares the local default branch' '
+	test_when_finished "rm -rf pm-default" &&
+	git clone pm-upstream pm-default &&
+	git -C pm-default checkout --detach &&
+	git -C pm-default branch --prune-merged origin &&
+	git -C pm-default rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged protects only the default branch by name, not by upstream' '
+	test_when_finished "rm -rf pm-default-alias" &&
+	git clone pm-upstream pm-default-alias &&
+	git -C pm-default-alias branch --track trunk origin/main &&
+	git -C pm-default-alias checkout --detach &&
+	git -C pm-default-alias branch --prune-merged origin &&
+	git -C pm-default-alias rev-parse --verify refs/heads/main &&
+	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
+'
+
 test_done
-- 
gitgitgadget

