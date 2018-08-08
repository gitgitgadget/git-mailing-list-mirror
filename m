Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B194B208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeHHPcd (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 11:32:33 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51133 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHHPcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 11:32:33 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so3357152ite.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OZXMojfCCRMbtsStRPMz8W6KE8sPPpZ04kzz6l3o5bY=;
        b=oKgRuhrOf6ANytI4IDsqDw/loHzjyUv5jZBw6GFLZXwjK27ViU1pmzoV3+PHN1lE9G
         qTpNdL3aQj6IwOL16lfilg+bF2iykkJdyvdUjFC+j2V50tcDRmO2c2ydTCOTvT5YQlie
         gtjF5dWMvlBzcn7ALB7g/wAWULH0mufQyLoWtqur5vFCQyZwQdMYfinNzMyRRFisOlq0
         mswI1N7F/wSL5H+nAjPDjTTVvQ4/WDHJ7XIhZwkc8yz+zbCHVgiHX9mOx/ustJ+p0Vj8
         PQtj6trC3vkN7t8sATTsK65LH46IGTRNXWo/3JHEF+HXt7L8vuizWzUSL0tpj0UyhVdZ
         8X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OZXMojfCCRMbtsStRPMz8W6KE8sPPpZ04kzz6l3o5bY=;
        b=LCDMHeSUI+2RJkW11jfQK8VrTfxp4MccgjyMia3Gka/M+H1Z4ncr79B7Ok19JOKKEX
         ym2nUQyiEYizqooRJPoL9eeOWmL1WBnme90XGDwM1BbhkHSRw7zOcGTCgcI93qvy8fWO
         tjeyWMG0VuehKw4QKQ982b4Sf912udo9JebGqNQd965pcuUBMD9rdarlDJtHBFUv4Vgm
         4+WNIN2Kwu3xX2obLEfXoEYhwEDG5aHMMe71eF2JLvJdCYPk1ZA07fKYbigyHTccWAg8
         4M2uMbk7E7F/7Gyx66cl/wzAKawri5c4buly2p8ciMI+LGA1WD0Jil6+9Lzq0C5XZP5M
         GKog==
X-Gm-Message-State: AOUpUlEhFrUp/ZODcuBL8MsXt+dKFYAHUPpfQG/LZmvl7PoOJcR/a+nE
        rAXn9+aCFm2HX7tC4mfG1KhtLB9lhqGYAA1v8GfUrA==
X-Google-Smtp-Source: AA+uWPwiSEBoSCHHv+k800Thg2nNjbtb1bLH0VeyQqX7FxTfkgQLRA83p2U1uL/7AwvGWyUNugXLaaulKu0DyUvTga4=
X-Received: by 2002:a02:238f:: with SMTP id u137-v6mr2434349jau.0.1533733975200;
 Wed, 08 Aug 2018 06:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180807125108.104293-1-hanwen@google.com> <xmqqva8lki14.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva8lki14.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Aug 2018 15:12:43 +0200
Message-ID: <CAFQ2z_OiwVqxawfuVWurqCwpA8beC7Vn89tkhZkLkYcrApacEQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/1] sideband: highlight keywords in remote sideband output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrn@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 11:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > Fix nits; remove debug printf.
> >
> > Han-Wen Nienhuys (1):
> >   sideband: highlight keywords in remote sideband output
> >
> >  Documentation/config.txt            |  12 +++
> >  help.c                              |   1 +
> >  help.h                              |   1 +
> >  sideband.c                          | 125 ++++++++++++++++++++++++++--
> >  t/t5409-colorize-remote-messages.sh |  87 +++++++++++++++++++
> >  5 files changed, 217 insertions(+), 9 deletions(-)
> >  create mode 100755 t/t5409-colorize-remote-messages.sh
> >
> > --
> > 2.18.0.597.ga71716f1ad-goog
>
> I'll squash in the following while queuing for
>
>     <CAPig+cScb_7s4a_ZSVCsr+nBxAHGHZVMZOtnrOgbhZUi96-VFA@mail.gmail.com>
>
> Thanks for sticking to the topic.

Thanks, LGTM.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
