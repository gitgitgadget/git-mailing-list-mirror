Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E90F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeGPXf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:27 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:48947 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:27 -0400
Received: by mail-io0-f202.google.com with SMTP id t11-v6so35590165iog.15
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Dp1Z/tfK6AzhuQQuEmh8rJQ+jMXMcqYtvX7fPjcxmcU=;
        b=ZFSwMCGibIt+nXoX5TypZuSj9aRerUw2uEiLHwC9MHW38wZOZzdSqU+Tl66e+Phz2W
         Fkxbdy2itHhAN7uuk/wOgV2Ov+XbTAxndPRlKiCCPLFHfjG68e7BIO/I3qyL06odSech
         rTbEWMfoSzVKRUqdoPH2i5wGSU299qD3x/e/GPpiPpznPWOLHaiwNeRa6sb8uUSK3LwI
         QQJVMCHGQb1MGOq3jY20OXK8q/AJ+I5SR11fJy+yz8u0h/1fgiIHfyT0M1lWj1Ekzc+o
         DPG7gCeOQnOnFprNOElr45A+zFixNwTgv2almyhpribCrEiS0hNS+lW4QqzFVItIYtrR
         A0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Dp1Z/tfK6AzhuQQuEmh8rJQ+jMXMcqYtvX7fPjcxmcU=;
        b=ChbV9/55/aOptU6TKNeyC+ITBPsCLYNWBY8rGaKSenIcUfdIrn/Q26b0iJ9aKbLRvH
         r2aXF4OFQX7O8xKjLXqrAhJvHAPIqLcmJVJVdJ4hjDcLXApscSGXxWYXmFVpDYQG0aHr
         0ng8VXW8hxVAWoXkYOy12QlyJjvKPQ5vm4h9bdZZkzX2MCX++sGQxVQxL/fIQZVgjmiJ
         7t6/isN+37EdOad4gG3lwPiLqbG1Ud0zt1wSXZdhfV4qn6NkFZcebOheZfqURoyKJHim
         l2biS442523Z4/j9lRyqKHW2wmCPjpgLZwkZWHY3is4Xh/HKwTfDpD+WFu2XCMAfleBM
         79Xg==
X-Gm-Message-State: AOUpUlEpj9q8YPXIdWRHcb6+xnfYDwVFQZEvCoy8X1gYYA+8SJsAIvv1
        SC/WzAiDPlwc1ZtDtoBLH1HHw0EXVnV2T6uY9z7oha8oIVKk2L7ZB06ZClC5z9Ff1ZN2BdYrfTj
        EYZHwVimfyt6Ok5fxeef8vkDDmIbLAGMbTi1veqjiDpB/pZRuI2qu9im53lL8
X-Google-Smtp-Source: AAOMgpe2uHEWuDTOn7B8Wx/KYpW3UVuURdh7xiVBlwkryJDriiNFmc1694nCVizFjIECujC5Ph7q9Artzh1Y
MIME-Version: 1.0
X-Received: by 2002:a24:3d90:: with SMTP id n138-v6mr7751254itn.43.1531782352406;
 Mon, 16 Jul 2018 16:05:52 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:05:35 -0700
In-Reply-To: <20180716230542.81372-1-sbeller@google.com>
Message-Id: <20180716230542.81372-3-sbeller@google.com>
References: <20180716230542.81372-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 2/9] xdiff/xdiffi.c: remove unneeded function declarations
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to forward-declare these functions, as they are used
after their implementation only.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiffi.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 0de1ef463bf..3e8aff92bc4 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,34 +22,17 @@
 
 #include "xinclude.h"
 
-
-
 #define XDL_MAX_COST_MIN 256
 #define XDL_HEUR_MIN_COST 256
 #define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
 #define XDL_SNAKE_CNT 20
 #define XDL_K_HEUR 4
 
-
-
 typedef struct s_xdpsplit {
 	long i1, i2;
 	int min_lo, min_hi;
 } xdpsplit_t;
 
-
-
-
-static long xdl_split(unsigned long const *ha1, long off1, long lim1,
-		      unsigned long const *ha2, long off2, long lim2,
-		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
-		      xdalgoenv_t *xenv);
-static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2);
-
-
-
-
-
 /*
  * See "An O(ND) Difference Algorithm and its Variations", by Eugene Myers.
  * Basically considers a "box" (off1, off2, lim1, lim2) and scan from both
-- 
2.18.0.203.gfac676dfb9-goog

