Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121D01F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeHNAGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:06:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43066 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbeHNAGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:06:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id j21-v6so9022595edp.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Q7ODlhF18ECyr8IundP0nNKK+SQBFgmRTRvuMM54HvY=;
        b=kHuC09FZahsXzjqqd5G5oJZR3hUvWGW6jfzli10tzPTqsivRn2W6Bz39zF6EUyB3Lq
         pinufmkm92JN1nTEDb/etpos0IYOKcpqBXdopGdKtAtvlGXYm53B5GYcOJf4p/n/NIHu
         ATgKPKcTYCZdazYEBLUDM1txUVo1yO2VcLCjx2R+gv/PbFugc8vdpbONBXd7AysQt/hG
         7pg7kR9v6LG499NzzDwalq94SxEvovCX/WDQep4QRhPG/hPtGT01V4PSFuK/0CU0Joir
         vGSbCDHtAFRiIPxQql3XqcUsHCf7v+ocpeHUHkIF1FTWfwcE6IKTYqurJxeD9ZZ4xPeA
         Jw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Q7ODlhF18ECyr8IundP0nNKK+SQBFgmRTRvuMM54HvY=;
        b=KEnVWY2Iv6Regam87RH6uq8FPIrZTnHM4OVlzRCgpjNkljVfP4pap99d3AmTGu/alC
         19zAWpguHL6Vha0p8zIBkd8/MkREkR/zc44HcgKCkjZJRgJ4b+AUMw6a+cMkfCJ4jMqI
         Wc238jm3fOwZl0OwcIwmEuEGakEVn9R2RDU0/NuHpEc6T3Y43SX6siNh6LKTCtRXDNkV
         EUVFLfT/dUTA+dgLzkLDDmLHrOZv6jhw9d9pv4WgEwxB9tsEnn7gKaQ4zW+efwlkoKaQ
         Ae/ZmVNVCcfEnCsEheq+bwj8n85JKJ/qAb/AHK4ZmyJsEgdV0Ov2LFM+rN1JrEykfjGL
         XflQ==
X-Gm-Message-State: AOUpUlESAQwutC3Mx/Om5hna96IoOAltwApEqsCcDvzph7fqxPa/475c
        T0eSrg1PB6Jtyayuxetl69U=
X-Google-Smtp-Source: AA+uWPwKMDxlusLy6nOitPGQTHR5GOMe5gfgt7B7qsg6apGGL3hCkHGfGNbln2/wfW1CzngYfuLtNw==
X-Received: by 2002:aa7:c910:: with SMTP id b16-v6mr24962708edt.22.1534195332223;
        Mon, 13 Aug 2018 14:22:12 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id m20-v6sm7706817eds.5.2018.08.13.14.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:22:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
References: <pull.17.git.gitgitgadget@gmail.com>
        <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
        <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
        <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
        <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
        <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
Date:   Mon, 13 Aug 2018 23:22:10 +0200
Message-ID: <87eff2rmgt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 13 2018, Johannes Sixt wrote:

> Am 13.08.2018 um 22:20 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> The Windows CRT implements O_APPEND "manually": on write() calls, the
>>> file pointer is set to EOF before the data is written. Clearly, this is
>>> not atomic. And in fact, this is the root cause of failures observed in
>>> t5552-skipping-fetch-negotiator.sh and t5503-tagfollow.sh, where
>>> different processes write to the same trace file simultanously; it also
>>> occurred in t5400-send-pack.sh, but there it was worked around in
>>> 71406ed4d6 ("t5400: avoid concurrent writes into a trace file",
>>> 2017-05-18).
>>>
>>> Fortunately, Windows does support atomic O_APPEND semantics using the
>>> file access mode FILE_APPEND_DATA. Provide an implementation that does.
>>>
>>> This implementation is minimal in such a way that it only implements
>>> the open modes that are actually used in the Git code base. Emulation
>>> for other modes can be added as necessary later. To become aware of
>>> the necessity early, the unusal error ENOSYS is reported if an
>>> unsupported mode is encountered.
>>>
>>> Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> ---
>>>   compat/mingw.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 39 insertions(+), 2 deletions(-)
>>
>> Nice.
>>
>> I wonder how much more expensive using this implementation is
>> compared with the original "race susceptible" open(), when raciness
>> is known not to be an issue (e.g. there is higher level lock that
>> protects the appending).
>
> Certainly, the former way that uses two syscalls
> (SetFilePointer+WriteFile) is more costly than this new way with just
> one syscall (WriteFile). Of course, I don't know how atomic append
> would be implemented in the kernel, but I can't think of a reason why
> it should be slow on Windows, but fast on POSIX.
>
> (But I can't provide numbers to back up my gut feeling...)
>
> (And I also assume that you are not worried about the performance of
> open() itself.)
>
>> ...[define race_safe_append_open]... and replace
>> the call to open(... O_APPEND ...) in trace.c::get_trace_fd() with a
>> call to that wrapper.  That way, other codepaths that use O_APPEND
>> (namely, reflog and todo-list writers) can avoid the additional
>> cost, if any.
>>
>> Some may find it beneficial from code readability POV because that
>> approach marks the codepath that needs to have non-racy fd more
>> explicitly.
>
> O_APPEND is POSIX and means race-free append. If you mark some call
> sites with O_APPEND, then that must be the ones that need race-free
> append. Hence, you would have to go the other route: Mark those call
> sites that do _not_ need race-free append with some custom
> function/macro. (Or mark both with different helpers and avoid writing
> down O_APPEND.)

O_APPEND in POSIX is race-free only up to PIPE_MAX bytes written at a
time, which is e.g. 2^12 by default on linux, after that all bets are
off and the kernel is free to interleave different write calls.

I've written code (not for git.git) that implements such a
"write_non_racy" function in the past, and the first thing it needs to
do is to assert that the length of the buffer being written doesn't
exceed PIPE_MAX.

So there's still a use for a race_safe_append_open() wrapper function,
to O_APPEND and do the PIPE_MAX assertion. Otherwise you're calling a
"safe" function which isn't safe at all anymore.

I have no idea what the equivalent of that PIPE_MAX caveat is on
non-POSIX (e.g. Windows), but would be interested to find out.
