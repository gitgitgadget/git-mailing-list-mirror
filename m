Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B2C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 10:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbiCHKkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiCHKkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 05:40:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C263C490
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 02:39:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u10so26135857wra.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 02:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XzQl+QH2C00Pq+7ve9AJzZls2ZxD5mPRpCHM2ytm3jM=;
        b=olE1IgTNIcda91RJm9enbHGRUsN2EMsYdNuIS9118yKvkqZiobKCYH0ereMbMc6pdd
         u5mffdHINzMU4uxVmaTXFM9DlzlYcURexd/pJf6JebqBsv1cpOFcEfdoUqPtvhFxggd4
         xdPrRY6mCF8xMN1Xu5Rvzi1BhniBiUEFAphUh0lkjs6NICacb2zCWLnYJ/FrymMmJfx/
         atV+D/s2Ha68x9IzDMdMBwA1AgzP3Jc1wlfMH4gD8OzMT+rb83b/zxTEljSIoq8gZkkn
         HnbZuW3MI1FGFgYcFcRnWTM9P4IQBls0vzKxNh7LrZokzn+QiliCtdRqtDRYd/5NOgs6
         Rzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XzQl+QH2C00Pq+7ve9AJzZls2ZxD5mPRpCHM2ytm3jM=;
        b=Y4XnCD1ZOdwM3xpnslfhZtkucykQeNii2MPOhRKPdg18ZdSOocPDdcotJ251mzLcDi
         23h/0GkxDpAsFcnQV3+b15NynjDaKglbHCXuDWzI7R9uW3/2NxwQrioDfaeKK3YDBvA0
         w7CjVv++gnBWZ9nG7ReT7FIA4GYJPxhMEoOdILGMCXUM1oTB4Y1y5flZzCVguYlT5B6k
         8FEP1pQ5UgYKo3JsEGrzHqh+Ph+Ofjhgu/yCD0vhw0Sw6666dyXfsvbHSXvfxXNBFcLD
         wIckctzBDDyLT9BwU2QQI//3I8QzbsXK6lsNh7onNv2d55v3dqupX7UydbUOQ4ZF0OcK
         3oSQ==
X-Gm-Message-State: AOAM533TNKAxXl94I/1QwI0JhIUFWoYakYlhoR9UaE0OShiACMjf4L1z
        z4XwAMFhJeoeJzj8X1AeDjE=
X-Google-Smtp-Source: ABdhPJxMwRfacJ3qKEFakXhKWbBLMIUNK1zNkFrpPgZhl4Kn+QxC4KB7LO94ghmZ4ZBKd/tWwJ88JQ==
X-Received: by 2002:adf:dcc2:0:b0:1f0:4c38:d6be with SMTP id x2-20020adfdcc2000000b001f04c38d6bemr11755616wrm.79.1646735978167;
        Tue, 08 Mar 2022 02:39:38 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id j3-20020a5d6043000000b001f0247bbdf7sm13591192wrt.64.2022.03.08.02.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 02:39:37 -0800 (PST)
Message-ID: <34452e16-cf8e-8d23-671e-3c24cdf4e6a4@gmail.com>
Date:   Tue, 8 Mar 2022 10:39:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite
 --updatref behavior
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
 <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
 <xmqqlexsexse.fsf@gitster.g> <20334a5e-52b8-12a4-de93-a8baa5313858@gmail.com>
 <220303.86a6e72d1g.gmgdl@evledraar.gmail.com>
 <d73db784-c09b-a889-3d19-d41be7748e66@gmail.com>
 <F383C357-FEC3-4E1E-A0B7-97EDE05035FD@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <F383C357-FEC3-4E1E-A0B7-97EDE05035FD@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 03/03/2022 19:12, John Cai wrote:
> Hi Phillip,
> 
> On 3 Mar 2022, at 12:28, Phillip Wood wrote:
> 
>> On 03/03/2022 16:52, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Thu, Mar 03 2022, Phillip Wood wrote:
>>>
>>>> On 02/03/2022 23:32, Junio C Hamano wrote:
>>>>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>> [...]
>>>>>> +test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
>>>>>> +	git init repo &&
>>>>>> +	(
>>>>>> +		cd repo &&
>>>>>> +		setup_stash
>>>>>> +	) &&
>>>>> Hmph, so this is done inside the subdirectory.  The implementation
>>>>> of the helper in this iteration does look cleaner than in the
>>>>> previous iteration.
>>>>> But these many references to "repo/" and "-C repo" we see below
>>>>> makes me wonder why we do not put the whole thing inside the
>>>>> subshell we started earlier.
>>>>> i.e.
>>>>> 	git init repo &&
>>>>> 	(
>>>>> 		cd repo &&
>>>>> 		setup_stash_test &&
>>>>> 		echo 9 >file &&
>>>>> 		old=$(git rev-parse stash@{0}) &&
>>>>> 		git stash &&
>>>>> 		new=$(git rev-parse stash@{0}) &&
>>>>> 		...
>>>>> 		test_cmp expect actual
>>>>> 	)
>>>>>
>>>>
>>>> I wonder if we could avoid the subshell entirely and avoid relying on
>>>> REFFILES (assuming we're not trying to test the implementation details
>>>> of that refs backend) by doing something like
>>>>
>>>> test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
>>>> 	old=$(git rev-parse stash@{0}) &&
>>>> 	setup_stash_test &&
>>>> 	git rev-list -g stash >tmp &&
>>>> 	sed /$old/d tmp >expect &&
>>>> 	git rev-list -g stash >actual &&
>>>> 	test_cmp expect actual
>>>> '
>>>
>>> Unless I'm missing something that "rev-list -g" will emit only the RHS
>>> of the stash logs, i.e. no "0000..." etc.
>>>
>>> And if we only look at that the difference with specifying the flag
>>> isn't visible, no?
>>
>> Maybe I'm missing what this test is actually needs to do. I thought it just needed to check that the deleted stash is removed from the reflog and the others are unchanged. You're right that it wont show the LHS and if that is important then you need to read the log file directly.
> 
> We had discussed this briefly in [1], but the --rewrite option for reflog delete will rewrite the LHS, which is not visible to normal ref API users. So the only way to test that this happened is to reach inside of the file.
> 
> 1. https://lore.kernel.org/git/xmqqczjdp2g8.fsf@gitster.g/

Thanks for the pointer, that was useful context that could maybe be 
added to the commit message to explain why the test needs to check the 
lhs of the reflog if you reroll.

Best Wishes

Phillip

>>
>> Best Wishes
>>
>> Phillip
> 
> thanks,
> John
> 
>>
>>
>>>>>> +	echo 9 >repo/file &&
>>>>>> +
>>>>>> +	old_oid="$(git -C repo rev-parse stash@{0})" &&
>>>>>> +	git -C repo stash &&
>>>>>> +	new_oid="$(git -C repo rev-parse stash@{0})" &&
>>>>>> +
>>>>>> +	cat >expect <<-EOF &&
>>>>>> +	$(test_oid zero) $old_oid
>>>>>> +	$old_oid $new_oid
>>>>>> +	EOF
>>>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>>>> +	test_cmp expect actual &&
>>>>>> +
>>>>>> +	git -C repo stash drop stash@{1} &&
>>>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>>>> +	cat >expect <<-EOF &&
>>>>>> +	$(test_oid zero) $new_oid
>>>>>> +	EOF
>>>>>> +	test_cmp expect actual
>>>>>> +'
>>>>>> +
>>>>>>     test_expect_success 'stash pop' '
>>>>>>     	git reset --hard &&
>>>>>>     	git stash pop &&
>>>

