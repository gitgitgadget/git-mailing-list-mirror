Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611192;
	b=YQOqoM8ioo5tJnIyzXCWF0F8tc/6nZDZU2ODxkqTwHlwXfr0Se+LxMr129Pgnb0FVVuM
	 810N6Dybh7jVbpNFfAvoA9leDQb/Lb4dRujez8pah/2IMdXbm0L+vq5vyNEf9X5t1CtMa
	 rk4p3iNAi3vVC9BsMfMx1RhaKK8LFd7vkDgtvSKpNlXgO57uhcwIADC3FLe9qvLw1JPv+
	 KmcznWzE1rbOKYlxxYZDDK02EsXY+M2pA/OWl3cyIOvLgj+G1kz+xD6e9dQuT4g4mxwqR
	 1VFWyjiR28LmsKaIi1Do9ijjgCJfgOB4XBxW3r+CW+T7seh+XXWyMBd2TiirG16GU6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=79txnamYkGgoMX2oYauOeClrkGxNkSyIMDuu+7GTcqQ=;
	b=4QRzhCPhr+L8VFQrMHIOcUGmrWir19cA0r3tV9bvdCx/CGdPtUNwcL71u4oDGHmwBYWb
	 7HUmYaPiGUXgc4N8QFeO6w+b0PZ/eaynwO9RiZ/Ub8CGE0YtsNiw8yR+qlnomZHg+5SU0
	 sIx2NIucLBsq7IuRhM95i/Q0oNfcBBHt+Z2AWkLptXx3U9bIic3w3p/RLENDaLbC6TlIH
	 +AVpHfvi4NEmtjiJ+8MQ1jX/ywv0f89qEkdh6A31xF0RnZ0ePrkBd23VbNgEkd7KTTGvW
	 LYEFFpKDikUjhjpZODv5sRUblLIOu/MCFpk6WIQ3nzd2sxe8q9GVOs+AZdmgUZxRBMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3W1IB7G;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA126606A69D
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA126606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3W1IB7G
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4adea5b7a2fso2052523fac.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 04:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795611189; x=1796215989; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=79txnamYkGgoMX2oYauOeClrkGxNkSyIMDuu+7GTcqQ=;
        b=v3W1IB7GqKTwjGtjPyPGqDjsWM8hGIloylqanWpHmMxZofUgF9mNgwjQ2My+uQWA8h
         R9tpMdFGcbLiO/e2SYajzQgGPzy9d206VxZwgYym7wMXM92UfEh6AUuI+8i7o6/u59C5
         v1q72U3aQhZIvEEA62qADVDrxz6tyOlES38OfO+5+Qb/1eTCCNuEz3WsHInUM1RpsPWk
         sViK0hc5uTAhg9txjAmagUjYcolo+gU0UCDWbQtCQwgXx/7fdYTbOc/Ip9J9utIEhLay
         MXZBt9Tx0g9Ax0WNNppzNNbvkP2x3G0HKqr+tXG4zf/LgCVQ6jy+lfXAjnVT3UXK4D5O
         cfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611189; x=1796215989;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79txnamYkGgoMX2oYauOeClrkGxNkSyIMDuu+7GTcqQ=;
        b=I8E0D+2cybA+YFRwWUKjp0yfytODdXgydVD/LOEREu3TFIottDwtZIBRZlCq6AFGYd
         FrEd8GFOjxMMb8ezALx4JA8bMhzuS8q9uXmcHKHdGesqJLMSZwaCWmz4EA123D+tFeqE
         BiHKZFrlOW7nNvgdhG8KzqQbUcuIw0FFSuAhS5pIqhLvd7ZMujoMTytDAHbOhUx4/ZTN
         bNrPyny5LO1GMcQcVKdPNQn1oG9LKjpZYlQsx+aQ/rJyVYng35dv/zeu5e2z7DNvDWBq
         MDn9O+s7ICi+LtrqJ+Jd63Re1z4eBn9Kt0px7bsxgmNx4jiS15Z7PqpooN4IoclNK/zo
         mtPA==
X-Gm-Message-State: APuU4Z9b9A6mrCeFZMTnN4uDH2czCdc0r9qCXHrK5uhSNBty7CagKZyP
	mcGFtz3N23H8p8Cogkp1lfVMPkkARjLiU3tfRFjosx1BPZMnsF9AaDB/vVzJ8sn9
