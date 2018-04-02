Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783641F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbeDBWtL (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:11 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35164 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeDBWtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id 61-v6so4150460plb.2
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SeduuirSVotW0CZ57zkbCIu9yb72hSQAsdMv+8VLwUk=;
        b=KCIkPLnu0Vf9E+Rl3rm8Ni4HNHUKIC4JRjTBBcuDBdiMXOyyjMd0D8oXZGgwDlPq/K
         tN6r3mnXllqKuqOSLZyDWEfCNAWxTeRc0EDrqOaueEVg9RQeG1OnlPnuSjH+h9taoK6o
         0SSvyV9OATBLHFiu6QCo6tUbhKC7JnhghrX+9bwrKWtkKWFDKO0bzhZ6vkn98uiR1p62
         sy8d2pRiHt1ptg6Gr2DJaU72WUWRzbEHOwVAYqLJOS67Hi3P7HW7q2fcEi/BhVErmABf
         djtHNn7SoXetEGAoequGnaf8XfuW0ZpM6/o4wJBXwpK4mZenpzyXR4e6yrpEygT9h2V7
         vCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SeduuirSVotW0CZ57zkbCIu9yb72hSQAsdMv+8VLwUk=;
        b=VLIBKKldaZ5VyhkycnCBhUJTqqpT2BFYA3kl7BA26D12fhqtNs+QEhu98+tOrLM8Gd
         7D31m28vD6n8cQYt5oonp7EDspNNdBKfMJLfK58hA0Br354sZ/eNMhd+XEOfk1AIiQhG
         QGcKhhRGi23Xdv637Ml63q87OWpLNqaG0xOLC6pxkoMz+JJ26ZqD07STCJtzNZ7Rgggs
         hXTuYpo8sohUw1kvcwzG14EpMlWqv2MGAnzBymDJoysE02S7GOXaUPdJp+pt52mfIAX3
         uASf3hycb+uMmNRuCUdbK6hGlRGXu9gNW+YcYcOcNHnDZxx2xr9MIMD8USKETM+zlA1J
         q4GA==
X-Gm-Message-State: AElRT7FvhP3EHGHPySkluAC6Cv6CnTTaxKa0pl4cTD4DC7C8qZircEPi
        HAO567TgB5Xt+eAbhbpMg9SA+A==
X-Google-Smtp-Source: AIpwx4+iVgLE/mWJopCGrsWOPHa3ecwdsO7jFGlkh1W9P/cdhW5tbsa7HvJwTARnqPEASo0P5r3nAA==
X-Received: by 2002:a17:902:52a4:: with SMTP id a33-v6mr4407930pli.371.1522709347953;
        Mon, 02 Apr 2018 15:49:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id u13sm2570432pfd.112.2018.04.02.15.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:07 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] xdiff/xdiffi.c: remove unneeded function declarations
Date:   Mon,  2 Apr 2018 15:48:49 -0700
Message-Id: <20180402224854.86922-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to forward-declare these functions, as they are used
after their implementation only.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiffi.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 0de1ef463b..3e8aff92bc 100644
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
2.17.0.484.g0c8726318c-goog

