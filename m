Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F0E1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 14:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFBOdA (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 10:33:00 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:40988 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBOdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 10:33:00 -0400
Received: by mail-qk1-f173.google.com with SMTP id c11so2920980qkk.8
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NNyB9uLtVHKEHNbBnxAAJwHDxp0Iml5mpkW1HLrjXJs=;
        b=TBdHocImd2xZRI0fGhHgOlg8GWgdd8DItoffXZ0rYg2sS/aoKvSURqvCZ9zFAOMTiy
         cFp6H5pIoyO4zgsW+S0fIgoh1lR+nw8GoJn2ZL4uxHri8W0MpRRm3NyziVTqf//maLLm
         rIxnkuNGm9TgGUogCZNQC7947oOSXCAzLSUDE3OL2FR0pePjjdkkql6gxy1K2fzP0k3G
         1R5pxqSGarh/8I4KMFzeLJkmOy4eK1mDtO4gbLf98fp6r66h8b4l2Oe7Fh0mrYdYJsG6
         QDT6SV3D94Q9N68wOmQjKstY62QEsqWPsg8PCVADx1xEuzVChlNBZZllNl/R+N4A8z7D
         cyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NNyB9uLtVHKEHNbBnxAAJwHDxp0Iml5mpkW1HLrjXJs=;
        b=cfT7nl+7/LzYbHUKVNqKzpNdw3LrYvt0NL1MGAJC/91vuQ2HbOaDykBbn/yu4r0cii
         1PGWMhots+iRn0RP21hY4F3f8QxywhDSx14MPjH8I5xVXyLVthh+rWp+50C7jnmkCh16
         azWh73MIeZCM2b8e6NcPmz48+X4o8EKJx34aYbsdjSHadvcmxLlPuVAQ+qhTNrC879xM
         GM+SYfle76UWRA8shpXDNCYJgaHmbvmQUESOZSTFuEOL6GgWsT0/zI5nqXwsobvN15RQ
         Sx5alaProsl4MkMuU29xZ7qpAavnr4XGbs/2o5pae/nJ8wH93ATCTQvP06+cSp/TCnzM
         DDDw==
X-Gm-Message-State: APjAAAVrht5FFrG1RdChbFIcZLs1BOT/llv4OPqfruYJrni/d2rZYhub
        sAX/KJGBBJVjT/Y7ntCLrbOwvQuutt5P5YLze+w=
X-Google-Smtp-Source: APXvYqyvRJgjjiw25FGNEtBPK3n46JQTTUc70J7vETqa4DVz55TtPmL390O+SPK/vmEdxQBeWbAoapZQpBqJL63zQkY=
X-Received: by 2002:a37:aac5:: with SMTP id t188mr17796408qke.157.1559485979307;
 Sun, 02 Jun 2019 07:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet>
 <xmqqwoi6v4ei.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905312224020.1775@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905312224020.1775@tvgsbejvaqbjf.bet>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 2 Jun 2019 22:32:44 +0800
Message-ID: <CANYiYbEYcZu3hOXdvFXo-hZo-=vZobYX-M-0dGMmp4TKM3p3nA@mail.gmail.com>
Subject: Re: cc/list-objects-filter-wo-sparse-path, was Re: What's cooking in
 git.git (May 2019, #05; Thu, 30)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2019=E5=B9=B46=E6=
=9C=881=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:26=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi Junio,
>
> On Fri, 31 May 2019, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >> * cc/list-objects-filter-wo-sparse-path (2019-05-29) 1 commit
> > >>   (merged to 'next' on 2019-05-30 at 5a294203ad)
> > >>  + list-objects-filter: disable 'sparse:path' filters
> > >>
> > >>  Disable "--filter=3Dsparse:path=3D<path>" that would allow reading =
from
> > >>  paths on the filesystem.
> > >>
> > >>  Will cook in 'next'.
> > >
> > > Not sure whether we want to fast-track this into v2.22.0. There is a =
risk.
> > >
> > > But then, the longer we ship with `--filter=3Dsparse:path` *enabled*,=
 the
> > > more we invite users to actually try and use it.
> >
> > This one I wasn't quite decided on, for exactly the same reason why
> > you said "Not sure".  I am inclined to merge it to 'master' at this
> > point, as it indeed is a risk to keep it enabled.
> >
> > The only remaining question it raises is if it makes it worthwhile
> > to add another rc; it introduces one new localizable string, too.
>
> That'd be more a question to the L10N coordinator (who you Cc:ed)... Jian=
g
> Lin? Would that require another -rc?

Current l10n round 2 is based on v2.22.0-rc2, and only 5 days left for the
final release. If merge the topic "cc/list-objects-filter-wo-sparse-path" t=
o
master, a -rc3 is needed for the new message introduced:

    +#: list-objects-filter-options.c:84
    +msgid "sparse:path filters support has been dropped"
    +msgstr ""

--
Jiang Xin
