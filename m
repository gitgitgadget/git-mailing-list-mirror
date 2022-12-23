Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E917C4167B
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiLWTQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLWTP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:15:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B66464
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:15:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h16so5305618wrz.12
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shBPUDOQ3lw6isJnbF5F+tb0pWMgvA0tEd9SBGv0OuA=;
        b=g4psPpulPqd5QMz69myPS2SvNN7BPP4sA0Z8tSQUyCeXjBtIryP/ED1WyXRjyYjM9a
         5CzKmfF9DLRBnYY64Efgk87gnxt2lXRo5SbEin6+BXeeDj4esVWA8I3bHYJh4Oa1c3wq
         8wzj4b6o3auOYqMEw2KC4sLvFfZ4y72LMcQ8L2NDFp+flBUE4nSbUPGSCGLAtwe/jvKk
         UXZUrJG3gL8thlfLWzG4FnpMXTWD/kq6gSRkx4Gh6+dkaXTQ1v7Fa5e7qUq8mqLRsnsT
         KszbnX5qjr6z91OVkYABZeY9spNogSxIlIKK7nzxJnFqNs9Gvs+Q92UWlRvyYUVI0QOo
         XO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shBPUDOQ3lw6isJnbF5F+tb0pWMgvA0tEd9SBGv0OuA=;
        b=MLqLmHUuG6vOoI3qm9Sm+HCvD+cx/rZPCQEAxb0lzd7k8vKFK6d8kYDblY4+IEzhCF
         8mAet8v0mLraagDVLHuGW9zJdGIj1fXQOTE9Pg3DOpgNi8v84ESm4FMYBzigfNImMhSL
         jcfhTLBfZFEsL5HILJzsZaSKDpFTA0jfSluDzSFJWLOLxeqlPq2UBl0dWQgXBlhVcBBN
         EYRfSkhi5KQEK95bXTmWrspMZLnqrWdmLITN6XpAXbJXHYXEQnMDmdMA2HfJDl/S89qw
         0q++FN+GNYEgac0PZZ49ljdBbzULYHel60uEUPt7WiY014hhliqzPrVGE619NA+G+YeM
         KXbQ==
X-Gm-Message-State: AFqh2kpzdIjByNUbyPhSmNImEefjiTVdwmbRkuLanc68CG67lV5tmHbd
        yA7mbekqGAZbq5swOrcRc11IT/kQo9c=
X-Google-Smtp-Source: AMrXdXsBseUECW8UI1dDgGUHJnfE3p6KN4Jgv2ejv8n0e4jfMo2yI9sp8kZEzeaBjITuRKWLAyARFA==
X-Received: by 2002:adf:e78b:0:b0:241:fe2e:8007 with SMTP id n11-20020adfe78b000000b00241fe2e8007mr6806356wrm.3.1671822956607;
        Fri, 23 Dec 2022 11:15:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4cd1000000b002425c6d30c6sm4243366wrt.117.2022.12.23.11.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:15:56 -0800 (PST)
Message-Id: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
References: <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:15:53 +0000
Subject: [PATCH v10 0/2] win32: close handles of threads that have been joined
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
  win32-pthread: prepare pthread.c for change by formatting
  win32: close handles of threads that have been joined

 compat/win32/pthread.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)


base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v10
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v9:

 2:  4c82a16a995 ! 1:  e0cc43efc6c prep: reformat pthread.c to fit coding guidelines
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    prep: reformat pthread.c to fit coding guidelines
     +    win32-pthread: prepare pthread.c for change by formatting
      
     -    The motivation for this change is that
     -    the post-image better fits the coding
     -    guidelines, especially since this file
     -    was changed.
     +    File has been formatted to meet coding guidelines
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     @@ compat/win32/pthread.c: int pthread_create(pthread_t *thread, const void *unused
      -		case WAIT_OBJECT_0:
      -			if (value_ptr)
      -				*value_ptr = thread->arg;
     --			CloseHandle(thread->handle);
      -			return 0;
      -		case WAIT_ABANDONED:
     --			CloseHandle(thread->handle);
      -			return EINVAL;
      -		default:
     --			/* the wait failed, so do not detach */
      -			return err_win_to_posix(GetLastError());
      +	switch (WaitForSingleObject(thread->handle, INFINITE)) {
      +	case WAIT_OBJECT_0:
      +		if (value_ptr)
      +			*value_ptr = thread->arg;
     -+		CloseHandle(thread->handle);
      +		return 0;
      +	case WAIT_ABANDONED:
     -+		CloseHandle(thread->handle);
      +		return EINVAL;
      +	default:
     -+		/* the wait failed, so do not detach */
      +		return err_win_to_posix(GetLastError());
       	}
       }
 1:  d9b1df22e03 ! 2:  d05d4c2e4b2 win32: close handles of threads that have been joined
     @@ Commit message
      
       ## compat/win32/pthread.c ##
      @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_ptr)
     - 		case WAIT_OBJECT_0:
     - 			if (value_ptr)
     - 				*value_ptr = thread->arg;
     -+			CloseHandle(thread->handle);
     - 			return 0;
     - 		case WAIT_ABANDONED:
     -+			CloseHandle(thread->handle);
     - 			return EINVAL;
     - 		default:
     -+			/* the wait failed, so do not detach */
     - 			return err_win_to_posix(GetLastError());
     + 	case WAIT_OBJECT_0:
     + 		if (value_ptr)
     + 			*value_ptr = thread->arg;
     ++		CloseHandle(thread->handle);
     + 		return 0;
     + 	case WAIT_ABANDONED:
     ++		CloseHandle(thread->handle);
     + 		return EINVAL;
     + 	default:
     ++		/* the wait failed, so do not detach */
     + 		return err_win_to_posix(GetLastError());
       	}
       }

-- 
gitgitgadget
