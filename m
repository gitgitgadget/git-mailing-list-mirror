Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6121AC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 20:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDLUGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLUGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 16:06:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB710DA
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:05:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d9so12173384wrb.11
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681329957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQjdAUQbBZ2dyO127HApmyrM90hBdBX7eLKH1Ns4a9c=;
        b=U3jNoL+HR8zZuANxZMYcHXtCHUM8IZ9ce20iO38VH9tpcDZQCBCtpEaDH4rxs73s0C
         wIOi+FcakvXLyk+wao8sXZ7ez+7vVoqhHLu2sew8KoIQdh6XgMr8OJFPcNngIqgrNvQS
         sEwmhgtz/faMxlStU6emqwsvHnnbnRv3jTJhr5BE7Ofd4l9byPLZ5K2eWySaKHoRgprk
         WcOybJI4kaWbgEKkQDspjkYmyb8Z1BZi9Q2u7nT7B18q1KYKZFruPq/iI680kBH07F6i
         zwkvAXiMicSAHVh1DBw9+eTVH53SVq21aQgwi5MtkS4m2qErqNF/MNYnypsdMZgyqb2k
         Ic1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQjdAUQbBZ2dyO127HApmyrM90hBdBX7eLKH1Ns4a9c=;
        b=T2TDP6atwUI8j/SklLPM/0jzVeJUjFfzOCjXg/v2RzsCkff4J1iOAPD4AoesieRFPN
         x7IF2e6Sd4pi6RC88k6/eBSzHMbp0kn8u9qR6XRGgshBnxhXYTM3NZssk1CqCro/ArXo
         Fn5JMMjtwBpLGun43NMTyd0xBgL1nMRDNB5c2r2NDzV1BN7ldr0oC5xuFQDiZI+9+L7j
         pt45dgf96IoHXcD+G9JJ7ilgl46+ef9AkJPdGjbdDCX2U0W8kmtpPDvmn3bwqgSNYX6U
         YTZLdeXP38BQXE9xtDABUBelJuRLx7xN+eXpJIRbC+byAwYuIxdyRCZHvP2+JHrN6+lA
         ZDiA==
X-Gm-Message-State: AAQBX9c2Z4oA20/ptdXwj7cy3dDtzHF2Py/beB9Wg7ribLv35e3/vV02
        BUl8lo0u1Pf4UpP65+IEa88/8jRmhwI=
X-Google-Smtp-Source: AKy350az3udhJB3JMRhw7grK+NiKFNQqIf3C7h9GWHIir4f4YzQJahcmmTNM7p4wDg8r2vwkXhPzTA==
X-Received: by 2002:adf:f9cc:0:b0:2f4:7980:cb22 with SMTP id w12-20020adff9cc000000b002f47980cb22mr2513442wrr.18.1681329957230;
        Wed, 12 Apr 2023 13:05:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c350a00b003f082388117sm3507218wmq.32.2023.04.12.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:05:57 -0700 (PDT)
Message-Id: <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1681329955.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Apr 2023 20:05:54 +0000
Subject: [PATCH 1/2] cocci: add headings to and reword README
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

- Drop "examples" since we actually use the patches.
- Drop sentences that could be headings instead

Signed-off-by: Glen Choo <chooglen@google.com>
---
 contrib/coccinelle/README | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index d1daa1f6263..9b28ba1c57a 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -1,7 +1,9 @@
-This directory provides examples of Coccinelle (http://coccinelle.lip6.fr/)
-semantic patches that might be useful to developers.
+= coccinelle
 
-There are two types of semantic patches:
+This directory provides Coccinelle (http://coccinelle.lip6.fr/) semantic patches
+that might be useful to developers.
+
+==  Types of semantic patches
 
  * Using the semantic transformation to check for bad patterns in the code;
    The target 'make coccicheck' is designed to check for these patterns and
@@ -42,7 +44,7 @@ There are two types of semantic patches:
    This allows to expose plans of pending large scale refactorings without
    impacting the bad pattern checks.
 
-Git-specific tips & things to know about how we run "spatch":
+== Git-specific tips & things to know about how we run "spatch":
 
  * The "make coccicheck" will piggy-back on
    "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object file
-- 
gitgitgadget

