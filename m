Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5742F1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeDFV54 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:57:56 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:43081 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDFV5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:57:55 -0400
Received: by mail-yb0-f174.google.com with SMTP id z5-v6so906054ybo.10
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CSof+ypdV48/YWxIMCGI/mEP8cuWMoK9z9aYpgLeeOY=;
        b=HHgGy99t/URCC4K5KpRlCx9ctTTfY2/dtH6sK8zq8zXuyqzdAZsMp/ItCMKrrbUTxg
         Z0mRTg4/++CphdiYBsED7jJSCUGxpOTGDtGMemrmpzi4n0z85EkHKww5tX8B8ynAZYAg
         yxp926oHEBssJ8jVkYxQgNRCnlXAINdnQ6opW13SdDEWVzN2rixkmlK31IfRuTXCuJxP
         9K4rlbUloMteGZuDwfDA/mc+yRdQMbYvYXuB0bRyKs04hGX4iUyOfJhtUS+C+CbgD7WS
         RiQMqK+HqsLPTpPJRoATJ19l/1rK7kyd4Ycjaw0hygjFqTx4bL+TMFXFqbWGx+hfJp8y
         5oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CSof+ypdV48/YWxIMCGI/mEP8cuWMoK9z9aYpgLeeOY=;
        b=ZqOkeqEbDLhwNNENqF8AjdmH1Tl7N9zzudNe16Kqwy5dW9IpeORMnVbqMrXfOSHWBi
         NEpOMhMWNmpjf75vHbGRnimHqXWvJ/3AMeGT7ck/yDNkHU3YeNqbpBod3izuE/zvNVk8
         ijVOzVepfYqBqeJ+G1SMXlYANznDeUa2mgmCg1+5nr85VfgwmT4VpoK6ZL/nrCaZztDb
         SY5sNmVfQzzKNJmvG1AsDaHOa4wnb6M3ChpEAFfnXXyYrA4hcM1tL1vbIeAbrRuh/64y
         XkT86Ipl/9oaRX5k741KP2nU4c1w/vTa1bL7Tr1fJxtUV3okvA4veUUISj0zy/foYS64
         bYoA==
X-Gm-Message-State: ALQs6tDFiB5EItFwH+LuyX2ADjlJy0wMSjZ9qeCnisdr87MmdtISW+X/
        gYcofAFEi57wug+Zl3NIq+zQ0qCXE3KjXL+F8MD8XA==
X-Google-Smtp-Source: AIpwx49awhmBGOcIXW1kvdhRyFjZtKEFcKUNKZMjlmRMOTf9Jia34qBo6j92YWoDhLex08NyZhiLfKwSj8dxEbjLv/E=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr10947340ybn.307.1523051874603;
 Fri, 06 Apr 2018 14:57:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 6 Apr 2018 14:57:54 -0700 (PDT)
In-Reply-To: <20180406214006.GE7870@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
 <87fu4hwgfa.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1804031150030.5026@qfpub.tvgsbejvaqbjf.bet>
 <20180403132717.GC18824@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1804031758160.5026@qfpub.tvgsbejvaqbjf.bet>
 <20180406214006.GE7870@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Apr 2018 14:57:54 -0700
Message-ID: <CAGZ79kaCSyz94_-a_Xq0LWT-tGqr+46me3gHy8d55HpxdU6f-A@mail.gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 2:40 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 03, 2018 at 06:00:05PM +0200, Johannes Schindelin wrote:
>
>> > But if we're at the point of creating custom C builtins for
>> > busybox/dash/etc, you should be able to create a primitive for "read
>> > this using buffered stdio, other processes be damned, and return one
>> > line at a time".
>>
>> Well, you know, I do not think that papering over the root cause will make
>> anything better. And the root cause is that we use a test framework
>> written in Unix shell.
>
> I'm not entirely convinced of this. My earlier numbers show that we
> spend a lot of time actually running Git. But that's not because we're
> written in shell, but because the stable interface to Git is running
> individual processes.
>
> So we can unit-test wildmatch or similar in a single C program, but I
> think we inherently need to run "git init" a lot of times.
>
> Now I think there's reason to doubt some of my numbers. I was counting
> exec's, and non-exec forks due to subshells, etc, may be important. So I
> claim only that I remain unconvinced that we are certain of the root
> cause.
>
> At any rate, I would be happy to see more study into this. If we can
> create a measurable speedup for an existing script, that might give us a
> blueprint for speeding up the whole suite.

The setup of each test is finicky, as we'd do different setups for each test
as we'd test different things. I once wondered if we'd want to have a
"ready made" directory that contains repositories in various states
that we can copy for each test and only need minimal adjustments
instead of writing the setup from scratch in each script.
