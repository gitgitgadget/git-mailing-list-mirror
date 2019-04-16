Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA2D20248
	for <e@80x24.org>; Tue, 16 Apr 2019 08:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfDPIxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 04:53:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53788 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfDPIxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 04:53:12 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so31750622itf.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RVBAqc1VGwCuDSaR/AHARCNBXsWDtceJfNZRqXpBM9w=;
        b=KfJXIo4tvTC0PKkxotHf+trtu/mNL7mHkmUJPKmAAqNgwxFvz/x4fSX2W2vxvNjl+0
         gR5hmy+xwj7lTDX0r2hoWH5b40HwO/G0tiq+CFDzcXXBg2/eGhlIWSHC/m9E5R1jZVx7
         jqrQZ/kjmpwVVcBXRQ/a1wt05S9KM56k/T9mCiaCxt6nDeMIH0OkpcSR98AHBqZdX4s+
         nLypm0vXhv/l/JJBwa3ORZ4oYVdMgOIn+5jNTt6i7E0nz1Da1XIQJq2M8e8nrv9XtACw
         p6PNL2dDbDCAkDNBIqKIdh2wnXBqNDmJXg39dxsEERDWXjTIBGa3q4sT43YMDwQx5a5Z
         RSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RVBAqc1VGwCuDSaR/AHARCNBXsWDtceJfNZRqXpBM9w=;
        b=R9Lknp8cDyVWwQ3wKXMthY9R/YU3Sgr+43NraO50O7xXIp4qsEsYCNxEO5GHatG8pY
         fWkea48JJoRWM4tpxLonUTZLVo20jCjyRSrm/8lXGVm41SYTd/EpQc2p1tAAJrlzc3Ok
         sc4Ta5WXIgGe/I6ruzGH4yssfxuZruR2Tt46tOv95yhvHsRlCGiJtGCQZ0DJKALsqh4n
         5robVi/zagIHM4KNRWVzzoOhfdi72BgNVoyfFuD36d+u6j1rqoDHWBXVb1MNYRCqX2AL
         GoxYwDaSgGmTGNnn/vlLbc+cbudVXUQOzDD55NhVKeQMRXZPJP0BaqJxR9wdbEJsRe2P
         3JIA==
X-Gm-Message-State: APjAAAXv0pUxWxeiw0fA6Sve68386ZocX5x4U4ce4y/LE44o99w/QHNX
        Cm3v7HLmowJZvWM034w8CIeMENzy8m7vjC6x3BY=
X-Google-Smtp-Source: APXvYqwftT2kn35gWpY2Vq4NdqBLaE3MdzBsrX/PGoCiWY1ByaIlD0sqQHSZuhDlrH2n0r4LXZonEusMmeoT0ugqHqU=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr26262604itb.107.1555404791484;
 Tue, 16 Apr 2019 01:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190127003535.28341-1-pclouds@gmail.com> <20190127003535.28341-8-pclouds@gmail.com>
 <02d2a828-b191-9d9a-7422-d76cdca69ef1@gmail.com>
In-Reply-To: <02d2a828-b191-9d9a-7422-d76cdca69ef1@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Apr 2019 15:52:45 +0700
Message-ID: <CACsJy8DDKuK5VYhh0GNYSJK1_y3MZgK5Vcq99N4jYcusVFnvQQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] parse-options: allow ll_callback with OPTION_CALLBACK
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 9:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/26/2019 7:35 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > @@ -238,7 +249,10 @@ static enum parse_opt_result parse_short_opt(struc=
t parse_opt_ctx_t *p,
> >                       len++;
> >               arg =3D xmemdupz(p->opt, len);
> >               p->opt =3D p->opt[len] ? p->opt + len : NULL;
> > -             rc =3D (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
> > +             if (numopt->callback)
> > +                     rc =3D (*numopt->callback)(numopt, arg, 0) ? (-1)=
 : 0;
> > +             else
> > +                     rc =3D (*numopt->ll_callback)(p, numopt, arg, 0);
> >               free(arg);
> >               return rc;
> >       }
>
> Hi Duy,
>
> This "else" condition is unreachable. This block is only hit when we have=
 a "-<n>"
> option, using OPT_NUMBER_CALLBACK, which is implemented by filling "callb=
ack", never
> "ll_callback".

It does not mean ll_callback cannot be used in the future though. We
have three options

1. drop the else clause
2. replace with "else BUG();"
3. implement proper else clause

Option #1 to me sounds wrong. If you don't support something, yell up.
Silently ignoring it only makes it harder to track down to this
unsupported location when it becomes reachable, however unlikely that
is.

Which leaves options #2 and #3. If you think this one line is risky
enough, I'll send a patch to replace it with BUG().

> I recommend reverting this diff segment, but please let me know if I'm mi=
ssing something.
>
> Thanks,
> -Stolee



--=20
Duy
