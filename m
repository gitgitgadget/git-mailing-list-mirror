Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DECD1F576
	for <e@80x24.org>; Mon,  5 Mar 2018 09:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeCEJ24 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 04:28:56 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43584 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932935AbeCEJ2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 04:28:49 -0500
Received: by mail-pf0-f193.google.com with SMTP id j2so4806644pff.10
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 01:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uY6G0m7JiQJBBwElfL01FGrnR1x/vs9xpvuzM1CodHs=;
        b=W9f4m4d0ShivIjd0SbB7T0o2n6VsMABSg0cadkbBXlwh5j8Zt7AXGWUBnsLbXR/xha
         pFFSGgpu50gWumA8HKOIqx5XK55lOX3RmiGaW/HPcCvZ1lFSqJSNx0hsYky3zqoUU3vx
         0YlTaifzNM6h3I7nI+TWizAV/Y1a/2dXppViZxdM0mpn3uhvz7DHRDeBnt9CRQ6roCz0
         F1snixAStR66pJN6DTSZEB6HRtsU+Jq1kNfLJ8TGwp5T/9dmbLW/9IVid12d2fnQQwXV
         GJSMkl4oFgFnAI6erC5PH8zi2dcuxYwbnPpyC8fWfiPU2OC97SEEWgPUTlQVxeVgDtw+
         pQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uY6G0m7JiQJBBwElfL01FGrnR1x/vs9xpvuzM1CodHs=;
        b=Rq1tX1DEMcO1reXYP1GJ8LxoJDQVP9eVUXPGnxOPHPuK5TX1gHbwj12NxVHz/whZ3u
         4+0vzCMD/kdlsnTsVkh4RNAPTseMc0u3jTpzuwQuFiypNPD4Z7sH7T7dnFb90mnylj/P
         aqq2cLTwro2L+Tnvcrdmf7SMPy7tVCnJVypw9pPCg+yyNWjyJaWCBZWbSPMwZfnZ1HLe
         tbiNxcIOsWbHnE5jd+AlLeEqDZG3dkkbLiiC+K4mJgf5joiQ0wfQNByjvxiQ/S/yt2UY
         ymwjSknVPdSHr8D2IB7s6wRxma6kasTeMZmFYAuZ7m9jD3rKm06DPZDHva+mvzrwbuUG
         OfHw==
X-Gm-Message-State: APf1xPAOBho6l7ZE03/3YlA3uCuQBW6I6SjGqhgQzC4Vhk1p+VlYj9GL
        1H1FI/CvmbNh+OM2Vwsqqig6Zg==
X-Google-Smtp-Source: AG47ELsWX9SY4NPrTHgioMQYYo+MHWJQ/4+aFL6VoDesyaIP0ZcQfssxsHf8ACPgTTPiSE6HuE2Ahg==
X-Received: by 10.101.85.67 with SMTP id t3mr11874011pgr.310.1520242128056;
        Mon, 05 Mar 2018 01:28:48 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id 5sm28211380pfh.133.2018.03.05.01.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 01:28:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 05 Mar 2018 16:28:42 +0700
Date:   Mon, 5 Mar 2018 16:28:42 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 0/9] Reduce pack-objects memory footprint
Message-ID: <20180305092842.GA28090@ash>
References: <20180301091052.32267-1-pclouds@gmail.com>
 <20180303024706.31465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303024706.31465-1-pclouds@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 03, 2018 at 09:46:57AM +0700, Nguyễn Thái Ngọc Duy wrote:
> The array of object_entry in pack-objects can take a lot of memory
> when pack-objects is run in "pack everything" mode. On linux-2.6.git,
> this array alone takes roughly 800MB.
> 
> This series reorders some fields and reduces field size... to keep
> this struct smaller. Its size goes from 136 bytes to 96 bytes (29%) on
> 64-bit linux and saves 260MB on linux-2.6.git.

And I continue to push this until someone screams "enough is enough!".
This patch saves 4 more bytes. The trade off is, processing objects
with offset beyond 4 GB will be slower. But I think this is a reasonable
trade off.

The same trick could be done for "size" field in this struct
(i.e. uncompressed object size greater than 32 bits must be read back
from disk). Interestingly though, "size" is unsigned long which is 32
bits on Windows and nobody has complained about it so far, we could
even just unconditionally reject objects larger than 4GB.

-- 8< --
Subject: [PATCH] pack-objects: shrink in_pack_offset for 4GB pack files

If a pack file is smaller than 4GB, pack offsets should fit within 32
bits. If not (which is not considered a common case), this field
in_pack_location stores the object index instead (which still fits in 32
bits) and getting pack offset requires extra lookups through
nth_packed_object_offset() function call.

This saves us 4 bytes but lose it to padding until this struct is shrunk
further.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 26 ++++++++++++++-----------
 pack-objects.h         | 44 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 55f19a1f18..57c04b277b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -43,6 +43,8 @@
 #define SET_DELTA(obj, val) (obj)->delta_idx = ((val) - to_pack.objects) + 1
 #define SET_DELTA_CHILD(obj, val) (obj)->delta_child_idx = ((val) - to_pack.objects) + 1
 
+#define IN_PACK_OFFSET(obj) oe_in_pack_offset(&to_pack, obj)
+
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
 	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
@@ -397,7 +399,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
 					      type, entry->size);
 
