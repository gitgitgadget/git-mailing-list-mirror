Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DE31F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 16:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408066AbfJYQtP (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 12:49:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38468 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfJYQtO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 12:49:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so2545952wms.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYVEpgBdS49RKH6l2tbvvF4Dmwjb+r3JAHid1MrIR4E=;
        b=ALPhNB+RM1ElJqfieb76M8aaaC/7SY6nKs2wXbautIclNdmGX7CgNvLCUEzSzblpC+
         KyVYUaBfmonwM7UMZfi3tMNtDFITYMbdVvxogBRD86CPHKd6e1h5PF9+DqfSta3EyD/1
         T0kF+RyzdgEuzAOFV8cBesa+I6rSZ1mmR5PpNV6t4HLE3dBrTeDLTQTA56+Wdi2ld3+M
         Zb7ZKVS+JaoztZNgeQBZx8FVg0J2PbPtCoAjWKv5+Czu4yRijR3o/CJ4R2b82agGETt8
         5L9ck7pkGZHs86T5QDf7/9h1LdYTf7wqzzjO9XMXIZW7sqoGXfHTbLULoWqfnMef2nGZ
         cDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYVEpgBdS49RKH6l2tbvvF4Dmwjb+r3JAHid1MrIR4E=;
        b=qx/9tllx2SX+IQCk9A8NxcyWa/5GF+GEolAyRZLKhoKwqNxuavtmDwL3MnoeYmMbvT
         Z0WX6kWGe5JQV1NvlGKwz1XkmmcKDz6Co7BG3Q/fgSB+7/zIPEa6PeF7DfesuskABPuO
         DzlETqtPdbrwuTlUciw/WFKojCOo3OPpBx5NWGoxS/z2zxnOvOCKeHiuDGy2NxnRmGZg
         89Z/f7adPjJvH0XojZ+0rsI88b+aYcDMFpByhGulkdYhJMdAHon4QfUbxqT2rd7CSdi5
         EUkczCMi86QCfPzeuXscxDZ7FnDnhj0uYgMIY0METwAXpfYjjMLziG4ULamvkOHPfoTz
         1bsQ==
X-Gm-Message-State: APjAAAVCKV7D8XCEEsy9Zz5HgwBZVFqlq44Yo/s2HH33Fj4SY+WUXTF1
        zVtpQIduasAlFhlbKw19ETo=
X-Google-Smtp-Source: APXvYqynKC1+oHzgweIXFLougyjFoxh49NwSlT9PQ3209hjMgoJa4ClE1jHA3mU3v/n4AcvjP5GPIw==
X-Received: by 2002:a05:600c:2212:: with SMTP id z18mr4741229wml.154.1572022152780;
        Fri, 25 Oct 2019 09:49:12 -0700 (PDT)
Received: from localhost.localdomain (x4db52416.dyn.telefonica.de. [77.181.36.22])
        by smtp.gmail.com with ESMTPSA id j63sm3126186wmj.46.2019.10.25.09.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Oct 2019 09:49:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] builtin/commit-graph.c: remove subcommand-less usage string
Date:   Fri, 25 Oct 2019 18:49:09 +0200
Message-Id: <20191025164909.354-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.538.gfb6e1f15ab
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first line in 'git commit-graph's usage string indicates that this
command can be invoked without specifying a subcommand.  However, this
is not the case:

  $ git commit-graph
  usage: git commit-graph [--object-dir <objdir>]
     or: git commit-graph read [--object-dir <objdir>]
  [...]
  $ echo $?
  129

Remove this line from the usage string.

The synopsis in the manpage doesn't contain this line.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/commit-graph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c6219ebe11..4d9b9c862f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,6 @@
 #include "object-store.h"
 
 static char const * const builtin_commit_graph_usage[] = {
-	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
-- 
2.24.0.rc1.539.g061db24550

