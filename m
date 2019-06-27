Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB43C1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfF0JVS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:21:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45891 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:21:18 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so3137638ioc.12
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oc+VU3poGMUmz8XjZSRULDH4xvxdgnciMrX/IyKmwlU=;
        b=QxNbyFXtsTXpsSoTumFf0XYk37PrHqF89c9+7bQfLHHdIHJjx+2PShsXcbqhx08kce
         SXmPbUZpe3VrtgQ18oaSIfV95UAnxhU2YTDQEBn8SHzxd7J2CSWZ68qNm73ai4mkBbD5
         IbMYyBVFi6H2aY4pcbjg2wwFkxAgMmQTc4KANaOGbG5JFnnq35cZToqtrlqhBBOnymg7
         sdaM3Y8+lqQGdJQCY/UXEzIQQzYti2KmD8qyzN8jiYmyfj7SzNAT3IaN5XfeP4lZ7E5t
         bw/IQQ+7QG0Mf+kLMw1i7EqAx9FXlMab2zbbnygGl663DxJh3CX3iIlS0bURkodfff6y
         fCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oc+VU3poGMUmz8XjZSRULDH4xvxdgnciMrX/IyKmwlU=;
        b=jQu6aMFoikIuo189fJ9GREUaAQToFmDVxh9I1RSKGxxiRtJwOwcf1NoPY7PCd5EqEa
         YuwoUAVw1gbH2LnLiV3WMNatULfNfAPBN3f1ddyziJt3BuHVLuxf0zsk5vjwpsrX2kOD
         9Utm2igSc/FrtNzZlVX5jCNO6B9VyX8ra+i9HG8qe6ddBGuu1L4jBWihx+bmzTSKPFIa
         pYVQLJBUTo+3InOXTU0XnRVlbpWLUUetiqxOf2CSgbDk7P8g9RRK1yjhD+FFLT76w40i
         ADD3isFVN1EjOypPpKwPe2G90id22YtPLOcdsMSGJ+kyjbk6uTrLzLiK0R+/QE4mPj73
         mjxA==
X-Gm-Message-State: APjAAAXKUZtWSlLQQt3hYM8ZrUCCbT7GNuhfVRS5UeEBVLvskZ5hA0hS
        MtohP3IsXQuJCRX44Fo0hOGxSmGIVu5gbZaYePo=
X-Google-Smtp-Source: APXvYqyAji8keeZ+rEdxQ8RW6HT7DDBDkR4DPcY+IKw4InvM5NhrstEWUSEWw2ebhC8txMV1mYBJtjMy7FWyCYOwBFM=
X-Received: by 2002:a02:5a89:: with SMTP id v131mr3468330jaa.130.1561627277713;
 Thu, 27 Jun 2019 02:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 16:20:51 +0700
Message-ID: <CACsJy8BHWvbL_rPuRN-=Q4sDL+wkJUNAoPhdjcrs+VqY5-Kr5w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 1:04 AM Junio C Hamano <gitster@pobox.com> wrote:
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

which should be protected by USE_STDEV. There's another code that
ignore st_ino on Windows in entry.c. Maybe it's time to define
USE_STINO instead of spreading "#if GIT_WINDOWS_NATIVE" more.
-- 
Duy
