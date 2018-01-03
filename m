Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62571F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeACQem (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41566 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeACQei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:38 -0500
Received: by mail-wr0-f194.google.com with SMTP id p69so2141381wrb.8
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wP3U1xM93sY/U+aBkYgb2muCBEKDN5f7mcuvwEvYA50=;
        b=Af1YJMXfvchi13kWUyV/pvz0stsVJHvapipHAjCfBO2y8hdB5p8P2Z6XZep/GSIWVT
         G3v2YIQriJHLQ/AmvMC2TW9NlBV16bAQSD+N6cn2l5w+m1c70Ssoogcq4AYPVQzp+61D
         KUDaZoSGTq/qHzMLf1ArjMb4J2x90XsQIFWkwa03/TJUHHHJs3nZGdlKeoFaNiPZ0nC0
         tQxgD+XxRGVpKhaVbK4nhCoz7Ci/hguJkphwO0rqEIUruQr2QpGQI4EFLJfPTZF31Gt3
         NeQM0BiWAgc+ViFkGS5YX8m8xCVbuZIGBuoyO/gqTzWPpK4ibf+bY8nk0DDXvnHzlQib
         FIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wP3U1xM93sY/U+aBkYgb2muCBEKDN5f7mcuvwEvYA50=;
        b=cRCrvFoLN+42zzecu3oCTyY1xI06YSdyTixnESzkCSAkaZCNIJZbGHga4ba4i2vyde
         9rRm5T4znN1ytPAnt38Q+5O3oSnROPADVsHZfoBhovO8guBP3wsgrS72L0Pq9WdwsY9X
         DCGT0k7d190idTEVY6MsY/cFqmzaLpCfXckg13yoYaDH6oiiZh8FgyedzLWedayn7VOC
         /8bI/BVmnleUCLBMOvGTqGADTisavll3F74anFxwJvS1cYCg3XLf6It1noXrD6k2u6XW
         oEWoFNwfx/0l+DJQdGSqgWTWh95ubTDEBEl55vRjVk3HA+tTejRmnSYdG21d+DrkDwIO
         IhnA==
X-Gm-Message-State: AKGB3mLM6XCgaIMMwFQOj9Y5KXKabRQUHgJwUIM7yZj8bxEwW/9vPtkS
        e1di+WirmGwzZA2Ikgbs7W26jxNF
X-Google-Smtp-Source: ACJfBotI4uYSxRMe2jF+FEaL/DUrTiVWtyuW2cbjoPjbRkviw+TQiZB8iHhu83MyV5YpKIkc9+tUYA==
X-Received: by 10.223.152.129 with SMTP id w1mr2232108wrb.20.1514997276353;
        Wed, 03 Jan 2018 08:34:36 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:35 -0800 (PST)
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
Subject: [PATCH 13/40] gc: do not repack promisor packfiles
Date:   Wed,  3 Jan 2018 17:33:36 +0100
Message-Id: <20180103163403.11303-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach gc to stop traversal at promisor objects, and to leave promisor
packfiles alone. This has the effect of only repacking non-promisor
packfiles, and preserves the distinction between promisor packfiles and
non-promisor packfiles.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-pack-objects.txt | 11 ++++++++
 builtin/gc.c                       |  4 +++
 builtin/pack-objects.c             | 37 ++++++++++++++++++++++++--
 builtin/prune.c                    |  7 +++++
 builtin/repack.c                   |  9 +++++--
 t/t0410-partial-clone.sh           | 54 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index aa403d02f3..81bc490ac5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -255,6 +255,17 @@ a missing object is encountered.  This is the default action.
 The form '--missing=allow-any' will allow object traversal to continue
 if a missing object is encountered.  Missing objects will silently be
 omitted from the results.
++
+The form '--missing=allow-promisor' is like 'allow-any', but will only
+allow object traversal to continue for EXPECTED promisor missing objects.
+Unexpected missing object will raise an error.
+
+--exclude-promisor-objects::
+	Omit objects that are known to be in the promisor remote.  (This
+	option has the purpose of operating only on locally created objects,
+	so that when we repack, we still maintain a distinction between
+	locally created objects [without .promisor] and objects from the
+	promisor remote [with .promisor].)  This is used with partial clone.
 
 SEE ALSO
 --------
diff --git a/builtin/gc.c b/builtin/gc.c
index 3c5eae0edf..cef1461d1a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,7 @@
 #include "argv-array.h"
 #include "commit.h"
 #include "packfile.h"
+#include "external-odb.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -458,6 +459,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
+			if (has_external_odb())
+				argv_array_push(&prune,
+						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
 				return error(FAILED_RUN, prune.argv[0]);
 		}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b9cfc289d..6c71552cdf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -75,6 +75,8 @@ static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
+static int exclude_promisor_objects;
+
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
 static unsigned long cache_max_small_delta_size = 1000;
@@ -84,8 +86,9 @@ static unsigned long window_memory_limit = 0;
 static struct list_objects_filter_options filter_options;
 
 enum missing_action {
-	MA_ERROR = 0,    /* fail if any missing objects are encountered */
-	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
+	MA_ERROR = 0,      /* fail if any missing objects are encountered */
+	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
+	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
 };
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
@@ -2578,6 +2581,20 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
 	show_object(obj, name, data);
 }
 
