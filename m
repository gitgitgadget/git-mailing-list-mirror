Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E76C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiHWTC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiHWTCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:02:09 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B2AC7FB8
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:33:46 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id h8so3577521ili.11
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Nh7HrzuYqchlYYVTjEfLoT77D29DNCeh+6NYRMdwEu4=;
        b=JtMV//RExaRokkNPfw0gfmH7CLazI6oqBYlhkTS8I1RSOekwYoLbXk1eWPevbpUIhr
         O2jEye9PhpVkBACXDYBuV7EuhCpwt9ytP4klsACDJTnlrhibv5ueCflF/swK+tBHJcdK
         kYPiK/CKHRjrht+HwKKgPWLYnKFnCot71fZEJS0/oCREbOLRuCRpJIBCiY91bU6gGyB7
         GAjEcLPcdWFkmiTHBzORs9Z9c6MCxue8FZnlafh+41q7heHjhI2U1SS2A0AIbwZLKtAg
         hlbT/1WJQFSNg1tiqlweBdFtWSBgwpnyn8sQ1crGErfskN70vc0KaBt+LasA2kAQqCU9
         xnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Nh7HrzuYqchlYYVTjEfLoT77D29DNCeh+6NYRMdwEu4=;
        b=D30qy9PmjiXP5LM1e7KxdG6RUQHacS4eu1zylB87Rjn9s6BGAlM4AI4dSM56ZlWcYg
         RVGxSrgIqUn32qU+KkO1wlvzqdTe6xBAKAG2qeCPqGTLy8Psf44RBVZ3U21RFT045bDY
         1b8TCMSdiqQrZ2/1vXtw9vgFDDLjo550CJVdht5A0YKR1cm12cvUwO/LoBe6CQFVavwD
         Gh8aRi3KGm7UbQ7fo4HWNUxNXsB3EAAivSGohvOIkEy7ag2HYqI+dGmFWs9e23Aj1P00
         F3sy3xAXfxqWsBtzdpe5p7qboatHwoy0/ObGN5x3mq4WQqiciNPk6e+HtFZ+KvlX0FFv
         LUoA==
X-Gm-Message-State: ACgBeo3/ClYUgyf9JHy7VraIRu78lRrUnOFFZ6XlDRgc/js4otzECeF4
        FsbhBkc8MQL83uG5sD+NaK4sLVGkcfBB
X-Google-Smtp-Source: AA6agR6pwP+raehOZtSyKyFrBsFePB+rRZ8MduqdbSH3YW19RKZtsJjCAGxkHZLU1jinT/chqFedOA==
X-Received: by 2002:a05:6e02:12e1:b0:2df:32f4:3aab with SMTP id l1-20020a056e0212e100b002df32f43aabmr318569iln.276.1661275824640;
        Tue, 23 Aug 2022 10:30:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1b9:9fd8:f860:8737? ([2600:1700:e72:80a0:f1b9:9fd8:f860:8737])
        by smtp.gmail.com with ESMTPSA id z19-20020a056638215300b003435c50f000sm3129807jaj.14.2022.08.23.10.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 10:30:24 -0700 (PDT)
Message-ID: <aa44e0b4-6e51-f5dc-16f0-69688833192f@github.com>
Date:   Tue, 23 Aug 2022 13:30:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Question] How to fix 'static-analysis' build on Ubuntu 20.04
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <eb8779bc-fc41-f601-05f2-024e6bf3f316@github.com>
 <20220822222601.GA1760@szeder.dev>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220822222601.GA1760@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 6:26 PM, SZEDER Gábor wrote:
> On Mon, Aug 22, 2022 at 11:19:11AM -0400, Derrick Stolee wrote:
>> While preparing my latest series, I noticed that the GitHub Actions CI
>> builds were cancelling the 'static-analysis' job because of a brownout of
>> Ubuntu 18.04. We are recommended to upgrade to 20.04.
>>
>> However, we explicitly chose 18.04 in d051ed77ee6
>> (.github/workflows/main.yml: run static-analysis on bionic, 2021-02-08)
>> because coccinelle was not available in 20.04. It still isn't available
>> since I tried the basic update and it failed [1]
>>
>> [1] https://github.com/gitgitgadget/git/runs/7955077955?check_suite_focus=true#step:3:98
>>
>> Does anyone have an idea of how to install coccinelle on this newer
>> version? 
> 
> Containers?  I've built Docker containers from most recent Coccinelle
> versions and used to use them in my custom Travis CI build jobs; the
> version included in Ubuntu 18.04 is rather old, and apparently it
> doesn't catch some transformations that later versions do [1].  I'm
> sure it's somehow possible to use such containers in GitHub Actions as
> well.
> 
>> Should we try compiling it from source for this job?
> 
> It's not that difficult to build Coccinelle from source once you
> figure out its OCaml dependencies...  And luckily those dependencies
> seem to be rather stable: we can pass the same dozen or so package
> names to 'apt-get' to install all its build dependencies both on
> ubuntu:18.04 and :20.04 base images.

These are both good ideas to consider if we need to in the future,
but it turns out that we can jump over 20.04 to 22.04 and that has
the correct feeds to install Coccinelle. I submitted an update [1].

[1] https://lore.kernel.org/git/pull.1334.git.1661275691795.gitgitgadget@gmail.com

> However, installing dependencies and building Coccinelle takes almost
> 5 minutes on my machine; I don't think we'd want to add that much
> overhead to every CI build.
> 
>> Should we
>> consider moving off of coccinelle and onto a different tool?
> 
> Is there any other comparable tool out there?!

I didn't have one in mind, but maybe someone else did? You make me
think that there is not, which isn't surprising.

Thanks,
-Stolee
