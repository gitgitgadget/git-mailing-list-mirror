Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2119BC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 18:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiLTS6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 13:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiLTS6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 13:58:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C154B1B796
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 10:57:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ja17so9444880wmb.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 10:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15QKqpyA5V2KyrOOYj0vo+TollFcW+tHB+e4yfA3oxU=;
        b=E9NJINqKdGwsAr9GWwV4+jS13Bw6a8KrOAWKvgX6oMbTsVtSDB2tMViF/7r6Qeb/PE
         2+1OcPUxPaFTytMQqkM57u2+zSmBTlgJvcTXF8VTQYP5aD7yRMGb01WvlYlcx6YQS+OG
         9M4iaZFs2EfBkz8MlDB5/fSHxU0Lkfls+0X5dRDxPDyjp5CQCPAEn1KlLjiwWJ6pS4tU
         ZXeGMgqqlBhUDViSBqek9CjKJO+hLBtmMXnj2IRZh5NCT3Bh61IBbuwUm5BJcosIJ69m
         pUaxbEHZLVdv56OwJvIJ4WTC28sCrRJ88+UHOeJJyP7SmZwPC8u2PPs8x9ttfqt2FifQ
         S9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15QKqpyA5V2KyrOOYj0vo+TollFcW+tHB+e4yfA3oxU=;
        b=K9zMceRmamP57fJg5ntysoFKe2Aa2qNurSTkuAF5oHd2XqLzYmTmHlJqgnijj/qdlL
         TMbnjuUUm6sad8rw08t1JYfAmovkU/gzbi2yd+InKv0vMhsUOhdxhqXlRIn4Mo0AtUtP
         2wO2aKJnXh8B4b37ImVV35Jc1BggN5nSa7rjHZqEoXm3jWjNQ+HBwhdy/hj1Ucug4ILx
         uSLo4XzNgHg2T1p6hpv3fJZY2mZ+26+nxcmFuKx/TmIcQr//4ugrXy6vaXZ3q4VfVbFN
         AvgGT1Rwj5ZySkkyJfhjUVsSLXbS/t4C7NsD3sYjuW7bkc8KJ3g4MMwv0x4Bv7CUim7r
         BCPg==
X-Gm-Message-State: ANoB5pkkfJ71F8O1FRJhDFeJEny/QC8LMpnV2uSOYx3fLKaZ0krcvd56
        d0MG0pEpqC7SnEiPHR0XmRgRoAisHio=
X-Google-Smtp-Source: AA0mqf7J33DkmG8pFy1Rrs6JZ1o1yM7+hIpK+Bb7r3bFepkjoZWQb94zb121DCNwSf3XuP7KfEzBvg==
X-Received: by 2002:a05:600c:4e47:b0:3d0:d177:cadf with SMTP id e7-20020a05600c4e4700b003d0d177cadfmr38466621wmq.32.1671562665006;
        Tue, 20 Dec 2022 10:57:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020a05600c46d000b003d34f170487sm16091260wmo.0.2022.12.20.10.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:57:44 -0800 (PST)
Message-Id: <pull.1406.v2.git.git.1671562663899.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.git.git.1671474876207.gitgitgadget@gmail.com>
References: <pull.1406.git.git.1671474876207.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 18:57:43 +0000
Subject: [PATCH v2] win32: close handles of threads that have been joined
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

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: close handles of threads that have been joined
    
    After joining threads, the handle to the original thread should be
    closed as it no longer needs to be open.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v2
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v1:

 1:  e53b274ab4b ! 1:  8b20c4149be win32: close handles of threads that have been joined
     @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_p
      +		return 0;
      +	case WAIT_ABANDONED:
      +		/* either thread is not joinable or another thread is waiting on
     -+		 * this, so we do not detatch */
     ++		 * this, so do not detatch */
      +		return EINVAL;
     -+	default:
      +	case WAIT_FAILED:
     ++	default:
      +		/* the function failed so we do not detach */
      +		return err_win_to_posix(GetLastError());
       	}


 compat/win32/pthread.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..0d62c45ecc2 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -39,14 +39,20 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
 	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
 	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			return 0;
-		case WAIT_ABANDONED:
-			return EINVAL;
-		default:
-			return err_win_to_posix(GetLastError());
+	case WAIT_OBJECT_0:
+		if (value_ptr)
+			*value_ptr = thread->arg;
+		/* detach the thread once the join succeeds */
+		CloseHandle(thread->handle);
+		return 0;
+	case WAIT_ABANDONED:
+		/* either thread is not joinable or another thread is waiting on
+		 * this, so do not detatch */
+		return EINVAL;
+	case WAIT_FAILED:
+	default:
+		/* the function failed so we do not detach */
+		return err_win_to_posix(GetLastError());
 	}
 }
 

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
