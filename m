Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066F01F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966684AbeCAJLx (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:53 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38361 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965026AbeCAJLo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:44 -0500
Received: by mail-pl0-f67.google.com with SMTP id d4-v6so3299615pll.5
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNiTMa5yVrsKAOnNHUpRCsh0Y4FwWxF1KZnMuXENjgg=;
        b=jwpBpk2yTrDtAiMo8Eym2UvXp4kRTdB4MQkk92BpHlxjMci8tKhOX/RDegEz3y6ZSk
         WEbB8cTLWuvq3Qn7QIE9GfFJK2i2vRe5d4kjeqSJru5GIJqs6mAgzxnpOz9M7xZsLOLL
         y+m+ntsmYoaKbzlNb9JDe26QdvdbmVehGTYFtKKSwEEASz3W7+SStTYafU5UniI3Uu/m
         wWdrD8q9sU3TxQD+GlZhKOoSQ2RyuzNeeswkgaZ03Ot9kVkVfsYQq8mLtPiM7F8n57AP
         p/MGt0SCWjO9EOd/zGaoOWuRcoTWY75UxSgdAR3kLNSHxlUTsgsxXPWrRFdFF2t+Ra7B
         iq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNiTMa5yVrsKAOnNHUpRCsh0Y4FwWxF1KZnMuXENjgg=;
        b=uOqRggTKyRHG9hwyfr31S3193E1Vo+hYQ1XojvJvgBZ619zMDkiPeclBT8HHH4o23w
         mFHwfl/orzaVKghlnWnBcJjp39g0IYZFYFOonB0phqIqdvB4C21P44urLktUia5CxeL/
         4XkcibZWbz+gI0m1dsrlz6DhGLkAE9TH8c4UByYdOhBy51b9EoujR+Qu6FYLv/D5cvAp
         G8Lze2CmI3z9HWW8oS+AIXkzA97OQG1WPqyytGTUdmgHUy1GELUqrvLmBeQ0c697YyhK
         QgISxf7RetrolJ2W9FwYxZcQ7wqg+QCN2TfNglvP2d+mMdrU3hMm8L6ZxCA2Jw2/C8vf
         Fhlg==
X-Gm-Message-State: APf1xPD8q/T8+BgfSXgMHCd4RebypRF6LwP4xsVTFJ3HoeBGszU3vVTK
        HDN6i9MwUdVod5Ewe494C0+5bg==
X-Google-Smtp-Source: AG47ELv1gIqUsfX+ZhS1yPeOmMiwxIdrArXIFxnAnsDVfqq2gvf3CNOAAF/ub6lbTPz8A5kmNngcZg==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr1265027plf.413.1519895503895;
        Thu, 01 Mar 2018 01:11:43 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id v1sm7550355pfg.33.2018.03.01.01.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/11] pack-objects: move in_pack out of struct object_entry
Date:   Thu,  1 Mar 2018 16:10:48 +0700
Message-Id: <20180301091052.32267-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
pack. Use an index isntead since the number of packs should be
relatively small.

This limits the number of packs we can handle to 256 (still
unreasonably high for a repo to work well). If you have more than 256
packs, you'll need an older version of Git to repack first.

