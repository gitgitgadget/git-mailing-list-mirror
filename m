Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253511F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfFXNC5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:02:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37998 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfFXNC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:02:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so4490272pgz.5
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pND3A6UIfQ+2CQ8yMVh4PK9XHBF8wkl1DDOK5kObOw=;
        b=beO71RVoKQij7JjZ4z4qDqsPOmoy23+5ZPTIFsupn/ASpbX1pRJF/1ioosKKCXrNZ6
         7sorBJCE8HHxmBuFwyX1yhSUCvmC27B+qwPplsjOGBJImk8XaOIcebWeiPwkLZ+egCzt
         Pnice7QebllDMMEiq+kv/bNXK+oRjWGBEkQj+hebiuKZGyOsYqS2ZwPa6Avza2Ep18cL
         ZWJq7w+62q3BQKcy75iXzgILeyQJQrJw7Q8w6vnMG79TGSvpDTtNogr0g9CoOn4YfSEa
         tQakSe1/wbv029fo/Vwl+cf2z8b5/KAcZ4LH5fvsJ/YN0ZI+vjrsXHjE9KTNAfvXXywk
         5lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pND3A6UIfQ+2CQ8yMVh4PK9XHBF8wkl1DDOK5kObOw=;
        b=hEPCYNBBPPKlkJdwiF1IzbQPq+AR0RIRbLDcj+ziJj41Pt0+EkzFp/P9bS9uzYF0Ef
         2Rd9YHBpeT01TtU/Nyhd3KsiC6zokJvJd5J3xQ1B/90gg9iaskxzivIGYMn6tuxxppOu
         fNNclg6gNoEwB5u2QhD2VPcg8tH9MIuACgACoESlz+gv3UMYTg17SrFePX3I3aQqomfY
         HiHd6qkTkZtkvtPmHNgkyt6oTgIFeyotzjdoyMtOfccDqMG4vZJbAGJVpjgwnXL00tXf
         N7lm6VmRNiWrOt+2NmsJDiUi/a3486Xa7Mx7wbSRmNuYVRf+/QzD5SEUMDzgHJbbGLe5
         7Bbw==
X-Gm-Message-State: APjAAAWp8vPGW3nIntJ99rTreHdIAsmmH4DWje41j+KViVe8vHlt/SGD
        Kt42FStaOHkQKEY8mSBYY/xqwYuU
X-Google-Smtp-Source: APXvYqwBmobABB4vMbjg9PasjnFKwrDttSrsPaLjAI8NCGVVuZ0H1olljFocKoA54IJYRovJg7/1eQ==
X-Received: by 2002:a17:90a:2567:: with SMTP id j94mr24874816pje.121.1561381376256;
        Mon, 24 Jun 2019 06:02:56 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id g2sm14061136pfb.95.2019.06.24.06.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:02:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:02:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/10] read-cache.c: dump common extension info in json
Date:   Mon, 24 Jun 2019 20:02:18 +0700
Message-Id: <20190624130226.17293-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624130226.17293-1-pclouds@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index db5147d088..4accd8bb08 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1694,8 +1694,26 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 }
 
 static int read_index_extension(struct index_state *istate,
-				const char *ext, const char *data, unsigned long sz)
+				const char *map,
+				unsigned long *offset)
 {
+	int ret = 0;
+	const char *ext = map + *offset;
+	uint32_t sz = get_be32(ext + 4);
+	const char *data = ext + 8;
+
+	if (istate->jw) {
+		char buf[5];
+
+		memcpy(buf, ext, 4);
+		buf[4] = '\0';
+		jw_object_inline_begin_object(istate->jw, buf);
+
+		jw_object_intmax(istate->jw, "file_offset", *offset);
+		jw_object_intmax(istate->jw, "ext_size", sz);
+	}
+	*offset += sz + 8;
+
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
 		istate->cache_tree = cache_tree_read(data, sz);
@@ -1704,8 +1722,7 @@ static int read_index_extension(struct index_state *istate,
 		istate->resolve_undo = resolve_undo_read(data, sz);
 		break;
 	case CACHE_EXT_LINK:
-		if (read_link_extension(istate, data, sz))
-			return -1;
+		ret = read_link_extension(istate, data, sz);
 		break;
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked = read_untracked_extension(data, sz);
@@ -1719,12 +1736,14 @@ static int read_index_extension(struct index_state *istate,
 		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
-			return error(_("index uses %.4s extension, which we do not understand"),
+			ret = error(_("index uses %.4s extension, which we do not understand"),
 				     ext);
-		fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
+		else
+			  fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
 		break;
 	}
-	return 0;
+	jw_end_gently(istate->jw);
+	return ret;
 }
 
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
@@ -1930,25 +1949,27 @@ static void *load_index_extensions(void *_data)
 {
 	struct load_index_extensions *p = _data;
 	unsigned long src_offset = p->src_offset;
+	int dump_json = 0;
 
 	while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
-		/* After an array of active_nr index entries,
+		if (p->istate->jw && !dump_json) {
+			jw_object_inline_begin_object(p->istate->jw, "extensions");
+			dump_json = 1;
+		}
+		/*
+		 * After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
 		 * sections, each of which is prefixed with
 		 * extension name (4-byte) and section length
 		 * in 4-byte network byte order.
 		 */
-		uint32_t extsize = get_be32(p->mmap + src_offset + 4);
-		if (read_index_extension(p->istate,
-					 p->mmap + src_offset,
-					 p->mmap + src_offset + 8,
-					 extsize) < 0) {
+		if (read_index_extension(p->istate, p->mmap, &src_offset) < 0) {
 			munmap((void *)p->mmap, p->mmap_size);
 			die(_("index file corrupt"));
 		}
-		src_offset += 8;
-		src_offset += extsize;
 	}
+	if (dump_json)
+		jw_end(p->istate->jw);
 
 	return NULL;
 }
-- 
2.22.0.rc0.322.g2b0371e29a

