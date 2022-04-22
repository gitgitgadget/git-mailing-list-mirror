Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF303C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446034AbiDVJeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446070AbiDVJd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:33:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B4453B59
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:30:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so10207221wrg.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zsQmV0yqemraXwOUsMKe5YR35m49HPTMoNXBupvyrxY=;
        b=ox8oSHF6481r5BurPQL22p7fv7lKXSmBtHtYIYmzIXEI7L6zwCjhorJ4Zi+eY0TQhD
         /xQq9S9K+Uzt1VsH2nWz2mowUp1p3AtkvF/EWKNqSR1UzkWoQIDXrnFuYJGlUUcHe5hL
         PDGesSlTaJAXJR1EjBRjd9KFssdmm6f7Huwqq9g+s3ZUWd/e4+CjyXKDnkO8TZv6jc7E
         tDMT5LC8m67Sq1f1BeUKdZIvTPBTM+O5hpUY+BkcQ5IlF4IxI31RXfrXUJ0e9Uk4cBzV
         6oobemQQJb++1O0EmOkyf/qXT3XKA57n823sAQSqz0uJKVduTHaY2kW4lrp79tB5Yzoa
         6yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zsQmV0yqemraXwOUsMKe5YR35m49HPTMoNXBupvyrxY=;
        b=6b783cIA5qIFFOElxMdQhqpVIAMcp1ffLBw9oSV8wHIuj0LoT691N6BffvSgB3kD8j
         hUtWA64RGC84B9qdT9gx+7hcyPiIB5McEK/skpcLHWZ1GVI8r1LvIdVXmAyjGt930gLY
         Rmsaf2NebWgE4Ewj8+9WUNU77N9jdXwB+f5GNMEbg5yYulqIi9lZhYRZlpQN8bI8oRqo
         4T5vtotlIooSQ/2xxIfIibGElNT8Eg/SlYY/zhIVbZgbJJiY1EtXrH4fHwqMDA9x6oba
         PLiclL5x2uR9Jv9xfV9kUYvTSYnSnYEkbs2wVYl5YRODycGGZQaSbhszfk4xYipSiS4x
         BQdw==
X-Gm-Message-State: AOAM530qyyl3GgJOAOlXFds4DqMtQVU+BxrQx4tL7i9r7kp15zL8bcSl
        mmS2LCtpxzamchNBgrPNf/w=
X-Google-Smtp-Source: ABdhPJzbL2wl0t69U67HjxBouJS+RcqZnetHR+sy1VtcIX9MlB9YYn/e0F6QFhxWTeL+77gAPp62xA==
X-Received: by 2002:a5d:6b4c:0:b0:1e6:8ece:62e8 with SMTP id x12-20020a5d6b4c000000b001e68ece62e8mr2955314wrw.201.1650619840773;
        Fri, 22 Apr 2022 02:30:40 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id n2-20020adfc602000000b0020ac8335e46sm1479848wrg.99.2022.04.22.02.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 02:30:40 -0700 (PDT)
Message-ID: <34a9c2dc-f8f5-4c1b-fed8-115429ae5a9f@gmail.com>
Date:   Fri, 22 Apr 2022 10:30:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ab/ci-setup-simplify (was Re: What's cooking in git.git (Apr
 2022, #05; Mon, 18))
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqbkwyz78z.fsf@gitster.g>
 <1157a463-f6c6-1df5-59cd-419d73eed1df@gmail.com>
 <220421.86fsm66zmz.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220421.86fsm66zmz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/04/2022 19:36, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 19 2022, Phillip Wood wrote:
> 
>>> * ab/ci-setup-simplify (2022-04-14) 29 commits
>>> [...]
>>>    Will merge to 'next'?
>>>    source: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
>>
>> I haven't had time to read all 31 patches from v4 in detail but I have
>> looked at the results in seen.
>>
>> Looking at seen:ci/install-dependencies.sh the shebang has been
>> changed to "#!/bin/sh" but it contains
>> "BREW_PACKAGE=${CC_PACKAGE/-/@}" which is a bashism.
>>
>> Looking at seen:.github/workflows/main.yaml to skip running the tests
>> one has to set "skip-tests: no" which is utterly confusing.
>>
>>  From what I saw scanning the patches there seemed to be a lot of
>> churn, both of existing code and code that gets added and then
>> moved/refactored within the series.
>>
>> Looking at the output of a recent ci run of seen the steps to prepare
>> the environment before building and testing print all the environment
>> variables rather than just the ones being set for that step which
>> seems to go against the aim of "CI: narrow down variable definitions
>> in --build and --test". (Also the "SKIP" prefix in the output lacks a
>> ":")
> 
> Thanks. Those were all helpful. I replied to these in a re-roll CL at:
> https://lore.kernel.org/git/cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com/
> [...] 
>> I think splitting out the build and test steps is a good idea but I'm
>> less convinced by some of the other changes.
> 
> What other changes are you referring to here?

Here's a list from memory - apologies if anything here has changed in
v5

Separating the environment setup from running the build/tests is quite
github specific. If instead we just had scripts that setup the
environment and ran the appropriate make command they could be used by
any future CI setup. Doing that would avoid lib.sh being a top level
script rather than a library as well.

I expected tput.sh to be some kind of wrapper around tput but it just
sets $TERM if it is not already set. We already do that in lib.sh I
think and I don't see what the point of changing that. I think we'd
want to do that whenever TERM is not set, not just for github actions.

Moving things from environment variables into MAKEFLAGS adds
unnecessary complexity as we still have to export those variables on
windows.

The script to run docker builds and tests under a unprivileged user
is just deleted rather than fixing our docker builds to not run as
root. At the moment some of the httpd tests are skipped because they
refuse to run as root.

One thing I do like is moving the environment setup out of the github
actions yaml and into the scripts as it should make it easier to
support other CI setups.

Best Wishes

Phillip
