Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709037E5FB
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939897; cv=none; b=K5kU1nohEYGyj5aaTUFq2AcnOxjqdGXqcZitvgozL7dKo7dgk1GFZYGtoLS8b0DMce730G+C2Q0val9EX5CEM0qylrmHUaCfFbg6ofCGrS6Aj40r8aV1+c7dv+XVwZLONXrd1U+TZ9S7JHhcg30rjj0cOHKEqo7x0z9w7e4n5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939897; c=relaxed/simple;
	bh=65DlGHrgkqTEr+L4R2jFeQ4JFdqZ/vj6WQ4Gd24IJBg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iQWQEDO3ZisNlI/nZLyj9wHoPrPhJ/q0TwoM5JCJ4Y0p5aHobckNJs59sk4d1Xa9oySzrCGMb4Yj3N/I2CoF2zF0eT0ixEoSFY0nSUGcqmFmL7bU6sZgcusLFI/rmZsmWd+RqW2jDeUrsHlB4ZY22qzuLnbPv+Sk6l9iOWhzTrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6gyjuZd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6gyjuZd"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cab973140bso14530075ad.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939889; x=1786544689; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ywWpnlcFqZzmm6csFBBITktqqoMb96Faiy6Mb+FQAeo=;
        b=f6gyjuZdufnRH+om1G4Zi6bLKVjc1oRagMv8/tjoDByp1oC5j2X8rVL2b+RdAQRoQx
         ZhGE9YNvvDwHXNXVweoCWOjydj0HbbmJM7WSVop+PuooJf+yrxov1+yGNFumeK6vJge6
         zzWO13QGXB9m/EiBkmrVTXITwBGOyECQm6VgcvXGo59aY0AnxQagg4H3uAVraMbVsW4F
         8tYiY2EVx+5U1lg4xZHKwRYQfj4RmDudmc4VNVlC5zFSioeEPKnxNpi7pefVHhYXBuWe
         KmNKCZLXX0fTVyMF0g5IfFETLUGIblyEAUnlTor8nYrNCbFFSA5nzNnYCkpOR+iDY9kb
         e9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939889; x=1786544689;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywWpnlcFqZzmm6csFBBITktqqoMb96Faiy6Mb+FQAeo=;
        b=dbeQL/3yxGvrh0mNi7huYz88TksHIOECe3ThbGpAoJl5oqfj7dM5q+7DNI9HyHbC0O
         NRF1XOpCCpwBkgJi4+zMaA4ZjD7i+jhMWRVdJNZmTB3P7+lnPiwKS4lyrqL7soJpy068
         I4x3ngJcSd8RdqCIVeFNkzbsbGM7qrly5rmtKSksZFfXk1cOU9t6ayuY2eSRInMpit0R
         4UcCrvHizxvSpsKazlkgr0lYkrL6PcjFTOHk3U4nLTLPzqHN8CviSoj44Q/pLwuZvoWN
         uJdbrLNH6+FhSLy3ZsKIhPiUGJ32Yor3e2MZKC8DvxRmGYO9Luetl41Qd6cC4LMen17U
         gspQ==
X-Gm-Message-State: AOJu0YwUbxBK3cOR3DarWfpRSvW0fFBBHjbOpmn88Wkg2mYlBU5gTv7s
	eqfrbu70gr7LyYhxAoUYVh2UIiWOL4xnquxyuZdKz0fFWL631Ac11kTo/tI5Rg==
