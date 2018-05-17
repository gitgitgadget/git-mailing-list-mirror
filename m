Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3757D1F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEQTrJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42020 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQTrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id u6-v6so3144743pls.9
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fcqq37Kr0JJxLn/StA+zuRxYsrs5RKJmQGH4OKr18W0=;
        b=Zz5Sjvg9VTAjJYptuHe0j12B64NILlYtmL1tQEF/Vbo8nXI/qoZnWyzSCamYHdwEUd
         YTC3SgubINr0/6AyGWmjAHrMqpAgfgo2b0oXRDAumooD10SIn6X8Pg2jVWtqnCQ6BTqI
         JFDnskkIhcVcQIir5pvIn4CdK5GcGiNkGTjxEzsCCnNjGh7Jx8ubN9ydxwzF3zdf4W4V
         wgmfJHsvkTekYJqbXkBm+RpJ8BAfXAXGH2m64IfknsB9IwILzeQoSs0duaZGtIMoY8Vj
         mIzKqTtlNk01xE7Wh5BDOWb/GYyJg1SJel1Ibdx6yZw2eSDIv440Htl8e9RNPhiKOjQy
         Ppcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fcqq37Kr0JJxLn/StA+zuRxYsrs5RKJmQGH4OKr18W0=;
        b=Kk1XB7iXkv6nbpMxpGdi/OTDPce2fAp8iqmslRfzWtVqYRjNyjcvhvUSgxXbYkNywI
         EHtjxoycfPGADaMACkGf0ROJfFE+SJc33JqANgLi0mZ1k9uIYzK5PZmPAmqmGfGcos0Z
         G6zktbrpj333xc5DPrnQ9wlepFft39T344ahFg9vvUUWZkwLQ5KH3Q9OH+uAj/zAJcUk
         0Z+q7WgyZQWsNS9Z5MV4ZnehFHcnRBozGeEFIcTlbFTpDAbDzihcmi14ZfCDOlX1UrGX
         UdkIJdq40wx2K3T3Niu6HH2d8QhOW0xf4JeUtO68rEMnQzndsVE3WluJfN3y+5fNktAt
         qwbg==
X-Gm-Message-State: ALKqPwcA9TsiJaFm59OLp42mLhqtvtwRdZjthOCvkKx9XZwx3VCkrNKN
        HLKZ/FZ5qyPiEspEA/GzINr66A==
X-Google-Smtp-Source: AB8JxZrY/CQqHT0lgaBW4aSRqD6M7MPdfDG4ja6LG4AMz75TXv2zttfXyCT7s2XSNfJ3ED1ZSUq5Tw==
X-Received: by 2002:a17:902:26:: with SMTP id 35-v6mr6688697pla.104.1526586426210;
        Thu, 17 May 2018 12:47:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id n10-v6sm12390373pfk.145.2018.05.17.12.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 2/8] xdiff/xdiffi.c: remove unneeded function declarations
Date:   Thu, 17 May 2018 12:46:47 -0700
Message-Id: <20180517194653.48928-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
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
2.17.0.582.gccdcbd54c44.dirty

