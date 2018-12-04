Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF01B211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 17:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLDRpW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 12:45:22 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:37204 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDRpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 12:45:22 -0500
Received: by mail-ua1-f48.google.com with SMTP id u19so6091581uae.4
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DvrysJnozlDA2blepWCKxxOiy0qnELFwLut964IwoM0=;
        b=AQEd6WInYUvm96Jf+CvvQqOK5S/IgS6iXr2DYwkkoO1Cvrbrh3LIGpOYhN9Q7uaR5f
         p67itXQD4vYyn2WrbSlDHFWl5q4A3DZsdACp3BWAEMYBSZVAIiE6wxa4vpjvn1QNAmGO
         8zC+m76E7cdGhvDT8YdW7/GWMxo4FYjota20h0CJY/WNx2pZ5qJHNqhFNgHnCs+DV07B
         MiujGXSWbEBGYoauXTUavV1Q6uGHMYeMj3mDwYyOfsVCV0zmERPW9qtUvZJb4hMl1xBO
         v6/DMxyAw7VT7QG2PMZGL269v9zvJ5Xwp6HACr97SfxJGKXgjqiv4VTVKgvVwEW+34Oy
         zMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DvrysJnozlDA2blepWCKxxOiy0qnELFwLut964IwoM0=;
        b=tRBW7S2OXlCeytEydhFyqGep153TV1I4psJW+XLP4OXnJ2pR+bmLlam1WHAXzTcJ4m
         vTZXe8c+Jn0vwHkaIzHGiihZ4MSpDFpQGMz5XZ6ERjsdMBEAfWW4ByuwpZMX8ueOJllx
         Rb5We307oaNvTVfqBME48Z3XrBmCI5vgsSDBiiH0VR7cWrM6KXLW09ayUtkOYdsl2qxU
         p7Jr89ZSBISpJgiQ5FaMxEMKgMvkSDK48KE3XFA5JfvP//4zzOUIm5iz5G9A72WTL3O6
         9mAyIpf6QwOrMBgdWqR1E9XLuqg2DYqL8nbMPclOCpSImvbR2fzVG6Yh4kf1QYY+Guw7
         GVRA==
X-Gm-Message-State: AA+aEWbJELExAV/Ef+Ur0NDGHNK90esGSsHJicHFeYqzhiQ4MMWWO5sN
        5BH1AdvNKnf6bTjdlZoRW/Pw5igX6LixiGEAsLQ=
X-Google-Smtp-Source: AFSGD/XcpA9YMBpsBAJtDPgkCOkyR2vKPxXC7jV5YMdxaNxg6xoOkApS3Jnn7cs0YOpXaJZmHczz/boUrwebYr2KFBY=
X-Received: by 2002:ab0:2314:: with SMTP id a20mr9390243uao.130.1543945520315;
 Tue, 04 Dec 2018 09:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com> <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com>
In-Reply-To: <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Dec 2018 09:45:08 -0800
Message-ID: <CABPp-BH=rsLqq4ZRMSUv6n0n5p=aMZs-+VkVT=7P8n4=iUk=-Q@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 8:28 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 2:29 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 2:01 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> > >
> > > v3 sees switch-branch go back to switch-branch (in v2 it was
> > > checkout-branch). checkout-files is also renamed restore-files (v1 wa=
s
> > > restore-paths). Hopefully we won't see another rename.
> >
> > I started reading through the patches.  I also tried to apply them
> > locally, but they had conflicts or missing base file version on both
> > master and next.  What version did you base it on?
>
> I think nd/checkout-dwim-fix because of a non-trivial conflict there
> (but I don't remember when I noticed it and rebased on that). Anyway
> you can get the whole series at
>
> https://gitlab.com/pclouds/git/tree/switch-branch-and-checkout-files
>
> It fixes some of your comments already, a couple of bug fixes here and
> there and in a good-enough shape that I start actually using it.

Cool.

> > > - Two more fancy features (the "git checkout --index" being the
> > >   default mode and the backup log for accidental overwrites) are of
> > >   course still missing. But they are coming.
> > >
> > > I did not go replace "detached HEAD" with "unnamed branch" (or "no
> > > branch") everywhere because I think a unique term is still good to
> > > refer to this concept. Or maybe "no branch" is good enough. I dunno.
> >
> > I personally like "unnamed branch", but "no branch" would still be
> > better than "detached HEAD".
>
> Haven't really worked on killing the term "detached HEAD" yet. But I
> noticed the other day that git-branch reports
>
> * (HEAD detached from 703266f6e4)
>
> and I didn't know how to rephrase that. I guess "unnamed branch from
> 703266f6e4" is probably good enough but my old-timer brain screams no.

Perhaps "* (On an unnamed branch, at 703266f6e4)"?
