Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE214C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 14:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjBAOlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjBAOlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 09:41:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4A611D0
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 06:40:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d14so17518955wrr.9
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTMECpUDKTHS74HXHwmTPr2Hocf59CkCntJyeARu1a0=;
        b=pDgUegO40vO70+b/pmA4AwhCqkPXz1QAny5XTj3FjSvfhpbh+Jonov3niEAzI2+W/3
         gtCdrNeTq7RQnteHa2umuaX82Ocm1tt4OcuGBT3uplbzF9gUkihHzhSwu/bmKpYia+Zf
         02Zi/DfI3iKsOmOlI8xhg8x1llZFvnFX28g6QXS0RsdxDzn7zAfQGVJYWfwZxiOd1jvI
         RNHqa50W4DOgkaDRYXE2Sw5i/zCgRFRoUjs5fi6lJWWHVOgnMsj9GO+pCu3Np8jNHumA
         4VuzCDfWEAz4FC/2Z4hnLgg7h3bfUQHQxHZPi7LwHhaCubBBz5O/6VGByCk+e8inHI3X
         hcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTMECpUDKTHS74HXHwmTPr2Hocf59CkCntJyeARu1a0=;
        b=iyGPDrvSON4PxH09SdHdgurEYfKHF+nmUTg3NFypDGrCHIZWUPiGoSV6yiRJes0zdn
         NVs/7da9iniFzV9ZkB2kWwjIp/p6IUufzZD/dD7eAy58og6fq1RXiF1SFaw7k4ZnzozW
         uyjLvLmGKpAFIUg/qv7fe03jzxwuHlmYXxGRc4V2NaZLglWz9h2e+OvWeEVyaWLc5I/E
         hDJTSTEZuj922/yP3fHB8k1c40OumJiVb6/XKTWxjX1liU8EYF2kNKW5cDGaykqkBU8W
         iz/7row/N+SyIU60nB3ice9FGc1EhZZq60soPrcjqkkF7wWJXZlaUFWHXoA8pBrrE/M7
         Zwgg==
X-Gm-Message-State: AO0yUKUgEbBuMpjV+UwQmYQmVgf53CcO9oIDjEX7dGIYMvpXC1Ki5/aH
        RJ19TkW+vvJ0oDFczVquN5wu3hsddPc=
X-Google-Smtp-Source: AK7set9ze23F/wrCycnZigPrPekrW2okHYceZL31blwxVaSWaxNXrojMQ9kN+z29ojfq37sKgmv1oA==
X-Received: by 2002:a05:6000:1561:b0:2bf:eb67:4774 with SMTP id 1-20020a056000156100b002bfeb674774mr3595839wrz.11.1675262455746;
        Wed, 01 Feb 2023 06:40:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d43cd000000b0027cb20605e3sm17525436wrr.105.2023.02.01.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:40:55 -0800 (PST)
Message-Id: <pull.1445.v3.git.git.1675262454817.gitgitgadget@gmail.com>
In-Reply-To: <pull.1445.v2.git.git.1675176818033.gitgitgadget@gmail.com>
References: <pull.1445.v2.git.git.1675176818033.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 14:40:54 +0000
Subject: [PATCH v3] win32: check for NULL after creating thread
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Check for NULL handles, not "INVALID_HANDLE,"
as CreateThread guarantees a valid handle in most cases.

The return value for failed thread creation is NULL,
not INVALID_HANDLE_VALUE, unlike other Windows API functions.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: check for NULL after creating thread
    
    Check for NULL handles, not "INVALID_HANDLE," as CreateThread guarantees
    a valid handle in most cases.
    
    The return value for failed thread creation is NULL, not
    INVALID_HANDLE_VALUE, unlike other Windows API functions.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1445%2FAtariDreams%2FhThread-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1445/AtariDreams/hThread-v3
Pull-Request: https://github.com/git/git/pull/1445

Range-diff vs v2:

 1:  c956cafdec9 ! 1:  1cbc43e0d82 win32: check for NULL after creating thread
     @@ Commit message
          as CreateThread guarantees a valid handle in most cases.
      
          The return value for failed thread creation is NULL,
     -    not INVALID_HANDLE_VALUE, unlike other Windows
     -    API functions.
     +    not INVALID_HANDLE_VALUE, unlike other Windows API functions.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      


 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3abe8dd5a27..f83610f684d 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -644,7 +644,7 @@ void winansi_init(void)
 
 	/* start console spool thread on the pipe's read end */
 	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
-	if (hthread == INVALID_HANDLE_VALUE)
+	if (!hthread)
 		die_lasterr("CreateThread(console_thread) failed");
 
 	/* schedule cleanup routine */

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
