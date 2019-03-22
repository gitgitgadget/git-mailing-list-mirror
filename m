Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601FD20248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfCVJdJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43140 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfCVJdG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so1513096wre.10
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jib3do62HBczUeB+oBoN71sAedr5IFP+YlGi9nRh/qI=;
        b=L9ifJzX18QYuA53eCB+E4dHy6bBr8vo8YHy/4uKzz96RZN92rCMunn4agaszg/7+6i
         xn3k5lIrLgMgD+r80SbhQGDm8kl7mS1ErI2MfbmKlq1q0w8EibcwmEoboz7p6JZYVKxQ
         SK1c6WXjOBgFEGTALYC9UteCVB4Dltgc3QNB87yYG4fSpg1J6YxQJFjuVnRAa46fZjlo
         W0ymAqcLhceVzHV8Ch9UvHSkALTtnYjSbYyl297nCU0LBSZKMkAos5hY04q+P6NZhH4/
         VTNtTlXfRf4UWc1gvI/+a63jCKrenpR2LDQQwuaUqRktvdj3c+DQi0/KpEq8hi9uIhSj
         aV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jib3do62HBczUeB+oBoN71sAedr5IFP+YlGi9nRh/qI=;
        b=aCYRz0jiqDiO34j1YHaxx904J+3VXTbU3rfyGuCu6AJIiMieMUaW+f58H4puzX7wCB
         XrTii/K5Z/VJFsi2OhZKirYt7Rg/B8ViioUi3Qsog8jzSa9j6aN7ZMpLAocquZHqkiGM
         ER00UIW3CfokwJjJ1CtVn+WMTBEoK3gbuBh/Pz+CQ0knD+WWAtE0RmZ6gQvBKDffc7TG
         UsVnsMQkhd3kYLhj3XjP6aCs2Qxtj3MemO+qzubqJLWnlDo7zvSRRS91s6CFhIGA71JE
         3J35zq49Au6r5j91dpuUMcD8R2vaDoC99M4qbe4WxuCJ/X2qHyoq5J5CDLPxy+iB2qJ1
         2how==
X-Gm-Message-State: APjAAAXJhFwkCHrpNpI5jUdx/U65WCtfeKACtEbwDY4scVurxTM+AQne
        zheCfagsupFRZKJi9oGPWZTwS3MY9rI=
X-Google-Smtp-Source: APXvYqyFGYq1ZoDKaSpZ40fPqbPM/TL9a/6FQralaMkU+f3a4/0ALSUHj72OM5MQlzuiQ1g45yrO/g==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr5927017wrm.52.1553247183958;
        Fri, 22 Mar 2019 02:33:03 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:03 -0700 (PDT)
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
Subject: [PATCH v3 03/11] gc docs: clean grammar for "gc.bigPackThreshold"
Date:   Fri, 22 Mar 2019 10:32:34 +0100
Message-Id: <20190322093242.5508-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
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
index c56f4f7cde..66386439b7 100644
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

