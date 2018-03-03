Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254471F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965210AbeCCCr7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:59 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45393 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965205AbeCCCr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:57 -0500
Received: by mail-pf0-f194.google.com with SMTP id h19so3894187pfd.12
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpUuQURPeYoNo9llYumsQcx/jrkfZuMX2AA4X2kLTgw=;
        b=mqy6HuOLWtENt2cjMGOn5NxKMxNz+9uG0z+dlY7wUPy5/OpVXb2ke80IcT/K3V/qnb
         MUZ4deMO9+dQ35P/FZ87eIBJw9DzGGDPp+TbI4MjV3a/AIFwi9gYkZuanOheYVjFT/Km
         MsgPVPTINW54YfyOF8JLaxQGBrEXaJqJubfSAaUe5Uy4yuYsPozRRS5j2YcgpMCpxyIg
         ryW5B0JLnX1Z5dMsHez8anyDUE1kO9aAvhQPpCl8UmdKcRRJbfkIlhI2zgnejeEoj8qX
         PwtiOK9UXHPiTKcBF8tseb78ziVGIK1Egkk1h38sRHaOZFjfeBNjXdqghaVYh2DvC6RQ
         eKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpUuQURPeYoNo9llYumsQcx/jrkfZuMX2AA4X2kLTgw=;
        b=IPw7QwqzyLBn/5SMhLoD26DOMh2hfU8H7NbZT5Q7ljIgX5q+Nha71SmbEg7K1NUbQx
         zXe5GPOWA2jS/4jM9flBVfQE33BsCbYNsKX1ynlPZeHaGwt8+nF1EjIB9lEbwZT9bRfI
         fxflEQaAPnZ+LKZeUpIVISB6+7w49SOKimbjg0pdicNxYHX+HmI1shuJX/PrmB2EDBrM
         DlQiiOkrUYQbu9AKv5ziENFZyF69bkObGMDeRTaguWMIZH8cLlVqscpKBk5DK5qnvuhe
         4TbHvFuOegi+ZBEHP9Cm0aYmyDQtVpvlkxZz6MZpFRXpcx2yetOwEQM0RxFbRLUgGzxX
         4LUQ==
X-Gm-Message-State: APf1xPDNzvMt8y4x60I3AAUAlEu9GpmhSvfd/Hba8zsPLnvL7+dAoqLA
        fCsfwYGl15mYlYawTAlFp/idzw==
X-Google-Smtp-Source: AG47ELuecfz9bHXFR7SceA5pR0j5u11SKHhfCTLypxYhJFfUAN/W080HyEk5sZRwX6af/XgFepGEQQ==
X-Received: by 10.99.39.131 with SMTP id n125mr6142177pgn.292.1520045276301;
        Fri, 02 Mar 2018 18:47:56 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 5sm16466837pfh.133.2018.03.02.18.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 8/9] pack-objects: refer to delta objects by index instead of pointer
Date:   Sat,  3 Mar 2018 09:47:05 +0700
Message-Id: <20180303024706.31465-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303024706.31465-1-pclouds@gmail.com>
References: <20180301091052.32267-1-pclouds@gmail.com>
 <20180303024706.31465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Notice that packing_data::nr_objects is uint32_t, we could only handle
maximum 4G objects and can address all of them with an uint32_t. If we
use a pointer here, we waste 4 bytes on 64 bit architecture.

Convert these delta pointers to indexes. Since we need to handle NULL
pointers as well, the index is shifted by one [1].

There are holes in this struct but this patch is already big. Struct
packing can be done separately. Even with holes, we save 8 bytes per
object_entry.

[1] This means we can only index 2^32-2 objects even though nr_objects
    could contain 2^32-1 objects. It should not be a problem in
    practice because when we grow objects[], nr_alloc would probably
    blow up long before nr_objects hits the wall.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 124 +++++++++++++++++++++++------------------
 pack-objects.h         |  14 +++--
 2 files changed, 78 insertions(+), 60 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5818bf73ca..55f19a1f18 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -29,6 +29,20 @@
 #include "list.h"
 #include "packfile.h"
 
