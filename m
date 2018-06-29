Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0FF1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030257AbeF2AUT (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:19 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:41231 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2AUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:17 -0400
Received: by mail-oi0-f73.google.com with SMTP id 130-v6so4466334oii.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=bIeVOizZY0K3NwnV4ECi2m1NpHlzj0Rj7hRdaynWMf8=;
        b=oOzinUqljoc9KERo0W8ijgjmKhEgYAEyRI+bXZIBHMCk4ZhFNMJv9X55aJVRjZXIkh
         85AjILvab0wQ+hDLuvsnyLzNv2SbYUr7QoyoFOiHNfLYB7p+l5BFGUpcfSMyoLemNcbF
         BGlKef7miKl2zUJf4ofm7GN+rwlQfdL9gW9sdfFML/WNjG0VJWXx3pNwj+2Xyy67k6Ym
         rlcqyXs+wMTw4aS83mcU8DZ22Y5ubkiLYGXeGMo/MIdkXY4+YSfqrOP/FLf8Kh40K13W
         3c6E9T3gbLR+aBFzBPfMiLJgPxx+o7+skrbtSs+I9PTSIZzhFd5PL6phYxew1rAXZhJt
         QOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=bIeVOizZY0K3NwnV4ECi2m1NpHlzj0Rj7hRdaynWMf8=;
        b=oQmyl1r2FTNgAiveXB2hnug1WUCVE3IXjHWu0meyXmMHKTdPBeTfNgPE4vS/x5whYa
         WvcKrivVI6fdGGIemDWI2Cm7wBq+jiYJRbdPItCivlLHJMr0A+NPrpEvnachw7qzYTT/
         x+Y+0kv8EbtuXf7JtiMmH54A3NuYSDDvE/JcwHbs1U7JXb7xbg8gBTIWSgq7ctXdhsWM
         ZGPIhazGPbUS+DQqHRLOAuwUf1pdcvvHZ2NhObDGqf2vKDVH6/npYKjg/5u/swMgdV+X
         6qN0vzRMOVPVHA6DfTaZD6vTMiMe26YUzYoBOtIDw0tx4NGic3dEYPhv+SOZJ+kQn8xR
         mHcg==
X-Gm-Message-State: APt69E2TvqxRCM42YKzYUZhKfSjTzUD0h5bfFksBZWFEZOGs3LPmDk+M
        kRHczwvCiu5c7XAmXjKrRBcjFcKLw6Vz
X-Google-Smtp-Source: AAOMgpdmvyKpK9TXKQetfWYO+IBlG7n2njbEpeGZOyivR6UfHDtNIuTXBt8XYoH1IH2s0Rsg2tcOEg7Id93S
MIME-Version: 1.0
X-Received: by 2002:a9d:182b:: with SMTP id b40-v6mr5339960ote.83.1530231616415;
 Thu, 28 Jun 2018 17:20:16 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:51 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-3-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 2/9] xdiff/xdiffi.c: remove unneeded function declarations
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com,
        Junio C Hamano <gitster@pobox.com>
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
2.18.0.399.gad0ab374a1-goog

