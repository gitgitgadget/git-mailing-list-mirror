Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63981F403
	for <e@80x24.org>; Sat,  9 Jun 2018 18:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeFISqF (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 14:46:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38596 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933150AbeFISqE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 14:46:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id d5-v6so14634934oib.5
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q5doa5BCZZ7GH4gFdAzV4kbuTSA3n29/LTI6aEuTweM=;
        b=A6E6AEMeudyFq2eSTxtZEdg/WMHh4+nmXtC45jDW9mCapNkyzhYcD0khfBFvTXiWCu
         xF27CMzrqeBuv+9RrH6pgIy6/2aQ/BgqRCSxlaqCh2BoY6nNtBs7+EfyhoRshjqqzb8g
         HJIgXeEXNQxz8X7NTc34w3SFOganY7pYga/OL9n6NieLSS5kUQGivLE6OqSIVce9TJoa
         S94i9Oz7M46obstgVHfHNbPDd2KCA5C+f7mno8t2yFRWIO25VXaKur3I0+5RQHikHDMY
         t3gaH1bQq9GIDGk6buV65nomIcb69NGgVla9stLl63LPpdPix51/821aETrxEwyN5OlG
         et3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q5doa5BCZZ7GH4gFdAzV4kbuTSA3n29/LTI6aEuTweM=;
        b=WXTIyjgi1jy7i3KYgf8hgw0+nihoU8qD/cehI2j7rJwcCyrB7VJKQna/1qRJCJiIcF
         obn/FvjibwpH4nMW0IeLi/wkbe3QfU1Nmn4WtSbwbXeT2+UgVASn3VdTCPcGs9w7Zhe7
         I6iQfN8LfCl82WoqYGIHhAaTrjQR0j1fnaHT7Jsc7KpRzgYToeaF7CNRkg37u5jFaJNO
         Qz31tHU7S/nb6Q/Mi9FkUrO7pBMF1O5cAWNfULOa/quOTMQ5TE0bwh576OgZVxzQvymX
         PwwLXL1y1B6LIbnwRdJLUH6LU6h2AIktk6a4kvultxF2u6kmCde6S1t5+EQryz1sohY4
         69Cg==
X-Gm-Message-State: APt69E3+NPx1eAririAdwcGWDDqrWGR1pSvUBEql5zjmcMnPE0gi60kj
        j5zaEcc9oiiPIEFCxxnF7ur3JDmCEKhKaRLk5Jw=
X-Google-Smtp-Source: ADUXVKIXh59oFeQVTvsF65I7Dpn8kDl/FwAVAxGn1VhLjefBe3UqewOgRFO/J6Q0AzryNoGBUkVd/xYe/xEp4CQ2BT0=
X-Received: by 2002:aca:fcc8:: with SMTP id a191-v6mr6010595oii.34.1528569964266;
 Sat, 09 Jun 2018 11:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180606165016.3285-1-pclouds@gmail.com> <20180606170243.4169-1-pclouds@gmail.com>
 <20180606170243.4169-12-pclouds@gmail.com> <CABPp-BGn8mz5tPrVk6fX3JKcaSuz4_XQSsSmvEMT_H5i4mF2Lg@mail.gmail.com>
In-Reply-To: <CABPp-BGn8mz5tPrVk6fX3JKcaSuz4_XQSsSmvEMT_H5i4mF2Lg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 20:45:38 +0200
Message-ID: <CACsJy8DoU_qkghnNWKPy9+z=Lktg6jSbBFk6xEUFwAUos4Gu5A@mail.gmail.com>
Subject: Re: [PATCH v4 17/23] read-cache.c: remove an implicit dependency on the_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 8:10 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jun 6, 2018 at 10:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index b404ebac7c..4f054d6dbb 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -315,7 +315,7 @@ static int add_cacheinfo(struct merge_options *o,
> >         struct cache_entry *ce;
> >         int ret;
> >
> > -       ce =3D make_cache_entry(mode, oid ? oid->hash : null_sha1, path=
, stage, 0);
> > +       ce =3D make_index_entry(&the_index, mode, oid ? oid->hash : nul=
l_sha1, path, stage, 0);
> >         if (!ce)
> >                 return err(o, _("add_cacheinfo failed for path '%s'; me=
rge aborting."), path);
>
> There's also a refresh_cache_entry() call about ten lines after this;
> since you converted all other make_cache_entry() and
> refresh_cache_entry() calls in this patch, I'm curious if that one was
> left out for a reason or was just an oversight.

Ah I didn't mean to convert or kill refresh_cache_entry(), not outside
read-cache.c. I rely on NO_THE_INDEX_COMPATIBILITY_MACROS to catch
*cache* functions and if we set it in this file, we're going to have a
lot more work to do and plenty of the_index will show up.

> There are also a lot of add_cache_entry() calls in this function.  I'm
> guessing we should either convert all of those too, or just change
> back this particular make_index_entry to make_cache_entry() as it was;
> it seems weird to have a mix of explicit the_index and implicit
> the_index usages in the same function.

Yes some files still have the mix of the_index and *cache*(). This one
and apply.c come to mind. There's more work to do to kill all
the_index outside builtin/

> If we convert them all,
> perhaps we should consider having merge_options store the index we're
> working on?  If you want to punt this until later or leave it for me
> while I make all my ongoing merge-recursive changes, that's fine.
> Just thought I'd point it out.

Right you're updating merge-recursive.c, I'd love it if you could
define NO_THE_INDEX_COMPATIBILITY_MACROS here. Yes merge_options
sounds like a good place to tell merge-recursive where to get a struct
index_state.
--=20
Duy
