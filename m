Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD19F20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeLKF2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36172 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbeLKF2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so828562wmj.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjLdJ3Og+Hql5t7fmiNjUJuMDVAm3tVRpwC9E31PA/o=;
        b=Dh/PfDXUo4MG0XlIf+IETRYA8j/n+GC9FTD4LvvCp37PIKZV4WnWsrWpHAfHxyoIYb
         lSAn0YPjvAn8FDiZgycyGsB4SiiBohXmIfc1l1d6Kz3w8A7Clz/zJwWb1pVw6tJOV5Ds
         g0H75XwCULJqpEro/DDUbqzitHNvl/174bkLGjVtZVEwWkQNHPDcEi5P9E795eBTFiYu
         qZRbb7xzXtIXNxLJaPCiwhbCEx6sYz/ejoHFTstTdJTfkX2UxCwm4Ii8nsmzpkciYc2C
         BuaP8phsQMz8a5ejwzOrBEnuArRwawj1UktKNjTdS7CswcGa9ZDsfWdQSCsotYdC3ruG
         arPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjLdJ3Og+Hql5t7fmiNjUJuMDVAm3tVRpwC9E31PA/o=;
        b=BzOyHyoN58aeDMA1Uebt5KKFBAwXZB/SSJlbvJ6iOyGVYnnthRgRvECO5emocPreou
         H/pPDkyZmziK3U22wvCUXqMQsIHd9LZs0zIjrPEG5iNaHpk/njkapiLIcvM/1KVA5zrJ
         8Gs2rNFpsDx34dv+4BteSIuomPlI85cP5Ln5a2wdkI08KAm7SRQjv6cKAwC+gngD5gNp
         ip2ooAt3djk1HQZ05aUuOvopGqdzq2vBzTPTFCXtI13YkO2Of9187Ki04Uch4bbc2rTG
         zWfHGH/Z3o+nkxNGACaAKd87by6hGjM4Y9yDphbuVE/fufNdX0+qLt6wCfk3hYXUQsBt
         n9mA==
X-Gm-Message-State: AA+aEWa/YgRB5G9S7LI9Qql/HXPQ/y6ILNytZu+HtxRsJr9ug3wSnqVA
        CQvUT7UJrT44setxQL8VbxuPEoTa
X-Google-Smtp-Source: AFSGD/VYOakLY1GmDjYY04tC8BP9a/6rMrM8mlGSLg8W9+11Ryn/cJCkV3KrKCQ1dCReB/M9x6Vp5Q==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr958098wmh.0.1544506093299;
        Mon, 10 Dec 2018 21:28:13 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:12 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v1 6/8] Use promisors_get_direct() and has_promisor_remote()
Date:   Tue, 11 Dec 2018 06:27:44 +0100
Message-Id: <20181211052746.16218-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
In-Reply-To: <20181211052746.16218-1-chriscool@tuxfamily.org>
References: <20181211052746.16218-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the repository_format_partial_clone global
and fetch_objects() directly, let's use has_promisor_remote()
and promisors_get_direct().

This way all the configured promisor remotes will be taken
into account, not only the one specified by
extensions.partialClone.

