Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934961F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfFYNlR (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44667 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfFYNlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so27166434edr.11
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUjbfaX8x/Hkcz066532dyQDPSZwjfDnEtWBELfOa/c=;
        b=lLocThYbPXloHgK5vJVHeFpoOja8CXzsSM5uzH1Cwis1Xk700uPR7E3m1Hf/wCbRPo
         0oivaMKoOK/Hqf5wIf0IV6qGUQJuZQOcGuCw/XyV8y5nOrq/i3UeCVmAHNZZu4QTsIlf
         K0KNPZ0MCMHNaa7JYxH9xSSmJ84WqiJHO5Woie17oPy5KZTv2kIq4hd+w5yv0P5Bmoci
         9pj58HVpbdaZmxEF/PMEH1OLVrTKWtYETQuIpoDN/2TVZIQ8qUKQgYm4kwWmsPqO6yLe
         MP/eSpKBGKntTKe9jDlXAWuBSpfXOo9EHebaIWRsbuE39ftfJMtFs2fvwACbcLNZp5rO
         WDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUjbfaX8x/Hkcz066532dyQDPSZwjfDnEtWBELfOa/c=;
        b=rvBNZiXVsJVHfxD0gb4YeVhc79Pr/VE2HHkg0N52z7v9x0hFfT9Ez8TUFPB0bX9dAI
         W7zOEwKQbysgyLo4D5MSh52U4F5t8U0cA3xozN0L6/xk/PPISpR+v0Z0VT6/OQFI1qBo
         aeOxtBkko7Ev9F8rY2M7HrlaTf2VK/BitznTeuLDDn7V7mqF97BsJmMoTR7a4CxXcJ7Q
         Y4SnG0Mn60zZWd5b8N+CfHtSAI86tGVQP5ub/s7qSybFF9wolfCoJo3v+es9QxrOn2mO
         pKKAoRbuwlT2tp1pX6VcMGz7w8/utLH680JQCXZNo/Zlo7Lh2nuOVQxwD7p/4Gi5eXVF
         ITzQ==
X-Gm-Message-State: APjAAAUIB3/mNy6AVfpljkcSHHKVOxWRXLo4ialwjsTy35Dy7PXtVp5p
        MBwqU2v0lqlX/o/TL12UeE69EumbO9c=
X-Google-Smtp-Source: APXvYqyyHLlu3OmJ61SbFC4OPeoxx7hhzlnDSd1Y3fJF8RvsdU7k44aTfSzY7ku837uKL0yLZZZZ/Q==
X-Received: by 2002:a17:906:c404:: with SMTP id u4mr6731999ejz.123.1561470073435;
        Tue, 25 Jun 2019 06:41:13 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 07/15] Use promisor_remote_get_direct() and has_promisor_remote()
