Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA531F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeCWRXL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:23:11 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41127 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbeCWRVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id o102-v6so19364278lfg.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9iOPR0YLpXs/QJTTKVOrUuyKel+jqq4c9YAZh7JrwQ=;
        b=R0BVmmGlTFT1ihl+y0hmEu/hsjhTCWzep3n5bh1FTX/0GYTE1r6J8eFeKR9lzM19ps
         eao/ID9eGII5sncD1V7VaETlMIjFQvf5UbbQ7qRNV6o3PU9y4IY7PcYPureYYztZPgwX
         NTY/zzQI+1xjSSGDb0CX+3VfZiINVP1wt32vt6JB+l3MCDWyYTvw7zfm/P51dLCzHWlG
         1Bb30kelG1frJY8VShN9b4+QSfuNX53QpAwz6DTwwRJw/ARDIO0FjfxNJ0GBVxh9wrr1
         Got4yGYtQLn1RRA8N0wfgD+/oCYeVGEoRHRoN7ikLipYK5uWJO343csFMiPPLEYgzYfw
         J64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9iOPR0YLpXs/QJTTKVOrUuyKel+jqq4c9YAZh7JrwQ=;
        b=h7OauMIf99v/07BA0ltU02p5rwr3a2otv0vDfgj7XYE+rOnuKeFD5X1qZv04zsfsKS
         zEYdUjK6i4t35w80xj8WeTqCw4MIga63udMbGMnNf+OREqQwmL5bBxbRH/J8ZtuuAAsB
         W7seC8vFep7BKJCOV1ENJ4wYZayNjhNLFWhPCKRQwdYqBB+Dzw1olO3oG/qYRSPa8Egl
         uEyqPLL+3hQW/V4lpslFVZOSwYqQq3IE4y1Zm8upH6cNx4ft0kU6sfaFUSdw7VbsJ8sb
         XDrSOwnSYFCkvWevBM4JY325W4GI5oqkGK+W0QBiIhYcF+aruhHUH+lzSH3aAJcGMYQW
         TqQw==
X-Gm-Message-State: AElRT7GU337TbX/deiE/uoJvaCZsu/uz93YiReCKQ1+YTT+IWUVxaFoE
        TqUK6h5x3yQq+Z8tMu+/rrA=
X-Google-Smtp-Source: AG47ELtWWcbw7epTcHLO6I5Dk21jVHvAV0OXXeCsmJn5PAuG0GrgB8Wa4qWrZr6TBl2nO91k/zCIzQ==
X-Received: by 2002:a19:e90e:: with SMTP id g14-v6mr21050211lfh.80.1521825706741;
        Fri, 23 Mar 2018 10:21:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/27] object-store: move packed_git and packed_git_mru to object store
Date:   Fri, 23 Mar 2018 18:20:59 +0100
Message-Id: <20180323172121.17725-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

In a process with multiple repositories open, packfile accessors
should be associated to a single repository and not shared globally.
Move packed_git and packed_git_mru into the_repository and adjust
callers to reflect this.

[nd: while at there, wrap access to these two fields in get_packed_git()
and get_packed_git_mru(). This allows us to lazily initialize these
fields without caller doing that explicitly]

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/count-objects.c  |  5 ++--
 builtin/fsck.c           |  6 +++--
 builtin/gc.c             |  4 +++-
 builtin/index-pack.c     |  1 +
 builtin/pack-objects.c   | 21 ++++++++++-------
 builtin/pack-redundant.c |  6 +++--
 cache.h                  | 29 -----------------------
 fast-import.c            |  8 +++++--
 http-backend.c           |  6 +++--
 http-push.c              |  1 +
 http-walker.c            |  1 +
 http.c                   |  1 +
 object-store.h           | 34 +++++++++++++++++++++++++++
 object.c                 |  7 ++++++
 pack-bitmap.c            |  4 +++-
 pack-check.c             |  1 +
 pack-revindex.c          |  1 +
 packfile.c               | 51 ++++++++++++++++++++++++----------------
 packfile.h               |  3 +++
 reachable.c              |  1 +
 server-info.c            |  6 +++--
 sha1_name.c              |  5 ++--
 22 files changed, 128 insertions(+), 74 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ced8958e43..b28ff00be2 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "repository.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "quote.h"
@@ -121,9 +122,9 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf loose_buf = STRBUF_INIT;
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
-		if (!packed_git)
+		if (!get_packed_git(the_repository))
 			prepare_packed_git();
