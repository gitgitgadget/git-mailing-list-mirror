Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACAB21F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeDNPgB (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:36:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37186 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDNPfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id m200-v6so16389625lfm.4
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3K6FzxqMHkrOs7yaPvMe1DKmIgqaWDL27x6TTKUwOm4=;
        b=CtfFA+nYQxJhX12gHk3J/u1mcD4HuuFwi9QluZAhpHBS1f3DCENUDqn8WxjpekzMSh
         5nVs8z9pIWn2L+U/V6qLhKdMqr3emstz2jInGFZrI6nmL5ef8sP5rM2FH9+DBX8azcuY
         JtWU6vT8ZEdWgPCz1bwpuCL2Btp7dqNtDP7NAw7HGJa37A5F7WPCSol9gHbTDh2cK9qx
         H5vVk/1BFIPTF1R+RpQ4P6tE2gdixyQzUdZYSQBzC3mQYQN29YvoHYOx4gQnsjrcmcie
         ciqL6V24bDLOTMICkKkw/er5zREPF7UsyKboyt7cZUElSTVNB9RqzrC0THD19f5XD7ED
         DGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3K6FzxqMHkrOs7yaPvMe1DKmIgqaWDL27x6TTKUwOm4=;
        b=SYBsH1FxpAI9/xNz5qtgvR74IVozvZhupNa9/8aF9ZT502hLybWSsp35ZCS73FzCjg
         2mbl0SQKEIt29a++OA2WRNGUdpuMltc5EZMOUZ1UwpvlIKVA5MZS4Y6pMHOpmlTHcgmE
         ++ALgeFIt86b5Gh0TIhc4qEneCtPvataDtpb0iF9kAv40K3Ep/yEWFxesNAtbJQ64UvN
         uUCGujwpSW1lopYx9QzV03Ggt21hNc5aR42AqbrPr8paJVXEPxqtZFMoZvxr6WpYAX06
         SAgUnrmKCA363J5l8TdAU1mw0hbWSLlvIeCO+SOZguF9uBoSCjlvz5IvXFmY4czH7LIS
         X58Q==
X-Gm-Message-State: ALQs6tC4+W4juRAHrdJPYOdaoRXph4B5EzLh0ATiyUtQWIOGUN+kGeoY
        EP8aXZURARCTDZNrfdG/9EW9jw==
X-Google-Smtp-Source: AIpwx487DS6zy2QKkwTlEu8jzPfHK+cib2D1jjiVF2TMfm2Wit0CW216/uCt+wrUz+1Xn9QjVv/jpg==
X-Received: by 10.46.137.13 with SMTP id d13mr5596299lji.27.1523720139449;
        Sat, 14 Apr 2018 08:35:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/15] pack-objects: shrink size field in struct object_entry
Date:   Sat, 14 Apr 2018 17:35:10 +0200
Message-Id: <20180414153513.9902-13-pclouds@gmail.com>
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

It's very very rare that an uncompressed object is larger than 4GB
(partly because Git does not handle those large files very well to
begin with). Let's optimize it for the common case where object size
is smaller than this limit.

Shrink size field down to 31 bits and one overflow bit. If the size is
too large, we read it back from disk. As noted in the previous patch,
we need to return the delta size instead of canonical size when the
to-be-reused object entry type is a delta instead of a canonical one.

Add two compare helpers that can take advantage of the overflow
bit (e.g. if the file is 4GB+, chances are it's already larger than
core.bigFileThreshold and there's no point in comparing the actual
value).

Another note about oe_get_size_slow(). This function MUST be thread
safe because SIZE() macro is used inside try_delta() which may run in
parallel. Outside parallel code, no-contention locking should be dirt
cheap (or insignificant compared to i/o access anyway). To exercise
this code, it's best to run the test suite with something like

    make test GIT_TEST_OE_SIZE=4

which forces this code on all objects larger than 3 bytes.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 105 +++++++++++++++++++++++++++++++----------
 pack-objects.c         |   3 ++
 pack-objects.h         |  57 +++++++++++++++++++++-
 t/README               |   6 +++
 4 files changed, 145 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 779f14a45e..cccd0f8040 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,6 +32,8 @@
 #include "object-store.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+#define SIZE(obj) oe_size(&to_pack, obj)
+#define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
 #define DELTA(obj) oe_delta(&to_pack, obj)
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
 #define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
