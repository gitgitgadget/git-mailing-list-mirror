Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D8F1F42B
	for <e@80x24.org>; Wed,  3 Jan 2018 16:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeACQeo (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45417 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQeg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id 9so3634058wme.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OhNDtuBPIF4FsAtYa1JhPQFJHVcaAF29L3GUM37oFLo=;
        b=rTYhI7DOlbo+t8wsofKLyQ5gCJ5BcPNgfaCz/8lq3IyrRn0KvaZcmk4mgpxcJi4dZp
         JwoFL8zTGH3ks3t0XLk+PG7IIeMCxS1lxK4sUKNI6wHQUD7TWlwaVYYTfR6bXdwKyW3U
         7As0Vyu/BEajyCXsNjMyGEyoYS3ktVOCgCJgtoIKFJTTrtz72CFkIca6RCDkcSE60I7R
         zshwRZjNIOdeKWQh0+qYl5Lx2EZLalnKeqbfw4pUY407vfkTpotrrLTElczMsoSGrGkK
         FjdMD9gzW4883FXVAh5YqU/GBzsG++3T6WOYA+z+daqWhzbZwFc2ubZkKiMeJVdaQyFb
         ny8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OhNDtuBPIF4FsAtYa1JhPQFJHVcaAF29L3GUM37oFLo=;
        b=QpIK7M1s4spTokfafTLE+SV+B4pB7Yk1IWt6/Lx6QdSSQWc5wclOqb/9m2yc0q5VF9
         0gJevMlBAL70p9GGG3jabZFB/p1wdjD1qFTZsXzRKv+nmZPNLf6qxmZpPko6K96P65Q8
         9s0AEmH2StyXYByicAcM5EM+mE4PVVxQYB6f7hsXs4fUoGxqHjZzUwRX3rVbmJsX8FOq
         Exj3dI6+QXU1tW7HbO0jRVusakRAzWAfce0jzR6aQDJi2yBBf9uLWK8cORT0OhrPMsKz
         MLNXfMcRZRXbiDXorkyhQ+Mq7gSs35ViXIG3k8TQGLCHINagFyIkUPO1XThiMotbh3hf
         rfwA==
X-Gm-Message-State: AKGB3mIQw6/99ZW/BvnrOQPSskb7vLuT0IvB6XuJK9LKzxi3PYa842Lz
        fZLdNjrOJ4N8rRv4NEW/bI+osIfZ
X-Google-Smtp-Source: ACJfBoulVG5zH03ZIL7ZNE5I2JvYXTrXmZF65UpxT3Y7t2D4PPAObZJlajZrD+RfvbT7PsPdbC7evg==
X-Received: by 10.28.61.135 with SMTP id k129mr1749624wma.81.1514997274667;
        Wed, 03 Jan 2018 08:34:34 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:33 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 12/40] rev-list: support termination at promisor objects
Date:   Wed,  3 Jan 2018 17:33:35 +0100
Message-Id: <20180103163403.11303-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach rev-list to support termination of an object traversal at any
object from a promisor remote (whether one that the local repo also has,
or one that the local repo knows about because it has another promisor
object that references it).

This will be used subsequently in gc and in the connectivity check used
by fetch.

For efficiency, if an object is referenced by a promisor object, and is
in the local repo only as a non-promisor object, object traversal will
not stop there. This is to avoid building the list of promisor object
references.

