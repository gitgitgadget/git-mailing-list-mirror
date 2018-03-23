Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930181F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeCWRVs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:21:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39440 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCWRVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:43 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so19385280lfd.6
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMkyrMEyZ4bqB1PUtN5CK76VIfv70ZrgwK2NFBUIxQo=;
        b=uQIZs6jROp9B05abwChQ/XlnM0UopJ3+LJi6GllxGDCRbXEDbuq2QYtE3lFlPuFIrX
         R8pLWoMV+ZDDfJjtXrhn82EQMED9e0/9oGPJPacDF5AdR2yrgFCMt9xtUxwpje8R30EW
         OEjtOIQ6qp1IWa6TttIXaSmN3ofjZMxmK99QQyubOUr6cBxe8U4kz0r3wHT3XSTynOsm
         XrGAIiD8KRTXvimjV8e/VhZctbIbNYtRGLB8HTxVxZ7c+vafniMj51uyx4z6ufu1PfUe
         2BkBBbSlv5JL4F6YmSthPNs+JHjDsSneznu6syv5AWA9wJuuMUNCjLubnTqKJti8X+Cs
         SLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMkyrMEyZ4bqB1PUtN5CK76VIfv70ZrgwK2NFBUIxQo=;
        b=aOqB12QL6vpT5AVznuXvS8OpEvwlBPZXG3ChtLeMzGypelu2f5+VFCHEoFITlqQnHK
         XX2r/7lXXq4KY4AN6m+72gTTA/bMuUlroOWhvKq7AXRWP0h0dCX9ltNGmy9VPj7lhOVR
         pWhQYgKH6QtjCgAEhUR82JDSGl1PnAptoNyV76FIjsjXqiupGgZUD2cNblwLAHp0xxP9
         i1KtrFxDkDpG/bb0HWnOougrKpdNY56xHw1IRNdMkG38As3DwnUNgoFKinxcw0HDJaYl
         VPi42BVHDT3Wpn9jePg9etnbZHgqt14uPrU4J9X5v8kchcnO4Iix46ZBzNqpIY/DSx9q
         yIYA==
X-Gm-Message-State: AElRT7EfEY8GsRo8v5ouzTk+sHsUNElEe8dPjmMaASXWqn332/aJ8dtY
        UE210wtZKgYqNXqOQLuGtjQ=
X-Google-Smtp-Source: AG47ELtHUWkCocXlQnXAw684bZA3g8294X/Z3661G33g7bNPhDs43gxqRk44UBYEnYWLhlW7Fb1B0w==
X-Received: by 10.46.23.202 with SMTP id 71mr19958318ljx.49.1521825700534;
        Fri, 23 Mar 2018 10:21:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/27] sb/object-store updates
Date:   Fri, 23 Mar 2018 18:20:54 +0100
Message-Id: <20180323172121.17725-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I have addressed all comments I've received so far. What I
decided not to do, I have responded individually. One comment I did
not respond nor do is the approximate thing, which could be done
later.

Interdiff is big due to the "objects." to "objects->" conversion
(blame Brandon for his suggestion, don't blame me :D)

diff --git a/builtin/am.c b/builtin/am.c
index 4762a702e3..47beddbe24 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1859,7 +1859,7 @@ static void am_run(struct am_state *state, int resume)
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		close_all_packs(&the_repository->objects);
+		close_all_packs(the_repository->objects);
 		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	}
 }
diff --git a/builtin/clone.c b/builtin/clone.c
index 13cfaa6488..7df5932b85 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -27,6 +27,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "object-store.h"
 
 /*
  * Overall FIXMEs:
@@ -1217,7 +1218,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_disconnect(transport);
 
 	if (option_dissociate) {
-		close_all_packs(&the_repository->objects);
+		close_all_packs(the_repository->objects);
 		dissociate_from_references();
 	}
 
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 5c7c3c6ae3..b28ff00be2 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4d72efca78..a39e9d7b15 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1478,7 +1478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
-	close_all_packs(&the_repository->objects);
+	close_all_packs(the_repository->objects);
 
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b0abba6e04..3ef25fab97 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -17,6 +17,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -714,11 +715,13 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
 	} else {
+		struct alternate_object_database *alt_odb_list;
+
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb(the_repository);
-		for (alt = the_repository->objects.alt_odb_list;
-		     alt; alt = alt->next)
+		alt_odb_list = the_repository->objects->alt_odb_list;
+		for (alt = alt_odb_list; alt; alt = alt->next)
 			fsck_object_dir(alt->path);
 
 		if (check_full) {
diff --git a/builtin/gc.c b/builtin/gc.c
index dd30067ac1..b00238cd5d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -21,6 +21,7 @@
 #include "argv-array.h"
 #include "commit.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 0f0c195705..1e9cdbdf78 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -22,6 +22,7 @@
 #include "pathspec.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "object-store.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -432,7 +433,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * object.
 	 */
 	grep_read_lock();
