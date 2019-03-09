Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EB620248
	for <e@80x24.org>; Sat,  9 Mar 2019 11:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCIL4t (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 06:56:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40341 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfCIL4t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 06:56:49 -0500
Received: by mail-it1-f193.google.com with SMTP id l139so335867ita.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 03:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HMhRsV5q6l5V8VaVFBwzowRtv5MFjfPUqhacxG/hvz0=;
        b=q+zdI5kPPAphhO4ypgUH9xd+jfAMSw4bpfbAHUVG+h0r9xhe+KzlGdZxG+c978rofV
         AmaEzgMs3+YN0ujFFIjd9xpFOhnNbjAXP40/pvTbN7j8f2Yp/C3uAsi7yXKQwMrPgUlc
         iKA6vdzSi9cuU85J7Y7bb+qafHBQkd/VFo1oUNd7GnJ/cVTHnRoPIpW+G24gXNc9IYBi
         L61EvUh9f9qm4snFCUoHAeQUT0W1TdSxTelu66bA0WTM2j8+FPj7wCd8KnyxxQMO0dSt
         egErlyZsf9iKyUQgvm948l249ZBEfwyZGgETdFnkMzNWTymnqTGJCgWVlLbsOJSaIgnY
         WANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HMhRsV5q6l5V8VaVFBwzowRtv5MFjfPUqhacxG/hvz0=;
        b=pAe+Kq3Df3zWjZSC4/sXraIz2zhR1Nmbk6h9xAT7Bi9wlqopq3e3LDp/Fla7gbdsGx
         3NXiSm+IyRyQDIfjU/nWfklPT9XIt1n20l/wi53PWxpk4vIeJQQs8ZzVF7KrPbvumZrY
         aA+YTlGxt+XfAYnP6TGRwIn7Q66TBdSCmiOnDAsSiD2+GOFgcuusknEdsC5cH3gl7UTR
         1g+bvCQbKx00F1VCpAuAgwHqgjsgZGw4uR20bSOsT3AouxLW6ef38EmVoikX94AgmIM7
         dRVh5qdbqxLB2sYM0dM9XoID1MY/R2byjZBSTMkJRyNEBvWA4IKYG/jDVm1VjEaw/SRH
         UdHQ==
X-Gm-Message-State: APjAAAWMkEvo7W3TspAMhd+H04wwh1817W9CqKg6ATZPi+CgVgpj0wt7
        Jsm2ZnDf5sykJExAiKBoxwTIBEg92A8umY7iZLg=
X-Google-Smtp-Source: APXvYqySIWid+afIz3YGTjZhcWEXMlZgG0q6cQgfK5GVfgRxGq8EcC71gd/C5WPRFuQkaq0JJwebKmtcPCPUsz+dFQk=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr9433578ita.10.1552132608229;
 Sat, 09 Mar 2019 03:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <d0f69dda-f677-45b8-f70e-971df27ce224@ramsayjones.plus.com>
In-Reply-To: <d0f69dda-f677-45b8-f70e-971df27ce224@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Mar 2019 18:56:21 +0700
Message-ID: <CACsJy8CuTCOjeOJ0B9Q+xR5LcSY_mwns1gwtApk0TDUm5YZEtQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] Add new command "switch"
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 9, 2019 at 12:49 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
>
> On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> [snip]
> > Range-diff d=E1=BB=B1a tr=C3=AAn v2:
> >  -:  ---------- >  1:  949f3dd4fd git-checkout.txt: spell out --no-opti=
on
> >  1:  8358b9ca36 =3D  2:  1ddbbae3e2 git-checkout.txt: fix one syntax li=
ne
> >  2:  1686ccbf8d !  3:  b0cb2372db doc: document --overwrite-ignore
> >     @@ -14,14 +14,15 @@
> >               out anyway. In other words, the ref can be held by more t=
han one
> >               worktree.
> >
> >     -+--[no-]overwrite-ignore::
> >     ++--overwrite-ignore::
> >     ++--no-overwrite-ignore::
>
> Just curious, but why? Is '--[no-]overwrite-ignore' thought to
> be harder to read? What about the rest of the man-pages?

It's also easier to search. If I remember correctly I did search for
the rest of man pages and the --no- wins over --[no-]
--=20
Duy
