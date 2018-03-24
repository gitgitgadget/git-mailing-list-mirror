Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F94D1FAE7
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbeCXGeK (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:10 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:38509 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCXGeI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:08 -0400
Received: by mail-lf0-f42.google.com with SMTP id u3-v6so352907lff.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zG3mnlMzXlGBZxlf0Y8ENqb/pBbJWa2jCQq9nQMLe4=;
        b=UQ2jSN6P7jNocCDLuKtDDdqWuVLrrYT529rd0wfACNcxEEhS7GhhQSLZ4rV7ELJWEp
         +tVLqILqz6Hx08TZps7tcY5QoquCnAgFrXrz9Pn62aHU3XfWkOfBl0K5EgFODRY/xfeH
         BgXvfqwtHt6UehlnKEi0d3B/XZqAe4ikByYQQDrYUnQbMzXr/DEYIO7+xWbx1u7TmqxK
         UkLUO9s38PxRwhK5Kjc9i+MLaWYMFSPVfB683xWCbW1LnpqcDs2HOIywtLPQa6JG1+u1
         O8wztsct5F60PUcS+G2P4Wa2qe30c4MPP41aENE+zVJwqe+iYjI5pkNPPB+6+gWV/OdY
         a5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zG3mnlMzXlGBZxlf0Y8ENqb/pBbJWa2jCQq9nQMLe4=;
        b=XmBKyX8tLeMi4dkQIuWQXVjhbhb2ZmJNqAACjwyCbcFsAWh/qe2gpLpsky72VJ+suy
         kFKGGUWw73ilGfWnNGNiUvAHqI1lz93K6FXnmIJmVUotCu5einkoBEyDmH3ZXmIMESmR
         9DzzTIKSbwJ2Kh9SRkR2e4E7P50PQVoSIVpkGfco8vKYVT3uk6VYIhxzhflscNXyTEC2
         WyV2WkKb5NFIqHU2xksEzDVOi5+yjc29fVXfjXBbQ5kXVJfoc7rLWJ0XFr/o8zJT6Zx7
         wgq249dcbFAobf/B9O69RmvjyGnOuaIZ7FQzu46BMji/KCVqLbcsnaUOrZAT+PF87/iN
         xfzA==
X-Gm-Message-State: AElRT7Gctn8KRfWpwedAM1W6Y+ombIR1nZ3K4uuJf8ToWYmnjXV+I9MY
        7DzOc+Msws/5Ke5gR3zHaHAxVg==
X-Google-Smtp-Source: AG47ELvE2zy9m7KuJAa1BIMLAZhy45ba8rgo94wjuxd+S7n10h+m7BUweTPgsEGP2FLUMmQv5yW1+Q==
X-Received: by 10.46.54.10 with SMTP id d10mr14141457lja.31.1521873246059;
        Fri, 23 Mar 2018 23:34:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 00/13] nd/pack-objects-pack-struct updates
Date:   Sat, 24 Mar 2018 07:33:40 +0100
Message-Id: <20180324063353.24722-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180318142526.9378-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phew.. pack-objects is tough to crack. v7 changes

- the 16k pack limit is removed thanks to Jeff suggestion. The limit
  for memory saving though is reduced down to 1k again.
- only object size below 2G is cached (previously 4G) to avoid 1 << 32
  on 32 bits.
- fix oe_size() retrieving wrong size (e.g. if entry->type is a delta
  then it must return delta size not canonical size)
- fix race condition when oe_size() (and oe_delta_size()) accesses
  object database in parallel try_delta code.
- add new GIT_TEST_ vars so that we use the whole test suite to
  exercise these hard-to-activate code paths.
- I finally fixed the "compressed" typo!

I'm not ignoring or forgetting other suggestions in this thread. the
rev-list thing is still on my todo list (either do it externally or
free up mem as Jeff suggested). revindex as well. But those can be
done later.

