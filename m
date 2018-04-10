Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A06B1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDJV0e (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:26:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42181 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJV0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:26:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id t20-v6so5493281ply.9
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R85Dtvp5ptKHjmpwwvCurKJ4yd3m8Gs5QQ38ta3HH7Y=;
        b=iCEHTLgF/25vij/77iXWkcT1SnjfO9aVOFUZTJw4MWnxgTJ2Oc4FVzGBaMHf0OkC5n
         cTZzXjDWN2gmxO7z5PaUiBIGxR4DfOF53PF8kgJua6psAbz5gtxGPne6RzbzJ3fzQb7E
         AywsvhkB1B/wZHHoxwot2fXPIiYzULJdPGWr4bKeI8WQKL0yh+fVVycwmZEUU6CQ8lVX
         J7g2P/fb8DJORgALKm4hmCI1bahPg1aIJqF1uB7Ifqd00Hz1Whj9ovZ2cn9Sgmis4VA0
         VtQNBLbaW4zWtGw+03CT1gT2k2F33t1gsebjc2oOPAy3x7Zn0qdsnzzV6ImOfpM/0L+G
         oTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R85Dtvp5ptKHjmpwwvCurKJ4yd3m8Gs5QQ38ta3HH7Y=;
        b=eSG725cPwFXq42IwXEL5GFdjImJ8Kp+ed9Q4Lx87KzL1pnLekYQF8NK7ygTlqyBz/y
         YTEcR/9axUFcz6YofvRrYazK8t4UjZdPmq5HF9Z1nPtNEWVnAzFM6jKkzOZY5QhwWPAW
         n5JQ9TNvvls7A7E6MCvkZKIRybCRD3JqDUU4qi62geodmc9RU19sb/oiE5RadtmY+ZHj
         AkxiwF+Wc6Pf0XwYGn8QowcFIwM4EQSYS7TBGeBOLqshE0DSZNmbc2KVon0PAq7xf2+2
         2W93jBT0PPOIJJkMznpsuBPpdaTq8WDPHYeXgfkzdkq1w9t2xp//MBACN0d7Uel+Gt2H
         DJFQ==
X-Gm-Message-State: ALQs6tBffOS5MUoIGCvxZu3+BW06LuWEKVmI/jn/8nDg7aeQN4wYRg0V
        ZSZ/sg322aHH/4eeO6LpDycsS5GT5NQ=
X-Google-Smtp-Source: AIpwx4+T5nFMThlulzXEzhxXoh0VGN+CFafqU505Ux9eBGhS1tUnP2E4T8fNXhH69LmUW9rJ9zRf+Q==
X-Received: by 2002:a17:902:9001:: with SMTP id a1-v6mr2041655plp.211.1523395592414;
        Tue, 10 Apr 2018 14:26:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d4sm8641685pgc.43.2018.04.10.14.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:26:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 1/6] write_or_die.c: rename to use dashes in file name
Date:   Tue, 10 Apr 2018 14:26:16 -0700
Message-Id: <20180410212621.259409-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
 <20180410212621.259409-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more consistent with the project style. The majority of Git's
source files use dashes in preference to underscores in their file names.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile                         | 2 +-
 write_or_die.c => write-or-die.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename write_or_die.c => write-or-die.c (100%)

diff --git a/Makefile b/Makefile
index 96f6138f63..be4ac5b2a6 100644
--- a/Makefile
+++ b/Makefile
@@ -933,7 +933,7 @@ LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
 LIB_OBJS += worktree.o
 LIB_OBJS += wrapper.o
-LIB_OBJS += write_or_die.o
+LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
diff --git a/write_or_die.c b/write-or-die.c
similarity index 100%
rename from write_or_die.c
rename to write-or-die.c
-- 
2.17.0.484.g0c8726318c-goog

