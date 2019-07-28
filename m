Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46D91F462
	for <e@80x24.org>; Sun, 28 Jul 2019 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfG1UHd (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 16:07:33 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41560 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfG1UHb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 16:07:31 -0400
Received: by mail-pl1-f170.google.com with SMTP id m9so26550289pls.8
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/rVU8qdCpP00xBRXD8n+YgD3UHAwUpLI17TAjN6c20=;
        b=pNphWlZojA2n1APLaR3SivsPmTZHso/17cZM2HYxQmZrp2TH9O00lhxSblxxsJEP4N
         BVA2ZLA9gTYmJz3taV6p6/59E56epHpj6M2UC4ppCh28UthuG0oYrBBN6jEM1qNEk5ES
         YVqYucmhoSsCRlRe7csn+AkK947sQ52O7C9UjUIG9fITLArvoj9XaN0JWOv7BFcTPSfd
         q4QmMNeRLfjbwWDYobOA0sawbO+vvRvGk1ylnVwzmx6HX0q++q+o6nuH+vpQ6BF2ADyw
         50ruwRsTKZH8Gm9HqCNKqd0v3NlolEkzUyO9ZVLzdBtCjZVj2tyXTxNy0M1xPJeipvPB
         CNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/rVU8qdCpP00xBRXD8n+YgD3UHAwUpLI17TAjN6c20=;
        b=aQmzqoobkzPehinpk+5SIv0LBQa0Vo30AaOPr6/0vtls8xDZRIYT8tT4pN+PjaoRfK
         lDT8LcmVf9rmzaJ823V1G+wOAWdXTMT/9JTwbGtU9cLFZCqBQ3ykvAIh93Bm4CCawVmG
         HgzDx4yu6wzTIL8b2DKLCjdW49I+Go+sCKH2wcMFOfnBmvY3i/cLdIFvK+pOzNd+EwDh
         PKK93fgbAE2jEuvJ/voL5dN6vH9xjvl2JQusXpIW7rRiiOHyfiEP7zpfJoIZ3tKvgRv6
         DT7TT+NTD+w6nI6THJtbVhj+c8rrKO/PKZuSmRq10kwjxSsy1XXrgGZePc/xik+qtHyV
         nI2Q==
X-Gm-Message-State: APjAAAVrSavNGxqOaAugERVqoccIIWRQE8QHVXEivH/sOoosUCqisJGZ
        lIpePawemaXqY+jUyZl4X6UURs6ULbA=
X-Google-Smtp-Source: APXvYqxlknm293u/eSg2ajMeuDlP5rIvAqkjhHaeRAwKil6wC+IkOTxC2YFmwT4p1IPsLlj/2aMrDw==
X-Received: by 2002:a17:902:e20c:: with SMTP id ce12mr110279337plb.130.1564344450874;
        Sun, 28 Jul 2019 13:07:30 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z4sm92603491pfg.166.2019.07.28.13.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 13:07:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 4/5] xdiff: remove duplicate headers from xhistogram.c
Date:   Sun, 28 Jul 2019 13:07:23 -0700
Message-Id: <20190728200724.35630-5-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190728200724.35630-1-carenas@gmail.com>
References: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
 <20190728200724.35630-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

8c912eea94 ("teach --histogram to diff", 2011-07-12) included them, but
were already part of xinclude.h

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 xdiff/xhistogram.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index ec85f5992b..c7b35a9667 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -42,8 +42,6 @@
  */
 
 #include "xinclude.h"
-#include "xtypes.h"
-#include "xdiff.h"
 
 #define MAX_PTR	UINT_MAX
 #define MAX_CNT	UINT_MAX
-- 
2.22.0

