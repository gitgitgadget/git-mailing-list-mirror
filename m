Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3ED1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965207AbeCCCrx (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:53 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46469 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965205AbeCCCrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:52 -0500
Received: by mail-pf0-f193.google.com with SMTP id z10so4766314pfh.13
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MttltKY1sUKyt04Zsc2ojPUc28ReDULXJG6IQaXTFUk=;
        b=pUIMIwj+q0/vnulVRfX5qOrGA0tZkff2yKlw3m5osZm832s9G/0y7Dg3Wlv0FBjgBr
         a1xYDGy2LPY6vmIEM2Re3K4wIp1osDf+NOqcPfFcBOOnwA1UFawdnnPA5icbJ8SY7K0+
         N9obk9K0GtG9QMqxUVDRhRV/wzK4QLiJZWGPk9HBUr3i/rGh6T+uIP2hsBq0N+lJQ6gD
         blTt2r0jNdpUGU10rqAzE9/fNAjExOG/xv32SSWRujWBQaE9bAiRNWOWIJUWbEkquFfF
         TukrhCsESCXwPS9iB9DevgFtJvNHBp1kCtQbOsVVoIwOj9AkdEW/UbVjcrTYd0xdGHuI
         9h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MttltKY1sUKyt04Zsc2ojPUc28ReDULXJG6IQaXTFUk=;
        b=Juyb0hmAgWtBzUlheA/ft4Nhng2wbeMFYGBn4uXTO1A9Ue+Q5w53wrmH5DnQgztQhn
         taO4N2iEeUwWxe+bkeUB/IYNEDRhdThECoEaTqQTwxlhwodUsIh3GmLtNK9tjiS2BKfA
         qyLFCFdCl097rusRzaOrfEbcL/ThchnJ7rQR4XqfkPL8rI6wPZpvCnPWhicHq2dRjq33
         qzChT2oVmm6qbaQrZRal3FRy8ZvqTvopDfC2kdAZ7xjLGlkjt6Qra30+j0MdA3DBQMTt
         VwsVl+5NYkJ8GgFS3BkSBk+UCyCdtxVl5gfPN4x9F8LgjPR6DfadKVPQpBDcvX5lG1BS
         xJaw==
X-Gm-Message-State: APf1xPAlrAxNsbvdhAWOm1MwuX/zU38hUVOozHpZnNyS7A418uioWaXB
        zhPBk6Rzjjs92d+e/gzSYSmaBg==
X-Google-Smtp-Source: AG47ELsr1lvo1nDl22o+nhiCP8J0BpX4UIkARhWofX00EHqRzJxUYspH+pUtNLj1TgBn5YYUE6+x+g==
X-Received: by 10.98.200.80 with SMTP id z77mr7500101pff.85.1520045271023;
        Fri, 02 Mar 2018 18:47:51 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id p16sm15308620pfd.77.2018.03.02.18.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 7/9] pack-objects: move in_pack out of struct object_entry
Date:   Sat,  3 Mar 2018 09:47:04 +0700
Message-Id: <20180303024706.31465-8-pclouds@gmail.com>
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

Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
pack. Use an index isntead since the number of packs should be
relatively small.

This limits the number of packs we can handle to 16k. For now if you hit
16k pack files limit, pack-objects will simply fail [1].

This technically saves 7 bytes. But we don't see any of that in
practice due to padding. The saving becomes real when we pack this
struct tighter later.

[1] The escape hatch is .keep file to limit the non-kept pack files
    below 16k limit. Then you can go for another pack-objects run to
    combine another 16k pack files. Repeat until you're satisfied.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-pack-objects.txt |  9 +++++
 builtin/pack-objects.c             | 59 +++++++++++++++++++++++-------
 cache.h                            |  1 +
 pack-objects.h                     | 18 ++++++++-
 4 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 3503c9e3e6..b8d936ccf5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -269,6 +269,15 @@ Unexpected missing object will raise an error.
 	locally created objects [without .promisor] and objects from the
 	promisor remote [with .promisor].)  This is used with partial clone.
 
