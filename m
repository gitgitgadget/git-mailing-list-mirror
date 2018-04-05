Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B21C1F424
	for <e@80x24.org>; Thu,  5 Apr 2018 08:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDEIOD (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 04:14:03 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33150 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeDEIOC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 04:14:02 -0400
Received: by mail-io0-f182.google.com with SMTP id p139so5519450iod.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZVWxTCR4kOoEYRYygig/mygnIRcjmvnrMMS9FZwnWNY=;
        b=FVNxJiZfjpYOt9X8kJraFlvG//OFd7R9Si8T4LRtuLEmaW4K32ljMCsaEoVzxEtA1g
         I7OVlK6TGucgjMXU5oWcr4xeUofLAARl1FdLx7cWMkwrhpwRT1GM5mB9orNW2cuF0TZF
         Nghxk4StWTia+iP71NxVhkPBBkYIBhuVlbSB4meYxoW8e0Op29Abe9H75GnJ+obJdijC
         skOLX1JTPhRzxGzx3PS1gCkGPd8QTSzKFJ1MnQ+m6uMuOzsEMe2nIEUv8SfDdWar3PXA
         iNXJq3wM6Qc0OryZ9XudSnKD3FiQvfWMMEVsXJzoZ2X6FjFED7XNIcJeq3E3ULlnd8Jk
         odPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZVWxTCR4kOoEYRYygig/mygnIRcjmvnrMMS9FZwnWNY=;
        b=dxdaoy/0cdGqzqCCQpjYaN+yM4seOyCQWlws8J7qq/YtX/ZNFbREbRVccBLAneromR
         63xGlzzMvItRoNpoK19j1DYEnNA6pQPNT1sNk8paLs4aNtZNZhDG/RgvO2x2H/HShbZi
         3byT8Wu8v9DVx7o+BVkDw2QCJz2HbY6nOpItsVy0F07uXteQ0/2bCSlw7uyTe6HD/MPt
         Y0bhIw37UgZ2TjW9WfQIzNspv3R22Z6ycdL6jximZU7kSK044nyO4Nx4LQJp9HaHQRmP
         mzbQxqS0EzI0uDBWcnhBYvGeocz2jh5qeOaV412jxj3t9PDRJ2n5u8Fk6OZWZWarNCXO
         1k7w==
X-Gm-Message-State: ALQs6tAdpxws2ZBheiwMfrzJ2UkZAo0f0ccpPQu+EqIc3wQGw9kAM/6u
        Pngn2oPMSoUzgd7GYUmTDshwCQ8LALWGMiMdafU=
X-Google-Smtp-Source: AIpwx48K1Fhp8vP1o1QYxPKpJb7185mPiz+I2QzH08r401DZVizQ3WJ97OfEecAT7fhaIqZARCTkah4CtVsVEKzEtAQ=
X-Received: by 10.107.150.19 with SMTP id y19mr18720223iod.272.1522916040133;
 Thu, 05 Apr 2018 01:14:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Thu, 5 Apr 2018 01:13:59 -0700 (PDT)
In-Reply-To: <CAP8UFD0yz3yH7-fpxr=69z=wXAVjxraFWsuDVa7Ke_6ByV5B8Q@mail.gmail.com>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-3-joel@teichroeb.net>
 <CAP8UFD3SM9e+_VGpxVNzMoEYnyzkF0EzjAPjvbFakr9t9Z-muQ@mail.gmail.com> <CAP8UFD0yz3yH7-fpxr=69z=wXAVjxraFWsuDVa7Ke_6ByV5B8Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 5 Apr 2018 10:13:59 +0200
Message-ID: <CAP8UFD1zEu1kbKWiYKxYdkrVL4m5XmCMbqz47r+JNQjD2_MEwQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] stash: convert apply to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 9:59 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Apr 5, 2018 at 9:50 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> So maybe we can get rid of `result` and have something like:
>>
>>        if (argc < 1) {
>>                error(_("at least one argument is required"));
>>                usage_with_options(git_stash_helper_usage, options);
>
> Maybe we could also simplify these 2 lines by using usage_msg_opt().
>
>>        }
>>
>>        if (!strcmp(argv[0], "apply"))
>>                return apply_stash(argc, argv, prefix);
>>
>>        error(_("unknown subcommand: %s"), argv[0]);
>>        usage_with_options(git_stash_helper_usage, options);

And here actually we could improve the above 2 lines using something like:

usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
                              git_stash_helper_usage, options);

It's better than using `error()` because the printed message will
start with "fatal" instead of "error".
