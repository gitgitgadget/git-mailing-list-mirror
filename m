Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B52C1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeGRUL3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:29 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:36566 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRUL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:28 -0400
Received: by mail-oi0-f73.google.com with SMTP id c23-v6so5109666oiy.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=bUvUB+f7+gz3qMR93/h15e845zoUoGIvxGaK2blTLxM=;
        b=nb+FfP0GrMszamFOmaOGogoEeLilcVQ0ugo3QFpKMAPfcWTbGVuEwDMSpFKUnHdd79
         817GftqP0YQ5REnzDQpV+OzZwemKfjfp1LugjsA6cz1y+QiO20Xo+68somTmBr6R/Mud
         YidssEHsNKbyq+oRqjkaHfSKHDp8PG/L6CpCUjvKStrV+E7D3X2p3Qdadbfb985x1cid
         I/QZBOlJPRl449abVxTXAqtzE8i6ZZ5GypfYmxtps8tjrYqeaIVR20hUMkDuK61JoRsl
         SLflJTaY0+UqW0QInvdXwX/0h04hEDfJIA04WvgiPvB/6XK9Aww/iwlqr3YAqWDctLkD
         USwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=bUvUB+f7+gz3qMR93/h15e845zoUoGIvxGaK2blTLxM=;
        b=SVUNKc6OcA8E2RqKefefaByoiuoqXVfRJrgKT9EpHL67JMLQLTHLUJZqKcuv9SBMDJ
         IgUedPMyrgaYZbddD2IUyX95ZOZ3soVpVIflkFI4YZJA94rWEN3eVfMKOqTWK42Vq8X+
         mb7HGVzqQzhYWaPmz7ptj1HtgZubLDgpXurvP77D0GrfpT/DHaF13LAwZHBJyTRzFhni
         552tpu+YVzzvkISzQsb2ZecK0y7uRY5TT286PpJMTjLJUguSsnLmxd+31eAaJxjb/fRK
         7OLdOF1rkwdLnu6/XfGLlKyNXzgh1W/cc+9se/gKHj3XcTcUW8VW2qVdQ5tAz/e0um5p
         ObfQ==
X-Gm-Message-State: AOUpUlGttzyvwiLRnmJwss8ehc1dkvCtbYqspyzg1hdv4iO8x8nkx6ZB
        yIbMNqHGnO+qMPA8Y995VCvgPsubkzHp0abWDUFnOhup545jyXLwQYigc2nQZxPDcfLd0XArETW
        k9khoi6s6RLVqWUQWtEmfCG+TM3AA0sd71csWNTx/DTYVSJdW0ctcCbLrqHg9
X-Google-Smtp-Source: AAOMgpcAlneJ1leq9hAnrQR6mYVtkjr92rldKFwPUEHc7RuE5OAkWWJTsYSNliFSwu21oKEiK8uwVy/BNwMd
MIME-Version: 1.0
X-Received: by 2002:aca:ad0d:: with SMTP id w13-v6mr4133772oie.79.1531942328202;
 Wed, 18 Jul 2018 12:32:08 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:48 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-3-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 02/10] xdiff/xdiffi.c: remove unneeded function declarations
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
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
2.18.0.233.g985f88cf7e-goog

