Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585743;
	b=F5hq69mOFYA3jEtBKFAWdudGCddm6l1c7fqCzF2uPazh/UoKgctOjIOmiy5W5gy8hYJ5
	 IrLXkwQ1QGXyc0LmJ9HcVOTel/iB1SgT9g2Wyk2j8Wd91YGyJpVx9q2RynGi/U9YPXJct
	 jowRlS/1a8g3ae6M+LWQYNpA69doCaBMowd52n2v++fTLRLBIsy9H5UyW2Qdflbgky+IQ
	 u2YdM9FERdGh6eXeWycsn96k0Q1KFxwqoNx1N7qcAJCdCF50kU7SWrJK7UFkcBA5szBU0
	 eHvboSKAG/oshWqJ2+6URhkY3mnHr1YNUnxumz3MCPweIw7Lz+1NZoTE/RQkR5Xqn8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=hHfavaacljfGep+YlSsFfIBvrvpZzxxX6GmkK/cmiew=;
	b=4r1MwblwtR7yq2HUtWxdMhyEDlez/JwCPjwEbGSkoyiyDGwPlPiLhy4II4FC4Ue8DNqg
	 DNJ994XLhZtiFLKDjbO9ZrXMADu24w3zX0So0OpoUohnM1pJbExyuF0AmfUf7e1Nd3vjm
	 rneYWSPnQ9h/NajwVh991TLEp7aiMYEQirVdX8TUR8ZGNy6E/8i5C93D0UtY44OVjwImn
	 QKLEd9zma8Mus8r38E1W4rm9yfZ/v1YaV0hRWmXxk6JraLibDxy3OvMmXTYJSgWjeVxD1
	 rNlENi1HP2zO6DJ72T3DJHcM0ISI5/+PUSE1KbSe6qnQCYO3XynN8RSQrQOGWP0WwPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l9MN7RVX;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0077606A33A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0077606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l9MN7RVX
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9178d514951so5491916d6.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585742; x=1793190542; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hHfavaacljfGep+YlSsFfIBvrvpZzxxX6GmkK/cmiew=;
        b=l9MN7RVXgmd835k31TK6y8CrWuVqZTsA7i4A1whbDi/Rhj/Z3tuvPtTAViA6Y/8ksw
         slkfZyRRFJ241kbOxnI+njgq2EcF9K47Q9cGIZOPHrfL/BHN4IRYfaQOf9fGM55ruYmh
         JHEodreJfpINhzwhBZPYk1PN/uw0AkMasoXLl0jUTT2+sVVA0H1SahEKV5jAnk05vFfS
         71w6EM8+MGjOg/VRjrVgbj4qS3y+DwqLJuyPiR3vsjxx281pE+Umr42SpIGACkw6k9fC
         owzrEyjD5xQiza2syGSUAoUqkkOyUcVwDC1YBgLrvtNVRHJb5kl6kjzEFpwFh0D5+tXN
         wizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585742; x=1793190542;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hHfavaacljfGep+YlSsFfIBvrvpZzxxX6GmkK/cmiew=;
        b=GzW5u3emHa4aagmDFY3S8GE67TeroVQtBIJSrQpg0TTiwhAETlghD+RQzGykizKGLy
         Bjn4gAjutg/ojN8A+EmHcN5cdcEwW+fr9lddsthtYKqhdAZq396vml3RG02tCio/Q6Fi
         x/jcc7Ca1QlByArKlZYZoSJlHnbdnHbmdy5eHASOqM7GCEjt2jkuQR38UcgnZz9Dp9BP
         HDuNlQrbqM97A8V8XTMQjwTZj7ez3vJim0kS4J3t8tn88yGGwTxRskIiNVHmAhgbP7GK
         NtyRdIfSe63q1/tdc3qrrJWcjMbWwpj238fWYahGWjXKn6B4jJXdE0/fDT0oFU5h5rZO
         gtcw==
X-Gm-Message-State: AFq9FYJfvEGElHMFLUZZ2jyHoifK8Rc6UR+vTwJmZMAIBcc6nAbikrFe
	3Q/CKeXx2ce8LLxLrQ9ahMBs0RZJYWgYb6tMbMPS4L4mbmK/xovJKkZb2HuadOtl
