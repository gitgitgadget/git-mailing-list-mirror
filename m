Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404491F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933784AbeFUV3o (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:29:44 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:41843 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933592AbeFUV3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:42 -0400
Received: by mail-qt0-f202.google.com with SMTP id 12-v6so3522387qtq.8
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/Nabu6PddZsX9Lad5rV+WWvY0eIqUAwu7A2gicIN5V0=;
        b=pGn3ofrp4egOubf0Y24IHt8HdgIe9odPkrNZP/Kr6JJ4WZuO+BpM6NiQIRUkWsxLM9
         Ta9EMZJ6agV1T7H2hejTe7QEZKFN/9ShiTLxnee58PTqx7vS9WACgSObJxJsCf7wWnF2
         Rv+O6PgqWEZQrufytalbO32rjrCXbDWIskF9NWbZYDAX6GwwQLj4VEiK9lB3iqIzKpRp
         a/qwZgsU1B5eg3vx76wnDdy/tvpVXiW8BQ6COz83FZGttADhmYZ1t79oDaVIEItAzerG
         yvsodLjejZyD5LrqFJ1lyqlsPxX4Ty6Y6aH36Pn5dg020yNW2xXGf3gufeJN+ER9HTdQ
         CSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/Nabu6PddZsX9Lad5rV+WWvY0eIqUAwu7A2gicIN5V0=;
        b=V6XJMfgEQX2AgU/v7JRg3uX84tduCOZiNBU9i1pWE8HUwy8fnkQdUw5q8Bwlfi/G9j
         3zytg/2CgElWJuuTWhJw9HGxVIVynXfS6tNaoKtKoPiSAQnh9f3EHc0UtDB2hVfLncYr
         Vm5fMCtI91wzvR4G0lLtezlYHQuklitTOscQovECL8+HsDBjWsisVbz9/YsE/cQpdaJu
         fHkNJhg0m7KYkrSYP8/jXnnoPlG66Bl19Y+/SbdRxWabnJER8HFau8wRspQ/joqn9FMY
         FnOQklVvnwR5Og+55HocISbtk70xWHk233YNYllifElx6WGIXDQwrUEzvoCqraxL0gfA
         IGZg==
X-Gm-Message-State: APt69E2lZOsF/BCJeEVWdPA67593THQ7O063iv48CCZqpgGKDmcy1ruW
        6z/khYIKq28tFv2vdNnVgtZtg6GBTgpA+Plr41zKrtq7FZ0OmBT4EapViw/ep/Uipya/ro3UTng
        7+lT1KrRAKGNzH3myS2ZZeTHYFll1G55g3qOI5HSygtIA6+zHRvRV0BlCJ/I/T0qRH1nGReHLgV
        KO
X-Google-Smtp-Source: ADUXVKJ2a0lENc8bj1lMBTbGYh34YyUk9+yzAmSSBg9PwAjPJHUDYQmDECW9bT/PWuNnTBx726N/JFevyjE6AY65Lgsx
MIME-Version: 1.0
X-Received: by 2002:a37:c40a:: with SMTP id d10-v6mr1012655qki.9.1529616581671;
 Thu, 21 Jun 2018 14:29:41 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:29:25 -0700
In-Reply-To: <cover.1529616356.git.jonathantanmy@google.com>
Message-Id: <da1a513f2508602e0736b6fbe142b2445948bd5c.1529616356.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: [PATCH 5/5] commit-graph: add repo arg to graph readers
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
 cache.h                    |  1 -
 commit-graph.c             | 52 +++++++++++++---------
 commit-graph.h             |  5 ++-
 commit.c                   |  4 +-
 config.c                   |  5 ---
 environment.c              |  1 -
 t/helper/test-repository.c | 88 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/t5318-commit-graph.sh    | 35 +++++++++++++++
 11 files changed, 162 insertions(+), 32 deletions(-)
 create mode 100644 t/helper/test-repository.c

diff --git a/Makefile b/Makefile
index e4b503d259..12d754cb70 100644
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
diff --git a/cache.h b/cache.h
index 89a107a7f7..ebf699fb0f 100644
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
index 61b4fbb925..12c4addf75 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -179,36 +179,47 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
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
 }
 
