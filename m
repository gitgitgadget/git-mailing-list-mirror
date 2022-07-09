Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C7C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiGIQ4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGIQ43 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 12:56:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1C17AAC
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 09:56:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so836519wmf.2
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AIc414NkNZyfJjsd+BKh8CRi5jTnJTakvuZ8AGuuDu0=;
        b=CXIqDUOss+1Pq+6rL+zzr1DWuDoK4KLVZ41Lgx8MfYNc4nBaW5VMQLanuf37NMDW2c
         wtcZN7ty5SHit5oUtPepqCiackoqzSBNzYMkb0xT2a3kevUWBR80hnk7T8gUkJKZypcq
         yxkp+TbPBmvHf6PsttC2vtZKB8Lpvcd93bnvZj72By9aMc7jlbPrKdwHhGezBVhDgkJX
         +/ySvj09dRJhLu5i7Vl6cE3j434maDmZHDE+rdycuSgXCIzG65tyEJ95V/W89AGyRKM3
         /0z87GnA+VE7ZrTQeRk46nf2Kge5OUX/YSBRb6esri6iIj/awBMJ88iZL9FaaBeErbug
         d0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AIc414NkNZyfJjsd+BKh8CRi5jTnJTakvuZ8AGuuDu0=;
        b=fZ9w0l/8jJtfpnbG3NC4nMRXPvjGHWWuviiqwTkts8dKfAK6WpXYlWRmox/8oO9eMJ
         QyC9xnrlVgU9v8owqf3Yr2BShDgGJe7pQoj4fYw0jApZDRVEMluZJINdb8CuZrrQ8LFA
         5eiuJD/lClwBteSYJ9ltmft3Yoe5J8rnGrP+cEALRU6khFbrPx8iiTw5uRUJ+2CMuVyL
         3w3oDdrgSkCQso2ck7+jHHfcfU9nplCAtmi3tF9zflWG0zz1UmVdKfZypBR3uBM1ZuKJ
         wals6ph9dhHrHzFWR7934qm/xQ/NG5gwWu8aFFLevw9mftoWV3duNkX7cHMUbVFQWkYZ
         15rw==
X-Gm-Message-State: AJIora9+eO9hZBxOJmjLQG1ETssKFenA8nKKkatSOH2G7kKB3It3rCWY
        RFqJe6KR6OGiTpvD5bXIj4HTyuojsAA=
X-Google-Smtp-Source: AGRyM1sBN8ODDeWNG8QKQOmtRI+FZ48eVTFrswVbEvkuYC9B8xjxKui5A5G5Ph0BJzUlxRyopQIVWA==
X-Received: by 2002:a05:600c:348f:b0:3a2:e369:9cc2 with SMTP id a15-20020a05600c348f00b003a2e3699cc2mr1219692wmq.166.1657385786575;
        Sat, 09 Jul 2022 09:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0039c4f53c4fdsm6584902wmq.45.2022.07.09.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 09:56:25 -0700 (PDT)
Message-Id: <63d3026adf8c490dc205fcec0e2d87b3ce74200e.1657385781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 16:56:20 +0000
Subject: [PATCH 3/4] glossary: add reachability bitmap description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/glossary-content.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index a9e69949a4e..6302df90563 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -500,6 +500,12 @@ exclude;;
 	<<def_tree_object,trees>> to the trees or <<def_blob_object,blobs>>
 	that they contain.
 
+[[def_reachability_bitmap]]reachability bitmaps::
+	Reachability bitmaps store information about the set of objects in
+	a packfile, or a multi-pack index (MIDX). A repository may have at
+	most one bitmap. The bitmap may belong to either one pack, or the
+	repository's multi-pack index (if it exists).
+
 [[def_rebase]]rebase::
 	To reapply a series of changes from a <<def_branch,branch>> to a
 	different base, and reset the <<def_head,head>> of that branch
-- 
gitgitgadget

