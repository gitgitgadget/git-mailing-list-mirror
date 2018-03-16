Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA071F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeCPSdG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:33:06 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41561 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752893AbeCPSc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id m69-v6so16711285lfe.8
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qf9IH5G581u0dAg9ZdJPGeqRU6jxub9Pyw3k1elxaUE=;
        b=aIi8IlNPS2h1wjaoWEC98STIA+Yzbq2o818Ht/HQjNhvYF4+PIDA+/jq2fDTUZmDwA
         N37VOrtjvIuiom2pecQnh7fEM59Z1r4GU8Tq2jtMfP8qCqlA9rMC4e4NSbfEaeR50IFd
         xBojJ5M97OoVWlj6/ltQVD6nHShr0+WM6fnSsC6Cv1YAfYiMQ0cF2Ifzq2TnyheroUOE
         zDONzjfrWtrTdUfBhtSLb+R5bG89Z0H83/OVN75ze+muypPQ86dX5SLmRCvs7v0CsPnT
         EU4jRPVqfmieg003Kqdsd3uBgsg9l/5wfKWmmr1qqhZLYbWvAQp4/ijvx/fpEOAF38OA
         vEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qf9IH5G581u0dAg9ZdJPGeqRU6jxub9Pyw3k1elxaUE=;
        b=DaIlm9RrqS7oCfytron+ifh7K79yb/qMCQ4fX+wjvkipD7R6+3l4d1/oktpMedq3VF
         SikDqVkKKooXbIbICx6EoJ/DtwEAQNSO3Q9ZqZyswmpoSkfxZDBG2TDpo3LJ5cfXlLpN
         MiKhRXNvKbq8bFe4p4LkGR6aylbSidtcoxDSLzKyVlUIca54zPfLBJtjwm6iKZiJcyC6
         husZfxr/f9N9ftrSOyvLyt6jac83S3kPMIrq4oXnmSw2gkq/wNSLdXHADke3fjHDi485
         aBXbWJVLXNNmT0WdXdGi/SX7SYuAOrxq5ZN3p2ZPBKg2v9hO0nEgsBnjn28nM+HiGUSh
         R8Zg==
X-Gm-Message-State: AElRT7EHLuLoKzSyj6U2oGhTbc+eCgUVobAMP72eNKCoT+DeZx1hRPRL
        askHlmTaA5J5iuBASQjpMuM=
X-Google-Smtp-Source: AG47ELu6c0MENc6z9T1+7xHOJ3BzcVC5YVZB/yWrvgMzSKwDdrdHHdumBIo/TH+AVAgUMjUJ7GPowA==
X-Received: by 2002:a19:17d4:: with SMTP id 81-v6mr2062158lfx.22.1521225177187;
        Fri, 16 Mar 2018 11:32:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 11/11] pack-objects.h: reorder members to shrink struct object_entry
Date:   Fri, 16 Mar 2018 19:32:00 +0100
Message-Id: <20180316183200.31014-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316183200.31014-1-pclouds@gmail.com>
References: <20180308114232.10508-1-pclouds@gmail.com>
 <20180316183200.31014-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous patches leave lots of holes and padding in this struct. This
patch reorders the members and shrinks the struct down to 80 bytes
(from 136 bytes, before any field shrinking is done) with 16 bits to
spare (and a couple more in in_pack_header_size when we really run out
of bits).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index f430d938c6..0fa0c83294 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -70,35 +70,36 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	/* object uncompressed size _if_ size_valid is true */
-	uint32_t size_;
-	unsigned size_valid:1;
-	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+	void *delta_data;	/* cached delta (uncompressed) */
 	off_t in_pack_offset;
+	uint32_t hash;			/* name hint hash */
+	uint32_t size_;	/* object uncompressed size _if_ size_valid is true */
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	void *delta_data;	/* cached delta (uncompressed) */
 	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	uint32_t delta_size_valid:1;
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+	unsigned size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
+	unsigned type_valid:1;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
-	unsigned type_valid:1;
-	uint32_t hash;			/* name hint hash */
-	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
 				    * objects against.
 				    */
 	unsigned no_try_delta:1;
+	unsigned char in_pack_header_size;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
+
+	/* size: 80, bit_padding: 16 bits */
 };
 
 struct packing_data {
-- 
2.16.2.903.gd04caf5039

