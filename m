Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCC0C53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 15:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjAHPNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 10:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjAHPNP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 10:13:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DEFB1CF
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 07:13:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso1731783wmq.3
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXsirtRS6hXjc6n/KR2EEdkoUUSYhCKwnxbopnxL10c=;
        b=cG4stJsCMASc+YgfJqKdQfkiC78t8i4XwFaRzheGc5iDrrEMQJLJS4HxOE7v3IcgSC
         FM38oiHq7kshu49zL/bYxSxd+6RzQ6Jbp35KFJ2qj7Wvli3oN8FTF5vUNxZqERa6x+JR
         AY/oMvKuz4fv+kkBexehb9lCkEw7ZKFbwvhr1R8gCMIojKoWI7e0ZEqU68f9CP+jdhX2
         zFaceK83gMbJDmMMAizWqzIHT4mxUoWLDoxN4iLZmOKftUhPs5VINkZJugSnCFwqQ7tZ
         V9uv/fVrbGSUhWRg2BsdnPWtcLF80zw1L7osozCIjZ/H45+lgbZQuEZ1aneZzMllmD6/
         nfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXsirtRS6hXjc6n/KR2EEdkoUUSYhCKwnxbopnxL10c=;
        b=UQrJn3WclOimU6ui1b9exDPit0qzMaJ64z/FrAXxXWMHaK8z/GPmRTQxcqZ+o0Ix0C
         +bWEMUde/N5th3BVX1+FebRKtSBF8/WdfSr4HPF4kbSZmaRpVCySGhVStT+66UA2I/e5
         nV5E9nWxjsXBtiRu+4QKy4+RidSTO0X/+UHa4UeSU25HZrPifJ9VsChQaeVfJPqNp7Vb
         thKavKof/biefYWW+fVu6nLygUEz9mmjGoBCZmuEi/oyUIAKeV5Bi/GThC1lU9npaTlh
         jF7vpLD/FVijbHqo7oOVZSgL8iAdkUrQyNHFZvaBo0LImkAvYkEP67JAdA4tNhxiU6ay
         zwqg==
X-Gm-Message-State: AFqh2kqvTDKCzKA0LSnLZeG+2qpkrzPKwzeyWXP2r3D7BviK74glJVt/
        ClcmT16KuBPyYpQrsZ3Sad0ih40O0XQ=
X-Google-Smtp-Source: AMrXdXsfbvme8Y0TPT/7N8pSrk/8zmJC2UC/ygAbbZI1kwcq7HpmIqmBl+JNqqIR/wPHfU33OkgAFg==
X-Received: by 2002:a7b:ce10:0:b0:3d9:ec15:d5e8 with SMTP id m16-20020a7bce10000000b003d9ec15d5e8mr1655733wmc.8.1673190791770;
        Sun, 08 Jan 2023 07:13:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b49bd61b19sm14444542wms.15.2023.01.08.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 07:13:11 -0800 (PST)
Message-Id: <pull.1423.v3.git.git.1673190790670.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v2.git.git.1673188382186.gitgitgadget@gmail.com>
References: <pull.1423.v2.git.git.1673188382186.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 15:13:10 +0000
Subject: [PATCH v3] run-command: remove async_exit
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

Use pthread_exit instead of async_exit.

This means we do not have
to deal with Windows's implementation
requiring an unsigned exit coded
despite the POSIX exit code requiring
a signed exit code.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    run-command: remove async_exit
    
    Use pthread_exit instead of async_exit.
    
    This means we do not have to deal with Windows's implementation
    requiring an unsigned exit coded despite the POSIX exit code requiring a
    signed exit code.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1423%2FAtariDreams%2Fconsistency-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1423/AtariDreams/consistency-v3
Pull-Request: https://github.com/git/git/pull/1423

Range-diff vs v2:

 1:  d4cf19107ed ! 1:  21833375dca run-command: make async_exit usage consistent
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    run-command: make async_exit usage consistent
     +    run-command: remove async_exit
      
     -    Use async_exit instead of pthread_exit,
     -    and make async_exit inline.
     +    Use pthread_exit instead of async_exit.
      
     -    Functions were reordered
     -    so that this would compile.
     +    This means we do not have
     +    to deal with Windows's implementation
     +    requiring an unsigned exit coded
     +    despite the POSIX exit code requiring
     +    a signed exit code.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     @@ run-command.c: static void *run_thread(void *data)
      +		return 0; /* no asyncs started yet */
      +	return !pthread_equal(main_thread, pthread_self());
      +}
     -+
     -+static inline void NORETURN async_exit(int code)
     -+{
     -+	pthread_exit((void *)(intptr_t)code);
     -+}
      +
       static NORETURN void die_async(const char *err, va_list params)
       {
       	report_fn die_message_fn = get_die_message_routine();
     -@@ run-command.c: static NORETURN void die_async(const char *err, va_list params)
     - 			close(async->proc_in);
     - 		if (async->proc_out >= 0)
     - 			close(async->proc_out);
     --		pthread_exit((void *)128);
     -+		async_exit(128);
     - 	}
     - 
     - 	exit(128);
      @@ run-command.c: static int async_die_is_recursing(void)
       	return ret != NULL;
       }
     @@ run-command.c: int in_async(void)
       }
       
      -static void NORETURN async_exit(int code)
     -+static inline void NORETURN async_exit(int code)
     +-{
     +-	exit(code);
     +-}
     +-
     + #endif
     + 
     + void check_pipe(int err)
       {
     - 	exit(code);
     - }
     + 	if (err == EPIPE) {
     +-		if (in_async())
     +-			async_exit(141);
     ++		if (in_async()) {
     ++#ifdef NO_PTHREADS
     ++			exit(141);
     ++#else
     ++			pthread_exit((void *)141);
     ++#endif
     ++		}
     + 
     + 		signal(SIGPIPE, SIG_DFL);
     + 		raise(SIGPIPE);


 run-command.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/run-command.c b/run-command.c
index 756f1839aab..4a9bcd6c841 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1030,6 +1030,13 @@ static void *run_thread(void *data)
 	return (void *)ret;
 }
 
+int in_async(void)
+{
+	if (!main_thread_set)
+		return 0; /* no asyncs started yet */
+	return !pthread_equal(main_thread, pthread_self());
+}
+
 static NORETURN void die_async(const char *err, va_list params)
 {
 	report_fn die_message_fn = get_die_message_routine();
@@ -1055,18 +1062,6 @@ static int async_die_is_recursing(void)
 	return ret != NULL;
 }
 
-int in_async(void)
-{
-	if (!main_thread_set)
-		return 0; /* no asyncs started yet */
-	return !pthread_equal(main_thread, pthread_self());
-}
-
-static void NORETURN async_exit(int code)
-{
-	pthread_exit((void *)(intptr_t)code);
-}
-
 #else
 
 static struct {
@@ -1112,18 +1107,18 @@ int in_async(void)
 	return process_is_async;
 }
 
-static void NORETURN async_exit(int code)
-{
-	exit(code);
-}
-
 #endif
 
 void check_pipe(int err)
 {
 	if (err == EPIPE) {
-		if (in_async())
-			async_exit(141);
+		if (in_async()) {
+#ifdef NO_PTHREADS
+			exit(141);
+#else
+			pthread_exit((void *)141);
+#endif
+		}
 
 		signal(SIGPIPE, SIG_DFL);
 		raise(SIGPIPE);

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