Interdiff

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index b8d936ccf5..3503c9e3e6 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -269,15 +269,6 @@ Unexpected missing object will raise an error.
 	locally created objects [without .promisor] and objects from the
 	promisor remote [with .promisor].)  This is used with partial clone.
 
-LIMITATIONS
------------
-
-This command could only handle 16384 existing pack files at a time.
-If you have more than this, you need to exclude some pack files with
-".keep" file and --honor-pack-keep option, to combine 16k pack files
-in one, then remove these .keep files and run pack-objects one more
-time.
-
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4406af640f..c774821930 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -30,6 +30,8 @@
 #include "packfile.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+#define SIZE(obj) oe_size(&to_pack, obj)
+#define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
 #define DELTA_SIZE(obj) oe_delta_size(&to_pack, obj)
 #define DELTA(obj) oe_delta(&to_pack, obj)
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
@@ -276,7 +278,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 
 	if (!usable_delta) {
 		if (oe_type(entry) == OBJ_BLOB &&
-		    oe_size_greater_than(entry, big_file_threshold) &&
+		    oe_size_greater_than(&to_pack, entry, big_file_threshold) &&
 		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
@@ -386,7 +388,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
-	unsigned long entry_size = oe_size(entry);
+	unsigned long entry_size = SIZE(entry);
 
 	if (DELTA(entry))
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
@@ -1036,7 +1038,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (*found_pack) {
 		want = want_found_object(exclude, *found_pack);
 		if (want != -1)
-			goto done;
+			return want;
 	}
 
 	list_for_each(pos, &packed_git_mru) {
@@ -1059,16 +1061,11 @@ static int want_object_in_pack(const struct object_id *oid,
 			if (!exclude && want > 0)
 				list_move(&p->mru, &packed_git_mru);
 			if (want != -1)
-				goto done;
+				return want;
 		}
 	}
 
-	want = 1;
-done:
-	if (want && *found_pack && !(*found_pack)->index)
-		oe_add_pack(&to_pack, *found_pack);
-
-	return want;
+	return 1;
 }
 
 static void create_object_entry(const struct object_id *oid,
@@ -1090,7 +1087,7 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		oe_set_in_pack(entry, found_pack);
+		oe_set_in_pack(&to_pack, entry, found_pack);
 		entry->in_pack_offset = found_offset;
 	}
 
@@ -1415,7 +1412,7 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
-	unsigned long size;
+	unsigned long canonical_size;
 
 	if (IN_PACK(entry)) {
 		struct packed_git *p = IN_PACK(entry);
@@ -1427,6 +1424,7 @@ static void check_object(struct object_entry *entry)
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
+		unsigned long in_pack_size;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1436,14 +1434,13 @@ static void check_object(struct object_entry *entry)
 		 */
 		used = unpack_object_header_buffer(buf, avail,
 						   &type,
-						   &size);
+						   &in_pack_size);
 		if (used == 0)
 			goto give_up;
 
 		if (type < 0)
 			die("BUG: invalid type %d", type);
 		entry->in_pack_type = type;
-		oe_set_size(entry, size);
 
 		/*
 		 * Determine if this is a delta and if so whether we can
@@ -1454,6 +1451,7 @@ static void check_object(struct object_entry *entry)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
+			SET_SIZE(entry, in_pack_size);
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -1510,8 +1508,9 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			oe_set_type(entry, entry->in_pack_type);
+			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA(entry, base_entry);
-			SET_DELTA_SIZE(entry, oe_size(entry));
+			SET_DELTA_SIZE(entry, in_pack_size);
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1519,18 +1518,18 @@ static void check_object(struct object_entry *entry)
 		}
 
 		if (oe_type(entry)) {
-			unsigned long size;
+			off_t delta_pos;
 
-			size = get_size_from_delta(p, &w_curs,
-				entry->in_pack_offset + entry->in_pack_header_size);
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
 			 * object size from the delta header.
 			 */
-			oe_set_size(entry, size);
-			if (oe_size_less_than(entry, 1))
+			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
+			canonical_size = get_size_from_delta(p, &w_curs, delta_pos);
+			if (canonical_size == 0)
 				goto give_up;
+			SET_SIZE(entry, canonical_size);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1544,15 +1543,18 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash, &size));
-	/*
-	 * The error condition is checked in prepare_pack().  This is
-	 * to permit a missing preferred base object to be ignored
-	 * as a preferred base.  Doing so can result in a larger
-	 * pack file, but the transfer will still take place.
-	 */
-	if (entry->type_valid)
-		oe_set_size(entry, size);
+	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
+					    &canonical_size));
+	if (entry->type_valid) {
+		SET_SIZE(entry, canonical_size);
+	} else {
+		/*
+		 * Bad object type is checked in prepare_pack().  This is
+		 * to permit a missing preferred base object to be ignored
+		 * as a preferred base.  Doing so can result in a larger
+		 * pack file, but the transfer will still take place.
+		 */
+	}
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
@@ -1619,7 +1621,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	} else {
 		oe_set_type(entry, type);
 	}
