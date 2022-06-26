Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C07C43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiFZNKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiFZNKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:10:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189DB7C1
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i25so3882988wrc.13
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KYUcpt9cHi2agWK3matXO5G6OMok3RbTL6LJ8CCZF1w=;
        b=adE4bxGfTJYy3a5AZGmnH31oZ+WcGiFKy/N3CT32uSBx0cheiUmoJMRE4ocEGjX8au
         k3Ee3fvyazy5YR9qKbTQV8O77HTUjy6mBY+HNrFHcutrfEm8+mS8kQUffKxwpbAC/Hvr
         p9imOrp7qBk5g/N+IFb7774t3cWp3XWg15C7MynXOZ6tDf904NGQrOtSe5wmIH966gPe
         TcmOOJtISl5Y8Ln1veH+ityOCq7tdrmgCvwm4Jdvpzf2I6cEdSgMD1tEh9vLoeJ2gsfo
         ko00OHdrNWcizByla6U7p0LIogNZurImX2Namp44OCLp4nuZOZe2/FWvE/naSBvu+/G/
         Y91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KYUcpt9cHi2agWK3matXO5G6OMok3RbTL6LJ8CCZF1w=;
        b=X64oSBUZUhwLbpWJffkdjUN1wRMgfY3W1vF+GOBqqRu6aCN9yFZqPT4jvtCqB4hOHG
         ZTHShyrRAMK9fg67q8VKetr/tRR8Kgcm6BcLWl3esNGVjVPpa/AHyh1/YIB1iN5mV80T
         QNGQJ3/ep4Qlov+Ps2FNAOgbPw/HP1MhzLkihbkolhdKH0zrI0h2V/oAk/0GxOIg3W+W
         3ukK1WnEsynMErbTNUIbisbCWTjeF+YgeuXlu+s9a+11lVqUqlc/WembSsklQLlaL9vV
         zSBReJGGxAvD/JotHJJErru8RX9hL78iP/QSt4IA6o9WZne4p6K8cxQyOCMaLEquuKCM
         nOSg==
X-Gm-Message-State: AJIora9KdLdVrTogu68Q5yGX8Yjj+dIFMlwcxq38P+Ov16j3yEhYeIvG
        6AAmrr+VqMrAJfPVBVFqRBTpyzJQcWcq8g==
X-Google-Smtp-Source: AGRyM1vly/WZFwwDQtm/dFJ7bO+F8H9mqQw94tSkDC9Mvq9Vd6Cc2B8GbsE/AZmtZx6txX1zK07q9A==
X-Received: by 2002:a05:6000:798:b0:21b:8ca1:9b52 with SMTP id bu24-20020a056000079800b0021b8ca19b52mr7901286wrb.374.1656249020301;
        Sun, 26 Jun 2022 06:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r68-20020a1c2b47000000b0039c4b518df4sm11798044wmr.5.2022.06.26.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:10:19 -0700 (PDT)
Message-Id: <4d11be66cfa2cd667df56ab9260903a37900bd4c.1656249017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
        <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 13:10:12 +0000
Subject: [PATCH v2 1/6] Documentation/technical: describe bitmap lookup table
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

When reading bitmap file, git loads each and every bitmap one by one
even if all the bitmaps are not required. A "bitmap lookup table"
extension to the bitmap format can reduce the overhead of loading
bitmaps which stores a list of bitmapped commit id pos (in the midx
or pack, along with their offset and xor offset. This way git can
load only the neccesary bitmaps without loading the previous bitmaps.

The older version of Git ignores the lookup table extension and doesn't
throw any kind of warning or error while parsing the bitmap file.

Add some information for the new "bitmap lookup table" extension in the
bitmap-format documentation.

Co-Authored-by: Taylor Blau <me@ttaylorr.com>
Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..7d4e450d3d8 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -67,6 +67,19 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			pack/MIDX. The format and meaning of the name-hash is
 			described below.
 
+			** {empty}
+			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
+			If present, the end of the bitmap file contains a table
+			containing a list of `N` <commit pos, offset, xor offset>
+			triplets. The format and meaning of the table is described
+			below.
++
+NOTE: This xor_offset is different from the bitmap's xor_offset.
+Bitmap's xor_offset is relative i.e. it tells how many bitmaps we have
+to go back from the current bitmap. Lookup table's xor_offset tells the
+position of the triplet in the list whose bitmap the current commit's
+bitmap have to xor with.
+
 		4-byte entry count (network byte order)
 
 			The total count of entries (bitmapped commits) in this bitmap index.
@@ -205,3 +218,31 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
 If implementations want to choose a different hashing scheme, they are
 free to do so, but MUST allocate a new header flag (because comparing
 hashes made under two different schemes would be pointless).
+
+Commit lookup table
+-------------------
+
+If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
+(preceding the name-hash cache and trailing hash) of the `.bitmap` file
+contains a lookup table specifying the information needed to get the
+desired bitmap from the entries without parsing previous unnecessary
+bitmaps.
+
+For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
+contains a list of `nr_entries` <commit pos, offset, xor offset> triplets.
+The content of i'th triplet is -
+
+	* {empty}
+	commit pos (4 byte integer, network byte order): ::
+	It stores the object position of the commit (in the midx or pack index)
+	to which the i'th bitmap in the bitmap entries belongs.
+
+	* {empty}
+	offset (8 byte integer, network byte order): ::
+	The offset from which that commit's bitmap can be read.
+
+	* {empty}
+	xor offset (4 byte integer, network byte order): ::
+	It holds the position of the triplet with whose bitmap the
+	current bitmap need to xor. If the current triplet's bitmap
+	do not have any xor bitmap, it defaults to 0xffffffff.
-- 
gitgitgadget