Date:   Tue, 25 Jun 2019 15:40:31 +0200
Message-Id: <20190625134039.21707-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the repository_format_partial_clone global
and fetch_objects() directly, let's use has_promisor_remote()
and promisor_remote_get_direct().

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
 builtin/index-pack.c          |  8 ++++----
 builtin/repack.c              |  3 ++-
 cache-tree.c                  |  3 ++-
 connected.c                   |  3 ++-
 diff.c                        |  9 ++++-----
 list-objects-filter-options.c | 28 +++++++++++++++-------------
 packfile.c                    |  3 ++-
 sha1-file.c                   | 15 ++++++++-------
 t/t5601-clone.sh              |  2 +-
 t/t5616-partial-clone.sh      |  2 +-
 unpack-trees.c                |  8 ++++----
 14 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f092382e1..85ae10bf0b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,6 +15,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 
 struct batch_options {
 	int enabled;
@@ -523,8 +524,8 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->all_objects) {
 		struct object_cb_data cb;
 
-		if (repository_format_partial_clone)
-			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
+		if (has_promisor_remote())
+			warning("This repository uses promisor remotes. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ba63d5ac6..f74bd78144 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "promisor-remote.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -1460,7 +1461,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!repository_format_partial_clone && !filter_options.choice)
+	if (!has_promisor_remote() && !filter_options.choice)
 		return;
 
 	/*
@@ -1468,7 +1469,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * on this repo and remember the given filter-spec as the default
 	 * for subsequent fetches to this remote.
 	 */
-	if (!repository_format_partial_clone && filter_options.choice) {
+	if (!has_promisor_remote() && filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
@@ -1477,7 +1478,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * We are currently limited to only ONE promisor remote and only
 	 * allow partial-fetches from the promisor remote.
 	 */
-	if (strcmp(remote->name, repository_format_partial_clone)) {
+	if (!promisor_remote_find(remote->name)) {
 		if (filter_options.choice)
 			die(_("--filter can only be used with the remote "
 			      "configured in extensions.partialClone"));
@@ -1611,7 +1612,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !repository_format_partial_clone)
+	if (filter_options.choice && !has_promisor_remote())
 		die("--filter can only be used when extensions.partialClone is set");
 
 	if (all) {
@@ -1645,7 +1646,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (remote) {
-		if (filter_options.choice || repository_format_partial_clone)
+		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
diff --git a/builtin/gc.c b/builtin/gc.c
index 8943bcc300..824a8832b5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -27,6 +27,7 @@
 #include "pack-objects.h"
 #include "blob.h"
 #include "tree.h"
+#include "promisor-remote.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -661,7 +662,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
-			if (repository_format_partial_clone)
+			if (has_promisor_remote())
 				argv_array_push(&prune,
 						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0d55f73b0b..a23454da6e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -14,7 +14,7 @@
 #include "thread-utils.h"
 #include "packfile.h"
 #include "object-store.h"
-#include "fetch-object.h"
+#include "promisor-remote.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -1352,7 +1352,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		sorted_by_pos[i] = &ref_deltas[i];
 	QSORT(sorted_by_pos, nr_ref_deltas, delta_pos_compare);
 
-	if (repository_format_partial_clone) {
+	if (has_promisor_remote()) {
 		/*
 		 * Prefetch the delta bases.
 		 */
@@ -1366,8 +1366,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 			oid_array_append(&to_fetch, &d->oid);
 		}
 		if (to_fetch.nr)
-			fetch_objects(repository_format_partial_clone,
-				      to_fetch.oid, to_fetch.nr);
+			promisor_remote_get_direct(the_repository,
+						   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 
diff --git a/builtin/repack.c b/builtin/repack.c
index caca113927..df9a32c906 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -11,6 +11,7 @@
 #include "midx.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -369,7 +370,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
-	if (repository_format_partial_clone)
+	if (has_promisor_remote())
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
diff --git a/cache-tree.c b/cache-tree.c
index b13bfaf71e..64c285a746 100644
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
index 1ab481fed6..b0e4968fbd 100644
--- a/connected.c
+++ b/connected.c
@@ -5,6 +5,7 @@
 #include "connected.h"
 #include "transport.h"
 #include "packfile.h"
+#include "promisor-remote.h"
 
 /*
  * If we feed all the commits we want to verify to this command
@@ -73,7 +74,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
-	if (repository_format_partial_clone)
+	if (has_promisor_remote())
 		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		argv_array_push(&rev_list.args, "--not");
diff --git a/diff.c b/diff.c
index 1ee04e321b..249cc6eace 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,7 @@
 #include "packfile.h"
 #include "parse-options.h"
 #include "help.h"
-#include "fetch-object.h"
+#include "promisor-remote.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -6514,8 +6514,7 @@ static void add_if_missing(struct repository *r,
 
 void diffcore_std(struct diff_options *options)
 {
-	if (options->repo == the_repository &&
-	    repository_format_partial_clone) {
+	if (options->repo == the_repository && has_promisor_remote()) {
 		/*
 		 * Prefetch the diff pairs that are about to be flushed.
 		 */
@@ -6532,8 +6531,8 @@ void diffcore_std(struct diff_options *options)
 			/*
 			 * NEEDSWORK: Consider deduplicating the OIDs sent.
 			 */
-			fetch_objects(repository_format_partial_clone,
-				      to_fetch.oid, to_fetch.nr);
+			promisor_remote_get_direct(options->repo,
+						   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 1cb20c659c..b0de7d3c17 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "promisor-remote.h"
 
 /*
  * Parse value of the argument to the "filter" keyword.
@@ -146,30 +147,31 @@ void partial_clone_register(
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
+	if (!promisor_remote_find(remote)) {
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
index d786ec7312..50aaf93bc3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -16,6 +16,7 @@
 #include "tree.h"
 #include "object-store.h"
 #include "midx.h"
+#include "promisor-remote.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -2119,7 +2120,7 @@ int is_promisor_object(const struct object_id *oid)
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
-		if (repository_format_partial_clone) {
+		if (has_promisor_remote()) {
 			for_each_packed_object(add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY);
diff --git a/sha1-file.c b/sha1-file.c
index 819d32cdb8..fe250c4b6e 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -30,8 +30,8 @@
 #include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
-#include "fetch-object.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -1377,16 +1377,17 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		}
 
 		/* Check if it is a missing object */
-		if (fetch_if_missing && repository_format_partial_clone &&
+		if (fetch_if_missing && has_promisor_remote() &&
 		    !already_retried && r == the_repository &&
 		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 			/*
-			 * TODO Investigate checking fetch_object() return
-			 * TODO value and stopping on error here.
-			 * TODO Pass a repository struct through fetch_object,
-			 * such that arbitrary repositories work.
+			 * TODO Investigate checking promisor_remote_get_direct()
+			 * TODO return value and stopping on error here.
+			 * TODO Pass a repository struct through
+			 * promisor_remote_get_direct(), such that arbitrary
+			 * repositories work.
 			 */
-			fetch_objects(repository_format_partial_clone, real, 1);
+			promisor_remote_get_direct(r, real, 1);
 			already_retried = 1;
 			continue;
 		}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 37d76808d4..534d03a4d7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -654,7 +654,7 @@ partial_clone () {
 	git -C client fsck &&
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
-	test_config -C client extensions.partialclone "not a remote" &&
+	test_config -C client remote.origin.promisor "false" &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index b91ef548f8..8f9a62aac0 100755
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
index 50189909b8..aebd865ef6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,7 +16,7 @@
 #include "submodule-config.h"
 #include "fsmonitor.h"
 #include "object-store.h"
-#include "fetch-object.h"
+#include "promisor-remote.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -400,7 +400,7 @@ static int check_updates(struct unpack_trees_options *o)
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
-	if (repository_format_partial_clone && o->update && !o->dry_run) {
+	if (has_promisor_remote() && o->update && !o->dry_run) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -419,8 +419,8 @@ static int check_updates(struct unpack_trees_options *o)
 			oid_array_append(&to_fetch, &ce->oid);
 		}
 		if (to_fetch.nr)
-			fetch_objects(repository_format_partial_clone,
-				      to_fetch.oid, to_fetch.nr);
+			promisor_remote_get_direct(the_repository,
+						   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 	for (i = 0; i < index->cache_nr; i++) {
-- 
2.22.0.229.ga13d9ffdf7.dirty

