Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276F020248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCUUvM (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41896 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUUvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1so57063wrs.8
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zB4mFhoGK4KPanI8kveD7MqMJFbMODEDoT+z3r37pjU=;
        b=X2pWMEWwFfqkUAHzwdSJr+TbQHEq/fSDLw8jwjmx2H+fJntBUqvrxaZUDVNmf1aJkk
         ggvRjpAPEXNwuvHDTIpmmprixUlHLoDjHnNz2urZ3tIeQM1l7YDohajbzc/D9mNpsF/V
         KiaaebfHAEP7w64UXo9NlmU1gOp52E0RDeQXm4QWz7bs7IWTbyimszd+W69oR4QbUOgn
         irNRCvxhGQ1FfYFpEn73zeKqdfsYR5EPAUsYnOuuw8lIwUk/X2Ru+Whf9MBGFqspaGJE
         HC49carUgbYXh7DUenVl3q9ZWzT/R/yYL7KVnZlh5lvlzJ3N3nzRZEjiMq5d68UI1ScJ
         gvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zB4mFhoGK4KPanI8kveD7MqMJFbMODEDoT+z3r37pjU=;
        b=qngWJqMZVEHHoUu0d8jgjdaQQHt7tkUizpFCtnjvs4dwKCtu9dJkek5tP9SiiJILXw
         MHcedS7eW+OdVv9aHNTILP8k3CdcTgvADwucKnw4lryk7g1MEEJ7vqbW/D2XxjGIyQT3
         v48eyafT7HNCy4SOZ11YQLiQJHMWh/BAMNFQ/+WcvSkKOxMLz51ZAjsMYo28aVg033KM
         iSRLeOtW0BwV706JXc+vLbs7Dx1UhssHq6Vsb6hgRyHZ/wVpGjGMxTuhX75+6zdVC8y5
         SLCodpmbio42F50AJsXWGCOQ4+3/Fll7gpJshx7rNFeTK2+0m7+2O6xLDvNa/cdcCVZF
         ECzA==
X-Gm-Message-State: APjAAAVq4rJ0M2ismRqn4s/SoRCglYtBBgU16jGWZp9fKTurX/yTeMTu
        nG8O+qZdYnYr96jqdD+l3y8N5JlJ
X-Google-Smtp-Source: APXvYqwkqP96wEwfs68VYd+WUHyPZD9X6B9PcQpXPqyxydKW6WAYwwcbXwJVGoZvCCo62mgZbpH2Lw==
X-Received: by 2002:adf:c002:: with SMTP id z2mr4072610wre.177.1553201468534;
        Thu, 21 Mar 2019 13:51:08 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] gc docs: clean grammar for "gc.bigPackThreshold"
Date:   Thu, 21 Mar 2019 21:50:47 +0100
Message-Id: <20190321205054.17109-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up the grammar in the documentation for
"gc.bigPackThreshold". This documentation was added in 9806f5a7bf ("gc
--auto: exclude base pack if not enough mem to "repack -ad"",
2018-04-15).

Saying "the amount of memory estimated for" flows more smoothly than
the previous "the amount of memory is estimated not enough".

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 95c3237f8e..c31fe581d9 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -59,8 +59,8 @@ If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file
 or over `gc.bigPackThreshold` limit)
 are consolidated into a single pack.
-If the amount of memory is estimated not enough for `git repack` to
-run smoothly and `gc.bigPackThreshold` is not set, the largest
+If the amount of memory estimated for `git repack` to run smoothly is
+not available and `gc.bigPackThreshold` is not set, the largest
 pack will also be excluded (this is the equivalent of running `git gc`
 with `--keep-base-pack`).
 Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
-- 
2.21.0.360.g471c308f928

