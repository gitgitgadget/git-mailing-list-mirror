Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40B21F42B
	for <e@80x24.org>; Wed,  3 Jan 2018 16:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbeACQep (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:45 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36481 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeACQee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:34 -0500
Received: by mail-wr0-f178.google.com with SMTP id u19so2155124wrc.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r9hfxKZkM8s8huwy93oxYatMKYt47xpy/0esRZLTuec=;
        b=dGlVTOHy2Fq2CXoPHVLTL7DgRJIRgRTWzW//I/6CDLHo56f1GfU5H8b8xIFRzrN3rC
         1MByJRxPhHNO8LCu0Plzim8Lq66mqVYksr9A6nXGU5gipD1bkNLXSsZoPtlPQX3au3wF
         HbEI87m7/W3bbp1Ikyvd18DzGHAnP93/vYXXU2bf4pZ0FfFUiqr/8JR801QmITiEH8/d
         hstnjNjywSLX9x12RDvZf2vk2V18SPeCjR5/R7b8mf5behF5UZ2AxMJ8P6OucbChcOif
         TFyfvPWrKgqZTVklspMdDd3oUG6KuiycLVVz4o7TGoA4586gAL2tPeACURg7k8KnOs8t
         oPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r9hfxKZkM8s8huwy93oxYatMKYt47xpy/0esRZLTuec=;
        b=bbimz+80mIIFC9oY1o+5YNtgj5MuPUy6MFrc4T8pS/6WOXlDmwW2AbXa3NkkiI/wRt
         CsQQ8a/QtNI+8kX2/ydnA449uFNkRU8UJSM4eHoWc7W+XmxfTElvJygwT3T7BopUyRFe
         3v12cs8sHjOQWG8n19IqCJoH0kCtiYoyEjO56Nct3HMv7YC6Us9Zsna+wnWSSLsuMyC9
         ks54RzxrDtUAYmJ/FRoFxk1/epM3SPoYDl3e43VSV0v4qMnMWTNDt/wIsIiwl/Iyp2MU
         adxhWcgTkxpibcfBI2yUE0NfHwkPXntqaB0e2iiDOPRHiJInhYGH41fBdUZJznj2dr+h
         HfEw==
X-Gm-Message-State: AKGB3mIQyE1EW6PFczIzzOmGSJVcGCgojfCdj+KKsQO+CIfFt3c0VT6m
        6nOyO71XMoN4dwhfj1lO0BkNIPM/
X-Google-Smtp-Source: ACJfBouozPhDUgiiz3Ul6DjCzJNpWnNYNb1DsvCu2HHa8Pv9KaIt/khbA6yAkRR/AjQU3mHWDtCCuw==
X-Received: by 10.223.171.72 with SMTP id r8mr2175281wrc.46.1514997272919;
        Wed, 03 Jan 2018 08:34:32 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:32 -0800 (PST)
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
Subject: [PATCH 11/40] sha1_file: support lazily fetching missing objects
Date:   Wed,  3 Jan 2018 17:33:34 +0100
Message-Id: <20180103163403.11303-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach sha1_file to fetch objects from the remote configured in
extensions.partialclone whenever an object is requested but missing.

The fetching of objects can be suppressed through a global variable.
This is used by fsck and index-pack.

However, by default, such fetching is not suppressed. This is meant as a
temporary measure to ensure that all Git commands work in such a
situation. Future patches will update some commands to either tolerate
missing objects (without fetching them) or be more efficient in fetching
them.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file.c that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in packfile.c (because I need to check callers that know
     about the loose/packed distinction and operate on both differently,
     and ensure that they can handle the concept of objects that are
     neither loose nor packed)

(1) is handled by the modification to sha1_object_info_extended().

For (2), I looked at for_each_packed_object and others.  For
for_each_packed_object, the callers either already work or are fixed in
this patch:
 - reachable - only to find recent objects
 - builtin/fsck - already knows about missing objects
 - builtin/cat-file - warning message added in this commit

Callers of the other functions do not need to be changed:
 - parse_pack_index
   - http - indirectly from http_get_info_packs
   - find_pack_entry_one
     - this searches a single pack that is provided as an argument; the
       caller already knows (through other means) that the sought object
       is in a specific pack
 - find_sha1_pack
   - fast-import - appears to be an optimization to not store a file if
     it is already in a pack
   - http-walker - to search through a struct alt_base
   - http-push - to search through remote packs
 - has_sha1_pack
   - builtin/fsck - already knows about promisor objects
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c       |  3 +++
 builtin/fetch-pack.c     |  2 ++
 builtin/fsck.c           |  3 +++
 builtin/index-pack.c     |  6 ++++++
 cache.h                  |  8 ++++++++
 fetch-object.c           |  3 +++
 sha1_file.c              | 28 ++++++++++++++++++--------
 t/t0410-partial-clone.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75a..1e4edd81a0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -13,6 +13,7 @@
 #include "tree-walk.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "external-odb.h"
 
 struct batch_options {
 	int enabled;
@@ -475,6 +476,8 @@ static int batch_objects(struct batch_options *opt)
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
 		for_each_packed_object(batch_packed_object, &sa, 0);
+		if (has_external_odb())
+			warning("This repository uses an odb. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 02abe7211e..15eeed7b17 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -53,6 +53,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
+	fetch_if_missing = 0;
+
 	packet_trace_identity("fetch-pack");
 
 	memset(&args, 0, sizeof(args));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a6fa6d6482..7a8a679d4f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -678,6 +678,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	int i;
 	struct alternate_object_database *alt;
 
+	/* fsck knows how to handle missing promisor objects */
+	fetch_if_missing = 0;
+
 	errors_found = 0;
 	check_replace_refs = 0;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9dffaf20ae..54c921fa71 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1657,6 +1657,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
 
+	/*
+	 * index-pack never needs to fetch missing objects, since it only
+	 * accesses the repo to do hash collision checks
+	 */
+	fetch_if_missing = 0;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
diff --git a/cache.h b/cache.h
index 078607ee91..3fabf998ce 100644
--- a/cache.h
+++ b/cache.h
@@ -1789,6 +1789,14 @@ struct object_info {
 #define OBJECT_INFO_QUICK 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
+/*
+ * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
+ * blobs. This has a difference only if extensions.partialClone is set.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/fetch-object.c b/fetch-object.c
index 23ec2bb0d0..8afadeda2b 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -14,7 +14,9 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	struct remote *remote;
 	struct transport *transport;
 	struct ref *ref;
+	int original_fetch_if_missing = fetch_if_missing;
 
+	fetch_if_missing = 0;
 	remote = remote_get(remote_name);
 	if (!remote->url[0])
 		die(_("Remote with no URL"));
@@ -25,4 +27,5 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
 	transport_fetch_refs(transport, ref);
+	fetch_if_missing = original_fetch_if_missing;
 }
diff --git a/sha1_file.c b/sha1_file.c
index cba6b2a537..261baf800f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1233,6 +1233,8 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return (status < 0) ? status : 0;
 }
 
+int fetch_if_missing = 1;
+
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
@@ -1241,6 +1243,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
+	int already_retried = 0;
 
 	if (is_null_sha1(real))
 		return -1;
@@ -1268,19 +1271,29 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
+	while (1) {
+		if (find_pack_entry(real, &e))
+			break;
+
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-		if (flags & OBJECT_INFO_QUICK) {
-			return -1;
-		} else {
-			reprepare_packed_git();
-			if (!find_pack_entry(real, &e))
-				return -1;
+		reprepare_packed_git();
+		if (find_pack_entry(real, &e))
+			break;
+
+		/* Check if it is a missing object */
+		if (fetch_if_missing && has_external_odb() &&
+		    !already_retried) {
+			if (!external_odb_get_direct(real))
+				return 0;
+			already_retried = 1;
+			continue;
 		}
+
+		return -1;
 	}
 
 	if (oi == &blank_oi)
@@ -1289,7 +1302,6 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		 * information below, so return early.
 		 */
 		return 0;
-
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a0f901fa1d..8b20d18603 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -138,4 +138,55 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 	git -C repo fsck "$A"
 '
 
+test_expect_success 'fetching of missing objects' '
+	rm -rf repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetching of missing objects from an HTTP server' '
+	rm -rf repo &&
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	git -C "$SERVER" repack -a -d --write-bitmap-index &&
+
+	git clone $HTTPD_URL/smart/server repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+stop_httpd
+
 test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

