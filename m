Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF241FAE2
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965204AbeCCCrr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:47 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39720 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965062AbeCCCrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id w16so3621240pgv.6
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wucAVc3CN/koghXX364FSgRGOdP86nD1tiVGBGWYnOY=;
        b=Nf8b0eZwqlgWp7h4t5b8Zo/1asNwH6ukwe3HTjEqLXjU37DLbvrRAcTA2zDjKziMuj
         3/i9+FZulWxeUxvxkTkwqLrQGRn/WeG/FKyDZ/RDLp9NssX66XXNcc7m257SxGoIhUsp
         GsAnXOnqY91mXdYoCglUmOt1w1+8OsCLc1qQBmvtIUm0Njyls38uSB3txT97+heMGUFC
         v1jDR1tAdg0QIzbY6/kFZeNDDmf5QAoVkZ5d1c7Oz3rd6b7sIO/NnRrx14LaPnubvrc0
         JTRcTlY/lQjPeB8mNUsP51Lx8n9pBP747H95TKM/fE+NVJG5kPAH9+NdNdh8xWljvpv8
         IY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wucAVc3CN/koghXX364FSgRGOdP86nD1tiVGBGWYnOY=;
        b=CDP3zpk5nwecGWsM3BPu6ZlzpFfoeSos87olopQTUpIurrfcD5O+j1awyP0ruotJvI
         RmiRyUu914x8z20iny7B9pdhiIEkEeK2PMA0GNzSC+IRx447Nlo5Sc6MaD0RVLk7sxce
         T05F9EOzx1+j13vFQ0skxcIt5yAUAhc2fdE+iOvStpz8QJHVQZEqC7qW6SONtwBBBUZr
         bYm3SNLeaAud40BQhw8oV5bivec+NgtvFPTp7dE8lcn8Eu+6midST0ieiCkucaMRzYDU
         E5O4gWlHefh9rbTqQfsYKBuYFlPrewO2y37yMOrqZEy9VMfEvCsMn+B/P7qYjd5fooTd
         MV0Q==
X-Gm-Message-State: APf1xPAg++kwF9K/6plsMiwHJc06ktj86YATyLWXJCG2YGlo4X2PbZAJ
        g7uuoIsVyOGfgfuAumt4VArdHg==
X-Google-Smtp-Source: AG47ELty21tiNy2Fu9utWmZcLTYfF97DxArSbEzskFVNzx+gL1p3J410Hldf7TkZXllo1oQXzWrMtA==
X-Received: by 10.101.97.26 with SMTP id z26mr6220064pgu.44.1520045265784;
        Fri, 02 Mar 2018 18:47:45 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t63sm16386029pfj.44.2018.03.02.18.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 6/9] pack-objects: move in_pack_pos out of struct object_entry
Date:   Sat,  3 Mar 2018 09:47:03 +0700
Message-Id: <20180303024706.31465-7-pclouds@gmail.com>
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

This field is only need for pack-bitmap, which is an optional
feature. Move it to a separate array that is only allocated when
pack-bitmap is used (it's not freed in the same way that objects[] is
not). This saves us 8 bytes in struct object_entry.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 3 ++-
 pack-bitmap-write.c    | 8 +++++---
 pack-bitmap.c          | 2 +-
 pack-bitmap.h          | 4 +++-
 pack-objects.h         | 8 ++++++--
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cfd97da7db..7bb5544883 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -878,7 +878,8 @@ static void write_pack_file(void)
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(oid.hash);
-				bitmap_writer_build_type_index(written_list, nr_written);
+				bitmap_writer_build_type_index(
+					&to_pack, written_list, nr_written);
 			}
 
 			finish_tmp_packfile(&tmpname, pack_tmp_name,
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e01f992884..1360a93311 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -48,7 +48,8 @@ void bitmap_writer_show_progress(int show)
 /**
  * Build the initial type index for the packfile
  */
-void bitmap_writer_build_type_index(struct pack_idx_entry **index,
+void bitmap_writer_build_type_index(struct packing_data *to_pack,
+				    struct pack_idx_entry **index,
 				    uint32_t index_nr)
 {
 	uint32_t i;
@@ -57,12 +58,13 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 	writer.trees = ewah_new();
 	writer.blobs = ewah_new();
 	writer.tags = ewah_new();
+	ALLOC_ARRAY(to_pack->in_pack_pos, to_pack->nr_objects);
 
 	for (i = 0; i < index_nr; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
 		enum object_type real_type;
 
-		entry->in_pack_pos = i;
+		IN_PACK_POS(to_pack, entry) = i;
 
 		switch (entry->type) {
 		case OBJ_COMMIT:
@@ -147,7 +149,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 			"(object %s is missing)", sha1_to_hex(sha1));
 	}
 
-	return entry->in_pack_pos;
+	return IN_PACK_POS(writer.to_pack, entry);
 }
 
 static void show_object(struct object *object, const char *name, void *data)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9270983e5f..f21479fe16 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1032,7 +1032,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		oe = packlist_find(mapping, sha1, NULL);
 
 		if (oe)
-			reposition[i] = oe->in_pack_pos + 1;
+			reposition[i] = IN_PACK_POS(mapping, oe) + 1;
 	}
 
 	rebuild = bitmap_new();
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3742a00e14..5ded2f139a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -44,7 +44,9 @@ int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bi
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
-void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);
+void bitmap_writer_build_type_index(struct packing_data *to_pack,
+				    struct pack_idx_entry **index,
+				    uint32_t index_nr);
 void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
diff --git a/pack-objects.h b/pack-objects.h
index fb2a3c8f48..737e89b665 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,9 @@
 #define OE_DFS_STATE_BITS 2
 #define OE_DEPTH_BITS 12
 
+#define IN_PACK_POS(to_pack, obj) \
+	(to_pack)->in_pack_pos[(struct object_entry *)(obj) - (to_pack)->objects]
+
 /*
  * State flags for depth-first search used for analyzing delta cycles.
  *
@@ -31,7 +34,6 @@ struct object_entry {
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
-	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
@@ -46,7 +48,7 @@ struct object_entry {
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 120, bit_padding: 8 bits */
+	/* size: 112, bit_padding: 8 bits */
 };
 
 struct packing_data {
@@ -55,6 +57,8 @@ struct packing_data {
 
 	int32_t *index;
 	uint32_t index_size;
+
+	unsigned int *in_pack_pos;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.16.1.435.g8f24da2e1a