X-Gm-Gg: AR+sD10Z8CEj/gXObPKnQ5oZ/31OJ5hjldV4nMpErT3jhTwc/1ws5euaIae75gCyFZY
	IrszUg+3UyjjPgF39u5eNqE8EUUbp8JHoptyX1eo04MQXC1qa2cZLf9bmpkd8EYT4iocAb4cdw4
	2HSJSMbJLFk1s3p+4KibRzWVcg4tuVhrIt2wmvRxOBwxBPZnT5ZcQtLehjVIhfjSVQG/w27OIwA
	I0vKM02j8LAq3yGogJKJh3R/TZR1cBpeK6xEWB1FhPHHutTMXapOlchkIgA1/8mG7jQANMB6LI2
	CdWU4/E/gsca4HDVLINNdtQMhIOLw3rdg00+V+zotKF9TQyQNz3pNvsL3Y7d4ZxadWNOnNOkXor
	tt3u33He+zYoiFcN5GGaSSRQvpx/emFwemUT3+F/Rb6huhYd8zR8IIuPjqdBfgiOdPnYsRYYmkA
	Wxr6qaywlA1szMCX7pSR2ER3xYttZzztBxxQ7ZuUMwj0PNnCtNk5H6vO6N396yncDyp/GVuJCbJ
	iD0
X-Received: by 2002:a17:903:245:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d0ca7aea8cmr77525465ad.8.1785939888775;
        Wed, 05 Aug 2026 07:24:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673b7b2sm17424967eec.19.2026.08.05.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:48 -0700 (PDT)
Message-Id: <a5ef60a39415bd2a2c7593225e0c5522246ae2ac.1785939877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:24:35 +0000
Subject: [PATCH v25 5/7] branch: add --delete-merged <pattern>
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

    git branch (--delete-merged <pattern>)... [<branch-pattern>...]

deletes local branches matching the optional branch patterns when their
configured upstream matches one of the --delete-merged arguments and
their tip is reachable from that upstream. The work has already landed
on the upstream they track, so the local copy is no longer needed.

Each <pattern> may name a ref, a remote, or a shell glob. The option can
be repeated to widen the upstream match. Keeping the candidate patterns
as positional arguments lets users bound the set of local branches that
may be deleted independently of the upstream selection.

A branch is not deleted when:

  * it is checked out in any worktree
  * its configured upstream ref no longer exists, since a missing
    upstream is not by itself a sign of integration
  * pushing it to the remote configured by branch.<name>.remote would
    update its upstream, as determined by that remote's configured push
    and fetch refspecs. For example, a local "main" that tracks
    "origin/main" is kept even when remote.pushDefault names a fork.
    Right after a pull it merely looks fully merged.
  * it is the local upstream of a branch that is not being deleted, so
    no branch is deleted out from under stacked work.

A branch whose work is not yet merged into its upstream is silently
skipped, so one unmerged topic does not abort the whole sweep.

