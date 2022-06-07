Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EFC43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 18:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiFGSC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350975AbiFGSBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 14:01:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F914D7A1
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:43:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q15so17128888wrc.11
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IcfZf7U8oYz8qZGfEuk/I+bjC6KUsUCW99d2MJsH2Pc=;
        b=hDlAoyJEz8cB/7cbzKrlqbfoCpF95ICEYTuGWOOBIXBqGEwp2GfUjAG9qPDYNYomUC
         eyrmYlY/CzkcUo9eZsQ/utdX44xo2bighVkGLE7ZHKem0oxM28jnRCpdInCMaZbTIvzo
         iYT7bPwVypd8a/0aeMkUUr0yiKQak055ITgTBO+ZJf3ab7GfQ5vueN5pZjzvWFZ1j6SJ
         SUX/dspinHXUQ0+rzCvFb1cLi+d3Ot+GIY1y1fbx2sgILkENwQkItjXkBOM96Uz3eT7W
         12ReFrrjcIy4tMd1KImME7j3p6nuVnnAuD6dXDPhF9I6hOWqracYbDYKbCrE7AToGa8b
         QwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IcfZf7U8oYz8qZGfEuk/I+bjC6KUsUCW99d2MJsH2Pc=;
        b=HHxoInVtTD7ed0wM4CSzNY3k4wqWwr/HjUh32Sfs5RjC/0NeIP4tK4Q27kfiJaf8F7
         UvRJKJz8sTg1bDO48vnR7d67XSj/OiJZTtMdYcNFENtDyinetjPo60PeC/rmK3ECAY5a
         qbaOFlrWdlCDbJswN2YwjuaqFLaIjexa7t73aifu/b8CB+0LvKvgadwKJAopU1g+1Ck6
         lqjv3lXkVcQkz+VRtEvaG8uhacTulbaqw5h0Jir8EcSj44Qd16l/HCzj3i7qex39m7AR
         iXesyRZQSkbg7HVUCyCjrrNeovyTdgGF+CzcHJMa8AadBVvumMc8aRHuK+XA8wfkzgBo
         tfUA==
X-Gm-Message-State: AOAM530GgTaYbMXq/LkpHgWCBsm9bRDPgVy/B5dNVhiNf23itXBi2t5+
        MuezCt6x90fgncDUmJtXtGTDdwAgDGCl8Qqu
X-Google-Smtp-Source: ABdhPJy8pfoWFUwCR9+EqjhkcPmbW5TL/FWZSLKPnJ6efxanrikLD0u/jOz7KG+uDe2MixsbQ8+3Ew==
X-Received: by 2002:adf:dc87:0:b0:216:cfca:65d with SMTP id r7-20020adfdc87000000b00216cfca065dmr17252459wrj.316.1654623818798;
        Tue, 07 Jun 2022 10:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b0039c50d2d28csm6142334wmq.44.2022.06.07.10.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:43:38 -0700 (PDT)
Message-Id: <cb919513c14d426b51051ee5c16badec37538032.1654623814.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 17:43:33 +0000
Subject: [PATCH v2 2/3] bitmap-format.txt: fix some formatting issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Vicent Marti <tanoku@gmail.com>,
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

Fix these and also reformat it (e.g. removing some blank lines) for
better readability of the html page.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..f22669b5916 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -39,7 +39,7 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 == On-disk format
 
-	- A header appears at the beginning:
+	* A header appears at the beginning:
 
 		4-byte signature: {'B', 'I', 'T', 'M'}
 
@@ -48,9 +48,7 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			of the bitmap index (the same one as JGit).
 
 		2-byte flags (network byte order)
-
 			The following flags are supported:
-
 			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
 			This flag must always be present. It implies that the
 			bitmap index has been generated for a packfile or
@@ -60,7 +58,6 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			requirement for the bitmap index format, also present in
 			JGit, that greatly reduces the complexity of the
 			implementation.
-
 			- BITMAP_OPT_HASH_CACHE (0x4)
 			If present, the end of the bitmap file contains
 			`N` 32-bit name-hash values, one per object in the
@@ -68,15 +65,13 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			described below.
 
 		4-byte entry count (network byte order)
-
 			The total count of entries (bitmapped commits) in this bitmap index.
 
 		20-byte checksum
-
 			The SHA1 checksum of the pack/MIDX this bitmap index
 			belongs to.
 
-	- 4 EWAH bitmaps that act as type indexes
+	* 4 EWAH bitmaps that act as type indexes
 
 		Type indexes are serialized after the hash cache in the shape
 		of four EWAH bitmaps stored consecutively (see Appendix A for
@@ -84,7 +79,6 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 		There is a bitmap for each Git object type, stored in the following
 		order:
-
 			- Commits
 			- Trees
 			- Blobs
@@ -97,17 +91,17 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 		in a full set (all bits set), and the AND of all 4 bitmaps will
 		result in an empty bitmap (no bits set).
 
-	- N entries with compressed bitmaps, one for each indexed commit
+	* N entries with compressed bitmaps, one for each indexed commit
 
 		Where `N` is the total amount of entries in this bitmap index.
 		Each entry contains the following:
 
-		- 4-byte object position (network byte order)
+		** 4-byte object position (network byte order)
 			The position **in the index for the packfile or
 			multi-pack index** where the bitmap for this commit is
 			found.
 
-		- 1-byte XOR-offset
+		** 1-byte XOR-offset
 			The xor offset used to compress this bitmap. For an entry
 			in position `x`, a XOR offset of `y` means that the actual
 			bitmap representing this commit is composed by XORing the
@@ -124,12 +118,12 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			with **previous** bitmaps, not bitmaps that will come afterwards
 			in the index.
 
-		- 1-byte flags for this bitmap
+		** 1-byte flags for this bitmap
 			At the moment the only available flag is `0x1`, which hints
 			that this bitmap can be re-used when rebuilding bitmap indexes
 			for the repository.
 
-		- The compressed bitmap itself, see Appendix A.
+		** The compressed bitmap itself, see Appendix A.
 
 == Appendix A: Serialization format for an EWAH bitmap
 
-- 
gitgitgadget

