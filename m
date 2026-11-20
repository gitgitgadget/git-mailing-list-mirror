Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184673;
	b=Qhy5Cy5orCyYc4YopMyAiGhIDWdvFgwuzKgyiHInDPhqp5LkCR6q+fV1CasIAwG0Kvtm
	 z9SHJoD3lh6oWznXoZ6RM2e7qAsL8uHOkYfVQpYjOtVlJDpGBnzC6QsHut4oGAHpwci0L
	 CoytNZnRdYFoHFtaFxcemtiYEYVzQN9FXYpiP+ZhGbZPuNAg+rphBpiil8S5PH/FXhKO6
	 u6BiyFGUdCiLNtLdyLeGslxn7MiamBKQmrAPJgXF6dhCqSsUyNWVIrqwMu940KLIOQ8ge
	 8FhVKGQgmBdEYVdd+iphAnhZA61CGkHHoOqYyQgjIBedUxvSMKA9HXLTcmaLd+Z1BEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=C1PjGDK7FY1nmJ4zFvqpid5WqvrYwKp9rK1T5a6PLaA=;
	b=idW9Bkr/oqwi8/C1PZjFfGyhWe/ymswTAwZX7MV/97908QDMG2ZzD7iqRHDIHe2nrKrM
	 52814rvQyv4C49USLkJMjakMcsyqbqhZpdwBSHTNi6Xu/e5ZzegUxWJdNLmzywDpaV6D6
	 BIlpNQx7/LkqYJUcyytcBU/0Qa2dgzLCrJ+8JB8pidRwQk8N7VxFjjms9XRVxEiqxYZhk
	 K+QBEed3m8VVYI8wN6AyOmrmf0CIxdE6lbFJpPHxz7COs+KTyhVGbkpHnVyP9yiClV4xv
	 gMRw7XvLG+XwkJU63+6PCon0QMeiDBxaibVBM+xtDFBixY+fxmbgWvBs1eJ6Gu2lq/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gPVPS0v1;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC57606A332
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC57606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gPVPS0v1
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15dd124bbe7so2045591c88.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795184672; x=1795789472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C1PjGDK7FY1nmJ4zFvqpid5WqvrYwKp9rK1T5a6PLaA=;
        b=gPVPS0v1D7LoE5bCwt4IAtkX4vX1tm60fN4/amC3/RUHtDf+aQbpRF6Cs4dPgs2plc
         4RyFKipG+yZz4OpSPSs8FU3TN7EC0eUWU0BzSYR5Qb/0COEuvHxa56+mDHOc5b8YtQpF
         /TC7Tegb/DLslaaEkQLKS2Hq+J/tKCJ/nZvE+Ogyd0hWMA9dmMkWe42elVRr1dQ9iA3M
         uOBRjDkMjHoH1tRmpPOneuJlRv4dgKOO8vqBz3keHJQ2jLFeiCklHy+GVyB2QrwsM/b8
         0lWnI7QKy6o+yoNZj2k5aBXVyiNfk4RQmZlMEUmj1Gj5GY+blI/lbUOmlbdH4S9bksd5
         W8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184672; x=1795789472;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1PjGDK7FY1nmJ4zFvqpid5WqvrYwKp9rK1T5a6PLaA=;
        b=aGZMdQ4nLuJGHiUGYRlOzPSzS5+21TTJeNug+/wdavtpNW+9of3rGUKqWjg0wixtKT
         FiC8CmizeLcAqMazARD6aN6FXTsSx6RBC3qKhJss6WwzkFFTvGLzJ+/Zm8H5fLUr/b/N
         e1xR2UiRJX9V9ZqwPtGiYV97O8+/O3rcGmucsM38q1FcfzR/ILdvKZXIRQsy7B32a62y
         vqV9EZn18JqOvQ+DviS3OvmrPc3OwhJ6Ks4XS3U/m9xBpbMQSNFhv2ksnMEB5hrK+bbM
         5nPNI8yWWufI5PMuIRamTlBC1Gn4luVuPG1mQ+w7RXyTMrkL8FKChaCV9BXO9Ygikksr
         6kAA==
X-Gm-Message-State: APuU4Z+d8fqA4x5judajF8C5PLn92GNrciZ3vkWZpdp+rB0blwF+ufWs
	z86uYORuLxSKJJX4SVl3rX/+6J7SdtVUJ+3zFHwiwQIaF6XbiNZsYk2rmNjzq6VB
X-Gm-Gg: AYBFou1sKDnxk6gH82Xk948T/ZqjBC07X1jw9E4LUSJ3gRtkMNvt3GuZR4hN8fvSpUo
	yoThFfSzYm3DesS00L3gySC7i1Ji9fgpNI/w9iSB1+zJ/t3HMepTO9stjSzDfQaCkcKJcGhZCBQ
	K3VdWH4FzxxC7xzNxH4pdofGSmFna09kvhFoAK3eZ3JtWINydkEQVRqKZ/B17jwbyU3Ge5KcmtN
	egqdWbtUETVsmYCEXywBNNlw2TUFsPacJn3HPti55QdCYscrKxCMIE0p5gH3HvJTj0q7yKDXcSS
	lHAqSoKBBAZUrKv9hI/o5uBrzM0Ekt/+WD4CuGhfuWBHTcEAE3YBthELK4E00srQ0x8Huz6dapQ
	PAQ1As04shGUNavzyQc2rl69vJkBruMPmVF9aSBdYhpEdhn3SLIR9RmKBzCT7UgNdBbfVohYw+g
	tYzMSFXuXFqPjomxsmP2eVbqGZjDDHVVmeV7vsnJw8W+KZTfPk4wRgkwpdiiMcLchFUJulZyZ5Y
	PedQ9KSwSE95ngP+jcZG2OR0xLH2gSZmmHy7iwNyjggZGdWFyzRAizRiPCGMoyH0OxXN2OibSRz
	A048zKC5jlGy85k0rjVcAqk3F5TciQ==
X-Received: by 2002:a05:701b:450d:20b0:1b2:4378:3545 with SMTP id a92af1059eb24-1b5568e825emr3334665c88.21.1795184671577;
        Fri, 20 Nov 2026 06:24:31 -0800 (PST)
Received: from [127.0.0.1] ([20.171.3.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm11115622c88.14.2026.11.20.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:24:30 -0800 (PST)
Message-Id: <1f922a00344f6b86dcc0054b3117f1bbad247810.1795184664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 14:24:23 +0000
Subject: [PATCH v9 3/4] branch: add --delete-integrated to delete rebase and
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
    Tuomas Ahola <taahol@utu.fi>,
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
index a803c24858..b6d9cd01a4 100644
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
index 6e6b04b11d..ee92e71f51 100644
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
@@ -1347,6 +1585,7 @@ int cmd_branch(int argc,
 
 out:
 	strvec_clear(&delete_merged);
+	strvec_clear(&delete_integrated);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 44336eef81..54461e90b3 100755
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
@@ -2017,6 +2050,143 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
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
@@ -2216,4 +2386,10 @@ test_expect_success '--dry-run without --delete-merged is rejected' '
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

