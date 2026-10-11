Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E84388E62
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791711673; cv=none; b=aqnEwbphT3Dtni0u3zkuIQJBZlrkHZ7A6HyVvb/py20dHiPP9gdJuVJN6yatT067TTQViz0uR6wzvuIliPkrCGc1Byh1SOrPsYvcGUvmKbQPPHrY5+fjxM2NLwh8L8VghDkB39a+UU6MvkIWdEfYkCDoBCQD9xVIWfLqJeu81E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791711673; c=relaxed/simple;
	bh=bC6isbnEAjemU2CecukJWW6afMSRVneAVZkNF1U6Uw8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ME3aXEiZaOCkH/kaqGwZCKJuAamDBu3X85obpnEjTLlftpa1fH/ptM+cVYExhd9Sr2xGt1iz4SSL4DtQ3Cs4LV0UP9LfPIsU+eT/6ztyX9nyqP+BjqZUAgfkwNiXXzRBaGdXfU7QfY4OUAWkgkqYZXX6A2jkJ1PXZkKOR6F8hzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHuAMD3x; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHuAMD3x"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53391786e55so19014291cf.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791711670; x=1792316470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jnt7FpQY1VPC3K2nfQR6YGO2HJ8TnDjBZSaMgvD0+JU=;
        b=XHuAMD3xoDCU/ajA9IAkkA7vZpZwnnR2nhAGmKGPtjcnfsI67lee+s1MMEAp3vOHrn
         mSXctegoHbEBkGDl8tSB4WdmgYj1+vi1gY7ykO8jrVLICDSHHmt7GLFleSoS/9+cLVSh
         rdoOCLVZmMgt40CQjQSRt4FK5CgYTp7Z7ajqpR91ul2b4xf6WQU9a6U3SMw1ipjzfXSJ
         lbWA4E0WwgfBsNBi9TKQ0xaQaRaXxYuts34eOL2WK8FkzvQyhg23o3lEdLrJRGRqcak/
         Z1NlLGC2aGsat29dkFgQjmMg3E4XhO9DMmySQ7cmtQLmYiO+XT0bIyiCnv1cKbv+Xdlb
         vfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791711670; x=1792316470;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jnt7FpQY1VPC3K2nfQR6YGO2HJ8TnDjBZSaMgvD0+JU=;
        b=t64/ggYeumdDoOezVDjmHbW/HDYyAXli4APSrjmySbFx/+2B1lrZ2x4SdIX7Q0q09z
         dHlz/cDTEXGyMbc5JLBOOYgjaJB8QoHWFEbJJdZ+JMI4KXy4Q6Vo0PSrLzSNiFbZzURc
         0KDJTB2ir6uPYYYoV2/i/cAJAydWNs4LWTtZHnv7zykbxiMqYrHe1ZQbQuo7GZBQqZ1T
         ++KMWXhzYaGG8YcTGFLYSOF+NDzJ8cngt4BlxsKgJbDzUrDFLPvViZhrPqtiXLYjGJYt
         ODFQGy0t8xzn3L6LC/thLQrDjoOwpsUOytYGjW/UrWEHhkBhlfF8ygKeMvszGW+i/KBk
         oh1Q==
X-Gm-Message-State: AFq9FYJ48gDSMO86+TMtLHjCu1cY4Xp8miPcanV/ouwZy+B3yk4sRF6O
	u/93gK0Qea5I7qrq72ze6VRFFS4OKv3GepsxXscw9hiy2Lxd4xWXENEscKNvGvITy2A=
X-Gm-Gg: AYBFou2HTBgAZl6XOC//wNtrpDAJdsRouar5Ax3jQcBOxuJicAG/lUXxU4ll7iFL+3p
	4Tf75thflz9ynLF3DHhNhAjqohxlFgVy4e3uuPW2mltTBdvo+VOQ2eqrl2h5vshf7BJaj8FXtKb
	izAnvbkT99YYA7ejFcfrZm993GsKF28DLZxlMgDLf3zBiuwwYV5Am/CZuavJrx6BU6JioJMeSSn
	d9D16Xi7uOQUShbUdRdbS/iTLaXCwoCFvbYVC4VenPlVjvrxhVUtsQm1qy1h3nFaqiZTHRo/Sl4
	H0m39W1V/tq/ZLtXW5h9jbefVxD9xULfY0Ar9GBEcLZlXI4x2N3QP2xggSiYiITnaucBXUHYFpX
	WBOSkC/VkDdpTqrJzRaEFj5OzhkWr83RApZGt/vUeh5HQTm2eSOrVACt+vC5zL5mRi4ihoOVxEP
	ZZ5tdRZYa2tIKtB+B4zB8va5eLDlA92+kaRxK1nzmbF9SloxPGEa5RqNTwKf864exX0GvvU4Ge3
	KQ=
X-Received: by 2002:ac8:5f0d:0:b0:535:25e6:3ca5 with SMTP id d75a77b69052e-5359fae52f4mr108296051cf.24.1791711669700;
        Sun, 11 Oct 2026 02:41:09 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.108.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55088538sm66433886d6.32.2026.10.11.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 02:41:09 -0700 (PDT)
