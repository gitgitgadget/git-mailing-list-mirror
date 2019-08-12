Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C657E1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 07:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHLHfo (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 03:35:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41092 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfHLHfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 03:35:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so2611547ota.8
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yxvyeXGZZEO3gkAa7hoWTew6QctDppkMpPDq3Td1awU=;
        b=MHnlbEAtnESMgJnxPhUHBYvTonQjKwrSNnPSWSf2q4tBl5YLPqN2pKWYzc5envYLak
         8+IkGJMQG66cTFfcWvaZbaO6hLuEjgsJCmaYxClYMB/r7lrwFgfs1dqO398dudb098zZ
         3SAmD8BAaHS8C7GpkSAttEoi86AJrPNvi6FyqGzCi2Qow7FdVacbuSSb2jgyDmU70zlh
         2F6jHP4pNQ6uGkaBc1h1Nn2Nxi79BsBLgcotyzgPaEyGOGse//2YpJ80UYfFj3HwOBMa
         PVOA5EDOZaQ73XoQf/yuOuFd7IFAoYcrfgfpISc8+ykrBxv6Uo3z7IaPalnLBGgx8rDe
         DiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yxvyeXGZZEO3gkAa7hoWTew6QctDppkMpPDq3Td1awU=;
        b=Aypk0HISW2qouaSUJE0idOTEEtDhy9rbu+OTsPipd1qhDGRqCWje1Ky/4LDYuFb2+f
         rCfQL2NQesV8sVXa8joAzC23oI/Ur0qk6TFTcafNk6DiRuDyJbTC8TNnk7Y3OostrxE5
         xd3tJPiQFPKpK4zA2/kHJChk2Y+XuQkKUKh9VxNoEb98I665Xr/bbEdYTinlHy41HmOG
         RQOkOW7qOV8snWhnx6UJX+m2SW0XmIHELZN1n/QG+BWiSTKzFaKnkrrWBibvbp3eWqdn
         wYuNduZB4oj2Tt11/Iuwno5WORryqsEmLo8WIhUjOgZ+BgrbUDjX2VhZERhmeDPp0K2Q
         qA+w==
X-Gm-Message-State: APjAAAVXJy7Wpb5TkOxLMCTJTf+iCBYNqiPn7aJpHJaHPTCLYDgCP8FS
        ZC/ODBr2Ytuo72aqCC1BniBHeuC1nBEZ46jKcHU=
X-Google-Smtp-Source: APXvYqzmcZIOlVAYpsv/zlGY2RZvIQRjLPHsNsrrIzw6xr4HJ3Xnz7OWq7EiYjj/Uwk5tb0eXeAjmUaRiYcUM5YyMYU=
X-Received: by 2002:a5e:da48:: with SMTP id o8mr21623036iop.252.1565595343693;
 Mon, 12 Aug 2019 00:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <20190810030315.7519-1-carenas@gmail.com> <f78b57a6-9ede-c87c-fc42-292851d79fad@web.de>
 <CAPUEspjtZhhynEmJu_weROaao=1zL+De1h50R-grG36ok+EAyw@mail.gmail.com> <501f946a-1f18-7c6a-2d15-8ff6375c4192@web.de>
In-Reply-To: <501f946a-1f18-7c6a-2d15-8ff6375c4192@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 12 Aug 2019 00:35:32 -0700
Message-ID: <CAPUEspiuuCWgjuHZ7DLyH+0hXt7MqeP++xyZuB+Zd5t-H_d69Q@mail.gmail.com>
Subject: Re: [PATCH] SQUASH
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 10, 2019 at 12:48 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> > On Sat, Aug 10, 2019 at 12:57 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> >
> > Do you mind then if I "adopt" your patch and submit a reroll with it,
>
> I don't mind, sounds good.

I had to squash another fix that was reported[1] before but wasn't picked u=
p
and that ironically might explain the last segfaults from my old V4

Carlo

[1] https://public-inbox.org/git/20190721194052.15440-1-carenas@gmail.com/
