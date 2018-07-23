Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BCB1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbeGWOxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:53:01 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43616 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWOxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:53:01 -0400
Received: by mail-ed1-f51.google.com with SMTP id b20-v6so1020141edt.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ochuAFWsuGJ+STCiW+VHwaz7Cpb+PNGT4qiJWGR8sNM=;
        b=p9QlxjCa0kMO/biIVsJVGbPalNVlFz//5l24Mug4/81Xw9P4cXNQm/PkHixRZabEII
         ceOUTz6iOcqGEq7NLbiTndbYvQR6Cl5DcMjke3DUG+XmW11ynN+Ld4MhgGyvtFpIzx9j
         5jp9q4jWTjExg9au7yDg8Y590xMWGghOffn6thV+yRhbm7q5k3z24y2tl91DwXJCPAvc
         xWywgisc84JE1Y4UVfXeq9MOxw1jIaMCOZA8chXroUPvuJLv4wO6d0pC99WTX4OE+G1E
         hdbL5wzmL4653qC5SjDnz2T1tVnPnibM7qg9hUSmy2+HCez5obmWG6xZ9ZWmzH6jh6/y
         F98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ochuAFWsuGJ+STCiW+VHwaz7Cpb+PNGT4qiJWGR8sNM=;
        b=rHjmBFfPZ5BAxb289Pmwc2NDWb/NsNX9XUFQ9pPf54gZSmXjHp8HWftM7VEFQUhEOE
         YASyco7/X6Q+VJRZs3x5l7nums8231szLJtgzlXwZGtQT889GtdDRm7245xazt71qiB5
         No9GllcEJGv5EJiS6uGxsFtLpLBn8xYvLKXWqNtqu3GPwApFDoCSXpzFF3sSNoKXretl
         ub+X1fQiMD/+nHOeKH6epbbx/xVq9TrqStleff2DA1U2FVvEOnx700s69/e6ZkwVXm7Q
         PAhygMKqgSd0bauHVfYjpYr+7AxnuPkMxK51kvplEoqNod2gMgfH2+ucxe2E/Ccx79E5
         G1Sg==
X-Gm-Message-State: AOUpUlEy4t9TITAQOtA0q5VNuTUqppXsHN8/I+6eWHC5X2uMGg1QScBJ
        ZE1gZFQPsIc+3no9dQvpNT4=
X-Google-Smtp-Source: AAOMgpc+UynWxJzvypJxrxiXh+1vZNmLe9KX7cSFjqelI0LpEh+gEmU23OBxaFMFL2eelcaGSlCfiQ==
X-Received: by 2002:a50:f390:: with SMTP id g16-v6mr14462648edm.226.1532353898962;
        Mon, 23 Jul 2018 06:51:38 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a11-v6sm494277edn.95.2018.07.23.06.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:51:38 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] coccinelle: exclude sha1dc source files from static analysis
Date:   Mon, 23 Jul 2018 15:50:58 +0200
Message-Id: <20180723135100.24288-4-szeder.dev@gmail.com>
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

sha1dc is an external library, that we carry in-tree for convenience
or grab as a submodule, so there is no use in applying our semantic
patches to its source files.

Therefore, exclude sha1dc's source files from Coccinelle's static
analysis.

This change also makes the static analysis somewhat faster: presumably
because of the heavy use of repetitive macro declarations, applying
the semantic patches 'array.cocci' and 'swap.cocci' to 'sha1dc/sha1.c'
takes over half a minute each on my machine, which amounts to about a
third of the runtime of applying these two semantic patches to the
whole git source tree.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8f509576e9..73e2d16926 100644
--- a/Makefile
+++ b/Makefile
@@ -2666,10 +2666,16 @@ check: command-list.h
 	fi
 
 C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
-%.cocci.patch: %.cocci $(C_SOURCES)
+ifdef DC_SHA1_SUBMODULE
+COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
+else
+COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
+endif
+
+%.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
 	ret=0; \
-	for f in $(C_SOURCES); do \
+	for f in $(COCCI_SOURCES); do \
 		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
 			{ ret=$$?; break; }; \
 	done >$@+ 2>$@.log; \
-- 
2.18.0.408.g42635c01bc