Message-Id: <94a6d23f8b96d4a07fb58c71f4a2f7dc4d3055bc.1791711665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Oct 2026 09:41:04 +0000
Subject: [PATCH v2 1/2] branch: let --delete-merged find squash merged
 branches
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A branch that upstream integrated with

    git merge --squash topic
    git commit

is never deleted by "git branch --delete-merged". The same goes for a
branch that was rebased or cherry-picked onto upstream. The upstream
holds a rewritten copy of its work, so its tip is not reachable from
it and it looks unmerged forever.

This happens all the time on hosting services. The "Squash and merge"
and "Rebase and merge" buttons on GitHub land pull requests this way,
so contributors to such projects collect local branches that
"--delete-merged" never cleans up.

Treat such a branch as merged when some upstream commit since the fork
point contains all of its changes, so that merging the branch into
that commit would change nothing. Name that commit in the output so
the user can see where the work went:

    Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).

The first upstream commit that contains the changes is used, so the
branch is deleted even if upstream later reverted or reworked them.
Nothing is lost, since that commit keeps them in the upstream history.
A branch whose changes only partly landed is kept.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  15 +-
 builtin/branch.c              | 332 ++++++++++++++++++++++++++++++++--
 t/t3200-branch.sh             | 143 +++++++++++++++
 3 files changed, 466 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..0427324de1 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -204,12 +204,15 @@ This option is only applicable in non-verbose mode.
 
 `--delete-merged <pattern>`::
 	Delete local branches whose configured upstream matches
-	_<pattern>_, but only when their tip is reachable from that
-	upstream. In other words, the work on the branch has already
-	landed on the upstream it tracks, so the local copy is no longer
-	needed. _<pattern>_ may name a ref, a remote (using the branch its
-	`HEAD` points at), or a shell-style glob. The option can be
-	repeated to widen the upstream match.
+	_<pattern>_, but only when their work has already landed on that
+	upstream, so the local copy is no longer needed. This is the case
+	when their tip is reachable from the upstream, or when some
+	upstream commit contains all of their changes, as happens after
+	a squash or rebase merge, even if those changes were later
+	reverted. The message for such a branch names the first upstream
+	commit that contains its changes. _<pattern>_ may name a ref, a
+	remote (using the branch its `HEAD` points at), or a shell-style
+	glob. The option can be repeated to widen the upstream match.
 	Optional _<branch-pattern>_ arguments limit which local branches
 	are considered, e.g. `git branch --delete-merged 'origin/*'
 	'topic-*'`.
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..513c39763b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -29,6 +29,14 @@
 #include "help.h"
 #include "advice.h"
 #include "commit-reach.h"
