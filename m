Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291DE1F453
	for <e@80x24.org>; Thu,  2 May 2019 00:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBAfg (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 20:35:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39404 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBAff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 20:35:35 -0400
Received: by mail-io1-f68.google.com with SMTP id c3so549975iok.6
        for <git@vger.kernel.org>; Wed, 01 May 2019 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cjfrpyXtPzR5UNGQ6PsNxIsOHa6YqB+2KZPCA9LiWGM=;
        b=sOaqhjzNwrsTIBD99WrFgtDcQ8pKlZOxWpZk3SgofyJlY5GsIwgSam7rOAsb/pf5vr
         mximoLIcOEkWXGjQ2C5Jk9Ren8Y45Hj2HTGF9hCBclFzeVEtgAEc7N+Cr3kIfVxSDgpr
         QmzzwEqsUyIRYVVodnr3c8ybRVXL8ghZvCkVKcZS8e+8pDjGagQKd//LLpFlHz7nng6S
         dZp+j8FAgfbfGqh8Ck+ZR0S6h8AvcjmqppChlsUgKTVvyxsR1M4kxwXeb4q3emDWebKs
         xfVS9FOh1cBkQeeUqg1Y52xjz4Mno+SAFneYfFrZtPP7hwApgnJWSClYJw/Bx8jo+Jvr
         XK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=cjfrpyXtPzR5UNGQ6PsNxIsOHa6YqB+2KZPCA9LiWGM=;
        b=OAAqUFO2wEG5fDhb/fETuqpaICC0UITLsZFBNQoCVLd8ujsAmBWeLzqFGYv1bJZnKD
         Btd7Nx+z16p4RR1/Fe3vDDftivGZBMqwJN3iLZnYY+qvu5NKBx7HQq+42Luy4XnmaOJS
         t9onUYgR/dVS+cxDzZ+UtJ5nAOfTzbfivNEiSu6EsD4Ur5JTn+sVOMPDIK6r2vPO2Fjj
         Ail+beX/8ny5+tX1w2mfaLxjVRi8INTazxJ5P1rb10SpNqudTRam5HeuytEjDmXrEhmq
         mwg9EnmHwQgOk6Z/YDg9+3dqmheoHWBCjRtl+w4c3ukYPfKebMN/Q9kjEbOiVNdeYq5m
         gajg==
X-Gm-Message-State: APjAAAWx71yWeiXiDQDNSo0SgrsKwovbC+R4I9ZZ2+PQlo+ksfoIzioX
        NJEQ3uKtQfHBblpb1H1wG3DUOSEYVSrMZXG1mu0=
X-Google-Smtp-Source: APXvYqz26q2mW/CdK09f8nYy467wsLANDTC8R0FNt8E8g51amlsxowpXwXHD6EXKB2UE81F82YnBKKxjgF8eIBFZhzU=
X-Received: by 2002:a5d:8795:: with SMTP id f21mr581215ion.20.1556757334757;
 Wed, 01 May 2019 17:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net>
In-Reply-To: <20190501234512.GD202237@genre.crustytoothpaste.net>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Thu, 2 May 2019 08:35:23 +0800
Message-ID: <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, John Lin <johnlinp@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

brian m. carlson <sandals@crustytoothpaste.net> =E6=96=BC 2019=E5=B9=B45=E6=
=9C=882=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:45=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Tue, Apr 30, 2019 at 12:15:37PM +0100, Phillip Wood wrote:
> > Hi John
> >
> > On 30/04/2019 07:02, John Lin wrote:
> > > When typing "git status", there is an empty line between
> > > the "Changes not staged for commit:" block and the list
> > > of changed files.
> >
> > I'm a bit confused by this as you change a status test below by inserti=
ng
> > these blank lines into the expected output, implying they are not there=
 now.
> > I think maybe the blank line is only shown when status prints advice.
> >
> > > However, when typing "git commit" with
> > > no files added, there are no empty lines between them.
> >
> > I have to say looking at the changes to the output I prefer the origina=
l,
> > the lists are nicely indented so there is no need for a blank line to
> > separate the header from the list and having the header immediately bef=
ore
> > the list means the blank line at the end of the block makes the extent =
of
> > the block clear. It also saves screen space which is useful for small l=
aptop
> > screens. I can see why one might want a blank line to separate the advi=
ce
> > and list of changes (though even there the indention of the list and ad=
vice
> > is different) but for a one line header I think it is better to start t=
he
> > list on the next line.
>
> I actually was going to submit an equivalent patch eventually. The
> inconsistency between status and commit is bothersome to me and I think
> that adding the whitespace improves readability.
>
> I'd love to see this picked up.

Thank you for the support! I'll be very happy if my patch can get into
the code base. Is there any improvement I can make for this patch?

Best,
John Lin

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
