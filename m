Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8131F453
	for <e@80x24.org>; Wed, 24 Oct 2018 13:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeJXWYZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 18:24:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38285 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXWYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 18:24:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id b14-v6so2894556wmj.3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ry3EVpQd7VVUr3w/KOeJSQvLC5pETKlDVmr/08iDd4Y=;
        b=BZKT3MNDsKoPF3z1aV4isMEalMVmeZWM2Z244IVaDJGC56MtYMkQ8NRrCN3mbOslwm
         232nGNq+6rumqOIuWZYPtIrh43SCQM0IgBnuTh3h//ILd8JHFpLNDm4Kagx3c6wIu14a
         La+JY977JoFq4J/L5RX5xtEy6BBwJzUw+xMpUD1guNl0ys5j4KYCxzMXTvoixiLswoUO
         QSEAWb9R9HAEPokLnDqoOTuf/1RoHBAnbAO/7hKAsuPDsCb9mchKe9DV6FwVuBe8esFy
         tRIsPfV6gAIwuNVxLZw/dx3YCYbATon45EVgHFrSPveV/R8gk7EKmTZ9s8yDfwiRPPm6
         WEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ry3EVpQd7VVUr3w/KOeJSQvLC5pETKlDVmr/08iDd4Y=;
        b=ivO4yPGQyKFiDOeukyrSzm3tspRrsUnb8ZrQmfApho8mcC6g+vRajy2zeNBmJWl65d
         l9C20FjMbfsSCkIPo4nIwDWerbQ7vCx5LGyrNSx/omruurhARQ8oyvKKAMWjF8mA3nGN
         A9GlodY5aWIuvFlqAo/6RvkBD2hUmGD5ird4t6ZsBE2optGhK6apP7NSbltluKSSP481
         yE/0dQGxJpARJArMPQ8AVX0pRxLzLS6OQE3TccPonZZ79EwDElB34wz6gH+0H+lgL1AO
         ybHn0UvckR+Sj56kn3HcAQ+2gFgfBYd1wnW83b2gkB2LWCeBc5Bt62rGBn/mlOzCoIg1
         cw9A==
X-Gm-Message-State: AGRZ1gJcgxOsyJsjMcH6vdwx/i8tK0TTmp53T6qTKFh9pj1y2Rx3v745
        bgc7UrY4096tNFNmTZY94qM=
X-Google-Smtp-Source: AJdET5dcWoZYcCCgXEHibRbFFlScisUjoRJqqqMwBuh8yWm4HLv8mrubKtG5QrqcVl4YTdwBO9aMag==
X-Received: by 2002:a1c:2c87:: with SMTP id s129-v6mr72567wms.127.1540389370319;
        Wed, 24 Oct 2018 06:56:10 -0700 (PDT)
Received: from [192.168.1.4] ([31.223.156.199])
        by smtp.gmail.com with ESMTPSA id 130-v6sm6364126wmn.7.2018.10.24.06.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:56:09 -0700 (PDT)
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user
 name
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        slawica92@hotmail.com
References: <20181023162941.3840-1-slawica92@hotmail.com>
 <CAP8UFD35aOb5weDcDVFth96e+H-as_Q9bLPuCpSDReKJERnM7Q@mail.gmail.com>
From:   Slavica <slavicadj.ip2018@gmail.com>
Message-ID: <45cf8bf9-adfa-655e-0ded-fdb71707f7ad@gmail.com>
Date:   Wed, 24 Oct 2018 15:56:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD35aOb5weDcDVFth96e+H-as_Q9bLPuCpSDReKJERnM7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 23-Oct-18 8:52 PM, Christian Couder wrote:
> On Tue, Oct 23, 2018 at 6:35 PM Slavica <slavicadj.ip2018@gmail.com> wrote:
>> This is part of enhancement request that ask for `git stash` to work even if `user.name` is not configured.
>> The issue is discussed here: https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.
> We prefer commit messages that contain as much as possible all the
> information necessary to understand the patch without links to other
> places.
>
> It seems that only this email from you reached me. Did you send other
> emails for patches 2/3 and 3/3?
>
> [...]

Okay, I will change that. This is my first patch and I am still adapting.

Emails for patches 2/3 and 3/3 because aren't there because I am still 
preparing them.

(I didn't know if I had 3 patches in plan that they should be sent at 
almost the same time.)

>
>> +    (
>> +        HOME=$(pwd)/none &&
>> +        export HOME &&
>> +        unset GIT_AUTHOR_NAME &&
>> +        unset GIT_AUTHOR_EMAIL &&
>> +        unset GIT_COMMITTER_NAME &&
>> +        unset GIT_COMMITTER_EMAIL &&
>> +        test_must_fail git config user.email &&
>> +        echo changed >1.t &&
>> +               git stash
> It seems that the above line is not indented like the previous ones.
I don't know what is the reason, in my IDE everything seems fine, but 
I'll fix it.
>
>> +    )
>> +'
> Thanks for contributing,
> Christian.

You are welcome,

Slavica

>
>