+#include "commit-slab.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "hex.h"
+#include "merge-ll.h"
+#include "revision.h"
+#include "tree-walk.h"
+#include "xdiff-interface.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
@@ -236,7 +244,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int kinds,
-			   unsigned int flags)
+			   unsigned int flags, struct strmap *landed_commits)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -334,6 +342,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		    !(landed_commits &&
+		      strmap_contains(landed_commits, bname.buf)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
@@ -357,15 +367,33 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
+		struct commit *landed = landed_commits ?
+			strmap_get(landed_commits, name + branch_name_pos) : NULL;
+		const char *landed_abbrev = landed ?
+			repo_find_unique_abbrev(the_repository,
+						&landed->object.oid,
+						DEFAULT_ABBREV) : NULL;
+
 		if (flags & DELETE_BRANCH_DRY_RUN) {
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Would delete branch %s (was %s, landed as %s).\n"),
+				       name + branch_name_pos, describe_ref,
+				       landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Would delete remote-tracking branch %s (was %s).\n")
 					: _("Would delete branch %s (was %s).\n"),
 					name + branch_name_pos, describe_ref);
 		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Deleted branch %s (was %s, landed as %s).\n"),
+				       refname, describe_ref, landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Deleted remote-tracking branch %s (was %s).\n")
 					: _("Deleted branch %s (was %s).\n"),
@@ -824,6 +852,251 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+enum change_state {
+	CHANGE_MISSING,
+	CHANGE_LANDED,
+	CHANGE_NEEDS_MERGE,
+};
+
+struct branch_change {
+	char *path;
+	struct object_id base_oid, branch_oid, upstream_oid;
+	unsigned short branch_mode;
+	enum change_state state;
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
+		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
+		       &p->one->oid : null_oid(the_hash_algo));
+		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
+		       &p->two->oid : null_oid(the_hash_algo));
+		change->branch_mode = p->two->mode;
+	}
+	diff_flush(&opt);
+}
+
+static int merge_keeps_upstream(const struct branch_change *change)
+{
+	mmfile_t base, upstream, branch;
+	mmbuffer_t result = { 0 };
+	int ret;
+
+	read_mmblob(&base, the_repository->objects, &change->base_oid);
+	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
+	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
+	ret = ll_merge(&result, change->path, &base, "base",
+		       &upstream, "upstream", &branch, "branch",
+		       the_repository->index, NULL) == LL_MERGE_OK &&
+	      result.size == upstream.size &&
+	      !memcmp(result.ptr, upstream.ptr, upstream.size);
+
+	free(base.ptr);
+	free(upstream.ptr);
+	free(branch.ptr);
+	free(result.ptr);
+	return ret;
+}
+
+static enum change_state change_state_at(struct branch_change *change,
+					 struct commit *commit)
+{
+	unsigned short mode;
+
+	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
+			   change->path, &change->upstream_oid, &mode))
+		return is_null_oid(&change->branch_oid) ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (oideq(&change->upstream_oid, &change->branch_oid))
+		return mode == change->branch_mode ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (is_null_oid(&change->base_oid) ||
+	    is_null_oid(&change->branch_oid) ||
+	    oideq(&change->upstream_oid, &change->base_oid) ||
+	    mode != change->branch_mode || !S_ISREG(mode))
+		return CHANGE_MISSING;
+	return CHANGE_NEEDS_MERGE;
+}
+
+static int changes_landed(struct landing_search *search,
+			  struct commit *commit)
+{
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		change->state = change_state_at(change, commit);
+		if (change->state == CHANGE_MISSING)
+			return 0;
+	}
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		if (change->state == CHANGE_NEEDS_MERGE &&
+		    !merge_keeps_upstream(change))
+			return 0;
+	}
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
+static int branch_opted_out(struct strbuf *key, const char *branch_name,
+			    unsigned int flags)
+{
+	int opt_out;
+
+	strbuf_reset(key);
+	strbuf_addf(key, "branch.%s.deletemerged", branch_name);
+	if (repo_config_get_bool(the_repository, key->buf, &opt_out) ||
+	    opt_out)
+		return 0;
+	if (!(flags & DELETE_BRANCH_QUIET))
+		fprintf(stderr,
+			_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+			branch_name, branch_name);
+	return 1;
+}
+
 static int delete_merged_branches(const struct strvec *upstreams,
 				 const char **argv, unsigned int flags)
 {
@@ -832,6 +1105,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
+	struct strmap landed_commits = STRMAP_INIT;
+	struct landing_search *searches = NULL;
+	size_t searches_nr = 0, searches_alloc = 0;
 	struct strvec branches_to_delete = STRVEC_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
@@ -852,7 +1128,6 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
-		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -867,21 +1142,35 @@ static int delete_merged_branches(const struct strvec *upstreams,
 			continue;
 		if (check_branch_commit(branch_name, branch_name,
 					&candidates.items[i]->objectname, NULL,
-					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
-			continue;
-
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
-		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
-		    !opt_out) {
-			if (!(flags & DELETE_BRANCH_QUIET))
-				fprintf(stderr,
-					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
-					branch_name, branch_name);
+					FILTER_REFS_BRANCHES,
+					DELETE_BRANCH_SKIP_UNMERGED)) {
+			struct commit *rev = lookup_commit_reference(
+				the_repository, &candidates.items[i]->objectname);
+			struct commit *upstream = lookup_commit_reference_by_name(
+				upstream_refname);
+
+			if (!rev || !upstream)
+				continue;
+			ALLOC_GROW(searches, searches_nr + 1, searches_alloc);
+			searches[searches_nr++] = (struct landing_search) {
+				.branch_name = branch_name,
+				.rev = rev,
+				.upstream = upstream,
+			};
 			continue;
 		}
 
-		strset_add(&deletable_branch_names, branch_name);
+		if (!branch_opted_out(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
+	}
+
+	find_landed_commits(searches, searches_nr, &landed_commits);
+	for (size_t i = 0; i < searches_nr; i++) {
+		const char *branch_name = searches[i].branch_name;
+
+		if (strmap_contains(&landed_commits, branch_name) &&
+		    !branch_opted_out(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
 	}
 
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
@@ -895,7 +1184,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags);
+				      flags, &landed_commits);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -903,6 +1192,13 @@ static int delete_merged_branches(const struct strvec *upstreams,
 
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
@@ -1135,7 +1431,7 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, filter.kind,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0), NULL);
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..adf1bc2233 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1979,6 +1979,149 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
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
+test_expect_success '--delete-merged deletes a squash merged branch' '
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
+		git branch --delete-merged origin/next >actual 2>&1 &&
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
+test_expect_success '--delete-merged deletes a squash merged branch that was reverted' '
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
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		echo "Deleted branch reverted (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged deletes a squash merged branch after upstream changed the same file' '
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >shared &&
+		git add shared &&
+		git commit -m "add shared" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b edits-shared --track origin/next &&
+		test_write_lines 1 two 3 4 5 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 2" &&
+		git push origin edits-shared &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 five 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 5" &&
+		git checkout main
+	) &&
+	squash_merge_upstream edits-shared &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short edits-shared) &&
+
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged reports a merge plainly next to an unmerged branch' '
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
+		git branch --delete-merged origin/next >actual 2>&1 &&
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
-- 
gitgitgadget

