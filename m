Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8711F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeGWOww (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:52:52 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44396 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGWOww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:52:52 -0400
Received: by mail-ed1-f44.google.com with SMTP id f23-v6so1023665edr.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QD8XGbbEFkaKYjG3gyenkp4rTiezbm+Mr20o1y5i/Ps=;
        b=kLJ2lfBQuBiy3RzvPlipYTlHOchZjT2adhj6UPdMfRbJrsdLcmL1uPmdp5nkHaf0GB
         lBNegIAZL9lCwm+S1PMZRKzBFui3hRHzsxk2vrYnJyLwZGi/CRXnkh5e+5s0m3z5tkCP
         wRC/rHvph6QvCPgV8AZo7cd8ktdrWxqgu9MEOceXy/m4FmqvpjRI1m0gvMcQDqN6J0pU
         y0zlirv7LHWRjJeqxM7X81hdc7G2iONXji2ypD4XK11Nwlp3BI9B4JjsTpyHzYwLmhXl
         ZhqE1W389HYK0m0vOFMlLgKUxXgWIs5CYfRlhVyuIkipUIeuc51mG+hO3oIv8OXVhs+q
         sGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QD8XGbbEFkaKYjG3gyenkp4rTiezbm+Mr20o1y5i/Ps=;
        b=ZkV9CMR8VfQVJqSk/TJ1W8a4IGya2BTv4RITY84P0RCZW6en4/NgwsBvLUHTzRZiHE
         3ViMR/m7iYsX43i76OktUBeF+oAQytEd0ql37J51SoQS3c4oXV3w9jS/4K+cClvAIeE3
         E4iPCXYg9QTTyspqcl6EnpLXgf+/9CB29T47na0OznZCGDaghmRf9p1LxlyS9pYD1kxD
         GbPHTjFr3QpBxy2t5nMvFTjbtfF1uYvDjbwKpDtADXjhoUEcIu25+aAzbvDsFemEsBr8
         5KObF4KPliZ1qL5hJy2gOoIlu0U5xsHyFu/4hDshNqcjpEAes1R/VR8y6wRjY8/GJTNT
         zqxw==
X-Gm-Message-State: AOUpUlE3g74q8OU1CLCwe+nLkaH9fDl7ln/5a7d4qab6ZjIdJEhYbOBk
        5vMOJB7jHJDNJl0ahuV8jJc=
X-Google-Smtp-Source: AAOMgpcvsyAearUg/w6cWa1UHNGHasnsMxGyAnerXw12Fy9aLc/6nTVvFcAS7aNdN2OXP4mRLkYixw==
X-Received: by 2002:a50:81c6:: with SMTP id 64-v6mr14685304ede.89.1532353890263;
        Mon, 23 Jul 2018 06:51:30 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a11-v6sm494277edn.95.2018.07.23.06.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:51:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] coccinelle: use $(addsuffix) in 'coccicheck' make target
Date:   Mon, 23 Jul 2018 15:50:57 +0200
Message-Id: <20180723135100.24288-3-szeder.dev@gmail.com>
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

The dependencies of the 'coccicheck' make target are listed with the
help of the $(patsubst) make function, which in this case doesn't do
any pattern substitution, but only adds the '.patch' suffix.

Use the shorter and more idiomatic $(addsuffix) make function instead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 27bfc196dd..8f509576e9 100644
--- a/Makefile
+++ b/Makefile
@@ -2683,7 +2683,7 @@ C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
 	then \
 		echo '    ' SPATCH result: $@; \
 	fi
-coccicheck: $(patsubst %.cocci,%.cocci.patch,$(wildcard contrib/coccinelle/*.cocci))
+coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
 
 .PHONY: coccicheck
 
-- 
2.18.0.408.g42635c01bc