-	oe_set_size(entry, size);
+	SET_SIZE(entry, size);
 }
 
 /*
@@ -1759,7 +1761,8 @@ static void get_object_details(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
-		if (oe_size_greater_than(entry, big_file_threshold))
+		if (entry->type_valid &&
+		    oe_size_greater_than(&to_pack, entry, big_file_threshold))
 			entry->no_try_delta = 1;
 	}
 
@@ -1788,8 +1791,8 @@ static int type_size_sort(const void *_a, const void *_b)
 	const struct object_entry *b = *(struct object_entry **)_b;
 	enum object_type a_type = oe_type(a);
 	enum object_type b_type = oe_type(b);
-	unsigned long a_size = oe_size(a);
-	unsigned long b_size = oe_size(b);
+	unsigned long a_size = SIZE(a);
+	unsigned long b_size = SIZE(b);
 
 	if (a_type > b_type)
 		return -1;
@@ -1858,6 +1861,41 @@ static pthread_mutex_t progress_mutex;
 
 #endif
 
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e)
+{
+	struct packed_git *p;
+	struct pack_window *w_curs;
+	unsigned char *buf;
+	enum object_type type;
+	unsigned long used, avail, size;
+
+	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
+		read_lock();
+		if (sha1_object_info(e->idx.oid.hash, &size) < 0)
+			die(_("unable to get size of %s"),
+			    oid_to_hex(&e->idx.oid));
+		read_unlock();
+		return size;
+	}
+
+	p = oe_in_pack(pack, e);
+	if (!p)
+		die("BUG: when e->type is a delta, it must belong to a pack");
+
+	read_lock();
+	w_curs = NULL;
+	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
+	used = unpack_object_header_buffer(buf, avail, &type, &size);
+	if (used == 0)
+		die(_("unable to parse object header of %s"),
+		    oid_to_hex(&e->idx.oid));
+
+	unuse_pack(&w_curs);
+	read_unlock();
+	return size;
+}
+
 static int try_delta(struct unpacked *trg, struct unpacked *src,
 		     unsigned max_depth, unsigned long *mem_usage)
 {
@@ -1892,7 +1930,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Now some size filtering heuristics. */
-	trg_size = oe_size(trg_entry);
+	trg_size = SIZE(trg_entry);
 	if (!DELTA(trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
@@ -1904,7 +1942,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
-	src_size = oe_size(src_entry);
+	src_size = SIZE(src_entry);
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
@@ -2026,7 +2064,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-		freed_mem += oe_size(n->entry);
+		freed_mem += SIZE(n->entry);
 		FREE_AND_NULL(n->data);
 	}
 	n->entry = NULL;
@@ -2476,7 +2514,8 @@ static void prepare_pack(int window, int depth)
 			 */
 			continue;
 
-		if (oe_size_less_than(entry, 50))
+		if (!entry->type_valid ||
+		    oe_size_less_than(&to_pack, entry, 50))
 			continue;
 
 		if (entry->no_try_delta)
@@ -3235,9 +3274,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/* make sure IN_PACK(0) return NULL */
-	oe_add_pack(&to_pack, NULL);
-
 	if (progress)
 		progress_state = start_progress(_("Counting objects"), 0);
 	if (!use_internal_rev_list)
diff --git a/pack-objects.c b/pack-objects.c
index 9558d13834..59c6e40a02 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -2,6 +2,7 @@
 #include "object.h"
 #include "pack.h"
 #include "pack-objects.h"
+#include "packfile.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const unsigned char *sha1,
@@ -86,15 +87,54 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 	return &pdata->objects[pdata->index[i] - 1];
 }
 
