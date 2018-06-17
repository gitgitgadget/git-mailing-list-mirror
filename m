Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E49C1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 08:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbeFQItk (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 04:49:40 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33628 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeFQItj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 04:49:39 -0400
Received: by mail-ot0-f194.google.com with SMTP id h6-v6so15434960otj.0
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fCG3TS+0vaLTdFj+azHRP8tw5IVSSbNJ4EIpxZoKDlg=;
        b=AlMVZF04aByqYSGaUyKVSlq1AwL1yuH36W5HX6Jj2VuVPS1YxQhSzFxzsrMOAzmVF+
         vmMlguqMybS7Wzs4vfA/sZUlnbxmSm5pFZAv+EQh+LXHgFPlnnlZHopRzLG92/BucGYw
         aT/9GMxtI0VbGViqUUJD3VZd51EzlM3doe6DONfWArVU0QZYRr0Hv/UVsA4ttABIN6sn
         gf/38+PnNpjo9kApDSyC1eCaFixvs6VJ3w1L6N8Sg1TbeqHzrIoRHPUGIMIh1q1o6KL1
         sL6C8tn5SlDKv9zBKF0gqmc6UvUMXNIO/6PXz44m0dnpuqlhOF+cq0yW/F3JNoM31GAn
         I9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fCG3TS+0vaLTdFj+azHRP8tw5IVSSbNJ4EIpxZoKDlg=;
        b=hsGRZb1fs4ZKOQNlojOCN/LY93Zxmp5kqP/SLb6XREcNMawh7aKeaTtkTqkWxzsX5G
         8T0uAFj/mdGFbnP3V2WE9nvkamqTNlAK5oPH5QllAPkQiM40YRNX3Yp60nVId0JUmyVT
         AHnaiCveY4iITJVBvm5hyYgK5+JSHi1yhSw9GYT+oKIyxXuix8oInWCIGPemzzER7rV3
         1B4OqyIdMgV9kWqJ2SF6MwyFcCNkhCmtfzgEGNnzY8Iu5is5wo4B3j/O/CkjIlC8bTzY
         V9gKxwWFfUCcdHAvOyyZfwZNF0mGE+nlBkn2UitbP2D4hhIq77JtQsImM6Xi6Ejtpl5G
         xgCQ==
X-Gm-Message-State: APt69E3Qffp+VrP/8qTrQA/B8Lu1GjB3eU4QLqKBklV4jmo+GpaVNGMM
        KaAzHrcF2DT5jGC/ykXIn0KoypOUVHBAyOVguPo=
X-Google-Smtp-Source: ADUXVKKA4dhVsjRSEXzs8zS1qUSR1zrN/fHyo91HlEQgwxLiiIfncYwCnWg0rtsELjsZAS87q6eja72unluvw1leEps=
X-Received: by 2002:a9d:32e1:: with SMTP id u88-v6mr5331634otb.173.1529225378701;
 Sun, 17 Jun 2018 01:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180616054157.32433-1-pclouds@gmail.com> <CABPp-BG1n4u78JScxrnUc1gecXFjKbwLWMxKKs+ZO17DdH3zvg@mail.gmail.com>
In-Reply-To: <CABPp-BG1n4u78JScxrnUc1gecXFjKbwLWMxKKs+ZO17DdH3zvg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 17 Jun 2018 10:49:12 +0200
Message-ID: <CACsJy8Bib-CFxUs5YBzcgo7LPDospdgSAn+-asCf-YrYnUxqXA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Kill the_index part 1, expose it
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 17, 2018 at 9:02 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Jun 15, 2018 at 10:41 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
> > This is the beginning of the end of the_index. The problem with
> > the_index is it lets library code anywhere access it freely. This is
> > not good because from high level you may not realize that the_index is
> > being used while you don't want to touch index at all, or you want to
> > use a different index instead.
> >
> > This is a long series, 86 patches [1], so I'm going to split and
> > submit it in 15-20 patches at a time. The first two parts are trivial
> > though and could be safely fast tracked if needed.
>
> You post this small little patch about unpack-trees.c, mentioning you
> don't know if it's even correct, and bait me into reviewing it and
> then spring on me that it's actually nearly 100 patches that need
> review...   Very sneaky.  ;-)

To be fair, it's all Brandon's fault. If he didn't kick the_index out
of dir.c, it would not conflict with one of my out-of-tree patches in
unpack-trees.c, catch my attention and make me go down this rabbit
hole :D
--=20
Duy
