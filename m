Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5014C1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeHCSOB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:14:01 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:39009 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeHCSOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:14:01 -0400
Received: by mail-it0-f52.google.com with SMTP id g141-v6so9100933ita.4
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EWbyAZl+kylyx7No+mBdI83gCkAmin7JdjCn1g9z2lc=;
        b=ZFxJYvjrZgXducDd0ynC4sLAaX+y936vHhh9g/jsDNLe0eTC2Vc0l+hC6fbg2WbTyF
         Hm9zcoZpwo/sX8h2MbSYsCBPxxjbM/GQ6Yt4XsiWii5qUBPxiM+LzUfYc3edRyl5Qkc9
         J+Uk3DGMlOKLjF3l2kDkhFdsgNWWwbg4raJQNAvNvv2CUoGGCBj6Rx4NyRi0N8VHQ4Yc
         qN9DEBSc/TCtsdZ+QRhStLpptju+LQtbT/7X0arVU6T8fE75/vzWXbNtkboLMq6IjQ74
         B5oqa3sDtDi9wvEzFx1PIXSYB6gagvFt1wVUB9eDxOwhvMJ9lKAI7+iELTE0pDOEIOK5
         8cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EWbyAZl+kylyx7No+mBdI83gCkAmin7JdjCn1g9z2lc=;
        b=Wl1yM0k/4RAmDlyrOM0jeu1kf4vyyN7RKNnremZwX3dZ2CXt3hQp58O0l9qFCAtPO2
         /u7ksAJumeZKbQDMWeqM/FtxjxOTcbMwzus0Kt906SPYIBgPif2y9Hqas6v1tDk+42zW
         8vjxcoEjzfX/DCPypaKUoVNVvhip7xCXgZ4/UKOdhVqrxS4MWMGAdyDD37KmXT8UO/4D
         O8wfbZ8/JF85XPgvC/YkDPbVDOgzhgwwkmkf16uBUcft1xu+Rks1OaQayW89mprlWIQs
         bPQr7Gz/ANfo8CondKYlURGSbIPuzonCBUaHM3mcmrkUjopV2c3r9X/xNt635STljR1l
         XYDg==
X-Gm-Message-State: AOUpUlEbYxW6lg+xiC4rS4E28i17r5tYo5Pbwxd+NRlikRtCQD/eezTd
        y/XnMnLAeWWhnDoVyMZSYrJ9jvibT2FYTBX5eP3ONg==
X-Google-Smtp-Source: AAOMgpc2iNuSasMhMF1xv5g86nK8nA2dMi8Y+ADjBa4W6q354y9zx6cWHcgK1j+H2+gZsg0zHj7u+IZ/BDoa1aGUpRg=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr7433269itf.78.1533313022544;
 Fri, 03 Aug 2018 09:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180630092031.29910-1-pclouds@gmail.com> <CACsJy8Am4bWKziBV6-J+c+Kz4u-rkotgZiorhvHOfy2K5cMBvg@mail.gmail.com>
In-Reply-To: <CACsJy8Am4bWKziBV6-J+c+Kz4u-rkotgZiorhvHOfy2K5cMBvg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 Aug 2018 18:16:36 +0200
Message-ID: <CACsJy8DnsTw6_Ohu+rZyqiBGV127dJ1Y4xGRbkRTaBchHtaQxQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Kill the_index part2, header file cleanup
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another friendly ping. I really need to know if I need to update (or
drop) this part before moving on to part 3.

On Sat, Jul 21, 2018 at 11:06 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Jun 30, 2018 at 11:20 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
> >
> > Like part 1 this is also boring. I wanted to drop these 'extern'
> > everywhere actually, so before I touched any header file in this
> > series, I did a clean up first. This is the result (and to reduce diff
> > noise later)
>
> Junio, part1 of the "kill the_index" series is dropped, but what about
> this one? I think it's still a good cleanup and it only slightly
> conflicts with 'pu'.
>
> >
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
> >   apply.h: drop extern on func declaration
> >   attr.h: drop extern from function declaration
> >   blame.h: drop extern on func declaration
> >   cache-tree.h: drop extern from function declaration
> >   convert.h: drop 'extern' from function declaration
> >   diffcore.h: drop extern from function declaration
> >   diff.h: remove extern from function declaration
> >   line-range.h: drop extern from function declaration
> >   rerere.h: drop extern from function declaration
> >   repository.h: drop extern from function declaration
> >   revision.h: drop extern from function declaration
> >   submodule.h: drop extern from function declaration
> >
> >  apply.h      |  23 +++++-----
> >  attr.h       |  24 +++++------
> >  blame.h      |  28 ++++++------
> >  cache-tree.h |   2 +-
> >  convert.h    |  56 ++++++++++++------------
> >  diff.h       | 120 +++++++++++++++++++++++++--------------------------
> >  diffcore.h   |  50 ++++++++++-----------
> >  line-range.h |  12 +++---
> >  repository.h |  25 +++++------
> >  rerere.h     |  14 +++---
> >  revision.h   |  69 ++++++++++++++---------------
> >  submodule.h  | 112 +++++++++++++++++++++++------------------------
> >  12 files changed, 269 insertions(+), 266 deletions(-)
> >
> > --
> > 2.18.0.rc2.476.g39500d3211
> >
>
>
> --
> Duy



--=20
Duy