+static void prepare_in_pack_by_idx(struct packing_data *pdata)
+{
+	struct packed_git **mapping, *p;
+	int cnt = 0, nr = 1 << OE_IN_PACK_BITS;
+
+	if (getenv("GIT_TEST_FULL_IN_PACK_ARRAY")) {
+		/*
+		 * leave in_pack_by_idx NULL to force in_pack[] to be
+		 * used instead
+		 */
+		return;
+	}
+
+	ALLOC_ARRAY(mapping, nr);
+	mapping[cnt++] = NULL; /* zero index must be mapped to NULL */
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next, cnt++) {
+		if (cnt == nr) {
+			free(mapping);
+			return;
+		}
+		p->index = cnt;
+		mapping[cnt] = p;
+	}
+	pdata->in_pack_by_idx = mapping;
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos)
 {
 	struct object_entry *new_entry;
 
+	if (!pdata->nr_objects) {
+		prepare_in_pack_by_idx(pdata);
+		if (getenv("GIT_TEST_OE_SIZE_BITS")) {
+			int bits = atoi(getenv("GIT_TEST_OE_SIZE_BITS"));;
+			pdata->oe_size_limit = 1 << bits;
+		}
+		if (!pdata->oe_size_limit)
+			pdata->oe_size_limit = 1 << OE_SIZE_BITS;
+	}
 	if (pdata->nr_objects >= pdata->nr_alloc) {
 		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
 		REALLOC_ARRAY(pdata->objects, pdata->nr_alloc);
+
+		if (!pdata->in_pack_by_idx)
+			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -107,5 +147,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	else
 		pdata->index[index_pos] = pdata->nr_objects;
 
+	if (pdata->in_pack)
+		pdata->in_pack[pdata->nr_objects - 1] = NULL;
+
 	return new_entry;
 }
diff --git a/pack-objects.h b/pack-objects.h
index af40211105..9f19672602 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,8 +3,9 @@
 
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
-#define OE_IN_PACK_BITS		14
+#define OE_IN_PACK_BITS		10
 #define OE_Z_DELTA_BITS		16
+#define OE_SIZE_BITS		31
 #define OE_DELTA_SIZE_BITS	31
 
 /*
@@ -35,7 +36,9 @@ enum dfs_state {
  *
  * "size" is the uncompressed object size. Compressed size of the raw
  * data for an object in a pack is not stored anywhere but is computed
- * and made available when reverse .idx is made.
+ * and made available when reverse .idx is made. Note that when an
+ * delta is reused, "size" is the uncompressed _delta_ size, not the
+ * canonical one after the delta has been applied.
  *
  * "hash" contains a path name hash which is used for sorting the
  * delta list and also during delta searching. Once prepare_pack()
@@ -74,7 +77,8 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	off_t in_pack_offset;
 	uint32_t hash;			/* name hint hash */
-	uint32_t size_;	/* object uncompressed size _if_ size_valid is true */
+	uint32_t size_:OE_SIZE_BITS;
+	unsigned size_valid:1;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
@@ -83,24 +87,23 @@ struct object_entry {
 	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	uint32_t delta_size_valid:1;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
-	unsigned size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_valid:1;
 	unsigned type_:TYPE_BITS;
+	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
 				    * objects against.
 				    */
-	unsigned no_try_delta:1;
-	unsigned char in_pack_header_size;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 80, bit_padding: 16 bits */
+	/* size: 80, bit_padding: 20 bits, holes: 1 bit */
 };
 
 struct packing_data {
@@ -111,8 +114,17 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
-	int in_pack_count;
-	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
+
+	/*
+	 * Only one of these can be non-NULL and they have different
+	 * sizes. if in_pack_by_idx is allocated, oe_in_pack() returns
+	 * the pack of an object using in_pack_idx field. If not,
+	 * in_pack[] array is used the same way as in_pack_pos[]
+	 */
+	struct packed_git **in_pack_by_idx;
+	struct packed_git **in_pack;
+
+	uintmax_t oe_size_limit;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -171,38 +183,27 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
 	pack->in_pack_pos[e - pack->objects] = pos;
 }
 
-static inline unsigned int oe_add_pack(struct packing_data *pack,
-				       struct packed_git *p)
-{
-	if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS))
-		die(_("too many packs to handle in one go. "
-		      "Please add .keep files to exclude\n"
-		      "some pack files and keep the number "
-		      "of non-kept files below %d."),
-		    1 << OE_IN_PACK_BITS);
-	if (p) {
-		if (p->index > 0)
-			die("BUG: this packed is already indexed");
-		p->index = pack->in_pack_count;
-	}
-	pack->in_pack[pack->in_pack_count] = p;
-	return pack->in_pack_count++;
-}
-
 static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
 					    const struct object_entry *e)
 {
-	return pack->in_pack[e->in_pack_idx];
+	if (pack->in_pack_by_idx)
+		return pack->in_pack_by_idx[e->in_pack_idx];
+	else
+		return pack->in_pack[e - pack->objects];
 
 }
 