-	add_to_alternates_memory(submodule.objects.objectdir);
+	add_to_alternates_memory(submodule.objects->objectdir);
 	grep_read_unlock();
 
 	if (oid) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5ebd370c56..1d6bc87b76 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -13,6 +13,7 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
diff --git a/builtin/merge.c b/builtin/merge.c
index 907ae44ab5..96d56cbdd2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -411,7 +411,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			close_all_packs(&the_repository->objects);
+			close_all_packs(the_repository->objects);
 			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 		}
 	}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e5fde1d6b..223f2d9fc0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -29,6 +29,7 @@
 #include "argv-array.h"
 #include "list.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index d6d8a44959..b5b007e706 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "repository.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define BLKSIZE 512
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ac478b7b99..1a298a6711 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2026,7 +2026,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			proc.git_cmd = 1;
 			proc.argv = argv_gc_auto;
 
-			close_all_packs(&the_repository->objects);
+			close_all_packs(the_repository->objects);
 			if (!start_command(&proc)) {
 				if (use_sideband)
 					copy_to_sideband(proc.err, -1, NULL);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b1daca995f..6d8e002be7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -16,6 +16,7 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "diff.h"
+#include "object-store.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
diff --git a/environment.c b/environment.c
index c05705e384..93c9fbb0ba 100644
--- a/environment.c
+++ b/environment.c
@@ -271,9 +271,9 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!the_repository->objects.objectdir)
+	if (!the_repository->objects->objectdir)
 		BUG("git environment hasn't been setup");
-	return the_repository->objects.objectdir;
+	return the_repository->objects->objectdir;
 }
 
 int odb_mkstemp(struct strbuf *template, const char *pattern)
diff --git a/fast-import.c b/fast-import.c
index 0dba555478..b3492fce5c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -169,6 +169,7 @@ Format of STDIN stream:
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/http-backend.c b/http-backend.c
index 22921d169a..64dde78c1b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -11,6 +11,7 @@
 #include "url.h"
 #include "argv-array.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
diff --git a/http-push.c b/http-push.c
index 0913f8ab86..97fe22a705 100644
--- a/http-push.c
+++ b/http-push.c
@@ -12,6 +12,7 @@
 #include "sigchain.h"
 #include "argv-array.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
diff --git a/http-walker.c b/http-walker.c
index 2c33969123..75d55d42a9 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -6,6 +6,7 @@
 #include "list.h"
 #include "transport.h"
 #include "packfile.h"
