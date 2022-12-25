Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A6C4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 01:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLYBlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 20:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLYBly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 20:41:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5F26CC
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:41:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso6618498wmb.1
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP6p4+iDsjBWqerhJIFgmb1SHNUQyfMhwQ/g/Zhp/kc=;
        b=O8bUQHZFIgrIYm9p1ywQfugwvpAGYxTK+A0An8d9HrS34am6rf2MUxJt8u/TeZGwJE
         chqEUknyWFL+v+CdUZezxdOby6AQm31As+HLO8UCtnvsWH92sOfS/Nf6CjHmqZ6s7YF7
         2v0QS6Z5SGoQhHZ4IgT/AszP83HFmBEqAHiy4foLEJJ8yE+35GAkuV66J04bSuUEN8sj
         KjVKN6Mnj17yzAm8i6EGspzIx+kNknaUay2gg2/G7x2992uT2y0/uMELAL3AtbAYgpcb
         0AnlC0W7TOrqDdtsg7AnNMV/UkvabbsqSi5RrxBlJAMZMrdRHvJyBNsEsywF+khxLiZe
         khLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP6p4+iDsjBWqerhJIFgmb1SHNUQyfMhwQ/g/Zhp/kc=;
        b=Fx0/bVawhZA7+Q7dcq3h0xx9OnzQfySrsbyaPsTijEUPZemdN+zox6ULv4W5D/r9k4
         Ttr4x3/2l9if/fK+IA4V26zBHNQ/GxwhPpjdSVzmXcd8hJj7QJxHVRRqhQp/NipUGqm0
         IVcxTlozAEjCat1xSyZN6du2pOLQlnRjLmgAXtGo6dQ1vKjOrwX0G/8nKkSCOqGJd/jN
         ANW2vlvan+u7Glz2yPzGnC4x2oelCIF8dghPx2WneBRBQuGrNnYIB99ujAnG3ApC6k/L
         VxwH0sluQxewtx/CPJoZqeurLdGDB1AJCIua/kCu3jqfqc6ceFuNdN2eQ74dgor6o/8F
         JxJg==
X-Gm-Message-State: AFqh2kqqF5Mdjlse8NeBLoDiqNCsqypf6imEGt9y1Vi38eI8wKxfsktz
        nN9QJY3uG8wyiMHDNpvMBoC84inBTCI=
X-Google-Smtp-Source: AMrXdXumnna2bQTRuLOxMOq6UhSYRghk543peltJjgCxC4XeNeQAmYyPRYyFUGH+qXhvDfRaLMvhdQ==
X-Received: by 2002:a05:600c:3584:b0:3d9:719a:8f7d with SMTP id p4-20020a05600c358400b003d9719a8f7dmr3582583wmq.35.1671932511576;
        Sat, 24 Dec 2022 17:41:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c161600b003cfa622a18asm13359718wmn.3.2022.12.24.17.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 17:41:51 -0800 (PST)
Message-Id: <pull.1414.v2.git.git.1671932510529.gitgitgadget@gmail.com>
In-Reply-To: <pull.1414.git.git.1671742750504.gitgitgadget@gmail.com>
References: <pull.1414.git.git.1671742750504.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Dec 2022 01:41:50 +0000
Subject: [PATCH v2] win32: use _endthreadex to terminate threads, not
 ExitThread
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Because we use the C runtime and
use _beginthreadex to create pthreads,
pthread_exit MUST use _endthreadex.

Otherwise, according to Microsoft:
"Failure to do so results in small
memory leaks when the thread
calls ExitThread."

Simply put, this is not the same as ExitThread.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: use _endthreadex to terminate threads, not ExitThread
    
    Because we use the C runtime and use _beginthread to create pthreads,
    pthread_exit MUST use _endthread.
    
    Otherwise, according to Microsoft: "Failure to do so results in small
    memory leaks when the thread calls ExitThread."
    
    Simply put, this is not the same as ExitThread.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1414%2FAtariDreams%2Fsevere-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1414/AtariDreams/severe-bug-v2
Pull-Request: https://github.com/git/git/pull/1414

Range-diff vs v1:

 1:  78f9d54c304 ! 1:  3e8212fb9a7 win32: use _endthreadex to terminate threads, not ExitThread
     @@ Metadata
       ## Commit message ##
          win32: use _endthreadex to terminate threads, not ExitThread
      
     -    This is a pretty serious bug actually:
          Because we use the C runtime and
          use _beginthreadex to create pthreads,
          pthread_exit MUST use _endthreadex.


 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 737983d00ba..cc3221cb2c8 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -66,7 +66,7 @@ pthread_t pthread_self(void);
 
 static inline void NORETURN pthread_exit(void *ret)
 {
-	ExitThread((DWORD)(intptr_t)ret);
+	_endthreadex((unsigned)(uintptr_t)ret);
 }
 
 typedef DWORD pthread_key_t;

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
