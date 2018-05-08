Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F14200B9
	for <e@80x24.org>; Tue,  8 May 2018 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755393AbeEHP4o (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 11:56:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46293 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755371AbeEHP4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 11:56:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id x7-v6so11611962lff.13
        for <git@vger.kernel.org>; Tue, 08 May 2018 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsW7QUoofldaXLZR7mn/naz8kXikcuI4EBCYzCaoPxY=;
        b=qISQCxgOz+h7KKrY9T2HwU2oSPO2JSdo3bw7k85GTFgoTJu3Un20IWWp8khoZ/7Sbu
         yFLFFrNVFkLBZJ5KUiShYrxiwbku/H39wsT1yNJnBUJnz3I6wuXuS7LQMVq8zGW7g3W2
         ePIWFPHA16Wmn2Y2+3LTmMiE/N0RbgTOruMkld5NN1U1a02MPwQKeDF27Z6Q3DqTp3Yb
         Bt6nYSMBF5UubOJ+379nTSnmCay9mw5UQu1UgD54vNGMi4t4mkoYH60hdS343TfBmqjY
         0fDe7IioryEDGwfBQiDuszgI2P1le3gmDbLMwu3wgJ73xKHbY12OXHgRcmmtf5bUOH6I
         arFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsW7QUoofldaXLZR7mn/naz8kXikcuI4EBCYzCaoPxY=;
        b=XYimarz7sClY2hKecAv+9ZM/lQHshhv0Z7fgCffx2+HM3cNPNQqt+S8CU11UL+lNxN
         CkdCjCZmCS3Gi26HtsgcymM3+4Rv1KF8fidilQuxmvrJXKhD7+PQGN5vqeoPfuJYDgwS
         7mbHYIN1iNY7rDLZeeAVb16wR6NdCiOO762SkQ6iWziOKcbyHf9E7LXsJzz7nxeQPL8n
         DYeSO1UtjHgNQMDN52ifBdpCdQtQuIyWuitSfwzAKMRDHvHCyU4g+IVC/PPTexQdQjPG
         37NNDtKH3tJqxhrXHvSr2gcYHsgwOz6QWaUvBEfu1mGmMQmX2myfpGbMdKk2lnfYl/0/
         wNyw==
X-Gm-Message-State: ALQs6tBvaL3L9bkri4H0NyBFE/4TQpGXHiGhatqTXxTW5wgJ8IkMAVVR
        s4ewHQuqJbkExyUnfnivevA=
X-Google-Smtp-Source: AB8JxZo5itsJPTkdiTHGbNq/zLddJJVJ7p3EEnnPR2lXoDN2MW0pDiuomLKY8+7RBQHkzpxS+mlBrg==
X-Received: by 2002:a19:6b15:: with SMTP id d21-v6mr25286152lfa.123.1525795001568;
        Tue, 08 May 2018 08:56:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p17-v6sm2636896ljc.72.2018.05.08.08.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 08:56:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, sandals@crustytoothpaste.net, sbeller@google.com,
        stolee@gmail.com, sunshine@sunshineco.com
Subject: [PATCH] pack-format.txt: more details on pack file format
Date:   Tue,  8 May 2018 17:56:27 +0200
Message-Id: <20180508155627.19245-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com>
References: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com>
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
"document" is basically patch-delta.c). Translate that C code in
English.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I noticed that these object type values are not documented in
 pack-format.txt so here's my attempt to improve it.

 While at there, I also add some text about this obscure delta format.
 We occasionally have questions about this on the mailing list if I
 remember correctly.

 Documentation/technical/pack-format.txt | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8e5bf60be3..2c7d5c0e74 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -36,6 +36,47 @@ Git pack format
 
   - The trailer records 20-byte SHA-1 checksum of all of the above.
 
+Valid object types are:
+
+- OBJ_COMMIT (1)
+- OBJ_TREE (2)
+- OBJ_BLOB (3)
+- OBJ_TAG (4)
+- OBJ_OFS_DELTA (6)
+- OBJ_REF_DELTA (7)
+
+Type 5 is reserved for future expansion.
+
+Deltified representation is a sequence of one byte command optionally
+followed by more data for the command. The following commands are
+recognized:
+
+- If bit 7 is set, the remaining bits in the command byte specifies
+  how to extract copy offset and size to copy. The following must be
+  evaluated in this exact order:
+  - If bit 0 is set, the following byte contains bits 0-7 of the copy
+    offset (this also resets all other bits in the copy offset to
+    zero).
+  - If bit 1 is set, the following byte contains bits 8-15 of the copy
+    offset.
+  - If bit 2 is set, the following byte contains bits 16-23 of the
+    copy offset.
+  - If bit 3 is set, the following byte contains bits 24-31 of the
+    copy offset.
+  - If bit 4 is set, the following byte contains bits 0-7 of the copy
+    size (this also resets all other bits in the copy size to zero_.
+  - If bit 5 is set, the following byte contains bits 8-15 of the copy
+    size.
+  - If bit 6 is set, the following byte contains bits 16-23 of the
+    copy size.
+
+  Copy size zero means 0x10000 bytes. The data from source object at
+  the given copy offset is copied back to the destination buffer.
+
+- If bit 7 is not set, it is the copy size in bytes. The following
+  bytes are copied to destination buffer
+- Command byte zero is reserved for future expansion.
+
 == Original (version 1) pack-*.idx files have the following format:
 
   - The header consists of 256 4-byte network byte order
-- 
2.17.0.705.g3525833791