-static void prepare_commit_graph(void)
+static void prepare_commit_graph(struct repository *r)
 {
 	struct alternate_object_database *alt;
 	char *obj_dir;
+	int config_value;
 
-	if (the_repository->objects->commit_graph_attempted)
+	if (r->objects->commit_graph_attempted)
+		return;
+	r->objects->commit_graph_attempted = 1;
+
+	if (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
+	    !config_value)
+		/*
+		 * This repository is not configured to use commit graphs, so
+		 * do not load one. (But report commit_graph_attempted anyway
+		 * so that commit graph loading is not attempted again for this
+		 * repository.)
+		 */
 		return;
-	the_repository->objects->commit_graph_attempted = 1;
 
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
+		prepare_commit_graph_one(r, alt->path);
 }
 
 static void close_commit_graph(void)
@@ -282,17 +293,15 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	return 1;
 }
 
-int parse_commit_in_graph(struct commit *item)
+int parse_commit_in_graph(struct repository *r, struct commit *item)
 {
-	if (!core_commit_graph)
-		return 0;
 	if (item->object.parsed)
 		return 1;
 
-	prepare_commit_graph();
-	if (the_repository->objects->commit_graph) {
+	prepare_commit_graph(r);
+	if (r->objects->commit_graph) {
 		struct commit_graph *commit_graph =
-			the_repository->objects->commit_graph;
+			r->objects->commit_graph;
 		uint32_t pos;
 		int found;
 		if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
@@ -321,14 +330,15 @@ static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *
 	return c->maybe_tree;
 }
 
-struct tree *get_commit_tree_in_graph(const struct commit *c)
+struct tree *get_commit_tree_in_graph(struct repository *r,
+				      const struct commit *c)
 {
 	if (c->maybe_tree)
 		return c->maybe_tree;
 	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
 
-	return load_tree_for_commit(the_repository->objects->commit_graph,
+	return load_tree_for_commit(r->objects->commit_graph,
 				    (struct commit *)c);
 }
 
@@ -588,7 +598,7 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc = approximate_object_count() / 4;
 
 	if (append) {
-		prepare_commit_graph_one(obj_dir);
+		prepare_commit_graph_one(the_repository, obj_dir);
 		if (the_repository->objects->commit_graph)
 			oids.alloc += the_repository->objects->commit_graph->num_commits;
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 320ee9fd8a..192ea2ca77 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -17,9 +17,10 @@ char *get_commit_graph_filename(const char *obj_dir);
  *
  * See parse_commit_buffer() for the fallback after this call.
  */
-int parse_commit_in_graph(struct commit *item);
+int parse_commit_in_graph(struct repository *r, struct commit *item);
 
-struct tree *get_commit_tree_in_graph(const struct commit *c);
+struct tree *get_commit_tree_in_graph(struct repository *r,
+				      const struct commit *c);
 
 struct commit_graph {
 	int graph_fd;
diff --git a/commit.c b/commit.c
index 0030e79940..38c12b002f 100644
--- a/commit.c
+++ b/commit.c
@@ -317,7 +317,7 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
 
-	return get_commit_tree_in_graph(commit);
+	return get_commit_tree_in_graph(the_repository, commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
@@ -413,7 +413,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (parse_commit_in_graph(item))
+	if (parse_commit_in_graph(the_repository, item))
 		return 0;
 	buffer = read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
diff --git a/config.c b/config.c
index fbbf0f8e9f..072e9bdb4d 100644
--- a/config.c
+++ b/config.c
@@ -1308,11 +1308,6 @@ static int git_default_core_config(const char *var, const char *value)
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
index 2a6de2330b..d6e5b39425 100644
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
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
new file mode 100644
index 0000000000..5fff540a26
--- /dev/null
+++ b/t/helper/test-repository.c
@@ -0,0 +1,88 @@
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
+	/*
+	 * Create a commit independent of any repository.
+	 */
+	c = lookup_commit(commit_oid);
+
+	repo_init(&r, gitdir, worktree);
+
+	if (!parse_commit_in_graph(&r, c))
+		die("Couldn't parse commit");
+
+	printf("%lu", c->date);
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
+	/*
+	 * Create a commit independent of any repository.
+	 */
+	c = lookup_commit(commit_oid);
+
+	repo_init(&r, gitdir, worktree);
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
index a380419b65..f80bbaec7f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -221,4 +221,39 @@ test_expect_success 'write graph in bare repo' '
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare commits/8 merge/2
 
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
2.18.0.rc2.347.g0da03f3a46.dirty

