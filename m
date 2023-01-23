Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804BC38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 16:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjAWQs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjAWQsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 11:48:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DF929E16
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:48:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l8so9525780wms.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtuwCzh+v+pSQsHuYd+TjmeSFV8bGfWr45rZGg7FNQY=;
        b=FjIH1IW0lGW2DszPQldGTYXX6ohP4mXJlmp2l2zuqVFFVQvUm03LSE+ADLNvZ2Hf0V
         nzI2/NhpFatEDYsJ3fVYrAw6ElmQAFkscGYe0kstovDA84f3XYBZfKHnxFJW/es3LZ4t
         y6Tir9jFUsjz0W086TdYdDmdQU2mlUh3TL2Lb/JDYFkFDkBgnv3oxy2VvRHF5lWwxghW
         6tOX0LkK/MtC3yKKul/vzdgtVuv1BgI4vXIp+zk5IE7RVabaT/pfouGt8Arr0PwxHEEH
         jfE720X/Pre1Nc4aUyJXaqs/3WvQK/8oGW0Bx8nVf/DZmeP6W6syCSW8RZAWgOiEl7sC
         Wrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtuwCzh+v+pSQsHuYd+TjmeSFV8bGfWr45rZGg7FNQY=;
        b=b9sTaD0mYNN87UjDnWHPu5hvN5/eIZXwLqoAarirIYtJV2pGoWF+boZU+B4gxRF6Ej
         qyQRBd/Q8mfqvyEMtwH58gxGH1xQEK1CiKaOSs1L2aVUGJ9U0Z62bciq9WydaxDWU6iZ
         7G/TscodjRcJ5MrCKBzOdlDNR20Ht38HvK5TpDYj+fSj654bcfA4xEClFUduuQvCFfcN
         otZf9ZUVaAkOO/OEuNl0hx4QfmX8In59x0ZRSGXCiNeltVyh56/eCSV4DGgIuyXlD+n+
         w+AXEC64/rZEgAhsFA5cYPX0eZANeGovoOqOLAnVWcI+Viyfr/jSWoswv9TE7G/5vve5
         GYBQ==
X-Gm-Message-State: AFqh2kpL1EIw6XslIjkkvG1y+y7WTZQ/60vinn8/4RezqJSCC0Y40KMe
        jpL2ecEt8nUF3hf5zqyK3D/6ItSdZfo=
X-Google-Smtp-Source: AMrXdXsEFiDQhpAuJvb+63Rl7X1g8OI68U8qdvliYRimbrqOskChmIJ83sXQr14GF9Js5Lxh8WgHWQ==
X-Received: by 2002:a1c:750e:0:b0:3da:fcf6:7146 with SMTP id o14-20020a1c750e000000b003dafcf67146mr24837399wmc.14.1674492500727;
        Mon, 23 Jan 2023 08:48:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003d9ed40a512sm15433144wmb.45.2023.01.23.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:48:20 -0800 (PST)
Message-Id: <pull.1440.v4.git.git.1674492499537.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.v3.git.git.1674492373925.gitgitgadget@gmail.com>
References: <pull.1440.v3.git.git.1674492373925.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 16:48:19 +0000
Subject: [PATCH v4] win32: fix thread usage for win32
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v4
Pull-Request: https://github.com/git/git/pull/1440

Range-diff vs v3:

 1:  68baafba2bd ! 1:  2e2d5ce7745 win32: fix thread usage for win32
     @@ Commit message
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     - ## compat/mingw.c ##
     -@@ compat/mingw.c: static int start_timer_thread(void)
     - 	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
     - 	if (timer_event) {
     - 		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
     --		if (!timer_thread )
     -+		if (!timer_thread)
     - 			return errno = ENOMEM,
     - 				error("cannot start timer thread");
     - 	} else
     -
       ## compat/winansi.c ##
      @@ compat/winansi.c: enum {
       	TEXT = 0, ESCAPE = 033, BRACKET = '['


 compat/winansi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
