Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949D61F406
	for <e@80x24.org>; Tue, 16 Jan 2018 10:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeAPKC5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 05:02:57 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45260 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeAPKC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 05:02:56 -0500
Received: by mail-oi0-f68.google.com with SMTP id j129so10199556oib.12
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s4iTLoG11/v65ul08K4dnMQch2TlQIu2bnosAMfX8ZY=;
        b=rgT0+RmHO/ngtBy/aqAKOz+2bIhuZ+db1dPoNxpK1H404XKNJyc8SdB8s0bYJz7ByD
         w+uY0oaJNzUQGjwpTlyGljgjrNEAcRnEvPhd/4YqkcBhkjwwusS8aY3eRDjXMq8avhoa
         Zibi487F5yssJE9/IugIOMn3fchQ/E7Sl+IVk1houcGVPFTXmHwMYSjbN098r50ayDWa
         ICfcoEHtbLG86YMXKUwnney5Sh2QmCWqYnH1Hoi0/Q6C6OrTeYwMoJQ4Ocw0QI9HAi7M
         J8A9k/V5arV/yPhhkzix77/rtQ7MPsq0E6HXDNkV3nNBIf6mH6dggN1CMeLNfMeMDY9t
         3KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s4iTLoG11/v65ul08K4dnMQch2TlQIu2bnosAMfX8ZY=;
        b=d6JStDgvUEfRiMcMiJ83RiytlZ+D336VsyPl3yaZAL7Kosz8T2XwFc6AC+gb+penNr
         o7C8EfveYOEcXOSg+7Ax2y4ASqdt/8MNlY0xBmBdsT6ILKK7GCVEkQP0tPNa1Y6B2rNk
         Jr9frF3afpt2ZOaUcubEPTYEHS5WSfxPkx32U8QCJnBX2x1zUkTmizvV+4D1gNh3iu4X
         6UEE0mhM0/bgGkt1pAicJ6fTJNoZg7NyrH9kyEmbtVJHH2NG+k/uoXSebaq5oiLZutJj
         xY5+KG9011NkqCaBswKISYIf0oR5q7hhoLmuFbuXu0mFfN7AzDyZ7SSwGukoXZk8L6Do
         Wuew==
X-Gm-Message-State: AKwxytcPD/t82zhU49J5Ooo3yFyLdbMNAMRuwcxf2dsAvl6ADEvhSeag
        K1+sCNA1k1zfwZ2JlND4MVhX1oTnb+vrkKiiT3Y=
X-Google-Smtp-Source: ACJfBot7TOJ2z6tUcG5NRjBBM+ZDgltp5OPA7i1ZDqY1PcIV4G2ziMDHaRdp/F/zS95gwyr2vjhMsTu+bu26PaLDgOs=
X-Received: by 10.202.60.134 with SMTP id j128mr2459292oia.268.1516096975469;
 Tue, 16 Jan 2018 02:02:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 16 Jan 2018 02:02:25 -0800 (PST)
In-Reply-To: <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
References: <20171229135240.GQ3693@zaya.teonanacatl.net> <20171229224825.31062-1-szeder.dev@gmail.com>
 <87y3ll6s0e.fsf@evledraar.gmail.com> <20171230005222.GT3693@zaya.teonanacatl.net>
 <87vago76i8.fsf@evledraar.gmail.com> <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
 <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Jan 2018 17:02:25 +0700
Message-ID: <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com>
Subject: Re: [PATCH] Add shell completion for git remote rm
To:     Keith Smiley <k@keith.so>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 4:43 AM, Keith Smiley <k@keith.so> wrote:
> So it sounds like either we should deprecate rm, or I should update the patch to the suggested method where we just complete remotes, but not rm in the list of completions.

I vote for deprecation. I could send a patch to start warning to
switch from 'rm' to 'remove'. Then perhaps we can delete it after two
releases. It's not classified as plumbing should we don't have worry
too much about scripts relying on 'remote rm'.

>
> Thoughts?
>
> --
> Keith Smiley
-- 
Duy
