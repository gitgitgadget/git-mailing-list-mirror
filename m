Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20DDB1F458
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeIYSBZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38465 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeIYSBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id z16-v6so6887596wmi.3
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+iCXS7jPu6phr0WIDO4E4yvYclZrJsSWEcjwmPKfeE=;
        b=PPAk7WgLsRS2vTE96IIIpJ0E11iK1tZW4LDKrrS4NuWjIM97Np7w+MltUarBEnMoIk
         o4S75Ts2uT9YFGCKLBDSLXzdLMSMJxUbJKSn5UO1SJ+9cTbXl8Ah07Ej0sm468Sl+8pQ
         E+Ix4ftf8FDzbR7WqJliJsmx1/TuMQav/+Bsaam8nB7Ge/NvYDf4J7wwsbsg/3qcnh5H
         FTxzfBfYGB7posQ0MEvfhuz+GrTI0KjBho7ARG1K9sAbQVGMPzR9UMBJyPDXEnwypbDC
         jrV1rJa2OYbDSJu1nNsBMywrQ8IY3pUoPlGBKM1fVuMMSIlSQo+4mDda7WWSLytqmMOa
         7AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+iCXS7jPu6phr0WIDO4E4yvYclZrJsSWEcjwmPKfeE=;
        b=DUNnBXp6CAi7B6kx0b3PvGhFacTf40VjN33e02jWFyuJ2VhGKZL9zcHmEEhelrYRYb
         bVjVeQcyPZueLVcY35Mf+newILShedkMlac1UnML8KeYLWrjrnartA4cUySkVPqXPw9r
         WsxAACASFTIzegXGUjOge9kPrieOq+07F/MKTRJjASEPzj3K3qO4CT2EYKiJlCd1Y4fC
         anG/xAuoZFFxmxqBrRkfUm3R7oL2qexGiba1jV3BtoIYe+NpgZ8wg0bBrWz9+VIp6+kP
         C5Z1FPjaLsrIgdwrE6QXeWwdM6XEWPR7VDbxcZZlSG8gCiNwLW351dQIVjIP0qifYvFb
         2mRQ==
X-Gm-Message-State: ABuFfohLBfiwmrcADCT1oLQp496Gcg/L3B9+HnGnCpUMFM8U+S50xFQL
        P4RkjxupQp6hlDPOn1ESB35f2O8x
X-Google-Smtp-Source: ACcGV635ZcoiAyxdh4ZJzmF7rP0wdyfgks4+bJDdcXYBWQkWDx8ze92rf3VrtTgWyw4fG/1RSaGJcA==
X-Received: by 2002:a1c:55c2:: with SMTP id j185-v6mr396354wmb.104.1537876448418;
        Tue, 25 Sep 2018 04:54:08 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:54:07 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v5 5/8] Use remote_odb_get_direct() and has_remote_odb()