This technically saves 7 bytes. But we don't see any of that in
practice due to padding. The saving becomes real when we pack this
struct tighter later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 48 ++++++++++++++++++++++++++++++++----------
 pack-objects.h         | 12 +++++++++--
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7bb5544883..d0d371714a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -367,7 +367,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 				unsigned long limit, int usable_delta)
 {
-	struct packed_git *p = entry->in_pack;
+	struct packed_git *p = IN_PACK(&to_pack, entry);
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
@@ -478,7 +478,7 @@ static off_t write_object(struct hashfile *f,
 
 	if (!reuse_object)
 		to_reuse = 0;	/* explicit */
-	else if (!entry->in_pack)
+	else if (!IN_PACK(&to_pack, entry))
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (entry->type == OBJ_REF_DELTA || entry->type == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
@@ -1074,7 +1074,15 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		entry->in_pack = found_pack;
+		int i;
+
+		for (i = 0; i < (1 << OE_IN_PACK_BITS); i++)
+			if (to_pack.in_pack[i] == found_pack) {
+				entry->in_pack_idx = i;
+				break;
+			}
+		if (i == (1 << OE_IN_PACK_BITS))
+			die("BUG: pack not found!");
 		entry->in_pack_offset = found_offset;
 	}
 
@@ -1399,8 +1407,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
-	if (entry->in_pack) {
-		struct packed_git *p = entry->in_pack;
+	if (IN_PACK(&to_pack, entry)) {
+		struct packed_git *p = IN_PACK(&to_pack, entry);
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
@@ -1535,14 +1543,16 @@ static int pack_offset_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
+	const struct packed_git *a_in_pack = IN_PACK(&to_pack, a);
+	const struct packed_git *b_in_pack = IN_PACK(&to_pack, b);
 
 	/* avoid filesystem trashing with loose objects */
-	if (!a->in_pack && !b->in_pack)
+	if (!a_in_pack && !b_in_pack)
 		return oidcmp(&a->idx.oid, &b->idx.oid);
 
-	if (a->in_pack < b->in_pack)
+	if (a_in_pack < b_in_pack)
 		return -1;
-	if (a->in_pack > b->in_pack)
+	if (a_in_pack > b_in_pack)
 		return 1;
 	return a->in_pack_offset < b->in_pack_offset ? -1 :
 			(a->in_pack_offset > b->in_pack_offset);
@@ -1578,7 +1588,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &entry->size;
 	oi.typep = &type;
-	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(&to_pack, entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
@@ -1848,8 +1858,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	 * it, we will still save the transfer cost, as we already know
 	 * the other side has it and we won't send src_entry at all.
 	 */
-	if (reuse_delta && trg_entry->in_pack &&
-	    trg_entry->in_pack == src_entry->in_pack &&
+	if (reuse_delta && IN_PACK(&to_pack, trg_entry) &&
+	    IN_PACK(&to_pack, trg_entry) == IN_PACK(&to_pack, src_entry) &&
 	    !src_entry->preferred_base &&
 	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
@@ -2958,6 +2968,21 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
+static void init_in_pack_mapping(struct packing_data *to_pack)
+{
+	struct packed_git *p;
+	int i = 0;
+
+	/* let IN_PACK() return NULL if in_pack_idx is zero */
+	to_pack->in_pack[i++] = NULL;
+
+	for (p = packed_git; p; p = p->next, i++) {
+		if (i >= (1 << OE_IN_PACK_BITS))
+			die("BUG: too many packs to handle!");
+		to_pack->in_pack[i] = p;
+	}
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3190,6 +3215,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			}
 		}
 	}
+	init_in_pack_mapping(&to_pack);
 
 	if (progress)
 		progress_state = start_progress(_("Counting objects"), 0);
diff --git a/pack-objects.h b/pack-objects.h
index 3bef28196c..839d5dc4fd 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,10 +3,14 @@
 
 #define OE_DFS_STATE_BITS 2
 #define OE_DEPTH_BITS 12
+#define OE_IN_PACK_BITS 8
 
 #define IN_PACK_POS(to_pack, obj) \
 	(to_pack)->in_pack_pos[(struct object_entry *)(obj) - (to_pack)->objects]
 
+#define IN_PACK(to_pack, obj) \
+	(to_pack)->in_pack[(obj)->in_pack_idx]
+
 /*
  * State flags for depth-first search used for analyzing delta cycles.
  *
@@ -23,7 +27,6 @@ enum dfs_state {
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-	struct packed_git *in_pack;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
@@ -35,6 +38,7 @@ struct object_entry {
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
 	unsigned char in_pack_header_size; /* note: spare bits available! */
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
@@ -46,9 +50,12 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+
+	/* XXX 12 bits hole, try to pack */
+
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 112 */
+	/* size: 112, padding: 4 */
 };
 
 struct packing_data {
@@ -59,6 +66,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.16.1.435.g8f24da2e1a

