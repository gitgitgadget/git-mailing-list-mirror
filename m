Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F8E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 05:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJVNxZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 09:53:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43175 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeJVNxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 09:53:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id q1-v6so2005685pfh.10
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvUInMaowIvzgsxpJ92dp7O2DKX5+9tJRrcatATnCNs=;
        b=hupesOoGb4q/XdkcKFkWeWt4tVsRRtZX6aFgn5b1irymnuQzK8NnD0eXrsukKmPZnE
         92z554po3tvr/azbFt0YCBQjl1SMn0v1wpsC45XgG9TFD/msHD8bFilTrfFYep2Xu9aW
         NZ8kX6YitWt/dtx+0U7DkoR8M4KlVpK4ky55pcjBKQej0Bytd2UqCORtWO3W0Zb+OwsE
         2PTq4Nanw/Xd8d9Hv9qKVkcpPpMmbzgdxEyu4n4vIMsqvP7Mjh0Jhn1jxSI1klRJtR2E
         5/dtjY7WToB0dybZjJ3KyCMjAkJkPpeSV9m8aEHCSQNi6hl711Lz/1X0/nauqDteCIBT
         KQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvUInMaowIvzgsxpJ92dp7O2DKX5+9tJRrcatATnCNs=;
        b=joLuzCgHMF6/MZJS8HxplA42KiUL+oNZa9610tZs2TRVNSFs8M7RMgLBvEqkCOkYwU
         Bqr45DejXpwzAiathXUp18paXmIxaiTWc0wRxINSpufRc9yNKtVhQGdo6HaVp/JxSDdv
         euSvKqszAPYzZmEaYz+US3ZCQSYv7niBBaW7uad/82CbveWjzSEo9uODc3jfhi+HljM1
         TozAqGg8c0YWVTRShLKW13ZUy07WMIpeVVMjT37LzCh/zKzqHtqU3lXIcJ2beXpTX+4+
         /EJ50ROf69RFKURBrNl5qSfDYs8o7NuCgfX+d83rqNLNMex4hUAEGlC/LpwQqk2kJX5+
         jzcw==
X-Gm-Message-State: ABuFfoiRvQnGIJJdMlAJKywFGSbkVYFptTUTGl4HzbSB/jkttaO/1llR
        NMTk73tU3BrJaWARZb3KwQDmaCZN
X-Google-Smtp-Source: ACcGV63Xvg1dl2O6qKmaaRd1cbGcB/gFbf4O2gVsiE7621pOJOrYSZ0MKrtn5n0pq6nHZZKOzrkZyA==
X-Received: by 2002:a63:d14a:: with SMTP id c10-v6mr41895508pgj.384.1540186585539;
        Sun, 21 Oct 2018 22:36:25 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n63-v6sm38004733pfn.9.2018.10.21.22.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Oct 2018 22:36:25 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] git-compat-util: define MIN through compat
Date:   Sun, 21 Oct 2018 22:36:04 -0700
Message-Id: <20181022053605.81048-3-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022053605.81048-1-carenas@gmail.com>
References: <20181022053605.81048-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this macro is commonly defined in system headers (usually <sys/param.h>)
but if it is not define it here so it can be used elsewhere

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-compat-util.h     | 5 +++++
 sha256/block/sha256.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5f2e90932f..7a0b48452b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -218,6 +218,11 @@
 #else
 #include <stdint.h>
 #endif
+
+#ifndef MIN
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
+
 #ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
index 0d4939cc2c..5fba943c79 100644
--- a/sha256/block/sha256.c
+++ b/sha256/block/sha256.c
@@ -130,9 +130,6 @@ static void blk_SHA256_Transform(blk_SHA256_CTX *ctx, const unsigned char *buf)
 	}
 }
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
 void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
 {
 	const unsigned char *in = data;
-- 
2.19.1