-static inline void oe_set_in_pack(struct object_entry *e,
+static inline void oe_set_in_pack(struct packing_data *pack,
+				  struct object_entry *e,
 				  struct packed_git *p)
 {
-	if (p->index <= 0)
-		die("BUG: found_pack should be NULL "
-		    "instead of having non-positive index");
-	e->in_pack_idx = p->index;
+	if (pack->in_pack_by_idx) {
+		if (p->index <= 0)
+			die("BUG: found_pack should be NULL "
+					"instead of having non-positive index");
+			e->in_pack_idx = p->index;
+	} else
+		pack->in_pack[e - pack->objects] = p;
 
 }
 
@@ -263,56 +264,49 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
 		e->delta_sibling_idx = 0;
 }
 
-static inline unsigned long oe_size(const struct object_entry *e)
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e);
+static inline unsigned long oe_size(struct packing_data *pack,
+				    const struct object_entry *e)
 {
-	if (e->size_valid) {
+	if (e->size_valid)
 		return e->size_;
-	} else {
-		unsigned long size;
 
-		sha1_object_info(e->idx.oid.hash, &size);
-		return size;
-	}
+	return oe_get_size_slow(pack, e);
 }
 
-static inline int oe_fits_in_32bits(unsigned long limit)
+static inline int oe_size_less_than(struct packing_data *pack,
+				    const struct object_entry *lhs,
+				    unsigned long rhs)
 {
-	uint32_t truncated_limit = (uint32_t)limit;
-
-	return limit == truncated_limit;
-}
-
-static inline int oe_size_less_than(const struct object_entry *e,
-				    unsigned long limit)
-{
-	if (e->size_valid)
-		return e->size_ < limit;
-	if (oe_fits_in_32bits(limit)) /* limit < 2^32 <= size ? */
+	if (lhs->size_valid)
+		return lhs->size_ < rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
 		return 0;
-	return oe_size(e) < limit;
+	return oe_get_size_slow(pack, lhs) < rhs;
 }
 
