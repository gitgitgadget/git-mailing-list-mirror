Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F3C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 17:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLVRRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVRRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 12:17:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A062140D0
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:17:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1779965wmp.3
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+rGBeCn8FMkViXo5BEGNnVCrcRtB/buv9HddmhS/6I=;
        b=C0cldroB4fCl90XSVaWt8IOZs1Q9Jh1ZXaPQDEd/cw1TkI9KZaA4sImO93YK2aVcys
         PEsqbhvMdT6QV3EJOSnpD03nurS0MRZhbRgvZk9YU+aRbJQwA2VgcTwQopn5/jeVwiPV
         fRpyZlaJHZjnw1gjla/lqOoroeG6Tt4c5eTTo7gvhilhKOQj5kGPy60sgb7ct+Yjyu5b
         RVwcCvGcY8v4prtIKz0i7rcLDKZmcmkFvBsFPurFLMhjB99jah1qkZp0Z6hxmkxxHyX9
         NKq7ptwX4CYDzodfuj/5k2wNa4un8FC8jz/bkb4H5HrLr28oBfYiRdpqaQAFXXFq0EF4
         9DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+rGBeCn8FMkViXo5BEGNnVCrcRtB/buv9HddmhS/6I=;
        b=plY2jFWczbcQJqxRyW1rEEEAkvWLnkYzcUFPsnlkAyCxJP2YE9bTAcEigL+I/bc/z+
         PSJwsyGvd8/YOmFOWnP5+QYDkybOfCopkV/h115CAUaLUr0dpn5b50MJF/sFXH8EyBnd
         k+fBCuaF+rzeRx7uTkHTXUfrtVphc9nhWp2pX3iyq2T6ZlA9kCIaxUh7AQLjluLUONWz
         PLBX5wMbs8BOUHdl3ltoRlONEXieKngwWRq8EwWPf764pVYXw/zi3cJx+a+QiPmAfvwD
         QVd6wbami3Kge2VzpzXaRuCXLgHoXjJrfp0+Xn9O7EGTHp/bbWaARLvX+bOI0nEUhDvz
         9hYg==
X-Gm-Message-State: AFqh2kqS18xUrX+x4bOn+boCWdpH9EFGEMuNMVi/NKgvtQmzsx+u3Ufe
        7hetMe4Q3MvC9eNMF2j9X7JuKqiK2kg=
X-Google-Smtp-Source: AMrXdXuOV58Gk+FALJrM0VGGj+6lJTpZwkZI6pQFWIJQlY+AnUxwSWPYuIglVZkhuC1ZMVbsM4gKgQ==
X-Received: by 2002:a05:600c:3d05:b0:3d3:5c21:dd94 with SMTP id bh5-20020a05600c3d0500b003d35c21dd94mr4847470wmb.9.1671729454555;
        Thu, 22 Dec 2022 09:17:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c501000b003b47ff307e1sm1640901wmr.31.2022.12.22.09.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 09:17:34 -0800 (PST)
Message-Id: <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v8.git.git.1671724911188.gitgitgadget@gmail.com>
References: <pull.1406.v8.git.git.1671724911188.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 17:17:31 +0000
Subject: [PATCH v9 0/2] win32: close handles of threads that have been joined
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
  prep: reformat pthread.c to fit coding guidelines

 compat/win32/pthread.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)


base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v9
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v8:

 1:  70588032eb3 ! 1:  d9b1df22e03 win32: close handles of threads that have been joined
     @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_p
      +			CloseHandle(thread->handle);
       			return EINVAL;
       		default:
     -+			/* the function failed, so do not detach */
     ++			/* the wait failed, so do not detach */
       			return err_win_to_posix(GetLastError());
       	}
       }
 -:  ----------- > 2:  4c82a16a995 prep: reformat pthread.c to fit coding guidelines

-- 
gitgitgadget
