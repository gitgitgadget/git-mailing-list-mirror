Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C98211B5
	for <e@80x24.org>; Thu, 14 Feb 2019 09:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404318AbfBNJs3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 04:48:29 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39008 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389588AbfBNJs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 04:48:29 -0500
Received: by mail-ed1-f51.google.com with SMTP id b14so4469384edt.6
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCRb5ygJ6PDwW/f1a+KwLhpxIhxJS4t57G4izxD0tPQ=;
        b=TsDH3G9jh0OmCJCDFMrYrAklTe7Tqmv90l2a4Goml7EGCMBNn1g0U+jy0l9UVl7DZI
         umkteW6Ye4E7ZOyNbcBUQLZDU41F+Q5sLJ81MVEdGN3PFnT++67eo3NL06ER1Mc9y39w
         NSpzPS+Pg7qWhH8Mi72y0bnrOWw1KX7yUOuUgSV0qO5zmO9OH3cAWBdchpHHpfeyJkaA
         ohjnqHg+48CyYEMxME0cSdo7oeSq/geJ/TnK7zCyYoduQzOvwr35jC/wNm93GxuPBcEw
         miXoV51owXC7YxGviMkzxVSGU91N8EhSJJ3wMgjXbgv2yzF6OnUYyPZrTFHLHWOfSOm+
         908A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCRb5ygJ6PDwW/f1a+KwLhpxIhxJS4t57G4izxD0tPQ=;
        b=jZC2qK6fEfTvI9okN+kQqdou/A0h5qMUl8E2wd8tyvIZGdafeVluVNJ8ft7n+dEuTq
         Hi3ylR028IsnHjLhEXN/4chmMJ0OfJyoGAC4Reew5XaNQsjJ9TWI1bjyPyNY5ldU9D4m
         VPNWNnNdrzx4spw8/Y8j2AFD74VYjdOwpWeOBMiLY7MQ3eET0tFFsjalSjmNz2S1pJuv
         jpMN086pnatti+PxHef6vixnbyixPeAkKhc+WyZ7LGzI1pLBKsVwPE61tW2Stejl2szl
         w69OWxCcbqk2EwCzAf6KSr0I/Y6iaCjm3KmvjbMpZ4fW7rXUdvqKrTCYKa/tmbxAaHxg
         Q94A==
X-Gm-Message-State: AHQUAuZo3cdVK9UAT8VV6Ghse/aEKh+eIEoh3rljsG2sFkDHwc/q237y
        SWiqJJnN/uRwSIbCeeFxHghCZdi1+n7YXeqhcb4=
X-Google-Smtp-Source: AHgI3IYcrYGeD2vPIn9lZgOUzGvYgZAytfXmsJJJkS8xAZ0RyI+lsfviyo/eDfFCUrdS3PyLuWJa1Hp6pl7Vw4xzna4=
X-Received: by 2002:a17:906:4988:: with SMTP id p8mr2107318eju.75.1550137706941;
 Thu, 14 Feb 2019 01:48:26 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com> <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
 <CABPp-BGNMN0QZWa4E4kBFOs8RcUQoMuMT2J_zKhwOTQPbaGU4g@mail.gmail.com>
In-Reply-To: <CABPp-BGNMN0QZWa4E4kBFOs8RcUQoMuMT2J_zKhwOTQPbaGU4g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Feb 2019 10:48:14 +0100
Message-ID: <CAP8UFD3kOp0iAX_A8K9wAht5=Zxp6Rea1fsDt8inG9ZpT-TWdw@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 11:37 PM Elijah Newren <newren@gmail.com> wrote:
>
> I'm a little hesitant to suggest this as I'm not sure how available I
> could be for mentoring and don't view myself as a good mentor, but
> another project idea which has lots of sub-pieces and thus could show
> progress and be useful even if not everything is completed:
>
> Consistency of sequencer commands:
...

Thanks! I like this idea, as it indeed consists in multiple tasks that
could be worked on independently.

Also 2 previous GSoC students already worked on the sequencer (in 2008
and 2010 IIRC), and I think Alban has been working on it too, so it
would be nice if another one worked on completing that work.

I added it to the Idea page.
