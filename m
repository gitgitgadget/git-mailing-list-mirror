Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C700A1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeKNHuS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 02:50:18 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38696 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNHuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 02:50:18 -0500
Received: by mail-ed1-f42.google.com with SMTP id a2-v6so11862054edi.5
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 13:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=XPFpaKQ+TSb2Hg19NIY4hEdT7/EL4r+Nc7Hmb3qPfxE=;
        b=hudmbY3ydig0fpN1XcOHMMCW7IyNzqJV/4Lw3eF6MSC/6FkbbVnxDU4PCth1V0WS5y
         kRXeLQez82g5IR0fPhA85MZruapD5FJgVlvYkW55O1tFn6nGt3JqoRmz3P6+PXOuQIFM
         tMsF/fvG/l+xqO4/+vpEu+s4PdRWbM/50ioG7b9V6GLp45FTkljMhlaIAXXh0WM5XsY0
         qrjkmxIFe18JEIxwPCOzWDYdfd2MCQnWKH+MSSseu6CNahkpcP2Ac7eHRqkesc8MlCpA
         K2Cdwu50Q3InMm3N1fQr0M6wbOO9hBhYPYOrzsmQkDfHNGZ2q8/BYr06GV0HW988nbFR
         E7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=XPFpaKQ+TSb2Hg19NIY4hEdT7/EL4r+Nc7Hmb3qPfxE=;
        b=MEeOfMj9xz2A/3fTSDTgrZgy8wyzjUS6x4K8yi1fbb4CuPSet6CM4iReGfVJOZoWuZ
         N2S0TuSU+orc7gP9Of9dXQMg7M8u4350xnNK7Yj0vIZKWqa5C33gJ/z0rCGq1ahh5koS
         4YREk9L1E2/Lyp7LJT/PgSSuWyQ59zCJgiuTCyChBwVrp9itSl+Ib1jai4k5jG368Cw2
         fiA42d/UjokeM3a8n7AbabApy1AreNx1/UZAI7DBnYtsWgmcQXb2eORZviyetAR5CPk4
         3jKuRQL2FWs7L2A6yROGHPlbXiM7cqL2QuOSlRGvgxXhhtMRaca7HwUQMgBrKSsUvari
         E2mQ==
X-Gm-Message-State: AGRZ1gI9k2Ue5Lo19qmaZfEJYDkgp2Pc2xa1W5HnorjbT5vll0nmXu72
        qjY51nGN28DLBv5drNX55gQ=
X-Google-Smtp-Source: AJdET5fHFF06hpOlv0OdNoaRwK25uQQc9By+1BZ9olFUI5xDYl8O1MiSxxV7CTfwM/xsV3dzxEm80w==
X-Received: by 2002:a50:b1db:: with SMTP id n27-v6mr16704672edd.128.1542145810276;
        Tue, 13 Nov 2018 13:50:10 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id q3-v6sm3201659ejz.30.2018.11.13.13.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 13:50:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: rebase-in-C stability for 2.20
References: <pull.76.git.gitgitgadget@gmail.com>
        <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
        <00d9b0e4-dde5-c96d-76d7-42fb9ac393f8@talktalk.net>
        <nycvar.QRO.7.76.6.1811132019440.39@tvgsbejvaqbjf.bet>
        <1b8461d1-6cb7-6622-94d2-44c27623236d@talktalk.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <1b8461d1-6cb7-6622-94d2-44c27623236d@talktalk.net>
Date:   Tue, 13 Nov 2018 22:50:05 +0100
Message-ID: <87y39w1wc2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 13 2018, Phillip Wood wrote:

> Hi Johannes
>
> On 13/11/2018 19:21, Johannes Schindelin wrote:
>> Hi Phillip,
>>
>> On Tue, 13 Nov 2018, Phillip Wood wrote:
>>
>>> Thanks for looking at this. Unfortunately using OPT_PASSTHRU_ARGV seems to
>>> break the error reporting
>>>
>>> Running
>>>    bin/wrappers/git rebase --onto @^^^^ @^^ -Cbad
>>>
>>> Gives
>>>    git encountered an error while preparing the patches to replay
>>>    these revisions:
>>>
>>>
>>> 67f673aa4a580b9e407b1ca505abf1f50510ec47...7c3e01a708856885e60bf4051586970e65dd326c
>>>
>>>    As a result, git cannot rebase them.
>>>
>
> git 2.19.1 gives
>
> First, rewinding head to replay your work on top of it...
> Applying: Ninth batch for 2.20
> error: switch `C' expects a numerical value
>
> So it has a clear message as to what the error is, this patch
> regresses that. It would be better if rebase detected the error before
> starting though.
>
>>> If I do
>>>
>>>    bin/wrappers/git rebase @^^ -Cbad
>>>
>>> I get no error, it just tells me that it does not need to rebase (which is
>>> true)
>>
>> Hmm. Isn't this the same behavior as with the scripted version?
>
> Ah you're right the script does not check if the option argument is valid.
>
>> Also: are
>> we sure that we want to allow options to come *after* the `<upstream>`
>> argument?
>
> Maybe not but the scripted version does. I'm not sure if that is a
> good idea or not.

According to Junio's calendar we're now 2 days from 2.20-rc0. We have
the js/rebase-autostash-detach-fix bug I reported sitting in "pu" still,
and then this.

I see we still have rebase.useBuiltin in the code as an escape hatch,
but it's undocumented.

Given that we're still finding regressions bugs in the rebase-in-C
version should we be considering reverting 5541bd5b8f ("rebase: default
to using the builtin rebase", 2018-08-08)?

I love the feature, but fear that the current list of known regressions
serve as a canary for a larger list which we'd discover if we held off
for another major release (and would re-enable rebase.useBuiltin=true in
master right after 2.20 is out the door).

But maybe I'm being overly paranoid. What do those more familiar with
this think?
