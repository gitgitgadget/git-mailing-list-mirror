Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63843EB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 21:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjG0VZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjG0VZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 17:25:19 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E6ED9
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 14:24:56 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8a7735231so9269085ad.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690493090; x=1691097890;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dvBp3ryP8su3XR9rBSiMGW6FdwwglPK+dwSyw9ASvE=;
        b=lujWz0o1TMG6trKnpE/BKYMnVGHHfs9odJacSALLr1vMoxSU1n0bf5Bqupjl4sl7eJ
         p+C89zFetuVdduw7PLHRqVLRNf+x0GcQYRpZfDd9NccU6SpoD8S8RN/Zt0v7Wbg/VFma
         +dR09zK2QVHwKVEnDIG8VVzABnwgxvKXfkmh8un1f0ix7lxT846PHuiYsHewalXiEnxr
         xTwwA4kIAmTrPejin6XsGOyGof6yV1iEyTRwPWVzxdwmadK6XvrSCwjgWHOkrx/bQ8yR
         UReqMhBputbQ6/KY9Z/ZrNORHUg2D+TVkWFBJ30uv4wY1BkxY3FXMVtrazTDwGLnHgy7
         xepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493090; x=1691097890;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dvBp3ryP8su3XR9rBSiMGW6FdwwglPK+dwSyw9ASvE=;
        b=F6JcpqZhDJKd9wwcSLKhk8TVO/3p0vpwwpJ3dxRmiRpVxtTkptPzkHEl3dE71ClVUD
         qMVC5vNUrhrQMsGHYOdwouzKAclFCsqKmGcHeHnxLIMKqKc5iUUh0BDoEDCANyk8eSDw
         oZ3f/MCgkatbgjn906ZO1XlloUQRTH+LTfQS+nZdFWsfBVwTMn0KpmVv9VwB4gAkMl4c
         vYgyRaYIKPvzRrpk8bAVkTAJOLxwozE5gJjfVFjmKA1LJndQJ3WdrWuDMMO5zCn67msk
         V6x/fk6+XarkcGw/uuzWflJ63gaewhpP9EhJ5sduJ0W1enulnLCCb0B2K+aLvIIFwKeT
         Msaw==
X-Gm-Message-State: ABy/qLbNO7jwF2+n09czIYkDZqbaTwA72xZ6iA54TYAxQ1iMILMCxZ6o
        u4WstdF1eDe1LhBdhnJ4m3ATVFrwCm8=
X-Google-Smtp-Source: APBJJlEyIxmIgay1x0MAfJ6O23T0+uyo8uzH0xVBif/Zt6Vr3GhI3ZjBwmbtDsQMGO4g9MpHoY1MMIYWS8M=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:41c8:b0:1b8:a92f:2618 with SMTP id
 u8-20020a17090341c800b001b8a92f2618mr2055ple.10.1690493090356; Thu, 27 Jul
 2023 14:24:50 -0700 (PDT)
Date:   Thu, 27 Jul 2023 14:24:48 -0700
In-Reply-To: <xmqqedkvk8u4.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqedkvk8u4.fsf@gitster.g>
Message-ID: <owlyedktf3of.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> 
> --------------------------------------------------
> [Cooking]
>
> ...
> 
> * jc/doc-sent-patch-now-what (2023-07-19) 1 commit
>  - MyFirstContribution: refrain from self-iterating too much
>
>  Process document update.
>
>  Will merge to 'next'?
>  source: <xmqqzga9opdu.fsf@gitster.g>

Please wait until seeing my review (will send later today).
