Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6F420C11
	for <e@80x24.org>; Tue, 28 Nov 2017 01:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbdK1B7X (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 20:59:23 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33792 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdK1B7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 20:59:23 -0500
Received: by mail-wr0-f177.google.com with SMTP id k18so23400875wre.1
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 17:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RxwN+vYNoXB9IkqX3hE03zvVQDl8B5aroLL2ByLs138=;
        b=hK6pzcnfc801AIEAvj0lRMftH77DuYpkntEIWKvXE3kgpODOqXPhxBWoqR4uBur64U
         KTr45NNPpKJvAT95/OklAbpOVHzn5zZXOz5SR7uZS3/Rxx3ft+iKTaS6AwjANRc/djoL
         I0t4wk3DvIk2sH0wYsqTiSJ8zcJp9MKOu2ka3/j/DekulyL09EowHWoMyys1ZBYAlIIj
         ufzQYTzt+xY5BI1JE7U/HYS1EdjfeEx0dzkMUWkmXNmNPjHq4kUTkdO8Stm7ZTRTl9nm
         LuDUQTFLivTXNznFzmmh1xvPAl5klVJK6aUKGuut6dmathgaNdvw7qrh1ERl9i/RA6Pl
         vc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RxwN+vYNoXB9IkqX3hE03zvVQDl8B5aroLL2ByLs138=;
        b=Ng266C68KzEketywjAYBGLeEuEki7jmZ++gON+QlYbjnpOTgT1e4kAkrvBJ/vlqW7Y
         TVmLrf9FpiD/Xfhl5tNSTYNpVlIJps/jFm84m33iErjwXOmzC5Tj1JLqVxnyqRp8mgbT
         9M9YCFQH11o70/NKnOFRWdSKC3k3ed9CdRplWr+ruwCCcqMo6CaUDT7tZzBRWJmKWPjH
         6/xxGhiZPjk0CZU6mCjPA1KGF8rqXqxhx3PZPCAtTbZBTAzq9kQYQdXhVZx+Qrqmu0mv
         sBaKcERQcJ0Rk0N5FObJGpyQLguvAuYsvN8ytpup53AisAGXwMWSvHR2LroWIy00L58F
         vRDQ==
X-Gm-Message-State: AJaThX5FRRDzl2Z74V7iNCoZS25v5v2UEOCFeE77DGjosEU4G5KxluUP
        Hp/veNJQkKIjYu4ix7wqJ9cp2EiV+9nwIOl1dy3zOg==
X-Google-Smtp-Source: AGs4zMZtAIAvy+qIWIKxV1qfHbLyazIIeAngMAomCMJaA0LsLqM5oWKVIeL0fWftKFeBMKVFA38VTshK+O5+w5tEshg=
X-Received: by 10.223.184.125 with SMTP id u58mr31080177wrf.33.1511834361849;
 Mon, 27 Nov 2017 17:59:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.203.140 with HTTP; Mon, 27 Nov 2017 17:58:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1711280132480.6482@virtualbox>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
 <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com> <20171127043740.GA5994@sigill>
 <xmqqk1yce301.fsf@gitster.mtv.corp.google.com> <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com>
 <alpine.DEB.2.21.1.1711272222100.6482@virtualbox> <xmqqbmjn9t48.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711280132480.6482@virtualbox>
From:   Takuto Ikuta <tikuta@google.com>
Date:   Tue, 28 Nov 2017 10:58:40 +0900
Message-ID: <CALNjmMpc2F4OSrQPBtRGwu6RM=V81PXJxOrP2w9dLdtL1=F+kw@mail.gmail.com>
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

As long as this PR is included in next Git for Windows release, I
won't suffer from slow git fetch.
https://github.com/git-for-windows/git/pull/1372

But I sent you 2 PRs to follow right way.
https://github.com/git-for-windows/git/pull/1379
https://github.com/git-for-windows/git/pull/1380
Feel free to merge these PRs.

Thanks.

2017-11-28 9:33 GMT+09:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi Junio,
>
> On Tue, 28 Nov 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > My current plan is to release a new Git for Windows version on Wednesday,
>> > to allow for a new cURL version to be bundled.
>>
>> Is this an updated 2.15.0 or are you planning to package 2.15.1?
>
> If there is a 2.15.1 to pick up for me, I'll take it. Otherwise it'll be
> Git for Windows v2.15.0(2).
>
> Ciao,
> Dscho



-- 
Takuto Ikuta
Software Engineer in Tokyo
Chrome Infrastructure (goma team)
