Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05181F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbeGWOwq (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:52:46 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33272 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGWOwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:52:46 -0400
Received: by mail-ed1-f48.google.com with SMTP id x5-v6so1044325edr.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sG8kinMb7c/c23r2w5t8aMN/lnGbOVA07aU38ClDDuM=;
        b=Q48+kJPCkpeMsv8XX7Z6bjj4BRmgv9a0pb+fHKFWQap9zgnWEinniiXEytqfsUd9uc
         RTdwK3AeW/ep23CcxDn66uENZBvSb5DJbP3cIa78YvNc2lPiRK1Dm9Ci4+LI37cTeaMO
         IExqfB/IWRvhpnVDCbo9sy33wCLkmyvXDgQ2aTx1kLHS7uadjQ2yuibLaFdOCAN61AhI
         G+zZTt7qwBVUCMK85to7zUz2BMd4hGr7b9PFiFZvArYmaexFPFKmtgwXp+WFF9mEzvlb
         DJwppDudGydo/VYLh2e5vxBsR7zq5lPyx/rNJTFbRngaDWTMw7TeMSgCxbpOi4QkVkP6
         8CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sG8kinMb7c/c23r2w5t8aMN/lnGbOVA07aU38ClDDuM=;
        b=QJQDamEOUszWFBn0/7Fb6borlC+AFVd0maNw/h4+yTwNASGbNFMNveop6e3you2+5H
         e9cMh4lDa8ljQh8ll4u3R2GxqmYWBk967vAV5MF8lXRJ7oEM2/rCqSA/wlF1LHwTCKQn
         DImsgFenf0lRjuqoa6A2Nu+1rF8ll58umkDoGNIINA+NB2zOCmybHFQ/bK/u+xHnV1QV
         UQMRubr2s3GFbkLAwWaMCLToMaNbqyZxXibjFIRM9jKgyFb07Zt/465dEAlphyXaJBBa
         VSV1aViTcgqI3nmCS1+tjBdOdu4CmFGxBHtkS+PAbiPQSTPqG2d4yqDj+UKc91X9KLnU
         /fvA==
X-Gm-Message-State: AOUpUlEH673UEqAGCmUT9ock5JWy836aNesQ2pqcSrdq2cbUxCM993tl
        YTbIElBbFJIr7gANxTq0R8YvzhQF
X-Google-Smtp-Source: AAOMgpdf775BD0KxjFefoSb0Yz6YiFtl6jjojT8/HaZpYxx2Xui7XcRRKF4J67Ki0x1A1ZhrUtDTlw==
X-Received: by 2002:a50:c19a:: with SMTP id m26-v6mr13854678edf.151.1532353883884;
        Mon, 23 Jul 2018 06:51:23 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a11-v6sm494277edn.95.2018.07.23.06.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:51:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] coccinelle: mark the 'coccicheck' make target as .PHONY
Date:   Mon, 23 Jul 2018 15:50:56 +0200
Message-Id: <20180723135100.24288-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'coccicheck' target doesn't create a file with the same name, so
mark it as .PHONY.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index e4b503d259..27bfc196dd 100644
--- a/Makefile
+++ b/Makefile
@@ -2685,6 +2685,8 @@ C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
 	fi
 coccicheck: $(patsubst %.cocci,%.cocci.patch,$(wildcard contrib/coccinelle/*.cocci))
 
+.PHONY: coccicheck
+
 ### Installation rules
 
 ifneq ($(filter /%,$(firstword $(template_dir))),)
-- 
2.18.0.408.g42635c01bc

