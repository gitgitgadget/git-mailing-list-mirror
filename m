Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44742C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiGRKF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiGRKFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 06:05:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1C2ACA
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 03:05:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t1so18406653lft.8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyEggtzbax+W8LAq6rQTz7fkXdhPepW+fs7ghaaD9sg=;
        b=l+pwpZ/9hEgiATPBCTNbQeq42jObak4RpRGhdA1vKcBrdHazo/PgCp8oUy9hOqO650
         XsJurtUeyFRbwkf5XuJZDSYtzaD3Y+zFmP1Fx9nrhbkIua+tDTVZ/7w+S3JJhnJHxnrt
         0w5FdxRiy0d4zGPChomlo7FI6qKXNMZy4PRTg3fGHpZIfAt4QjUjGKb+LGxG7nrIZz4l
         LqCiLNIp4rpe4DSaNj5I30dQ9cibtSgyaJEluS24WcAj0DrYY8YIxFeeQ8PU44HDJEmE
         AwMpiSenhR5yN30XNZ6zL/RiV7dIcZ5Frvw5jzz4MviZL5P7JYD8zIJD3ktq4aAPYPbs
         aJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyEggtzbax+W8LAq6rQTz7fkXdhPepW+fs7ghaaD9sg=;
        b=R4YfNN55omtN3uGX3xHyCvQAFbaBAT0E2uqMCjuHnRZdTCCmPcU4POOoOb34fpi/VY
         WDujRPJ0LWcQI5rMOhDthIuB+U1uI7ChXQJPW7FIueBYlr+HupqkpAsHRZDpEsxUva+J
         PC3E0wG9+pxwjfj+KPXENJ8y9AO8puYdiMdT4F/1fcGB1TiDAFvHImHjxukVvZG9rfmO
         Euvr8K+Q70HVFhQs+ggfQwXrSOfdByu6UFiz4w6GS/7an7cP25FU/6EHV+Yzhj3kUDR/
         UYJMtU2drnklYlm7heSad37W5ZbIJqRWFMO4CUjvZgrmDAhTIE9tMzSsUl/S0bEJdYGi
         AApQ==
X-Gm-Message-State: AJIora8u6ZD+Koo+87+0TnFY+3b35yX8gkUuZxgtWPrf6N29V1IxcGjk
        khhoXwBzbdg6nlHj66TM4heJ+IgegUE=
X-Google-Smtp-Source: AGRyM1u8Npw2rBWHTqjHuisL3+jDqajfpvbKiL9ZKhovjfoe5u4wR0bzuPppWKquONAusBGiO0aBmQ==
X-Received: by 2002:a05:6512:344e:b0:489:f4ad:88d8 with SMTP id j14-20020a056512344e00b00489f4ad88d8mr15914948lfr.297.1658138752625;
        Mon, 18 Jul 2022 03:05:52 -0700 (PDT)
Received: from localhost.localdomain (81-231-137-145-no600.tbcn.telia.com. [81.231.137.145])
        by smtp.gmail.com with ESMTPSA id c12-20020a056512238c00b0047968606114sm2509482lfv.111.2022.07.18.03.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 03:05:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] config/core.txt: fix minor issues for `core.sparseCheckoutCone`
Date:   Mon, 18 Jul 2022 12:05:30 +0200
Message-Id: <20220718100530.2068354-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.37.1.373.g4dd4a117ec
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sparse checkout feature can be used in "cone mode" or "non-cone
mode". In this one instance in the documentation, we refer to the latter
as "non cone mode" with whitespace rather than a hyphen. Align this with
the rest of our documentation.

A few words later in the same paragraph, there's mention of "a more
flexible patterns". Drop that leading "a" to fix the grammar.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 BTW, Elijah, it seems like you've recently started using different
 e-mail addresses, even within the same series [1]. Not sure if that's
 intentional or not? I decided to cc the one you've used by far the most
 rather than spamming all of your accounts.

 [1] https://lore.kernel.org/git/pull.1268.v4.git.1656984823.gitgitgadget@gmail.com/

 Documentation/config/core.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 3ea3124f7f..37afbaf5a4 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -722,8 +722,8 @@ core.sparseCheckout::
 core.sparseCheckoutCone::
 	Enables the "cone mode" of the sparse checkout feature. When the
 	sparse-checkout file contains a limited set of patterns, this
-	mode provides significant performance advantages. The "non
-	cone mode" can be requested to allow specifying a more flexible
+	mode provides significant performance advantages. The "non-cone
+	mode" can be requested to allow specifying more flexible
 	patterns by setting this variable to 'false'. See
 	linkgit:git-sparse-checkout[1] for more information.
 
-- 
2.37.1.373.g4dd4a117ec

