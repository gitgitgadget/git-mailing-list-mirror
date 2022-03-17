Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F8FC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 03:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351310AbiCQDSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 23:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbiCQDSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 23:18:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA8520F77
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 20:16:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d7so5535667wrb.7
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ahZ5BMAE+CC4ogFJO+BKE7toN5aX/jwltR2QRCvh4uI=;
        b=Y575YgOL3PXWOrmt51u8LMva6IRYpNuZ5mus4XQWnexZ/oKjxLnbini0KqcT0yF0T0
         F93TFIzgjKYySdGVusTaEcrcNF9bbDmNViVQz4WDys7zyOIBl4cTFUV6+e2sbYJCXF2k
         NT5plG/j2b7WhH0P3+q58M/uQYyj6rUUSxaGmoO0kBn9+rba95m/2FZy7AZO8UFjNKLY
         JZirLMCER9ZRMw/adWRaXnedINiFxcLr1JGxWM0j59uBYHKC6I4CGtUi439V7uoctbTP
         6nLpxIDHIWOAsRhFY9OBrlVIgH53erUl2zbO79ltDVksstwJiYkUTrPE92z5Cbf0tH6J
         W6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ahZ5BMAE+CC4ogFJO+BKE7toN5aX/jwltR2QRCvh4uI=;
        b=THg/aL62c8uBEHcp42iseMDuOulaO+JwRhdIB59ptWoTnyeiEBBhL5Ou9HI3L6g5Dc
         KBnkZJLiV0FVhmykUBaeY2Ua6QzKqGO7QE2iHGGZ5OadevVo1KA10TI9Jajt07kJNnVM
         lJ5YYGZSUKeHsyW4nVDf5BhFEkNBpLMoq0X5kmfz0MgP2ehQoAmtp67hD+74Hm1jmLYv
         eR/HBuTQFnXeXkdM9VbjQWSui1wlHtr729gb27g20zFxppfkmX/kGaOBP2ETV+jZBbUo
         Sdyea/56wAXYZWicLJtKjUGylerfiKzPHof17+Avp+W1Hf2hrbN6ZuXNwPJ7hwILajn5
         rRnA==
X-Gm-Message-State: AOAM532wHL1C4KhEHiqAvCQ9jgE+P+LE6xTiQXcJ8pm/XhsTJgxkWU0U
        yB8QQSOEMPizhBdVq4UK/qNC9NURie0=
X-Google-Smtp-Source: ABdhPJyEuzPXwU/BlwJMKIdBkdQbn85Mfgbsp6UeccdTEorN29BdvosH2gK+ZB8bAgI8a+U4l5/fVA==
X-Received: by 2002:a05:6000:178d:b0:1f1:da46:9ce5 with SMTP id e13-20020a056000178d00b001f1da469ce5mr2067583wrg.119.1647487003513;
        Wed, 16 Mar 2022 20:16:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6688000000b001f04ae0bb6csm2779453wru.58.2022.03.16.20.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 20:16:43 -0700 (PDT)
Message-Id: <f658eb00bcd2429859bc7b0d3b19bfa8a7791ca8.1647487001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
        <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 03:16:40 +0000
Subject: [PATCH v3 1/2] rebase: use test_commit helper in setup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

To prepare for the next commit that will test rebase with oids instead
of branch names, update the rebase setup test to add a couple of tags we
can use. This uses the test_commit helper so we can replace some lines
that add a commit manually.

Setting logAllRefUpdates is not necessary because it's on by default for
repositories with a working tree.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3400-rebase.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 71b1735e1dd..0643d015255 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=bogus@email@address
 export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 
 test_expect_success 'prepare repository with topic branches' '
-	git config core.logAllRefUpdates true &&
-	echo First >A &&
-	git update-index --add A &&
-	git commit -m "Add A." &&
+	test_commit "Add A." A First First &&
 	git checkout -b force-3way &&
 	echo Dummy >Y &&
 	git update-index --add Y &&
@@ -32,9 +29,7 @@ test_expect_success 'prepare repository with topic branches' '
 	git mv A D/A &&
 	git commit -m "Move A." &&
 	git checkout -b my-topic-branch main &&
-	echo Second >B &&
-	git update-index --add B &&
-	git commit -m "Add B." &&
+	test_commit "Add B." B Second Second &&
 	git checkout -f main &&
 	echo Third >>A &&
 	git update-index A &&
-- 
gitgitgadget

