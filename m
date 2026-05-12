Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F4492537
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574243; cv=none; b=N+T4JwN8G2JUvkTY/I1Rr7MyYOUJsH5UrVpMJYSCQRc7f9hlDfLx8/yMi1W7rtEmMWifa5ARS38Vr7wQRwjaSU9NzfrlYFuY4Juq4Bu+nkmxsUaYkFq3x1UhrZxjhb/gHUsXu297+p3U9RuIOLokLYmO6ocTnl2U6eQCDEna9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574243; c=relaxed/simple;
	bh=FMrPDUEJvyNu8edBhTy2Bjr9zq2iCKXkXz2/UHAk2S8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PuetghzjdGlH+FH39iLtqgDle3wIVwMmD2YVHuoVoYGMZfKHKQHBqt9DYUQuZpRF2i4c3C0UkNgeU+goycdQoENnPrxvEQtp5oZ0IT6nJhRl/0SNLTUizeViuUWskmlGcQ2SebEHeC7ULXqT/DbxKcMbZgrORJNJDa2Mosog7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkutcHnq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkutcHnq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ee62a19730so598908785a.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778574236; x=1779179036; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+aUlreIe4YLU0b4KLjINYSwp2plP49dV7kE/3sFKvM=;
        b=NkutcHnqbK4UXVCS1zWQh/cEw46MPf1Y52PfL/PDRtTncm7EXCLyAvAUkxiJ8eQNW5
         ubjNicN6B5djqaab2hPr3dnF5681qJn7FCRmKIapttJT2FJZjPIIX8vjvx/sNrXIgICt
         c2axivShON9fWEFan7FcxzlQvJnYpPhi2XzELTNeuvUL7I/xepXP9QuSCKVaHmDJSgB+
         WO2QN9dGWfaONlWMQyj/ybNAEIIBDrP5QAyEB91/aIHPy6OEaq9LyXRQyjXDtKgy18SL
         OS7TZGOC6ULaUuHSol8jpAmsSWW2UsXdOo85nkRKV6OmVjqp2+8JZzMwSJWM7z/6512y
         IjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574236; x=1779179036;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+aUlreIe4YLU0b4KLjINYSwp2plP49dV7kE/3sFKvM=;
        b=agEW13PwewdZP9luyqxQWBPdWiHEPHRYuu1OUMriplcz1AO+8Nloo0ze0zMohMsdfb
         Xg0H+PR6FBgwnmESQJlBxiZueYg/LGExSeuswJl/pY2Gi8yLhjVAhVDZLMHpzM9E2UCj
         3wdLEh/YJ6AaoyNjId98nnaD5ypMlmESo73Y8Rj2Gw5d+K5ykbGLBg/xIxCovqg95tiU
         Xr7tWI0R2e6GOvxMAF/ERLF7oIiuo/u65/cuRZT5KkbY2BbB3K0GvtyvkxFoAea20yRO
         su61fNYk4sxhWpJx8Sxg/+q9vkNowNcoOIAPkSCnguf9LZV2kH9UqFvZ7L+3UMaQHLQ4
         9nJw==
X-Gm-Message-State: AOJu0YxgwUurEfKuVlUTxtqRV9Jcc7alHXNgjG30sworgKu+/TU27VDY
	zr34vyrh6/Mrc6/oQEySY/fHC56FK61CHEEbBlafLQXqF0HVd1RxBCqpNC1nSg==
X-Gm-Gg: Acq92OFo6UOBb1ENuZQbHSMrEAE90ETiKh9P46/+pUJbj6qDuRj87jXr/k99Wy5JKBC
	/Ei6UM0V8yP45cKG0c9RFWQ4FJ9nlDPryFrj2MqcUA12kPgleXlIIo/fQsRNl09r2+vxYHf/egr
	Ln3HKcTY+5VGBTOd3/mGWoHg8TRTuVQ07+n4fcvv77EkVrpM2PgZ1U3XqywOjicmHjf/sOKA6F9
	U1hgnLQUqnC6Dbf4yRD0Cge9DNfQZNWy6X9pbaXg21nXtnSIUmH2BT8ZPZ0Q29YRF2v75tA1zTM
	rRM43JGpI2531eAgXCLohROra1xDmmKC13DBjaeLc7wHKSmmbW9yda50PAirfwOWoZYbTaxE1NG
	EHLM8GfD2QPEa93eqPj512/mEdATuq4hPfAZZdAoOZ6K97SLWEIZVKt1TppiA0wZVk94cl1maIf
	ckW3zKT+2gT1CAX1nymSbjKx3E