+#include "object-store.h"
 
 struct alt_base {
 	char *base;
diff --git a/http.c b/http.c
index df9dbea59c..4d613d5f6b 100644
--- a/http.c
+++ b/http.c
@@ -14,6 +14,7 @@
 #include "packfile.h"
 #include "protocol.h"
 #include "string-list.h"
+#include "object-store.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
diff --git a/object-store.h b/object-store.h
index 521f5a1755..fef33f345f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -90,13 +90,19 @@ struct raw_object_store {
 	/* Path to extra alternate object database if not NULL */
 	char *alternate_db;
 
-	struct packed_git *packed_git; /* private */
-	/* A most-recently-used ordered version of the packed_git list. */
-	struct list_head packed_git_mru; /* private */
-
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c
+	 */
+
+	struct packed_git *packed_git;
+	/* A most-recently-used ordered version of the packed_git list. */
+	struct list_head packed_git_mru;
+
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
@@ -112,7 +118,7 @@ struct raw_object_store {
 	unsigned packed_git_initialized : 1;
 };
 
-void raw_object_store_init(struct raw_object_store *o);
+struct raw_object_store *raw_object_store_new(void);
 void raw_object_store_clear(struct raw_object_store *o);
 
 /*
diff --git a/object.c b/object.c
index 60ca76b285..4c2cf7ff5d 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "object-store.h"
 #include "packfile.h"
 
 static struct object **obj_hash;
@@ -447,23 +448,30 @@ void clear_commit_marks_all(unsigned int flags)
 	}
 }
 
-void raw_object_store_init(struct raw_object_store *o)
+struct raw_object_store *raw_object_store_new(void)
 {
+	struct raw_object_store *o = xmalloc(sizeof(*o));
+
 	memset(o, 0, sizeof(*o));
 	INIT_LIST_HEAD(&o->packed_git_mru);
+	return o;
 }
 
 static void free_alt_odb(struct alternate_object_database *alt)
 {
 	strbuf_release(&alt->scratch);
 	oid_array_clear(&alt->loose_objects_cache);
+	free(alt);
 }
 
 static void free_alt_odbs(struct raw_object_store *o)
 {
 	while (o->alt_odb_list) {
+		struct alternate_object_database *next;
+
+		next = o->alt_odb_list->next;
 		free_alt_odb(o->alt_odb_list);
-		o->alt_odb_list = o->alt_odb_list->next;
+		o->alt_odb_list = next;
 	}
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index abed43cdb5..22cd425788 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -11,6 +11,7 @@
 #include "pack-objects.h"
 #include "packfile.h"
 #include "repository.h"
+#include "object-store.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
diff --git a/pack-check.c b/pack-check.c
index 073c1fbd46..2378f25999 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -3,6 +3,7 @@
 #include "pack-revindex.h"
 #include "progress.h"
 #include "packfile.h"
+#include "object-store.h"
 
 struct idx_entry {
 	off_t                offset;
diff --git a/pack-revindex.c b/pack-revindex.c
index ff5f62c033..bb521cf7fb 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pack-revindex.h"
+#include "object-store.h"
 
 /*
  * Pack index for existing packs give us easy access to the offsets into
diff --git a/packfile.c b/packfile.c
index a0842521e5..17170fc662 100644
--- a/packfile.c
+++ b/packfile.c
@@ -14,6 +14,7 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "tree.h"
+#include "object-store.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -244,7 +245,7 @@ static int unuse_one_window(struct packed_git *current)
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = the_repository->objects.packed_git; p; p = p->next)
+	for (p = the_repository->objects->packed_git; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -382,7 +383,7 @@ static int close_one_pack(void)
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = the_repository->objects->packed_git; p; p = p->next) {
 		if (p->pack_fd == -1)
 			continue;
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
@@ -684,8 +685,8 @@ void install_packed_git(struct packed_git *pack)
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = the_repository->objects.packed_git;
-	the_repository->objects.packed_git = pack;
+	pack->next = the_repository->objects->packed_git;
+	the_repository->objects->packed_git = pack;
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -767,7 +768,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
-			for (p = the_repository->objects.packed_git; p;
+			for (p = the_repository->objects->packed_git; p;
 			     p = p->next) {
 				size_t len;
 				if (strip_suffix(p->pack_name, ".pack", &len) &&
@@ -811,20 +812,20 @@ static void prepare_packed_git_one(char *objdir, int local)
  */
 unsigned long approximate_object_count(void)
 {
-	if (!the_repository->objects.approximate_object_count_valid) {
+	if (!the_repository->objects->approximate_object_count_valid) {
 		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
 		count = 0;
-		for (p = the_repository->objects.packed_git; p; p = p->next) {
+		for (p = the_repository->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
 		}
-		the_repository->objects.approximate_object_count = count;
+		the_repository->objects->approximate_object_count = count;
 	}
-	return the_repository->objects.approximate_object_count;
+	return the_repository->objects->approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -867,8 +868,8 @@ static int sort_pack(const void *a_, const void *b_)
 
 static void rearrange_packed_git(void)
 {
-	the_repository->objects.packed_git = llist_mergesort(
-		the_repository->objects.packed_git, get_next_packed_git,
+	the_repository->objects->packed_git = llist_mergesort(
+		the_repository->objects->packed_git, get_next_packed_git,
 		set_next_packed_git, sort_pack);
 }
 
@@ -876,42 +877,42 @@ static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&the_repository->objects.packed_git_mru);
+	INIT_LIST_HEAD(&the_repository->objects->packed_git_mru);
 
-	for (p = the_repository->objects.packed_git; p; p = p->next)
-		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
+	for (p = the_repository->objects->packed_git; p; p = p->next)
+		list_add_tail(&p->mru, &the_repository->objects->packed_git_mru);
 }
 
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
 
-	if (the_repository->objects.packed_git_initialized)
+	if (the_repository->objects->packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
+	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
-	the_repository->objects.packed_git_initialized = 1;
+	the_repository->objects->packed_git_initialized = 1;
 }
 
 void reprepare_packed_git(void)
 {
-	the_repository->objects.approximate_object_count_valid = 0;
-	the_repository->objects.packed_git_initialized = 0;
+	the_repository->objects->approximate_object_count_valid = 0;
+	the_repository->objects->packed_git_initialized = 0;
 	prepare_packed_git();
 }
 
 struct packed_git *get_packed_git(struct repository *r)
 {
-	return r->objects.packed_git;
+	return r->objects->packed_git;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
-	return &r->objects.packed_git_mru;
+	return &r->objects->packed_git_mru;
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -1022,7 +1023,7 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 	struct packed_git *p;
 	unsigned i;
 
-	for (p = the_repository->objects.packed_git; p; p = p->next)
+	for (p = the_repository->objects->packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
 			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
 				return p;
@@ -1853,14 +1854,14 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	struct list_head *pos;
 
 	prepare_packed_git();
-	if (!the_repository->objects.packed_git)
+	if (!the_repository->objects->packed_git)
 		return 0;
 
-	list_for_each(pos, &the_repository->objects.packed_git_mru) {
+	list_for_each(pos, &the_repository->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (fill_pack_entry(sha1, e, p)) {
 			list_move(&p->mru,
-				  &the_repository->objects.packed_git_mru);
+				  &the_repository->objects->packed_git_mru);
 			return 1;
 		}
 	}
@@ -1907,7 +1908,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	int pack_errors = 0;
 
 	prepare_packed_git();
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = the_repository->objects->packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
@@ -1938,7 +1939,7 @@ static int add_promisor_object(const struct object_id *oid,
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
-	 * to are also promisor objects. (Blobs refer to no objects.)
+	 * to are also promisor objects-> (Blobs refer to no objects->)
 	 */
 	if (obj->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)obj;
diff --git a/path.c b/path.c
index 81a42d9115..3308b7b958 100644
--- a/path.c
+++ b/path.c
@@ -10,6 +10,7 @@
 #include "submodule-config.h"
 #include "path.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -382,7 +383,7 @@ static void adjust_git_path(const struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objects.objectdir);
+		replace_dir(buf, git_dir_len + 7, repo->objects->objectdir);
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
 	else if (repo->different_commondir)
diff --git a/reachable.c b/reachable.c
index 88d7d679da..25cfd99d1c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -11,6 +11,7 @@
 #include "list-objects.h"
 #include "packfile.h"
 #include "worktree.h"
+#include "object-store.h"
 
 struct connectivity_progress {
 	struct progress *progress;
diff --git a/repository.c b/repository.c
index 34c0a7f180..a4848c1bd0 100644
--- a/repository.c
+++ b/repository.c
@@ -13,7 +13,7 @@ void initialize_the_repository(void)
 	the_repository = &the_repo;
 
 	the_repo.index = &the_index;
-	raw_object_store_init(&the_repo.objects);
+	the_repo.objects = raw_object_store_new();
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
@@ -60,10 +60,10 @@ void repo_set_gitdir(struct repository *repo,
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
-	expand_base_dir(&repo->objects.objectdir, o->object_dir,
+	expand_base_dir(&repo->objects->objectdir, o->object_dir,
 			repo->commondir, "objects");
-	free(repo->objects.alternate_db);
-	repo->objects.alternate_db = xstrdup_or_null(o->alternate_db);
+	free(repo->objects->alternate_db);
+	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,
@@ -142,7 +142,7 @@ static int repo_init(struct repository *repo,
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
-	raw_object_store_init(&repo->objects);
+	repo->objects = raw_object_store_new();
 
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
@@ -223,7 +223,8 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
-	raw_object_store_clear(&repo->objects);
+	raw_object_store_clear(repo->objects);
+	FREE_AND_NULL(repo->objects);
 
 	if (repo->config) {
 		git_configset_clear(repo->config);
diff --git a/repository.h b/repository.h
index 6c383c05c6..abba2c09bc 100644
--- a/repository.h
+++ b/repository.h
@@ -1,12 +1,11 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
-#include "object-store.h"
-
 struct config_set;
+struct git_hash_algo;
 struct index_state;
+struct raw_object_store;
 struct submodule_cache;
-struct git_hash_algo;
 
 struct repository {
 	/* Environment */
@@ -25,7 +24,7 @@ struct repository {
 	/*
 	 * Holds any information related to accessing the raw object content.
 	 */
-	struct raw_object_store objects;
+	struct raw_object_store *objects;
 
 	/*
 	 * Path to the repository's graft file.
diff --git a/server-info.c b/server-info.c
index 6fe64ede17..75a8b65e47 100644
--- a/server-info.c
+++ b/server-info.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "packfile.h"
+#include "object-store.h"
 
 /*
  * Create the file "path" by writing to a temporary file and renaming
diff --git a/sha1_file.c b/sha1_file.c
index 7066d4c9ce..0989bbd948 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,7 +23,6 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
-#include "object-store.h"
 #include "streaming.h"
 #include "dir.h"
 #include "list.h"
@@ -31,6 +30,7 @@
 #include "quote.h"
 #include "packfile.h"
 #include "fetch-object.h"
+#include "object-store.h"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -325,7 +325,7 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 
 void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addstr(buf, r->objects.objectdir);
+	strbuf_addstr(buf, r->objects->objectdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
@@ -419,7 +419,7 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&r->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -427,8 +427,8 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*r->objects.alt_odb_tail = ent;
-	r->objects.alt_odb_tail = &(ent->next);
+	*r->objects->alt_odb_tail = ent;
+	r->objects->alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -482,7 +482,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, r->objects.objectdir);
+	strbuf_add_absolute_path(&objdirbuf, r->objects->objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -565,7 +565,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
-		if (the_repository->objects.alt_odb_tail)
+		if (the_repository->objects->alt_odb_tail)
 			link_alt_odb_entries(the_repository, reference,
 					     '\n', NULL, 0);
 	}
@@ -665,7 +665,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	int r = 0;
 
 	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
+	for (ent = the_repository->objects->alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -675,13 +675,13 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 
 void prepare_alt_odb(struct repository *r)
 {
-	if (r->objects.alt_odb_tail)
+	if (r->objects->alt_odb_tail)
 		return;
 
-	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
-	link_alt_odb_entries(r, r->objects.alternate_db, PATH_SEP, NULL, 0);
+	r->objects->alt_odb_tail = &r->objects->alt_odb_list;
+	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects.objectdir, 0);
+	read_info_alternates(r, r->objects->objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
@@ -722,7 +722,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
@@ -882,7 +882,7 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 
 	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -913,7 +913,7 @@ static int open_sha1_file(struct repository *r,
 	most_interesting_errno = errno;
 
 	prepare_alt_odb(r);
-	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
diff --git a/sha1_name.c b/sha1_name.c
index 2065be90d2..4325f74e0c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "object-store.h"
 #include "repository.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
@@ -105,7 +106,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		 */
 		fakeent = alloc_alt_odb(get_object_directory());
 	}
-	fakeent->next = the_repository->objects.alt_odb_list;
+	fakeent->next = the_repository->objects->alt_odb_list;
 
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		int pos;
diff --git a/submodule.c b/submodule.c
index 47ddc9b273..b03e5f5045 100644
--- a/submodule.c
+++ b/submodule.c
@@ -21,6 +21,7 @@
 #include "remote.h"
 #include "worktree.h"
 #include "parse-options.h"
+#include "object-store.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7120634b04..7314b5943e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "worktree.h"
+#include "object-store.h"
 
 static const char *notnull(const char *arg, const char *name)
 {
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b2d9280f10..fea3f55545 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 #include "argv-array.h"
 #include "quote.h"
+#include "object-store.h"
 
 struct tmp_objdir {
 	struct strbuf path;
diff --git a/transport.c b/transport.c
index 00d48b5b56..3afc632472 100644
--- a/transport.c
+++ b/transport.c
@@ -18,6 +18,7 @@
 #include "sha1-array.h"
 #include "sigchain.h"
 #include "transport-internal.h"
+#include "object-store.h"
 
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
-- 
2.17.0.rc0.348.gd5a49e0b6f

