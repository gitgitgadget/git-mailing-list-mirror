Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC1D1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeDNPfs (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43531 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDNPfo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so16386909lfa.10
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=codqrZDsPyahEk4Q1ItMTaLcvq1RHmSKvc9flEbDOfU=;
        b=FuJGQz9uFlCXIxJ378RnQCa49IqFvIZRkUzHxNbUK9pjn7Vtg3Tmo/kH795fUIW/7b
         f9c1GAKI27Zv6uz32GsUMuhlKwFdFrs0lfYbRfayEJmK5Arep0Uxx9O2xbD46lEbxXNo
         GrIE/p/kWSsUEL4WKeVaImwtOcrB6gQaAKyPXJZTUujFZfYqgQLTsh+vZFquJPD4JCpF
         X38+JwhMGpZUyEhN0Xv+bq5aLorKsAnu4l14M+8GZL7x4WRDjtCEsptb/yp1gvi2GOdg
         HodMZvPT7j0KI4q2NGPHJ7y9G9lvko+L3oa16WSH2h7oCUjZ6Ch3ptA1dzcvO3x8p8Hi
         +MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=codqrZDsPyahEk4Q1ItMTaLcvq1RHmSKvc9flEbDOfU=;
        b=kFwXD1TdrGmqL2bwTeLcpZ24qWPZWz2N4o5GgrBWHD3z4QqrKjHrLDZpU8hCJ2t/1x
         7CzORNfzMxtE7Rb+FgZHH15I1f+PztGL5mDWcnDowl1JLtg4+6VzJuBOmiKW2OZ56h0o
         TTfz5QvbGY+BaUdBUB/8YSR2JwoYp03BDKCv7gew3zvAlDI5IxcDXMaGwmXue4KFflaQ
         ceWJ9giSpWmgldMYGB4AiTHrG2mkC1p2H9cYKcqtIBBOmA4Jtjn7Nlk0ZYnq0YDAIqOP
         N7m5GJiDrqvt8McoWhKOy+H/kjgWmg7F3u2z8lL/PEy50uPtKIKZ2gU8oaR3smJkdqhz
         osWQ==
X-Gm-Message-State: ALQs6tAODarrzJqde1OiYQI8to20sUENwN/yjFd+uTjQuifNExslR6kJ
        iDcUEvdy3I213T85PBbhfDRDSQ==
X-Google-Smtp-Source: AIpwx4+SE73qy0mFDevC0TcPI1cjlT4j2JfAHRgJ0Hea4owdA+8RxS+8Sqjzb1T7Vabolt99Ucldyw==
X-Received: by 2002:a19:c4c8:: with SMTP id u191-v6mr11370364lff.109.1523720142448;
        Sat, 14 Apr 2018 08:35:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/15] pack-objects: reorder members to shrink struct object_entry
Date:   Sat, 14 Apr 2018 17:35:12 +0200
Message-Id: <20180414153513.9902-15-pclouds@gmail.com>
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

Previous patches leave lots of holes and padding in this struct. This
patch reorders the members and shrinks the struct down to 80 bytes
(from 136 bytes on 64-bit systems, before any field shrinking is done)
with 16 bits to spare (and a couple more in in_pack_header_size when
we really run out of bits).

This is the last in a series of memory reduction patches (see
"pack-objects: a bit of document about struct object_entry" for the
first one).

Overall they've reduced repack memory size on linux-2.6.git from
3.747G to 3.424G, or by around 320M, a decrease of 8.5%. The runtime
of repack has stayed the same throughout this series. Ævar's testing
on a big monorepo he has access to (bigger than linux-2.6.git) has
shown a 7.9% reduction, so the overall expected improvement should be
somewhere around 8%.

See 87po42cwql.fsf@evledraar.gmail.com on-list
(https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/) for
more detailed numbers and a test script used to produce the numbers
cited above.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index 1c588184b2..e5456c6c89 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -28,6 +28,10 @@ enum dfs_state {
 };
 
 /*
+ * The size of struct nearly determines pack-objects's memory
+ * consumption. This struct is packed tight for that reason. When you
+ * add or reorder something in this struct, think a bit about this.
+ *
  * basic object info
  * -----------------
  * idx.oid is filled up before delta searching starts. idx.crc32 is
@@ -76,34 +80,44 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
+	void *delta_data;	/* cached delta (uncompressed) */
+	off_t in_pack_offset;
+	uint32_t hash;			/* name hint hash */
 	unsigned size_:OE_SIZE_BITS;
 	unsigned size_valid:1;
-	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
-	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	unsigned delta_size_valid:1;
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
+	unsigned type_valid:1;
 	unsigned type_:TYPE_BITS;
+	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
-	unsigned type_valid:1;
-	uint32_t hash;			/* name hint hash */
-	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
 				    * objects against.
 				    */
-	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
+
+	/*
+	 * pahole results on 64-bit linux (gcc and clang)
+	 *
+	 *   size: 80, bit_padding: 20 bits, holes: 8 bits
+	 *
+	 * and on 32-bit (gcc)
+	 *
+	 *   size: 76, bit_padding: 20 bits, holes: 8 bits
+	 */
 };
 
 struct packing_data {
-- 
2.17.0.367.g5dd2e386c3

