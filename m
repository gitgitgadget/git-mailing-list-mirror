Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E45C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiLUEfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUEfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:35:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E881B7B0
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:35:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so10347255wmb.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeMRu3MJPLWwp9T88nXe1Yvd7l+IZ+d12HxCnWQyn68=;
        b=gMAmmcsDL5COKNu/MtCnYGennMyC3TZj5jBlkVlCq3uOLz5zW/Ti6Po3SwkiJ3DXpj
         Kc6Qtr1M0NO/5bXU90LEFWohVVE+A+UXoAUP4FH/TyQ7U8B/61nu7bBvrgYhjdnSSUPC
         Rz45oR0MqNn1/bGBFUwmiPY2UIh9GJikk/xs5ZeLcxUlWk1+gnYFlUcBSN7kXPj3WPvC
         4lxDiefZdlEVMIc7n5OzKZmI9Fggi/w2lNPlytrslDO4kr376zjlwlTrQ8H67xfKN8ks
         0JcoIBoKXGPFHpEAHZ4W58sz+XCDXHWaPO58mLBsLSpm/Bg9pPbBVrzK6dcL4gdoPNsh
         4QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeMRu3MJPLWwp9T88nXe1Yvd7l+IZ+d12HxCnWQyn68=;
        b=HQKsOJY+KPmcv7x8XxRGwBi9nfrAR8iW8TA2oc1PkOQ6njejvjHAp8d84XrsbV7G60
         cCvCe2U5/23szHru2T85VfL/ah2ZN6BrAWN/INFOogaqA8Qu1jmO3uqC5zRK1qOhetKS
         dIesUg1EumJPQpgnV7q2kFcjZeh0gLW15A6P2DZu5qSHeip1WYMeptTBVtkYVzGnjwTP
         WF4RB8ot2Wvc52gTKvaSciWFuIEWIWNUnRGq3cjVeaDaqq0UrQCxgDqk6LgwcTeTQtL2
         x2U5FIsMTfTK6o4aHZecE/3QC34azuGfD+kUUupLAouxrohvVijugO3/KnHHlrJwqowj
         +r5w==
X-Gm-Message-State: AFqh2kpV4cn7C0MvvXrI4yfmb7tQFaoPsWXS96Jx5suKAMYglYE3+Z/z
        DeLQfd11HnlO0Ai8Xt3V8gyqIuQOp3w=
X-Google-Smtp-Source: AMrXdXv2zEzOD6cZ8UhoIwGrdXLigRWvhUZwHcPzbMWPTQQuOaj7ejoqdz35nTx5YKCW+lVmmLwioQ==
X-Received: by 2002:a05:600c:5108:b0:3d1:ce35:4224 with SMTP id o8-20020a05600c510800b003d1ce354224mr486637wms.11.1671597318705;
        Tue, 20 Dec 2022 20:35:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c6c182bef9sm889187wmb.36.2022.12.20.20.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:35:18 -0800 (PST)
Message-Id: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v5.git.git.1671571084753.gitgitgadget@gmail.com>
References: <pull.1406.v5.git.git.1671571084753.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 04:35:15 +0000
Subject: [PATCH v6 0/2] win32: close handles of threads that have been joined
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

 compat/win32/pthread.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)


base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v6
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v5:

 1:  94ed068d25b ! 1:  0b5afdb93db win32: close handles of threads that have been joined
     @@ Commit message
          After joining threads, the handle to the original thread
          should be closed as it no longer needs to be open.
      
     -    Because this only needs to happen if the
     -    WaitForSingleObject fails, the function was
     -    rewritten to accommodate this change.
     -
     -    The function is still POSIX compliant.
     +    This change makes the function POSIX compliant.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     @@ compat/win32/pthread.c: int pthread_create(pthread_t *thread, const void *unused
      -			return EINVAL;
      -		default:
      -			return err_win_to_posix(GetLastError());
     -+	if (WaitForSingleObject(thread->handle, INFINITE) == WAIT_FAILED)
     ++	switch (WaitForSingleObject(thread->handle, INFINITE)) {
     ++	case WAIT_OBJECT_0:
     ++		if (value_ptr)
     ++			*value_ptr = thread->arg;
     ++		CloseHandle(thread->handle);
     ++		return 0;
     ++	case WAIT_ABANDONED:
     ++		CloseHandle(thread->handle);
     ++		return EINVAL;
     ++	default:
     ++		/* the function failed, so do not detach */
      +		return err_win_to_posix(GetLastError());
     -+
     -+	if (value_ptr) {
     -+		*value_ptr = thread->arg;
       	}
     -+
     -+	CloseHandle(thread->handle);
     -+	return 0;
       }
       
     - pthread_t pthread_self(void)
 -:  ----------- > 2:  5b35362e5d2 prep

-- 
gitgitgadget
