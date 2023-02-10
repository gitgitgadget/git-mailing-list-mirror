Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90FBC636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 15:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjBJPFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 10:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjBJPFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 10:05:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D7211CE
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:05:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j23so5402060wra.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6aajj9Fn0bi3yan27CVyUPXjOaUmn6cANrnsCxKC8U=;
        b=Etdn1bIgZVKuNhSrtOirO+ehUc13AjDWXeAodzQZ4LTFpJP+jRdNI8zjiekgLkrXKy
         hKtdtNrC0rYxCUirBpw+FpKsRI1Wa0/qZP9ZgHGeMWKTThEunjxl1KOFkHkNmjIc8xmH
         cLCih0+x4efQWAj0PKmZg+l/Hx1KrtqrAqiCL76vzGZVpl+CJo5JWs1P75Ks/m4A/tkf
         JW+jF+3D59yqtfgdpc/4gT+FhCdYF5lsDEf8m1psKYngK/lm5JHlAsrXP4EYeRtALV4P
         Xovq6IQWEoEJ/DLw63Uk3mwHEl/2Q8d9fclVxrFjfxcMRMD3nM1AR9+TVIRCzxa/wfQu
         BONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6aajj9Fn0bi3yan27CVyUPXjOaUmn6cANrnsCxKC8U=;
        b=p8UZvavvRt4qqJ/W7H/oVR+1mZ0PtaBqqK0cNQEHtczC4BD6UqAm0iOQtISezROVWr
         lhQ4nF8QJpFDtvp7rCqJwo5ln+D1+sF+wCzh33lzPBlSF2ZxDQvFYsUngILz/469PvCd
         4CMdccJADquS2y5R7XyjAuScASQfbnAasbF7eMpaTiuLhttVQXoSrCjM375HU5f5UHYB
         i1+90MFKZJzhkRc1o3MI0gJ1Wvor89CGghBakeFfzv5x7JvS10UX4TiVI2qL31eR/aiQ
         CJMiZcRfRTtfz9qfMWahFwiJXRPGGuQVH9LIXwbqd2dAqhrTr3d4UfRji4NixYlRLIAN
         8HEg==
X-Gm-Message-State: AO0yUKX6R8zfBo5E4OFye7x/inUxmcCaTGgD4BtTGUER1sZ9fk84SIAG
        0Y6qRtwIo72qRWN5/GhDX47cB/K384A=
X-Google-Smtp-Source: AK7set8Lj8zMbIlURwuF/9sZbkMFP39lX4t5fNHkncV5vNPsTYEPNY8FgirjxUDeefK+9o8SEN99Og==
X-Received: by 2002:a5d:4fc5:0:b0:2c3:e297:8e4d with SMTP id h5-20020a5d4fc5000000b002c3e2978e4dmr4673727wrw.6.1676041475045;
        Fri, 10 Feb 2023 07:04:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a5d574e000000b002bfb02153d1sm3872866wrw.45.2023.02.10.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:04:34 -0800 (PST)
Message-Id: <pull.1440.v6.git.git.1676041473607.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.v5.git.git.1675176442381.gitgitgadget@gmail.com>
References: <pull.1440.v5.git.git.1675176442381.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Feb 2023 15:04:33 +0000
Subject: [PATCH v6] win32: fix thread usage for win32
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v6
Pull-Request: https://github.com/git/git/pull/1440

Range-diff vs v5:

 1:  6ab79d9275d ! 1:  67cef4bd8c9 win32: fix thread usage for win32
     @@ compat/winansi.c: void winansi_init(void)
       
       	/* start console spool thread on the pipe's read end */
      -	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
     --	if (hthread == INVALID_HANDLE_VALUE)
     --		die_lasterr("CreateThread(console_thread) failed");
      +	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
     -+	if (!hthread)
     + 	if (!hthread)
     +-		die_lasterr("CreateThread(console_thread) failed");
      +		die_lasterr("_beginthreadex(console_thread) failed");
       
       	/* schedule cleanup routine */


 compat/winansi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index f83610f684d..be65b27bd75 100644
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
+	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
 	if (!hthread)
-		die_lasterr("CreateThread(console_thread) failed");
+		die_lasterr("_beginthreadex(console_thread) failed");
 
 	/* schedule cleanup routine */
 	if (atexit(winansi_exit))

base-commit: 23c56f7bd5f1667f8b793d796bf30e39545920f6
-- 
gitgitgadget
