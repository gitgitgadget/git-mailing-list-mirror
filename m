Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AE81F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeDNPfo (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:44 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39296 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeDNPfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:36 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so16397407lfd.6
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKbl+L4JL52goLPzgGWZ6A858LvkLPUDWE7SB/2Q75c=;
        b=tJiwFhx8ry68ZwZ/ycRSww/wC8Nwr6KqlKj7+9lZAdQwMt7nxJ7GcIpj+ihLkdL2mN
         9v06wRxDK2GWioG9geqKPkYMPBUvdl3lnFtvLpVAhqjC2KWIV0mKG7wMtvkJG/oF973N
         lp4tkSAvTe8j3oicDTu3hdfUq2a15svHtcKmOazC2erJHf585gv1GXAqKITimLbL8pDO
         /t4wq8U7pXtVvxUsQue6pE9k8kYwDF9MVOfsXrd4hhe/dFer3T+NU7x3NP8CUSMdJ2Dw
         vRyCg3rxcYnvJ38HFw3qFyUmeo5nfVjNfHsy2Pk77MUWNUY9C0l1EJzd+1lQnaBxykKD
         8UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKbl+L4JL52goLPzgGWZ6A858LvkLPUDWE7SB/2Q75c=;
        b=SZBxeAS+rw2W1AEzj7BQEvBdnr3DoFlC7zpgz6lgtDeWUuuZJYX3Ve2nMCAcJAdAGq
         A2RvKBzCJDgCdrYRF4hP1Ir+n2B/RCxclSjLKGG0JBEf/GFbyI8zIwpE96glRLsrRcrC
         wmoEZ2LV6LC7b1c+MEPzxXA+OSU8ixMVs8RfxJ5QSDwaF2xE7TDHpb5nvS/GpBiek/G5
         hH+Al2RIYWjb2lzpK1JsdLXb9nLng0EseC3qjmUFpaYnIFfUqoPIn+voM5xG/6dTphca
         bCEAprJdEUm7GDzvHa4LWdJAP4b5E+moKpV3QEZPOTQ6ojXX/GocW0S7iZT7xP85W6k1
         wlng==
X-Gm-Message-State: ALQs6tBzpyQ6DtAzVuAZ4U/gTCPcqN+2ga6DvHeifiFCrC/OJZGGrB7y
        VeIzyow5zbrfsxe4g/oW0TlhkA==
X-Google-Smtp-Source: AIpwx481PcmuS+5m1ZQXTYxpeXZDQLg0c9whNAaBVCHpY4aloYcd3QmFeURs3ZTUcJSDWCmnUsQ2iw==
X-Received: by 2002:a19:c713:: with SMTP id x19-v6mr11187293lff.32.1523720134581;
        Sat, 14 Apr 2018 08:35:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/15] pack-objects: refer to delta objects by index instead of pointer
Date:   Sat, 14 Apr 2018 17:35:06 +0200
Message-Id: <20180414153513.9902-9-pclouds@gmail.com>
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

These delta pointers always point to elements in the objects[] array
in packing_data struct. We can only hold maximum 4G of those objects
because the array size in nr_objects is uint32_t. We could use
uint32_t indexes to address these elements instead of pointers. On
64-bit architecture (8 bytes per pointer) this would save 4 bytes per
pointer.

Convert these delta pointers to indexes. Since we need to handle NULL
pointers as well, the index is shifted by one [1].

[1] This means we can only index 2^32-2 objects even though nr_objects
    could contain 2^32-1 objects. It should not be a problem in
    practice because when we grow objects[], nr_alloc would probably
    blow up long before nr_objects hits the wall.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 117 ++++++++++++++++++++++-------------------
 pack-objects.h         |  67 +++++++++++++++++++++--
 2 files changed, 125 insertions(+), 59 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2784d58ec2..ec02641d2e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,6 +32,12 @@
 #include "object-store.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+#define DELTA(obj) oe_delta(&to_pack, obj)
