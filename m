Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96164385D7E
	for <git@vger.kernel.org>; Tue, 12 May 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605670; cv=none; b=QW99H7vhoNKgKRHtEJp0wg5qiYyyMCztL6ljeP03/RNCtOaN/paLHpyObsvCGmoDmXQttvqVKZMsR/Uu8Sk4f+hWzfGqX24YjSjTsDygvnP3FYN8rNRB3cFBHx8XaVzLYrhHqyq/sh50Hf+QXkzUpBn1bvKX935ptpFejZEO1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605670; c=relaxed/simple;
	bh=D/Bem6iDD2Y2h1pp22JePTFPN8TIJzy4EZAJvgOfySI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tjCzkHEa2sHxes7lrDFvTiXHAX+UBuqsTjgxymVS7GIUN39Zbzx8Q6lUZL59N91iRg3IDTrCEfDM+G28CEy+KwZtl8AKVfum4FA4QLnvqhX5a5CLr+pcIGXR1Y5jTTi6tX6O3Gtq/A7y0aTYUczp/RzRXzjAHPS1E41XDxCRrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9pg+gcu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9pg+gcu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c80291e6237so4032874a12.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605667; x=1779210467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHyf64M2XdFZVSFSo+8rp6rd/JYnsSXttyPr5+0jDTs=;
        b=Q9pg+gcuX7m8u2L8j43hMqB/1u3ve9burHH2rjRtAA4z5yi5pLtxy7x7fZs8bbH+cw
         0IO1GkS4S/bAbVIjAK7gRHGdEV3JknzpyzbsG9k7ozr0fNk/uZgNYqoWnj51GvP06BAw
         3kkvTYuXsIwNURPFDKkjZebFwirFTGk1A8HgUMI7oUPX3Bgjl8XfL2oq3jxNp6zkCjyI
         y/jck3HwT7iiOhMjioHA7aNE5BCbpuM2qxTPhpKdVUPhC2JCF6aU2cNHNk+OnFS8sr9m
         KXUqcpAcmV1chaRnAsdhIow9+V4PnxDAoMcHJNfPnNx6jx7woQdNXJ8fRks9jlW07feq
         3F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605667; x=1779210467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHyf64M2XdFZVSFSo+8rp6rd/JYnsSXttyPr5+0jDTs=;
        b=ex6XOa+gIVJDXpk8Fii1yX3wAQEP0Iip5qA/v6wklDFCt++WcTZG+torbypdyHOuex
         XkL/67Mf6X42/87k2NO4YxH6T7FYk1TUqaOWFsO0wDJQwrcArfoXgBhm6FuNgDWVHIH1
         WrxV8eBy4bCCrIHDLyJbwL0pqhIYV+JEblwPq8a6efhsmrI1lUjlfvL0JXfh0fS5ROnf
         DfO11aNhULza7nyzvOnZSrk7ogj+t0HUSbmP4WvFj2sj7L9uzHqSVIUe/rhdQ66eLe42
         TZXcrLhMgMETPhnZ3ZLEXOn236Oj4MpQYzkMMl+p3eBdJqAxNnjBqh9GFh6DYbJewFwT
         i8DA==
X-Gm-Message-State: AOJu0YwzkLX5xpULaukAaeAAfPCOR1hIx5Ulz8I8+u9O+48gDNM5hYfz
	+xsvkmgVdXhcQmWroahpczNVO/TWCI886l1uVP7SdfeCzDU9fwLgzkKScqpThn69
X-Gm-Gg: Acq92OFVZJRg8UXP2e7x+IgCLXOvluSwE7GRKxu2VtsxNDM0lXSQMfoJOhwf06ZQsOW
	FTefI/LQPe5AHG1Np55CpTeKrQmwqFk6PkAdKGVoKkuYbwvyra4s5fT8wOdchQc67PAzjiCbBfp
	W5qPXCPwo8LsFIaP8GD8QicwwJUs6Kdegen3b4mMOm0Rvvd4dxbMzOaPzEepsz+765WCkqM55RU
	VDk9oJAaKunJ8Fg33u+lhHMRA874d6V7ggKjXqb3dH/PNo0iY+i89e7DokJecHSC5Ae78hrDJrX
	L6zzqmXJojQNINKEeQCX4nG+rgv0q/ZEEvu7roo2rbiT31/nfABPEB4XuBDkQzltN1OH1g87i8u
	KWMjOujD9FfI4+nxKRD0ta2D8eFmLC44kVSg7KSkkKAVL9ORFH2B0sfNk+Kz8aMK2lKZT+ZbrmX
	fkMesmQDGgRP/yoWEqqMWSTpcLQyA=
X-Received: by 2002:a05:6a20:a104:b0:3a2:e273:6b8d with SMTP id adf61e73a8af0-3ad99c240c7mr4830511637.38.1778605667213;
        Tue, 12 May 2026 10:07:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.246.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f127sm24539283b3a.5.2026.05.12.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:07:46 -0700 (PDT)
Message-Id: <3032e9c39a13a1826c24c3d2f2b229dab932439d.1778605658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
References: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
	<pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 17:07:36 +0000
Subject: [PATCH v8 3/5] branch: add --prune-merged <remote>
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
 Documentation/git-branch.adoc |  20 +++++
 builtin/branch.c              | 144 +++++++++++++++++++++++++++++-----
 t/t3200-branch.sh             |  96 +++++++++++++++++++++++
 3 files changed, 241 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5773104cd3..c3f5150f03 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <remote>...
+git branch [-f] --prune-merged <remote>...
 
 DESCRIPTION
 -----------
@@ -211,6 +212,25 @@ Each _<remote>_ may be either the name of a configured remote
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
+integrated). With `--force` (or `-f`), the reachability check is
+skipped and every branch in the candidate set is deleted. The
+currently checked-out branch in any worktree is always preserved,
+as is the local branch that mirrors _<remote>_'s default branch.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1941f8a9ad..50bf9774a8 100644
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
@@ -753,36 +756,132 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
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
 
+static int prune_merged_branches(int argc, const char **argv, int force,
+				 int quiet)
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
+				      1, force,
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
+	string_list_clear(&protected_default_refs, 0);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -825,6 +924,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +980,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches forked from the given <remote>s")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -924,7 +1026,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -933,7 +1036,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -971,12 +1074,15 @@ int cmd_branch(int argc,
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
+		ret = prune_merged_branches(argc, argv, force, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 24a3ec44ee..ca071338d3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,4 +1771,100 @@ test_expect_success '--forked requires at least one <remote>' '
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
+	test_grep "re-run with --force" err &&
+	test_grep ! "If you are sure you want to delete it" err &&
+	git -C pm-unmerged rev-parse --verify refs/heads/wip
+'
+
+test_expect_success '--prune-merged --force deletes branches regardless of reachability' '
+	test_when_finished "rm -rf pm-force" &&
+	git clone pm-upstream pm-force &&
+	git -C pm-force checkout -b wip origin/wip &&
+	git -C pm-force branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-force local-only &&
+	git -C pm-force checkout - &&
+
+	git -C pm-force branch --force --prune-merged origin &&
+
+	test_must_fail git -C pm-force rev-parse --verify refs/heads/wip
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
+	git -C pm-head branch --force --prune-merged origin &&
+
+	git -C pm-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged spares the local default branch' '
+	test_when_finished "rm -rf pm-default" &&
+	git clone pm-upstream pm-default &&
+	git -C pm-default checkout --detach &&
+	git -C pm-default branch --force --prune-merged origin &&
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