(In list-objects.c, the case where obj is NULL in process_blob() and
process_tree() do not need to be changed because those happen only when
there is a conflict between the expected type and the existing object.
If the object doesn't exist, an object will be synthesized, which is
fine.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt |  11 ++++
 builtin/rev-list.c                 |  69 ++++++++++++++++++++++---
 list-objects.c                     |  29 ++++++++++-
 object.c                           |   2 +-
 revision.c                         |  33 +++++++++++-
 revision.h                         |   5 +-
 t/t0410-partial-clone.sh           | 101 +++++++++++++++++++++++++++++++++++++
 7 files changed, 239 insertions(+), 11 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 22f5c9b43d..7b273635de 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -750,10 +750,21 @@ The form '--missing=allow-any' will allow object traversal to continue
 if a missing object is encountered.  Missing objects will silently be
 omitted from the results.
 +
+The form '--missing=allow-promisor' is like 'allow-any', but will only
+allow object traversal to continue for EXPECTED promisor missing objects.
+Unexpected missing objects will raise an error.
++
 The form '--missing=print' is like 'allow-any', but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
 endif::git-rev-list[]
 
+--exclude-promisor-objects::
+	(For internal use only.)  Prefilter object traversal at
+	promisor boundary.  This is used with partial clone.  This is
+	stronger than `--missing=allow-promisor` because it limits the
+	traversal, rather than just silencing errors about missing
+	objects.
+
 --no-walk[=(sorted|unsorted)]::
 	Only show the given commits, but do not traverse their ancestors.
 	This has no effect if a range is specified. If the argument
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d5345b6a2e..e27aa1fc07 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -15,6 +15,7 @@
 #include "progress.h"
 #include "reflog-walk.h"
 #include "oidset.h"
+#include "packfile.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -67,6 +68,7 @@ enum missing_action {
 	MA_ERROR = 0,    /* fail if any missing objects are encountered */
 	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
 	MA_PRINT,        /* print ALL missing objects in special section */
+	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
 };
 static enum missing_action arg_missing_action;
 
@@ -197,6 +199,12 @@ static void finish_commit(struct commit *commit, void *data)
 
 static inline void finish_object__ma(struct object *obj)
 {
+	/*
+	 * Whether or not we try to dynamically fetch missing objects
+	 * from the server, we currently DO NOT have the object.  We
+	 * can either print, allow (ignore), or conditionally allow
+	 * (ignore) them.
+	 */
 	switch (arg_missing_action) {
 	case MA_ERROR:
 		die("missing blob object '%s'", oid_to_hex(&obj->oid));
@@ -209,25 +217,36 @@ static inline void finish_object__ma(struct object *obj)
 		oidset_insert(&missing_objects, &obj->oid);
 		return;
 
+	case MA_ALLOW_PROMISOR:
+		if (is_promisor_object(&obj->oid))
+			return;
+		die("unexpected missing blob object '%s'",
+		    oid_to_hex(&obj->oid));
+		return;
+
 	default:
 		BUG("unhandled missing_action");
 		return;
 	}
 }
 
-static void finish_object(struct object *obj, const char *name, void *cb_data)
+static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
+	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
 		finish_object__ma(obj);
+		return 1;
+	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(&obj->oid);
+	return 0;
 }
 
 static void show_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	finish_object(obj, name, cb_data);
+	if (finish_object(obj, name, cb_data))
+		return;
 	display_progress(progress, ++progress_counter);
 	if (info->flags & REV_LIST_QUIET)
 		return;
@@ -315,11 +334,19 @@ static inline int parse_missing_action_value(const char *value)
 
 	if (!strcmp(value, "allow-any")) {
 		arg_missing_action = MA_ALLOW_ANY;
+		fetch_if_missing = 0;
 		return 1;
 	}
 
 	if (!strcmp(value, "print")) {
 		arg_missing_action = MA_PRINT;
+		fetch_if_missing = 0;
+		return 1;
+	}
+
+	if (!strcmp(value, "allow-promisor")) {
+		arg_missing_action = MA_ALLOW_PROMISOR;
+		fetch_if_missing = 0;
 		return 1;
 	}
 
