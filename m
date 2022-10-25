Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3BC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 13:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJYN3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYN3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 09:29:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EABF7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:29:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu30so20996421wrb.8
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WS7eIjyfzCe3EjGyPOCAWK4uQzmOygz0iianFU4BIog=;
        b=i94bIDrPqlE7jKjlNKHLxiXqmNjMj38VcNJ8fS7wulNdA/imPoef7P8EEEw/w5WT8D
         queO27OXLJZ81DuNzt+wgJgdDeRfvV6VS0Y+jEVcXmu3UdR0ZgIxCsv0HpMurDA3uaN+
         09pWEhHIfOYchAGpQLhzEJBIlJpE4tGESmOKkwcLBxPNC85mC7IXMP36PViHzKNcTlyp
         80rPjJ64xRZs20WMoAk/NdTnL8sgkNINL6wyDesdMgxG9s15xSHZRI9QK+OgY/4zH9WU
         YqpaM9b8NYBk3kJX2x7h3757yUw6v2xur3T3lYVjuheBWCGzQfFBJ2K/r6TiZgVXe30j
         RxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS7eIjyfzCe3EjGyPOCAWK4uQzmOygz0iianFU4BIog=;
        b=LQxqTDJQNCryUUcyNjCJo6ITotxkg8GIfnXmEEHUifChSzP5TvrzsNzDnusiJJ9WSC
         L7oaBGyVGtqTCEjOW12HylfxBIUKH0jl20zWybEm6bzbPqlklygbP9sDj6SCuvCptXll
         nCH2+CmBEg5OdTq5s3HS9uvvzmbOp2hgFyhuy92egLdBC4go8AwSwQgKI3cIkTj1Q1oL
         aM3kePQtdBaD6FEsQHdVULIL0M9ZcCN99qaSKnNBshOXn0/qwEIi8Lts7Abz3W3mjCm6
         VHaNq1lPeUsr3UqQurSrPVNeZ7w9fF8E6qy6+sv7c6BKw1Zi3Dd2QIqw2owUt2M2WnTj
         xXxQ==
X-Gm-Message-State: ACrzQf3NTDBYV72TAfPYPCyKnzJRsI4qtIxDTWC1fg7vgLxw/SbbR8FJ
        cifIw2T9H9Sv7xeIz8tGTNM=
X-Google-Smtp-Source: AMsMyM6FDfa3hhtXIBHlARTiTE1a5mZ0DKMj1oqionaFC5tFNUNrbqWoTc88K6369aT84b2HKVoVvQ==
X-Received: by 2002:adf:ef4e:0:b0:236:6608:f6ce with SMTP id c14-20020adfef4e000000b002366608f6cemr9807314wrp.85.1666704564576;
        Tue, 25 Oct 2022 06:29:24 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b003b47b913901sm2932356wmq.1.2022.10.25.06.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:29:24 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c3d27586-f5b5-4e3f-9cbb-8cd31ac8887e@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 14:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/9] cmake: use GIT_TEST_BUILD_DIR instead of editing hack
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-6.9-45f1a4e6f93-20221021T091013Z-avarab@gmail.com>
 <d6e2baab-be26-66d1-f07c-134eb6fe06fd@dunelm.org.uk>
 <221021.868rl9faf2.gmgdl@evledraar.gmail.com>
In-Reply-To: <221021.868rl9faf2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/2022 15:43, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 21 2022, Phillip Wood wrote:
>> Lets squash that commit into this one, so we can see how it is used
>> when it is added.
> 
> Heh, I did that to begin with, but found that the commit message &
> change was too long & trying to explain two different things.
> 
> Since GIT_TEST_BUILD_DIR (like GIT_TEST_INSTALLED) is something you can
> use stand-alone I prefer to keep it this way. The commit message shows
> how you can use it without anything to do with cmake, and then later
> (here) we can use it for cmake...

We're only adding it because we want to use it with cmake though and the 
only way to see if the previous patch is correct is to start using it.

>>>    file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>>>      #test
>>>    foreach(tsh ${test_scipts})
>>>    	add_test(NAME ${tsh}
>>> -		COMMAND ${SH_EXE} ${tsh}
>>> +		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh}
>>
>> I'm not sure about using env on windows,
> 
> In general, if it didn't work a lot of our test suite would fail, so
> it's definitely supported, and since this is only used to run tests it
> should be OK with portability.
> 
> But I don't have a Windows dev environment other than the CI, are you
> able to test this & check if it works?

I keep meaning to set up a git build on windows but I haven't got round 
to it. Using "sh -c" also gives us more flexibility in later patches.

>> can we use ${SH_EXE} -c
>> instead to avoid creating an extra process?
>>
>> 	COMMAND ${SH_EXE} -c [[GIT_TEST_BUILD_DIR="$1"; . "$2"]]
>> 	"${tsh}" "${CMAKE_BINARY_DIR}" "${tsh}"
> 
> Neat, so that "[[...]]" syntax makes sure we don't have any quoting
> issues?

Yes, it works like lua. 
https://cmake.org/cmake/help/latest/manual/cmake-language.7.html#bracket-argument

Best Wishes

Phillip
