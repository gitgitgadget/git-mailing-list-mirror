Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4CEC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 03:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356810AbiBDD2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 22:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347848AbiBDD2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 22:28:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ECAC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 19:28:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id r59so4268482pjg.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 19:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=9YEuO2fJ4zQVwKu1in8R7dGNuiIztz8vwRd5i7hVUKc=;
        b=KpsJhjix8DsJ/up691bmgWbav8/0rY2zRhzzu7Fqnr/xuijTBOrEUr8jxqlepIzg11
         GsKS+dppPGvoWVNSjDY6et4UGZSUEHvSS59aaMKSIheuTh0I/h/sqzJidJxZOhUlRMSC
         +0sz3A9tWwFqY7ASIGaIeqm4B+LBX85xizeB5Fj3yyGx9MUwJ7IPhM20YzjuogPX8lT6
         JXOEMNEmXWUhrXeZbHCB84wI9Cn6ozz851yZ5KVoNmIR4o7A04txtb+oUgv2KoOGO/72
         MTx/RlrR1AItptM8f/3Rl4FeARD3IDQyQd8NeVyBfWIAwTo8kvbqL0XPrJ+zAsKEITyD
         OVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=9YEuO2fJ4zQVwKu1in8R7dGNuiIztz8vwRd5i7hVUKc=;
        b=heCmHSdA6JRq12gj4X3adFjGHhhlIVniXxiNnXqV4BKm5cNAnLA4Lb/EKlrFy6iI0r
         QfFcxiq62iH/8+N9gta8gKJBnML82IIXmEfUIUzDrvqu+y1QfQKBP3HUEUa0iY9JvSNX
         AFhzNcGtDKYYChgjJmABSCaGy6CseYBiCXvRkHqeIxOpKo3Xqlj01zp5v0ajp6R2VOKq
         1vfkP5GapcwgPLJWJk/VRuGoDF9zRJV24YKkczTs77oVuKyh6MVYgt3+ly1IsDMb8Bc/
         rC+NQkL1lufqqzUxExKvbxZmce2VasSVSrOqoAU7EEjIPah/IW4rj7RWgko9VIB4IBOQ
         nWiw==
X-Gm-Message-State: AOAM5333T6i/uY9gO9H12cMlMkPdjbELF75Je+u/Z2LrYZsn0Tql7qqw
        l0eYJVzt5c/Uqc6KPeXtOTg=
X-Google-Smtp-Source: ABdhPJzjRUTS4HL+0KFgqp61Z7lNO7HOuhTizT1sbGA9MFgf/hhTRSnJ+xn4qlrlu+DegfeBmU09Jg==
X-Received: by 2002:a17:902:70ca:: with SMTP id l10mr1042047plt.174.1643945295316;
        Thu, 03 Feb 2022 19:28:15 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:51c6:c5ef:caca:5a98? ([2601:602:9e81:12c0:51c6:c5ef:caca:5a98])
        by smtp.gmail.com with ESMTPSA id b11sm425234pfv.192.2022.02.03.19.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 19:28:14 -0800 (PST)
Message-ID: <7bcd8f30-840e-be53-ff7a-b5ab035fd3b3@gmail.com>
Date:   Thu, 3 Feb 2022 19:28:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v5 0/3] completion: sparse-checkout updates
Content-Language: en-US
From:   Lessley Dennington <lessleydennington@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <xmqqo83nr59i.fsf@gitster.g> <7033ab1b-7d90-d83c-fc65-33801c6348cc@gmail.com>
 <xmqqy22rpm10.fsf@gitster.g> <eb442213-d369-fdcd-c3a3-05239bccb5bf@gmail.com>
 <cb6f65b5-4e02-08af-bea6-141fb6227927@gmail.com>
In-Reply-To: <cb6f65b5-4e02-08af-bea6-141fb6227927@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/3/22 6:43 PM, Lessley Dennington wrote:
> 
> 
> On 2/3/22 3:59 PM, Lessley Dennington wrote:
>>
>>
>> On 2/3/22 3:28 PM, Junio C Hamano wrote:
>>> Lessley Dennington <lessleydennington@gmail.com> writes:
>>>
>>>> On 2/3/22 1:48 PM, Junio C Hamano wrote:
>>>>> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
>>>>> writes:
>>>>>
>>>>>> This series is based on en/sparse-checkout-set.
>>>>> This has been a very helpful note, but after the topic was merged to
>>>>> 'master' on Jan 3rd, it has become a tad stale.  Let me apply the
>>>>> topic directly on v2.35.0 instead.
>>>>> Thanks.
>>>>
>>>> Thank you for the heads up! I will remove from future versions.
>>>
>>> No problem.
>>>
>>> FWIW, the tip of 'seen' seems to be failing the CI; I haven't looked
>>> into the cause of the breakage.
>>>
>>>    https://github.com/git/git/actions/runs/1792151138
>>>
>>> There is another CI job running on 'seen', whose only difference from
>>> the above version is that this topic has been temporarily ejected:
>>>
>>>    https://github.com/git/git/actions/runs/1792296432
>>>
>>> We'll see if that fails the same way (in which this topic may not
>>> have anything to do with the breakage) or if it passes.
>>>
>>> Thanks.
>>
>> I just merged seen locally and was able to repro the failure. I will
>> submit a fix ASAP.
> 
> GitGitGadget CI has passed with the fix, but it is not responding to the
> /submit command. As a heads up, fix may not be submitted until folks who
> are a bit more knowledgeable about GGG than I are available to help
> troubleshoot.

Nvm, I was able to get it to work!
