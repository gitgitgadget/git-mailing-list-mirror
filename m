Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE201F42D
	for <e@80x24.org>; Fri, 11 May 2018 06:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeEKGzl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 02:55:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41282 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeEKGzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 02:55:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id m17-v6so1247940lfj.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 23:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nc96Wo6006f0DR9yG8tzj5EG1aGST5hk5EROW60qwoE=;
        b=J6jVCHbQSuHSopHOygLHnsASjH07TXKguyfeO9FNu5LwAq/PTGekpBQJzMIDi4rTxk
         W1iEVuSf1aZLmJ5P482G/Ic047mc/Lut43QLX3Iaipy7UPbNIYLKYYlcGm94Tty2d9JJ
         zH966UQOytR3F86diJdFM+l2nzDDCRV39kyCEhtbUk+wnITo0bgNOGiHUjlpwwp2FEyf
         9LjELSXJWHuM+eMamLk3XVrkkocas4lDRX82njw3GXc1i2q/gGUJH1+kfwZ3ZXPslvK9
         KVrd4Mxz3QBuF0GsSDH+MUT+d3z7Pps6rTMxq+DTnbhNya0/u64VP00qUeUbDzMIw+x/
         E8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nc96Wo6006f0DR9yG8tzj5EG1aGST5hk5EROW60qwoE=;
        b=N+TZASgmOSbNxQQsaRaLqCY/0LRpiQKsbCI2VqLll5stEIdoDTox3Hvx0qRK/4rfWw
         L5/kun2HLMsmLZmx+pI+/K7LNlTWu4ZklRnOFE4ca6CIXb58Kae/uJa13AEK2iZC4r2C
         fxhQZi080L4M/KlruX5Y3X+jn9KoLsTkmGisT0p0Ok0XStX80YMSJMvc4qaTEG2fvuCj
         ktXNh1iyZAitrhC3itpFyPpZ6nQVDKDorjlV+PK6RRD6Ksag/IaaIMzUGaWnaY9543P4
         egoO2EBXoPMc1rIs/w07pZmL7jOaOsVt+HuJJbkTZbMt8hWzT9RTWqGr1m+U+VHXo2+x
         /Kug==
X-Gm-Message-State: ALKqPwesmaPQw+94ILUDkEcsVwAuYy0p02FzxgWeKgFxoBjuI1IHJKyd
        ZlyNUP4+2O/sf5nCbfsoWzo=
X-Google-Smtp-Source: AB8JxZpt1+1ZJNA/syY5vN8WZVONKHoVDmxqe9UshnnKA47Skk6FVQ2SZPEfYg3Mn+UTfMFrhzjCOw==
X-Received: by 2002:a19:f00f:: with SMTP id p15-v6mr778522lfc.77.1526021738329;
        Thu, 10 May 2018 23:55:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e9-v6sm510364ljg.90.2018.05.10.23.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 23:55:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, sandals@crustytoothpaste.net, sbeller@google.com,
        stolee@gmail.com, sunshine@sunshineco.com
