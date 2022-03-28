Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E6FC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbiC1OD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiC1OD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:03:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7495EBFF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u16so20555032wru.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TcVHonLBZGosq+7VKT77a72z0kemvaq/5GGDKB0cb0Q=;
        b=o8o/+G3B4nt4CIqdaML0A5GorloQ9HlzmmPZk++Pqq058AEl51lqAhGHJma2ezuR90
         Ud8sE5HlKveiLKdPiYFk/0IfclG7DTBHGxOPNlBUStv30tYAXDcuYL3m0AwnXUzM53Fh
         rF3OKWy+P+bhkpyVeODHpKPDUHnKozOxfT/f1C7rC7bma2Pqm1DyUYxLqC7lsYMGjG5L
         ZtUVI0R6lpb8Jr7bZQjZzzLh+/PJCcpO4p8mLsCCpdFL6rsZN9F0x+oq1iVIZGJcDcIt
         4iNvFUC4q9E6Ih0jhUP8WAo/bYyfGXpEW9P6gxsA8M3wilYq6l1F/UkW+0Gsx8IQFaAh
         16iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TcVHonLBZGosq+7VKT77a72z0kemvaq/5GGDKB0cb0Q=;
        b=YKN77CjZ+7cvjfNkGN3gdBKxHZrzAk5sBrsydDchRTf6hpoyNxffbK2QuRClQfueGu
         sNhU5RwGONRsesYNpprsETF/vA5vR200+7s/EK4IPr6VaFymh9wULdigf0eKmKutm6m+
         ZsCK5riwy9M5++H+aXXOruHHXM8i2MG3uNj6tNC2AFWn2PSrzlEFP9W5BPtfkzh2BqCM
         9CBgh/csM9yFqXQSe0IEsJjPp+3T8oPsQ+EYZ0KiZaIkXcsSRIKnU8N8WVkeyIk6JW7Q
         gygDfd2fw8gbyqJjnhR3YZVJ3x4STW6/OIpV4veNZ4itRdGxj6idUEt44lQc4xD8+5XM
         nYuQ==
X-Gm-Message-State: AOAM531dLrLniiCgafJfc3lHKGPtXctHjai9VkO5N+Ank6Uf+l7weLH+
        Urd7jF5Y8lopG5jxiAV+gh/9TTl/NBc=
X-Google-Smtp-Source: ABdhPJyAqaP4M+NSlXTaQ6Ld/fnipSBQqXDG/6+40SOv6YPsprUodCvfgU2nqpp3Gzo+4rHBhocgNg==
X-Received: by 2002:a05:6000:1085:b0:205:ab9b:8cf5 with SMTP id y5-20020a056000108500b00205ab9b8cf5mr15643730wrw.196.1648476135770;
        Mon, 28 Mar 2022 07:02:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020a1c5401000000b0038caef28acbsm11519807wmb.47.2022.03.28.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:02:14 -0700 (PDT)
Message-Id: <6cd6d4a59f6596ee190e97f72e788a23c4fa5534.1648476132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 14:02:05 +0000
Subject: [PATCH v4 1/7] fetch-negotiator: add specific noop initializer
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
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>,
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

