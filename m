Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3271F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeCPSco (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:32:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34467 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCPScn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id l191-v6so16763115lfe.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUt8XL7Knv7pL1GSOhKXzRwTrssgvkr4GAcdUzpVzmM=;
        b=erQexn5zJhA2a9UfzHURbwJ6ZWu5rJp7IjevQbr5CQt0ejPWnJAvdfZgqsa/yc7aUB
         dxUblkA/gnnl+ZeS1nYUiGZcOFKcYGLBNxQQDMlq4a27jwybcM2T3SUccfGBOEEj8ToM
         K2J5pV7aIIHm6mqTZYVyBRHYjzusW6GQwKxb+yz/wmUj8e3OogRUHraM+oxRY22yGmPq
         z9kZ7vopVqISPMhd4zTW1PmZvI0gXZqdkPOVaEF8RTlR01tz62+zlJXDy5BuxGqPycus
         5BQzHHa6XbOxr6lTHfS5ikRuDymLEaCav8J3U2vhehWLNbwXvUPOGExjUx9gufdgazkb
         kIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUt8XL7Knv7pL1GSOhKXzRwTrssgvkr4GAcdUzpVzmM=;
        b=DtkvS4r7x6zPnVrmlA7Q44Kr0qWxn6SrZoK8nz7PB5qvZEVebzlpuJFD4wGDPaxPqa
         t8zQseg8fPs6SiqK1jztySTeyB2BK8MDlGeCI47SFtuNfrNCHefJKw5bdTm7Wi18fMH6
         E3jCKAxX1tYNSr53oPw53QWvESQS3SdqhASy0ezjm5vCiTn0ZGD01UVYKowJezTqzkBX
         othy8K/Ih964fFgstl4L/6xUh7vEYiYGFP4e1Pf+Ik8yU4vIKkoXdZOBh7U43w4gnhAl
         U0L2AkPJ5ovauiRRu5p2c7D5lh3fKog+jM2hDzdzzbnw/VuhX2JcC+pd2wuZQQbfkX+8
         cf/w==
X-Gm-Message-State: AElRT7GMYWfr5mFO8tVMK2E/Dk0U32JlybvLXFlU3IZ6KMu25NDHQnb6
        Zt9JzjI0v+LCvOPeQ8N3S5w=
X-Google-Smtp-Source: AG47ELuGdx8dz4DXy9RwVpImn/QYcEsFPJ+9iSCzk3aOS6TlrtSRK9DT3ejp7Mx+axvGrg/5LheZYA==
X-Received: by 10.46.23.202 with SMTP id 71mr2063475ljx.49.1521225160924;
        Fri, 16 Mar 2018 11:32:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 00/11] nd/pack-objects-pack-struct updates
Date:   Fri, 16 Mar 2018 19:31:49 +0100
Message-Id: <20180316183200.31014-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180308114232.10508-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most important change in v4 is it fixes a case where I failed to
propagate an error condition to later code in 02/11. This results in
new wrappers, oe_type() and oe_set_type(). This also reveals another
extra object type, OBJ_NONE, that's also used by pack-objects.

Other changes are comments fixes, commit messages fixes, off-by-one
bugs. No more saving compared to v3.

I also changed my approach a bit. I stop trying to make struct
reduction visible at every patch. All these patches shrink some field
even if the struct size is the same. The reordering and packing
happens at the last patch.

I'm not super happy that many corner cases of my changes are not
covered by the test suite. In many cases it's very hard or expensive
to create the right error condition. If only this code is part of
libgit.a and I could write C unit tests for it...

