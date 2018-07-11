Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2A41F85E
	for <e@80x24.org>; Wed, 11 Jul 2018 22:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390644AbeGKWte (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:49:34 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:38425 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGKWte (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:49:34 -0400
Received: by mail-yb0-f202.google.com with SMTP id g6-v6so26378910ybc.5
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rJ4Kfb7vzdmHinxc41OOB7oidmBYAEtjvUZd0NQ9hdU=;
        b=H6VKU3nhcqQ3Utl+rzHySxFvLeDqxjdMVZ6Mgj00FqZk5QJGI7mFEof7j5ttE39hIn
         vOgSA5yryiHGaXvNenZU0aGzUcLvgctdN8xlXeex+6SbHMlADDPoClzoTdZwb/BuRnx8
         MWtwP7R9GyJkW6l95ctKSFgyBu2wRHO+1KbqOGp4sW/6TR/8GMJA56GgnAs7nbXE1izF
         RRQ8NiOGjOvKr3Pk2GOOSURxTYg8tOmD4iDjmGHCaz13A3XQJAYWODskCs4k+0RzVmX7
         /5pgAzcF5gB8IQvkfgBDj8ZZSp0jB42IEvAJmcD6Y2IXpQp5yAQeNlE8uX6zQU7xwOIe
         YfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rJ4Kfb7vzdmHinxc41OOB7oidmBYAEtjvUZd0NQ9hdU=;
        b=ToDNNAp8lcAWnQNxbwW2JZDt4oapM9BRfPto/h1Nv34nuu6mClPvzy9oxm/iYc4BQV
         Dn1IwdIZOttByekhgXGgdd84lGUfZv/FPfEH6kskPog/8+mTuGAhh7M6s2Vrsr705ZAR
         jeZI3yKAttNtMYV8HKppsTQKP9NJepf1HALxW+K0ShcwsQ70llrQpBPCXYh4fooNSo/1
         8oJQW3hXqgCZEgQUfVBsemVMxku7B6w3vy+iZDUJ2ZgK0d2RHT2HxKUIzHp2IhTgJgm2
         e82PIZwo9Cn0BMOYOJR02G6rHUrOcznbWagnlfnDKzCJfYVONm4iMqtCGwlMjJCiCIeD
         k3yw==
X-Gm-Message-State: AOUpUlEHXZjnrBqRT3XXbK380rRA2oRQevF6wu6n2gGkoxRY0t3kKF8+
        nrs2+v/WYO7A4wF0ce8/SFGQti1dfbg0oIzP1aZJ4OicRR5dstQ1QedXpRJoZ71npwTS67+f8Tx
        TjFaKogDQQ3ABg7vkn6Q7mymwuBZFKbRpwNz9ReBLPrMIaughISAs3Mz2yQG10CCKoOAXnCWjm+
        +G
X-Google-Smtp-Source: AAOMgpf3gLECbwCJYd++Fpxs9RABg2lr93nrbpwXGEg0lXqfEho+/I3GD3mWHqmWSx0WJ1rTS25g1HKfU0DCuO95i6d+
MIME-Version: 1.0
X-Received: by 2002:a81:7709:: with SMTP id s9-v6mr197325ywc.131.1531348982389;
 Wed, 11 Jul 2018 15:43:02 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:42:42 -0700
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com>
Message-Id: <b2f5b69806c4c4a4009267701245aee4cabd2cf1.1531348540.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531348540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v3 6/6] commit-graph: add repo arg to graph readers
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a struct repository argument to the functions in commit-graph.h that
read the commit graph. (This commit does not affect functions that write
commit graphs.)

Because the commit graph functions can now read the commit graph of any
repository, the global variable core_commit_graph has been removed.
Instead, the config option core.commitGraph is now read on the first
time in a repository that a commit is attempted to be parsed using its
commit graph.

This commit includes a test that exercises the functionality on an
arbitrary repository that is not the_repository.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                   |  1 +
 builtin/fsck.c             |  2 +-
 cache.h                    |  1 -
 commit-graph.c             | 60 +++++++++++++++-------------
 commit-graph.h             |  7 ++--
 commit.c                   |  6 +--
 config.c                   |  5 ---
 environment.c              |  1 -
 ref-filter.c               |  2 +-
 t/helper/test-repository.c | 82 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/t5318-commit-graph.sh    | 35 ++++++++++++++++
 13 files changed, 162 insertions(+), 42 deletions(-)
 create mode 100644 t/helper/test-repository.c

diff --git a/Makefile b/Makefile
index 0cb6590f24..bb8bd67201 100644
--- a/Makefile
+++ b/Makefile
@@ -719,6 +719,7 @@ TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
+TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
diff --git a/builtin/fsck.c b/builtin/fsck.c
index ea5e2a03e6..c96f3f4fcc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -830,7 +830,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
-	if (core_commit_graph) {
+	if (!git_config_get_bool("core.commitgraph", &i) && i) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
 
diff --git a/cache.h b/cache.h
index 8b447652a7..3311f4c9e2 100644
--- a/cache.h
+++ b/cache.h
@@ -813,7 +813,6 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
-extern int core_commit_graph;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/commit-graph.c b/commit-graph.c
index b6a76a1413..b0a55ad128 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -183,15 +183,15 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	exit(1);
 }
 
-static void prepare_commit_graph_one(const char *obj_dir)
+static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 {
 	char *graph_name;
 
-	if (the_repository->objects->commit_graph)
+	if (r->objects->commit_graph)
 		return;
 
 	graph_name = get_commit_graph_filename(obj_dir);
-	the_repository->objects->commit_graph =
+	r->objects->commit_graph =
 		load_commit_graph_one(graph_name);
 
 	FREE_AND_NULL(graph_name);
@@ -203,26 +203,34 @@ static void prepare_commit_graph_one(const char *obj_dir)
  * On the first invocation, this function attemps to load the commit
  * graph if the_repository is configured to have one.
  */
-static int prepare_commit_graph(void)
+static int prepare_commit_graph(struct repository *r)
 {
 	struct alternate_object_database *alt;
 	char *obj_dir;
+	int config_value;
 
-	if (the_repository->objects->commit_graph_attempted)
-		return !!the_repository->objects->commit_graph;
-	the_repository->objects->commit_graph_attempted = 1;
+	if (r->objects->commit_graph_attempted)
+		return !!r->objects->commit_graph;
+	r->objects->commit_graph_attempted = 1;
 
-	if (!core_commit_graph)
+	if (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
+	    !config_value)
+		/*
+		 * This repository is not configured to use commit graphs, so
+		 * do not load one. (But report commit_graph_attempted anyway
+		 * so that commit graph loading is not attempted again for this
+		 * repository.)
+		 */
 		return 0;
 
-	obj_dir = get_object_directory();
-	prepare_commit_graph_one(obj_dir);
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects->alt_odb_list;
-	     !the_repository->objects->commit_graph && alt;
+	obj_dir = r->objects->objectdir;
+	prepare_commit_graph_one(r, obj_dir);
+	prepare_alt_odb(r);
+	for (alt = r->objects->alt_odb_list;
+	     !r->objects->commit_graph && alt;
 	     alt = alt->next)
-		prepare_commit_graph_one(alt->path);
-	return !!the_repository->objects->commit_graph;
+		prepare_commit_graph_one(r, alt->path);
+	return !!r->objects->commit_graph;
 }
 
 static void close_commit_graph(void)
@@ -323,8 +331,6 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
 {
 	uint32_t pos;
 
-	if (!core_commit_graph)
-		return 0;
 	if (item->object.parsed)
 		return 1;
 
@@ -334,20 +340,20 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
 	return 0;
 }
 
-int parse_commit_in_graph(struct commit *item)
+int parse_commit_in_graph(struct repository *r, struct commit *item)
 {
-	if (!prepare_commit_graph())
+	if (!prepare_commit_graph(r))
 		return 0;
-	return parse_commit_in_graph_one(the_repository->objects->commit_graph, item);
+	return parse_commit_in_graph_one(r->objects->commit_graph, item);
 }
 
-void load_commit_graph_info(struct commit *item)
+void load_commit_graph_info(struct repository *r, struct commit *item)
 {
 	uint32_t pos;
-	if (!prepare_commit_graph())
+	if (!prepare_commit_graph(r))
 		return;
-	if (find_commit_in_graph(item, the_repository->objects->commit_graph, &pos))
-		fill_commit_graph_info(item, the_repository->objects->commit_graph, pos);
+	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
+		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
 
 static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
@@ -373,9 +379,9 @@ static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
 	return load_tree_for_commit(g, (struct commit *)c);
 }
 
-struct tree *get_commit_tree_in_graph(const struct commit *c)
+struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit *c)
 {
-	return get_commit_tree_in_graph_one(the_repository->objects->commit_graph, c);
+	return get_commit_tree_in_graph_one(r->objects->commit_graph, c);
 }
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -691,7 +697,7 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc = approximate_object_count() / 4;
 
 	if (append) {
-		prepare_commit_graph_one(obj_dir);
+		prepare_commit_graph_one(the_repository, obj_dir);
 		if (the_repository->objects->commit_graph)
 			oids.alloc += the_repository->objects->commit_graph->num_commits;
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 94defb04a9..76e098934a 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -19,7 +19,7 @@ char *get_commit_graph_filename(const char *obj_dir);
  *
  * See parse_commit_buffer() for the fallback after this call.
  */
-int parse_commit_in_graph(struct commit *item);
+int parse_commit_in_graph(struct repository *r, struct commit *item);
 
 /*
  * It is possible that we loaded commit contents from the commit buffer,
@@ -27,9 +27,10 @@ int parse_commit_in_graph(struct commit *item);
  * checked and filled. Fill the graph_pos and generation members of
  * the given commit.
  */
-void load_commit_graph_info(struct commit *item);
+void load_commit_graph_info(struct repository *r, struct commit *item);
 
-struct tree *get_commit_tree_in_graph(const struct commit *c);
+struct tree *get_commit_tree_in_graph(struct repository *r,
+				      const struct commit *c);
 
 struct commit_graph {
 	int graph_fd;
diff --git a/commit.c b/commit.c
index c0a83d2644..39b80bd21d 100644
--- a/commit.c
+++ b/commit.c
@@ -342,7 +342,7 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
 
-	return get_commit_tree_in_graph(commit);
+	return get_commit_tree_in_graph(the_repository, commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
@@ -438,7 +438,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	item->date = parse_commit_date(bufptr, tail);
 
 	if (check_graph)
-		load_commit_graph_info(item);
+		load_commit_graph_info(the_repository, item);
 
 	return 0;
 }
@@ -454,7 +454,7 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(item))
+	if (use_commit_graph && parse_commit_in_graph(the_repository, item))
 		return 0;
 	buffer = read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
diff --git a/config.c b/config.c
index 139c903f6b..3aacddfec4 100644
--- a/config.c
+++ b/config.c
@@ -1309,11 +1309,6 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.commitgraph")) {
-		core_commit_graph = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 013e845235..6cf0079389 100644
--- a/environment.c
+++ b/environment.c
@@ -66,7 +66,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
-int core_commit_graph;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
diff --git a/ref-filter.c b/ref-filter.c
index 49021ee446..9b2da88392 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1713,7 +1713,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 
 	for (p = want; p; p = p->next) {
 		struct commit *c = p->item;
-		load_commit_graph_info(c);
+		load_commit_graph_info(the_repository, c);
 		if (c->generation < cutoff)
 			cutoff = c->generation;
 	}
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
new file mode 100644
index 0000000000..2762ca6562
--- /dev/null
+++ b/t/helper/test-repository.c
@@ -0,0 +1,82 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "commit-graph.h"
+#include "commit.h"
+#include "config.h"
+#include "object-store.h"
+#include "object.h"
+#include "repository.h"
+#include "tree.h"
+
+static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
+				       const struct object_id *commit_oid)
+{
+	struct repository r;
+	struct commit *c;
+	struct commit_list *parent;
+
+	repo_init(&r, gitdir, worktree);
+
+	c = lookup_commit(&r, commit_oid);
+
+	if (!parse_commit_in_graph(&r, c))
+		die("Couldn't parse commit");
+
+	printf("%"PRItime, c->date);
+	for (parent = c->parents; parent; parent = parent->next)
+		printf(" %s", oid_to_hex(&parent->item->object.oid));
+	printf("\n");
+
+	repo_clear(&r);
+}
+
+static void test_get_commit_tree_in_graph(const char *gitdir,
+					  const char *worktree,
+					  const struct object_id *commit_oid)
+{
+	struct repository r;
+	struct commit *c;
+	struct tree *tree;
+
+	repo_init(&r, gitdir, worktree);
+
+	c = lookup_commit(&r, commit_oid);
+
+	/*
+	 * get_commit_tree_in_graph does not automatically parse the commit, so
+	 * parse it first.
+	 */
+	if (!parse_commit_in_graph(&r, c))
+		die("Couldn't parse commit");
+	tree = get_commit_tree_in_graph(&r, c);
+	if (!tree)
+		die("Couldn't get commit tree");
+
+	printf("%s\n", oid_to_hex(&tree->object.oid));
+
+	repo_clear(&r);
+}
+
+int cmd__repository(int argc, const char **argv)
+{
+	if (argc < 2)
+		die("must have at least 2 arguments");
+	if (!strcmp(argv[1], "parse_commit_in_graph")) {
+		struct object_id oid;
+		if (argc < 5)
+			die("not enough arguments");
+		if (parse_oid_hex(argv[4], &oid, &argv[4]))
+			die("cannot parse oid '%s'", argv[4]);
+		test_parse_commit_in_graph(argv[2], argv[3], &oid);
+	} else if (!strcmp(argv[1], "get_commit_tree_in_graph")) {
+		struct object_id oid;
+		if (argc < 5)
+			die("not enough arguments");
+		if (parse_oid_hex(argv[4], &oid, &argv[4]))
+			die("cannot parse oid '%s'", argv[4]);
+		test_get_commit_tree_in_graph(argv[2], argv[3], &oid);
+	} else {
+		die("unrecognized '%s'", argv[1]);
+	}
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 805a45de9c..dafc91c240 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -29,6 +29,7 @@ static struct test_cmd cmds[] = {
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
+	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
 	{ "run-command", cmd__run_command },
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddfb94..80cbcf0857 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
+int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5947de3d24..4f17d7701e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -431,4 +431,39 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	test_must_fail git fsck
 '
 
+test_expect_success 'setup non-the_repository tests' '
+	rm -rf repo &&
+	git init repo &&
+	test_commit -C repo one &&
+	test_commit -C repo two &&
+	git -C repo config core.commitGraph true &&
+	git -C repo rev-parse two | \
+		git -C repo commit-graph write --stdin-commits
+'
+
+test_expect_success 'parse_commit_in_graph works for non-the_repository' '
+	test-tool repository parse_commit_in_graph \
+		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
+	echo $(git -C repo log --pretty="%ct" -1) \
+		$(git -C repo rev-parse one) >expect &&
+	test_cmp expect actual &&
+
+	test-tool repository parse_commit_in_graph \
+		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
+	echo $(git -C repo log --pretty="%ct" -1 one) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '
+	test-tool repository get_commit_tree_in_graph \
+		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
+	echo $(git -C repo rev-parse two^{tree}) >expect &&
+	test_cmp expect actual &&
+
+	test-tool repository get_commit_tree_in_graph \
+		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
+	echo $(git -C repo rev-parse one^{tree}) >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.203.gfac676dfb9-goog

