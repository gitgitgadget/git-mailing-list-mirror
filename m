Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F08CCA47A
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 05:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiFPFEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiFPFEC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 01:04:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168D853712
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:04:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m24so292348wrb.10
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8NVEdeAslaWje9c2lM4NsWUuUpvssohcGa9xqMX7fBs=;
        b=aOFc9lKfyPSuUgMFIsNEUxnA+FrZMLlTLMM8j8UXQChRvnJH0JN5R74hbzeoh7k4zw
         c441hxbOINug+BQU7wfJEd90etFU8Ej9P2Abc+iNknOTF1qX6Irw7BXP/vN4jEs4f/Zq
         hR8UtXIcGDxO5AHwPze6FgpJ+KZ6TElv7wfeOsiIKZj7wmQ97hnORmk2AQggo388IAEF
         2seGmjooCrRG/wPFLgxYUT+uaZ9hJdKQoIIfwcPLZfp0EVnicPAMDLPnE4QTiqJLNgz4
         hQRdVZxIik3cTlf+nqfyQEV9hRv1ZQA7doJ+P80cZodtpkoO/6Bzj6YKkgzQs86EeJsD
         K/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8NVEdeAslaWje9c2lM4NsWUuUpvssohcGa9xqMX7fBs=;
        b=Lvrbo0yrjXmlrHs/c0rtxxGFZe4Dobf/VZMmuL6qm/Dq5S4DME4sQLFs39KLC+f8az
         zpxXAYMZcKPiDLrK58OHqg+Z4N4StARa8qXnfNYjDrpNipJOKa+MOrltKZYr228IuYik
         tzhixkdmp6MQpyuAovBPbTmVtI9wEPPcnkUr9vyesASpCc86xkO9pNfd/TdjnBAnmc6N
         LSqOIgclgSSqi2UopK7COSc+3zd8WsAEbRvTNJOl0HI5188dW9X265SAyl1GTlFGAfr7
         vDK2q8kctbPJfjIN9ED4RhIuJqp8PdF8uKMv589Uc/TLwzw/jcKAsaROa8WLU5nqqOr0
         8Gmw==
X-Gm-Message-State: AJIora/kPXnHy6FBWzmzoG3PRaexpPvyFCOljje1fsZ/MF0cYDq/jMfx
        v+LLC1afLGk3WIcW535m9vqMMk2IbuOJ6Q==
X-Google-Smtp-Source: AGRyM1uE0SVKjz4FFBdl8IkkJlpw6ZQeFvLdafwPpF5xddI+00dD6XAa9enWjSbinvJzd8uPKGy4qw==
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id f15-20020a0560001b0f00b00210313aef2amr2778811wrz.281.1655355839072;
        Wed, 15 Jun 2022 22:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d5263000000b0020ff7246934sm671302wrc.95.2022.06.15.22.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 22:03:58 -0700 (PDT)
Message-Id: <25512aa9c5b6d6df0c20c0400a0cac11afb64842.1655355834.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
References: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
        <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 05:03:53 +0000
Subject: [PATCH v4 2/3] bitmap-format.txt: fix some formatting issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

The asciidoc generated html for `Documentation/technical/bitmap-
format.txt` is broken. This is mainly because `-` is used for nested
lists (which is not allowed in asciidoc) instead of `*`.

Fix these and also reformat it for better readability of the html page.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 199 +++++++++++-----------
 1 file changed, 103 insertions(+), 96 deletions(-)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..49c8e819804 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -25,9 +25,9 @@ An object is uniquely described by its bit position within a bitmap:
 	is defined as follows:
 
 		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)
-
-	The ordering between packs is done according to the MIDX's .rev file.
-	Notably, the preferred pack sorts ahead of all other packs.
++
+The ordering between packs is done according to the MIDX's .rev file.
+Notably, the preferred pack sorts ahead of all other packs.
 
 The on-disk representation (described below) of a bitmap is the same regardless
 of whether or not that bitmap belongs to a packfile or a MIDX. The only
@@ -39,97 +39,104 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 == On-disk format
 