+#define DELTA(obj) \
+	((obj)->delta_idx ? &to_pack.objects[(obj)->delta_idx - 1] : NULL)
+#define DELTA_CHILD(obj) \
+	((obj)->delta_child_idx ? &to_pack.objects[(obj)->delta_child_idx - 1] : NULL)
+#define DELTA_SIBLING(obj) \
+	((obj)->delta_sibling_idx ? &to_pack.objects[(obj)->delta_sibling_idx - 1] : NULL)
+
+#define CLEAR_DELTA(obj) (obj)->delta_idx = 0
+#define CLEAR_DELTA_CHILD(obj) (obj)->delta_child_idx = 0
+#define CLEAR_DELTA_SIBLING(obj) (obj)->delta_sibling_idx = 0
+
+#define SET_DELTA(obj, val) (obj)->delta_idx = ((val) - to_pack.objects) + 1
+#define SET_DELTA_CHILD(obj, val) (obj)->delta_child_idx = ((val) - to_pack.objects) + 1
+
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
 	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
@@ -125,11 +139,11 @@ static void *get_delta(struct object_entry *entry)
 	buf = read_sha1_file(entry->idx.oid.hash, &type, &size);
 	if (!buf)
 		die("unable to read %s", oid_to_hex(&entry->idx.oid));
-	base_buf = read_sha1_file(entry->delta->idx.oid.hash, &type,
+	base_buf = read_sha1_file(DELTA(entry)->idx.oid.hash, &type,
 				  &base_size);
 	if (!base_buf)
 		die("unable to read %s",
-		    oid_to_hex(&entry->delta->idx.oid));
+		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
 	if (!delta_buf || delta_size != entry->delta_size)
@@ -286,12 +300,12 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		size = entry->delta_size;
 		buf = entry->delta_data;
 		entry->delta_data = NULL;
-		type = (allow_ofs_delta && entry->delta->idx.offset) ?
+		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	} else {
 		buf = get_delta(entry);
 		size = entry->delta_size;
-		type = (allow_ofs_delta && entry->delta->idx.offset) ?
+		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	}
 
@@ -315,7 +329,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		 * encoding of the relative offset for the delta
 		 * base from this object's position in the pack.
 		 */