X-Received: by 2002:a05:620a:bd3:b0:8fb:1ba7:bdf3 with SMTP id af79cd13be357-904d4679dbemr4060081085a.14.1778574236256;
        Tue, 12 May 2026 01:23:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986aeccsm1261066485a.4.2026.05.12.01.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:23:55 -0700 (PDT)
Message-Id: <a2450098932a734f47ebe5f2c800bd63f760b64c.1778574229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
References: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
	<pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 08:23:47 +0000
Subject: [PATCH v7 3/5] branch: add --prune-merged <remote>
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

Delete the local branches that --forked <remote> would list,
refusing any whose tip is not reachable from the remote's default
branch. With --force, delete unconditionally. The currently
checked-out branch in any worktree is always preserved.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  16 +++
 builtin/branch.c              | 181 ++++++++++++++++++++++++++++++----
 t/t3200-branch.sh             | 146 +++++++++++++++++++++++++++
 3 files changed, 323 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5773104cd3..1a5a5a9a54 100644
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
+As a safety check, branches with commits not yet integrated into
+their upstream remote-tracking branch are refused; if the upstream
+itself is gone, the remote's default branch is consulted instead.
+With `--force` (or `-f`), delete refused branches regardless. The
+currently checked-out branch in any worktree is always preserved.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1941f8a9ad..2eb7433b28 100644
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
@@ -131,7 +132,8 @@ static const char *branch_get_color(enum color_branch ix)
 }
 
 static int branch_merged(int kind, const char *name,
-			 struct commit *rev, struct commit *head_rev)
+			 struct commit *rev, struct commit *head_rev,
+			 int no_head_fallback)
 {
 	/*
 	 * This checks whether the merge bases of branch and HEAD (or
@@ -155,9 +157,33 @@ static int branch_merged(int kind, const char *name,
 					 &oid, NULL)) != NULL)
 			reference_rev = lookup_commit_reference(the_repository,
 								&oid);
+
+		if (!reference_rev && no_head_fallback && upstream &&
+		    starts_with(upstream, "refs/remotes/")) {
+			const char *remote_name = upstream + strlen("refs/remotes/");
+			const char *slash = strchr(remote_name, '/');
+			if (slash) {
+				struct strbuf head_ref = STRBUF_INIT;
+				strbuf_add(&head_ref, "refs/remotes/", strlen("refs/remotes/"));
+				strbuf_add(&head_ref, remote_name, slash - remote_name);
+				strbuf_addstr(&head_ref, "/HEAD");
+				if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+							    head_ref.buf,
+							    RESOLVE_REF_READING,
+							    &oid, NULL))
+					reference_rev = lookup_commit_reference(the_repository,
+										&oid);
+				strbuf_release(&head_ref);
+			}
+		}
 	}
-	if (!reference_rev)
+	if (!reference_rev) {
+		if (no_head_fallback) {
+			free(reference_name_to_free);
+			return 0;
+		}
 		reference_rev = head_rev;
+	}
 
 	merged = reference_rev ? repo_in_merge_bases(the_repository, rev,
 						     reference_rev) : 0;
@@ -171,7 +197,7 @@ static int branch_merged(int kind, const char *name,
 	 * any of the following code, but during the transition period,
 	 * a gentle reminder is in order.
 	 */
-	if (head_rev != reference_rev) {
+	if (!no_head_fallback && head_rev != reference_rev) {
 		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
 		if (expect < 0)
 			exit(128);
@@ -192,6 +218,7 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
+			       int no_head_fallback,
 			       int kinds, int force, int warn_only,
 			       int *n_not_merged)
 {
@@ -200,7 +227,8 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
-	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
+	if (!force && !branch_merged(kinds, branchname, rev, head_rev,
+				     no_head_fallback)) {
 		if (warn_only) {
 			warning(_("the branch '%s' is not fully merged"),
 				branchname);
@@ -227,7 +255,9 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds,
+static int delete_branches(int argc, const char **argv,
+			   int no_head_fallback,
+			   int force, int kinds,
 			   int quiet, int warn_only, int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
@@ -317,8 +347,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		}
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
-		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force, warn_only, n_not_merged)) {
+		    check_branch_commit(bname.buf, name, &oid, head_rev,
+					no_head_fallback,
+					kinds, force, warn_only, n_not_merged)) {
 			if (!warn_only)
 				ret = 1;
 			goto next;
@@ -753,36 +784,139 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
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
+		const char *push_ref;
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
+		if (upstream &&
+		    string_list_has_string(&protected_default_refs, upstream)) {
+			const char *leaf = strrchr(upstream, '/');
+			if (leaf && !strcmp(leaf + 1, short_name))
+				continue;
+		}
+
+		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
+		if (!push_ref)
+			continue;
+		if (refs_ref_exists(get_main_ref_store(the_repository),
+				    push_ref))
+			continue;
+		if (string_list_has_string(&protected_default_refs, push_ref))
+			continue;
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
@@ -825,6 +959,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +1015,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches forked from the given <remote>s")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -924,7 +1061,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -933,7 +1071,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -971,12 +1109,15 @@ int cmd_branch(int argc,
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
index 24a3ec44ee..f0d1250dbf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,4 +1771,150 @@ test_expect_success '--forked requires at least one <remote>' '
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
+test_expect_success '--prune-merged falls back to remote default branch when upstream is gone' '
+	test_when_finished "rm -rf pm-fallback" &&
+	git clone pm-upstream pm-fallback &&
+	git -C pm-fallback branch one --track origin/one &&
+	git -C pm-fallback update-ref -d refs/remotes/origin/one &&
+	# Detach HEAD to an unrelated commit so the candidate is not
+	# reachable from local HEAD. The upstream origin/one is now
+	# gone; the merged-ness check should fall back to
+	# refs/remotes/origin/HEAD, against which "one" is reachable.
+	git -C pm-fallback commit --allow-empty -m unrelated &&
+	git -C pm-fallback checkout --detach &&
+	git -C pm-fallback reset --hard HEAD^ &&
+
+	git -C pm-fallback branch --prune-merged origin &&
+
+	test_must_fail git -C pm-fallback rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged refuses when upstream and remote default are both gone' '
+	test_when_finished "rm -rf pm-both-gone" &&
+	git clone pm-upstream pm-both-gone &&
+	git -C pm-both-gone checkout -b one --track origin/one &&
+	test_commit -C pm-both-gone unpushed &&
+	git -C pm-both-gone checkout - &&
+
+	git -C pm-both-gone update-ref -d refs/remotes/origin/HEAD &&
+	git -C pm-both-gone update-ref -d refs/remotes/origin/one &&
+	git -C pm-both-gone branch --prune-merged origin 2>err &&
+	test_grep "not fully merged" err &&
+
+	git -C pm-both-gone rev-parse --verify refs/heads/one
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
+	git -C pm-pushdiff branch --track topic-a origin/one &&
+
+	git -C pm-pushdiff branch --force --prune-merged origin &&
+
+	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
+'
+
+test_expect_success '--prune-merged spares the local default branch' '
+	test_when_finished "rm -rf pm-default" &&
+	git clone pm-upstream pm-default &&
+	git -C pm-default config push.default current &&
+	git -C pm-default checkout --detach &&
+	git -C pm-default branch --prune-merged origin &&
+	git -C pm-default rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged protects only the default branch by name, not by upstream' '
+	test_when_finished "rm -rf pm-default-alias" &&
+	git clone pm-upstream pm-default-alias &&
+	git -C pm-default-alias config push.default current &&
+	git -C pm-default-alias branch --track trunk origin/main &&
+	git -C pm-default-alias checkout --detach &&
+	git -C pm-default-alias branch --force --prune-merged origin &&
+	git -C pm-default-alias rev-parse --verify refs/heads/main &&
+	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
+'
+
+test_expect_success '--prune-merged spares branches whose push ref is the default branch' '
+	test_when_finished "rm -rf pm-pushdefault" &&
+	git clone pm-upstream pm-pushdefault &&
+	git -C pm-pushdefault branch --track topic origin/one &&
+	git -C pm-pushdefault config --add remote.origin.push refs/heads/topic:refs/heads/main &&
+	git -C pm-pushdefault update-ref -d refs/remotes/origin/one &&
+	git -C pm-pushdefault update-ref -d refs/remotes/origin/main &&
+	git -C pm-pushdefault checkout --detach &&
+	git -C pm-pushdefault branch --prune-merged origin &&
+	git -C pm-pushdefault rev-parse --verify refs/heads/topic
+'
+
 test_done
-- 
gitgitgadget