-	- A header appears at the beginning:
-
-		4-byte signature: {'B', 'I', 'T', 'M'}
-
-		2-byte version number (network byte order)
-			The current implementation only supports version 1
-			of the bitmap index (the same one as JGit).
-
-		2-byte flags (network byte order)
-
-			The following flags are supported:
-
-			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
-			This flag must always be present. It implies that the
-			bitmap index has been generated for a packfile or
-			multi-pack index (MIDX) with full closure (i.e. where
-			every single object in the packfile/MIDX can find its
-			parent links inside the same packfile/MIDX). This is a
-			requirement for the bitmap index format, also present in
-			JGit, that greatly reduces the complexity of the
-			implementation.
-
-			- BITMAP_OPT_HASH_CACHE (0x4)
-			If present, the end of the bitmap file contains
-			`N` 32-bit name-hash values, one per object in the
-			pack/MIDX. The format and meaning of the name-hash is
-			described below.
-
-		4-byte entry count (network byte order)
-
-			The total count of entries (bitmapped commits) in this bitmap index.
-
-		20-byte checksum
-
-			The SHA1 checksum of the pack/MIDX this bitmap index
-			belongs to.
-
-	- 4 EWAH bitmaps that act as type indexes
-
-		Type indexes are serialized after the hash cache in the shape
-		of four EWAH bitmaps stored consecutively (see Appendix A for
-		the serialization format of an EWAH bitmap).
-
-		There is a bitmap for each Git object type, stored in the following
-		order:
-
-			- Commits
-			- Trees
-			- Blobs
-			- Tags
-
-		In each bitmap, the `n`th bit is set to true if the `n`th object
-		in the packfile or multi-pack index is of that type.
-
-		The obvious consequence is that the OR of all 4 bitmaps will result
-		in a full set (all bits set), and the AND of all 4 bitmaps will
-		result in an empty bitmap (no bits set).
-
-	- N entries with compressed bitmaps, one for each indexed commit
-
-		Where `N` is the total amount of entries in this bitmap index.
-		Each entry contains the following:
-
-		- 4-byte object position (network byte order)
-			The position **in the index for the packfile or
-			multi-pack index** where the bitmap for this commit is
-			found.
-
-		- 1-byte XOR-offset
-			The xor offset used to compress this bitmap. For an entry
-			in position `x`, a XOR offset of `y` means that the actual
-			bitmap representing this commit is composed by XORing the
-			bitmap for this entry with the bitmap in entry `x-y` (i.e.
-			the bitmap `y` entries before this one).
-
-			Note that this compression can be recursive. In order to
-			XOR this entry with a previous one, the previous entry needs
-			to be decompressed first, and so on.
-
-			The hard-limit for this offset is 160 (an entry can only be
-			xor'ed against one of the 160 entries preceding it). This
-			number is always positive, and hence entries are always xor'ed
-			with **previous** bitmaps, not bitmaps that will come afterwards
-			in the index.
-
-		- 1-byte flags for this bitmap
-			At the moment the only available flag is `0x1`, which hints
-			that this bitmap can be re-used when rebuilding bitmap indexes
-			for the repository.
-
-		- The compressed bitmap itself, see Appendix A.
+    * A header appears at the beginning:
+
+        4-byte signature: :: {'B', 'I', 'T', 'M'}
+
+        2-byte version number (network byte order): ::
+
+            The current implementation only supports version 1
+            of the bitmap index (the same one as JGit).
+
+        2-byte flags (network byte order): ::
+
+            The following flags are supported:
+
+            ** {empty}
+            BITMAP_OPT_FULL_DAG (0x1) REQUIRED: :::
+
+            This flag must always be present. It implies that the
+            bitmap index has been generated for a packfile or
+            multi-pack index (MIDX) with full closure (i.e. where
+            every single object in the packfile/MIDX can find its
+            parent links inside the same packfile/MIDX). This is a
+            requirement for the bitmap index format, also present in
+            JGit, that greatly reduces the complexity of the
+            implementation.
+
+            ** {empty}
+            BITMAP_OPT_HASH_CACHE (0x4): :::
+
+            If present, the end of the bitmap file contains
+            `N` 32-bit name-hash values, one per object in the
+            pack/MIDX. The format and meaning of the name-hash is
+            described below.
+
+        4-byte entry count (network byte order): ::
+            The total count of entries (bitmapped commits) in this bitmap index.
+
+        20-byte checksum: ::
+            The SHA1 checksum of the pack/MIDX this bitmap index
+            belongs to.
+
+    * 4 EWAH bitmaps that act as type indexes
++
+Type indexes are serialized after the hash cache in the shape
+of four EWAH bitmaps stored consecutively (see Appendix A for
+the serialization format of an EWAH bitmap).
++
+There is a bitmap for each Git object type, stored in the following
+order:
++
+    - Commits
+    - Trees
+    - Blobs
+    - Tags
+
++
+In each bitmap, the `n`th bit is set to true if the `n`th object
+in the packfile or multi-pack index is of that type.
++
+The obvious consequence is that the OR of all 4 bitmaps will result
+in a full set (all bits set), and the AND of all 4 bitmaps will
+result in an empty bitmap (no bits set).
+
+    * N entries with compressed bitmaps, one for each indexed commit
++
+Where `N` is the total amount of entries in this bitmap index.
+Each entry contains the following:
+
+        ** {empty}
+        4-byte object position (network byte order): ::
+            The position **in the index for the packfile or
+            multi-pack index** where the bitmap for this commit is
+            found.
+
+        ** {empty}
+        1-byte XOR-offset: ::
+            The xor offset used to compress this bitmap. For an entry
+            in position `x`, a XOR offset of `y` means that the actual
+            bitmap representing this commit is composed by XORing the
+            bitmap for this entry with the bitmap in entry `x-y` (i.e.
+            the bitmap `y` entries before this one).
++
+NOTE: This compression can be recursive. In order to
+XOR this entry with a previous one, the previous entry needs
+to be decompressed first, and so on.
++
+The hard-limit for this offset is 160 (an entry can only be
+xor'ed against one of the 160 entries preceding it). This
+number is always positive, and hence entries are always xor'ed
+with **previous** bitmaps, not bitmaps that will come afterwards
+in the index.
+
+        ** {empty}
+        1-byte flags for this bitmap: ::
+            At the moment the only available flag is `0x1`, which hints
+            that this bitmap can be re-used when rebuilding bitmap indexes
+            for the repository.
+
+        ** The compressed bitmap itself, see Appendix A.
 
 == Appendix A: Serialization format for an EWAH bitmap
 
@@ -142,8 +149,8 @@ implementation:
 	- 4-byte number of words of the COMPRESSED bitmap, when stored
 
 	- N x 8-byte words, as specified by the previous field
-
-		This is the actual content of the compressed bitmap.
++
+This is the actual content of the compressed bitmap.
 
 	- 4-byte position of the current RLW for the compressed
 		bitmap
-- 
gitgitgadget

