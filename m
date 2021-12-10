Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1EDC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 06:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhLJGy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 01:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhLJGy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 01:54:27 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E3CC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 22:50:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r138so7223713pgr.13
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 22:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZuvlVMPY+htduUgRbXAuiFPUSnAvW6+zyyllSFgiTMw=;
        b=SRoXi8HR4+t9Cu9JdKHKYw9p2+HktxrbhMwLdRbfXUG9NZcgRI2wZdZadEaPT70ue6
         gL1/xKApwEQHxXpe4zZM0IHDUph8xVWBwDKlz4RmXxEdUanj0GLnF+OEWszT/vhQIyl4
         o1JJL5zrFvt8XFco4MTW0QJR4ZUA9iR60l50yZ3Ij43Z0kE3RuFK+9fJUG+wkC7r/gyU
         OyQ32zdG5OWJsvXF4pRUKE2yBAyMdFbQrHfP1yRfQGh3irv3aMW+S/iQgesKxM2w8fo4
         1XLsN9RVOuR6zjhbtPPkpfEfYuKSgFQsOEjY52w5AjTq4UHmgX7jSH96G6x1PpQjZnk/
         NB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZuvlVMPY+htduUgRbXAuiFPUSnAvW6+zyyllSFgiTMw=;
        b=aZw/vb5+A+IZml1M60L+f8sLntFE0FiR8Upm0omKQd3K5ICQx2UmUrPSCc6GQLBd+f
         LrA4JGiJ1u08XFGqmTmHvrFiyx6kHpuvmLBJE+QaNSX9T1RN7orHtcqlHGI8DySJi3Mf
         XzFrT5Ef2vcsSLOUam4FHoP+tRUAYRkbaEhhphy5tBvMM+GZ/MBXQCisZiMU/4Q7MhvO
         CJoCEfPN/FT0AoXfI1ro1CigP5ueMa4m+ly7EPO5ZQ7t96aIDJ6lKiqCYxw+pQdpnWhJ
         u4896+fYUiG8eg5RN3hI4IhaYA1EGeadXelYR7QLa3vXQc4/zWVxnhKJ287U6GiMn00I
         MVsQ==
X-Gm-Message-State: AOAM532ycIs5yUh1W1Q5fZN1VyBCtxs0s/3vT+Pqx6fyzatQZhoD8SGg
        b2S0Uujd/6ntbPWhlGcZyyE=
X-Google-Smtp-Source: ABdhPJw1ZndRHrCGMEC11t6/oxvojLfsZR2qDWeZySXvGBSYelHgOMWf3z8ODap42d6GUI6YteC1Hg==
X-Received: by 2002:aa7:9acc:0:b0:4a2:b8b5:8813 with SMTP id x12-20020aa79acc000000b004a2b8b58813mr16367048pfp.4.1639119052514;
        Thu, 09 Dec 2021 22:50:52 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-16.three.co.id. [116.206.28.16])
        by smtp.gmail.com with ESMTPSA id p188sm1810614pfg.102.2021.12.09.22.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 22:50:52 -0800 (PST)
Message-ID: <0784617f-416f-a981-44e0-62bd22018d6c@gmail.com>
Date:   Fri, 10 Dec 2021 13:50:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v19 1/3] doc: git-format-patch: describe the option
 --always
Content-Language: en-US
To:     =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbikgdmlhIEdpdEdpdEdhZGdldA==?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>, Aleen <aleen42@vip.qq.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
 <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
 <a524ca6adfa2adc02e517b7be5199b0c071134c4.1639034755.git.gitgitgadget@gmail.com>
 <1ad4a3ee-af05-9bb2-67fe-566d5e4c39a8@gmail.com>
 <7bd729fd.29.17da1f2df5d.Coremail.pwxu@coremail.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <7bd729fd.29.17da1f2df5d.Coremail.pwxu@coremail.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/21 08.26, Aleen 徐沛文 wrote:
> Dears Sanjaya,
> 
>      Thanks for your suggestion. I don't see the actual difference between
>      the two sentences, and do you want to enhance the word "always"?
>      If you do, how about just describing the option as "Always include patches..."?
> 
> Aleen
> 

Semantically speaking, I choose "generate" because git format-patch **generates**
patches from the specified commits.

-- 
An old man doll... just what I always wanted! - Clara
