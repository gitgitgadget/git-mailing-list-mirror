Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E3AC3DA7A
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 01:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLYBkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 20:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiLYBkO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 20:40:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB3646A
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:40:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id co23so7645501wrb.4
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6GP/eZ3XXrZHZXftNTRfIXvKeFBn1NYVoQFNtA6JMQ=;
        b=SUkQ9JgOMdscFHaf1903nTVQ6AquFdnbEro7RGA5tM7SiO/AFspZvNwsx92D23BANU
         Nb76g0AbbDf20qmU505NXiHGe8ncO5qPNGMZPMdiv5HEYN864cqjDTiiks5V+eqImpX7
         hkYl4o0G87TfdvThRVSdkzkW9e+dMBXhyeeWdJ/6IN+9JnQEpk+R1p8vptCtQuxfx59g
         DabZKltlFsiEhDJQ7w4ewJyvtlYDJQdf1u+u3LzGLo8fkXvaBA6elCdcMUmzCYKwCAi7
         MdjjQVvHIBy2EtyVn7QnKOV5h9Xt3WNcUqTIqbW6r6Ns1sYrjfk+ABdYNTq02bfe4rIc
         Hxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6GP/eZ3XXrZHZXftNTRfIXvKeFBn1NYVoQFNtA6JMQ=;
        b=3lGlDuppE6ea7DwUZdtzWRQ5Xr1mKULQJ5vnb2W7Wk2QMlyTbrFWIamDCWkLNspZcR
         IXSy0z4yn6+557Ev+rREJlQ73YRYDGRvZssMF3dmKNhaf79/nN+0utHjCDAtFYtYnZMw
         pFobRIYODmFz2e+MIbyRnWup3pDAS0sV5XTgVwpqN52sgFlm98KYc7Njk4Cdf4kzPATn
         mvXqzzw1z1/NJSXgxbJPWVn0eJC64GhW1pVmmDFX3ckMjIF2ygPQT2iUfONUOui3tUzb
         Qbpzp+1Oscm2dTQUXACEl6cX6R+uaZ3+Lbn95GYJsNUILCc7Sdz2l2lepzcNB0l84Ckw
         d68A==
X-Gm-Message-State: AFqh2krOHxEWaymfFZjm5N6O4K1x33DFyGXSxONSsUQA9LCTe6otu2eu
        +q94Zm3ahAmPA597FzjdHBM5zuaY1IM=
X-Google-Smtp-Source: AMrXdXuFIe12o2/D0jd+dtJITp9/+dWydIatR6vByCvnBLHlFqiAdy471Oa+i7rHBtj0DiLlrdgwIg==
X-Received: by 2002:adf:f1c9:0:b0:271:808e:ad8b with SMTP id z9-20020adff1c9000000b00271808ead8bmr6622341wro.34.1671932407722;
        Sat, 24 Dec 2022 17:40:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm6699371wrq.10.2022.12.24.17.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 17:40:07 -0800 (PST)
Message-Id: <e0cc43efc6c498706559ae4fc71c597a6481f64c.1671932405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
References: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
        <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Dec 2022 01:40:04 +0000
Subject: [PATCH v12 1/2] win32-pthread: prepare pthread.c for change by
 formatting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

File has been formatted to meet coding guidelines

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..65e15a560d5 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -22,12 +22,12 @@ static unsigned __stdcall win32_start_routine(void *arg)
 }
 
 int pthread_create(pthread_t *thread, const void *unused,
-		   void *(*start_routine)(void*), void *arg)
+		   void *(*start_routine)(void *), void *arg)
 {
 	thread->arg = arg;
 	thread->start_routine = start_routine;
-	thread->handle = (HANDLE)
-		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
+	thread->handle = (HANDLE)_beginthreadex(NULL, 0, win32_start_routine,
+						thread, 0, NULL);
 
 	if (!thread->handle)
 		return errno;
@@ -37,16 +37,15 @@ int pthread_create(pthread_t *thread, const void *unused,
 
 int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
-	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
-	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			return 0;
-		case WAIT_ABANDONED:
-			return EINVAL;
-		default:
-			return err_win_to_posix(GetLastError());
+	switch (WaitForSingleObject(thread->handle, INFINITE)) {
+	case WAIT_OBJECT_0:
+		if (value_ptr)
+			*value_ptr = thread->arg;
+		return 0;
+	case WAIT_ABANDONED:
+		return EINVAL;
+	default:
+		return err_win_to_posix(GetLastError());
 	}
 }
 
-- 
gitgitgadget

