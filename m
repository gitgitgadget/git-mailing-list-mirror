Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24DF0211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 21:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeLCVnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:43:13 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40832 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeLCVnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 16:43:12 -0500
Received: by mail-ed1-f54.google.com with SMTP id d3so12101173edx.7
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5E+W4K78FSsNiC5J2ICOyad6/gauw5lauZwCXn4bplU=;
        b=KoL2ZhSJfP26zFCGwmXg14QlveUEdmDCUFtgbH4wGBLX7hDd5RiUTXqb5ckl7rPDUE
         WoiyJjWFFIlIqGGtGcR2BMYRbRBXsLLmFvdFuO+buufJl2DJKEFqr5YXaxqOAEiaMRVX
         TGbRiefE+b8vOqy0ut43mLzoN6C+NDPeTT02b2pg7M9XM5hD9v7TVAghkq/cAF9JUwGX
         FTvTSGWk2RKTHlV6NC//5p5OuFyB8jCd4TQXAG6OwmlamifqaE2ERW8LZ8tKKVJ9i4pc
         eOoR5RHEZGWAxwVtM09MtDcMUqvByf7DfsK02RUVNh+geBh2i87GGHXLySt/mUnYwTYD
         nZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5E+W4K78FSsNiC5J2ICOyad6/gauw5lauZwCXn4bplU=;
        b=h7GRc/voG0vTFrL/NMMUuZVXUzaFdmzVOuj4YS9dh0UfKZ9wTOs6fZZaeZ2EU1q6tS
         Y6o+KBmoZFRS8v2NoJ6885ZCxBm3PtMekpEhl/MD0PEFeuSgQAhEQpAabCjLH39iYr1W
         u63Vlo7jfvC4qAwHGSohMZOmB1TcY3u+ijGgRR/RP/GB2s8EAqWEvqXsLCm8buHdk1GZ
         Wy8qOtNrE3Qhq4iPpBauMQUWZODgNg3TvdmmoEGho+iy1eIWe2Bg6Iie1N6daljGBAOX
         Tca9wZPU3TwAU/gCKuEAqcuKNPX5sQxRR2xx1t1thhDJYx7u9LCi2Y81mkEx4p0Zqwsa
         tjhw==
X-Gm-Message-State: AA+aEWZI95uDWungg6uhvwYvh42gMvYZiRx0COXImOwI5JA7HSaeCejp
        YJaDm768zGbpUPJEJmzXIFClrHRCtERSe9U8VD6mDQ==
X-Google-Smtp-Source: AFSGD/X4faulRZxgAkKKFGJ8fbw9RMbXbv1NBcuVI+Mu2WWpW3exx9WWha2yJA5OXqJwHm8dvo9LA7/GjqW81/MetDI=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr5150939edd.215.1543873390862;
 Mon, 03 Dec 2018 13:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com>
 <CACsJy8Cv9ZwWEs-wsOtms3JCXo7x8fL_PBatcb0TgvrrQuMUdg@mail.gmail.com>
 <CAGZ79kYiMObOHAuf+01r0-YVWHBk-6NpceXh9Z25dx9JZsP62Q@mail.gmail.com> <CACsJy8CkBV48Yd9FHfLVQSHJ630uw8icn128xjAPUOeWJVWfVA@mail.gmail.com>
In-Reply-To: <CACsJy8CkBV48Yd9FHfLVQSHJ630uw8icn128xjAPUOeWJVWfVA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Dec 2018 13:42:59 -0800
Message-ID: <CAGZ79kZk-im9=dgMJof2LGuR6hftMcnwx0=G-sjhkERWDqXEwA@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 7:33 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 9:30 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 12:09 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 9:01 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > > > should we do
> > > > something about detached HEAD in this switch-branch command (or
> > > > whatever its name will be)?
> > > >
> > > > This is usually a confusing concept to new users
> > >
> > > And it just occurred to me that perhaps we should call this "unnamed
> > > branch" (at least at high UI level) instead of detached HEAD. It is
> > > technically not as accurate, but much better to understand.
> >
> > or 'direct' branch?
>
> makes me think, what is an indirect branch?

I drew the term from HEAD pointing to a branch pointing
to a commit, i.e. HEAD indirectly points to a commit, but
in 'direct' branch mode, HEAD contains the commit id.

So indirect branch would work for our current 'real' branches.

When asked out of context of this discussion, I might add
yet another layer of abstraction to make an 'indirect branch',
i.e. HEAD pointing to a symbolic ref that points at a branch
that points to a commit.

The term symref is what we currently use
(Just looked into gitglossary, where we distinguish
symbolic refs from pseudorefs) for hat I would have called
an indirect branch as well.

So maybe we need to measure the level of indirection
("How often do we need to dereference the ref/object to get
a commit oid?") to come to terms in how to describe
the use cases easily.

Here is a fun-one:
  git checkout <symbolic-ref>
  git checkout --detach

Currently the --detach option detaches HEAD from
branch pointing at the object id, i.e. it is the same as
  git checkout <oid>

whereas when we focus on the levels of indirection
it would also be reasonable to have
  git checkout <branch>
as a reasonable alternative, where <branch> is the
branch that is pointed at from the <symbolic ref>.