Interdiff

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0f65e0f243..c388d87c3e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -275,7 +275,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	struct git_istream *st = NULL;
 
 	if (!usable_delta) {
-		if (entry->type == OBJ_BLOB &&
+		if (oe_type(entry) == OBJ_BLOB &&
 		    oe_size_greater_than(entry, big_file_threshold) &&
 		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
@@ -381,7 +381,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
-	enum object_type type = entry->type;
+	enum object_type type = oe_type(entry);
 	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
@@ -491,11 +491,12 @@ static off_t write_object(struct hashfile *f,
 		to_reuse = 0;	/* explicit */
 	else if (!IN_PACK(entry))
 		to_reuse = 0;	/* can't reuse what we don't have */
-	else if (entry->type == OBJ_REF_DELTA || entry->type == OBJ_OFS_DELTA)
+	else if (oe_type(entry) == OBJ_REF_DELTA ||
+		 oe_type(entry) == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
 		to_reuse = usable_delta;
 				/* ... but pack split may override that */
-	else if (entry->type != entry->in_pack_type)
+	else if (oe_type(entry) != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
 	else if (DELTA(entry))
 		to_reuse = 0;	/* we want to pack afresh */
@@ -716,8 +717,8 @@ static struct object_entry **compute_write_order(void)
 	 * And then all remaining commits and tags.
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type != OBJ_COMMIT &&
-		    objects[i].type != OBJ_TAG)
+		if (oe_type(&objects[i]) != OBJ_COMMIT &&
+		    oe_type(&objects[i]) != OBJ_TAG)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -726,7 +727,7 @@ static struct object_entry **compute_write_order(void)
 	 * And then all the trees.
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type != OBJ_TREE)
+		if (oe_type(&objects[i]) != OBJ_TREE)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -1083,8 +1084,7 @@ static void create_object_entry(const struct object_id *oid,
 
 	entry = packlist_alloc(&to_pack, oid->hash, index_pos);
 	entry->hash = hash;
-	if (type)
-		entry->type = type;
+	oe_set_type(entry, type);
 	if (exclude)
 		entry->preferred_base = 1;
 	else
@@ -1453,9 +1453,9 @@ static void check_object(struct object_entry *entry)
 		switch (entry->in_pack_type) {
 		default:
 			/* Not a delta hence we've already got all we need. */
-			entry->type = entry->in_pack_type;
+			oe_set_type(entry, entry->in_pack_type);
 			entry->in_pack_header_size = used;
-			if (entry->type < OBJ_COMMIT || entry->type > OBJ_BLOB)
+			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
 			unuse_pack(&w_curs);
 			return;
@@ -1509,7 +1509,7 @@ static void check_object(struct object_entry *entry)
 			 * deltify other objects against, in order to avoid
 			 * circular deltas.
 			 */
-			entry->type = entry->in_pack_type;
+			oe_set_type(entry, entry->in_pack_type);
 			SET_DELTA(entry, base_entry);
 			SET_DELTA_SIZE(entry, oe_size(entry));
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
@@ -1518,7 +1518,7 @@ static void check_object(struct object_entry *entry)
 			return;
 		}
 
-		if (entry->type) {
+		if (oe_type(entry)) {
 			unsigned long size;
 
 			size = get_size_from_delta(p, &w_curs,
@@ -1544,14 +1544,15 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->idx.oid.hash, &size);
+	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash, &size));
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
 	 * as a preferred base.  Doing so can result in a larger
 	 * pack file, but the transfer will still take place.
 	 */
-	oe_set_size(entry, size);
+	if (entry->type_valid)
+		oe_set_size(entry, size);
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
@@ -1613,15 +1614,12 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in entry->type
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = sha1_object_info(entry->idx.oid.hash,
-					       &size);
-		oe_set_size(entry, size);
+		oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
+						    &size));
 	} else {
-		if (type < 0)
-			die("BUG: invalid type %d", type);
-		entry->type = type;
-		oe_set_size(entry, size);
+		oe_set_type(entry, type);
 	}
+	oe_set_size(entry, size);
 }
 
 /*
@@ -1788,12 +1786,14 @@ static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
+	enum object_type a_type = oe_type(a);
+	enum object_type b_type = oe_type(b);
 	unsigned long a_size = oe_size(a);
 	unsigned long b_size = oe_size(b);
 
-	if (a->type > b->type)
+	if (a_type > b_type)
 		return -1;
-	if (a->type < b->type)
+	if (a_type < b_type)
 		return 1;
 	if (a->hash > b->hash)
 		return -1;
@@ -1869,7 +1869,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	void *delta_buf;
 
 	/* Don't bother doing diffs between different types */
-	if (trg_entry->type != src_entry->type)
+	if (oe_type(trg_entry) != oe_type(src_entry))
 		return -1;
 
 	/*
@@ -2484,11 +2484,11 @@ static void prepare_pack(int window, int depth)
 
 		if (!entry->preferred_base) {
 			nr_deltas++;
-			if (entry->type < 0)
+			if (oe_type(entry) < 0)
 				die("unable to get type of object %s",
 				    oid_to_hex(&entry->idx.oid));
 		} else {
-			if (entry->type < 0) {
+			if (oe_type(entry) < 0) {
 				/*
 				 * This object is not found, but we
 				 * don't have to include it anyway.
@@ -2597,7 +2597,7 @@ static void read_object_list_from_stdin(void)
 			die("expected object ID, got garbage:\n %s", line);
 
 		add_preferred_base_object(p + 1);
-		add_object_entry(&oid, 0, p + 1, 0);
+		add_object_entry(&oid, OBJ_NONE, p + 1, 0);
 	}
 }
 
@@ -3110,7 +3110,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
-	if (depth > (1 << OE_DEPTH_BITS))
+	if (depth >= (1 << OE_DEPTH_BITS))
 		die(_("delta chain depth %d is greater than maximum limit %d"),
 		    depth, (1 << OE_DEPTH_BITS));
 	if (cache_max_small_delta_size >= (1 << OE_Z_DELTA_BITS))
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 256a63f892..f7c897515b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -66,12 +66,12 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 
 		oe_set_in_pack_pos(to_pack, entry, i);
 
-		switch (entry->type) {
+		switch (oe_type(entry)) {
 		case OBJ_COMMIT:
 		case OBJ_TREE:
 		case OBJ_BLOB:
 		case OBJ_TAG:
-			real_type = entry->type;
+			real_type = oe_type(entry);
 			break;
 
 		default:
@@ -100,7 +100,7 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 		default:
 			die("Missing type information for %s (%d/%d)",
 			    oid_to_hex(&entry->idx.oid), real_type,
-			    entry->type);
+			    oe_type(entry));
 		}
 	}
 }
diff --git a/pack-objects.h b/pack-objects.h
index 1a159aba37..0fa0c83294 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -28,7 +28,7 @@ enum dfs_state {
  * basic object info
  * -----------------
  * idx.oid is filled up before delta searching starts. idx.crc32 and
- * is only valid after the object is written down and will be used for
+ * is only valid after the object is written out and will be used for
  * generating the index. idx.offset will be both gradually set and
  * used in writing phase (base objects get offset first, then deltas
  * refer to them)
@@ -59,8 +59,8 @@ enum dfs_state {
  * compute_write_order(). "delta" and "delta_size" must remain valid
  * at object writing phase in case the delta is not cached.
  *
- * If a delta is cached in memory and is compressed delta points to
- * the data and z_delta_size contains the compressed size. If it's
+ * If a delta is cached in memory and is compressed delta_data points
+ * to the data and z_delta_size contains the compressed size. If it's
  * uncompressed [1], z_delta_size must be zero. delta_size is always
  * the uncompressed size and must be valid even if the delta is not
  * cached.
@@ -70,23 +70,22 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	/* object uncompressed size _if_ size_valid is true */
-	uint32_t size_;
+	void *delta_data;	/* cached delta (uncompressed) */
 	off_t in_pack_offset;
+	uint32_t hash;			/* name hint hash */
+	uint32_t size_;	/* object uncompressed size _if_ size_valid is true */
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	uint32_t hash;			/* name hint hash */
-	void *delta_data;	/* cached delta (uncompressed) */
-	/* object uncompressed size _if_ size_valid is true */
-	uint32_t size;
-	uint32_t delta_size_:OE_DELTA_SIZE_BITS;	/* delta data size (uncompressed) */
+	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	uint32_t delta_size_valid:1;
-	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
-	unsigned type:TYPE_BITS;
+	unsigned size_valid:1;
+	unsigned z_delta_size:OE_Z_DELTA_BITS;
+	unsigned type_valid:1;
+	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
@@ -94,21 +93,13 @@ struct object_entry {
 				    * objects against.
 				    */
 	unsigned no_try_delta:1;
+	unsigned char in_pack_header_size;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
-	unsigned size_valid:1;
-
-	/* XXX 8 bits hole, try to pack */
-
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
-	/*
-	 * if delta_data contains a compressed delta, this contains
-	 * the compressed length
-	*/
-	unsigned z_delta_size:OE_Z_DELTA_BITS;
 
-	/* size: 80, bit_padding: 1 bits */
+	/* size: 80, bit_padding: 16 bits */
 };
 
 struct packing_data {
@@ -151,6 +142,21 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline enum object_type oe_type(const struct object_entry *e)
+{
+	return e->type_valid ? e->type_ : OBJ_BAD;
+}
+
+static inline void oe_set_type(struct object_entry *e,
+			       enum object_type type)
+{
+	if (type >= OBJ_ANY)
+		die("BUG: OBJ_ANY cannot be set in pack-objects code");
+
+	e->type_valid = type >= OBJ_NONE;
+	e->type_ = (unsigned)type;
+}
+
 static inline unsigned int oe_in_pack_pos(const struct packing_data *pack,
 					  const struct object_entry *e)
 {
-- 8< --

Nguyễn Thái Ngọc Duy (11):
  pack-objects: a bit of document about struct object_entry
  pack-objects: turn type and in_pack_type to bitfields
  pack-objects: use bitfield for object_entry::dfs_state
  pack-objects: use bitfield for object_entry::depth
  pack-objects: move in_pack_pos out of struct object_entry
  pack-objects: move in_pack out of struct object_entry
  pack-objects: refer to delta objects by index instead of pointer
  pack-objects: shrink z_delta_size field in struct object_entry
  pack-objects: shrink size field in struct object_entry
  pack-objects: shrink delta_size field in struct object_entry
  pack-objects.h: reorder members to shrink struct object_entry

 Documentation/config.txt           |   4 +-
 Documentation/git-pack-objects.txt |  13 +-
 Documentation/git-repack.txt       |   4 +-
 builtin/pack-objects.c             | 309 +++++++++++++++++------------
 cache.h                            |   3 +
 object.h                           |   1 -
 pack-bitmap-write.c                |  14 +-
 pack-bitmap.c                      |   2 +-
 pack-bitmap.h                      |   4 +-
 pack-objects.h                     | 294 ++++++++++++++++++++++++---
 10 files changed, 488 insertions(+), 160 deletions(-)

-- 
2.16.2.903.gd04caf5039

