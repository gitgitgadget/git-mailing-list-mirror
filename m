Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945141F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeCaKDX (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:23 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36146 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeCaKDW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id z143-v6so15133734lff.3
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ZouKX2wUWln6Oj6l09KY9qqeOhyyHcWQuktxA9J948=;
        b=nYIpfE/rWgCrgM4FkoXLEwIdbPSrzFsqW46CQIic90ge6ntrOChHoAVBYGcC3Oxy7G
         5gczLHtlUfqJgSHUvH0HZyNuvqQCfadAFmoXZJv+GTGrKF/B8mYsQNM84JdYH0LXVUW3
         gJ++BwiOcMDW8ihKQhEyfdvBu7t+GTMxO9Rl/LdFbBWms/IOJmB1/Vu+X9wp/akuvXpn
         E+Pdt/eEdvtfqw9JOyXKagDOvQ7SzzOTe+/9yoC5tdtVS9wXRuEDnrHpoYCtDK0FZa2H
         mFjcmtCr1D1EiVrx+f9R+W7Y6uFwgrsrW8Jn39ILnHUMV2HIFLGFEVR8Pd3+BXDSz+T8
         fB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZouKX2wUWln6Oj6l09KY9qqeOhyyHcWQuktxA9J948=;
        b=kl9njtW2neF8wup9T1iXjUIvZtD4uIICx8vaDFEdPnijcL0gM0lQzkrAMxFdS6Pfcx
         xNzEHMAd3t0SNiCvOK8Pcysyroas8xulb63+DiP7DCNUNQbqCwn5hdbfJb71XW5n5qGu
         tGeeeBW8CPKLT7Jvs8Aak9psBUaSrPyIBdkKopZWwhTVfuSl6UsacWd8LTQEHPwKWISW
         irfb0hLwsHpONlJwxUjBO61Ff852MOsXZWT/VBYYGeJjD1Migd3Yu/4ugyYKB3BcSYQ2
         mcQy83SbYlmAhNr/IPHhhVKo1UCmlLyxVu2OBFYWgd0U6jILntP6qbERpSIoXqtMabUF
         2RdA==
X-Gm-Message-State: ALQs6tD94SRYlN9WbyZcRxjPPcV1lwv+tLUxnMzTPJKtaWYeu0/uqMkv
        /54mog4F0kHMZsk9n9v8XhY=
X-Google-Smtp-Source: AIpwx4/SdzNWISy2w7iA4UpgmUQL7IZZ4SuY4M2VRPoPQiJlmrGG6w/3GNVvTdEn5sUnckW3pc+/mA==
X-Received: by 10.46.128.16 with SMTP id j16mr1522861ljg.26.1522490600382;
        Sat, 31 Mar 2018 03:03:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 00/15] nd/pack-objects-pack-struct updates
Date:   Sat, 31 Mar 2018 12:02:56 +0200
Message-Id: <20180331100311.32373-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v8 changes

- prefer BUG() over die()
- do "1U <<" instead of "1 << " to avoid undefined behavior with
  signed shifting.
- add more comments based on Jeff's feedback
- plug a leak in try_delta() when delta_size is too large
- be kind and set depth/cache_max_small_delta_size to max limit
  instead of dying when the user gives a value over limit
- make travis execute pack-objects uncommon code
- use git_env_*() instead of manually handling getenv() values
- fallback code for when a new pack is added when pack-objects is
  running
- Compressed cached delta size limit is increased from 64k to 1MB
- Cached delta size limit is decreased from 2G to 1MB

Interdiff

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c774821930..b5bba2c228 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1439,7 +1439,7 @@ static void check_object(struct object_entry *entry)
 			goto give_up;
 
 		if (type < 0)
-			die("BUG: invalid type %d", type);
+			BUG("invalid type %d", type);
 		entry->in_pack_type = type;
 
 		/*
@@ -1861,6 +1861,11 @@ static pthread_mutex_t progress_mutex;
 
 #endif
 
+/*
+ * Return the size of the object without doing any delta
+ * reconstruction (so non-deltas are true object sizes, but deltas
+ * return the size of the delta data).
+ */
 unsigned long oe_get_size_slow(struct packing_data *pack,
 			       const struct object_entry *e)
 {
@@ -1881,7 +1886,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 
 	p = oe_in_pack(pack, e);
 	if (!p)
-		die("BUG: when e->type is a delta, it must belong to a pack");
+		BUG("when e->type is a delta, it must belong to a pack");
 
 	read_lock();
 	w_curs = NULL;
@@ -2006,8 +2011,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= (1 << OE_DELTA_SIZE_BITS))
+	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
+		free(delta_buf);
 		return 0;
