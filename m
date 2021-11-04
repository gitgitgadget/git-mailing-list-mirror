Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F0C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 04:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0CE61157
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 04:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhKDEDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 00:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhKDEDn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 00:03:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4DC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 21:01:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b12so6571108wrh.4
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 21:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6obSlLoYsBdF4U0DMAOP7PkZOEWp7zdfKt/5zKW/UBw=;
        b=bSujmx3uVILoFSOeuukDerfldqMcUdyGFaqv4KrumFXn78GG/pxWYDIcWWTPvabiVY
         ZHN7ga4bWg72Jn/82dUzwRaRsxZ8ITjln6fmnBNOsbU/Mn32P0MdMUN9kiccDVNeJaDY
         Nj56IwvD1tJ4pUCNCvYCq5sr+yxNoj/vKx4eFTqMgJu7oqeV+5uzjLFFIjOgOyaahnlm
         SklDXmc8WBz2Apkuwn4WnfYEYqH585s7T5RL9j+edLaOXg2SVJCCEv5Ec25rzh4LyxWz
         gMv65QUFJ+QMLY4URnos+p8ywtllORSp08TW5p5JlMO31HgE+T7xTGCrNjdEpuAEa7gK
         FzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6obSlLoYsBdF4U0DMAOP7PkZOEWp7zdfKt/5zKW/UBw=;
        b=MD67kkqL/KAGl88U6DeHofuO/MpLiPY5HLANbYhXiyfywjxIXlbtgFuZuYxb/56qFr
         EL+BtFIyJc8A40+AWd1WJsPrcMcYvDrhgx2JJpvot8TX0PaCI53J3vB5tjFY9D/i3r+s
         gHlKS7jLg6tcc8+KJJJFt84rcyRdU8TDuMEhz2+HcyYxEXRGBwzQzrhUQ2Oo7XnlMI+R
         6rlaaiIAcQ3Eu/cXdRotwbh7ZLF1sf2CmrblNKZUfyn1xRVlyz9a8dOCTRZKLIBw6tn3
         a9B/GSoPxC1jpfRBT5DTUlzIgAAoAF9+riVwNnE6sA2mhU4JcX/n8IsMrU1IVprUH9jv
         +ZFw==
X-Gm-Message-State: AOAM5310mlxsE2oX3CGBDFefvm0xp+qiB2/jeiMXcwidLxHG04xVw6Ec
        +s0xpZ9wuAL4EflhXLJXb2u2oJQ/gRE=
X-Google-Smtp-Source: ABdhPJwgY6wwxpoWHkTlUCu+fqApctWbfZ07YzOuaIW9CiNUvTWrHf1HybCCnaK6gn2XEmmGc4RCeQ==
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr27153116wri.195.1635998464561;
        Wed, 03 Nov 2021 21:01:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm3591921wrv.78.2021.11.03.21.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 21:01:04 -0700 (PDT)
Message-Id: <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
In-Reply-To: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Nov 2021 04:01:03 +0000
Subject: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue on
 Fedora
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, philipoakley@iee.email, eschwartz@archlinux.org,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

This fix corrects an issue found in the `dockerized(pedantic, fedora)` CI
build, first appearing after the introduction of a new version of the Fedora
docker image version. This image includes a version of `glibc` with the
attribute `__attr_access_none` added to `pthread_setspecific` [1], the
implementation of which only exists for GCC 11.X - the version included in
the Fedora image. The attribute requires that the pointer provided in the
second argument of `pthread_getspecific` must, if not NULL, be a pointer to
a valid object. In the usage in `async_die_is_recursing`, `(void *)1` is not
valid, causing the error.