+#define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
+#define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
+#define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
+#define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
+#define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -129,10 +135,11 @@ static void *get_delta(struct object_entry *entry)
 	buf = read_object_file(&entry->idx.oid, &type, &size);
 	if (!buf)
 		die("unable to read %s", oid_to_hex(&entry->idx.oid));
-	base_buf = read_object_file(&entry->delta->idx.oid, &type, &base_size);
+	base_buf = read_object_file(&DELTA(entry)->idx.oid, &type,
+				    &base_size);
 	if (!base_buf)
 		die("unable to read %s",
-		    oid_to_hex(&entry->delta->idx.oid));
+		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
 	if (!delta_buf || delta_size != entry->delta_size)
@@ -288,12 +295,12 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
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
 
@@ -317,7 +324,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		 * encoding of the relative offset for the delta
 		 * base from this object's position in the pack.
 		 */
-		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
+		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -343,7 +350,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 	} else {
 		if (limit && hdrlen + datalen + 20 >= limit) {
@@ -379,8 +386,8 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 
-	if (entry->delta)
-		type = (allow_ofs_delta && entry->delta->idx.offset) ?
+	if (DELTA(entry))
+		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
 					      type, entry->size);
@@ -408,7 +415,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	}
 
 	if (type == OBJ_OFS_DELTA) {
-		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
+		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -427,7 +434,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 		reused_delta++;
 	} else {
@@ -467,13 +474,13 @@ static off_t write_object(struct hashfile *f,
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
@@ -489,7 +496,7 @@ static off_t write_object(struct hashfile *f,
 				/* ... but pack split may override that */
 	else if (oe_type(entry) != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
-	else if (entry->delta)
+	else if (DELTA(entry))
 		to_reuse = 0;	/* we want to pack afresh */
 	else
 		to_reuse = 1;	/* we have it in-pack undeltified,
@@ -541,12 +548,12 @@ static enum write_one_status write_one(struct hashfile *f,
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
+			SET_DELTA(e, NULL);
 			break;
 		default:
 			break;
@@ -608,34 +615,34 @@ static void add_descendants_to_write_order(struct object_entry **wo,
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
@@ -646,7 +653,7 @@ static void add_family_to_write_order(struct object_entry **wo,
 {
 	struct object_entry *root;
 
-	for (root = e; root->delta; root = root->delta)
+	for (root = e; DELTA(root); root = DELTA(root))
 		; /* nothing */
 	add_descendants_to_write_order(wo, endp, root);
 }
@@ -661,8 +668,8 @@ static struct object_entry **compute_write_order(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
 		objects[i].filled = 0;
-		objects[i].delta_child = NULL;
-		objects[i].delta_sibling = NULL;
+		SET_DELTA_CHILD(&objects[i], NULL);
+		SET_DELTA_SIBLING(&objects[i], NULL);
 	}
 
 	/*
@@ -672,11 +679,11 @@ static struct object_entry **compute_write_order(void)
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
@@ -1493,10 +1500,10 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			oe_set_type(entry, entry->in_pack_type);
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
@@ -1567,17 +1574,19 @@ static int pack_offset_sort(const void *_a, const void *_b)
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
+	SET_DELTA(entry, NULL);
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
@@ -1617,7 +1626,7 @@ static void break_delta_chains(struct object_entry *entry)
 
 	for (cur = entry, total_depth = 0;
 	     cur;
-	     cur = cur->delta, total_depth++) {
+	     cur = DELTA(cur), total_depth++) {
 		if (cur->dfs_state == DFS_DONE) {
 			/*
 			 * We've already seen this object and know it isn't
@@ -1642,7 +1651,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * it's not a delta, we're done traversing, but we'll mark it
 		 * done to save time on future traversals.
 		 */
-		if (!cur->delta) {
+		if (!DELTA(cur)) {
 			cur->dfs_state = DFS_DONE;
 			break;
 		}
@@ -1665,7 +1674,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * We keep all commits in the chain that we examined.
 		 */
 		cur->dfs_state = DFS_ACTIVE;
-		if (cur->delta->dfs_state == DFS_ACTIVE) {
+		if (DELTA(cur)->dfs_state == DFS_ACTIVE) {
 			drop_reused_delta(cur);
 			cur->dfs_state = DFS_DONE;
 			break;
@@ -1680,7 +1689,7 @@ static void break_delta_chains(struct object_entry *entry)
 	 * an extra "next" pointer to keep going after we reset cur->delta.
 	 */
 	for (cur = entry; cur; cur = next) {
-		next = cur->delta;
+		next = DELTA(cur);
 
 		/*
 		 * We should have a chain of zero or more ACTIVE states down to
@@ -1865,7 +1874,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
-	if (!trg_entry->delta) {
+	if (!DELTA(trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
 	} else {
@@ -1939,7 +1948,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (!delta_buf)
 		return 0;
 
-	if (trg_entry->delta) {
+	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
 		if (delta_size == trg_entry->delta_size &&
 		    src->depth + 1 >= trg->depth) {
@@ -1968,7 +1977,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		free(delta_buf);
 	}
 
-	trg_entry->delta = src_entry;
+	SET_DELTA(trg_entry, src_entry);
 	trg_entry->delta_size = delta_size;
 	trg->depth = src->depth + 1;
 
@@ -1977,13 +1986,13 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
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
@@ -2052,7 +2061,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * otherwise they would become too deep.
 		 */
 		max_depth = depth;
-		if (entry->delta_child) {
+		if (DELTA_CHILD(entry)) {
 			max_depth -= check_delta_limit(entry, 0);
 			if (max_depth <= 0)
 				goto next;
@@ -2102,7 +2111,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
 		 */
-		if (entry->delta && max_depth <= n->depth)
+		if (DELTA(entry) && max_depth <= n->depth)
 			continue;
 
 		/*
@@ -2110,7 +2119,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * currently deltified object, to keep it longer.  It will
 		 * be the first base object to be attempted next.
 		 */
-		if (entry->delta) {
+		if (DELTA(entry)) {
 			struct unpacked swap = array[best_base];
 			int dist = (window + idx - best_base) % window;
 			int dst = best_base;
@@ -2431,7 +2440,7 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (entry->delta)
+		if (DELTA(entry))
 			/* This happens if we decided to reuse existing
 			 * delta from a pack.  "reuse_delta &&" is implied.
 			 */
diff --git a/pack-objects.h b/pack-objects.h
index 7bedd5af81..e962dce3c0 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -70,11 +70,11 @@ struct object_entry {
 	unsigned long size;	/* uncompressed size */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
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
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
@@ -194,4 +194,61 @@ static inline void oe_set_in_pack(struct packing_data *pack,
 		pack->in_pack[e - pack->objects] = p;
 }
 
+static inline struct object_entry *oe_delta(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_idx)
+		return &pack->objects[e->delta_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta(struct packing_data *pack,
+				struct object_entry *e,
+				struct object_entry *delta)
+{
+	if (delta)
+		e->delta_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_idx = 0;
+}
+
+static inline struct object_entry *oe_delta_child(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_child_idx)
+		return &pack->objects[e->delta_child_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_child(struct packing_data *pack,
+				      struct object_entry *e,
+				      struct object_entry *delta)
+{
+	if (delta)
+		e->delta_child_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_child_idx = 0;
+}
+
+static inline struct object_entry *oe_delta_sibling(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_sibling_idx)
+		return &pack->objects[e->delta_sibling_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_sibling(struct packing_data *pack,
+					struct object_entry *e,
+					struct object_entry *delta)
+{
+	if (delta)
+		e->delta_sibling_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_sibling_idx = 0;
+}
+
 #endif
-- 
2.17.0.367.g5dd2e386c3