X-Gm-Gg: AZFdTZeJS2VWHOPSb7SOe8wVKJjZDDXDY7cmUyIU23NZtK/TFd8sHpEBrPlqRbUokJL
	lpFveErv7a9fnQ2v+DzjypQV7jfLCZdNxUNatK5RccQs71zRrkmtEIERBYRfZGMm2uqif3KatAv
	cGDpJKKFqBL+8n6Vp+HWEdc35u8xGPmEimtpP0KMrIvAb5TpTbA9TtZINuc/ib8MNj+lKJBScyL
	zk5zJU7RhzC8oiCDzTV1GOW5e2evKKd5TIAZSU9PFX2wXqd5+LrSaNH6lup0MPK44rtCy/lGBZo
	Q2alY6ssvwARYfNILhKFcDISL/OTZHuFNU4qMO1wIC67tBQx4X7iLl2OfCYQcetCatbgeWESMUh
	BjMqU8DRx4enfiyhp/FwJZ4jObcJayW1FgWryoS9nRHRXh056xm4j40xcmdeL0F2M/aIY6T9G+L
	VeFrlY/ZxNygsE4Ihuh+GF0ae46UFcffnWz8auuUo2QlNM9+uUAS8DVpQqysOOL7lipks4aOE6s
	eG/5WWOS71pPsyDwpw4ZpOzwc5ln1op00jKB2ig9EswNFzNHiz4XUPgd8qlL3kfYvUYNYESiKAy
	kb0CoJ/bvRmKH5KQ3DtaPCzWz718qQZCm/2io2y7KSlNcG6cmKLp0Q==
X-Received: by 2002:a05:6808:2391:b0:4f4:3790:660b with SMTP id 5614622812f47-57a0a60d67amr18659458b6e.29.1795611188634;
        Wed, 25 Nov 2026 04:53:08 -0800 (PST)
Received: from [127.0.0.1] ([20.12.245.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35c5ac5dsm14164058b6e.15.2026.11.25.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:07 -0800 (PST)
Message-Id: <4b8282f2a5c211064697e8684c1870b310f6618f.1795611175.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 12:52:54 +0000
Subject: [PATCH v11 4/5] branch: add --delete-integrated for rebased or
 squash-merged branches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A branch that upstream integrated with

    git rebase main topic
    git checkout main
    git merge --ff-only topic

or with

    git merge --squash topic
    git commit

is never deleted by "git branch --delete-merged". This is what the
"Rebase and merge" and "Squash and merge" buttons on GitHub do. The
upstream holds rewritten copies of the branch's work, so its tip is not
reachable from it and it looks unmerged forever.

Add --delete-integrated, which does what --delete-merged does and also
deletes a branch when some upstream commit since the fork point has the
branch's version of every file the branch changed. That commit is named
in the output so the user can see where the work went:

    Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).

The first such commit is used, so the branch is deleted even if
upstream later reverted or reworked the changes. Nothing is lost, since
that commit keeps them in the upstream history. Who made that commit
does not matter, since the local branch is no longer needed either way.
A branch whose changes only partly landed is kept.

--delete-merged keeps deleting only branches whose own commits are in
the upstream, so it never removes a branch because somebody else made
the same change.

The check never reads file contents, so it stays cheap in a partial
clone.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |   8 +-
 Documentation/git-branch.adoc    |  25 ++-
 builtin/branch.c                 | 249 ++++++++++++++++++++++++++++-
 t/t3200-branch.sh                | 263 +++++++++++++++++++++++++++++++
 4 files changed, 529 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index c2acd89c99..be9b296bda 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -106,7 +106,7 @@ for details).
 
 `branch.<name>.deleteMerged`::
 	If set to `false`, branch _<name>_ is exempt from