-	offset = entry->in_pack_offset;
+	offset = IN_PACK_OFFSET(entry);
 	revidx = find_pack_revindex(p, offset);
 	datalen = revidx[1].offset - offset;
 	if (!pack_to_stdout && p->index_version > 1 &&
@@ -1107,7 +1109,7 @@ static void create_object_entry(const struct object_id *oid,
 		if (found_pack->index <= 0)
 			die("BUG: found_pack should be NULL instead of having non-positive index");
 		entry->in_pack_idx = found_pack->index;
-		entry->in_pack_offset = found_offset;
+		oe_set_in_pack_offset(&to_pack, entry, found_offset);
 	}
 
 	entry->no_try_delta = no_try_delta;
@@ -1442,7 +1444,7 @@ static void check_object(struct object_entry *entry)
 		unsigned char *buf, c;
 		enum object_type type;
 
-		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
+		buf = use_pack(p, &w_curs, IN_PACK_OFFSET(entry), &avail);
 
 		/*
 		 * We want in_pack_type even if we do not reuse delta
@@ -1475,12 +1477,12 @@ static void check_object(struct object_entry *entry)
 		case OBJ_REF_DELTA:
 			if (reuse_delta && !entry->preferred_base)
 				base_ref = use_pack(p, &w_curs,
-						entry->in_pack_offset + used, NULL);
+						IN_PACK_OFFSET(entry) + used, NULL);
 			entry->in_pack_header_size = used + 20;
 			break;
 		case OBJ_OFS_DELTA:
 			buf = use_pack(p, &w_curs,
-				       entry->in_pack_offset + used, NULL);
+				       IN_PACK_OFFSET(entry) + used, NULL);
 			used_0 = 0;
 			c = buf[used_0++];
 			ofs = c & 127;
@@ -1494,8 +1496,8 @@ static void check_object(struct object_entry *entry)
 				c = buf[used_0++];
 				ofs = (ofs << 7) + (c & 127);
 			}
-			ofs = entry->in_pack_offset - ofs;
-			if (ofs <= 0 || ofs >= entry->in_pack_offset) {
+			ofs = IN_PACK_OFFSET(entry) - ofs;
+			if (ofs <= 0 || ofs >= IN_PACK_OFFSET(entry)) {
 				error("delta base offset out of bound for %s",
 				      oid_to_hex(&entry->idx.oid));
 				goto give_up;
@@ -1538,7 +1540,7 @@ static void check_object(struct object_entry *entry)
 			 * object size from the delta header.
 			 */
 			entry->size = get_size_from_delta(p, &w_curs,
-					entry->in_pack_offset + entry->in_pack_header_size);
+				IN_PACK_OFFSET(entry) + entry->in_pack_header_size);
 			if (entry->size == 0)
 				goto give_up;
 			unuse_pack(&w_curs);
@@ -1578,8 +1580,8 @@ static int pack_offset_sort(const void *_a, const void *_b)
 		return -1;
 	if (a_in_pack > b_in_pack)
 		return 1;
-	return a->in_pack_offset < b->in_pack_offset ? -1 :
-			(a->in_pack_offset > b->in_pack_offset);
+	return IN_PACK_OFFSET(a) < IN_PACK_OFFSET(b) ? -1 :
+		(IN_PACK_OFFSET(a) > IN_PACK_OFFSET(b));
 }
 
 /*
@@ -1614,7 +1616,9 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &entry->size;
 	oi.typep = &type;
-	if (packed_object_info(IN_PACK(&to_pack, entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(&to_pack, entry),
+			       IN_PACK_OFFSET(entry),
+			       &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
diff --git a/pack-objects.h b/pack-objects.h
index a57aca5f03..cb752fb4d8 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,8 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#include "packfile.h"
+
 #define OE_DFS_STATE_BITS 2
 #define OE_DEPTH_BITS 12
 #define OE_IN_PACK_BITS 14
@@ -32,7 +34,6 @@ enum dfs_state {
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
@@ -42,6 +43,13 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
+	/*
+	 * If in_pack_location_is_offset is true, this contains offset
+	 * to the object in "in_pack". If false, it contains the
+	 * object _index_ and pack offset must be retrieved via
+	 * nth_packed_object_offset().
+	 */
+	uint32_t in_pack_location;
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
@@ -54,13 +62,14 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+	unsigned in_pack_location_is_offset:1;
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 
 	/* XXX 8 bits hole, try to pack */
 
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 96, bit_padding: 18 bits */
+	/* size: 96, padding: 4, bit_padding: 17 bits */
 };
 
 struct packing_data {
@@ -103,4 +112,35 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline off_t oe_in_pack_offset(const struct packing_data *pack,
+				      const struct object_entry *e)
+{
+	if (e->in_pack_location_is_offset)
+		return e->in_pack_location;
+
+	/*
+	 * Slow path where in_pack_location contains the object index
+	 * instead of offset. We perform one more lookup.
+	 */
+	return nth_packed_object_offset(IN_PACK(pack, e),
+					e->in_pack_location);
+}
+
+static inline void oe_set_in_pack_offset(struct packing_data *pack,
+					 struct object_entry *e,
+					 off_t offset)
+{
+	struct revindex_entry *revidx;
+
+	e->in_pack_location = offset;
+	if (e->in_pack_location == offset) {
+		e->in_pack_location_is_offset = 1;
+		return;
+	}
+
+	revidx = find_pack_revindex(IN_PACK(pack, e), offset);
+	e->in_pack_location = revidx->nr;
+	e->in_pack_location_is_offset = 0;
+}
+
 #endif
-- 
2.16.1.435.g8f24da2e1a

-- 8< --