X-Gm-Gg: AYBFou2nUTvfbj0o+SVpwZbIMf8fCidFBlIlRuvCZ9uzy3okVWmoQAVv+Ziz2PwJJNx
	9KOxhdDkg03Qb2bOQ1JKLrQOhEg1mKar3UKWTi6T6+LwDqo6gyVeZLAocRTj3BMjt+gLj6FCLU3
	5cZ0W43Z7Jp0R2XPy/10h+UkNjP6aOpmAoizDKIYM20C+Ah+p7L84BmYx/WUvz6X4SNYtltYSrf
	AfXdZtwX0uOjhbXCrjLgKqpa/VUsfoN5rYzz6a23ELoeCXeB1rbJCZ0RSsLKGGBsz7K4tmuBrXf
	DYmL4T7fAusOhphhP688nNc5BKUcPUkmnqFdyxtboVtK0LiLzxgcI504HhYmJeqYeAJoI4H/7gp
	f1bvggCUsAvbNjhyi3smhErrjHyWndSyOz0lRGJ7Tcfj0lAuyFwWXFE8+G8pR62a1Qhuvz+bnAC
	s9/YnLFpWUBO5muMQjni/duWv37sQWZeAMF82vmogai0QcYJU2Ozmr6Us51tZmlqU6XBcfW4kZ6
	KAp1ynSqeeDcZQ5WksglbIwlH6Wn4chFnk2wg8vCsOfbBsu2XCdWyo6ww==
X-Received: by 2002:a05:6214:401d:b0:91b:d5d7:8c81 with SMTP id 6a1803df08f44-91c12e38420mr28998096d6.7.1792585721682;
        Wed, 21 Oct 2026 05:28:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.95.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b74c01sm23519246d6.8.2026.10.21.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:28:41 -0700 (PDT)
Message-Id: <9a7e88ced6600a8d6331ca9c4bcdc6cd208dd73f.1792585717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 12:28:36 +0000
Subject: [PATCH v3 2/3] branch: let --delete-merged find rebase merged
 branches
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

is never deleted by "git branch --delete-merged". This is what the
"Rebase and merge" button on GitHub does. The upstream holds rewritten
copies of the branch's commits, so its tip is not reachable from it and
it looks unmerged forever.

Treat such a branch as merged when some upstream commit since the fork
point has the branch's version of every file the branch changed. Name
that commit in the output so the user can see where the work went:

    Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).

The first upstream commit that has them is used, so the branch is
deleted even if upstream later reverted or reworked them. Nothing is
lost, since that commit keeps them in the upstream history. A branch
whose changes only partly landed is kept.

The same check finds a squash merge when upstream did not change the
same files between the fork point and the squash. It never reads file
contents, so it stays cheap in a partial clone.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  15 +-
 builtin/branch.c              | 251 +++++++++++++++++++++++++++++++++-
 t/t3200-branch.sh             | 137 +++++++++++++++++++
 3 files changed, 391 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..3d6549b977 100644
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
+	upstream commit has their version of every file they changed, as
+	happens after a rebase merge, even if those changes were later
+	reverted. The message for such a branch names the first upstream
+	commit that has them. _<pattern>_ may name a ref, a remote (using
+	the branch its `HEAD` points at), or a shell-style glob. The
+	option can be repeated to widen the upstream match.
 	Optional _<branch-pattern>_ arguments limit which local branches
 	are considered, e.g. `git branch --delete-merged 'origin/*'
 	'topic-*'`.
diff --git a/builtin/branch.c b/builtin/branch.c
index 171b13b081..2a2e370401 100644
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
@@ -236,7 +242,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int kinds,
-			   unsigned int flags)
+			   unsigned int flags, struct strmap *landed_commits)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -334,6 +340,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		    !(landed_commits &&
+		      strmap_contains(landed_commits, bname.buf)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
@@ -357,15 +365,33 @@ static int delete_branches(int argc, const char **argv, int kinds,
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
@@ -824,6 +850,185 @@ static int branch_pushes_to_upstream(struct branch *branch,
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
@@ -849,6 +1054,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
+	struct strmap landed_commits = STRMAP_INIT;
+	struct landing_search *searches = NULL;
+	size_t searches_nr = 0, searches_alloc = 0;
 	struct strvec branches_to_delete = STRVEC_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
@@ -883,13 +1091,37 @@ static int delete_merged_branches(const struct strvec *upstreams,
 			continue;
 		if (check_branch_commit(branch_name, branch_name,
 					&candidates.items[i]->objectname, NULL,
-					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
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
 
@@ -901,7 +1133,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags);
+				      flags, &landed_commits);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -909,6 +1141,13 @@ static int delete_merged_branches(const struct strvec *upstreams,
 
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
@@ -1141,7 +1380,7 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, filter.kind,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0), NULL);
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..5ba19a34e2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1979,6 +1979,143 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
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
+test_expect_success '--delete-merged deletes a rebase merged branch' '
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
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		echo "Deleted branch rebased (was $sha, landed as $landed)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
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