@@ -344,6 +371,35 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+
+	/*
+	 * Scan the argument list before invoking setup_revisions(), so that we
+	 * know if fetch_if_missing needs to be set to 0.
+	 *
+	 * "--exclude-promisor-objects" acts as a pre-filter on missing objects
+	 * by not crossing the boundary from realized objects to promisor
+	 * objects.
+	 *
+	 * Let "--missing" to conditionally set fetch_if_missing.
+	 */
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--exclude-promisor-objects")) {
+			fetch_if_missing = 0;
+			revs.exclude_promisor_objects = 1;
+			break;
+		}
+	}
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (skip_prefix(arg, "--missing=", &arg)) {
+			if (revs.exclude_promisor_objects)
+				die(_("cannot combine --exclude-promisor-objects and --missing"));
+			if (parse_missing_action_value(arg))
+				break;
+		}
+	}
+
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	memset(&info, 0, sizeof(info));
@@ -412,9 +468,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (skip_prefix(arg, "--missing=", &arg) &&
-		    parse_missing_action_value(arg))
-			continue;
+		if (!strcmp(arg, "--exclude-promisor-objects"))
+			continue; /* already handled above */
+		if (skip_prefix(arg, "--missing=", &arg))
+			continue; /* already handled above */
 
 		usage(rev_list_usage);
 
diff --git a/list-objects.c b/list-objects.c
index 0966cdc9fa..168bef688a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -9,6 +9,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "packfile.h"
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
@@ -30,6 +31,20 @@ static void process_blob(struct rev_info *revs,
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 
+	/*
+	 * Pre-filter known-missing objects when explicitly requested.
+	 * Otherwise, a missing object error message may be reported
+	 * later (depending on other filtering criteria).
+	 *
+	 * Note that this "--exclude-promisor-objects" pre-filtering
+	 * may cause the actual filter to report an incomplete list
+	 * of missing objects.
+	 */
+	if (revs->exclude_promisor_objects &&
+	    !has_object_file(&obj->oid) &&
+	    is_promisor_object(&obj->oid))
+		return;
+
 	pathlen = path->len;
 	strbuf_addstr(path, name);
 	if (filter_fn)
@@ -91,6 +106,8 @@ static void process_tree(struct rev_info *revs,
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
+	int gently = revs->ignore_missing_links ||
+		     revs->exclude_promisor_objects;
 
 	if (!revs->tree_objects)
 		return;
@@ -98,9 +115,19 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, revs->ignore_missing_links) < 0) {
+	if (parse_tree_gently(tree, gently) < 0) {
 		if (revs->ignore_missing_links)
 			return;
+
+		/*
+		 * Pre-filter known-missing tree objects when explicitly
+		 * requested.  This may cause the actual filter to report
+		 * an incomplete list of missing objects.
+		 */
+		if (revs->exclude_promisor_objects &&
+		    is_promisor_object(&obj->oid))
+			return;
+
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
diff --git a/object.c b/object.c
index b9a4a0e501..4c222d6260 100644
--- a/object.c
+++ b/object.c
@@ -252,7 +252,7 @@ struct object *parse_object(const struct object_id *oid)
 	if (obj && obj->parsed)
 		return obj;
 
-	if ((obj && obj->type == OBJ_BLOB) ||
+	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
 	     sha1_object_info(oid->hash, NULL) == OBJ_BLOB)) {
 		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
diff --git a/revision.c b/revision.c
index 72f2b4572e..f246728f2d 100644
--- a/revision.c
+++ b/revision.c
@@ -198,6 +198,8 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
+		if (revs->exclude_promisor_objects && is_promisor_object(oid))
+			return NULL;
 		die("bad object %s", name);
 	}
 	object->flags |= flags;
@@ -799,9 +801,17 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
-
-		if (parse_commit_gently(p, revs->ignore_missing_links) < 0)
+		int gently = revs->ignore_missing_links ||
+			     revs->exclude_promisor_objects;
+		if (parse_commit_gently(p, gently) < 0) {
+			if (revs->exclude_promisor_objects &&
+			    is_promisor_object(&p->object.oid)) {
+				if (revs->first_parent_only)
+					break;
+				continue;
+			}
 			return -1;
+		}
 		if (revs->show_source && !p->util)
 			p->util = commit->util;
 		p->object.flags |= left_flag;
@@ -2100,6 +2110,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
+	} else if (!strcmp(arg, "--exclude-promisor-objects")) {
+		if (fetch_if_missing)
+			die("BUG: exclude_promisor_objects can only be used when fetch_if_missing is 0");
+		revs->exclude_promisor_objects = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
@@ -2842,6 +2856,16 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN);
 }
 
