Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EACC38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjAWQq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjAWQqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 11:46:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C522BF04
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:46:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k16so9523400wms.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKVON092vIGEHy44EtP3+ojo2jDyu0o+fsjLi1fmn7k=;
        b=UgET5vC5IAMChC+A9tv3y4uar0twCP6unITYmEZe7nGQyCGLWp0t7f43x1LE0zq75b
         9eFFxqXrRqFsf4uhxRs0eUWNmfuorfCTyP3X7Vb1iGSqzg0RqyPnqUmlAnsRbxMSl6su
         oLTwAt/t3zZll5XOSBlm4K/WubEuOJA/x7OmyXUiT129IUpsWQg+jGaYoIILL2mworXc
         4yJLv1x7J1QAzJnjaabMSJAN6sACyOJLaT4p+OMZKS6w66H5r43YiIzlxA5olLqZfJN2
         rimnjKuRmxRFtSVhFKXBqN2W0k1yOp2BiSZRNzGTOPRSYpzhpko7WMos1kVOp/koVeD5
         QwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKVON092vIGEHy44EtP3+ojo2jDyu0o+fsjLi1fmn7k=;
        b=PnhJWO84rGvMEYjPbxK9Kjmb+efiZngXnOjy+e4TfMD6qLsTSiKSsE9+jtAxxOI5aZ
         FaooWwU/C95UauSAQbkQ/HI6i9qoiQz2qE6L1mEpv4949VQK4lCCbxbtsNzPkyqiX7oj
         HxwbOlt5vZvM/IByw4cwByDUs+F4SFJWIthaT2MnGp4wQclgGe5jvxq5nVaFgfB9+2vC
         GlYRwEtUI3BKulGlAG3hHOsBgMknc7D/E4Z+K+FDEwdfUxh1sqBDuFKvH0wLRUFmCulo
         7E1rVrVP4Vx/+v8H9MNr/lUufrKm9AZAbFxVPQKvsDQ6nYMbcIyjbMOMkaOhNjCyr3bg
         8Qkg==
X-Gm-Message-State: AFqh2kqJtwKEOT5KFPLWc1EBeFoGyFhq5915+XC7DPE9sSHeERhUL+am
        NAUQjLX6X/tsrbd+7slonlBHiDPuXVs=
X-Google-Smtp-Source: AMrXdXtPDJBMaOdC0DkhJLRAgMPGSHQDlgw42/0djNMJWqzskjxBaF9bgsjoaS6T6h9T3yKpsJwOUA==
X-Received: by 2002:a05:600c:1d10:b0:3d3:58d1:2588 with SMTP id l16-20020a05600c1d1000b003d358d12588mr21530550wms.41.1674492375056;
        Mon, 23 Jan 2023 08:46:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003dafa04ecc4sm10948079wmi.6.2023.01.23.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:46:14 -0800 (PST)
Message-Id: <pull.1440.v3.git.git.1674492373925.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.v2.git.git.1674491796648.gitgitgadget@gmail.com>
References: <pull.1440.v2.git.git.1674491796648.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 16:46:13 +0000
Subject: [PATCH v3] win32: fix thread usage for win32
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

Use _beginthreadex instead of CreateThread
since we use the Windows CRT,
as Microsoft recommends _beginthreadex
over CreateThread for these situations.

Finally, check for NULL handles, not "INVALID_HANDLE,"
as _beginthreadex guarantees a valid handle in most cases

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: fix thread usage for win32
    
    Use pthread_exit instead of async_exit.
    
    This means we do not have to deal with Windows's implementation
    requiring an unsigned exit coded despite the POSIX exit code requiring a
    signed exit code.
    
    Use _beginthreadex instead of CreateThread since we use the Windows CRT.
    
    Finally, check for NULL handles, not "INVALID_HANDLE," as _beginthreadex
    guarantees a valid handle in most cases
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v3
Pull-Request: https://github.com/git/git/pull/1440

Range-diff vs v2:

 1:  4a2c3da9d4c ! 1:  68baafba2bd win32: fix thread usage for win32
     @@ Commit message
          win32: fix thread usage for win32
      
          Use _beginthreadex instead of CreateThread
     -    since we use the Windows CRT.
     +    since we use the Windows CRT,
     +    as Microsoft recommends _beginthreadex
     +    over CreateThread for these situations.
      
          Finally, check for NULL handles, not "INVALID_HANDLE,"
          as _beginthreadex guarantees a valid handle in most cases


 compat/mingw.c   | 2 +-
 compat/winansi.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e433740381b..715f1c87e11 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2291,7 +2291,7 @@ static int start_timer_thread(void)
 	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
 	if (timer_event) {
 		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
-		if (!timer_thread )
+		if (!timer_thread)
 			return errno = ENOMEM,
 				error("cannot start timer thread");
 	} else
diff --git a/compat/winansi.c b/compat/winansi.c
index 3abe8dd5a27..be65b27bd75 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -340,7 +340,7 @@ enum {
 	TEXT = 0, ESCAPE = 033, BRACKET = '['
 };
 
-static DWORD WINAPI console_thread(LPVOID unused)
+static unsigned int WINAPI console_thread(LPVOID unused)
 {
 	unsigned char buffer[BUFFER_SIZE];
 	DWORD bytes;
@@ -643,9 +643,9 @@ void winansi_init(void)
 		die_lasterr("CreateFile for named pipe failed");
 
 	/* start console spool thread on the pipe's read end */
-	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
-	if (hthread == INVALID_HANDLE_VALUE)
-		die_lasterr("CreateThread(console_thread) failed");
+	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
+	if (!hthread)
+		die_lasterr("_beginthreadex(console_thread) failed");
 
 	/* schedule cleanup routine */
 	if (atexit(winansi_exit))

base-commit: 56c8fb1e95377900ec9d53c07886022af0a5d3c2
-- 
gitgitgadget
