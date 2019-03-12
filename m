Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89DA20305
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCLNaZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:25 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:36857 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCLNaX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:23 -0400
Received: by mail-ed1-f44.google.com with SMTP id e4so2307874edi.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBPEpDuRPZ2/YjbyPaJ1s8okeJOTok1vnDs1HCxXPHc=;
        b=QgfxgVmftuDHuQyvXDvCg05ynkxKyuUVNoySYVX80JqYb1JA8O7rp17OXAZf+zp6wb
         emNPHNq3V/HEJwbSZtFC1fRddOrnFnB8zT3nQoWyQ0iQ9xmNDaJpBKPilR+tHGKtoTgM
         fPydZaovjeKWdXzQRmV5h5PKj/Mm5+rOQZljWdHvjOTRIWxF+TWBAkglZYVGTmJ4PVqZ
         TteLWw0afmjrK6XpQBG1VVim5EC0nvdTpfLvYV2AAdTtuMrjy3a97YkmO2mPBK86Mm3m
         SqseOFFv7hsKzRzo5/jDii/dmPOTf8EO/+pxC2oxVxMrWaP6GMG7uzSovXRjGBXn/aCX
         BLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBPEpDuRPZ2/YjbyPaJ1s8okeJOTok1vnDs1HCxXPHc=;
        b=Z6+cTw0ZqfK0Z8hm37rJIfKAI2xkNmD8tDagi4bpbbocvNmcCAypsHzIwIE76ubmK2
         JvFhRO7dkYVr06+SQJEgKTeXuftmIVmNTMqjOFlEkKzF+tLdhPa/dNaQi9VpWFzOpfjg
         LhCDJshByqtb52ofpBv2HlyGpNHhoxE+RJqJss6n9tZqycLHulyjrj3GFKHjQ4j52L0Y
         pXdSzjSGSsoXpuxOFD2i+zDJJhcAKYdBUUbDFRSrlAw+SPY8lNlI6BMBTpl3wEuTip/4
         PHkm3xNJSBIdebSoPa2nCQJUOT5ueO3MoCnvornKPY1b3UUypgCiDZHqnZpl7aRC6zwU
         MfNw==
X-Gm-Message-State: APjAAAWfwv6IL07bpteXfXbynTiWCRmJFQxACVE1H0dArbQ+CIS5J0Md
        9xPiZ3sQ/nTEBioRv/viMbKn4Wwx
X-Google-Smtp-Source: APXvYqxjUC6Ng32RpUX4xk8DVRrbwfWMyUcP8/wwr0YdcQvlhOG1EmVCx+LWhSI3Un1o4HUT0p+06w==
X-Received: by 2002:a17:906:2797:: with SMTP id j23mr9845448ejc.128.1552397420943;
        Tue, 12 Mar 2019 06:30:20 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:20 -0700 (PDT)
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
Subject: [PATCH v3 06/11] Use promisor_remote_get_direct() and has_promisor_remote()
Date:   Tue, 12 Mar 2019 14:29:54 +0100
Message-Id: <20190312132959.11764-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
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
index b620fd54b4..7edf70ae6c 100644
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
@@ -1609,7 +1610,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !repository_format_partial_clone)
+	if (filter_options.choice && !has_promisor_remote())
 		die("--filter can only be used when extensions.partialClone is set");
 
 	if (all) {
@@ -1643,7 +1644,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (remote) {
-		if (filter_options.choice || repository_format_partial_clone)
+		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc..0bec41b25f 100644
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
index 67f8978043..3b935690c8 100644
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
index c0036f7378..f41a831fce 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "promisor-remote.h"
 
 /*
  * Parse value of the argument to the "filter" keyword.
@@ -144,30 +145,31 @@ void partial_clone_register(
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
index 16bcb75262..0f95cdc1c9 100644
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
index 01cc0590f4..715a2b882a 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -32,6 +32,7 @@
 #include "packfile.h"
 #include "fetch-object.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -1369,15 +1370,16 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
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
+			 * TODO Investigate checking promisor_remote_get_direct()
+			 * TODO return value and stopping on error here.
+			 * TODO Pass a repository struct through
+			 * promisor_remote_get_direct(), such that arbitrary
+			 * repositories work.
 			 */
-			fetch_objects(repository_format_partial_clone, real, 1);
+			promisor_remote_get_direct(real, 1);
 			already_retried = 1;
 			continue;
 		}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d6948cbdab..dd658f8b32 100755
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
index 9643acb161..e8ca825ab7 100755
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
index 22c41a3ba8..47353d85c3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -17,6 +17,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "fetch-object.h"
+#include "promisor-remote.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -398,7 +399,7 @@ static int check_updates(struct unpack_trees_options *o)
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
-	if (repository_format_partial_clone && o->update && !o->dry_run) {
+	if (has_promisor_remote() && o->update && !o->dry_run) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -415,8 +416,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 		if (to_fetch.nr)
-			fetch_objects(repository_format_partial_clone,
-				      to_fetch.oid, to_fetch.nr);
+			promisor_remote_get_direct(to_fetch.oid, to_fetch.nr);
 		fetch_if_missing = fetch_if_missing_store;
 		oid_array_clear(&to_fetch);
 	}
-- 
2.21.0.166.gb5e4dbcfd3