-	`git branch --delete-merged`.  Useful for a topic branch you
-	intend to develop further after an initial round has been
-	merged upstream.  Defaults to true.  Explicit deletion via
-	`git branch -d` is unaffected.
+	`git branch --delete-merged` and `--delete-integrated`.  Useful
+	for a topic branch you intend to develop further after an
+	initial round has been merged upstream.  Defaults to true.
+	Explicit deletion via `git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 8efc4faed9..b496794d78 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -26,6 +26,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] [--dry-run] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
+git branch [--dry-run] (--delete-integrated <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
 -----------
@@ -235,14 +236,24 @@ A branch whose work has not yet been merged into its upstream is
 silently skipped. Delete it with `git branch -D` if you want to
 remove it anyway.
 
+`--delete-integrated <pattern>`::
+	Like `--delete-merged`, but also delete a branch whose changes
+	the upstream already has even though its commits are not there,
+	as happens after a squash or rebase merge. Such a branch is
+	deleted when some upstream commit since the fork point has its
+	version of every file it changed, even if those changes were
+	later reverted, and the message names the first such commit.
+	It does not matter who made that commit. The same rules for
+	which branches are kept apply as for `--delete-merged`.
+
 `--dry-run`::
-	With `-d`, `-D` or `--delete-merged`, print which branches
-	would be deleted and exit without touching any ref.  A branch
-	that cannot be deleted is reported as an error, the same as
-	without `--dry-run`.  Useful for sanity-checking a wide pattern
-	like `'origin/*'` before committing to the deletion.  Other
-	operations, such as creating or renaming a branch, do not
-	support it.
+	With `-d`, `-D`, `--delete-merged` or `--delete-integrated`,
+	print which branches would be deleted and exit without touching
+	any ref.  A branch that cannot be deleted is reported as an
+	error, the same as without `--dry-run`.  Useful for
+	sanity-checking a wide pattern like `'origin/*'` before
+	committing to the deletion.  Other operations, such as creating
+	or renaming a branch, do not support it.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 82452836d6..bb4c52c69a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -29,6 +29,12 @@
 #include "help.h"
 #include "advice.h"
 #include "commit-reach.h"
+#include "commit-slab.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "hex.h"
+#include "revision.h"
+#include "tree-walk.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
@@ -41,6 +47,8 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--format]"),
 	N_("git branch [<options>] (--delete-merged <pattern>)... "
 	   "[<branch-pattern>...]"),
+	N_("git branch [<options>] (--delete-integrated <pattern>)... "
+	   "[<branch-pattern>...]"),
 	NULL
 };
 
@@ -201,6 +209,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 	DELETE_BRANCH_DRY_RUN = (1 << 4),
+	DELETE_BRANCH_INTEGRATED = (1 << 5),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -844,6 +853,185 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+struct branch_change {
+	char *path;
+	struct object_id branch_oid;
+	unsigned short branch_mode;
+};
+
+struct landing_search {
+	const char *branch_name;
+	struct commit *rev;
+	struct commit *upstream;
+	struct branch_change *changes;
+	size_t changes_nr, changes_alloc;
+};
+
+define_commit_slab(changed_paths, struct string_list *);
+
+static void collect_branch_changes(struct landing_search *search,
+				   struct commit *base)
+{
+	struct diff_options diffopt;
+
+	repo_diff_setup(the_repository, &diffopt);
+	diffopt.flags.recursive = 1;
+	diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diffopt);
+	diff_tree_oid(get_commit_tree_oid(base),
+		      get_commit_tree_oid(search->rev), "", &diffopt);
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		struct branch_change *change;
+
+		ALLOC_GROW(search->changes, search->changes_nr + 1,
+			   search->changes_alloc);
+		change = &search->changes[search->changes_nr++];
+		change->path = xstrdup(p->two->path);
+		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
+		       &p->two->oid : null_oid(the_hash_algo));
+		change->branch_mode = p->two->mode;
+	}
+	diff_flush(&diffopt);
+}
+
+static int change_landed(const struct branch_change *change,
+			 struct commit *commit)
+{
+	struct object_id oid;
+	unsigned short mode;
+
+	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
+			   change->path, &oid, &mode) || S_ISDIR(mode))
+		return is_null_oid(&change->branch_oid);
+	return oideq(&oid, &change->branch_oid) &&
+	       mode == change->branch_mode;
+}
+
+static int changes_landed(struct landing_search *search,
+			  struct commit *commit)
+{
+	for (size_t i = 0; i < search->changes_nr; i++)
+		if (!change_landed(&search->changes[i], commit))
+			return 0;
+	return 1;
+}
+
+static struct string_list *changed_paths_of(struct changed_paths *cache,
+					    struct diff_options *diffopt,
+					    struct commit *commit)
+{
+	struct string_list **paths = changed_paths_at(cache, commit);
+	struct commit *parent;
+
+	if (*paths)
+		return *paths;
+
+	CALLOC_ARRAY(*paths, 1);
+	string_list_init_dup(*paths);
+	parent = commit->parents ? commit->parents->item : NULL;
+	if (parent && repo_parse_commit(the_repository, parent))
+		die(_("could not parse commit %s"),
+		    oid_to_hex(&parent->object.oid));
+	diff_tree_oid(parent ? get_commit_tree_oid(parent) : NULL,
+		      get_commit_tree_oid(commit), "", diffopt);
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		string_list_append(*paths, p->two->path);
+	}
+	diff_flush(diffopt);
+	string_list_sort(*paths);
+	return *paths;
+}
+
+static void free_changed_paths(struct string_list **paths)
+{
+	if (!*paths)
+		return;
+	string_list_clear(*paths, 0);
+	free(*paths);
+}
+
+static int touches_changes(struct string_list *paths,
+			   const struct landing_search *search)
+{
+	for (size_t i = 0; i < search->changes_nr; i++)
+		if (string_list_has_string(paths, search->changes[i].path))
+			return 1;
+	return 0;
+}
+
+static struct commit *find_landed_commit(struct landing_search *search,
+					 struct changed_paths *cache,
+					 struct diff_options *diffopt)
+{
+	struct commit *commit, *landed = NULL;
+	struct strvec args = STRVEC_INIT;
+	struct rev_info revs;
+
+	strvec_pushl(&args, "rev-list", "--reverse",
+		     oid_to_hex(&search->upstream->object.oid), NULL);
+	strvec_pushf(&args, "^%s", oid_to_hex(&search->rev->object.oid));
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+	while (!landed && (commit = get_revision(&revs)))
+		if (touches_changes(changed_paths_of(cache, diffopt, commit),
+				    search) &&
+		    changes_landed(search, commit))
+			landed = commit;
+	release_revisions(&revs);
+	clear_commit_marks(search->upstream, ALL_REV_FLAGS);
+	clear_commit_marks(search->rev, ALL_REV_FLAGS);
+	strvec_clear(&args);
+	return landed;
+}
+
+static void find_landed_commits(struct landing_search *searches,
+				size_t searches_nr,
+				struct strmap *landed_commits)
+{
+	struct changed_paths cache;
+	struct diff_options diffopt;
+
+	for (size_t i = 0; i < searches_nr; i++) {
+		struct landing_search *search = &searches[i];
+		struct commit_list *merge_bases = NULL;
+
+		if (repo_get_merge_bases(the_repository, search->upstream,
+					 search->rev, &merge_bases) < 0)
+			exit(128);
+		if (merge_bases)
+			collect_branch_changes(search, merge_bases->item);
+		commit_list_free(merge_bases);
+	}
+
+	repo_diff_setup(the_repository, &diffopt);
+	diffopt.flags.recursive = 1;
+	diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diffopt.no_free = 1;
+	diff_setup_done(&diffopt);
+	init_changed_paths(&cache);
+
+	for (size_t i = 0; i < searches_nr; i++) {
+		struct commit *landed;
+
+		if (!searches[i].changes_nr)
+			continue;
+		landed = find_landed_commit(&searches[i], &cache, &diffopt);
+		if (landed)
+			strmap_put(landed_commits, searches[i].branch_name,
+				   landed);
+	}
+
+	deep_clear_changed_paths(&cache, free_changed_paths);
+	diffopt.no_free = 0;
+	diff_free(&diffopt);
+}
+
 static bool opted_out_of_delete_merged(struct strbuf *key,
 				       const char *branch_name,
 				       unsigned int flags)
@@ -870,6 +1058,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
+	struct strmap landed_commits = STRMAP_INIT;
+	struct landing_search *searches = NULL;
+	size_t searches_nr = 0, searches_alloc = 0;
 	struct strvec branches_to_delete = STRVEC_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
@@ -904,13 +1095,39 @@ static int delete_merged_branches(const struct strvec *upstreams,
 			continue;
 		if (check_branch_commit(branch_name, branch_name,
 					&candidates.items[i]->objectname, NULL,
-					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
+					FILTER_REFS_BRANCHES,
+					DELETE_BRANCH_SKIP_UNMERGED)) {
+			struct commit *rev, *upstream;
+
+			if (!(flags & DELETE_BRANCH_INTEGRATED))
+				continue;
+			rev = lookup_commit_reference(
+				the_repository, &candidates.items[i]->objectname);
+			upstream = lookup_commit_reference_by_name(upstream_refname);
+			if (!rev || !upstream)
+				continue;
+			ALLOC_GROW(searches, searches_nr + 1, searches_alloc);
+			searches[searches_nr++] = (struct landing_search) {
+				.branch_name = branch_name,
+				.rev = rev,
+				.upstream = upstream,
+			};
 			continue;
+		}
 
 		if (!opted_out_of_delete_merged(&key, branch_name, flags))
 			strset_add(&deletable_branch_names, branch_name);
 	}
 
+	find_landed_commits(searches, searches_nr, &landed_commits);
+	for (size_t i = 0; i < searches_nr; i++) {
+		const char *branch_name = searches[i].branch_name;
+
+		if (strmap_contains(&landed_commits, branch_name) &&
+		    !opted_out_of_delete_merged(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
+	}
+
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
 				     &protected_branch_names);
 
@@ -922,7 +1139,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags, NULL);
+				      flags, &landed_commits);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -930,6 +1147,13 @@ static int delete_merged_branches(const struct strvec *upstreams,
 
 	strbuf_release(&key);
 	strvec_clear(&branches_to_delete);
+	for (size_t i = 0; i < searches_nr; i++) {
+		for (size_t j = 0; j < searches[i].changes_nr; j++)
+			free(searches[i].changes[j].path);
+		free(searches[i].changes);
+	}
+	free(searches);
+	strmap_clear(&landed_commits, 0);
 	strset_clear(&protected_branch_names);
 	strset_clear(&deletable_branch_names);
 	ref_array_clear(&candidates);
@@ -1002,6 +1226,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	struct strvec delete_integrated = STRVEC_INIT;
 	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
@@ -1059,6 +1284,9 @@ int cmd_branch(int argc,
 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
 			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
+		OPT_CALLBACK_F(0, "delete-integrated", &delete_integrated, N_("pattern"),
+			N_("like --delete-merged, but also delete branches whose changes landed upstream (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			N_("only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
@@ -1109,7 +1337,7 @@ int cmd_branch(int argc,
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !delete_merged.nr &&
-	    argc == 0)
+	    !delete_integrated.nr && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -1117,13 +1345,17 @@ int cmd_branch(int argc,
 	    filter.points_at.nr || filter.forked.nr)
 		list = 1;
 
+	die_for_incompatible_opt2(!!delete_merged.nr, "--delete-merged",
+				  !!delete_integrated.nr, "--delete-integrated");
+
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!delete_merged.nr;
+			    !!unset_upstream + !!delete_merged.nr +
+			    !!delete_integrated.nr;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
-	if (dry_run && !delete && !delete_merged.nr) {
+	if (dry_run && !delete && !delete_merged.nr && !delete_integrated.nr) {
 		if (rename)
 			die(_("--dry-run is not supported for branch renaming"));
 		if (copy)
@@ -1178,6 +1410,12 @@ int cmd_branch(int argc,
 					     (quiet ? DELETE_BRANCH_QUIET : 0) |
 					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
 		goto out;
+	} else if (delete_integrated.nr) {
+		ret = delete_merged_branches(&delete_integrated, argv,
+					     (quiet ? DELETE_BRANCH_QUIET : 0) |
+					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0) |
+					     DELETE_BRANCH_INTEGRATED);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
@@ -1357,6 +1595,7 @@ int cmd_branch(int argc,
 
 out:
 	strvec_clear(&delete_merged);
+	strvec_clear(&delete_integrated);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 55dda3b265..deead4be24 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1963,6 +1963,39 @@ check_branches () {
 	test_cmp expect actual
 }
 
+test_expect_success '--delete-merged does not delete unrelated branches' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b unrelated-topic --track origin/next &&
+		test_write_lines 1 2 3 4 >file &&
+		git add file &&
+		git commit -m "add file" &&
+		git push origin unrelated-topic &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 >file &&
+		test_write_lines 5 6 7 >elif &&
+		git add file elif &&
+		git commit --author="unrelated user <uu@example.com>" \
+			-m "unrelated commit adding an identical file" &&
+		git checkout main
+	) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		test_must_be_empty actual &&
+		check_branches <<-\EOF
+		main
+		unrelated-topic
+		EOF
+	)
+'
+
 test_expect_success '--delete-merged keeps cloned main without explicit push configuration' '
 	setup_repo_for_delete_merged &&
 	(
@@ -2017,6 +2050,209 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
 	)
 '
 
+push_topic () {
+	branch=$1 &&
+	shift &&
+	(
+		cd repo &&
+		git checkout -b "$branch" --track origin/next &&
+		for commit in "$@"
+		do
+			test_commit "$commit" || return 1
+		done &&
+		git push origin "$branch" &&
+		git checkout --detach
+	)
+}
+
+squash_merge_upstream () {
+	(
+		cd upstream &&
+		git checkout next &&
+		git merge --squash "$1" &&
+		git commit -m "Squash merge of $1" &&
+		git checkout main
+	)
+}
+
+rebase_merge_upstream () {
+	(
+		cd upstream &&
+		git rebase next "$1" &&
+		git checkout next &&
+		git merge --ff-only "$1" &&
+		git checkout main
+	)
+}
+
+test_expect_success '--delete-integrated deletes a rebase merged branch' '
+	setup_repo_for_delete_merged &&
+	push_topic rebased rebased-one rebased-two &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_commit before-rebase &&
+		git checkout main
+	) &&
+	rebase_merge_upstream rebased &&
+	landed=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short rebased) &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		echo "Deleted branch rebased (was $sha, landed as $landed)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-integrated deletes a squash merged branch' '
+	setup_repo_for_delete_merged &&
+	push_topic squashed squashed-one squashed-two &&
+	push_topic partial lands-upstream stays-local &&
+	squash_merge_upstream partial~1 &&
+	squash_merge_upstream squashed &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short squashed) &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		echo "Deleted branch squashed (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		partial
+		EOF
+	)
+'
+
+test_expect_success '--delete-integrated deletes a squash merged branch that was reverted' '
+	setup_repo_for_delete_merged &&
+	push_topic reverted reverted-work &&
+	squash_merge_upstream reverted &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		git revert --no-edit HEAD &&
+		git checkout main
+	) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short reverted) &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		echo "Deleted branch reverted (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
+	setup_repo_for_delete_merged &&
+	push_topic a-unmerged unmerged-work &&
+	push_topic b-merged merged-work &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_commit upstream-work &&
+		git merge --no-ff b-merged &&
+		git checkout main
+	) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short b-merged) &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		echo "Deleted branch b-merged (was $sha)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		a-unmerged
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-integrated deletes a squash merged branch that turned a file into a directory' '
+	(
+		cd upstream &&
+		git checkout next &&
+		echo content >item &&
+		git add item &&
+		git commit -m "add item" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b file-to-dir --track origin/next &&
+		git rm item &&
+		mkdir item &&
+		echo content >item/part &&
+		git add item &&
+		git commit -m "turn item into a directory" &&
+		git push origin file-to-dir &&
+		git checkout --detach
+	) &&
+	squash_merge_upstream file-to-dir &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short file-to-dir) &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		echo "Deleted branch file-to-dir (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-integrated honors --dry-run and --quiet' '
+	setup_repo_for_delete_merged &&
+	push_topic previewed previewed-work &&
+	squash_merge_upstream previewed &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short previewed) &&
+
+		git branch --dry-run --delete-integrated origin/next >actual 2>&1 &&
+		echo "Would delete branch previewed (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF &&
+		main
+		previewed
+		EOF
+
+		git branch --quiet --delete-integrated origin/next >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
 test_expect_success '--delete-merged keeps main despite a different default push remote' '
 	setup_repo_for_delete_merged &&
 	create_merged_branch on-next &&
@@ -2195,6 +2431,27 @@ test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
 	)
 '
 
+test_expect_success '--delete-integrated honours branch.<name>.deleteMerged=false' '
+	setup_repo_for_delete_merged &&
+	push_topic deleted opted-in-work &&
+	push_topic kept opted-out-work &&
+	squash_merge_upstream deleted &&
+	squash_merge_upstream kept &&
+	(
+		cd repo &&
+		git fetch origin &&
+		git config branch.kept.deleteMerged false &&
+
+		git branch --delete-integrated origin/next 2>err &&
+
+		test_grep "Skipping .kept." err &&
+		check_branches <<-\EOF
+		kept
+		main
+		EOF
+	)
+'
+
 test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	setup_repo_for_delete_merged &&
 	create_merged_branch kept &&
@@ -2264,4 +2521,10 @@ test_expect_success '--dry-run is not supported when not deleting branches' '
 	)
 '
 
+test_expect_success '--delete-integrated cannot be combined with --delete-merged' '
+	test_must_fail git -C forked branch --delete-merged origin/next \
+		--delete-integrated origin/next 2>err &&
+	test_grep "cannot be used together" err
+'
+
 test_done
-- 
gitgitgadget