+LIMITATIONS
+-----------
+
+This command could only handle 16384 existing pack files at a time.
+If you have more than this, you need to exclude some pack files with
+".keep" file and --honor-pack-keep option, to combine 16k pack files
+in one, then remove these .keep files and run pack-objects one more
+time.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7bb5544883..5818bf73ca 100644
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
@@ -1024,7 +1024,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (*found_pack) {
 		want = want_found_object(exclude, *found_pack);
 		if (want != -1)
-			return want;
+			goto done;
 	}
 
 	list_for_each(pos, &packed_git_mru) {
@@ -1047,11 +1047,27 @@ static int want_object_in_pack(const struct object_id *oid,
 			if (!exclude && want > 0)
 				list_move(&p->mru, &packed_git_mru);
 			if (want != -1)
-				return want;
+				goto done;
 		}
 	}
 
-	return 1;
+	want = 1;
+done:
+	if (want && *found_pack && !(*found_pack)->index) {
+		struct packed_git *p = *found_pack;
+
+		if (to_pack.in_pack_count >= (1 << OE_IN_PACK_BITS))
+			die(_("too many packs to handle in one go. "
+			      "Please add .keep files to exclude\n"
+			      "some pack files and keep the number "
+			      "of non-kept files below %d."),
+			    1 << OE_IN_PACK_BITS);
+
+		p->index = to_pack.in_pack_count++;
+		to_pack.in_pack[p->index] = p;
+	}
+
+	return want;
 }
 
 static void create_object_entry(const struct object_id *oid,
@@ -1074,7 +1090,9 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		entry->in_pack = found_pack;
+		if (found_pack->index <= 0)
+			die("BUG: found_pack should be NULL instead of having non-positive index");
+		entry->in_pack_idx = found_pack->index;
 		entry->in_pack_offset = found_offset;
 	}
 
@@ -1399,8 +1417,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
-	if (entry->in_pack) {
-		struct packed_git *p = entry->in_pack;
+	if (IN_PACK(&to_pack, entry)) {
+		struct packed_git *p = IN_PACK(&to_pack, entry);
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
@@ -1535,14 +1553,16 @@ static int pack_offset_sort(const void *_a, const void *_b)
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
@@ -1578,7 +1598,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &entry->size;
 	oi.typep = &type;
-	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(&to_pack, entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
@@ -1848,8 +1868,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
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
@@ -2958,6 +2978,16 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
+static void init_in_pack_mapping(struct packing_data *to_pack)
+{
+	/* let IN_PACK() return NULL if in_pack_idx is zero */
+	to_pack->in_pack[to_pack->in_pack_count++] = NULL;
+	/*
+	 * the rest is lazily initialized only for packs that we want
+	 * in want_object_in_pack().
+	 */
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3190,6 +3220,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			}
 		}
 	}
+	init_in_pack_mapping(&to_pack);
 
 	if (progress)
 		progress_state = start_progress(_("Counting objects"), 0);
diff --git a/cache.h b/cache.h
index 862bdff83a..b90feb3802 100644
--- a/cache.h
+++ b/cache.h
@@ -1635,6 +1635,7 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
+	int index;		/* for builtin/pack-objects.c */
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 freshened:1,
diff --git a/pack-objects.h b/pack-objects.h
index 737e89b665..83d91a0765 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,10 +3,14 @@
 
 #define OE_DFS_STATE_BITS 2
 #define OE_DEPTH_BITS 12
+#define OE_IN_PACK_BITS 14
 
 #define IN_PACK_POS(to_pack, obj) \
 	(to_pack)->in_pack_pos[(struct object_entry *)(obj) - (to_pack)->objects]
 
+#define IN_PACK(to_pack, obj) \
+	(to_pack)->in_pack[(obj)->in_pack_idx]
+
 /*
  * State flags for depth-first search used for analyzing delta cycles.
  *
@@ -20,10 +24,14 @@ enum dfs_state {
 	DFS_NUM_STATES
 };
 
+/*
+ * The size of struct nearly determines pack-objects's memory
+ * consumption. This struct is packed tight for that reason. When you
+ * add or reorder something in this struct, think a bit about this.
+ */
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-	struct packed_git *in_pack;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
@@ -35,6 +43,7 @@ struct object_entry {
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
 	unsigned char in_pack_header_size; /* note: spare bits available! */
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
@@ -46,9 +55,12 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+
+	/* XXX 8 bits hole, try to pack */
+
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 112, bit_padding: 8 bits */
+	/* size: 112, padding: 4, bit_padding: 18 bits */
 };
 
 struct packing_data {
@@ -59,6 +71,8 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	int in_pack_count;
+	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.16.1.435.g8f24da2e1a

