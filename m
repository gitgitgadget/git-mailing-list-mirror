Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11631F597
	for <e@80x24.org>; Thu,  2 Aug 2018 06:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeHBIF3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36579 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so1100426wmc.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOjvZluFSxzBh1kti9aDv3kUrjtCWmYwu189Djg+9+c=;
        b=tH5lTVpsVArUBgIVcGG01R6AlXu0B/rqSJtxe9GGbMsnvet4v58VMNw8N15np3vlG1
         XIIGDEgWDdZRJB1pOjIRorTTlNS2mSxpGGcFnjqc6tE3ZtJ03M1nk8wrAIlJUW19BS23
         Oxq+eB4DwElIuWYEqD0nXfnOOERWRYfVHlf+EyVrDv1N4i92BT1go43myJBxvfWhyM6Y
         5TjqlX37ySgg+JLFekwh+br6ge4b2kGp723gjdsim1BCjQskaAY2sht6Q18hkJZ2QMWD
         RxZrVLe3D6hRTbBDLaNM/B2lBdp2b/vmJ22WXLXmx7dy1W24F+a2EAZ9qjIwZ2gTERif
         /56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOjvZluFSxzBh1kti9aDv3kUrjtCWmYwu189Djg+9+c=;
        b=Evjnq8JDaWgP4LFXCt41VGQItTfuAUmHmCyNRn1wporyM9GEVdrGTSt1lszOPvQXJh
         kP1JLqP6PQD7Rk90Sve3XXdPlNVgelmvE33jsSYK7nEjKNiboRptjyfDli+MZn02CD1N
         s9+mZ9Cg+MvSk+ertg59O7gstjjyobKh9Z7nBppiGLcUmpAK+MpPiMw96vcGQEqIBn5R
         ugDVjnalgcaoY/S9K9UskkPJb+pFc4QOUFOgl/PAW7D9YvTsE0vwKTioJOE+OJD4j3Lc
         IdiXt5HmIHhIoPCBFQV2WTcoSysujebQdA2ax0TYpC9zHQ13UAWU6HYperyWXg+WIxRW
         6jrA==
X-Gm-Message-State: AOUpUlGNBpiEoFM+1kebFOX9eQKFjBFnHTVOkqd1byS0DXZeqkhHdBwO
        A138IwbfrhiB0tFjA0LI9e9yoxBq
X-Google-Smtp-Source: AAOMgpeTJ4ug9BM2c/gN3XJll/SxLZPlPbPJk7NifH3ShAgmV5M6ZLWhFlCaQNdurfivuqwPD1XwzQ==
X-Received: by 2002:a1c:415:: with SMTP id 21-v6mr977468wme.128.1533190554257;
        Wed, 01 Aug 2018 23:15:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:53 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 6/9] Use remote_odb_get_direct() and has_remote_odb()
