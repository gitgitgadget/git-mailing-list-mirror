Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3CCC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6016261406
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbhI2Qmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhI2Qmw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 12:42:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093E6C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 09:41:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i19so10392066lfu.0
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX3mZhywYOxvQ/D4dvL+zytylGpgX7KSkTW77Sp0QqQ=;
        b=HaLDG67UIwfhDhUx0xlNg3+3+wSZWJxPDDPDJYkHU9NPxU4U1GgblayCshCGW2PCJ/
         4ky7kZ+lsarHZpd4OKkDuKgKu13K8HF8kUl75w4aCbYuJnnCOnqWLpnG2zUJKYioYSAv
         y2ajuxxVXv0/qb/AMZl68kzrteydJWZNgoxJuFDU+Ar9VXlCI+cS4/RmhOVdc/wiAwKK
         lxWARYVYXmFkCPt0A8WG0IodWXrNT8aOECCydI1apKesJuNWIvGVYTbQDX3n0ulX1Hn9
         osD/zYYjUThAD6SsyPV/zedaEUSV2E7pqBkgK39ym+woaVvdQcfZIe2Y8vf/ODB+GGtB
         U9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX3mZhywYOxvQ/D4dvL+zytylGpgX7KSkTW77Sp0QqQ=;
        b=m1TkTbM8FSy9s1z51EJPQ8pox7/ik7XN9JGSHBFFtWRa6ffA87tL69nrNm4mwRGcu8
         8U++uqyH5t/IXB5Q/znDred81YJ92yhI8wu6BLiR47NMIu1KwuqtUPMhEicPXnYF9z19
         6cNZKzx8HVCbin02qoxSxpin/R4yGE0AvXAP0Sv28ZeIfTWID5o0PurzG4rDvVlAlERT
         f8emINrcjSNx/PctQYOM7c0OP8Shg8AGJwInleaJZoKjnVXDVVDWxHktrMYj5MjRz2YM
         plxaKVE99HHDmiZpu1LL64U0MVsCyCuKpBQWaQY2Wv7BGFoHkT27tKqX42Lm24n2m0LT
         Ic/Q==
X-Gm-Message-State: AOAM53336fk/QH74jF3u4e4L1ONqTReWV5vdqAEqR3r3ZDamIBEJkg1f
        tvGnWMCRTUSo52Bvng5ZUW1lnkfjG5VT3PCm+eg=
X-Google-Smtp-Source: ABdhPJyPyTI0+8OD4EvBov2pp/ysS3s5Mg7rQaocslG1ALusJSG5RDG6Gk1zeVCjJMjNw9xwGsfarVwYLpdMTiy4wnc=
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr699252lfe.442.1632933669289;
 Wed, 29 Sep 2021 09:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
 <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com> <6ce72a709a11686b9082439a257fd5f58e5eb0f7.1632871971.git.gitgitgadget@gmail.com>
 <CABPp-BHAQU=i0K9KCtqdifECw4qQjH=6c=4-Bz45yEmbT1YABw@mail.gmail.com>
In-Reply-To: <CABPp-BHAQU=i0K9KCtqdifECw4qQjH=6c=4-Bz45yEmbT1YABw@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 29 Sep 2021 09:40:58 -0700
Message-ID: <CANQDOddqwVtWfC4eEP3fJB4sUiszGX8bLqoEVLcMf=v+jzx19g@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] tmp-objdir: new API for creating temporary
 writable databases
To:     Elijah Newren <newren@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 29, 2021 at 1:42 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi,
>
> Thanks for working on this, and for moving this up in your series near
> the beginning.
>
> On Tue, Sep 28, 2021 at 4:34 PM Neeraj Singh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > This patch is based on work by Elijah Newren. Any bugs however are my
> > own.
>
> This kind of information is often included in a commit message via a
> trailer such as:
>     Based-on-patch-by: Elijah Newren <newren@gmail.com>
> or Helped-by: or Co-authored-by: or Contributions-by: .

Will fix. I didn't know what some acceptable trailers were.  I'll use:
Based-on-patch-by: Elijah Newren <newren@gmail.com>

> >
> > +struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
> > +{
> > +       struct object_directory *new_odb;
> > +
> > +       /*
> > +        * Make sure alternates are initialized, or else our entry may be
> > +        * overwritten when they are.
> > +        */
> > +       prepare_alt_odb(the_repository);
>
> This implicit dependence on the_repository is unfortunate.  My
> versions passed the repository parameter explicitly.  While my
> remerge-diff code doesn't really make use of that currently, it could
> make sense to have temporary object stores for a submodule and do
> remerge-diff work on them.  You've also got two more uses of
> the_repository later in this function.

The core loose object code in object-file.c is riven with
the_repository assumptions. I'd have to refactor that code (including
the alternates code) to take repository arguments.  Given the
extensive assumptions, I'd like to push back on this suggestion and
all of the related suggestions.

> > diff --git a/object-store.h b/object-store.h
> > index 551639f173d..5bc9da6634e 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -31,7 +31,12 @@ struct object_directory {
> >          * This is a temporary object store, so there is no need to
> >          * create new objects via rename.
> >          */
> > -       int is_temp;
> > +       int is_temp : 8;
> > +
> > +       /*
> > +        * This object store is ephemeral, so there is no need to fsync.
> > +        */
> > +       int will_destroy : 8;
>
> Why 8 bits wide rather than 1?  I thought these were boolean
> values...was I mistaken?
>
> (Also, if boolean and compressing to 1 bit, should probably be
> unsigned rather than signed.)

This will go away when I drop the rename patch.  I wish we had a
standard bool_t type which is one char wide.  This is a
microoptimization, since accessing bits usually encodes to more or
larger instructions than accessing bytes.

> > +        */
> > +       strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
> >
> >         /*
> >          * Grow the strbuf beyond any filename we expect to be placed in it.
> > @@ -269,6 +279,15 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
> >         if (!t)
> >                 return 0;
> >
> > +
> > +
>
> Why so many blank lines?
>

This was an accident, will remove.

> Other than those minor things, I couldn't find any problems.

Thanks for the review!
