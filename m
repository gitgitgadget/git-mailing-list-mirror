Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB8C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbiHRVlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbiHRVk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:40:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3FBD741
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ba1so3142564wrb.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Pmssy3NMTu/rhL8RVFQSIiSxL7vJcmdwCs/n+zYEl+0=;
        b=gNbfHMIIM8jDCrD9+jiSK2MzDqg3tDoybh23xSXm1BfFuZnXv+RpxqxsaIs9XPEvy7
         OXZ93QMIMpsyZ63vuHEsIelOW3vCoRynN7aH86sPJ9L62WSxVPVOAvyZOCNwn/dqM/bl
         BqjnffZaDFCsiqiJ9A8MCmQ58xU0eT8bwaqbb5RcNiOc7fu8XBc7mFsD1vyGokyJcRR4
         +57l+fHLzDJtMPQfaSYYzU+tskvtvb91cOFCeWNsqX/IRH12vsSfzPK4DQBFrbUg+Tjv
         IejqDq1LKULNC8Iq/1I0ajBdNvsAOn+7Gqa9PAE0/Rl7Mb57W5FYN0Bd9x9YQF+TRfH2
         g0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Pmssy3NMTu/rhL8RVFQSIiSxL7vJcmdwCs/n+zYEl+0=;
        b=hmwqSj0/qSH1iZ6IJTticyZzA7VWQIo17gni4P64RSqWCM96uVN2t38sroDxa8jSR/
         4NKnmgulsgBAwsOFb134TCdNmLnpPL3oN2PvMTO1HYgivEO4YWMpeld+/AmBn/S9fkRo
         MC8V4cOxg3Tpsl8WjP+35dzFfkgh0sdTJSTxj+7gPqaXzMw3C0mowbEqQuMVDKam2DKj
         iQGTnw3cGeVTtQOkWBWn1aG2jQ5XrbvIC5aIXMBCCaAcCxMb6GOFJ3hMvxh9BpQS0Q2/
         DniINCwOFCj5ManjVGP9AI9SdJTYyicOM3Hf6+QvdQOhqFJYr9OwaPxIF0IwleJteLSz
         e+RA==
X-Gm-Message-State: ACgBeo05lzNmESrdzo2BT3aboZQjF6mhPUA44hp7M5jpA/0YteNC0T09
        mgPSj5+wCYagJd0wzAW5STT4JKUF4PA=
X-Google-Smtp-Source: AA6agR4/L4jeSJxSAUbycGGZCMv9u3ZNSnZXL5z19gvHOxb4NvSD333+zOg4wQJdpg3oJSlyCFvHyw==
X-Received: by 2002:a5d:5989:0:b0:221:7c34:3943 with SMTP id n9-20020a5d5989000000b002217c343943mr2425847wri.441.1660858857332;
        Thu, 18 Aug 2022 14:40:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az14-20020a05600c600e00b003a536d5aa2esm3474032wmb.11.2022.08.18.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:40:56 -0700 (PDT)
Message-Id: <a6bb0113b9c2eaf0cabc4079bd0928e04c07a96c.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:47 +0000
Subject: [PATCH v3 2/8] scalar-unregister: handle error codes greater than 0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When 'scalar unregister' tries to disable maintenance and remove an
enlistment, ensure that the return value is nonzero if either operation
produces *any* nonzero return value, not just when they return a value less
than 0.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 92b648f3511..8ef8dd55041 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -223,10 +223,10 @@ static int unregister_dir(void)
 {
 	int res = 0;
 
-	if (toggle_maintenance(0) < 0)
+	if (toggle_maintenance(0))
 		res = -1;
 
-	if (add_or_remove_enlistment(0) < 0)
+	if (add_or_remove_enlistment(0))
 		res = -1;
 
 	return res;
-- 
gitgitgadget

