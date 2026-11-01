Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521337;
	b=mZptziYDdg1Q3YMfCidDkOtdSrPv4TXHXn20+O9ALfgBr4cS+k+AMooJeP2BCDuIf6Xx
	 T0b3gKLSr0S6MXphiawRg1/Z6Sb3G+ZOs4EPddlRI+dahJ1GcKJjowkgUUTISSigL69ff
	 honfqtGaqCbCVVDg3zx2eXk2jvE/Ke/tlLEZFq2IDawjjg+1kY/Zy3xS2L9c72gvXvaTW
	 aR7+LQyfGiMw/xPWV1Chuhbzw30/N8Z0qrPtRgOFit8mpHAdyMdSmt56/KXdmMU3ycm7z
	 GwY1pCcKwhrA2Y6l32XSvNGvsbZTiyht3sE2VC7oAUL4oTJdKOW82Z6rrdf9xfqHlSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=P4g3noDP9kSVPe+INlxP7VwpDEdaYRfPgP5ObhWq++0=;
	b=YY0xV7j4+jc4yr1UKg+fP1kK9ylqE4Yuk5ti0ZAO0LcwARlcIDt5Hcbi4NsXFoVKdp+y
	 xPjzg9iF7DWRS2TfYBYUYMGXBZdczGgE+fi+SR/hfU2h+1crC+vxmlhctx5ZbJ2btDhOp
	 7Gs6jgjBqvuU62dQ8mymxMafT3bcApqnWTINsHkzOf5TTHsNlvRXgcADsRmdgD1/Pyhr2
	 vEJVAh+fapXYbe/ISszfS81brtbDGv6HDGDoBukCHqndMdN8c5m+dfVwnaeRgePAf17Mv
	 98jB9LaFvcx+0N7FYFgGlZofxVSKZ1suihWCIo2fLkjJTmKOIGrNKcDL5H7zuoUjW8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBvXmlXa;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330E606A326
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3330E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBvXmlXa
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14394530ec6so2545806c88.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521336; x=1794126136; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P4g3noDP9kSVPe+INlxP7VwpDEdaYRfPgP5ObhWq++0=;
        b=lBvXmlXa+YbVr9BP0UMiVCGNZkkr0biZrBvivb+q+KIhgVtv11fOO7mbt+Ieyia7oO
         ITPQU8u+DF8bhqXNLRbeH4BloXUTJ1yQL8GYoBKNT/44p7DJ0RhrskATx6cTM259FIbz
         KMpeg6+SOVeBMTZcGxQ+s4VEMFB8FWB0iymCrdh/zxDXdbtBsgM21vqO4MBaebhvGhuO
         2yL8Q3zAPAQ7Tb7OaDGWl5eQETNo9rzI7+FIZBxD1KrrTCsJxeDzk4BwSH6yJeItEPfG
         oKEGfvCd+mhNIMLwW4vTGm9N/75KtNOzaNbroAXl7wD+ZXNi6JlaGPXjK4WRJ/zL14hy
         QjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521336; x=1794126136;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4g3noDP9kSVPe+INlxP7VwpDEdaYRfPgP5ObhWq++0=;
        b=WrXyAxIkr4qHP5IeHVRkOb69RW7syRZ9gIQgyMVGaYJPE+b0dg1tBQZkYqBjGkZs7S
         JcsHLee7+DnVYzl75Hzp6Vegl4LOdYznzbNZqkJlarjuHQ1Al6Rz6XycIwus670NRTVd
         yUpMZCfXtHqA+0lPeNkyS249vErx4E4YxkUk5GMngzWK2luN42i7iIFVYYNRnbgMB5V0
         4NDBPMB5jQ4NuTWftCQ+cXdIkhDlY/a6xUbwKp7VRIp4uVnZBsIdJA2qFUB4z3SrDxLC
         ppGUicK55Lm/6vb8Uu+4GGvULFACcfSI223oN6Mx9k3wYFoEzb0r4T8CtQP3KTx/pf3+
         Fceg==
X-Gm-Message-State: AFq9FYKv/ALq2Admvs9NhgTAXHYGY+LszoIjYP6x4t43IcGoH3AmG8yC
	qeKiDQroz1QUgjpECoZf3ULYFuhH1mGoMmr/hxJMIF15BCBCDa7N4UV7eM8gYpPIWOE=
X-Gm-Gg: AYBFou2eXn15OKxKoP2OrliL/M13c+MzFW0Oh6NsXXcmwmVRMPSnjdOJ00qIHfFSc23
	BLIks26oP2hOkNa4OHbDCBXSlcTpIjnOEWRVU76Io6gccGjy7OqJbOl9GjEiXnyA6E4sDYDeRV2
	CobIZUBPs1qLqhsCfiaeW6GbsHoE/63PNNrzlHO8oAiyulq3G16YymtYMIkjccRYXrENjc19udY
	JmA7vf62ctgjn0aSEwdgJfz6DhlYG0uHlxJvTtarRzuqsUhimSCTTm/oj5Hw2DYr9p27/iD5JQC
	py1lrpwpyXz9iNG7oSqh8f6jN7fAf9tzPaRZxVbRVlY7/BdvNFVVQaruyYpi5CYeNUWTmJRpS+I
	B5FnlOQF+Plsn/rdzo6asIIvwuxdVSgy1G8GCUWYwfnudTP7NTZP4bme/DfcdCLhbLDJR40LnwH
	FyQNMPrIMi9s89Y7Q2Jdtbqp4J8PwWfz0W/HX6tIHkbiihK4bIGnwielmWna4xuKBnmw+LNd/zE
	CpPkFuBXRHZaibCbgGek23rNQ7XsW274+6sVHY2Xaod6sEvvpJwSeK52Q39CyVZt6ASiVceRrj9
	7bppwnFL0PLdUiRFMWbwr9jjk1O7bLw=
