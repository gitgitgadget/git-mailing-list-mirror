Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E12DC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 22:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjGMWB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGMWB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 18:01:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6EC0
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 15:01:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1370539f8f.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689285684; x=1691877684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=STmDjZMapDc38UrI4UEFa8eXLieXDqRvOgKxZoTxf0s=;
        b=Qwa6/vSRucVAfiyQgPLeDorYCX0W7fB0XOGzGvM+JjObXh2QxoNU4islCuobrlEJJR
         a27t5/tNP+nyOrqhj0XHxA4TiKEi3gwS7KEeP6M4mN4KVnC5uNBnzzsNvHwQQg/fiKFa
         gZvNij5pks83EaB5dkKS/22Yxowb3QoLUsJo3MVznqe+Cj4LiV/n1adldgkMz8TGbOdt
         0DYFaNclURLUrGJtrQfVOUs6EQzo3wQgseP+Q1Ys87sKG5/F5AL8xj9Sjm/j3TB0wNPe
         hbLzscGwA7mp1SjsxaLoZoQkfx8snPFotahsz+OoWZJPJcjBgm5ra0QWUKBDRwccXYnB
         gzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689285684; x=1691877684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STmDjZMapDc38UrI4UEFa8eXLieXDqRvOgKxZoTxf0s=;
        b=GAEKZtdDdDxEl0uiae0pHIpB0R5qubciR0RE7XoGxwjh+05YgZgmVSRLw208O8LZ6y
         7Ul+unnp+A0oBz30Z5XejP8nsaUS2m2HJhMY+q1JhVaYsYs+oErZfXEKIGvgG/xrYZLQ
         QkjC8ms+ADFey7g9U5OnSTvLCxPfAcn5xSTbF5iTM76KimaccUfytbaokhFvwqgQoaKi
         /Om1sbfelhlRPGNHIOOjDUU+tZBmwTUGONtf9pSuE7iiR467yG+ef7MfxregxVGUam5F
         h6Vy5i161/sMgfbHj99DJze7zq46ns5dlCqiY68M7y1FzEXktvkTEz5mLP4+4/wQWlqr
         k4rA==
X-Gm-Message-State: ABy/qLaQ+01nzjsJvZZZziUpcoO8fDD2MOmiGe5M/JmCB8/aZXtX54Bv
        tmJZPdk3XHnwPM+qVWsx1Bqcm5E9C2A=
X-Google-Smtp-Source: APBJJlGcQYfxosdQ2/TU0RFG3zdhG3OzM3+OBwNk5fRi/s9CvkOipjunOYyvc2Y3LKMag+SaqptLrg==
X-Received: by 2002:a5d:4ac5:0:b0:314:1318:18b7 with SMTP id y5-20020a5d4ac5000000b00314131818b7mr2470748wrs.19.1689285684038;
        Thu, 13 Jul 2023 15:01:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0031416362e23sm9026740wru.3.2023.07.13.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:01:23 -0700 (PDT)
Message-ID: <pull.1550.git.1689285683013.gitgitgadget@gmail.com>
From:   "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Jul 2023 22:01:22 +0000
Subject: [PATCH] i18n: mark more bundle.c strings for translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "D. Ben Knoble" <ben.knoble+github@gmail.com>,
        "D. Ben Knoble" <ben.knoble+github@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "D. Ben Knoble" <ben.knoble+github@gmail.com>

These two messages were introduced in 8ba221e245 (bundle: output hash
information in 'verify', 2022-03-22) and 105c6f14ad (bundle: parse
filter capability, 2022-03-09) but never for translation.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
    i18n: mark more bundle.c strings for translation
    
    I noticed that git bundle output contained some untranslated messages
    for LC_ALL=fr_FR.UTF-8; in order to add translations for these messages,
    they need to be marked for translation.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1550%2Fbenknoble%2Fbundle-translations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1550/benknoble/bundle-translations-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1550

 bundle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 8d5936c4212..a9744da255c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -271,10 +271,10 @@ int verify_bundle(struct repository *r,
 			list_refs(r, 0, NULL);
 		}
 
-		printf_ln("The bundle uses this hash algorithm: %s",
+		printf_ln(_("The bundle uses this hash algorithm: %s"),
 			  header->hash_algo->name);
 		if (header->filter.choice)
-			printf_ln("The bundle uses this filter: %s",
+			printf_ln(_("The bundle uses this filter: %s"),
 				  list_objects_filter_spec(&header->filter));
 	}
 cleanup:

base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
-- 
gitgitgadget
