Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C8D1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeDXVDk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45697 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeDXVDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id l27so13289373pfk.12
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FS+1wcvo70WHie8diMI6J3yqBzUfDT7zsa8VnlLdFdg=;
        b=wDd2do21uYrWTVZ2TTfeDwPvtcyUF1Pzl7WOa3GVd0r1Ilcjd0Omf/jII/aKwglhVG
         untRu0P/Ns5D5AvxaZYDwFFMM9eieXRNpsr+sFbxZTuIzWyE0EK8uIQJXchyFImJD3qk
         eQ0CKre0TnuVlrXKZ3dWViw66aAD2tmTnOQuSIxaO4d5H+IB8e2q0A9BY7wkncNlw3Tr
         f98ZjkoTtcTe3WZp2j+nVRxW/MTb6hf018r8KuukGyZlx8opgqeUR9Auj3shThtDoSX0
         kja+e/IeX0JBwLCJhl/oc1IIpY1bXskISIydJdKoPTUynce7wp838gntiYo+wqDZ+ogL
         AqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FS+1wcvo70WHie8diMI6J3yqBzUfDT7zsa8VnlLdFdg=;
        b=bo1/ejCOdy8ajDE6pJgJTUB9PZDPuT6V13DXbFEjKHP3Qb3r1RsWFyl38CTD2F9iO5
         6BTVBAl/rJImvWPD5IU/OxeQLu44NUNA0rnolGas3kUkb9k7y6SRu6u5rLhnKFNE4Qbn
         +dN3bLEIjcQ0mwhCP/MSS4b9R84KQkSY7v4NIVLca56DjWp5IDba4A/+PTu0VZ9mNxKJ
         XW4yVw32Ue7lb66gs+duYK4MXCZ0TSH4gmMBgzxq+jFu6nbiI7FbWOY8rnxc2KBu+AwT
         UT25J4uulSPT1/tVj5IejaztSJVnOBNr2eYBStf43W133kPT/hrTgEXQnLSiD9Mp6UEa
         mFBg==
X-Gm-Message-State: ALQs6tDcrgWT60JzMQmkqrcleRTSmnoFjw4Q6ASuQw4Xk6DmgHGlkbfy
        ZAzatR9E5iGKxg80frKBTK0Piuz3+KI=
X-Google-Smtp-Source: AB8JxZoWzHZBf1QOSqGOC7nArVjyJXCJLaObrePOxidC0MUsN29fGdbsM9N/n8287soTfR1XRakBuQ==
X-Received: by 2002:a17:902:74c6:: with SMTP id f6-v6mr3177042plt.7.1524603815530;
        Tue, 24 Apr 2018 14:03:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a4sm37516083pfj.107.2018.04.24.14.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] xdiff/xdiffi.c: remove unneeded function declarations
Date:   Tue, 24 Apr 2018 14:03:25 -0700
Message-Id: <20180424210330.87861-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
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
2.17.0.441.gb46fe60e1d-goog

