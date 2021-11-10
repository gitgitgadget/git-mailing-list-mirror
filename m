Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAB5C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CBB61241
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKJLI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhKJLIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 06:08:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F7C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 03:05:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r8so3283845wra.7
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EtekMmlmH7w277sDBSKbW/X6LJzPTAyyz8Y6tKjhh7I=;
        b=qdisvtagpncokj/oOthOLuUvlExsThOjKngCpaHbpZIKVl78TWNssCe2uf79OT6qSz
         h+OvyoYNxfr7lloNw6xvW31/xatClbaXRFEQ9f5JO122y36H8ZkGB7VoMlKNWYq6Nlad
         QsNculPbgWI5p8Qdo6oznZYcAVkUlZuSNISzEPrNysZGLGyy+Pa1pWGJmXCfUDIllkOa
         LBbd375q06r6QrfV5T6EIJxPIv20JgpLFw/sCof60Oxcf6iTr/72HanAI1wvhGe+k/Cw
         czaUGp4Tp/5vAUhLPIRo7reRpd16aT9WYWDkET/biEk5qMb70eIA8mmG8FyyKhrUEO5d
         Rfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EtekMmlmH7w277sDBSKbW/X6LJzPTAyyz8Y6tKjhh7I=;
        b=jNBZpetQGnt/hcolf1tGCfNECaVRdmPg1xn3uEKL/4lHZOm9qN1xv+Mrax2rSnSFOc
         zDK2T2k4z6BThT99T5HSr9DkbZogudVhXRRRzvubyjqscLPnrDzPxPaQFLWlBGp55ijN
         6My6Q9W8OFuJubWJQR/q8R+I0es/mVuD7/5WXn5qtMB3080+LGeOYbQhAOvES4F5to6F
         xVu70FR9cA47tZXEmymngdT1j7C6sLjl2vqSaiIedHdjhY2IE/vexB2OyOBPZEb6knTA
         eUWqQ0VgKg7mNOLMW3nyNjbMGUu27H3QiAdLc6T+dNiQh5vNFiaLnYdIsBFV75t1yAK1
         i7Rg==
X-Gm-Message-State: AOAM532LF0oHQ8JYgSIhEpXlF6eLDkoVxvB/HsaXkP+nTiJROhB8CO6G
        mn55o4Zn8QfVPTWrwYz3CL+p9isAaWmivg==
X-Google-Smtp-Source: ABdhPJxT3cgeVkME+zXA6EvXsI0fF095uaO6X0xNKU9ujkuXzZ72MMkAaPQ9mflPWIPQwpdb5Bx6QQ==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr18303168wrb.80.1636542327156;
        Wed, 10 Nov 2021 03:05:27 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id l26sm5418102wms.15.2021.11.10.03.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:05:26 -0800 (PST)
Message-ID: <33c63811-b048-8227-6148-16d5bd908564@gmail.com>
Date:   Wed, 10 Nov 2021 11:05:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 01/15] diff --color-moved: add perf tests
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
 <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
 <8fc8914a37b3c343cd92bb0255088f7b000ff7f7.1635336262.git.gitgitgadget@gmail.com>
 <xmqqsfwkq1h4.fsf@gitster.g> <b6f57fc3-75d9-d7d5-7153-28dde066a101@gmail.com>
 <211029.86zgqs3wpx.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <211029.86zgqs3wpx.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 29/10/2021 12:06, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 29 2021, Phillip Wood wrote:
> 
>> Hi Junio
>>
>> On 28/10/2021 22:32, Junio C Hamano wrote:
>>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> Add some tests so we can monitor changes to the performance of the
>>>> move detection code. The tests record the performance of a single
>>>> large diff and a sequence of smaller diffs.
>>> "A single large diff" meaning...?
>>
>> The diff of two commits that are far apart in the history so have lots
>> of changes between them
>>
>>>> +if ! git rev-parse --verify v2.29.0^{commit} >/dev/null
>>>> +then
>>>> +	skip_all='skipping because tag v2.29.0 was not found'
>>>> +	test_done
>>>> +fi
>>> Hmph.  So this is designed only to be run in a clone of git.git with
>>> that tag (and a bit of history, at least to v2.28.0 and 1000 commits)?
>>> I am asking primarily because this seems to be the first instance of
>>> a test that hardcodes the dependency on our history, instead of
>>> allowing the tester to use their favourite history by using the
>>> GIT_PERF_LARGE_REPO and GIT_PERF_REPO environment variables.
>>
>> p3404-rebase-interactive does the same thing. The aim is to have a
>> repeatable test rather than just using whatever commit HEAD happens to
>> be pointing at when the test is run as the starting point, if you have
>> any ideas for doing that another way I'm happy to change it.
> 
> I don't know if it's worth it here, but the following would work:
> 
>   1. List all tags in the repository, sorted in reverse order, so e.g.:
> 
>      git tag -l 'v*.0' --sort=version:refname
> 
>      (The glob can be configurable as an env variable, or we could fall
>      back)
> 
>   2. Go down that list and find the first pair that matches some limit, I
>      think say the first "major" release with 500 commits would qualify
> 
>   3. Make it a GIT_PERF_LARGE_REPO test
> 
> We've got some perf tests that do similar things. I think you'd find
> that with something like this you should able to hand the perf test a
> path to git.git, or linux.git, and probably any "major" repository" as
> long as it follows a common "we tag our releases at some interval"
> pattern.
> 
> Or perhaps more simply:
> 
>   1. Note the number of commits in the history, per "git rev-list HEAD |
>      wc -l" 2.
> 
>   2. Then round that down to the nearest 10^x, so for a 250k commit
>     repository round down to 100k and diff say the 90k..100kth commits,
>     for git.git which has 60k that would be 10k, and the diff is commits
>     9k..10k..
> 
> It means you'll get a "bump" eventually when say git.git crosses 100k
> commits, but it will prorably be stable for any measurement anyone cares
> to do, and means that you can get "realistic" measurements for diffing a
> big chuck on of history from anything from a tiny repository with >=10
> commits, to something truly gargantuan where you'd end up diffing say
> 900k..1m.

Thanks for the suggestions, I was quite tempted by the second idea, but 
in the end I couldn't face rerunning the pref tests and updating all the 
commit messages again. I've added a couple of environment variables to 
allow the revs in the diff commands to be customized.

Best Wishes

Phillip