Subject: [PATCH v3] pack-format.txt: more details on pack file format
Date:   Fri, 11 May 2018 08:55:23 +0200
Message-Id: <20180511065523.7001-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510150939.25399-1-pclouds@gmail.com>
References: <20180510150939.25399-1-pclouds@gmail.com>
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
 Diff from v2

    diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
    index 00351cb822..70a99fd142 100644
    --- a/Documentation/technical/pack-format.txt
    +++ b/Documentation/technical/pack-format.txt
    @@ -56,27 +56,37 @@ blob. However to save space, an object could be stored as a "delta" of
     another "base" object. These representations are assigned new types
     ofs-delta and ref-delta, which is only valid in a pack file.
     
    -Both ofs-delta and ref-delta store the "delta" against another
    -object. The difference between them is, ref-delta directly encodes
    -20-byte base object name. If the base object is in the same pack,
    -ofs-delta encodes the offset of the base object in the pack instead.
    +Both ofs-delta and ref-delta store the "delta" to be applied to
    +another object (called 'base object') to reconstruct the object. The
    +difference between them is, ref-delta directly encodes 20-byte base
    +object name. If the base object is in the same pack, ofs-delta encodes
    +the offset of the base object in the pack instead.
    +
    +The base object could also be deltified if it's in the same pack.
    +Ref-delta can also refer to an object outside the pack (i.e. the
    +so-called "thin pack"). When stored on disk however, the pack should
    +be self contained to avoid cyclic dependency.
     
     The delta data is a sequence of instructions to reconstruct an object
    -from the base object. Each instruction appends more and more data to
    -the target object until it's complete. There are two supported
    -instructions so far: one for copy a byte range from the source object
    -and one for inserting new data embedded in the instruction itself.
    +from the base object. If the base object is deltified, it must be
    +converted to canonical form first. Each instruction appends more and
    +more data to the target object until it's complete. There are two
    +supported instructions so far: one for copy a byte range from the
    +source object and one for inserting new data embedded in the
    +instruction itself.
     
     Each instruction has variable length. Instruction type is determined
     by the seventh bit of the first octet. The following diagrams follow
     the convention in RFC 1951 (Deflate compressed data format).
     
    +==== Instruction to copy from base object
    +
       +----------+---------+---------+---------+---------+-------+-------+-------+
       | 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | size3 |
       +----------+---------+---------+---------+---------+-------+-------+-------+
     
     This is the instruction format to copy a byte range from the source
    -object. It encodes the offset to copy from any the number of bytes to
    +object. It encodes the offset to copy from and the number of bytes to
     copy. Offset and size are in little-endian order.
     
     All offset and size bytes are optional. This is to reduce the
    @@ -99,6 +109,8 @@ In its most compact form, this instruction only takes up one byte
     values zero. There is another exception: size zero is automatically
     converted to 0x10000.
     
    +==== Instruction to add new data
    +
       +----------+============+
       | 0xxxxxxx |    data    |
       +----------+============+
    @@ -108,6 +120,8 @@ object. The following data is appended to the target object. The first
     seven bits of the first octet determines the size of data in
     bytes. The size must be non-zero.
     
    +==== Reserved instruction
    +
       +----------+============
       | 00000000 |
       +----------+============

 Documentation/technical/pack-format.txt | 92 +++++++++++++++++++++++++
 cache.h                                 |  5 ++
 2 files changed, 97 insertions(+)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8e5bf60be3..70a99fd142 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -36,6 +36,98 @@ Git pack format
 
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
+Both ofs-delta and ref-delta store the "delta" to be applied to
+another object (called 'base object') to reconstruct the object. The
+difference between them is, ref-delta directly encodes 20-byte base
+object name. If the base object is in the same pack, ofs-delta encodes
+the offset of the base object in the pack instead.
+
+The base object could also be deltified if it's in the same pack.
+Ref-delta can also refer to an object outside the pack (i.e. the
+so-called "thin pack"). When stored on disk however, the pack should
+be self contained to avoid cyclic dependency.
+
+The delta data is a sequence of instructions to reconstruct an object
+from the base object. If the base object is deltified, it must be
+converted to canonical form first. Each instruction appends more and
+more data to the target object until it's complete. There are two
+supported instructions so far: one for copy a byte range from the
+source object and one for inserting new data embedded in the
+instruction itself.
+
+Each instruction has variable length. Instruction type is determined
+by the seventh bit of the first octet. The following diagrams follow
+the convention in RFC 1951 (Deflate compressed data format).
+
+==== Instruction to copy from base object
+
+  +----------+---------+---------+---------+---------+-------+-------+-------+
+  | 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | size3 |
+  +----------+---------+---------+---------+---------+-------+-------+-------+
+
+This is the instruction format to copy a byte range from the source
+object. It encodes the offset to copy from and the number of bytes to
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
+==== Instruction to add new data
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
+==== Reserved instruction
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

