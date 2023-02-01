Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2374C636D4
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBAWUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBAWUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:20:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17464680
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:20:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg26so71725wmb.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyUYdkacW/oSCDKtBwO3yDAxSBJUoTR+Jn4Pv/DzWls=;
        b=c2v36yC+3pT6EjypsXIfdbP5r715lUJwB2wTdNmsOaoQTCoafz9uzmATfHV5Nv7d51
         CNwxFUAeSyDfz8H7KJMsuuFI/MVm+cwNrtqsGLljQN7fH1eogKUGXM3zXo5Zz+oPr/aH
         qiZRqRj8A0Kw41mE/ajz8wwixVlpD2Ce5YqHTwoYN/OmkL2c6chDMDrP7CKsy2UTBWew
         gPPp+VO87SnUbvnYOTYdXZIT85Bxxf16aqP01pO6++IyoUTgvwYQtTVwrK023EeBUwXP
         KH0QwbxwEpn7b6R2u13yhl7pThl5uHwTwEPG608i8u9a/gStAcrWa7o+4nq8SRaxTWpB
         wS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyUYdkacW/oSCDKtBwO3yDAxSBJUoTR+Jn4Pv/DzWls=;
        b=ewYpoT41ex5IbNX0zQT+8RL4yQwfZp4JcTEqGRrJrvEgX1NyMgLYFCHMwDqT7t4qUC
         TaDHiNElZKhu+GeUoakc5lN2fUkmfqE2khXNwLaDBNDqnRBDyktkHzzT8WKjliEsR+jQ
         Fe9lqAMPU+iHjJqDs2scqL0lTdbToLMkRPcHTkxu0PogDaCUA9UMeLywd1xop1mZ+iqy
         UxOYk1I0q484zKDWyRdkE+Ijwy10EVCajmjtkT3+FUp8Jac1rpAOCJ7FQj2wc7ayianV
         7xnF6Gwj7G9I6rUjcYDHrFbfBoHiX5ycAshtdYgipGRrGTKECmaB+kp6hWBm7fUWauzU
         ilKQ==
X-Gm-Message-State: AO0yUKUJTL4r4TQZAyidaDo0LVMj+x6rsK63iPgRXaqQkLR6EvZZj4zo
        +NEhYIQo09FbcZmQK58zaADKRUQnuUU=
X-Google-Smtp-Source: AK7set8Fb/XrpNmQ+LnBbDLeTw3tH5oZX21fJUFUYN8neKGIgXjxk3sPWvkAEe4E5d75w0RTbH7TtQ==
X-Received: by 2002:a05:600c:245:b0:3db:887:8c8c with SMTP id 5-20020a05600c024500b003db08878c8cmr3444877wmj.27.1675290035470;
        Wed, 01 Feb 2023 14:20:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003dc434b39c2sm3099762wmq.26.2023.02.01.14.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:20:35 -0800 (PST)
Message-Id: <pull.1445.v4.git.git.1675290034144.gitgitgadget@gmail.com>
In-Reply-To: <pull.1445.v3.git.git.1675262454817.gitgitgadget@gmail.com>
References: <pull.1445.v3.git.git.1675262454817.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 22:20:33 +0000
Subject: [PATCH v4] compat/winansi: check for errors of CreateThread()
 correctly
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1445%2FAtariDreams%2FhThread-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1445/AtariDreams/hThread-v4
Pull-Request: https://github.com/git/git/pull/1445

Range-diff vs v3:

 1:  1cbc43e0d82 ! 1:  6c4188977e8 win32: check for NULL after creating thread
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    win32: check for NULL after creating thread
     -
     -    Check for NULL handles, not "INVALID_HANDLE,"
     -    as CreateThread guarantees a valid handle in most cases.
     +    compat/winansi: check for errors of CreateThread() correctly
      
          The return value for failed thread creation is NULL,
          not INVALID_HANDLE_VALUE, unlike other Windows API functions.


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
