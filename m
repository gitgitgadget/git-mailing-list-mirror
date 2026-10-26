Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003634;
	b=Pbkmt21RLNSUcJk8UmCkXio9ZHy72K6f+cGOVkZiOBOFyu1q2PE/2CDb+rF9d6x9Y7ys
	 sp8S1h/mpX4A5/09QM4wlwWREo6iJ9abOe/yTGT0nzs2Qwf8BPwqU1SMUK5jiESP4w27E
	 meWzxJa4KGQW5J0tSxZAhCqEhhiVLaDlA24kPUkGYNOZYM/hr7mvYreq2gQgI3wxL0tBk
	 HGRH1I8zOA5GT29ZVgx7uDvpHsKWy1CCbhbhqqVv8hTj0hAAskAJvoKUvpJMGcOni9zDc
	 jNnaDbZIqXEc/hXekLH1dz3jznhI7+wAdaL+YNPDX/tKqPeueZypJGYF+aXQZIIGJSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=4jxjaE18oxd84pVGmTxt6iXjZWnIzo/HYJJAlMlJZGY=;
	b=FPM/6MNjHVhFZcljzwR4LLr/2O0VVPYX24UZoiSabdhoRmxIDM3EOYr1msXTUCHUc2Tj
	 lH5VTaxQQPmRYl1I0DI6R30NJQD0+y5qYuZGCwNf+gneaJqnjZAdDkH2sChf4pssu5tx7
	 Gx5YAcHNyIKPlf9XljxP9nkYHOli1I0t93j9El7x42q1lDvmQPccEl8wQf3xpWn7gEvRR
	 iB80U7I83CcYRWAnjlEgDzGKQkMDTmXQr+iePEOb2REToQ25HvLjGJ0DUtjdWCNO9NZxe
	 c8basrLtNEP+KOlFxxzZDyqRtFSU9gtfopxKQxBsOkgVbSbSeIcYc2RD9AORlEZoFRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BS8bYOOh;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D4606A33C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32D4606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BS8bYOOh
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea759cc9b6so9232245ad.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003633; x=1793608433; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4jxjaE18oxd84pVGmTxt6iXjZWnIzo/HYJJAlMlJZGY=;
        b=BS8bYOOhg+fwc9YWko7MvYFt4WUtDDRqbroWG/rCXXNKjOyJ5olGmGfQDMBXmDYSIE
         P8ahEnAab3Il7ML+IjyuLNQXyaDb/cmQIuyr25hHJlkrJcTCI9fjc3T616s0VgnDZK4M
         JlTd2942NQzDhFVRj6KlC6hRyBpDp/4rh4JaGYVYZBcNa/qTQboVXwZ/b35V3r7ruDlm
         e5zmyOiU8EvILbU077mazTk+MIStx40NKB25yt5G8q3rIzul0hbJZzCdFnsx+YfJ45IJ
         A2pPG/aMchQ0j4b0HqGz7NUXJybJp6KWI3fhiPQcOw1dHLC6OuJztmvQRlZrS/gM3qF1
         Mggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003633; x=1793608433;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jxjaE18oxd84pVGmTxt6iXjZWnIzo/HYJJAlMlJZGY=;
        b=10L059ysuDx73Dlpu9gh5+G1ar4Ngirfocg7pQ7FtWWbv0CJot2g4x8gTC2uxYiEGC
         Yc/Z0Rts43+TiUUnqtTZzJ92kTuFj+8NABnSwWS+/o4sjYDtNM3KAqNfs4MkZpWUfhQj
         kE4b2tw+whUHkyP6SPhVcb8dziNucGxY70mppTnhblKTjSzR8izhebni9mwyHHDPJWCg
         i8oOlY+zoZ6Qr4aP3ANW3V8IeLI2KRzzV06IkUXmz2+w9cys8uU3llLbh4z5Wi9yeEqQ
         v5td9a3ROdLJx52GjGTU3stc/N4+vGQBRVZF9lvo8daEMcc0rLXR6hOnhNwKjfo+pSEh
         oCUQ==
X-Gm-Message-State: AFq9FYKaqZfNv8G4g4u4dBa+K/Xg1hmSiPQrA/2tnlP0qfr9BQlYxNb2
	WF7D2x2yhCJwbZA5zIcXjJx1bpAi4+YGUq+GzTq1kTuIE2kSgf2kfd/Ob+9mYo5J
