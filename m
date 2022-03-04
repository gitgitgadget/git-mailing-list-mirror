Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA41C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiCDPF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiCDPF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF915B3CB
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:38 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e24so122317wrc.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TcVHonLBZGosq+7VKT77a72z0kemvaq/5GGDKB0cb0Q=;
        b=gGlbgoJtqPq4zhTuKjxRU2f59eoyWdT8LbDTs8NpdsM/FGKUa7zkMAm9RoXYyvzANO
         qX1cKS3KPfvXADp/5SaT/LzoD9KJVtBlEhH9gDlMC/LYDKK4wNhFYEKRIsB3ZvDW9wgd
         RcgECVvUygbuqLhdF4GwATDvlyssSkwR9X3kRcALB3DOSI0wdtLRbxxkvZjukrQ+6guU
         zuVF9ejScIxwtk78C4QLNu99DFHpmmhOD4hOrasYdtpEkuI51a7kNS6se2eyNag7MYzK
         6OvBqFdlDOlXdvyrOK0OOETwes6OQgdAQZV7kMYynfzmqCw7cwFwuUuqcd33VBKrGDzB
         NdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TcVHonLBZGosq+7VKT77a72z0kemvaq/5GGDKB0cb0Q=;
        b=v6qbzi7EbawbOtxbK4EHQfHgWSfxXKVKZcjyW/xAHIeFWzu93YWTTUaPFos+hzqDki
         nBo+1FNNdUabVQu3LevAVq6dy3vVHTK4oqKsBa3TVuNoc6E31dPAcHIRrCQFVllSh8vU
         0wSuelRceYgI/VJmG8WjUFzCjCXIv62mvyiv9pdsNM3r/rllNdgcmIX6XbTKs25hs6SB
         d/+Fwdyvkk4KbWtIraXHkOoubx+ntF54EmpMQDF7Kpn9RFLG8+O39OdVW3U4mRtf5qlO
         cLXJzrMwi1DbKwES6ctaub6JRtMf2Ljjt3HcNYtw3lrhaY4s7Rxdws2QS2A5W8fAC+Sk
         UIsg==
X-Gm-Message-State: AOAM533P5ddSasVm9PHpi3byo2KLzRYWwhZj+Dn59v+HXa7yDkQVBO3d
        iSo/El8aiQ8iDJPUw6Zem0+UgcwUem8=
X-Google-Smtp-Source: ABdhPJx7fF+CPJ+zHRoWrTjTuXNOvO91i551KfQOaNGrYcIM50CbDXbljfrNp4qPqndtRB8Ukr29rg==
X-Received: by 2002:a05:6000:15c7:b0:1f0:b269:76ac with SMTP id y7-20020a05600015c700b001f0b26976acmr2133551wry.331.1646406277090;
        Fri, 04 Mar 2022 07:04:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020adff8cd000000b001f03439743fsm4869880wrq.75.2022.03.04.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:36 -0800 (PST)
Message-Id: <96a75be3d8acf983db256206706c2e9651d4a2c2.1646406275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:28 +0000
Subject: [PATCH v3 1/7] fetch-negotiator: add specific noop initializer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a specific initializer for the noop fetch negotiator. This is
introduced to support allowing partial clones to skip commit negotiation
when performing a "refetch".

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 fetch-negotiator.c | 5 +++++
 fetch-negotiator.h | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 874797d767b..be383367f55 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -23,3 +23,8 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 	}
 }
+
+void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator)
+{
+	noop_negotiator_init(negotiator);
+}
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index ea78868504b..e348905a1f0 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -53,7 +53,15 @@ struct fetch_negotiator {
 	void *data;
 };
 
+/*
+ * Initialize a negotiator based on the repository settings.
+ */
 void fetch_negotiator_init(struct repository *r,
 			   struct fetch_negotiator *negotiator);
 
+/*
+ * Initialize a noop negotiator.
+ */
+void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator);
+
 #endif
-- 
gitgitgadget

