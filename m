Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C481F406
	for <e@80x24.org>; Thu, 10 May 2018 15:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966092AbeEJPJq (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 11:09:46 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41676 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965834AbeEJPJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 11:09:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id o123-v6so3449954lfe.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q88z8t9D29EEPxYsRPQzbtieeGFg5mNPbOw4IwbXM2w=;
        b=YbOn/zU4UhFaoBFu1b/IRxCZduf40fXsMbJvHRf95CjEJnlLFUJyFRpVpO/OBiRlJn
         rkOckd2ST7vUJHFblnt+TKa0DN+8tGxrS4MwjIO0q5Qg8E3Oko2/uTpC4MGKlnOr3aOs
         RdxdacWvHL2ZnPHaMp9BLfkC5HozZtv0XhMMFOSDkTRaCqQJDRmQJPt8xSWpDg2N3+KG
         XD6NlUcdRgludUb59mIDmgGTxBMIxx75ANvUkTSmzdk3WZQYHZ2uUKum47plWdYIZq0G
         chGWw2LpNqg7/nRGsk/GJCR7hpbL5Duy0lxbSMkGsiR03z3ZS17l7NowS2+mXh4V4ASp
         3EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q88z8t9D29EEPxYsRPQzbtieeGFg5mNPbOw4IwbXM2w=;
        b=E34m8thKqRzanSNtZct4WhKssU44aThO1ymBZnkjAJGQG/v2H02GCsw8CbuCFs/cBc
         c2Egkss5n29BzjxzoYZApoh3PlPpR3JILZDEIQOuyrYZbWVzGZaKcJIT2Cm8jLvyXSQR
         uihgc/pSaDv0HvLJJnj1ZnJ8Sferu6G8I/VSKFpbuX7hm1fajStk2xctfHTkc0fZkOqe
         SfSOVkMuRGuRX+SmSSnlHy4QYPz4F9lmBMRjXnhklJ7XXamUhEzXoyy3gEdzYft8TMU0
         mLJdwcnxW6Ug7n+jzg6QTtK3vmC0ybG9MgdBGyk5ZSG+RSj4o8JsyDZbmcyqka3/pbtd
         UYuw==
X-Gm-Message-State: ALKqPwf2sLof+vhwxmRQQQBIFcRgLsQ74t7KN8L5g0l2v+mld9OSJZ5+
        2Y02L/fuPm/vaE3jroEeO3Y=
X-Google-Smtp-Source: AB8JxZq7AyfpJEVmufQ9+Ck3hZfuXbjEYLhTdSY1SkRsjBLXcv5UyAxByuRfOuI2HJh/i/tdra1kkQ==
X-Received: by 2002:a19:f4d:: with SMTP id e74-v6mr1209258lfi.39.1525964983853;
        Thu, 10 May 2018 08:09:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm218045ljg.16.2018.05.10.08.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 08:09:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, sandals@crustytoothpaste.net, sbeller@google.com,
        stolee@gmail.com, sunshine@sunshineco.com
Subject: [PATCH v2] pack-format.txt: more details on pack file format
Date:   Thu, 10 May 2018 17:09:39 +0200
Message-Id: <20180510150939.25399-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180508155627.19245-1-pclouds@gmail.com>
References: <20180508155627.19245-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current document mentions OBJ_* constants without their actual
values. A git developer would know these are from cache.h but that's
not very friendly to a person who wants to read this file to implement
a pack file parser.

Similarly, the deltified representation is not documented at all (the
"document" is basically patch-delta.c). Translate that C code to
English with a bit more about what ofs-delta and ref-delta mean.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This is a much better description than v1. I hope.

 Documentation/technical/pack-format.txt | 78 +++++++++++++++++++++++++
 cache.h                                 |  5 ++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8e5bf60be3..d20bf592aa 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -36,6 +36,84 @@ Git pack format
 
   - The trailer records 20-byte SHA-1 checksum of all of the above.
 
+=== Object types
+
+Valid object types are:
+
+- OBJ_COMMIT (1)
+- OBJ_TREE (2)
+- OBJ_BLOB (3)
+- OBJ_TAG (4)
+- OBJ_OFS_DELTA (6)
+- OBJ_REF_DELTA (7)
+
+Type 5 is reserved for future expansion. Type 0 is invalid.
+
+=== Deltified representation
+
+Conceptually there are only four object types: commit, tree, tag and
+blob. However to save space, an object could be stored as a "delta" of
+another "base" object. These representations are assigned new types
+ofs-delta and ref-delta, which is only valid in a pack file.
+
+Both ofs-delta and ref-delta store the "delta" against another
+object. The difference between them is, ref-delta directly encodes
+20-byte base object name. If the base object is in the same pack,
+ofs-delta encodes the offset of the base object in the pack instead.
+
+The delta data is a sequence of instructions to reconstruct an object
+from the base object. Each instruction appends more and more data to
+the target object until it's complete. There are two supported
+instructions so far: one for copy a byte range from the source object
+and one for inserting new data embedded in the instruction itself.
+
+Each instruction has variable length. Instruction type is determined
+by the seventh bit of the first octet. The following diagrams follow
+the convention in RFC 1951 (Deflate compressed data format).
+
+  +----------+---------+---------+---------+---------+-------+-------+-------+
+  | 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | size3 |
+  +----------+---------+---------+---------+---------+-------+-------+-------+
+
+This is the instruction format to copy a byte range from the source
+object. It encodes the offset to copy from any the number of bytes to
+copy. Offset and size are in little-endian order.
+
+All offset and size bytes are optional. This is to reduce the
+instruction size when encoding small offsets or sizes. The first seven
+bits in the first octet determines which of the next seven octets is
+present. If bit zero is set, offset1 is present. If bit one is set
+offset2 is present and so on.
+
+Note that a more compact instruction does not change offset and size
+encoding. For example, if only offset2 is omitted like below, offset3
+still contains bits 16-23. It does not become offset2 and contains
+bits 8-15 even if it's right next to offset1.
+
+  +----------+---------+---------+
+  | 10000101 | offset1 | offset3 |
+  +----------+---------+---------+
+
+In its most compact form, this instruction only takes up one byte
+(0x80) with both offset and size omitted, which will have default
+values zero. There is another exception: size zero is automatically
+converted to 0x10000.
+
+  +----------+============+
+  | 0xxxxxxx |    data    |
+  +----------+============+
+
+This is the instruction to construct target object without the base
+object. The following data is appended to the target object. The first
+seven bits of the first octet determines the size of data in
+bytes. The size must be non-zero.
+
+  +----------+============
+  | 00000000 |
+  +----------+============
+
+This is the instruction reserved for future expansion.
+
 == Original (version 1) pack-*.idx files have the following format:
 
   - The header consists of 256 4-byte network byte order
diff --git a/cache.h b/cache.h
index 77b7acebb6..ad549e258e 100644
--- a/cache.h
+++ b/cache.h
@@ -373,6 +373,11 @@ extern void free_name_hash(struct index_state *istate);
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #endif
 
+/*
+ * Values in this enum (except those outside the 3 bit range) are part
+ * of pack file format. See Documentation/technical/pack-format.txt
+ * for more information.
+ */
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
-- 
2.17.0.705.g3525833791

