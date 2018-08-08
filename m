Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BB11F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeHIAks (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:40:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33489 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAks (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:40:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so3378960wrp.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XtAWHIPDfi7524cjwjsUdG1PNbh/SkCx9FtBeN58Khk=;
        b=fTOCLGdlCNqF3x5l6IPP1hFJXNEC5ayLhmTlDdqcA1BkAjPzfSiRKV/92Nkb6/khex
         /ExQ1RJqbR1K7/Mr/TnyZBVoQviDRmOILfPxoEZYmyuqxRdE/MU/w70SdSvaW4SWelMC
         Lqt4vMMp7Ma/fOc/xwAQeb2Ozl7vEEDFiwfXroOHB55grm6HJf4bOaEJSbGTPEnj47vm
         cg9Tssd1jzQZZajOQSrt8VeIw/Ufu464nFLbt4ainbAg9N6Q+40L4DIx2g4j4jvZ6zjQ
         NmCJSA2alYVW9VeTQW3+iX9jd1UDp4/Rvt+atPha+mWcKH4pHdfEv652kkMwvhixJkKz
         53Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XtAWHIPDfi7524cjwjsUdG1PNbh/SkCx9FtBeN58Khk=;
        b=a/YLWwr44lFiok1t8QDAA/8JK4Ev1PbtwOyRbH9NKUuGJ1ZFmXKPtZrBpgn6XRjBOx
         0+gLw7VEuKxnkUQ5C2qEhDfxeDkebiRAueiPPbs7PfTED/yugpUHNb29TgiDSQ5TsLRC
         whX2RTVyZ/2bff4lt+PqySrs/9hBpdI8z1e4OoXQhOvGWtfU7nzPs7BYR1f7u7qypjOS
         NPZ0HJNjhdil9ZXUOlgF3gfNkPmnlPK/GIqnC2h1RKTKzF54mt6pwOWsTdqhaOacXZWt
         8L/3cYS+bSl2jxmL9uctXmHQHekt3lJJJlR7wREYwLI6wbr4KTQOZfK3e+t1sUdAKaHu
         5KVQ==
X-Gm-Message-State: AOUpUlF5cmjhavEP61wgrow5vxGW0aQP47tCm5Qc788lDjYA+Ok8OLug
        mkrQymr193do6rQlkY41RmM=
X-Google-Smtp-Source: AA+uWPyJ9RnXzpeTKzocscgX0XPIyJLOd/LMvjrEpFaMB6fBLshdaIhNw0Q43LXdPlmeoOS6wcdzfw==
X-Received: by 2002:adf:b786:: with SMTP id s6-v6mr2914095wre.247.1533766745763;
        Wed, 08 Aug 2018 15:19:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2-v6sm4759543wrn.83.2018.08.08.15.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 15:19:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] pull --rebase=<type>: allow single-letter abbreviations for the type
References: <pull.14.git.gitgitgadget@gmail.com>
        <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com>
        <87sh3qrn6d.fsf@evledraar.gmail.com>
        <xmqqmutwfxh0.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 08 Aug 2018 15:19:04 -0700
In-Reply-To: <xmqqmutwfxh0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 08 Aug 2018 12:51:39 -0700")
Message-ID: <xmqqk1p0ec2v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> -	else if (!strcmp(value, "preserve"))
>>> +	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
>>>  		return REBASE_PRESERVE;
>>> -	else if (!strcmp(value, "merges"))
>>> +	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
>>>  		return REBASE_MERGES;
>>> -	else if (!strcmp(value, "interactive"))
>>> +	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
>>>  		return REBASE_INTERACTIVE;
>>
>> Here 3 special cases are added...
>> ...
>>> +test_expect_success 'pull --rebase=i' '
>>> ...
>>> +'
>>> +
>>>  test_expect_success 'pull.rebase=invalid fails' '
>>>  	git reset --hard before-preserve-rebase &&
>>>  	test_config pull.rebase invalid &&
>>
>> ...but this test is only for 1/3. I haven't run this, but it looks like
>> the tests will still pass if we remove --rebase=p and --rebase=m.
>
> Good eyes.  It's not like that parsing these three is implemented
> with one thing; in other words, it is not hard to break one without
> breaking the other two.

Having said that, that can be done as a follow-up "oops, the
original was sloppy" patch.  It's not as bad compared to "oops, the
original was totally borked and here is a fix", so I am OK with that
;-)