This fix imitates a workaround added in SELinux [2] by using the pointer to
the static `async_die_counter` itself as the second argument to
`pthread_setspecific`. This guaranteed non-NULL, valid pointer matches the
intent of the current usage while not triggering the build error.

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a1561c3bbe8
[2] https://lore.kernel.org/all/20211021140519.6593-1-cgzones@googlemail.com/

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    async_die_is_recursing: fix use of pthread_getspecific for Fedora
    
    Following up on Johannes' report earlier [1], this patch fixes a
    compiler error in the Fedora CI build (the same issue was identified in
    a local developer build about a week ago [2]). This fix changes the
    second argument in the call to pthread_setspecific from '(void *)1' to a
    valid pointer, thus preventing the error in the use of
    __attr_access_none.
    
    
    Changes since V1
    ================
    
     * Change &ret to &async_die_counter ("dummy" argument to
       pthread_setspecific) so that it's using a global (rather than local)
       variable
     * Fix typo in commit message (pthread_getspecific ->
       pthread_setspecific)
    
    [1]
    https://lore.kernel.org/git/nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqbjf.bet/
    [2]
    https://lore.kernel.org/git/43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1072%2Fvdye%2Ffix-fedora-build-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1072/vdye/fix-fedora-build-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1072

Range-diff vs v1:

 1:  efe0b398f54 ! 1:  7f10e09269a async_die_is_recursing: fix use of pthread_getspecific for Fedora
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    async_die_is_recursing: fix use of pthread_getspecific for Fedora
     +    async_die_is_recursing: work around GCC v11.x issue on Fedora
      
     -    Correct an issue encountered in the `dockerized(pedantic, fedora)` CI build,
     -    first appearing after the release of v36 as the latest stable version of the
     -    Fedora docker image. This image includes a version of `glibc` with the
     -    attribute `__attr_access_none` added to `pthread_getspecific` [1], the
     +    This fix corrects an issue found in the `dockerized(pedantic, fedora)` CI
     +    build, first appearing after the introduction of a new version of the Fedora
     +    docker image version. This image includes a version of `glibc` with the
     +    attribute `__attr_access_none` added to `pthread_setspecific` [1], the
          implementation of which only exists for GCC 11.X - the version included in
     -    Fedora. The attribute requires that the pointer provided in the second
     -    argument of `pthread_getspecific` must, if not NULL, be a pointer to a valid
     -    object. In the usage in `async_die_is_recursing`, `(void *)1` is not valid,
     -    resulting in the error.
     +    the Fedora image. The attribute requires that the pointer provided in the
     +    second argument of `pthread_getspecific` must, if not NULL, be a pointer to
     +    a valid object. In the usage in `async_die_is_recursing`, `(void *)1` is not
     +    valid, causing the error.
      
     -    The fix imitates a workaround added in SELinux [2] by using the pointer to
     -    `ret` as the second argument to `pthread_getspecific`. This guaranteed
     -    non-NULL, valid pointer adheres to the current intended usage of
     -    `pthread_getspecific` while not triggering the build error.
     +    This fix imitates a workaround added in SELinux [2] by using the pointer to
     +    the static `async_die_counter` itself as the second argument to
     +    `pthread_setspecific`. This guaranteed non-NULL, valid pointer matches the
     +    intent of the current usage while not triggering the build error.
      
          [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a1561c3bbe8
          [2] https://lore.kernel.org/all/20211021140519.6593-1-cgzones@googlemail.com/
     @@ run-command.c: static NORETURN void die_async(const char *err, va_list params)
       {
       	void *ret = pthread_getspecific(async_die_counter);
      -	pthread_setspecific(async_die_counter, (void *)1);
     -+	pthread_setspecific(async_die_counter, &ret); /* set to any non-NULL valid pointer */
     ++	pthread_setspecific(async_die_counter, &async_die_counter); /* set to any non-NULL valid pointer */
       	return ret != NULL;
       }
       


 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 7ef5cc712a9..f40df01c772 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1099,7 +1099,7 @@ static NORETURN void die_async(const char *err, va_list params)
 static int async_die_is_recursing(void)
 {
 	void *ret = pthread_getspecific(async_die_counter);
-	pthread_setspecific(async_die_counter, (void *)1);
+	pthread_setspecific(async_die_counter, &async_die_counter); /* set to any non-NULL valid pointer */
 	return ret != NULL;
 }
 

base-commit: 876b1423317071f43c99666f3fc3db3642dfbe14
-- 
gitgitgadget
