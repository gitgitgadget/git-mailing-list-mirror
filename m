Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D5EC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiEIPWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiEIPWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:22:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8422440D
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:18:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e24so19950860wrc.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Im17A3+eAsmoH9ZXmZHe2RLSZLGeQcJ0qDqhiq0iy2Q=;
        b=BbAyeNujJi4qDpD61ldC1G7JUMsXCpSaMAtaCdBTxF3WKX6NBu1/NFJb4K7QatOamT
         EnpeH4cAnOFLZyDBIpXTDdTahctVdZ6x0KNFfONaUvpzaV/r6zR4bohpXQfvHStY7J62
         CeLQEkl/gAa7PBAKK+0xodFrfXqrIoid9kiop5miWbel6kc3QqcGuQyrSP+n4IBb51cF
         4HpvezYRzHp1MqBdG9LU89OEKfBl57H8YwyxxP3XngfJpJFo7HL0lU3IgRtnVgrN9dWS
         eid0IdZjOqWm9CYyGM7CMhUkJ22qKLHRcydsFjgu1vzP3gQNDlDNvQapJXeHMk4T9ske
         DRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Im17A3+eAsmoH9ZXmZHe2RLSZLGeQcJ0qDqhiq0iy2Q=;
        b=yv14OegsBwY+Zo/oT1wfRrpVmfJ5QU63WM5Hj9dfVEvcwxGbKTkNOz2UJe4bn+rkKn
         ueZEDfw1/lB2E+SB2xM5Gx2LEmqpee4FG04NSYx6EU6s2tTV5hgoTHBD845bZqjzQo8U
         xjPw3giD6pUQJQxRq+ec02Mdq395dKop6kB0BUybkmBZb94F3zKsrRMLzWNIUaOtn1lc
         DkSljWQJsp2uIxpRyKiUAKLN92ysk3nyjDU0cK018Jgb2boRXbmIYc6sryz2kA53Cer8
         HwjdM7eEtfzQiMN9iTP+kUMwzjoVm6GOwlrSqR2ts9xEGk8tCFNB9a3/0LTiZDX58Z12
         0WIg==
X-Gm-Message-State: AOAM531YkCR4UPvtVgEmsxpiHBmnAg9BhMX0nUZYe/pT3cX/PIvp3hOR
        CXJ12mcEBkV3Ui2YmYQ48e8=
X-Google-Smtp-Source: ABdhPJyj3LO8aPQYRvGhlYE9SqVi+48CmerZzf0aIrObNGG+NP1gEDdoC0hle9OM917KBUGMuB4klg==
X-Received: by 2002:a5d:63ce:0:b0:20a:da1f:aac5 with SMTP id c14-20020a5d63ce000000b0020ada1faac5mr14069275wrw.589.1652109521831;
        Mon, 09 May 2022 08:18:41 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id l124-20020a1c2582000000b0039482d95ab7sm7978770wml.24.2022.05.09.08.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 08:18:41 -0700 (PDT)
Message-ID: <8b7e0af4-7b6b-8891-edc1-81d6b0f3b412@gmail.com>
Date:   Mon, 9 May 2022 16:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
Content-Language: en-GB-large
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com>
 <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
 <xmqqlevfesnu.fsf@gitster.g> <4314bf6d-d76c-bc5b-a7f9-e59c7c181c7c@gmail.com>
 <CAPUEspiX4FJc4-1DGCek1iWMYL7M7Xir9PSXbFAwQy7xTFKxYg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEspiX4FJc4-1DGCek1iWMYL7M7Xir9PSXbFAwQy7xTFKxYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 09/05/2022 15:51, Carlo Arenas wrote:
> On Mon, May 9, 2022 at 1:21 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 05/05/2022 19:33, Junio C Hamano wrote:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>> Hmm. I would like to suggest that we can side-step all of these issues
>>>> (and the ones I outline below) by considering a similar approach to the
>>>> one Stolee took in t0033: use one or more `GIT_TEST_*` environment
>>>> variables to pretend the exact scenario we want to test for.
>>>
>>> Perhaps this may be a way to pretend we are running a command under
>>> 'sudo'?
>>>
>>>        test_pretend_sudo () {
>>>               GIT_TEST_PRETEND_GETEUID_RETURNING_ROOT=1 \
>>>            GIT_TEST_PRETEND_LSTAT_RETURNING_ROOT=root/p \
>>>                   SUDO_UID=0 "$@"
>>>        }
>>>
>>>        test_expect_success 'access root-owned repository as root' '
>>>                mkdir root/p &&
>>>                git init root/p &&
>>>                test_pretend_sudo git status
>>>        '
>>>
>>> That way we can avoid having to run "chown" while preparing for the
>>> test fixture, and running "git status" under root, but I am not sure
>>> if we want our shipped production binaries to have these "pretend"
>>> knobs.
>>
>> Lets ask ourselves "How could an attacker use these knobs to facilitate
>> an attack?".
> 
> That is not the question raised by having those "pretend" knobs in the
> production binary, but instead how can an attacker abuse them to get
> themself and UID he doesn't have and therefore additional access.

Maybe I'm missing something but I thought the idea was that these knobs 
were only for the safe.directory check and the normal file permissions 
would apply to all the other code.

Best Wishes

Phillip

> The fact that the current code requires you to be root to even enable
> the logic makes it more difficult to use SUDO_UID that way, because if
> you already got root, you don't really need them, but take into
> consideration that this discussion starts with (how can we run these
> things as a the test user and avoid sudo, hence root).
> 
> Carlo
