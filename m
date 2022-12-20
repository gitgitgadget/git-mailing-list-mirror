Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED1C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 20:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiLTUEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 15:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLTUEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 15:04:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0A1AA3F
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:04:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay40so9603387wmb.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XEUV2r8xBjkPsc66/G/gZkB7TxWTfR9u6gihRrfej8=;
        b=FGnmaPFijhXi5XX8CORYIlItbNaAmttwDAXVr5R57n7dn0Fd7TZ3dj3mxz94yYSZM6
         ocIw3WBRRXtAWg2Tw9aoIZhshjoY+fO1scFegLjTwwrfWnwu10OfA9YC2bIXpo80LLpp
         qIKAlkzWsiJ9BOgc77HOGoXJqLOHKFb+nC+w5thMvP58W1sVpsuQLIiEPWFcBgzwzEkb
         GcPmuYtp7fWXjhk4FA0XNEFBf/QD//YuZooRPJQ/WFKAgSG+FyLXYfkna4sysUYr14pG
         lJCdf9/ssC/vAIjjjy0dzUgTw6MD06ky9xS/VGcH90MSMFXTnR75mZ3j3++FBd40IxV1
         h6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XEUV2r8xBjkPsc66/G/gZkB7TxWTfR9u6gihRrfej8=;
        b=wqRMT5Z0VrRxjIVadKDUeyyJXWUSbRyvIbu8fjbj108bgy2gI/WRZ7Ov+nsqo27Nyu
         YzMxI0ACuqPv+yWIVhSKe+A1S/bKHl6Gpph7ZHNz4XgQWCfgHRWzEsRE6pNxuGo3IWcV
         qDkxM0LVHyaEHfTfhOTK+YlfsdY3eOaWOwrGpbYccNq41OkAozrSCniJZCCkU/P6/7AE
         RvcsCfho8ef6HJhzq2OTEv3oojAeDYFIv4XD7nIleKt8RuO1ypUDeOeF74GQHrVdVP0b
         0Czw6E3yrrdQ7exvjVxd4JHBw0YCMkCLkfDey/OKrfetrk2VnUARaX2+sKv3OvURopen
         2O/A==
X-Gm-Message-State: AFqh2kpLud9EG7P82GF9AM3L+wo6Za6pi8NDQD1ZxoOYCGZW40E64nG6
        HLlP2jXHXwroqRgzVwNRGtMp3JXyUTM=
X-Google-Smtp-Source: AMrXdXvPljsvWnvXuCunS3EUmsceMS9xXhWnx5H78PbKXCDS28FeF1Fo2rBWRFaAKpsIvkqqSXQoKg==
X-Received: by 2002:a05:600c:a10:b0:3cf:ab98:2245 with SMTP id z16-20020a05600c0a1000b003cfab982245mr2559185wmp.28.1671566642608;
        Tue, 20 Dec 2022 12:04:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b00241fea203b6sm13571705wry.87.2022.12.20.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:04:02 -0800 (PST)
Message-Id: <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v3.git.git.1671562845014.gitgitgadget@gmail.com>
References: <pull.1406.v3.git.git.1671562845014.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 20:03:59 +0000
Subject: [PATCH v4 0/2] win32: close handles of threads that have been joined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After joining threads, the handle to the original thread should be closed as
it no longer needs to be open.

Signed-off-by: Seija Kijin doremylover123@gmail.com

Seija Kijin (2):
  win32: close handles of threads that have been joined
  prep

 compat/win32/pthread.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)


base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v4
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v3:

 -:  ----------- > 1:  526ef7cc339 win32: close handles of threads that have been joined
 1:  2049576b193 ! 2:  2cb4d5c7007 win32: close handles of threads that have been joined
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    win32: close handles of threads that have been joined
     -
     -    After joining threads, the handle to the original thread
     -    should be closed as it no longer needs to be open.
     +    prep
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## compat/win32/pthread.c ##
     +@@ compat/win32/pthread.c: static unsigned __stdcall win32_start_routine(void *arg)
     + }
     + 
     + int pthread_create(pthread_t *thread, const void *unused,
     +-		   void *(*start_routine)(void*), void *arg)
     ++		   void *(*start_routine)(void *), void *arg)
     + {
     + 	thread->arg = arg;
     + 	thread->start_routine = start_routine;
     +-	thread->handle = (HANDLE)
     +-		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
     ++	thread->handle = (HANDLE)_beginthreadex(NULL, 0, win32_start_routine,
     ++						thread, 0, NULL);
     + 
     + 	if (!thread->handle)
     + 		return errno;
      @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_ptr)
       {
       	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
     @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_p
      -		case WAIT_OBJECT_0:
      -			if (value_ptr)
      -				*value_ptr = thread->arg;
     +-			/* detach the thread once the join succeeds */
     +-			CloseHandle(thread->handle);
      -			return 0;
      -		case WAIT_ABANDONED:
     +-			/* either thread is not joinable or another thread is
     +-			 * waiting on this, so do not detatch */
      -			return EINVAL;
      -		default:
     +-			/* the function failed, so do not detach */
      -			return err_win_to_posix(GetLastError());
      +	case WAIT_OBJECT_0:
      +		if (value_ptr)
     @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_p
      +		CloseHandle(thread->handle);
      +		return 0;
      +	case WAIT_ABANDONED:
     -+		/* either thread is not joinable or another thread is waiting on
     -+		 * this, so do not detatch */
     ++		/* either thread is not joinable or another thread is
     ++		 * waiting on this, so do not detatch */
      +		return EINVAL;
     -+	case WAIT_FAILED:
      +	default:
      +		/* the function failed, so do not detach */
      +		return err_win_to_posix(GetLastError());

-- 
gitgitgadget
