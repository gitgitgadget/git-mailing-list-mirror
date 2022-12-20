Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2DC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 21:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiLTVSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 16:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiLTVSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 16:18:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1061E3FB
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 13:18:07 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y8so22991wrl.13
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 13:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k0BYoH7pbtzHeQQc9OhAVKU5yx70Q614wSxp4J52Tc=;
        b=nSUI4Bgay1gFrBA12oH0ftQlE0yfMyWL/u9F6Np1HmbjdnrZBjVtOMypC8BdXJIEIt
         9hp1GMhv2dgKca4bsGi8qFunuWBu2hrCy07VHdkHseB8CcPsudtlfoBA4CY+p/0uQRii
         SBi37opyWVIlbSQAXjREmyQ4moHUagXFIVq+xAl6mozSoaQyp8/HcsR0fSPRw/czrSLH
         y2x21/CrMGMFYHjzudgmBfn6VSoNx6B14kqOjSAxlME4UYIJ0tOoJyGRXFobaRXTCeeF
         Yh175QQlMJ/GnsTP49jSaLvV4gQzdhHEzV/cbVTps4yrpzM3MoukoPOo7iClW1FZ1B1z
         C6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k0BYoH7pbtzHeQQc9OhAVKU5yx70Q614wSxp4J52Tc=;
        b=O2E5nK7lm4z/Tfa49xHlmV0lfbywVJM372JcAQs/Ak7CaZmaLJgCl4eFtr8Y/EnEjT
         xtnsGqSKxVd7knLb8VgZa7HnOORnE9cTALwNyiJ+78fz4U7J0JeskrQnHOuFZ/NzqTDr
         sHHb1YQtIwJ3pFd2KaUJY9wZyHGvm36jvavBVMwGGSpnGV3BlCPhKQooNaor0WFapZ9U
         tIIqhNW+F8AXpGGRZwW5yOqfRwX9xNBM5mN17OdKvWoUEZkYnsfONZaN1crR7r/Nw22e
         LOYeBrG45Ty+MiF06fJaRQsKxn5UhKZzeduuYK0WAcQplcMvMn7vhOg7/Yz9xWB99QDF
         NeJg==
X-Gm-Message-State: ANoB5pmmxLfJL9pIS2brTle0iv2XSN3DwajS9f/bztb0UI1hi8q685iD
        tON5m3riFxl7RxwOr/xkISPPbjiyr9A=
X-Google-Smtp-Source: AA0mqf7LKMm3zohwRH1QDub9kNfazMJaHXKY34YlkViG8RRU19ehrpaHsF8pvsDCt7zvIjk6FLkpTQ==
X-Received: by 2002:adf:f0d1:0:b0:24e:f72a:4285 with SMTP id x17-20020adff0d1000000b0024ef72a4285mr20839980wro.24.1671571086135;
        Tue, 20 Dec 2022 13:18:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17-20020adfd851000000b0024194bba380sm13851306wrl.22.2022.12.20.13.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:18:05 -0800 (PST)
Message-Id: <pull.1406.v5.git.git.1671571084753.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
References: <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 21:18:04 +0000
Subject: [PATCH v5] win32: close handles of threads that have been joined
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

After joining threads, the handle to the original thread
should be closed as it no longer needs to be open.

Because this only needs to happen if the
WaitForSingleObject fails, the function was
rewritten to accommodate this change.

The function is still POSIX compliant.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: close handles of threads that have been joined
    
    After joining threads, the handle to the original thread should be
    closed as it no longer needs to be open.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v5
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v4:

 1:  526ef7cc339 < -:  ----------- win32: close handles of threads that have been joined
 2:  2cb4d5c7007 ! 1:  94ed068d25b prep
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    prep
     +    win32: close handles of threads that have been joined
     +
     +    After joining threads, the handle to the original thread
     +    should be closed as it no longer needs to be open.
     +
     +    Because this only needs to happen if the
     +    WaitForSingleObject fails, the function was
     +    rewritten to accommodate this change.
     +
     +    The function is still POSIX compliant.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## compat/win32/pthread.c ##
     -@@ compat/win32/pthread.c: static unsigned __stdcall win32_start_routine(void *arg)
     - }
     - 
     - int pthread_create(pthread_t *thread, const void *unused,
     --		   void *(*start_routine)(void*), void *arg)
     -+		   void *(*start_routine)(void *), void *arg)
     - {
     - 	thread->arg = arg;
     - 	thread->start_routine = start_routine;
     --	thread->handle = (HANDLE)
     --		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
     -+	thread->handle = (HANDLE)_beginthreadex(NULL, 0, win32_start_routine,
     -+						thread, 0, NULL);
     +@@ compat/win32/pthread.c: int pthread_create(pthread_t *thread, const void *unused,
       
     - 	if (!thread->handle)
     - 		return errno;
     -@@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_ptr)
     + int win32_pthread_join(pthread_t *thread, void **value_ptr)
       {
     - 	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
     - 	switch (result) {
     +-	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
     +-	switch (result) {
      -		case WAIT_OBJECT_0:
      -			if (value_ptr)
      -				*value_ptr = thread->arg;
     --			/* detach the thread once the join succeeds */
     --			CloseHandle(thread->handle);
      -			return 0;
      -		case WAIT_ABANDONED:
     --			/* either thread is not joinable or another thread is
     --			 * waiting on this, so do not detatch */
      -			return EINVAL;
      -		default:
     --			/* the function failed, so do not detach */
      -			return err_win_to_posix(GetLastError());
     -+	case WAIT_OBJECT_0:
     -+		if (value_ptr)
     -+			*value_ptr = thread->arg;
     -+		/* detach the thread once the join succeeds */
     -+		CloseHandle(thread->handle);
     -+		return 0;
     -+	case WAIT_ABANDONED:
     -+		/* either thread is not joinable or another thread is
     -+		 * waiting on this, so do not detatch */
     -+		return EINVAL;
     -+	default:
     -+		/* the function failed, so do not detach */
     ++	if (WaitForSingleObject(thread->handle, INFINITE) == WAIT_FAILED)
      +		return err_win_to_posix(GetLastError());
     ++
     ++	if (value_ptr) {
     ++		*value_ptr = thread->arg;
       	}
     ++
     ++	CloseHandle(thread->handle);
     ++	return 0;
       }
       
     + pthread_t pthread_self(void)


 compat/win32/pthread.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..7f8503b4b50 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -37,17 +37,15 @@ int pthread_create(pthread_t *thread, const void *unused,
 
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
+	if (WaitForSingleObject(thread->handle, INFINITE) == WAIT_FAILED)
+		return err_win_to_posix(GetLastError());
+
+	if (value_ptr) {
+		*value_ptr = thread->arg;
 	}
+
+	CloseHandle(thread->handle);
+	return 0;
 }
 
 pthread_t pthread_self(void)

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