-		for (p = packed_git; p; p = p->next) {
+		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fsck.c b/builtin/fsck.c
index c736a10a11..7707407275 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -732,7 +732,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			prepare_packed_git();
 
 			if (show_progress) {
-				for (p = packed_git; p; p = p->next) {
+				for (p = get_packed_git(the_repository); p;
+				     p = p->next) {
 					if (open_pack_index(p))
 						continue;
 					total += p->num_objects;
@@ -740,7 +741,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 				progress = start_progress(_("Checking objects"), total);
 			}
-			for (p = packed_git; p; p = p->next) {
+			for (p = get_packed_git(the_repository); p;
+			     p = p->next) {
 				/* verify gives error messages itself */
 				if (verify_pack(p, fsck_obj_buffer,
 						progress, count))
diff --git a/builtin/gc.c b/builtin/gc.c
index 77fa720bd0..b00238cd5d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -11,6 +11,7 @@
  */
 
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "tempfile.h"
 #include "lockfile.h"
@@ -20,6 +21,7 @@
 #include "argv-array.h"
 #include "commit.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -173,7 +175,7 @@ static int too_many_packs(void)
 		return 0;
 
 	prepare_packed_git();
-	for (cnt = 0, p = packed_git; p; p = p->next) {
+	for (cnt = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
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
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 83dcbc9773..223f2d9fc0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "attr.h"
 #include "object.h"
@@ -28,6 +29,7 @@
 #include "argv-array.h"
 #include "list.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -1025,8 +1027,7 @@ static int want_object_in_pack(const struct object_id *oid,
 		if (want != -1)
 			return want;
 	}
-
-	list_for_each(pos, &packed_git_mru) {
+	list_for_each(pos, get_packed_git_mru(the_repository)) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		off_t offset;
 
@@ -1044,7 +1045,8 @@ static int want_object_in_pack(const struct object_id *oid,
 			}
 			want = want_found_object(exclude, p);
 			if (!exclude && want > 0)
-				list_move(&p->mru, &packed_git_mru);
+				list_move(&p->mru,
+					  get_packed_git_mru(the_repository));
 			if (want != -1)
 				return want;
 		}
@@ -2673,7 +2675,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 
 	memset(&in_pack, 0, sizeof(in_pack));
 
-	for (p = packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		struct object_id oid;
 		struct object *o;
 
@@ -2736,7 +2738,8 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
 
-	p = (last_found != (void *)1) ? last_found : packed_git;
+	p = (last_found != (void *)1) ? last_found :
+					get_packed_git(the_repository);
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep) &&
@@ -2745,7 +2748,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 			return 1;
 		}
 		if (p == last_found)
-			p = packed_git;
+			p = get_packed_git(the_repository);
 		else
 			p = p->next;
 		if (p == last_found)
@@ -2781,7 +2784,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	uint32_t i;
 	struct object_id oid;
 
-	for (p = packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local || p->pack_keep)
 			continue;
 
@@ -3152,7 +3155,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	prepare_packed_git();
 	if (ignore_packed_keep) {
 		struct packed_git *p;
-		for (p = packed_git; p; p = p->next)
+		for (p = get_packed_git(the_repository); p; p = p->next)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
@@ -3165,7 +3168,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		 * also covers non-local objects
 		 */
 		struct packed_git *p;
-		for (p = packed_git; p; p = p->next) {
+		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local) {
 				have_non_local_packs = 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index aaa8136322..b5b007e706 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -7,7 +7,9 @@
 */
 
 #include "builtin.h"
+#include "repository.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define BLKSIZE 512
 
@@ -571,7 +573,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packed_git *p = packed_git;
+	struct packed_git *p = get_packed_git(the_repository);
 
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
@@ -586,7 +588,7 @@ static struct pack_list * add_pack_file(const char *filename)
 
 static void load_all(void)
 {
-	struct packed_git *p = packed_git;
+	struct packed_git *p = get_packed_git(the_repository);
 
 	while (p) {
 		add_pack(p);
diff --git a/cache.h b/cache.h
index 41530d5d16..d3429a0d48 100644
--- a/cache.h
+++ b/cache.h
@@ -1585,35 +1585,6 @@ struct pack_window {
 	unsigned int inuse_cnt;
 };
 
-extern struct packed_git {
-	struct packed_git *next;
-	struct list_head mru;
-	struct pack_window *windows;
-	off_t pack_size;
-	const void *index_data;
-	size_t index_size;
-	uint32_t num_objects;
-	uint32_t num_bad_objects;
-	unsigned char *bad_object_sha1;
-	int index_version;
-	time_t mtime;
-	int pack_fd;
-	unsigned pack_local:1,
-		 pack_keep:1,
-		 freshened:1,
-		 do_not_close:1,
-		 pack_promisor:1;
-	unsigned char sha1[20];
-	struct revindex_entry *revindex;
-	/* something like ".git/objects/pack/xxxxx.pack" */
-	char pack_name[FLEX_ARRAY]; /* more */
-} *packed_git;
-
-/*
- * A most-recently-used ordered version of the packed_git list.
- */
-extern struct list_head packed_git_mru;
-
 struct pack_entry {
 	off_t offset;
 	unsigned char sha1[20];
diff --git a/fast-import.c b/fast-import.c
index b70ac025e0..b3492fce5c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -154,6 +154,7 @@ Format of STDIN stream:
 
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "object.h"
@@ -168,6 +169,7 @@ Format of STDIN stream:
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -1110,7 +1112,8 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_sha1_pack(oid.hash, packed_git)) {
+	} else if (find_sha1_pack(oid.hash,
+				  get_packed_git(the_repository))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1305,7 +1308,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_sha1_pack(oid.hash, packed_git)) {
+	} else if (find_sha1_pack(oid.hash,
+				  get_packed_git(the_repository))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/http-backend.c b/http-backend.c
index f3dc218b2a..64dde78c1b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "object.h"
@@ -10,6 +11,7 @@
 #include "url.h"
 #include "argv-array.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
@@ -518,13 +520,13 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 
 	select_getanyfile(hdr);
 	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
 	}
 
 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
 	}
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
index 07c2b1af82..d850408d18 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -5,6 +5,7 @@
 #include "list.h"
 #include "transport.h"
 #include "packfile.h"
+#include "object-store.h"
 
 struct alt_base {
 	char *base;
diff --git a/http.c b/http.c
index 31755023a4..efa977112a 100644
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
index 0b4db5867d..c687ab7587 100644
--- a/object-store.h
+++ b/object-store.h
@@ -52,6 +52,30 @@ void add_to_alternates_memory(const char *dir);
  */
 struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
 
+struct packed_git {
+	struct packed_git *next;
+	struct list_head mru;
+	struct pack_window *windows;
+	off_t pack_size;
+	const void *index_data;
+	size_t index_size;
+	uint32_t num_objects;
+	uint32_t num_bad_objects;
+	unsigned char *bad_object_sha1;
+	int index_version;
+	time_t mtime;
+	int pack_fd;
+	unsigned pack_local:1,
+		 pack_keep:1,
+		 freshened:1,
+		 do_not_close:1,
+		 pack_promisor:1;
+	unsigned char sha1[20];
+	struct revindex_entry *revindex;
+	/* something like ".git/objects/pack/xxxxx.pack" */
+	char pack_name[FLEX_ARRAY]; /* more */
+};
+
 struct raw_object_store {
 	/*
 	 * Path to the repository's object store.
@@ -64,6 +88,16 @@ struct raw_object_store {
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
+
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c
+	 */
+
+	struct packed_git *packed_git;
+	/* A most-recently-used ordered version of the packed_git list. */
+	struct list_head packed_git_mru;
 };
 
 struct raw_object_store *raw_object_store_new(void);
diff --git a/object.c b/object.c
index 581347b535..04631ee841 100644
--- a/object.c
+++ b/object.c
@@ -452,6 +452,7 @@ struct raw_object_store *raw_object_store_new(void)
 	struct raw_object_store *o = xmalloc(sizeof(*o));
 
 	memset(o, 0, sizeof(*o));
+	INIT_LIST_HEAD(&o->packed_git_mru);
 	return o;
 }
 
@@ -480,4 +481,10 @@ void raw_object_store_clear(struct raw_object_store *o)
 
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
+
+	INIT_LIST_HEAD(&o->packed_git_mru);
+	/*
+	 * TODO: call close_all_packs once migrated to
+	 * take an object store argument
+	 */
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9270983e5f..22cd425788 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -10,6 +10,8 @@
 #include "pack-revindex.h"
 #include "pack-objects.h"
 #include "packfile.h"
+#include "repository.h"
+#include "object-store.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -335,7 +337,7 @@ static int open_pack_bitmap(void)
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
 	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
 	}
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
index fdbf240f81..39f4a85200 100644
--- a/packfile.c
+++ b/packfile.c
@@ -46,8 +46,6 @@ static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
-struct packed_git *packed_git;
-LIST_HEAD(packed_git_mru);
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -247,7 +245,7 @@ static int unuse_one_window(struct packed_git *current)
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = packed_git; p; p = p->next)
+	for (p = the_repository->objects->packed_git; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -317,7 +315,7 @@ void close_all_packs(void)
 {
 	struct packed_git *p;
 
-	for (p = packed_git; p; p = p->next)
+	for (p = the_repository->objects->packed_git; p; p = p->next)
 		if (p->do_not_close)
 			die("BUG: want to close pack marked 'do-not-close'");
 		else
@@ -385,7 +383,7 @@ static int close_one_pack(void)
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = packed_git; p; p = p->next) {
+	for (p = the_repository->objects->packed_git; p; p = p->next) {
 		if (p->pack_fd == -1)
 			continue;
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
@@ -687,8 +685,8 @@ void install_packed_git(struct packed_git *pack)
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = packed_git;
-	packed_git = pack;
+	pack->next = the_repository->objects->packed_git;
+	the_repository->objects->packed_git = pack;
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -770,7 +768,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
-			for (p = packed_git; p; p = p->next) {
+			for (p = the_repository->objects->packed_git; p;
+			     p = p->next) {
 				size_t len;
 				if (strip_suffix(p->pack_name, ".pack", &len) &&
 				    len == base_len &&
@@ -821,7 +820,7 @@ unsigned long approximate_object_count(void)
 
 		prepare_packed_git();
 		count = 0;
-		for (p = packed_git; p; p = p->next) {
+		for (p = the_repository->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
@@ -870,18 +869,19 @@ static int sort_pack(const void *a_, const void *b_)
 
 static void rearrange_packed_git(void)
 {
-	packed_git = llist_mergesort(packed_git, get_next_packed_git,
-				     set_next_packed_git, sort_pack);
+	the_repository->objects->packed_git = llist_mergesort(
+		the_repository->objects->packed_git, get_next_packed_git,
+		set_next_packed_git, sort_pack);
 }
 
 static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&packed_git_mru);
+	INIT_LIST_HEAD(&the_repository->objects->packed_git_mru);
 
-	for (p = packed_git; p; p = p->next)
-		list_add_tail(&p->mru, &packed_git_mru);
+	for (p = the_repository->objects->packed_git; p; p = p->next)
+		list_add_tail(&p->mru, &the_repository->objects->packed_git_mru);
 }
 
 static int prepare_packed_git_run_once = 0;
@@ -907,6 +907,16 @@ void reprepare_packed_git(void)
 	prepare_packed_git();
 }
 
+struct packed_git *get_packed_git(struct repository *r)
+{
+	return r->objects->packed_git;
+}
+
+struct list_head *get_packed_git_mru(struct repository *r)
+{
+	return &r->objects->packed_git_mru;
+}
+
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
@@ -1015,7 +1025,7 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 	struct packed_git *p;
 	unsigned i;
 
-	for (p = packed_git; p; p = p->next)
+	for (p = the_repository->objects->packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
 			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
 				return p;
@@ -1846,13 +1856,14 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	struct list_head *pos;
 
 	prepare_packed_git();
-	if (!packed_git)
+	if (!the_repository->objects->packed_git)
 		return 0;
 
-	list_for_each(pos, &packed_git_mru) {
+	list_for_each(pos, &the_repository->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (fill_pack_entry(sha1, e, p)) {
-			list_move(&p->mru, &packed_git_mru);
+			list_move(&p->mru,
+				  &the_repository->objects->packed_git_mru);
 			return 1;
 		}
 	}
@@ -1899,7 +1910,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	int pack_errors = 0;
 
 	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
+	for (p = the_repository->objects->packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
@@ -1930,7 +1941,7 @@ static int add_promisor_object(const struct object_id *oid,
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
-	 * to are also promisor objects. (Blobs refer to no objects.)
+	 * to are also promisor objects-> (Blobs refer to no objects->)
 	 */
 	if (obj->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)obj;
diff --git a/packfile.h b/packfile.h
index a7fca598d6..76496226bb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -38,6 +38,9 @@ extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
 
+struct packed_git *get_packed_git(struct repository *r);
+struct list_head *get_packed_git_mru(struct repository *r);
+
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.
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
diff --git a/server-info.c b/server-info.c
index 26a6c20b7d..75a8b65e47 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,9 +1,11 @@
 #include "cache.h"
+#include "repository.h"
 #include "refs.h"
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
 #include "packfile.h"
+#include "object-store.h"
 
 /*
  * Create the file "path" by writing to a temporary file and renaming
@@ -200,7 +202,7 @@ static void init_pack_info(const char *infofile, int force)
 	objdirlen = strlen(objdir);
 
 	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
@@ -210,7 +212,7 @@ static void init_pack_info(const char *infofile, int force)
 	}
 	num_pack = i;
 	info = xcalloc(num_pack, sizeof(struct pack_info *));
-	for (i = 0, p = packed_git; p; p = p->next) {
+	for (i = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		info[i] = xcalloc(1, sizeof(struct pack_info));
diff --git a/sha1_name.c b/sha1_name.c
index a22a29cda0..ffff7d8710 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -197,7 +197,8 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 	struct packed_git *p;
 
 	prepare_packed_git();
-	for (p = packed_git; p && !ds->ambiguous; p = p->next)
+	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
+	     p = p->next)
 		unique_in_pack(p, ds);
 }
 
@@ -567,7 +568,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 	struct packed_git *p;
 
 	prepare_packed_git();
-	for (p = packed_git; p; p = p->next)
+	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

