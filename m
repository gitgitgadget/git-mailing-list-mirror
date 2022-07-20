Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE0AC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiGTOFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGTOFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 10:05:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5BDE9E
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 07:05:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z13so6715638wro.13
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tuzgIEkmu5CcuDnt05w4QEo8w5u0tq3gF7F/WJurB4o=;
        b=FxKXQ4MFpwSNqctHSs8R61F7anPPg178ohEyPU+CwZfVKry/I4nlPlgHno+5ElKRE6
         c4MQZxqCEG/xGQagT+J5YygMsUpqE2J1qzssp70ECFAi25uh3EzMXUgs9f6JxTdmbYMK
         taXJLxiZO95/GUvfZkD/FadoK1jf3hHcrzJWG8ZdL25x8kT/957Ysu1Pop6eXB242gto
         +ZkCi5RKHEeXcyaUNDocJymUTPJDruET7DYb+qzuzE3/jOLqOZtfzDOzTf5sLaSKm701
         kSbs7B5Vg7o2eQCp5yI+EytY+TLJPPnBc9qGjWJZKkOKqs+exbwaWfeLykG1VdUTt6jm
         6xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tuzgIEkmu5CcuDnt05w4QEo8w5u0tq3gF7F/WJurB4o=;
        b=zEyzcEMwNNGwkh4Uet8UrYzPdB51DXgPkWHGPMYA4xa1aRJ/LQQc7H7y3jTumj6oTr
         EQtRa8ba8J+3ffK43k+0v5hSWrH5tGhXogcZFmR3K1KDfzf8WYGii7idZ9x689/9A0fQ
         c/2e/Mrt0YZdRgq7mBZu8TkClaiCznwHmveltb29cFWIndygJ7MkReGUzQ7aDfej8tg0
         g0gFa03xzH/gXzZK2EvpJLiHtOFKeWGZR6Cl7g3MbHXhTwGTdk8p1VYTTjnhKbWA/gFU
         hN31J9U7GYPS6KuuJ7nek5ascb9dQPbvClZloQf8WxFHzt9N0n5INuIK1F/lO052sNHh
         g8ig==
X-Gm-Message-State: AJIora+nQzSqT0hMY/llHRnKosYif89Zwl7ensIHFpWxin6gZynReWDW
        bOGh46M3QFhp4cWUTQWB79JYTdfnQyI=
X-Google-Smtp-Source: AGRyM1s3kavNjlTvq9D51R8csWuo10amz2tfJG5phX5A6sikXn6foeE04iVarjsrG+Fn++ZQ/Ggjpw==
X-Received: by 2002:a05:6000:1f19:b0:21d:a50f:212d with SMTP id bv25-20020a0560001f1900b0021da50f212dmr30917187wrb.578.1658325916359;
        Wed, 20 Jul 2022 07:05:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b003a2d6f26babsm2780066wmq.3.2022.07.20.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:05:15 -0700 (PDT)
Message-Id: <f72bf11e6efb4690ae808c0b56c3991c2b1ef266.1658325914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
References: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
        <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 14:05:08 +0000
Subject: [PATCH v4 1/6] Documentation/technical: describe bitmap lookup table
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

When reading bitmap file, Git loads each and every bitmap one by one
even if all the bitmaps are not required. A "bitmap lookup table"
extension to the bitmap format can reduce the overhead of loading
bitmaps which stores a list of bitmapped commit id pos (in the midx
or pack, along with their offset and xor offset. This way git can
load only the necessary bitmaps without loading the previous bitmaps.

Older versions of Git ignore the lookup table extension and don't
throw any kind of warning or error while parsing the bitmap file.

Add some information for the new "bitmap lookup table" extension in the
bitmap-format documentation.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-Authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..c30dc177643 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -67,6 +67,17 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			pack/MIDX. The format and meaning of the name-hash is
 			described below.
 
+			** {empty}
+			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
+			If present, the end of the bitmap file contains a table
+			containing a list of `N` <commit_pos, offset, xor_row>
+			triplets. The format and meaning of the table is described
+			below.
++
+NOTE: Unlike the xor_offset used to compress an individual bitmap,
+`xor_row` stores an *absolute* index into the lookup table, not a location
+relative to the current entry.
+
 		4-byte entry count (network byte order)
 
 			The total count of entries (bitmapped commits) in this bitmap index.
@@ -205,3 +216,31 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
 If implementations want to choose a different hashing scheme, they are
 free to do so, but MUST allocate a new header flag (because comparing
 hashes made under two different schemes would be pointless).
+
+Commit lookup table
+-------------------
+
+If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
+bytes (preceding the name-hash cache and trailing hash) of the `.bitmap`
+file contains a lookup table specifying the information needed to get
+the desired bitmap from the entries without parsing previous unnecessary
+bitmaps.
+
+For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
+contains a list of `nr_entries` <commit_pos, offset, xor_row> triplets
+(sorted in the ascending order of `commit_pos`). The content of i'th
+triplet is -
+
+	* {empty}
+	commit_pos (4 byte integer, network byte order): ::
+	It stores the object position of a commit (in the midx or pack
+	index).
+
+	* {empty}
+	offset (8 byte integer, network byte order): ::
+	The offset from which that commit's bitmap can be read.
+
+	* {empty}
+	xor_row (4 byte integer, network byte order): ::
+	The position of the triplet whose bitmap is used to compress
+	this one, or `0xffffffff` if no such bitmap exists.
-- 
gitgitgadget

