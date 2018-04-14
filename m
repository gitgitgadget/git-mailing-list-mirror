Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1C01F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeDNPgO (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:36:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46759 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeDNPfa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id j68-v6so16378396lfg.13
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5ChEOJ5qWP6TeL1GnXsbg3tVZ3ikZcob9pTSuTK2VI=;
        b=Rz0kyFvi9bRQy/uRgJPuejulWB8WbWWEUT+0RLBPKuxztVQAoU/YiHHa+66vOdvKon
         nuG1zsjKHKZmX6Cr3CfLhTwOiSog9Jsqi3Eg0uGaHzoZzitXFvFRvDctk8z1wn3bol/k
         hYkOZn/YQSSp5+2yK6ziaYvmljuFAkywvaClNyyqY4/A53lohNiJk+J0p/60MvqlJpgh
         lyKpv94nNqdCYWtbd/zR4Ey5fxK6OEid/LY+fVl2Bvi/yiQhUkJDMVFR/nN9rHYKr+Hy
         VHqY7+I/68+/undGu18D9VPkR0vEmnUMb/dZFQmYUxN7SQWXNvC85/naPfsbgGs7Jfha
         44ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5ChEOJ5qWP6TeL1GnXsbg3tVZ3ikZcob9pTSuTK2VI=;
        b=OamkI8vnFw0+WfKRjXG1YsfQrTvb6RdDJKFPpXq/zaqyr7PsRKjVDSIjTpVGv9cekH
         9ZzIaPGS3c04o87Hx3h//afS4b1NtWTsRIyWfl6u1aSHrADezweWU+YbCYazoZy4P2ru
         PXaTVGCWxH0aSk0A7AA+7bSsEmKFjlzr/mHrri8yqjqH9j16WzugbLOQFUgHaolvvC+z
         +6nuqoS0sykwtS0/jn7IeewPL4h/StbKjUTu9ymAamHqtcC6aRpAEk2AXKRTr87URD8V
         r0y9Cp+FLsdjOKv+Ymj0Zrt7wv1oGpPywlk9B1/apmnzwCExZrmHVFqbdF0E72c2oqCH
         zmQA==
X-Gm-Message-State: ALQs6tA9h2F1u7rCrEdjYlbItd3gyq0FcGt9pB1njeIeKVy/zzIbPL1I
        s8uwMrWqNhgn45bd/eicLkYNqw==
X-Google-Smtp-Source: AIpwx49yjjNXog4s8LNPyDN9qQABdcu1jfc6rBCklu3w2qeieEZRzZUnZ1y4dBRkdeBKDC701k098g==
X-Received: by 2002:a19:e90f:: with SMTP id g15-v6mr11155377lfh.0.1523720128591;
        Sat, 14 Apr 2018 08:35:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/15] pack-objects: turn type and in_pack_type to bitfields
Date:   Sat, 14 Apr 2018 17:35:01 +0200
Message-Id: <20180414153513.9902-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An extra field type_valid is added to carry the equivalent of OBJ_BAD
in the original "type" field. in_pack_type always contains a valid
type so we only need 3 bits for it.

A note about accepting OBJ_NONE as "valid" type. The function
read_object_list_from_stdin() can pass this value [1] and it
eventually calls create_object_entry() where current code skip setting
"type" field if the incoming type is zero. This does not have any bad
side effects because "type" field should be memset()'d anyway.

But since we also need to set type_valid now, skipping oe_set_type()
leaves type_valid zero/false, which will make oe_type() return
OBJ_BAD, not OBJ_NONE anymore. Apparently we do care about OBJ_NONE in
prepare_pack(). This switch from OBJ_NONE to OBJ_BAD may trigger

    fatal: unable to get type of object ...

Accepting OBJ_NONE [2] does sound wrong, but this is how it is has
been for a very long time and I haven't time to dig in further.

[1] See 5c49c11686 (pack-objects: better check_object() performances -
    2007-04-16)

