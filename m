Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8FDC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiGNTS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239941AbiGNTSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:18:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7D613D36
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:18:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j12so1282218plj.8
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ikv298xpdRp2UeTLxe2XGwQCugGpVYoEbwosAfHAYxo=;
        b=C+ii41c/fLK67ivCN0YGKAt0jxU1qGR7oULQs9Filsyp2HS+DMrjfv2Dhv89SEPjH0
         fbnMwcXyBPJYvy+c9mwdU+6bcftC/LQeN9UH+Yb7ziRZSAgZQ5L3XYv4gfnInRt3cPer
         ZXD/u1V4SsWyYua5lDU0Nf1nsspV18NPl2OaYval5kzMbg5uY0p9wYfyf4GFtk7or/RU
         dApacPynIjwq10WGUoQ3cCehP/Emy2IZ5wZCWtMZRGjLmXW0T1swsmVSLoLTNwDCHI0l
         RxmzZKN9ZZDlaFNMWqUuPMKIEjBF3qkMJMP5S1XGsiCqtfQUFiRAWhPc29uSa+SaAlR+
         P4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ikv298xpdRp2UeTLxe2XGwQCugGpVYoEbwosAfHAYxo=;
        b=LDVWNgm0Lil7pG9RJRyPMI/h7+pKzc4yuIkSmxsC18wjk3CnMV3qVxpTNw9eqMiZ3u
         IBMzuirrVKSzQI4JQG3ErZLl48I7SSWThFb90rXehX1hwSvLo/ip6LtqtmDE4+glYJ3s
         K/0u3rZYIUQTUvMT6ZYvgTP/ewLIslzOopBk7rRu0GkKF10KikvF05Jf67caRLaQa2py
         HcqNWWYWa0WqacCUflpgWulCUkJWWRsaGzYxZnv6bv3K3T8tzKofPKrZht76hcIbV1Ip
         HdpJcvL+7arr1OF+h7XnXvLdnPMoSMw/YlQ/Mdv/Dnl4LPI190CjKyb2cVakKWBKii9X
         UxWw==
X-Gm-Message-State: AJIora9l4vxz6F92a0cQLBHYe2cNUaM8gNkpGIGrHAgTqJhLjuhokPlY
        GgPGOnEod7Y8Qszww/A7/B6S5TAUEDWl
X-Google-Smtp-Source: AGRyM1tnohBQUYoVrNCBZqJ/bd8jMB+OstjmAUNiUnwxz4k60hfGXe+2EwmJiiKsdIGi4I4REaxmGg==
X-Received: by 2002:a17:90b:19d2:b0:1f0:46ef:fc1b with SMTP id nm18-20020a17090b19d200b001f046effc1bmr11162087pjb.182.1657826333161;
        Thu, 14 Jul 2022 12:18:53 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0051b8e7765edsm2025998pfh.67.2022.07.14.12.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 12:18:52 -0700 (PDT)
Message-ID: <4f4d5d03-2a0d-19c1-fd2e-80ab86aa1145@github.com>
Date:   Thu, 14 Jul 2022 12:18:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: "reject arguments in cone-mode that look like patterns" doesn't
 work in macos-12
Content-Language: en-US
To:     fawaz ahmed0 <fawazahmed0@hotmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BL0PR13MB42750BC5C4837B7B0BD1885EF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
 <BL0PR13MB427533B25CCFE6A37F7619E8F1889@BL0PR13MB4275.namprd13.prod.outlook.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <BL0PR13MB427533B25CCFE6A37F7619E8F1889@BL0PR13MB4275.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fawaz ahmed0 wrote:
> Please refer: https://github.com/git/git/commit/8dd7c4739bded62175bea1f7518d993b39b51f90#commitcomment-78433458
> 
> 
> Using patterns in cone mode should fail, but it doesn't seem to fail on macOS-12(github actions)

Can you confirm which version is being used on that MacOS agent? For
example, you could add a call to 'git version' in the workflow and see what
it prints out. I suspect that the agent may be using an older version of
Git, which would mean that the sparse-checkout is initialized in *non* cone
mode.

For what it's worth, my local development machine is also MacOS 12 (running
Git v2.37), and I'm correctly seeing the error in a cone mode
sparse-checkout.

> 
> Step to reproduce(try in macOS-12):
> 
> git clone --filter=blob:none --no-checkout --depth 1 --sparse https://github.com/fawazahmed0/currency-api.git . 
> git sparse-checkout add 'latest/*'
> 
> Thanks
> Fawaz Ahmed