Date:   Thu,  2 Aug 2018 08:15:02 +0200
Message-Id: <20180802061505.2983-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Instead of using the repository_format_partial_clone global
and fetch_object() directly, let's use has_remote_odb() and
remote_odb_get_direct().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c            |  5 +++--
 builtin/fetch.c               | 11 ++++++-----
 builtin/gc.c                  |  3 ++-
 builtin/repack.c              |  3 ++-
 cache.h                       |  2 --
 connected.c                   |  3 ++-
 environment.c                 |  1 -
 list-objects-filter-options.c | 27 +++++++++++++++------------
 packfile.c                    |  3 ++-
 setup.c                       |  7 +------
 sha1-file.c                   | 14 ++++++++------
 t/t0410-partial-clone.sh      | 34 +++++++++++++++++-----------------
 t/t5500-fetch-pack.sh         |  4 ++--
 t/t5601-clone.sh              |  2 +-
 t/t5616-partial-clone.sh      |  2 +-
 t/t5702-protocol-v2.sh        |  2 +-
 unpack-trees.c                |  6 +++---
 17 files changed, 66 insertions(+), 63 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4a44b2404f..4d19e9277e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -14,6 +14,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "remote-odb.h"
 
 struct batch_options {
 	int enabled;
@@ -478,8 +479,8 @@ static int batch_objects(struct batch_options *opt)
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
 		for_each_packed_object(batch_packed_object, &sa, 0);
-		if (repository_format_partial_clone)
-			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
+		if (has_remote_odb())
+			warning("This repository uses an odb. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac06f6a576..9c7df8356c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -22,6 +22,7 @@
 #include "utf8.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "remote-odb.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -1339,7 +1340,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!repository_format_partial_clone && !filter_options.choice)
+	if (!has_remote_odb() && !filter_options.choice)
 		return;
 
 	/*
@@ -1347,7 +1348,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * on this repo and remember the given filter-spec as the default
 	 * for subsequent fetches to this remote.
 	 */
-	if (!repository_format_partial_clone && filter_options.choice) {
+	if (!has_remote_odb() && filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
@@ -1356,7 +1357,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * We are currently limited to only ONE promisor remote and only
 	 * allow partial-fetches from the promisor remote.
 	 */
-	if (strcmp(remote->name, repository_format_partial_clone)) {
+	if (!find_odb_helper(remote->name)) {
 		if (filter_options.choice)
 			die(_("--filter can only be used with the remote configured in core.partialClone"));
 		return;
@@ -1487,7 +1488,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !repository_format_partial_clone)
+	if (filter_options.choice && !has_remote_odb())
 		die("--filter can only be used when extensions.partialClone is set");
 
 	if (all) {
@@ -1521,7 +1522,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (remote) {
-		if (filter_options.choice || repository_format_partial_clone)
+		if (filter_options.choice || has_remote_odb())
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..02c783b514 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -26,6 +26,7 @@
 #include "pack-objects.h"
 #include "blob.h"
 #include "tree.h"
+#include "remote-odb.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -619,7 +620,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
-			if (repository_format_partial_clone)
+			if (has_remote_odb())
 				argv_array_push(&prune,
 						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..72b1e2d94f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "remote-odb.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -249,7 +250,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
-	if (repository_format_partial_clone)
+	if (has_remote_odb())
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (window)
 		argv_array_pushf(&cmd.args, "--window=%s", window);
diff --git a/cache.h b/cache.h
index 8b447652a7..a0772bd099 100644
--- a/cache.h
+++ b/cache.h
@@ -904,13 +904,11 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
-extern char *repository_format_partial_clone;
 extern const char *core_partial_clone_filter_default;
 
 struct repository_format {
 	int version;
 	int precious_objects;
-	char *partial_clone; /* value of extensions.partialclone */
 	int is_bare;
 	int hash_algo;
 	char *work_tree;
diff --git a/connected.c b/connected.c
index 1bba888eff..7743b78290 100644
--- a/connected.c
+++ b/connected.c
@@ -4,6 +4,7 @@
 #include "connected.h"
 #include "transport.h"
 #include "packfile.h"
+#include "remote-odb.h"
 
 /*
  * If we feed all the commits we want to verify to this command
@@ -56,7 +57,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
-	if (repository_format_partial_clone)
+	if (has_remote_odb())
 		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		argv_array_push(&rev_list.args, "--not");
diff --git a/environment.c b/environment.c
index 013e845235..8234940046 100644
--- a/environment.c
+++ b/environment.c
@@ -30,7 +30,6 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
-char *repository_format_partial_clone;
 const char *core_partial_clone_filter_default;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0e2bd6a06..60452c8f36 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "remote-odb.h"
 
 /*
  * Parse value of the argument to the "filter" keyword.
@@ -114,30 +115,32 @@ void partial_clone_register(
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
+
+	/* Check if it is already registered */
+	if (find_odb_helper(remote))
+		return;
 
 	git_config_set("core.repositoryformatversion", "1");
-	git_config_set("extensions.partialclone", remote);
 
-	repository_format_partial_clone = xstrdup(remote);
+	/* Add odb config for the remote */
+	cfg_name = xstrfmt("odb.%s.promisorRemote", remote);
+	git_config_set(cfg_name, remote);
+	free(cfg_name);
 
 	/*
 	 * Record the initial filter-spec in the config as
 	 * the default for subsequent fetches from this remote.
+	 *
+	 * TODO: move core.partialclonefilter into odb.<name>
 	 */
 	core_partial_clone_filter_default =
 		xstrdup(filter_options->filter_spec);
 	git_config_set("core.partialclonefilter",
 		       core_partial_clone_filter_default);
+
+	/* Make sure the config info are reset */
+	remote_odb_reinit();
 }
 
 void partial_clone_get_default_filter_spec(
diff --git a/packfile.c b/packfile.c
index 7cd45aa4b2..9cbc974612 100644
--- a/packfile.c
+++ b/packfile.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
+#include "remote-odb.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -1976,7 +1977,7 @@ int is_promisor_object(const struct object_id *oid)
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
-		if (repository_format_partial_clone) {
+		if (has_remote_odb()) {
 			for_each_packed_object(add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY);
diff --git a/setup.c b/setup.c
index b24c811c1c..4eeb7fe073 100644
--- a/setup.c
+++ b/setup.c
@@ -419,11 +419,7 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
-		else if (!strcmp(ext, "partialclone")) {
-			if (!value)
-				return config_error_nonbool(var);
-			data->partial_clone = xstrdup(value);
-		} else
+		else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
 		data->is_bare = git_config_bool(var, value);
@@ -465,7 +461,6 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	repository_format_partial_clone = candidate->partial_clone;
 	string_list_clear(&candidate->unknown_extensions, 0);
 	if (!has_common) {
 		if (candidate->is_bare != -1) {
diff --git a/sha1-file.c b/sha1-file.c
index c099f5584d..5e183d2cd4 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -32,6 +32,7 @@
 #include "packfile.h"
 #include "fetch-object.h"
 #include "object-store.h"
+#include "remote-odb.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -1309,15 +1310,16 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		}
 
 		/* Check if it is a missing object */
-		if (fetch_if_missing && repository_format_partial_clone &&
+		if (fetch_if_missing && has_remote_odb() &&
 		    !already_retried && r == the_repository) {
 			/*
-			 * TODO Investigate checking fetch_object() return
-			 * TODO value and stopping on error here.
-			 * TODO Pass a repository struct through fetch_object,
-			 * such that arbitrary repositories work.
+			 * TODO Investigate checking remote_odb_get_direct()
+			 * TODO return value and stopping on error here.
+			 * TODO Pass a repository struct through
+			 * remote_odb_get_direct(), such that arbitrary
+			 * repositories work.
 			 */
-			fetch_object(repository_format_partial_clone, real->hash);
+			remote_odb_get_direct(real->hash);
 			already_retried = 1;
 			continue;
 		}
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4984ca583d..71a9b9a3e8 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -23,10 +23,10 @@ promise_and_delete () {
 	delete_object repo "$HASH"
 }
 
-test_expect_success 'extensions.partialclone without filter' '
+test_expect_success 'promisor remote without filter' '
 	test_create_repo server &&
 	git clone --filter="blob:none" "file://$(pwd)/server" client &&
-	git -C client config --unset core.partialclonefilter &&
+	git -C client config --unset odb.origin.partialclonefilter &&
 	git -C client fetch origin
 '
 
@@ -51,7 +51,7 @@ test_expect_success 'missing reflog object, but promised by a commit, passes fsc
 
 	# But with the extension, it succeeds
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo fsck
 '
 
@@ -74,7 +74,7 @@ test_expect_success 'missing reflog object, but promised by a tag, passes fsck'
 	printf "$T\n" | pack_as_from_promisor &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo fsck
 '
 
@@ -92,7 +92,7 @@ test_expect_success 'missing reflog object alone fails fsck, even with extension
 	delete_object repo "$A" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	test_must_fail git -C repo fsck
 '
 
@@ -108,7 +108,7 @@ test_expect_success 'missing ref object, but promised, passes fsck' '
 	promise_and_delete "$A" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo fsck
 '
 
@@ -131,7 +131,7 @@ test_expect_success 'missing object, but promised, passes fsck' '
 	promise_and_delete "$AT" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo fsck
 '
 
@@ -144,7 +144,7 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 	promise_and_delete "$A" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo fsck "$A"
 '
 
@@ -159,7 +159,7 @@ test_expect_success 'fetching of missing objects' '
 	rm -rf repo/.git/objects/* &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "origin" &&
+	git -C repo config odb.magic.promisorRemote "origin" &&
 	git -C repo cat-file -p "$HASH" &&
 
 	# Ensure that the .promisor file is written, and check that its
@@ -180,7 +180,7 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	promise_and_delete "$FOO" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
 	grep $(git -C repo rev-parse bar) out &&
 	! grep $FOO out
@@ -205,7 +205,7 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	promise_and_delete "$TREE2" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
 	grep $(git -C repo rev-parse foo) out &&
 	! grep $TREE out &&
@@ -224,7 +224,7 @@ test_expect_success 'rev-list stops traversal at missing and promised blob' '
 	promise_and_delete "$BLOB" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
 	grep $(git -C repo rev-parse HEAD) out &&
 	! grep $BLOB out
@@ -243,7 +243,7 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
 	printf "%s\n%s\n%s\n" $COMMIT $TREE $BLOB | pack_as_from_promisor &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
 	! grep $COMMIT out &&
 	! grep $TREE out &&
@@ -267,7 +267,7 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 	promise_and_delete $BLOB &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
 '
 
@@ -280,7 +280,7 @@ test_expect_success 'gc does not repack promisor objects' '
 	HASH=$(printf "$TREE_HASH\n" | pack_as_from_promisor) &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo gc &&
 
 	# Ensure that the promisor packfile still exists, and remove it
@@ -304,7 +304,7 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	HASH=$(promise_and_delete $TREE_HASH) &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo gc &&
 
 	# Ensure that the promisor packfile still exists, and remove it
@@ -335,7 +335,7 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	rm -rf repo/.git/objects/* &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "origin" &&
+	git -C repo config odb.magic.promisorRemote "origin" &&
 	git -C repo cat-file -p "$HASH" &&
 
 	# Ensure that the .promisor file is written, and check that its
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3d33ab3875..8605b9b3b5 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -851,14 +851,14 @@ fetch_filter_blob_limit_zero () {
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
 
 	git clone "$URL" client &&
-	test_config -C client extensions.partialclone origin &&
+	test_config -C client odb.magic.promisorRemote origin &&
 
 	test_commit -C "$SERVER" two &&
 
 	git -C client fetch --filter=blob:limit=0 origin HEAD:somewhere &&
 
 	# Ensure that commit is fetched, but blob is not
-	test_config -C client extensions.partialclone "arbitrary string" &&
+	test_config -C client odb.magic.promisorRemote "arbitrary string" &&
 	git -C client cat-file -e $(git -C "$SERVER" rev-parse two) &&
 	test_must_fail git -C client cat-file -e $(git hash-object "$SERVER/two.t")
 }
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0b62037744..022c65a7ae 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -647,7 +647,7 @@ partial_clone () {
 	git -C client fsck &&
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
-	test_config -C client extensions.partialclone "not a remote" &&
+	test_config -C client odb.origin.promisorRemote "not a remote" &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 44d8e80171..f7ed3c40e2 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -40,7 +40,7 @@ test_expect_success 'do partial clone 1' '
 		| sort >observed.oids &&
 	test_cmp expect_1.oids observed.oids &&
 	test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
-	test "$(git -C pc1 config --local extensions.partialclone)" = "origin" &&
+	test "$(git -C pc1 config --local odb.origin.promisorRemote)" = "origin" &&
 	test "$(git -C pc1 config --local core.partialclonefilter)" = "blob:none"
 '
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index a4fe6508bd..0c47599568 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -285,7 +285,7 @@ test_expect_success 'partial fetch' '
 	rm -rf client "$(pwd)/trace" &&
 	git init client &&
 	SERVER="file://$(pwd)/server" &&
-	test_config -C client extensions.partialClone "$SERVER" &&
+	test_config -C client odb.magic.promisorRemote "$SERVER" &&
 
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch --filter=blob:none "$SERVER" master:refs/heads/other &&
diff --git a/unpack-trees.c b/unpack-trees.c
index cd0680f11e..13da008198 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "fetch-object.h"
+#include "remote-odb.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -383,7 +384,7 @@ static int check_updates(struct unpack_trees_options *o)
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
-	if (repository_format_partial_clone && o->update && !o->dry_run) {
+	if (has_remote_odb() && o->update && !o->dry_run) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -400,8 +401,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 		if (to_fetch.nr)
-			fetch_objects(repository_format_partial_clone,
-				      &to_fetch);
+			remote_odb_get_many_direct(&to_fetch);
 		fetch_if_missing = fetch_if_missing_store;
 		oid_array_clear(&to_fetch);
 	}
-- 
2.18.0.330.g17eb9fed90