[2] 21666f1aae (convert object type handling from a string to a number
    - 2007-02-26)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 59 +++++++++++++++++++++++++-----------------
 cache.h                |  2 ++
 object.h               |  1 -
 pack-bitmap-write.c    |  6 ++---
 pack-objects.h         | 20 ++++++++++++--
 5 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4bdae5a1d8..88877f1f59 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,7 +266,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	struct git_istream *st = NULL;
 
 	if (!usable_delta) {
-		if (entry->type == OBJ_BLOB &&
+		if (oe_type(entry) == OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
 		    (st = open_istream(&entry->idx.oid, &type, &size, NULL)) != NULL)
 			buf = NULL;
@@ -371,7 +371,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
-	enum object_type type = entry->type;
+	enum object_type type = oe_type(entry);
 	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
@@ -480,11 +480,12 @@ static off_t write_object(struct hashfile *f,
 		to_reuse = 0;	/* explicit */
 	else if (!entry->in_pack)
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
 	else if (entry->delta)
 		to_reuse = 0;	/* we want to pack afresh */
@@ -705,8 +706,8 @@ static struct object_entry **compute_write_order(void)
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
@@ -715,7 +716,7 @@ static struct object_entry **compute_write_order(void)
 	 * And then all the trees.
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type != OBJ_TREE)
+		if (oe_type(&objects[i]) != OBJ_TREE)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -1066,8 +1067,7 @@ static void create_object_entry(const struct object_id *oid,
 
 	entry = packlist_alloc(&to_pack, oid->hash, index_pos);
 	entry->hash = hash;
-	if (type)
-		entry->type = type;
+	oe_set_type(entry, type);
 	if (exclude)
 		entry->preferred_base = 1;
 	else
@@ -1407,6 +1407,7 @@ static void check_object(struct object_entry *entry)
 		unsigned long avail;
 		off_t ofs;
 		unsigned char *buf, c;
+		enum object_type type;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1415,11 +1416,15 @@ static void check_object(struct object_entry *entry)
 		 * since non-delta representations could still be reused.
 		 */
 		used = unpack_object_header_buffer(buf, avail,
-						   &entry->in_pack_type,
+						   &type,
 						   &entry->size);
 		if (used == 0)
 			goto give_up;
 
+		if (type < 0)
+			BUG("invalid type %d", type);
+		entry->in_pack_type = type;
+
 		/*
 		 * Determine if this is a delta and if so whether we can
 		 * reuse it or not.  Otherwise let's find out as cheaply as
@@ -1428,9 +1433,9 @@ static void check_object(struct object_entry *entry)
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
@@ -1484,7 +1489,7 @@ static void check_object(struct object_entry *entry)
 			 * deltify other objects against, in order to avoid
 			 * circular deltas.
 			 */
-			entry->type = entry->in_pack_type;
+			oe_set_type(entry, entry->in_pack_type);
 			entry->delta = base_entry;
 			entry->delta_size = entry->size;
 			entry->delta_sibling = base_entry->delta_child;
@@ -1493,7 +1498,7 @@ static void check_object(struct object_entry *entry)
 			return;
 		}
 
-		if (entry->type) {
+		if (oe_type(entry)) {
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
@@ -1516,7 +1521,7 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = oid_object_info(&entry->idx.oid, &entry->size);
+	oe_set_type(entry, oid_object_info(&entry->idx.oid, &entry->size));
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1559,6 +1564,7 @@ static void drop_reused_delta(struct object_entry *entry)
 {
 	struct object_entry **p = &entry->delta->delta_child;
 	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
 
 	while (*p) {
 		if (*p == entry)
@@ -1570,15 +1576,18 @@ static void drop_reused_delta(struct object_entry *entry)
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
-	oi.typep = &entry->type;
+	oi.typep = &type;
 	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
-		 * And if that fails, the error will be recorded in entry->type
+		 * And if that fails, the error will be recorded in oe_type(entry)
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = oid_object_info(&entry->idx.oid, &entry->size);
+		oe_set_type(entry, oid_object_info(&entry->idx.oid,
+						   &entry->size));
+	} else {
+		oe_set_type(entry, type);
 	}
 }
 
@@ -1746,10 +1755,12 @@ static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
+	enum object_type a_type = oe_type(a);
+	enum object_type b_type = oe_type(b);
 
-	if (a->type > b->type)
+	if (a_type > b_type)
 		return -1;
-	if (a->type < b->type)
+	if (a_type < b_type)
 		return 1;
 	if (a->hash > b->hash)
 		return -1;
@@ -1825,7 +1836,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	void *delta_buf;
 
 	/* Don't bother doing diffs between different types */
-	if (trg_entry->type != src_entry->type)
+	if (oe_type(trg_entry) != oe_type(src_entry))
 		return -1;
 
 	/*
@@ -2429,11 +2440,11 @@ static void prepare_pack(int window, int depth)
 
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
@@ -2542,7 +2553,7 @@ static void read_object_list_from_stdin(void)
 			die("expected object ID, got garbage:\n %s", line);
 
 		add_preferred_base_object(p + 1);
-		add_object_entry(&oid, 0, p + 1, 0);
+		add_object_entry(&oid, OBJ_NONE, p + 1, 0);
 	}
 }
 
diff --git a/cache.h b/cache.h
index bbaf5c349a..543bb42ce8 100644
--- a/cache.h
+++ b/cache.h
@@ -373,6 +373,8 @@ extern void free_name_hash(struct index_state *istate);
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #endif
 
+#define TYPE_BITS 3
+
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
diff --git a/object.h b/object.h
index f13f85b2a9..3d305fe868 100644
--- a/object.h
+++ b/object.h
@@ -25,7 +25,6 @@ struct object_array {
 
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
-#define TYPE_BITS   3
 /*
  * object flag allocation:
  * revision.h:               0---------10                                26
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 41ae27fb19..2df7b3e144 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -64,12 +64,12 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 
 		entry->in_pack_pos = i;
 
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
@@ -97,7 +97,7 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 		default:
 			die("Missing type information for %s (%d/%d)",
 			    oid_to_hex(&entry->idx.oid), real_type,
-			    entry->type);
+			    oe_type(entry));
 		}
 	}
 }
diff --git a/pack-objects.h b/pack-objects.h
index c0a1f61aac..b4a83a6123 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -59,8 +59,9 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
+	unsigned type_:TYPE_BITS;
+	unsigned in_pack_type:TYPE_BITS; /* could be delta */
+	unsigned type_valid:1;
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
@@ -123,4 +124,19 @@ static inline uint32_t pack_name_hash(const char *name)
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
+		BUG("OBJ_ANY cannot be set in pack-objects code");
+
+	e->type_valid = type >= OBJ_NONE;
+	e->type_ = (unsigned)type;
+}
+
 #endif
-- 
2.17.0.367.g5dd2e386c3

