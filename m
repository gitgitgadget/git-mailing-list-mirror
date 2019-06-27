Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4A51F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF0RXc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:23:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39167 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0RXc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:23:32 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so6485877iod.6
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6GC57ydUyrK1i6sF5yA7IvL8Q5N9TN1nUNV7r1w5GA=;
        b=bjCtUb7SPF5YgCK+JKhUi8omR/LTdonW1DhvwJ2SHL40fwkclmGakgPY9pD9tZU06Y
         /AU2QCXsn/E5T+t+0RQ6fZY7uPBb2Uw7/QlEa0tJrdiz5/ZsS5AUlY5WyYh1us3xsZ1C
         SEfvUC/+3FVZblER0xbQLDiPJqPFVKicXUyzYoSv+yL6rpFwiwaoS8D//H/2iJgAK6b3
         /fvGu027pCLC/HGLi+SEBxCBjHwyOL/44HkGIduWUIIm0zxcTyo5VCsDcIHKlwstKsSv
         wNntjwRglNCLneMzoomeTQSs/QUB1bSoZ3ojXY4srBKbHSM0qWjm6ZrkPuUouss+mySN
         YEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6GC57ydUyrK1i6sF5yA7IvL8Q5N9TN1nUNV7r1w5GA=;
        b=eoMxYfD6CeA1QdD8X+S+wRx5jrGhvCS3m50aVUbenJH6z3Es438B26rgkqPN0jdWTY
         kyAwDkn9Y3oosv7m5MnAWcOVCGODY6Plv5skHGgTQ7j4PuInuf/OChRNwt5gmUKCuIFE
         voawWzs/S4IAXVjr19MGXOg2Fowp6r0guf7ES5iyiKbBOM3oVN/JFN6dtsY47dJJByFD
         uQKMw/dLPLa/MR6NDl+zWAUTxFDUKZ//hawvdEgPVrMeoC6m02GGAV5Ae8TLT+NF40Fe
         KK282h2TjU9Mw9suJrXmLOFb0ztCG2HXITG/LNe0eLUjsxb6LgmAChWlUw72ZbUwFMSL
         G+FA==
X-Gm-Message-State: APjAAAWKCKKvmrs1QHFodnVb4BTqbH+kTOqm2W7DM+B8twlL6TQPRTit
        B5StpwUpPrjN/Hv8FwPNmcreYG8fbieAnGeci8uzxw==
X-Google-Smtp-Source: APXvYqwdOGvTMnAOx9GCdc81DEInbkzUgvR09UB5K3DxgEH9JVjDlla1K/tv6a0wVVG2A8ZR3qNt3U0W+J+Oz4DJcMA=
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr5887062ioc.76.1561656211543;
 Thu, 27 Jun 2019 10:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 27 Jun 2019 14:23:19 -0300
Message-ID: <CAHd-oW5zea9wzobAQG4FzN-KSS5BsRoM5vf_x_F83=yqGRfUQw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Matheus,
> >
> > On Tue, 18 Jun 2019, Matheus Tavares wrote:
> >
> >>[...]
> >> +/*
> >> + * Look for a recursive symlink at iter->base.path pointing to any directory on
> >> + * the previous stack levels. If it is found, return 1. If not, return 0.
> >> + */
> >> +static int find_recursive_symlinks(struct dir_iterator_int *iter)
> >> +{
> >> +    int i;
> >> +
> >> +    if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
> >> +        !S_ISDIR(iter->base.st.st_mode))
> >> +            return 0;
> >>
> >> +    for (i = 0; i < iter->levels_nr; ++i)
> >> +            if (iter->base.st.st_ino == iter->levels[i].ino)
> >
> > This does not work on Windows. [[ Windows port does not have
> > usable st_ino field ]]]
>
> And if you cross mountpoint, st_ino alone does not guarantee
> uniqueness; you'd need to combine it with st_dev, I would think,
> even on POSIX systems.

Ok, thanks for letting me know. I'm trying to think of another
approach to test for recursive symlinks that does not rely on inode:
Given any symlink, we could get its real_path() and compare it with
the path of the directory current being iterated. If the first is a
prefix of the second, than we mark it as a recursive symlink.

What do you think of this idea?