+static int mark_uninteresting(const struct object_id *oid,
+			      struct packed_git *pack,
+			      uint32_t pos,
+			      void *unused)
+{
+	struct object *o = parse_object(oid);
+	o->flags |= UNINTERESTING | SEEN;
+	return 0;
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -2870,6 +2894,11 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
+	if (revs->exclude_promisor_objects) {
+		for_each_packed_object(mark_uninteresting, NULL,
+				       FOR_EACH_OBJECT_PROMISOR_ONLY);
+	}
+
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
diff --git a/revision.h b/revision.h
index 19dc9bdddb..eb14994316 100644
--- a/revision.h
+++ b/revision.h
@@ -122,7 +122,10 @@ struct rev_info {
 			ancestry_path:1,
 			first_parent_only:1,
 			line_level_traverse:1,
-			tree_blobs_in_commit_order:1;
+			tree_blobs_in_commit_order:1,
+
+			/* for internal use only */
+			exclude_promisor_objects:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 8b20d18603..4dc02459a5 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -160,6 +160,107 @@ test_expect_success 'fetching of missing objects' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
+test_expect_success 'rev-list stops traversal at missing and promised commit' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+
+	FOO=$(git -C repo rev-parse foo) &&
+	promise_and_delete "$FOO" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
+	grep $(git -C repo rev-parse bar) out &&
+	! grep $FOO out
+'
+
+test_expect_success 'rev-list stops traversal at missing and promised tree' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	mkdir repo/a_dir &&
+	echo something >repo/a_dir/something &&
+	git -C repo add a_dir/something &&
+	git -C repo commit -m bar &&
+
+	# foo^{tree} (tree referenced from commit)
+	TREE=$(git -C repo rev-parse foo^{tree}) &&
+
+	# a tree referenced by HEAD^{tree} (tree referenced from tree)
+	TREE2=$(git -C repo ls-tree HEAD^{tree} | grep " tree " | head -1 | cut -b13-52) &&
+
+	promise_and_delete "$TREE" &&
+	promise_and_delete "$TREE2" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	grep $(git -C repo rev-parse foo) out &&
+	! grep $TREE out &&
+	grep $(git -C repo rev-parse HEAD) out &&
+	! grep $TREE2 out
+'
+
+test_expect_success 'rev-list stops traversal at missing and promised blob' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	echo something >repo/something &&
+	git -C repo add something &&
+	git -C repo commit -m foo &&
+
+	BLOB=$(git -C repo hash-object -w something) &&
+	promise_and_delete "$BLOB" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	grep $(git -C repo rev-parse HEAD) out &&
+	! grep $BLOB out
+'
+
+test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+	test_commit -C repo baz &&
+
+	COMMIT=$(git -C repo rev-parse foo) &&
+	TREE=$(git -C repo rev-parse bar^{tree}) &&
+	BLOB=$(git hash-object repo/baz.t) &&
+	printf "%s\n%s\n%s\n" $COMMIT $TREE $BLOB | pack_as_from_promisor &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	! grep $COMMIT out &&
+	! grep $TREE out &&
+	! grep $BLOB out &&
+	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
+'
+
+test_expect_success 'rev-list accepts missing and promised objects on command line' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+	test_commit -C repo baz &&
+
+	COMMIT=$(git -C repo rev-parse foo) &&
+	TREE=$(git -C repo rev-parse bar^{tree}) &&
+	BLOB=$(git hash-object repo/baz.t) &&
+
+	promise_and_delete $COMMIT &&
+	promise_and_delete $TREE &&
+	promise_and_delete $BLOB &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
+'
+
 LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