-static inline int oe_size_greater_than(const struct object_entry *e,
-				       unsigned long limit)
+static inline int oe_size_greater_than(struct packing_data *pack,
+				       const struct object_entry *lhs,
+				       unsigned long rhs)
 {
-	if (e->size_valid)
-		return e->size_ > limit;
-	if (oe_fits_in_32bits(limit)) /* limit < 2^32 <= size ? */
+	if (lhs->size_valid)
+		return lhs->size_ > rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
 		return 1;
-	return oe_size(e) > limit;
+	return oe_get_size_slow(pack, lhs) > rhs;
 }
 
-static inline void oe_set_size(struct object_entry *e,
+static inline void oe_set_size(struct packing_data *pack,
+			       struct object_entry *e,
 			       unsigned long size)
 {
-	e->size_ = size;
-	e->size_valid = e->size_ == size;
-
-	if (!e->size_valid) {
-		unsigned long real_size;
-
-		if (sha1_object_info(e->idx.oid.hash, &real_size) < 0 ||
-		    size != real_size)
+	if (size < pack->oe_size_limit) {
+		e->size_ = size;
+		e->size_valid = 1;
+	} else {
+		e->size_valid = 0;
+		if (oe_get_size_slow(pack, e) != size)
 			die("BUG: 'size' is supposed to be the object size!");
 	}
 }
@@ -322,7 +316,7 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
 {
 	if (e->delta_size_valid)
 		return e->delta_size_;
-	return oe_size(e);
+	return oe_size(pack, e);
 }
 
 static inline void oe_set_delta_size(struct packing_data *pack,
@@ -331,7 +325,7 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 {
 	e->delta_size_ = size;
 	e->delta_size_valid = e->delta_size_ == size;
-	if (!e->delta_size_valid && size != oe_size(e))
+	if (!e->delta_size_valid && size != oe_size(pack, e))
 		die("BUG: this can only happen in check_object() "
 		    "where delta size is the same as entry size");
 }
diff --git a/t/README b/t/README
index 1a1361a806..da117ca734 100644
--- a/t/README
+++ b/t/README
@@ -292,6 +292,26 @@ and know what setup is needed for it.  Or when you want to run
 everything up to a certain test.
 
 
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
+GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
+path where there are more than 1024 packs even if the actual number of
+packs in repository is below this limit.
+
+GIT_TEST_OE_SIZE_BITS=<bits> exercises the uncommon pack-objects
+code path where we do not cache objecct size in memory and read it
+from existing packs on demand. This normally only happens when the
+object size is over 2GB. This variable forces the code path on any
+object larger than 2^<bits> bytes.
+
 Naming Tests
 ------------
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9c68b99251..5c076637ff 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -457,6 +457,11 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 	grep -F "no threads support, ignoring pack.threads" err
 '
 
+test_expect_success 'pack-objects in too-many-packs mode' '
+	GIT_TEST_FULL_IN_PACK_ARRAY=1 git repack -ad &&
+	git fsck
+'
+
 #
 # WARNING!
 #

Nguyễn Thái Ngọc Duy (13):
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

 Documentation/config.txt           |   4 +-
 Documentation/git-pack-objects.txt |   4 +-
 Documentation/git-repack.txt       |   4 +-
 builtin/pack-objects.c             | 353 +++++++++++++++++++----------
 cache.h                            |   3 +
 object.h                           |   1 -
 pack-bitmap-write.c                |  14 +-
 pack-bitmap.c                      |   2 +-
 pack-bitmap.h                      |   4 +-
 pack-objects.c                     |  43 ++++
 pack-objects.h                     | 306 ++++++++++++++++++++++---
 t/README                           |  10 +
 t/t5300-pack-object.sh             |   5 +
 13 files changed, 588 insertions(+), 165 deletions(-)

-- 
2.17.0.rc0.348.gd5a49e0b6f

