Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58CACCA47C
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 18:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiFGSC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350926AbiFGSBa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 14:01:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E217F14D7B1
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:43:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so9702559wmn.4
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CrFF6ZgyQNirS2ZOC0MhUXTEX+PprmCGACgxdgMJDUM=;
        b=aOFSiqv1n2aRJV6igzkUohiVxrc/lhUSCktOkBXrck73Um/RVLVjWLbDBlL/xc09lw
         cu7Xu0ORamZEqQ5vQjmXMjgytkTPg/k818gvmIuQQV1HC4dNHde/KjNauYMnQXEq0mcS
         FcAlU7A2O7wl+0YHv7v5NgwwzKlPIHBk5MkyyUk7Rx1meM00GA7gHcO4RXmQJSWm0anP
         49JPYGlQ3hfvRm16IvuG8orIYVUkvKxs06EdsWRFNpCaINSALy+gNnokYhfQCb9SaQ2s
         FT5f+mRdpXnMnqG0pOe17ddMKeFaKCY/W8OWRI0oClmm2E5/V8NN6bL59CzbxhdHabfV
         cTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CrFF6ZgyQNirS2ZOC0MhUXTEX+PprmCGACgxdgMJDUM=;
        b=zfrvwVmr+nAin+0z8u/wapQA13euIHshuHedL1EniNMrl2l4DJdyj5ToGe1vVuJ+U8
         ZBgYButXSUStM4KvOCXQCNpQmk7ZEQU8Mr4kzyct2Iu6oYYredRBFHUk5xTbdYiGk2io
         7lyOyt//lwpTXCIvaAldfbi0n2jugR2YBKiYrKZzjKC5cyhMo3sR9yYq1YAbzRtUQUF7
         jQTKL6dfkrllWGnya//PJ0b8BEYEjQStD4/2byL+rpC1MEVNEo6dXTgVrpWI17ibU5ry
         v85bPTJODYzzcwVmb3rDSCPuHvvcRS/KPCkqZCKZUnG9XpGUeQmET6WUY+MygE3LqOpG
         dJLA==
X-Gm-Message-State: AOAM532gXW++VadfF5Bamc8lFJ7TSiAJcIW9isQnx5qbrYmsblis0Jna
        Q9ahCLVIooH7bmKJD3/JTIAAHllZ7e6vQ/IC
X-Google-Smtp-Source: ABdhPJwlGeIyAD1f3BLo1uy4gSlRYe1Yl0Hnm6f7IwLtCx80Mu/GGFKfNjXhWTQ18Xz0ZxkeIvzULw==
X-Received: by 2002:a05:600c:3d94:b0:39c:1c04:3191 with SMTP id bi20-20020a05600c3d9400b0039c1c043191mr29569980wmb.171.1654623819996;
        Tue, 07 Jun 2022 10:43:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a1c2703000000b0039c4b518df4sm11014370wmn.5.2022.06.07.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:43:39 -0700 (PDT)
Message-Id: <2171d31fb2b783371bdc31ba54856dea8224de65.1654623814.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 17:43:34 +0000
Subject: [PATCH v2 3/3] bitmap-format.txt: add information for trailing
 checksum
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

Bitmap file has a trailing checksum at the end of the file. However
there is no information in the bitmap-format documentation about it.

Add a trailer section to include the trailing checksum info in the
`Documentation/technical/bitmap-format.txt` file.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index f22669b5916..a43d2fe2bbf 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -125,6 +125,10 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 		** The compressed bitmap itself, see Appendix A.
 
+	* TRAILER:
+
+		Index checksum of the above contents. It is a 20-byte SHA1 checksum.
+
 == Appendix A: Serialization format for an EWAH bitmap
 
 Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
-- 
gitgitgadget
