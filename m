Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3FFC636D3
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjAaOr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAaOr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 09:47:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3EF49029
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 06:47:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a3so7742551wrt.6
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywdzv/aYYSO874ESOIsIrtHztyINa0o6cHyYJaZCqOw=;
        b=P1v/Qu3TWAB1zJkdouIv43UKuOrWEF8DQD5RF6yRrWDbhM7AdSUu99gkLmSWZsg3Lz
         6qIzVf2YA5BpxZBQkRMrfjqz4G6eLs8p3MbawFHUcGJNGnMGETcEVslZ4KqhU8zLCHrD
         G8oxOY7WVODoFnM4G3rhYony/A9r4P9LdJFKsdjRJ4YyNSt/7bM0I5jIlaNKTlmeLx/X
         vePqY9N7eP3agW6iz6SGbDowggSfp7ZAJNjVJ38xYOrwXnAQdEU8AWoexsgKYv72ZBDf
         h8N9Jsb5z24J6ag9F+nM3uNMt4dQZTjQeELxYc5o9PKK/dDbeDkgdUEP2LYaXamyhNOf
         WVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywdzv/aYYSO874ESOIsIrtHztyINa0o6cHyYJaZCqOw=;
        b=K2QY4gBaQkOTSxXkmj97D+dV4WtOgN2p2omT3IKJ4RuDJ7Af9RCYhYwPJeIau5GAtN
         GXy2ObQ8Zvu0g9SMIbO0UKwkfSOC0T98II6IKXJjCofLGryZyysQoFlvKwbGkV4ImtBy
         rY6wDlohZ4uBHYalohlWTAzXbLE6I5fMELfOMRaFbhm5jGr+z8MH6zKOT7acA+VyhOpX
         YGlBgdMWDh5qvmqnr+qE4fQKxMYyarKEEqwgnbVPHDzv1EIJ03yLIbm5E/zeEyeYPEVI
         gw915v/i5OivMijHjrZllu7Ty0nGrKjrXl5mPs/UtmsI/JOkNW6TN79HuCCyZ9CQjBgb
         zreA==
X-Gm-Message-State: AO0yUKW6MGHaQvBjL2WcRtgy6GlaOly2C+XgFnMua7cgt7rheUwcUL7R
        BDUoYNiyEjNro708/sfCvkbNUleW9BQ=
X-Google-Smtp-Source: AK7set9KuJ6GE42WuGhqEQT/uVE6Md4B93/GzraIi7rtPKulecWm/s0WZuktwdepkBOhBS5IvboWXg==
X-Received: by 2002:adf:ed88:0:b0:2bf:e31a:26b9 with SMTP id c8-20020adfed88000000b002bfe31a26b9mr10999632wro.63.1675176443775;
        Tue, 31 Jan 2023 06:47:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a5d56cd000000b002bfd462d13asm14302831wrw.18.2023.01.31.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:47:23 -0800 (PST)
Message-Id: <pull.1440.v5.git.git.1675176442381.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.v4.git.git.1674492499537.gitgitgadget@gmail.com>
References: <pull.1440.v4.git.git.1674492499537.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 14:47:22 +0000
Subject: [PATCH v5] win32: fix thread usage for win32
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v5
Pull-Request: https://github.com/git/git/pull/1440

Range-diff vs v4:

 1:  2e2d5ce7745 = 1:  6ab79d9275d win32: fix thread usage for win32


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

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