@@ -276,7 +278,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 
 	if (!usable_delta) {
 		if (oe_type(entry) == OBJ_BLOB &&
-		    entry->size > big_file_threshold &&
+		    oe_size_greater_than(&to_pack, entry, big_file_threshold) &&
 		    (st = open_istream(&entry->idx.oid, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
@@ -385,12 +387,13 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
+	unsigned long entry_size = SIZE(entry);
 
 	if (DELTA(entry))
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
-					      type, entry->size);
+					      type, entry_size);
 
 	offset = entry->in_pack_offset;
 	revidx = find_pack_revindex(p, offset);
@@ -407,7 +410,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	datalen -= entry->in_pack_header_size;
 
 	if (!pack_to_stdout && p->index_version == 1 &&
-	    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
+	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
 		error("corrupt packed object for %s",
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
@@ -1408,6 +1411,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
+	unsigned long canonical_size;
+
 	if (IN_PACK(entry)) {
 		struct packed_git *p = IN_PACK(entry);
 		struct pack_window *w_curs = NULL;
@@ -1445,7 +1450,7 @@ static void check_object(struct object_entry *entry)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
-			entry->size = in_pack_size;
+			SET_SIZE(entry, in_pack_size);
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -1502,9 +1507,9 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			oe_set_type(entry, entry->in_pack_type);
-			entry->size = in_pack_size; /* delta size */
+			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA(entry, base_entry);
-			entry->delta_size = entry->size;
+			entry->delta_size = in_pack_size;
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1520,9 +1525,10 @@ static void check_object(struct object_entry *entry)
 			 * object size from the delta header.
 			 */
 			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
-			entry->size = get_size_from_delta(p, &w_curs, delta_pos);
-			if (entry->size == 0)
+			canonical_size = get_size_from_delta(p, &w_curs, delta_pos);
+			if (canonical_size == 0)
 				goto give_up;
+			SET_SIZE(entry, canonical_size);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1536,13 +1542,17 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	oe_set_type(entry, oid_object_info(&entry->idx.oid, &entry->size));
-	/*
-	 * The error condition is checked in prepare_pack().  This is
-	 * to permit a missing preferred base object to be ignored
-	 * as a preferred base.  Doing so can result in a larger
-	 * pack file, but the transfer will still take place.
-	 */
+	oe_set_type(entry, oid_object_info(&entry->idx.oid, &canonical_size));
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
@@ -1582,6 +1592,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
+	unsigned long size;
 
 	while (*idx) {
 		struct object_entry *oe = &to_pack.objects[*idx - 1];
@@ -1594,7 +1605,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	SET_DELTA(entry, NULL);
 	entry->depth = 0;
 
-	oi.sizep = &entry->size;
+	oi.sizep = &size;
 	oi.typep = &type;
 	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
@@ -1603,11 +1614,11 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in oe_type(entry)
 		 * and dealt with in prepare_pack().
 		 */
-		oe_set_type(entry, oid_object_info(&entry->idx.oid,
-						   &entry->size));
+		oe_set_type(entry, oid_object_info(&entry->idx.oid, &size));
 	} else {
 		oe_set_type(entry, type);
 	}
+	SET_SIZE(entry, size);
 }
 
 /*
@@ -1747,7 +1758,8 @@ static void get_object_details(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
-		if (entry->type_valid && big_file_threshold < entry->size)
+		if (entry->type_valid &&
+		    oe_size_greater_than(&to_pack, entry, big_file_threshold))
 			entry->no_try_delta = 1;
 	}
 
@@ -1776,6 +1788,8 @@ static int type_size_sort(const void *_a, const void *_b)
 	const struct object_entry *b = *(struct object_entry **)_b;
 	enum object_type a_type = oe_type(a);
 	enum object_type b_type = oe_type(b);
+	unsigned long a_size = SIZE(a);
+	unsigned long b_size = SIZE(b);
 
 	if (a_type > b_type)
 		return -1;
@@ -1789,9 +1803,9 @@ static int type_size_sort(const void *_a, const void *_b)
 		return -1;
 	if (a->preferred_base < b->preferred_base)
 		return 1;
-	if (a->size > b->size)
+	if (a_size > b_size)
 		return -1;
-	if (a->size < b->size)
+	if (a_size < b_size)
 		return 1;
 	return a < b ? -1 : (a > b);  /* newest first */
 }
@@ -1844,6 +1858,46 @@ static pthread_mutex_t progress_mutex;
 
 #endif
 
+/*
+ * Return the size of the object without doing any delta
+ * reconstruction (so non-deltas are true object sizes, but deltas
+ * return the size of the delta data).
+ */
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
+		if (oid_object_info(&e->idx.oid, &size) < 0)
+			die(_("unable to get size of %s"),
+			    oid_to_hex(&e->idx.oid));
+		read_unlock();
+		return size;
+	}
+
+	p = oe_in_pack(pack, e);
+	if (!p)
+		BUG("when e->type is a delta, it must belong to a pack");
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
@@ -1878,7 +1932,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Now some size filtering heuristics. */
-	trg_size = trg_entry->size;
+	trg_size = SIZE(trg_entry);
 	if (!DELTA(trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
@@ -1890,7 +1944,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
-	src_size = src_entry->size;
+	src_size = SIZE(src_entry);
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
@@ -2008,7 +2062,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-		freed_mem += n->entry->size;
+		freed_mem += SIZE(n->entry);
 		FREE_AND_NULL(n->data);
 	}
 	n->entry = NULL;
@@ -2458,7 +2512,8 @@ static void prepare_pack(int window, int depth)
 			 */
 			continue;
 
-		if (!entry->type_valid || entry->size < 50)
+		if (!entry->type_valid ||
+		    oe_size_less_than(&to_pack, entry, 50))
 			continue;
 
 		if (entry->no_try_delta)
diff --git a/pack-objects.c b/pack-objects.c
index 08cfe68b6b..e0c4600568 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -143,6 +143,9 @@ void prepare_packing_data(struct packing_data *pdata)
 	} else {
 		prepare_in_pack_by_idx(pdata);
 	}
+
+	pdata->oe_size_limit = git_env_ulong("GIT_TEST_OE_SIZE",
+					     1U << OE_SIZE_BITS);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
diff --git a/pack-objects.h b/pack-objects.h
index e4ea6a350c..ee2c7ab382 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -7,6 +7,11 @@
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		10
 #define OE_Z_DELTA_BITS		20
+/*
+ * Note that oe_set_size() becomes expensive when the given size is
+ * above this limit. Don't lower it too much.
+ */
+#define OE_SIZE_BITS		31
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -70,7 +75,8 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;	/* uncompressed size */
+	unsigned size_:OE_SIZE_BITS;
+	unsigned size_valid:1;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
@@ -115,6 +121,8 @@ struct packing_data {
 	 */
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
+
+	uintmax_t oe_size_limit;
 };
 
 void prepare_packing_data(struct packing_data *pdata);
@@ -254,4 +262,51 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
 		e->delta_sibling_idx = 0;
 }
 
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e);
+static inline unsigned long oe_size(struct packing_data *pack,
+				    const struct object_entry *e)
+{
+	if (e->size_valid)
+		return e->size_;
+
+	return oe_get_size_slow(pack, e);
+}
+
+static inline int oe_size_less_than(struct packing_data *pack,
+				    const struct object_entry *lhs,
+				    unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ < rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
+		return 0;
+	return oe_get_size_slow(pack, lhs) < rhs;
+}
+
+static inline int oe_size_greater_than(struct packing_data *pack,
+				       const struct object_entry *lhs,
+				       unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ > rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
+		return 1;
+	return oe_get_size_slow(pack, lhs) > rhs;
+}
+
+static inline void oe_set_size(struct packing_data *pack,
+			       struct object_entry *e,
+			       unsigned long size)
+{
+	if (size < pack->oe_size_limit) {
+		e->size_ = size;
+		e->size_valid = 1;
+	} else {
+		e->size_valid = 0;
+		if (oe_get_size_slow(pack, e) != size)
+			BUG("'size' is supposed to be the object size!");
+	}
+}
+
 #endif
diff --git a/t/README b/t/README
index a06a85bae8..8373a27fea 100644
--- a/t/README
+++ b/t/README
@@ -309,6 +309,12 @@ pack-objects code path where there are more than 1024 packs even if
 the actual number of packs in repository is below this limit. Accept
 any boolean values that are accepted by git-config.
 
+GIT_TEST_OE_SIZE=<n> exercises the uncommon pack-objects code path
+where we do not cache object size in memory and read it from existing
+packs on demand. This normally only happens when the object size is
+over 2GB. This variable forces the code path on any object larger than
+<n> bytes.
+
 Naming Tests
 ------------
 
-- 
2.17.0.367.g5dd2e386c3

