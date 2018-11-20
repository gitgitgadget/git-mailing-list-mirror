Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347C81F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeKTTum (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 14:50:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32868 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeKTTum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 14:50:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so4546031wmo.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4B6R1SKQXm10t4tSAMLAD5/a0173PGsRxO+oylnyLuw=;
        b=EbrR3isdx9WL46/c7lW5n9P3teLeZoANkfTN0ZOxeYNEt2twrN19f29CbzDAYsJFUx
         PiZ9lA21ndO6G2KCh2UjdjRU0vAxmZLerBv/haqxC7nI8SECdvEdf+cKpHAxKiOa+wx5
         +THi4vS5HoBRCvuSmqo4CZCHdWPZar0XgC/zapwLWT2mD8linphZJ5YYzNzfbMwVsGg1
         EpfVPjoRrjrnH/7OwUjQPkWaXA7kXI6OkB9NaEv5HBcE1XGso+fkWbRsjsOe7uEFkjg0
         QhRvXw3oUNwW6UEn6qspqSrFeSTpjG/q1MBnHvI+0JwpjBzqpr6xIMN6M+/LB6MHeizt
         K9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4B6R1SKQXm10t4tSAMLAD5/a0173PGsRxO+oylnyLuw=;
        b=M4ijOy8t+SgmQmFbPdbp+vDaknQqlHls18srNibdEtyo5aULPeQjTV3KT484ZMESAe
         6OTEZQApkUeSq7b1yvRvGNHhCedj1AMTGKiHJH5D0StHSywvTfiTLyi6qbgJd7RXPJb5
         AwyM11IHLvbBMhUizx+4sdYrTH6beuiSGRMgeM8LLgiWRre3tq/bFWqpaJ8rQem8Wc3Z
         WfC4wkX+IlTdn6n6HjpLLzf+pTEOmQbddReW6csXhlDzoBFFQLd3JBt3nylUgF1aaZor
         +vjfwqG7ue/yUZ5YqM/DhTjUXIAQSqUW/Un8VAApNJ+9DGB6T6OgMgZpm70Sze+L6JZm
         MPiA==
X-Gm-Message-State: AGRZ1gIuNNEcIoECTangs/RwFiBn1RHglJNu6cmGsyw5VhXPKZTBTVpw
        Kc+Bj8my84TnC+oW77VY/CCvbwafzFtMj1LarPU=
X-Google-Smtp-Source: AFSGD/UY6tSfMFGwMMi/bdkbsgNOummmSPyPOrPaYr/LvsUvZuesOOE+iPj/Aqbe6MpwtTff57JFbstgkooXliopbCI=
X-Received: by 2002:a1c:702:: with SMTP id 2-v6mr1423891wmh.113.1542705753069;
 Tue, 20 Nov 2018 01:22:33 -0800 (PST)
MIME-Version: 1.0
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
 <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
 <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
 <20181112131247.GL3956@sigill.intra.peff.net> <xmqqwophyc9s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwophyc9s.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 20 Nov 2018 12:17:59 +0300
Message-ID: <CAL21BmmK_ZS=wuGXRLj=s0=dqMvUWFiLLBZWx5ymnFjyasX=sA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 04:52, Junio=
 C Hamano <gitster@pobox.com>:
>
> Jeff King <peff@peff.net> writes:
>
> >> You mean something like
> >>
> >>                      v->s =3D xstrfmt("%"PRIdMAX, (intmax_t)oi->disk_s=
ize);
> >
> > I think elsewhere we simply use PRIuMAX for printing large sizes via
> > off_t; we know this value isn't going to be negative.
> >
> > I'm not opposed to PRIdMAX, which _is_ more accurate, but...
> >
> >> P.S.: I wondered whether we have precedent for PRIdMAX, as we used to =
use
> >> only PRIuMAX, but yes: JeffH's json-writer uses PRIdMAX.
> >
> > That's pretty recent. I won't be surprised if we have to do some
> > preprocessor trickery to handle that at some point. We have a PRIuMAX
> > fallback already. That comes from c4001d92be (Use off_t when we really
> > mean a file offset., 2007-03-06), but it's not clear to me if that was
> > motivated by a real platform or an over-abundance of caution.
> >
> > I'm OK with just using PRIdMAX as appropriate for now. It will serve as
> > a weather-balloon, and we can #define our way out of it later if need
> > be.
>
> I am OK if we avoid PRIdMAX and use PRIuMAX instead with a cast to
> the corresponding size in this codepath, as long as we properly
> handle negative oi.disk_size field, which may be telling some
> "unusual" condition to us.

Maybe we want to change the type (from off_t to unsigned) directly in
struct object_info? That will help us not to make additional
checkings. Or, at least, I suggest to add check to
oid_object_info_extended() so that this function will give a guarantee
that the size is non-negative. That will make code cleaner (otherwise
we need to add checks everywhere after oid_object_info_extended()
usage).

Please, look at this one also [1]. Thanks a lot!

[1] https://public-inbox.org/git/CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=3DfbY3jGu=
mRcSJ=3DBc_pQ@mail.gmail.com/

>
>