Also when cloning or fetching using a partial clone filter,
remote.origin.promisor will be set to "true" instead of
setting extensions.partialClone to "origin". This makes it
possible to use many promisor remote just by fetching from
them.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/cat-file.c            |  5 +++--
 builtin/fetch.c               | 11 ++++++-----
 builtin/gc.c                  |  3 ++-
 builtin/repack.c              |  3 ++-
 cache-tree.c                  |  3 ++-
 connected.c                   |  3 ++-
 list-objects-filter-options.c | 28 +++++++++++++++-------------
 packfile.c                    |  3 ++-
 sha1-file.c                   | 14 ++++++++------
 t/t5601-clone.sh              |  2 +-
 t/t5616-partial-clone.sh      |  2 +-
 unpack-trees.c                |  6 +++---
 12 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2ca56fd086..bdb0331ba4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -14,6 +14,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 
 struct batch_options {
 	int enabled;
@@ -517,8 +518,8 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->all_objects) {
 		struct object_cb_data cb;
 
-		if (repository_format_partial_clone)
-			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
+		if (has_promisor_remote())
+			warning("This repository uses promisor remotes. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..647a60b26c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "promisor-remote.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -1459,7 +1460,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!repository_format_partial_clone && !filter_options.choice)
+	if (!has_promisor_remote() && !filter_options.choice)
 		return;
 
 	/*
@@ -1467,7 +1468,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * on this repo and remember the given filter-spec as the default
 	 * for subsequent fetches to this remote.
 	 */
-	if (!repository_format_partial_clone && filter_options.choice) {
+	if (!has_promisor_remote() && filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
@@ -1476,7 +1477,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * We are currently limited to only ONE promisor remote and only
 	 * allow partial-fetches from the promisor remote.
 	 */
-	if (strcmp(remote->name, repository_format_partial_clone)) {
+	if (!find_promisor_remote(remote->name)) {
 		if (filter_options.choice)
 			die(_("--filter can only be used with the remote configured in core.partialClone"));
 		return;
@@ -1607,7 +1608,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !repository_format_partial_clone)
+	if (filter_options.choice && !has_promisor_remote())
 		die("--filter can only be used when extensions.partialClone is set");
 
 	if (all) {
@@ -1641,7 +1642,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (remote) {
-		if (filter_options.choice || repository_format_partial_clone)
+		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
diff --git a/builtin/gc.c b/builtin/gc.c
index 871a56f1c5..42dfa3a23c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -27,6 +27,7 @@
 #include "pack-objects.h"
 #include "blob.h"
 #include "tree.h"
+#include "promisor-remote.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -640,7 +641,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
-			if (repository_format_partial_clone)
+			if (has_promisor_remote())
 				argv_array_push(&prune,
 						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
diff --git a/builtin/repack.c b/builtin/repack.c
index 45583683ee..26e02e3135 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -11,6 +11,7 @@
 #include "midx.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -366,7 +367,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
-	if (repository_format_partial_clone)
+	if (has_promisor_remote())
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
diff --git a/cache-tree.c b/cache-tree.c
index 9d454d24bc..a1ecb2a1fa 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -5,6 +5,7 @@
 #include "cache-tree.h"
 #include "object-store.h"
 #include "replace-object.h"
+#include "promisor-remote.h"
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -357,7 +358,7 @@ static int update_one(struct cache_tree *it,
 		}
 
 		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
-			(repository_format_partial_clone &&
+			(has_promisor_remote() &&
 			 ce_skip_worktree(ce));
 		if (is_null_oid(oid) ||
 		    (!ce_missing_ok && !has_object_file(oid))) {
diff --git a/connected.c b/connected.c
index 1bba888eff..0eaaedee6a 100644
--- a/connected.c
+++ b/connected.c
@@ -4,6 +4,7 @@
 #include "connected.h"
 #include "transport.h"
 #include "packfile.h"
+#include "promisor-remote.h"
 
 /*
  * If we feed all the commits we want to verify to this command
@@ -56,7 +57,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
-	if (repository_format_partial_clone)
+	if (has_promisor_remote())
 		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		argv_array_push(&rev_list.args, "--not");
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e8da2e8581..3b5ff55480 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "promisor-remote.h"
 
 /*
  * Parse value of the argument to the "filter" keyword.
@@ -125,30 +126,31 @@ void partial_clone_register(
 	const char *remote,
 	const struct list_objects_filter_options *filter_options)
 {
-	/*
-	 * Record the name of the partial clone remote in the
-	 * config and in the global variable -- the latter is
-	 * used throughout to indicate that partial clone is
-	 * enabled and to expect missing objects.
-	 */
-	if (repository_format_partial_clone &&
-	    *repository_format_partial_clone &&
-	    strcmp(remote, repository_format_partial_clone))
-		die(_("cannot change partial clone promisor remote"));
+	char *cfg_name;
 
-	git_config_set("core.repositoryformatversion", "1");
-	git_config_set("extensions.partialclone", remote);
+	/* Check if it is already registered */
+	if (!find_promisor_remote(remote)) {
+		git_config_set("core.repositoryformatversion", "1");
 
-	repository_format_partial_clone = xstrdup(remote);
+		/* Add promisor config for the remote */
+		cfg_name = xstrfmt("remote.%s.promisor", remote);
+		git_config_set(cfg_name, "true");
+		free(cfg_name);
+	}
 
 	/*
 	 * Record the initial filter-spec in the config as
 	 * the default for subsequent fetches from this remote.
+	 *
+	 * TODO: record it into remote.<name>.partialclonefilter
 	 */
 	core_partial_clone_filter_default =
 		xstrdup(filter_options->filter_spec);
 	git_config_set("core.partialclonefilter",
 		       core_partial_clone_filter_default);
+
+	/* Make sure the config info are reset */
+	promisor_remote_reinit();
 }
 
 void partial_clone_get_default_filter_spec(
diff --git a/packfile.c b/packfile.c
index d1e6683ffe..7aaeea7693 100644
--- a/packfile.c
+++ b/packfile.c
@@ -16,6 +16,7 @@
 #include "tree.h"
 #include "object-store.h"
 #include "midx.h"
+#include "promisor-remote.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -2113,7 +2114,7 @@ int is_promisor_object(const struct object_id *oid)
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
-		if (repository_format_partial_clone) {
+		if (has_promisor_remote()) {
 			for_each_packed_object(add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY);
diff --git a/sha1-file.c b/sha1-file.c
index cf88eeb147..f1acaa3254 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -32,6 +32,7 @@
 #include "packfile.h"
 #include "fetch-object.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -1309,15 +1310,16 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		}
 
 		/* Check if it is a missing object */
-		if (fetch_if_missing && repository_format_partial_clone &&
+		if (fetch_if_missing && has_promisor_remote() &&
 		    !already_retried && r == the_repository) {
 			/*
-			 * TODO Investigate checking fetch_object() return
-			 * TODO value and stopping on error here.
-			 * TODO Pass a repository struct through fetch_object,
-			 * such that arbitrary repositories work.
+			 * TODO Investigate checking promisors_get_direct()
+			 * TODO return value and stopping on error here.
+			 * TODO Pass a repository struct through
+			 * promisors_get_direct(), such that arbitrary
+			 * repositories work.
 			 */
-			fetch_objects(repository_format_partial_clone, real, 1);
+			promisors_get_direct(real, 1);
 			already_retried = 1;
 			continue;
 		}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8bbc7068ac..aafe55b8b7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -653,7 +653,7 @@ partial_clone () {
 	git -C client fsck &&
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
-	test_config -C client extensions.partialclone "not a remote" &&
+	test_config -C client remote.origin.promisor "false" &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 336f02a41a..d09dee1f14 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'do partial clone 1' '
 
 	test_cmp expect_1.oids observed.oids &&
 	test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
-	test "$(git -C pc1 config --local extensions.partialclone)" = "origin" &&
+	test "$(git -C pc1 config --local remote.origin.promisor)" = "true" &&
 	test "$(git -C pc1 config --local core.partialclonefilter)" = "blob:none"
 '
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..9ad157eeab 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "fetch-object.h"
+#include "promisor-remote.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -418,7 +419,7 @@ static int check_updates(struct unpack_trees_options *o)
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
-	if (repository_format_partial_clone && o->update && !o->dry_run) {
+	if (has_promisor_remote() && o->update && !o->dry_run) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -435,8 +436,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 		if (to_fetch.nr)
-			fetch_objects(repository_format_partial_clone,
-				      to_fetch.oid, to_fetch.nr);
+			promisors_get_direct(to_fetch.oid, to_fetch.nr);
 		fetch_if_missing = fetch_if_missing_store;
 		oid_array_clear(&to_fetch);
 	}
-- 
2.20.0.rc2.14.g1379de12fa.dirty

