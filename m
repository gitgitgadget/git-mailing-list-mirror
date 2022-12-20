Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AA9C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 20:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiLTUEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 15:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLTUEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 15:04:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531CA1AA3F
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:04:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h11so12818708wrw.13
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcgVdPDor86TyrWCXGVn9KQX9sG95QlBazETZ4moG/c=;
        b=ecVfVU92lTTQvg8s6x5kr9sgATCSQYbMw0bjhSC9f1H1hXEkzGGaUa5V78cQqN9k03
         yd7j7AO27nMnQCnFTYEG8U7ZqtrvgB7ocmLqcTYqU3QadZ9F+LuLY4crxUZlROkeZEuN
         kuueMNoVQl0qUhXLx2/mUs5lO1tQDxSos/Q6+hguopn4ROe8sr7SvHIIZtFk/eyipKqi
         PAh/+dB5d2JIijxx0uOWqgNovGwmuz07BZyZ+vJmod7JCA1HWL/3JKD6qMRNC5EovaOi
         kvKbAHu46k4u/RKmluHNVrY5f60P8h6hJbhgJTNqJW7e2ME8lauMHa6isj/bmzehAzvc
         /aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcgVdPDor86TyrWCXGVn9KQX9sG95QlBazETZ4moG/c=;
        b=qr2NI6nAlLFpIbb55rDNQFnswM9Duc8ShdftgK/11aWLjNOtvLKThzJLoFoESypElY
         ZNkH0NfeZQKK0tz+pcVHpGk3T/RCMFeKTJjHQ7MlbO0uZFGr0eF0xUbxM+CZUKu95MbT
         iS+nNux6CZoDqciw7AN+gLvm9WJnKr70teppX+6tzY4e2cHTIz/RGdoRiqZCMJQ/ekNO
         i1J6bfLG23NGdmmvBYUl68ea5lxL9lEQhN3brVCIdBlDr4lYGuRsn7EcgHkUZ9WzGoCb
         COQ0Nq1cCuOU1qMqt3JvmVBL5Xu7BxEfIdJLcioFmuJGoNrjKOh3DhdeRWyse7VTZ97j
         ekBw==
X-Gm-Message-State: ANoB5pkkoFH6yyoE+Wou4XFLNZoCk0z8+dIUVpC8VRLtkQbkQFvt2dXo
        576qup/XH5a/DcPPMoFiKp1veSXBQvE=
X-Google-Smtp-Source: AA0mqf5sOKz7oNmsp5rSNr9mctOCqywoem2oCl4AvjsocCo5uNzHJRNKRgycG8KtuB69bCHvMQ7aZg==
X-Received: by 2002:a5d:460b:0:b0:241:f818:f09 with SMTP id t11-20020a5d460b000000b00241f8180f09mr28008530wrq.24.1671566644748;
        Tue, 20 Dec 2022 12:04:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b00228cbac7a25sm13500147wrm.64.2022.12.20.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:04:04 -0800 (PST)
Message-Id: <2cb4d5c70072b3e3a4bfb85fe486b78b231a2a8c.1671566641.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
References: <pull.1406.v3.git.git.1671562845014.gitgitgadget@gmail.com>
        <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 20:04:01 +0000
Subject: [PATCH v4 2/2] prep
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 89e89c3fe00..0831ffbc3ae 100644
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
@@ -39,19 +39,19 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
 	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
 	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			/* detach the thread once the join succeeds */
-			CloseHandle(thread->handle);
-			return 0;
-		case WAIT_ABANDONED:
-			/* either thread is not joinable or another thread is
-			 * waiting on this, so do not detatch */
-			return EINVAL;
-		default:
-			/* the function failed, so do not detach */
-			return err_win_to_posix(GetLastError());
+	case WAIT_OBJECT_0:
+		if (value_ptr)
+			*value_ptr = thread->arg;
+		/* detach the thread once the join succeeds */
+		CloseHandle(thread->handle);
+		return 0;
+	case WAIT_ABANDONED:
+		/* either thread is not joinable or another thread is
+		 * waiting on this, so do not detatch */
+		return EINVAL;
+	default:
+		/* the function failed, so do not detach */
+		return err_win_to_posix(GetLastError());
 	}
 }
 
-- 
gitgitgadget
