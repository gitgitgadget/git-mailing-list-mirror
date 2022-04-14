Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFC4C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 20:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346295AbiDNUcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 16:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiDNUcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 16:32:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97443B3FA
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 13:29:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso10235044pjb.5
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eDszkt0LwsuObZRupIk+KgSegqu+eOoceeqyJsfLZP4=;
        b=SpVG54tJhQbeIv5qqPYJwQNK3TuN3nBUCHp1JvF5+NTghBDhNtV5LKDvwLzPjm2cWs
         uo0CFaWF52rwr8FyNflcSxsNLBJp0NOpXTYyyn17e/QZpRhKKBQl8juD5eXUC3xhfaJz
         oUuApMp0LVX2P6EfdOBAlN9+0KYWAl3THfnpzMZlEA6Vf6uJ5mabG09xEFydlXsTJnGC
         vD/qXJvSgKJXg1YlWaPyfy8GDPddYcGBawyghIPZA53UyH0qm/qEFCmNlXgo1I9XPF3g
         uuf/IMbCqOXOuVviDN6Tm0/0r/zf4xxiDCTbTLjwdTtIgUsX8CyQuSFcuzbYOyI1aFA4
         7leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eDszkt0LwsuObZRupIk+KgSegqu+eOoceeqyJsfLZP4=;
        b=BQ6gldpMdsusX3q9/8L2Jw41JYV+sF3Sxe1O0mK3SHglun6oqGA4nLlmdLPtMm8tbb
         JL4/PGDRS6XOL/d5F/WYgICFAyjRZ/JElJ8uXjpQOU7/+snEOkecAs0KEuC60VDq02xJ
         5lS63k/5kPOR1VUbJmt6UrO0eLjYAwncCQoRxFuC2CbZG9CIMYXD29r5/MHGG8eh0C82
         wYwxzMPceGB4EqaCssONcDkq4DJ2eek9VxChYSFGmOPpfBuPds2/CRdkgqRBC1DUBTGc
         TT0p4Ee+9AvUFCYXNi2089DAcDVn+18rnms0H09dBwcythExTg1079L+lrzZOoFeW/da
         rriA==
X-Gm-Message-State: AOAM532GjrGIJKWCNlf5cNfFWjL65oTrI+tn8WuDaZ8+VK4o0IbcYRMd
        FROTKTwYUZoqMjia6tHmXoS2tE6FPGI=
X-Google-Smtp-Source: ABdhPJzLml6iEC7BEf/Yxvv/D8oN4ht5WRbBgsMdq3MPSEHHKFzE9Cz23ZOvGXgkhjZhnAxPnN/lzA==
X-Received: by 2002:a17:90b:4a41:b0:1c7:a0d7:718c with SMTP id lb1-20020a17090b4a4100b001c7a0d7718cmr345533pjb.57.1649968181228;
        Thu, 14 Apr 2022 13:29:41 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.130.193])
        by smtp.gmail.com with ESMTPSA id 26-20020a630f5a000000b0039d83ab8655sm2629681pgp.0.2022.04.14.13.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 13:29:40 -0700 (PDT)
Message-ID: <0179a76a-182a-0501-a4ae-800ddb53b8cd@gmail.com>
Date:   Fri, 15 Apr 2022 01:59:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
References: <c2190b9c-3393-730d-1bed-d793c1d32275@gmail.com>
 <20220414082010.14217-1-chakrabortyabhradeep79@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20220414082010.14217-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-04-2022 13:50, Abhradeep Chakraborty wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> 
>> That's good to know. Do let us know if you have any experience with C
>> and shell programming outside of your contributions to Git.
> 
> Thank you for reviewing my proposal. I used C language in my B.tech
> classes. I never used C in practical/real world projects before. So,
> putting altogether, no, I didn't use C and shell in real world projects
> before.
>

That's good to know. Thanks.

>> Taylor has shared feedback on the proposal and timeline which I hope are
>> helpful to you. Specifically, Taylor said:
>>
>>>
>>> So I think it makes sense to try and find a way you can dip your toes
>>> into 2-3 of the sub-projects and get a sense for what feels most doable
>>> and interesting, then focus on that before allocating time for more
>>> projects in the future.
>>   >
>>
>> I agree with this. It's better to be practical than ambituous when
>> planning the proposal.
> 
> Okay, I am willing to work on first sub-project then. Should I remove the
> other subprojects then?
> 

Rather than deciding the plan in haste, I would recommend that you put 
some more thought into deciding the plan for your proposal. Take some 
time to reflect on the different parts required for the project, 
potential things that might interfere with the project etc. This would 
help you come up with a more refined plan.

This might need some deeper understanding of the project that you would 
be working on. Do feel to ask us in case you face any issues with this.

Also, you could use Taylor's suggestion as a possible starting point for
the plan:

 > If you end up working on this, I would suggest budgeting a week or so
 > to try out a couple of different sub-projects, and then decide where
 > to spend your time from there.

Hope this helps,
Sivaraam
