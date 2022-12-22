Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E9EC4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 19:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiLVT1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 14:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiLVT06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 14:26:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFE1CFFD
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 11:26:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so7124921ejc.12
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8aCcPtdO16WWUAjnnKhaX6Sa6jL/pcfNqzCsXPUKjc=;
        b=SwG65JmJAV8tDoJPCBSRPOiY4acenmtM1Moq6HXw34D3OZVsAsCoX2liX2D0j1NLlh
         SW7R5/DCyX7Jpj+xBQut5gxwFPvcPgULMYEL0hZj0KD4MLT+rAXjXMkvdvztUdfws2Mm
         e9tFTNdzN0tVXfHrJce8KZarAZoSzDlbmBJ89EMXEuK2ZGLyd2zMTG96sGkUCBecJXvv
         tpYc3Yw7Edaf6jnwveiuGEIQ+iPLWaod3ZXXMlB/IpAzGbLXQ7ElkW8mFcw3rEXCVH47
         dH35gxSpea0wnAfvjf63zoSAxZVM6pptu76KVi+0iEcIGvfNJWWFqaCA47Y0E68CU+XJ
         FPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8aCcPtdO16WWUAjnnKhaX6Sa6jL/pcfNqzCsXPUKjc=;
        b=YbP7/p7QKwVr4BtgUS+uHcdjMtEVwi4Zy9xm0f9Rn73PjZsdgyOk2ExUA5ObFL+mCX
         0GSANhLvrD9OsJmIPCaoJQVVR3wxXYxydVMtF/9a00pCqqfKUu2D8sXdoPhEdpDS12FM
         Ph0tubpW76eOuvlC300hEZYMhSdMVBGxGGG5bIpxuhEWzggK1xfNdcbTNtC4gxrs+kGb
         5XaKvUEyTKbs79dtp29qAM0oguCqDabT93Ogmz4+PDlCAvJzm9Q3SRngYLTkWWtlc89Z
         XCWa+IqySIcgvK3kqT6jaqUv9Hgog2MkeFVeFknuvQsOhKHwUe+2pYuWva/HTLaFiRzz
         4Rjg==
X-Gm-Message-State: AFqh2kp/Lj1hX851c/osMQSg6M9sLD8k39gfGtCLehAFtfqyHVRlAQld
        5LLx+f1waapKmjuR72PMmu0=
X-Google-Smtp-Source: AMrXdXswP2fE0hzztXsbplQ93Ir4BykHO0NWUiZqsvd8+TkP+MzDGoMRuqJo4Vd8X/5Usqc2SLhVfw==
X-Received: by 2002:a17:907:c386:b0:81e:8988:71ac with SMTP id tm6-20020a170907c38600b0081e898871acmr6129242ejc.24.1671737208818;
        Thu, 22 Dec 2022 11:26:48 -0800 (PST)
Received: from localhost (94-21-37-252.pool.digikabel.hu. [94.21.37.252])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906045600b0073022b796a7sm559494eja.93.2022.12.22.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:26:48 -0800 (PST)
Date:   Thu, 22 Dec 2022 20:26:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: GitHub actions are failing
Message-ID: <20221222192646.GF3411@szeder.dev>
References: <CA+PPyiHtPsRwqMmr6annuuqzeUEf+7pFUSbnXdThjNNVtxFCGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+PPyiHtPsRwqMmr6annuuqzeUEf+7pFUSbnXdThjNNVtxFCGw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2022 at 08:55:43PM +0300, NSENGIYUMVA WILBERFORCE wrote:
> Hi
> So I have been working in the signature atom patches. I have been
> testing my commits on my fork. However, the actions are failing.
> One of the errors is
> 
> -------------
> E: Package 'gcc-8' has no installation candidate
> + end_group
> + test -n ''
> + return 0
> Error: Process completed with exit code 100.
> -------------
> 
> I would like to have any help, my branch is
> https://github.com/nsengiyumva-wilberforce/git/commits/signature5

This should be fixed in 0178420b9c (github-actions: run gcc-8 on
ubuntu-20.04 image, 2022-11-25), which is in v2.39.0-rc1, but your
branch is based on v2.39.0-rc0.  I would suggest to rebase your branch
on top of v2.39.0, because it contains a few other CI fixes that are
not yet present in any of its prereleases.

