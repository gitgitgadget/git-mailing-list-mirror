Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F56C211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 16:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeLDQ2X (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 11:28:23 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:39205 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDQ2X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 11:28:23 -0500
Received: by mail-it1-f178.google.com with SMTP id a6so15342741itl.4
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SPNj9OcZy2t0yU91HIvR2qwOv1fo6rYiqRcVu+O7Fu8=;
        b=kIOZYPCN41EjJ+PPZgc8qW3gOeowxVrzhlC7Ezr9NaUfXfiP6B45c53yGNul8Deze0
         fcZfIPyLLpe3Wcx+di9ZeHfQOPW1U3MfMpFlGYIJovkmky4SwkDr/DfSDlzfl7a6zwUi
         Ms2/Qmsh8M3nFpzlDfrVggnV/UcDKQyWjyDhFVrg3L2PX6GbWGqmgp2ZQcHvhuAldDb1
         SdpXFbV7kwEOIHaL5Ie3sYKrRbGU75B1uXJ0F5ursKWqnrR+ZNIfNuEPDU0qp1/kcSXK
         Zz3jEJDegp80uUKcxM55ZQbpMSeT8NoAzBeo2WHFwZxko/ZzBKdyP5UiEE/9NkCSIjMJ
         glFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SPNj9OcZy2t0yU91HIvR2qwOv1fo6rYiqRcVu+O7Fu8=;
        b=a5gkkiHURdYDEGkPagPoYtWkcShmLeatXM3GUqZsQiurb3SPoEFuRxk+L33mkU2ql+
         DYjSRyy0swCR2NlpgZvhK2X3iasOgf8+G3KR+NgwSVDvK3+ZGJkUdNRE8vcRA2z/WoNq
         nPR/2p3MwPlrPEModKDkp3gXb/ZilulFziAvIUjP6H6TS9GM/s6wCmXe2W2DDU47/hK2
         17wzxPEFMNB1kckG1fRCxk1jDKGqs9axTJ1u4DQvmb2SJ3XLRsAaW/6vSJOGO54DYzJW
         AGFYXbrUy01KsjYv2sYyNVT93bdD2FTcdFvXh02iV6/d4iUQbboIgX1NRbbcxalhBW+c
         ZT3A==
X-Gm-Message-State: AA+aEWZ6Uao9f6xOUdBeCEkw2acaWsvcnSCdzplR4oXc5ctb6afMndP5
        kp7/HnK67cntvaYXVVFUkHT4U2GXpvf+ycxa9ko=
X-Google-Smtp-Source: AFSGD/WoV2bUoCoCy+aKqLMAAIgdOLyaL3WWye2o5v3wrVOnMLGrF3nshGSb7ts2o6Gq1hj9eMjOXCD5oTQeW1Mrtys=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr12058885ith.123.1543940902246;
 Tue, 04 Dec 2018 08:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com>
In-Reply-To: <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Dec 2018 17:27:55 +0100
Message-ID: <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
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

On Tue, Dec 4, 2018 at 2:29 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Nov 29, 2018 at 2:01 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > v3 sees switch-branch go back to switch-branch (in v2 it was
> > checkout-branch). checkout-files is also renamed restore-files (v1 was
> > restore-paths). Hopefully we won't see another rename.
>
> I started reading through the patches.  I also tried to apply them
> locally, but they had conflicts or missing base file version on both
> master and next.  What version did you base it on?

I think nd/checkout-dwim-fix because of a non-trivial conflict there
(but I don't remember when I noticed it and rebased on that). Anyway
you can get the whole series at

https://gitlab.com/pclouds/git/tree/switch-branch-and-checkout-files

It fixes some of your comments already, a couple of bug fixes here and
there and in a good-enough shape that I start actually using it.

> > - Two more fancy features (the "git checkout --index" being the
> >   default mode and the backup log for accidental overwrites) are of
> >   course still missing. But they are coming.
> >
> > I did not go replace "detached HEAD" with "unnamed branch" (or "no
> > branch") everywhere because I think a unique term is still good to
> > refer to this concept. Or maybe "no branch" is good enough. I dunno.
>
> I personally like "unnamed branch", but "no branch" would still be
> better than "detached HEAD".

Haven't really worked on killing the term "detached HEAD" yet. But I
noticed the other day that git-branch reports

* (HEAD detached from 703266f6e4)

and I didn't know how to rephrase that. I guess "unnamed branch from
703266f6e4" is probably good enough but my old-timer brain screams no.
--=20
Duy