Date:   Tue, 25 Sep 2018 13:53:38 +0200
Message-Id: <20180925115341.19248-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
In-Reply-To: <20180925115341.19248-1-chriscool@tuxfamily.org>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the repository_format_partial_clone global
and fetch_objects() directly, let's use has_remote_odb() and
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
 list-objects-filter-options.c | 27 ++++++++++++++------------
 packfile.c                    |  3 ++-
 setup.c                       |  7 +------
 sha1-file.c                   | 14 ++++++++------
 t/t0410-partial-clone.sh      | 36 +++++++++++++++++------------------
 t/t5500-fetch-pack.sh         |  4 ++--
 t/t5601-clone.sh              |  2 +-
 t/t5616-partial-clone.sh      |  2 +-
 t/t5702-protocol-v2.sh        |  2 +-
 unpack-trees.c                |  6 +++---
 17 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 64ec1745ab..7a2986d938 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -14,6 +14,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "remote-odb.h"
 
 struct batch_options {
 	int enabled;
@@ -507,8 +508,8 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->all_objects) {
 		struct object_cb_data cb;
 
-		if (repository_format_partial_clone)
-			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
+		if (has_remote_odb())
+			warning("This repository uses an odb. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a..e01b65950c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "remote-odb.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -1372,7 +1373,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!repository_format_partial_clone && !filter_options.choice)
+	if (!has_remote_odb() && !filter_options.choice)
 		return;
 
 	/*
@@ -1380,7 +1381,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * on this repo and remember the given filter-spec as the default
 	 * for subsequent fetches to this remote.
 	 */
-	if (!repository_format_partial_clone && filter_options.choice) {
+	if (!has_remote_odb() && filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
@@ -1389,7 +1390,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * We are currently limited to only ONE promisor remote and only
 	 * allow partial-fetches from the promisor remote.
 	 */
-	if (strcmp(remote->name, repository_format_partial_clone)) {
+	if (!find_odb_helper(remote->name)) {
 		if (filter_options.choice)
 			die(_("--filter can only be used with the remote configured in core.partialClone"));
 		return;
@@ -1520,7 +1521,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !repository_format_partial_clone)
+	if (filter_options.choice && !has_remote_odb())
 		die("--filter can only be used when extensions.partialClone is set");
 
 	if (all) {
@@ -1554,7 +1555,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (remote) {
-		if (filter_options.choice || repository_format_partial_clone)
+		if (filter_options.choice || has_remote_odb())
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
diff --git a/builtin/gc.c b/builtin/gc.c
index 2b592260e9..356db8ab70 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -27,6 +27,7 @@
 #include "pack-objects.h"
 #include "blob.h"
 #include "tree.h"
+#include "remote-odb.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -623,7 +624,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
-			if (repository_format_partial_clone)
+			if (has_remote_odb())
 				argv_array_push(&prune,
 						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
diff --git a/builtin/repack.c b/builtin/repack.c
index c6a7943d5c..16f9a952a0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -11,6 +11,7 @@
 #include "midx.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "remote-odb.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -366,7 +367,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
-	if (repository_format_partial_clone)
+	if (has_remote_odb())
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
diff --git a/cache.h b/cache.h
index d508f3d4f8..195de98c2e 100644
--- a/cache.h
+++ b/cache.h
@@ -955,13 +955,11 @@ extern int grafts_replace_parents;
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
index 3f3c8746c2..87c871e5f1 100644
--- a/environment.c
+++ b/environment.c
@@ -31,7 +31,6 @@ int warn_ambiguous_refs = 1;
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
index 841b36182f..16d12c8e86 100644
--- a/packfile.c
+++ b/packfile.c
@@ -16,6 +16,7 @@
 #include "tree.h"
 #include "object-store.h"
 #include "midx.h"
+#include "remote-odb.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -2101,7 +2102,7 @@ int is_promisor_object(const struct object_id *oid)
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
index 5c44873d37..c9ed42e513 100644
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
-			fetch_objects(repository_format_partial_clone, real, 1);
+			remote_odb_get_direct(real, 1);
 			already_retried = 1;
 			continue;
 		}
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index cfd0655ea1..9ead9860f5 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -23,7 +23,7 @@ promise_and_delete () {
 	delete_object repo "$HASH"
 }
 
-test_expect_success 'extensions.partialclone without filter' '
+test_expect_success 'promisor remote without filter' '
 	test_create_repo server &&
 	git clone --filter="blob:none" "file://$(pwd)/server" client &&
 	git -C client config --unset core.partialclonefilter &&
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
@@ -192,7 +192,7 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	promise_and_delete "$FOO" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	GIT_TEST_COMMIT_GRAPH=0 git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
 	grep $(git -C repo rev-parse bar) out &&
 	! grep $FOO out
@@ -217,7 +217,7 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	promise_and_delete "$TREE2" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
 	grep $(git -C repo rev-parse foo) out &&
 	! grep $TREE out &&
@@ -236,7 +236,7 @@ test_expect_success 'rev-list stops traversal at missing and promised blob' '
 	promise_and_delete "$BLOB" &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
 	grep $(git -C repo rev-parse HEAD) out &&
 	! grep $BLOB out
@@ -255,7 +255,7 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
 	printf "%s\n%s\n%s\n" $COMMIT $TREE $BLOB | pack_as_from_promisor &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
 	! grep $COMMIT out &&
 	! grep $TREE out &&
@@ -279,7 +279,7 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 	promise_and_delete $BLOB &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
 '
 
@@ -295,7 +295,7 @@ test_expect_success 'gc repacks promisor objects separately from non-promisor ob
 	printf "$TREE_TWO\n" | pack_as_from_promisor &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo gc &&
 
 	# Ensure that exactly one promisor packfile exists, and that it
@@ -329,7 +329,7 @@ test_expect_success 'gc does not repack promisor objects if there are none' '
 	test_commit -C repo one &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo gc &&
 
 	# Ensure that only one pack exists
@@ -351,7 +351,7 @@ test_expect_success 'repack -d does not irreversibly delete promisor objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 
 	git -C repo commit --allow-empty -m one &&
 	git -C repo commit --allow-empty -m two &&
@@ -379,7 +379,7 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	HASH=$(promise_and_delete $TREE_HASH) &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
 	git -C repo gc &&
 
 	# Ensure that the promisor packfile still exists, and remove it
@@ -410,7 +410,7 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	rm -rf repo/.git/objects/* &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "origin" &&
+	git -C repo config odb.magic.promisorRemote "origin" &&
 	git -C repo cat-file -p "$HASH" &&
 
 	# Ensure that the .promisor file is written, and check that its
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1b5a4a6d38..7be1dd9a4c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -884,14 +884,14 @@ fetch_filter_blob_limit_zero () {
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
index f1a49e94f5..d0cd8b6233 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -653,7 +653,7 @@ partial_clone () {
 	git -C client fsck &&
 
 	# Ensure that unneeded blobs are not inadvertently fetched.
-	test_config -C client extensions.partialclone "not a remote" &&
+	test_config -C client odb.origin.promisorRemote "not a remote" &&
 	test_must_fail git -C client cat-file -e "$HASH1" &&
 
 	# But this blob was fetched, because clone performs an initial checkout
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bbbe7537df..9897b8db12 100755
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
index 3beeed4546..e683dd4ca1 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -290,7 +290,7 @@ test_expect_success 'partial fetch' '
 	rm -rf client "$(pwd)/trace" &&
 	git init client &&
 	SERVER="file://$(pwd)/server" &&
-	test_config -C client extensions.partialClone "$SERVER" &&
+	test_config -C client odb.magic.promisorRemote "$SERVER" &&
 
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch --filter=blob:none "$SERVER" master:refs/heads/other &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 51bfac6aa0..a5ce98a450 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "fetch-object.h"
+#include "remote-odb.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -418,7 +419,7 @@ static int check_updates(struct unpack_trees_options *o)
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
-	if (repository_format_partial_clone && o->update && !o->dry_run) {
+	if (has_remote_odb() && o->update && !o->dry_run) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -435,8 +436,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 		if (to_fetch.nr)
-			fetch_objects(repository_format_partial_clone,
-				      to_fetch.oid, to_fetch.nr);
+			remote_odb_get_direct(to_fetch.oid, to_fetch.nr);
 		fetch_if_missing = fetch_if_missing_store;
 		oid_array_clear(&to_fetch);
 	}
-- 
2.19.0.278.gca5b891cac