+	}
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
@@ -2163,7 +2170,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 			unsigned long size;
 
 			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
-			if (size < (1 << OE_Z_DELTA_BITS)) {
+			if (size < (1U << OE_Z_DELTA_BITS)) {
 				entry->z_delta_size = size;
 				cache_lock();
 				delta_cache_size -= DELTA_SIZE(entry);
@@ -3131,7 +3138,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	};
 
 	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
-		die("BUG: too many dfs states, increase OE_DFS_STATE_BITS");
+		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
 
 	check_replace_refs = 0;
 
@@ -3149,12 +3156,16 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
-	if (depth >= (1 << OE_DEPTH_BITS))
-		die(_("delta chain depth %d is greater than maximum limit %d"),
-		    depth, (1 << OE_DEPTH_BITS) - 1);
-	if (cache_max_small_delta_size >= (1 << OE_Z_DELTA_BITS))
-		die(_("pack.deltaCacheLimit is greater than maximum limit %d"),
-		    (1 << OE_Z_DELTA_BITS) - 1);
+	if (depth >= (1 << OE_DEPTH_BITS)) {
+		warning(_("delta chain depth %d is too deep, forcing %d"),
+			depth, (1 << OE_DEPTH_BITS) - 1);
+		depth = (1 << OE_DEPTH_BITS) - 1;
+	}
+	if (cache_max_small_delta_size >= (1U << OE_Z_DELTA_BITS)) {
+		warning(_("pack.deltaCacheLimit is too high, forcing %d"),
+			(1U << OE_Z_DELTA_BITS) - 1);
+		cache_max_small_delta_size = (1U << OE_Z_DELTA_BITS) - 1;
+	}
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
@@ -3274,6 +3285,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	prepare_packing_data(&to_pack);
+
 	if (progress)
 		progress_state = start_progress(_("Counting objects"), 0);
 	if (!use_internal_rev_list)
diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index 73e273fac7..857d144ee8 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -10,7 +10,10 @@ ln -s "$cache_dir/.prove" t/.prove
 make --quiet test
 if test "$jobname" = "linux-gcc"
 then
-	GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
+	export GIT_TEST_SPLIT_INDEX=YesPlease
+	export GIT_TEST_FULL_IN_PACK_ARRAY=true
+	export GIT_TEST_OE_SIZE=10
+	make --quiet test
 fi
 
 check_unignored_build_artifacts
diff --git a/pack-objects.c b/pack-objects.c
index 59c6e40a02..bf2e0a808d 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -3,6 +3,7 @@
 #include "pack.h"
 #include "pack-objects.h"
 #include "packfile.h"
+#include "config.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const unsigned char *sha1,
@@ -90,18 +91,14 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 static void prepare_in_pack_by_idx(struct packing_data *pdata)
 {
 	struct packed_git **mapping, *p;
-	int cnt = 0, nr = 1 << OE_IN_PACK_BITS;
-
-	if (getenv("GIT_TEST_FULL_IN_PACK_ARRAY")) {
-		/*
-		 * leave in_pack_by_idx NULL to force in_pack[] to be
-		 * used instead
-		 */
-		return;
-	}
+	int cnt = 0, nr = 1U << OE_IN_PACK_BITS;
 
 	ALLOC_ARRAY(mapping, nr);
-	mapping[cnt++] = NULL; /* zero index must be mapped to NULL */
+	/*
+	 * oe_in_pack() on an all-zero'd object_entry
+	 * (i.e. in_pack_idx also zero) should return NULL.
+	 */
+	mapping[cnt++] = NULL;
 	prepare_packed_git();
 	for (p = packed_git; p; p = p->next, cnt++) {
 		if (cnt == nr) {
@@ -114,21 +111,50 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
 	pdata->in_pack_by_idx = mapping;
 }
 
+/*
+ * A new pack appears after prepare_in_pack_by_idx() has been
+ * run. This is likely a race.
+ *
+ * We could map this new pack to in_pack_by_idx[] array, but then we
+ * have to deal with full array anyway. And since it's hard to test
+ * this fall back code, just stay simple and fall back to using
+ * in_pack[] array.
+ */
+void oe_map_new_pack(struct packing_data *pack,
+		     struct packed_git *p)
+{
+	uint32_t i;
+
+	REALLOC_ARRAY(pack->in_pack, pack->nr_alloc);
+
+	for (i = 0; i < pack->nr_objects; i++)
+		pack->in_pack[i] = oe_in_pack(pack, pack->objects + i);
+
+	FREE_AND_NULL(pack->in_pack_by_idx);
+}
+
+/* assume pdata is already zero'd by caller */
+void prepare_packing_data(struct packing_data *pdata)
+{
+	if (git_env_bool("GIT_TEST_FULL_IN_PACK_ARRAY", 0)) {
+		/*
+		 * do not initialize in_pack_by_idx[] to force the
+		 * slow path in oe_in_pack()
+		 */
+	} else {
+		prepare_in_pack_by_idx(pdata);
+	}
+
+	pdata->oe_size_limit = git_env_ulong("GIT_TEST_OE_SIZE",
+					     1U << OE_SIZE_BITS);
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos)
 {
 	struct object_entry *new_entry;
 
-	if (!pdata->nr_objects) {
-		prepare_in_pack_by_idx(pdata);
-		if (getenv("GIT_TEST_OE_SIZE_BITS")) {
-			int bits = atoi(getenv("GIT_TEST_OE_SIZE_BITS"));;
-			pdata->oe_size_limit = 1 << bits;
-		}
-		if (!pdata->oe_size_limit)
-			pdata->oe_size_limit = 1 << OE_SIZE_BITS;
-	}
 	if (pdata->nr_objects >= pdata->nr_alloc) {
 		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
 		REALLOC_ARRAY(pdata->objects, pdata->nr_alloc);
diff --git a/pack-objects.h b/pack-objects.h
index c20f67e25b..60192cce1f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,9 +4,13 @@
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		10
-#define OE_Z_DELTA_BITS		16
+#define OE_Z_DELTA_BITS		20
+/*
+ * Note that oe_set_size() becomes expensive when the given size is
+ * above this limit. Don't lower it too much.
+ */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	31
+#define OE_DELTA_SIZE_BITS	20
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -36,7 +40,7 @@ enum dfs_state {
  *
  * "size" is the uncompressed object size. Compressed size of the raw
  * data for an object in a pack is not stored anywhere but is computed
- * and made available when reverse .idx is made. Note that when an
+ * and made available when reverse .idx is made. Note that when a
  * delta is reused, "size" is the uncompressed _delta_ size, not the
  * canonical one after the delta has been applied.
  *
@@ -77,15 +81,15 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	off_t in_pack_offset;
 	uint32_t hash;			/* name hint hash */
-	uint32_t size_:OE_SIZE_BITS;
+	unsigned size_:OE_SIZE_BITS;
 	unsigned size_valid:1;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
-	uint32_t delta_size_valid:1;
+	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
+	unsigned delta_size_valid:1;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_valid:1;
@@ -103,7 +107,15 @@ struct object_entry {
 	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 80, bit_padding: 20 bits, holes: 1 bit */
+	/*
+	 * pahole results on 64-bit linux (gcc and clang)
+	 *
+	 *   size: 80, bit_padding: 20 bits, holes: 8 bits
+	 *
+	 * and on 32-bit (gcc)
+	 *
+	 *   size: 76, bit_padding: 20 bits, holes: 8 bits
+	 */
 };
 
 struct packing_data {
@@ -127,6 +139,7 @@ struct packing_data {
 	uintmax_t oe_size_limit;
 };
 
+void prepare_packing_data(struct packing_data *pdata);
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos);
@@ -164,7 +177,7 @@ static inline void oe_set_type(struct object_entry *e,
 			       enum object_type type)
 {
 	if (type >= OBJ_ANY)
-		die("BUG: OBJ_ANY cannot be set in pack-objects code");
+		BUG("OBJ_ANY cannot be set in pack-objects code");
 
 	e->type_valid = type >= OBJ_NONE;
 	e->type_ = (unsigned)type;
@@ -190,21 +203,20 @@ static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
 		return pack->in_pack_by_idx[e->in_pack_idx];
 	else
 		return pack->in_pack[e - pack->objects];
-
 }
 
+void oe_map_new_pack(struct packing_data *pack,
+		     struct packed_git *p);
 static inline void oe_set_in_pack(struct packing_data *pack,
 				  struct object_entry *e,
 				  struct packed_git *p)
 {
-	if (pack->in_pack_by_idx) {
-		if (p->index <= 0)
-			die("BUG: found_pack should be NULL "
-					"instead of having non-positive index");
+	if (!p->index)
+		oe_map_new_pack(pack, p);
+	if (pack->in_pack_by_idx)
 		e->in_pack_idx = p->index;
-	} else
+	else
 		pack->in_pack[e - pack->objects] = p;
-
 }
 
 static inline struct object_entry *oe_delta(
@@ -307,7 +319,7 @@ static inline void oe_set_size(struct packing_data *pack,
 	} else {
 		e->size_valid = 0;
 		if (oe_get_size_slow(pack, e) != size)
-			die("BUG: 'size' is supposed to be the object size!");
+			BUG("'size' is supposed to be the object size!");
 	}
 }
 
@@ -326,7 +338,7 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 	e->delta_size_ = size;
 	e->delta_size_valid = e->delta_size_ == size;
 	if (!e->delta_size_valid && size != oe_size(pack, e))
-		die("BUG: this can only happen in check_object() "
+		BUG("this can only happen in check_object() "
 		    "where delta size is the same as entry size");
 }
 
diff --git a/t/README b/t/README
index 02bfb3fed5..c01d210c15 100644
--- a/t/README
+++ b/t/README
@@ -291,16 +291,26 @@ expect the rest to function correctly.
 and know what setup is needed for it.  Or when you want to run
 everything up to a certain test.
 
+
+Running tests with special setups
+---------------------------------
+
+The whole test suite could be run to test some special features
+that cannot be easily covered by a few specific test cases. These
+could be enabled by running the test suite with correct GIT_TEST_
+environment set.
+
+GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
+
 GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
 path where there are more than 1024 packs even if the actual number of
 packs in repository is below this limit.
 
-GIT_TEST_OE_SIZE_BITS=<bits> exercises the uncommon pack-objects
-code path where we do not cache objecct size in memory and read it
-from existing packs on demand. This normally only happens when the
-object size is over 2GB. This variable forces the code path on any
-object larger than 2^<bits> bytes.
-
+GIT_TEST_OE_SIZE=<n> exercises the uncommon pack-objects code path
+where we do not cache object size in memory and read it from existing
+packs on demand. This normally only happens when the object size is
+over 2GB. This variable forces the code path on any object larger than
+<n> bytes.
 
 Naming Tests
 ------------
Nguyễn Thái Ngọc Duy (15):
  t/README: mention about running the test suite in special modes
  pack-objects: a bit of document about struct object_entry
  pack-objects: turn type and in_pack_type to bitfields
  pack-objects: use bitfield for object_entry::dfs_state
  pack-objects: use bitfield for object_entry::depth
  pack-objects: move in_pack_pos out of struct object_entry
  pack-objects: move in_pack out of struct object_entry
  pack-objects: refer to delta objects by index instead of pointer
  pack-objects: shrink z_delta_size field in struct object_entry
  pack-objects: don't check size when the object is bad
  pack-objects: clarify the use of object_entry::size
  pack-objects: shrink size field in struct object_entry
  pack-objects: shrink delta_size field in struct object_entry
  pack-objects: reorder members to shrink struct object_entry
  ci: exercise the whole test suite with uncommon code in pack-objects

 Documentation/config.txt           |   4 +-
 Documentation/git-pack-objects.txt |   4 +-
 Documentation/git-repack.txt       |   4 +-
 builtin/pack-objects.c             | 366 +++++++++++++++++++----------
 cache.h                            |   3 +
 ci/run-tests.sh                    |   5 +-
 object.h                           |   1 -
 pack-bitmap-write.c                |  14 +-
 pack-bitmap.c                      |   2 +-
 pack-bitmap.h                      |   4 +-
 pack-objects.c                     |  69 ++++++
 pack-objects.h                     | 312 ++++++++++++++++++++++--
 t/README                           |  20 ++
 t/t5300-pack-object.sh             |   5 +
 14 files changed, 650 insertions(+), 163 deletions(-)

-- 
2.17.0.rc2.515.g4feb9b7923