X-Received: by 2002:a05:7022:7f17:b0:168:3243:c937 with SMTP id a92af1059eb24-1ac5cb1c8b3mr11942423c88.16.1793521336021;
        Sun, 01 Nov 2026 01:22:16 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.197.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4b08bsm25675584c88.16.2026.11.01.01.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:22:15 -0700 (PDT)
Message-Id: <92bd9afda49e429d2c958824af532f7ae57998b7.1793521331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:22:10 +0000
Subject: [PATCH v6 3/4] branch: add --delete-integrated to delete rebase and
 squash merged branches
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
 Documentation/git-branch.adoc    |  19 ++-
 builtin/branch.c                 | 253 ++++++++++++++++++++++++++++++-
 t/t3200-branch.sh                | 176 +++++++++++++++++++++
 4 files changed, 441 insertions(+), 15 deletions(-)

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
index bfdf459329..6be28c8a4e 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -26,6 +26,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
+git branch [--dry-run] (--delete-integrated <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
 -----------
@@ -235,11 +236,21 @@ A branch whose work has not yet been merged into its upstream is
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
-	With `--delete-merged`, print which branches would be
-	deleted and exit without touching any ref.  Useful for
-	sanity-checking a wide pattern like `'origin/*'` before
-	committing to the deletion.
+	With `--delete-merged` or `--delete-integrated`, print which
+	branches would be deleted and exit without touching any ref.
+	Useful for sanity-checking a wide pattern like `'origin/*'`
+	before committing to the deletion.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 99b0dd45e9..818c916791 100644
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
+			   change->path, &oid, &mode))
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
 static bool branch_opted_out(struct strbuf *key, const char *branch_name,
 			     unsigned int flags)
 {
@@ -869,6 +1057,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
+	struct strmap landed_commits = STRMAP_INIT;
+	struct landing_search *searches = NULL;
+	size_t searches_nr = 0, searches_alloc = 0;
 	struct strvec branches_to_delete = STRVEC_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
@@ -903,13 +1094,39 @@ static int delete_merged_branches(const struct strvec *upstreams,
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
 
 		if (!branch_opted_out(&key, branch_name, flags))
 			strset_add(&deletable_branch_names, branch_name);
 	}
 
+	find_landed_commits(searches, searches_nr, &landed_commits);
+	for (size_t i = 0; i < searches_nr; i++) {
+		const char *branch_name = searches[i].branch_name;
+
+		if (strmap_contains(&landed_commits, branch_name) &&
+		    !branch_opted_out(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
+	}
+
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
 				     &protected_branch_names);
 
@@ -921,7 +1138,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags, NULL);
+				      flags, &landed_commits);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -929,6 +1146,13 @@ static int delete_merged_branches(const struct strvec *upstreams,
 
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
@@ -1001,6 +1225,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	struct strvec delete_integrated = STRVEC_INIT;
 	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
@@ -1058,8 +1283,11 @@ int cmd_branch(int argc,
 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
 			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
+		OPT_CALLBACK_F(0, "delete-integrated", &delete_integrated, N_("pattern"),
+			N_("like --delete-merged, but also delete branches whose changes landed upstream (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL(0, "dry-run", &dry_run,
-			N_("with --delete-merged, only print which branches would be deleted")),
+			N_("with --delete-merged or --delete-integrated, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1108,7 +1336,7 @@ int cmd_branch(int argc,
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !delete_merged.nr &&
-	    argc == 0)
+	    !delete_integrated.nr && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -1116,14 +1344,18 @@ int cmd_branch(int argc,
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
 
-	if (dry_run && !delete_merged.nr)
-		die(_("--dry-run requires --delete-merged"));
+	if (dry_run && !delete_merged.nr && !delete_integrated.nr)
+		die(_("--dry-run requires --delete-merged or --delete-integrated"));
 
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
@@ -1168,6 +1400,12 @@ int cmd_branch(int argc,
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
@@ -1340,6 +1578,7 @@ int cmd_branch(int argc,
 
 out:
 	strvec_clear(&delete_merged);
+	strvec_clear(&delete_integrated);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..1fbb173ad4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1925,6 +1925,39 @@ check_branches () {
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
@@ -1979,6 +2012,143 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
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
 test_expect_success '--delete-merged keeps main despite a different default push remote' '
 	setup_repo_for_delete_merged &&
 	create_merged_branch on-next &&
@@ -2178,4 +2348,10 @@ test_expect_success '--dry-run without --delete-merged is rejected' '
 	test_grep "requires --delete-merged" err
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

