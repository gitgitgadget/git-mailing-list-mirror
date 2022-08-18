Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4EFC28B2B
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 06:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbiHRGRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 02:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbiHRGRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 02:17:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343F96FF0
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 23:17:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r16so541724wrm.6
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=GfuK3OfjqWycfIsAchRueEqPHtrs16kkw+UuZuK+2sM=;
        b=PAlJEpkMtHnKy/oBTVRF7tQxdOJBhsjGHQ6lJ4s453NkyP80XwRcD5R5E5D7Ypfttj
         z5TZ2D8Sx9nSwjBkuyb6ye+pDrpII2xnA6aHDSQRra6UMllN9qN7YKCG+onhmxIT8Z/N
         Sz9Cxoe7OznZEM+YzBLyVjmO61J/N41iyCZbQymNpLNWaLP1NxF+ahhRGi5DIcIBDxbF
         jLstMHKGhy5T6nHxMNOWtob7pv6vbPUzZ2NG+L1v0ow7XdNWYHN8grZjowgLnFUiIFqT
         L0nO9X+PGq+iXCrKghCALdJM5qcHMPhrmL6sTS0//gcznrUnAB472XIFFzCeKo7qCsQu
         YxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=GfuK3OfjqWycfIsAchRueEqPHtrs16kkw+UuZuK+2sM=;
        b=fL8aqtiS9hNL9QRi8EBeZA22n4LvGBXATq78ae6LQS/5NQS0ZrxAM19Saywu88xsre
         gcX7krJRsKcbdrJey1nJmPt7174IA2QufViuX2gXfxWeOYdDc9IJnJqID/jwI/7OqQN3
         NXrk8ngsdLNnCaXQsIz8Kf/oZUk8F2WewVrMs3FVin6GP3U1+cix3ngbajEgS/ktHTbB
         qTijsLTUDcmY1BP7GU9wg8BHYqvklYlqI1Ixlm5lHUWyp7JHNG3YqJzOU71M+z9/Nwdq
         D/DXPlsqZqIHC0o3ugS7rmyOynjLU0/P6C8bYz8Gql1y3Ad77LyA88GxkJzt8lVKKk8s
         qV9w==
X-Gm-Message-State: ACgBeo2IRFt0DVC5oorSf7TdPQPF09pil2YQo9NmoqKel+aPyKzlY9tw
        PwxjMLrRWzuLoR4M66GDXbKaq6uRJqU=
X-Google-Smtp-Source: AA6agR7ZE7YAkkD2GxW+sPb8nidui+N7vGQ04eEeFH8w9gMDhYZMusDxV4AKwZNz+kH+5oXmLhKWOA==
X-Received: by 2002:a05:6000:789:b0:225:142e:5b9d with SMTP id bu9-20020a056000078900b00225142e5b9dmr650962wrb.9.1660803469805;
        Wed, 17 Aug 2022 23:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a056000014e00b00223678fe95asm566317wrx.18.2022.08.17.23.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:17:49 -0700 (PDT)
Message-Id: <68ab719d99c68c81159c65ee42930a3023f275db.1660803467.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
        <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 06:17:46 +0000
Subject: [PATCH v2 1/2] rev-list-options.txt: fix simple typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..2f85726745a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -659,7 +659,7 @@ Here, the merge commits `O` and `P` contribute extra noise, as they did
 not actually contribute a change to `file.txt`. They only merged a topic
 that was based on an older version of `file.txt`. This is a common
 issue in repositories using a workflow where many contributors work in
-parallel and merge their topic branches along a single trunk: manu
+parallel and merge their topic branches along a single trunk: many
 unrelated merges appear in the `--full-history` results.
 
 When using the `--simplify-merges` option, the commits `O` and `P`
-- 
gitgitgadget