Collect protected local upstreams without changing the candidate set
during ref iteration, then remove them after iteration. This makes the
result independent of ref iteration order. If a protected branch's own
upstream is deleted by the same sweep, clear its upstream configuration.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  33 +++++
 builtin/branch.c              | 195 +++++++++++++++++++++++++++++-
 t/t3200-branch.sh             | 219 ++++++++++++++++++++++++++++++++++
 3 files changed, 445 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index b0d66a6deb..4766178204 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch (--delete-merged <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
 -----------
@@ -201,6 +202,38 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--delete-merged <pattern>`::
+	Delete local branches whose configured upstream matches
+	_<pattern>_, but only when their tip is reachable from that
+	upstream. In other words, the work on the branch has already
+	landed on the upstream it tracks, so the local copy is no longer
+	needed. _<pattern>_ may name a ref, a remote (using the branch its
+	`HEAD` points at), or a shell-style glob. The option can be
+	repeated to widen the upstream match.
+	Optional _<branch-pattern>_ arguments limit which local branches
+	are considered, e.g. `git branch --delete-merged 'origin/*'
+	'topic-*'`.
++
+A branch is not deleted when:
++
+--
+* its configured upstream ref no longer exists,
+* it is checked out in any worktree,
+* pushing it to the remote configured by
+  `branch.<name>.remote` would update its upstream, so it cannot be
+  distinguished from a branch that just looks fully merged right
+  after a pull; this is determined by the remote's configured push and
+  fetch refspecs,
+* it is the local upstream of a branch that is not being deleted.
+--
++
+When such a local upstream branch has its own upstream deleted by the
+same operation, its upstream configuration is cleared.
++
+A branch whose work has not yet been merged into its upstream is
+silently skipped. Delete it with `git branch -D` if you want to
+remove it anyway.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b0aa68572..f1a73bcea1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -21,6 +21,7 @@
 #include "branch.h"
 #include "path.h"
 #include "string-list.h"
+#include "strmap.h"
 #include "column.h"
 #include "utf8.h"
 #include "ref-filter.h"
@@ -38,6 +39,8 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] (--delete-merged <pattern>)... "
+	   "[<branch-pattern>...]"),
 	NULL
 };
 
@@ -700,6 +703,184 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 	return 0;
 }
 
+struct stacked_branch_data {
+	struct strset *deletable_branch_names;
+	struct strset *protected_branch_names;
+};
+
+static int collect_stacked_branch_base(const struct reference *ref,
+				       void *cb_data)
+{
+	struct stacked_branch_data *data = cb_data;
+	const char *branch_name;
+	struct branch *branch;
+	const char *upstream_refname;
+	const char *upstream_branch_name;
+
+	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
+		BUG("expected local branch ref, got '%s'", ref->name);
+	if (strset_contains(data->deletable_branch_names, branch_name))
+		return 0;
+
+	branch = branch_get(branch_name);
+	upstream_refname = branch_get_upstream(branch, NULL);
+	if (!upstream_refname ||
+	    !skip_prefix(upstream_refname, "refs/heads/",
+			 &upstream_branch_name) ||
+	    !strset_contains(data->deletable_branch_names,
+			    upstream_branch_name))
+		return 0;
+
+	strset_add(data->protected_branch_names, upstream_branch_name);
+	return 0;
+}
+
+static void protect_stacked_branch_bases(struct ref_store *refs,
+					 struct strset *deletable_branch_names,
+					 struct strset *protected_branch_names)
+{
+	struct stacked_branch_data data = {
+		.deletable_branch_names = deletable_branch_names,
+		.protected_branch_names = protected_branch_names,
+	};
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/heads/",
+	};
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	refs_for_each_ref_ext(refs, collect_stacked_branch_base, &data, &opts);
+
+	strset_for_each_entry(protected_branch_names, &iter, entry)
+		strset_remove(deletable_branch_names, entry->key);
+}
+
+static void clear_deleted_upstreams(struct strset *protected_branch_names,
+				    struct strset *deletable_branch_names)
+{
+	struct strbuf key = STRBUF_INIT;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strset_for_each_entry(protected_branch_names, &iter, entry) {
+		struct branch *branch = branch_get(entry->key);
+		const char *upstream_refname = branch_get_upstream(branch, NULL);
+		const char *upstream_branch_name;
+
+		if (!upstream_refname ||
+		    !skip_prefix(upstream_refname, "refs/heads/",
+				 &upstream_branch_name) ||
+		    !strset_contains(deletable_branch_names,
+				    upstream_branch_name))
+			continue;
+
+		strbuf_addf(&key, "branch.%s.merge", branch->name);
+		repo_config_set_gently(the_repository, key.buf, NULL);
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.remote", branch->name);
+		repo_config_set_gently(the_repository, key.buf, NULL);
+		strbuf_reset(&key);
+	}
+
+	strbuf_release(&key);
+}
+
+static int branch_pushes_to_upstream(struct branch *branch,
+				     const char *upstream)
+{
+	struct remote *remote = remote_get(remote_for_branch(branch, NULL));
+	char *push_refname = NULL;
+	char *tracking = NULL;
+	int ret = 0;
+
+	if (!remote)
+		return 0;
+	if (remote->push.nr)
+		push_refname = apply_refspecs(&remote->push, branch->refname);
+	else
+		push_refname = xstrdup(branch->refname);
+	if (push_refname)
+		tracking = apply_refspecs(&remote->fetch, push_refname);
+	if (tracking && !strcmp(tracking, upstream))
+		ret = 1;
+
+	free(push_refname);
+	free(tracking);
+	return ret;
+}
+
+static int delete_merged_branches(const struct strvec *upstreams,
+				 const char **argv, unsigned int flags)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array candidates = { 0 };
+	struct strset deletable_branch_names = STRSET_INIT;
+	struct strset protected_branch_names = STRSET_INIT;
+	struct strvec branches_to_delete = STRVEC_INIT;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	int ret = 0;
+
+	for (size_t i = 0; i < upstreams->nr; i++)
+		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
+			die(_("'%s' is not a valid branch or pattern"),
+			    upstreams->v[i]);
+
+	filter.kind = FILTER_REFS_BRANCHES;
+	filter.name_patterns = argv;
+	filter_refs(&candidates, &filter, filter.kind);
+
+	for (int i = 0; i < candidates.nr; i++) {
+		const char *branch_refname = candidates.items[i]->refname;
+		const char *branch_name;
+		struct branch *branch;
+		const char *upstream_refname;
+
+		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
+			BUG("filter returned non-branch ref '%s'", branch_refname);
+		if (branch_checked_out(branch_refname))
+			continue;
+
+		branch = branch_get(branch_name);
+		upstream_refname = branch_get_upstream(branch, NULL);
+		if (!upstream_refname || !refs_ref_exists(refs, upstream_refname))
+			continue;
+		if (branch_pushes_to_upstream(branch, upstream_refname))
+			continue;
+		if (check_branch_commit(branch_name, branch_name,
+					&candidates.items[i]->objectname, NULL,
+					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
+			continue;
+
+		strset_add(&deletable_branch_names, branch_name);
+	}
+
+	protect_stacked_branch_bases(refs, &deletable_branch_names,
+				     &protected_branch_names);
+
+	strset_for_each_entry(&deletable_branch_names, &iter, entry)
+		strvec_push(&branches_to_delete, entry->key);
+
+	if (branches_to_delete.nr)
+		ret = delete_branches(branches_to_delete.nr, branches_to_delete.v,
+				      FILTER_REFS_BRANCHES,
+				      DELETE_BRANCH_SKIP_UNMERGED |
+				      DELETE_BRANCH_NO_HEAD_FALLBACK |
+				      flags);
+
+	if (!ret)
+		clear_deleted_upstreams(&protected_branch_names,
+					&deletable_branch_names);
+
+	strvec_clear(&branches_to_delete);
+	strset_clear(&protected_branch_names);
+	strset_clear(&deletable_branch_names);
+	ref_array_clear(&candidates);
+	ref_filter_clear(&filter);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -764,6 +945,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	struct strvec delete_merged = STRVEC_INIT;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -817,6 +999,9 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
+			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -864,7 +1049,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !delete_merged.nr &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -874,7 +1060,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!delete_merged.nr;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -916,6 +1102,10 @@ int cmd_branch(int argc,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
+	} else if (delete_merged.nr) {
+		ret = delete_merged_branches(&delete_merged, argv,
+					     quiet ? DELETE_BRANCH_QUIET : 0);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
@@ -1087,6 +1277,7 @@ int cmd_branch(int argc,
 	ret = 0;
 
 out:
+	strvec_clear(&delete_merged);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c2f3fd8fa8..496072a3fe 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1884,4 +1884,223 @@ test_expect_success '--forked requires a value' '
 	test_grep "requires a value" err
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
+		git config push.default current &&
+		git fetch other
+	)
+}
+
+create_merged_branch () {
+	(
+		cd repo &&
+		git checkout -b "$1" --track origin/next &&
+		git commit --allow-empty -m "$1 work" &&
+		git push origin "$1:next"
+	)
+}
+
+check_branches () {
+	git for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success '--delete-merged keeps cloned main without explicit push configuration' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		test_cmp_config origin branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge &&
+		git checkout --detach &&
+
+		git branch --delete-merged */* &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged deletes only selected merged branches' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch also-merged &&
+	create_merged_branch merged &&
+	(
+		cd repo &&
+		git checkout -b unmerged --track origin/next &&
+		git commit --allow-empty -m "unmerged work" &&
+		git checkout -b tracks-other --track other/main &&
+		sha=$(git rev-parse --short merged) &&
+
+		git branch --delete-merged origin/next merged >actual 2>&1 &&
+		echo "Deleted branch merged (was $sha)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		also-merged
+		main
+		tracks-other
+		unmerged
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged keeps main despite a different default push remote' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch on-next &&
+	create_merged_branch checked-out &&
+	create_merged_branch upstream-gone &&
+	(
+		cd repo &&
+		git config remote.pushDefault fork &&
+		git checkout -b local-to-delete --track main &&
+		git config branch.upstream-gone.merge refs/heads/topic &&
+		git checkout -b tracks-other --track other/main &&
+		git checkout checked-out &&
+
+		git branch --delete-merged origin/* --delete-merged main &&
+
+		check_branches <<-\EOF
+		checked-out
+		main
+		tracks-other
+		upstream-gone
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged maps push refspecs to upstreams' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b topic &&
+		git config remote.origin.push \
+			"refs/heads/topic:refs/heads/published" &&
+		git push origin &&
+		git branch --set-upstream-to=origin/published topic &&
+		git checkout -b other-topic --track origin/published &&
+		git checkout --detach &&
+
+		git branch --delete-merged origin/published &&
+
+		check_branches <<-\EOF
+		main
+		topic
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch feature &&
+	(
+		cd repo &&
+		git checkout -b topic --track feature &&
+		git commit --allow-empty -m "topic work" &&
+
+		git branch --delete-merged origin/next 2>err &&
+
+		test_must_be_empty err &&
+		check_branches <<-\EOF &&
+		feature
+		main
+		topic
+		EOF
+
+		pattern="branch\\.(feature|topic)\\.(merge|remote)" &&
+		git config --local --get-regexp "$pattern" >actual &&
+		cat >expect <<-\EOF &&
+		branch.feature.remote origin
+		branch.feature.merge refs/heads/next
+		branch.topic.remote .
+		branch.topic.merge refs/heads/feature
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--delete-merged clears the deleted upstream of a protected branch' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git branch --track lower origin/next &&
+		git branch --track mid lower &&
+		git checkout -b tip --track mid &&
+		git commit --allow-empty -m "tip work" &&
+		sha=$(git rev-parse --short lower) &&
+
+		git branch --delete-merged origin/next \
+			--delete-merged lower >actual 2>&1 &&
+		echo "Deleted branch lower (was $sha)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF &&
+		main
+		mid
+		tip
+		EOF
+
+		pattern="branch\\.(mid|tip)\\.(merge|remote)" &&
+		git config --local --get-regexp "$pattern" >actual &&
+		cat >expect <<-\EOF &&
+		branch.tip.remote .
+		branch.tip.merge refs/heads/mid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--delete-merged result is independent of stacked branch names' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git branch --track c-lower origin/next &&
+		git branch --track b-mid c-lower &&
+		git checkout -b a-tip --track b-mid &&
+		git commit --allow-empty -m "tip work" &&
+
+		git branch --delete-merged origin/next --delete-merged "c-*" &&
+
+		check_branches <<-\EOF &&
+		a-tip
+		b-mid
+		main
+		EOF
+
+		git branch --delete-merged origin/next \
+			--delete-merged "c-*" >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		check_branches <<-\EOF
+		a-tip
+		b-mid
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged requires a value' '
+	test_must_fail git -C forked branch --delete-merged 2>err &&
+	test_grep "requires a value" err
+'
 test_done
-- 
gitgitgadget