-		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
+		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -341,7 +355,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 	} else {
 		if (limit && hdrlen + datalen + 20 >= limit) {
@@ -377,8 +391,8 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 
-	if (entry->delta)
-		type = (allow_ofs_delta && entry->delta->idx.offset) ?
+	if (DELTA(entry))
+		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
 					      type, entry->size);
@@ -406,7 +420,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	}
 
 	if (type == OBJ_OFS_DELTA) {
-		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
+		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -425,7 +439,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 		reused_delta++;
 	} else {
@@ -465,13 +479,13 @@ static off_t write_object(struct hashfile *f,
 	else
 		limit = pack_size_limit - write_offset;
 
-	if (!entry->delta)
+	if (!DELTA(entry))
 		usable_delta = 0;	/* no delta */
 	else if (!pack_size_limit)
 	       usable_delta = 1;	/* unlimited packfile */
-	else if (entry->delta->idx.offset == (off_t)-1)
+	else if (DELTA(entry)->idx.offset == (off_t)-1)
 		usable_delta = 0;	/* base was written to another pack */
-	else if (entry->delta->idx.offset)
+	else if (DELTA(entry)->idx.offset)
 		usable_delta = 1;	/* base already exists in this pack */
 	else
 		usable_delta = 0;	/* base could end up in another pack */
@@ -486,7 +500,7 @@ static off_t write_object(struct hashfile *f,
 				/* ... but pack split may override that */
 	else if (entry->type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
-	else if (entry->delta)
+	else if (DELTA(entry))
 		to_reuse = 0;	/* we want to pack afresh */
 	else
 		to_reuse = 1;	/* we have it in-pack undeltified,
@@ -538,12 +552,12 @@ static enum write_one_status write_one(struct hashfile *f,
 	}
 
 	/* if we are deltified, write out base object first. */
-	if (e->delta) {
+	if (DELTA(e)) {
 		e->idx.offset = 1; /* now recurse */
-		switch (write_one(f, e->delta, offset)) {
+		switch (write_one(f, DELTA(e), offset)) {
 		case WRITE_ONE_RECURSIVE:
 			/* we cannot depend on this one */
-			e->delta = NULL;
+			CLEAR_DELTA(e);
 			break;
 		default:
 			break;
@@ -605,34 +619,34 @@ static void add_descendants_to_write_order(struct object_entry **wo,
 			/* add this node... */
 			add_to_write_order(wo, endp, e);
 			/* all its siblings... */
-			for (s = e->delta_sibling; s; s = s->delta_sibling) {
+			for (s = DELTA_SIBLING(e); s; s = DELTA_SIBLING(s)) {
 				add_to_write_order(wo, endp, s);
 			}
 		}
 		/* drop down a level to add left subtree nodes if possible */
-		if (e->delta_child) {
+		if (DELTA_CHILD(e)) {
 			add_to_order = 1;
-			e = e->delta_child;
+			e = DELTA_CHILD(e);
 		} else {
 			add_to_order = 0;
 			/* our sibling might have some children, it is next */
-			if (e->delta_sibling) {
-				e = e->delta_sibling;
+			if (DELTA_SIBLING(e)) {
+				e = DELTA_SIBLING(e);
 				continue;
 			}
 			/* go back to our parent node */
-			e = e->delta;
-			while (e && !e->delta_sibling) {
+			e = DELTA(e);
+			while (e && !DELTA_SIBLING(e)) {
 				/* we're on the right side of a subtree, keep
 				 * going up until we can go right again */
-				e = e->delta;
+				e = DELTA(e);
 			}
 			if (!e) {
 				/* done- we hit our original root node */
 				return;
 			}
 			/* pass it off to sibling at this level */
-			e = e->delta_sibling;
+			e = DELTA_SIBLING(e);
 		}
 	};
 }
@@ -643,7 +657,7 @@ static void add_family_to_write_order(struct object_entry **wo,
 {
 	struct object_entry *root;
 
-	for (root = e; root->delta; root = root->delta)
+	for (root = e; DELTA(root); root = DELTA(root))
 		; /* nothing */
 	add_descendants_to_write_order(wo, endp, root);
 }
@@ -658,8 +672,8 @@ static struct object_entry **compute_write_order(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
 		objects[i].filled = 0;
-		objects[i].delta_child = NULL;
-		objects[i].delta_sibling = NULL;
+		CLEAR_DELTA_CHILD(&objects[i]);
+		CLEAR_DELTA_SIBLING(&objects[i]);
 	}
 
 	/*
@@ -669,11 +683,11 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (i = to_pack.nr_objects; i > 0;) {
 		struct object_entry *e = &objects[--i];
-		if (!e->delta)
+		if (!DELTA(e))
 			continue;
 		/* Mark me as the first child */
-		e->delta_sibling = e->delta->delta_child;
-		e->delta->delta_child = e;
+		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
+		SET_DELTA_CHILD(DELTA(e), e);
 	}
 
 	/*
@@ -1509,10 +1523,10 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			entry->type = entry->in_pack_type;
-			entry->delta = base_entry;
+			SET_DELTA(entry, base_entry);
 			entry->delta_size = entry->size;
-			entry->delta_sibling = base_entry->delta_child;
-			base_entry->delta_child = entry;
+			entry->delta_sibling_idx = base_entry->delta_child_idx;
+			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1583,17 +1597,19 @@ static int pack_offset_sort(const void *_a, const void *_b)
  */
 static void drop_reused_delta(struct object_entry *entry)
 {
-	struct object_entry **p = &entry->delta->delta_child;
+	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
 
-	while (*p) {
-		if (*p == entry)
-			*p = (*p)->delta_sibling;
+	while (*idx) {
+		struct object_entry *oe = &to_pack.objects[*idx - 1];
+
+		if (oe == entry)
+			*idx = oe->delta_sibling_idx;
 		else
-			p = &(*p)->delta_sibling;
+			idx = &oe->delta_sibling_idx;
 	}
-	entry->delta = NULL;
+	CLEAR_DELTA(entry);
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
@@ -1635,7 +1651,7 @@ static void break_delta_chains(struct object_entry *entry)
 
 	for (cur = entry, total_depth = 0;
 	     cur;
-	     cur = cur->delta, total_depth++) {
+	     cur = DELTA(cur), total_depth++) {
 		if (cur->dfs_state == DFS_DONE) {
 			/*
 			 * We've already seen this object and know it isn't
@@ -1660,7 +1676,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * it's not a delta, we're done traversing, but we'll mark it
 		 * done to save time on future traversals.
 		 */
-		if (!cur->delta) {
+		if (!DELTA(cur)) {
 			cur->dfs_state = DFS_DONE;
 			break;
 		}
@@ -1683,7 +1699,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * We keep all commits in the chain that we examined.
 		 */
 		cur->dfs_state = DFS_ACTIVE;
-		if (cur->delta->dfs_state == DFS_ACTIVE) {
+		if (DELTA(cur)->dfs_state == DFS_ACTIVE) {
 			drop_reused_delta(cur);
 			cur->dfs_state = DFS_DONE;
 			break;
@@ -1698,7 +1714,7 @@ static void break_delta_chains(struct object_entry *entry)
 	 * an extra "next" pointer to keep going after we reset cur->delta.
 	 */
 	for (cur = entry; cur; cur = next) {
-		next = cur->delta;
+		next = DELTA(cur);
 
 		/*
 		 * We should have a chain of zero or more ACTIVE states down to
@@ -1881,7 +1897,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
-	if (!trg_entry->delta) {
+	if (!DELTA(trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
 	} else {
@@ -1957,7 +1973,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (!delta_buf)
 		return 0;
 
-	if (trg_entry->delta) {
+	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
 		if (delta_size == trg_entry->delta_size &&
 		    src->depth + 1 >= trg->depth) {
@@ -1986,7 +2002,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		free(delta_buf);
 	}
 
-	trg_entry->delta = src_entry;
+	SET_DELTA(trg_entry, src_entry);
 	trg_entry->delta_size = delta_size;
 	trg->depth = src->depth + 1;
 
@@ -1995,13 +2011,13 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 {
-	struct object_entry *child = me->delta_child;
+	struct object_entry *child = DELTA_CHILD(me);
 	unsigned int m = n;
 	while (child) {
 		unsigned int c = check_delta_limit(child, n + 1);
 		if (m < c)
 			m = c;
-		child = child->delta_sibling;
+		child = DELTA_SIBLING(child);
 	}
 	return m;
 }
@@ -2070,7 +2086,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * otherwise they would become too deep.
 		 */
 		max_depth = depth;
-		if (entry->delta_child) {
+		if (DELTA_CHILD(entry)) {
 			max_depth -= check_delta_limit(entry, 0);
 			if (max_depth <= 0)
 				goto next;
@@ -2120,7 +2136,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
 		 */
-		if (entry->delta && max_depth <= n->depth)
+		if (DELTA(entry) && max_depth <= n->depth)
 			continue;
 
 		/*
@@ -2128,7 +2144,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * currently deltified object, to keep it longer.  It will
 		 * be the first base object to be attempted next.
 		 */
-		if (entry->delta) {
+		if (DELTA(entry)) {
 			struct unpacked swap = array[best_base];
 			int dist = (window + idx - best_base) % window;
 			int dst = best_base;
@@ -2449,7 +2465,7 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (entry->delta)
+		if (DELTA(entry))
 			/* This happens if we decided to reuse existing
 			 * delta from a pack.  "reuse_delta &&" is implied.
 			 */
diff --git a/pack-objects.h b/pack-objects.h
index 83d91a0765..db50e56223 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -33,11 +33,13 @@ struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
 	off_t in_pack_offset;
-	struct object_entry *delta;	/* delta base object */
-	struct object_entry *delta_child; /* deltified objects who bases me */
-	struct object_entry *delta_sibling; /* other deltified objects who
-					     * uses the same base as me
-					     */
+	uint32_t delta_idx;	/* delta base object */
+	uint32_t delta_child_idx; /* deltified objects who bases me */
+	uint32_t delta_sibling_idx; /* other deltified objects who
+				     * uses the same base as me
+				     */
+	/* XXX 4 bytes hole, try to pack */
+
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
@@ -60,7 +62,7 @@ struct object_entry {
 
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 112, padding: 4, bit_padding: 18 bits */
+	/* size: 104, padding: 4, bit_padding: 18 bits */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