+static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *data)
+{
+	assert(arg_missing_action == MA_ALLOW_PROMISOR);
+
+	/*
+	 * Quietly ignore EXPECTED missing objects.  This avoids problems with
+	 * staging them now and getting an odd error later.
+	 */
+	if (!has_object_file(&obj->oid) && is_promisor_object(&obj->oid))
+		return;
+
+	show_object(obj, name, data);
+}
+
 static int option_parse_missing_action(const struct option *opt,
 				       const char *arg, int unset)
 {
@@ -2592,10 +2609,18 @@ static int option_parse_missing_action(const struct option *opt,
 
 	if (!strcmp(arg, "allow-any")) {
 		arg_missing_action = MA_ALLOW_ANY;
+		fetch_if_missing = 0;
 		fn_show_object = show_object__ma_allow_any;
 		return 0;
 	}
 
+	if (!strcmp(arg, "allow-promisor")) {
+		arg_missing_action = MA_ALLOW_PROMISOR;
+		fetch_if_missing = 0;
+		fn_show_object = show_object__ma_allow_promisor;
+		return 0;
+	}
+
 	die(_("invalid value for --missing"));
 	return 0;
 }
@@ -3009,6 +3034,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action },
+		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
+			 N_("do not pack objects in promisor packfiles")),
 		OPT_END(),
 	};
 
@@ -3054,6 +3081,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		argv_array_push(&rp, "--unpacked");
 	}
 
+	if (exclude_promisor_objects) {
+		use_internal_rev_list = 1;
+		fetch_if_missing = 0;
+		argv_array_push(&rp, "--exclude-promisor-objects");
+	}
+
 	if (!reuse_object)
 		reuse_delta = 0;
 	if (pack_compression_level == -1)
diff --git a/builtin/prune.c b/builtin/prune.c
index d2fdae680a..4cfec82f40 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -101,12 +101,15 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct progress *progress = NULL;
+	int exclude_promisor_objects = 0;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("expire objects older than <time>")),
+		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
+			 N_("limit traversal to objects outside promisor packfiles")),
 		OPT_END()
 	};
 	char *s;
@@ -139,6 +142,10 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		show_progress = isatty(2);
 	if (show_progress)
 		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	if (exclude_promisor_objects) {
+		fetch_if_missing = 0;
+		revs.exclude_promisor_objects = 1;
+	}
 
 	mark_reachable_objects(&revs, 1, expire, progress);
 	stop_progress(&progress);
diff --git a/builtin/repack.c b/builtin/repack.c
index f17a68a17d..a6d9cfb92c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "external-odb.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -83,7 +84,8 @@ static void remove_pack_on_signal(int signo)
 
 /*
  * Adds all packs hex strings to the fname list, which do not
- * have a corresponding .keep file.
+ * have a corresponding .keep or .promisor file. These packs are not to
+ * be kept if we are going to pack everything into one file.
  */
 static void get_non_kept_pack_filenames(struct string_list *fname_list)
 {
@@ -101,7 +103,8 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 
 		fname = xmemdupz(e->d_name, len);
 
-		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)) &&
+		    !file_exists(mkpath("%s/%s.promisor", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
 		else
 			free(fname);
@@ -232,6 +235,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
+	if (has_external_odb())
+		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (window)
 		argv_array_pushf(&cmd.args, "--window=%s", window);
 	if (window_memory)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4dc02459a5..6af4712da8 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -10,14 +10,16 @@ delete_object () {
 
 pack_as_from_promisor () {
 	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
-	>repo/.git/objects/pack/pack-$HASH.promisor
+	>repo/.git/objects/pack/pack-$HASH.promisor &&
+	echo $HASH
 }
 
 promise_and_delete () {
 	HASH=$(git -C repo rev-parse "$1") &&
 	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
 	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
-	git -C repo tag -d my_annotated_tag &&
+	# tag -d prints a message to stdout, so redirect it
+	git -C repo tag -d my_annotated_tag >/dev/null &&
 	delete_object repo "$HASH"
 }
 
@@ -261,6 +263,54 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
 '
 
+test_expect_success 'gc does not repack promisor objects' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
+	HASH=$(printf "$TREE_HASH\n" | pack_as_from_promisor) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo gc &&
+
+	# Ensure that the promisor packfile still exists, and remove it
+	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	rm repo/.git/objects/pack/pack-$HASH.* &&
+
+	# Ensure that the single other pack contains the commit, but not the tree
+	ls repo/.git/objects/pack/pack-*.pack >packlist &&
+	test_line_count = 1 packlist &&
+	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
+	grep "$(git -C repo rev-parse HEAD)" out &&
+	! grep "$TREE_HASH" out
+'
+
+test_expect_success 'gc stops traversal when a missing but promised object is reached' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
+	HASH=$(promise_and_delete $TREE_HASH) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo gc &&
+
+	# Ensure that the promisor packfile still exists, and remove it
+	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	rm repo/.git/objects/pack/pack-$HASH.* &&
+
+	# Ensure that the single other pack contains the commit, but not the tree
+	ls repo/.git/objects/pack/pack-*.pack >packlist &&
+	test_line_count = 1 packlist &&
+	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
+	grep "$(git -C repo rev-parse HEAD)" out &&
+	! grep "$TREE_HASH" out
+'
+
 LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