X-Gm-Gg: AYBFou39zoDrrtNCiJy3m5yWSw9xCAhiTyH3httRW+8z0FJ7jO/FpiUH2u8Hok2tRWO
	eU+NTP5fAF+LbhkG3SjQXVeHLuEJWmGG03yXaRQQNzCGvd5yRLjfpJnNar18owjRZx4aDUe7OT1
	CQmcQoR7eYlbRc1rg37wOCHs7QgFN4rGlIFWK2LboAtdYdHDjo/1FNm26q9LKpTxGlzr6e0B9id
	8r6ieykdlO6dwpAX0Gamz0gPbX3iFdDGCUPo9PtKkZeCadgZP2sKGQIhJZn2i98wSm+OPA7WaxD
	QDL/tsZqk4nthh/nfIRvFpLg4HCamMkorMkC8sL3OCmMHGoNCSkFW+n+e2eWM8lyJ5XM61Rqh3a
	Hk7IDatewRh44z0U3dVuYYFWeDoSbJDGk7f6N8qUbWh0cKpxG8k0U1iUTKA+R4Q2qaVpGIMJ14M
	3Y7lvQsfLcdTrm9XMQQhJouGo63D9ElbYbDq8aOn2TGaVU/KkWFtOcG2HNb1zamgx1/vyif4J/u
	iy1D70ZLfPGv40w4qZ9ddKFzoOp8gUFihYi0ty28KMfdUQrLQHnNLfovbey
X-Received: by 2002:a17:903:2985:b0:2e9:401f:f102 with SMTP id d9443c01a7336-2ea9c83a95dmr54863105ad.32.1793003632977;
        Mon, 26 Oct 2026 01:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.211.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b22416bsm13248365ad.72.2026.10.26.01.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:33:52 -0700 (PDT)
Message-Id: <deb1e649cfe0c3d83af5d7fca01e8f5b6bf66359.1793003627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 08:33:46 +0000
Subject: [PATCH v4 3/4] branch: add --delete-integrated to delete rebase and
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
 builtin/branch.c                 | 248 ++++++++++++++++++++++++++++++-
 t/t3200-branch.sh                | 175 ++++++++++++++++++++++
 4 files changed, 435 insertions(+), 15 deletions(-)

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
index 99b0dd45e9..ba04d8c486 100644
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
@@ -201,6 +207,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 	DELETE_BRANCH_DRY_RUN = (1 << 4),
+	DELETE_BRANCH_INTEGRATED = (1 << 5),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -844,6 +851,185 @@ static int branch_pushes_to_upstream(struct branch *branch,
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
+	struct diff_options opt;
+
+	repo_diff_setup(the_repository, &opt);
+	opt.flags.recursive = 1;
+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&opt);
+	diff_tree_oid(get_commit_tree_oid(base),
+		      get_commit_tree_oid(search->rev), "", &opt);
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
+	diff_flush(&opt);
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
+					    struct diff_options *opt,
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
+		      get_commit_tree_oid(commit), "", opt);
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		string_list_append(*paths, p->two->path);
+	}
+	diff_flush(opt);
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
+					 struct diff_options *opt)
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
+		if (touches_changes(changed_paths_of(cache, opt, commit),
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
+	struct diff_options opt;
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
+	repo_diff_setup(the_repository, &opt);
+	opt.flags.recursive = 1;
+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	opt.no_free = 1;
+	diff_setup_done(&opt);
+	init_changed_paths(&cache);
+
+	for (size_t i = 0; i < searches_nr; i++) {
+		struct commit *landed;
+
+		if (!searches[i].changes_nr)
+			continue;
+		landed = find_landed_commit(&searches[i], &cache, &opt);
+		if (landed)
+			strmap_put(landed_commits, searches[i].branch_name,
+				   landed);
+	}
+
+	deep_clear_changed_paths(&cache, free_changed_paths);
+	opt.no_free = 0;
+	diff_free(&opt);
+}
+
 static bool branch_opted_out(struct strbuf *key, const char *branch_name,
 			     unsigned int flags)
 {
@@ -869,6 +1055,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
+	struct strmap landed_commits = STRMAP_INIT;
+	struct landing_search *searches = NULL;
+	size_t searches_nr = 0, searches_alloc = 0;
 	struct strvec branches_to_delete = STRVEC_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
@@ -903,13 +1092,39 @@ static int delete_merged_branches(const struct strvec *upstreams,
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
 
@@ -921,7 +1136,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags, NULL);
+				      flags, &landed_commits);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -929,6 +1144,13 @@ static int delete_merged_branches(const struct strvec *upstreams,
 
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
@@ -1001,6 +1223,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	struct strvec delete_integrated = STRVEC_INIT;
 	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
@@ -1058,8 +1281,11 @@ int cmd_branch(int argc,
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
@@ -1108,7 +1334,7 @@ int cmd_branch(int argc,
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !delete_merged.nr &&
-	    argc == 0)
+	    !delete_integrated.nr && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -1118,12 +1344,13 @@ int cmd_branch(int argc,
 
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
@@ -1168,6 +1395,12 @@ int cmd_branch(int argc,
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
@@ -1340,6 +1573,7 @@ int cmd_branch(int argc,
 
 out:
 	strvec_clear(&delete_merged);
+	strvec_clear(&delete_integrated);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..64dc4c7561 100755
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
@@ -2178,4 +2348,9 @@ test_expect_success '--dry-run without --delete-merged is rejected' '
 	test_grep "requires --delete-merged" err
 '
 
+test_expect_success '--delete-integrated cannot be combined with --delete-merged' '
+	test_must_fail git -C forked branch --delete-merged origin/next \
+		--delete-integrated origin/next
+'
+
 test_done
-- 
gitgitgadget

