Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED9CC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 03:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F36A64DD5
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 03:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBNDPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 22:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBNDPI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 22:15:08 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1BC061756
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 19:14:20 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id e4so3080674ote.5
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 19:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IElRW386UOQhn8luUcBWCluXYcKSkK+fL0qfPDL7/94=;
        b=HYAeE/khcw8YvBAduxa+f/2fLxzyetW2o34+ocK/VZQYvabyFfrMzhPZiMbVFBA1eo
         8qhFLBK5HZDte0UyAPu9RQuDiYYtuNXSrqvwcalOkY9mCqcFlM6ubEJDBfMN58eABNtD
         +LEnvHJ3fY0aSsxURl0RiKSSGVBjaNSDA4WYxEs9bVYH+cVwlp4ZbwWXF2P+eiNGpD3P
         4T2BxI2luJBHQxpXLL2aVtAZTDPWyWimkO1bcKGj/t8R+2zQxmIsnnhTBH7i473UJ/Bk
         9FU/RKCswTZ0DxC5toIYRMWploQg+liKxcl80ZrQZUjPvPl/CaSRT8/ZmkaggIJMrTL0
         gn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IElRW386UOQhn8luUcBWCluXYcKSkK+fL0qfPDL7/94=;
        b=WQXTk/KiZqhBClnk34P1nWQJYPwxybrQoFjsvtXXip03uTUv8v9z9ZZMWE9NbRl1Yv
         J5igSDX77kjyFJIQnv4jQGd4tGP8TKKe2ffjXCDuvI5a6jzv7D0AW/rp5271vT7Y0Gat
         RBbKu7pfxhQ78s/ajtxZkipXcFIWTETWEXPuqGTJSNSstJfCW8RCZBrkKNfXejdoEqDX
         74oN4egaE9EZRbwGtwA1Q7h9w2J8yIijrMC9iZMBXoCmgM3JW9shm7iKMWworkOhN74P
         haIO5sO1FUYASOcSRGfbtZFlnfm9JGYVfAmPoPqcVYw8JIpmse5QGaOz8w9wXcVPLMGs
         L/9g==
X-Gm-Message-State: AOAM531wShKxuZOuFwuj/TqDOC1QWc23872IwIRq/vvWJqQ5mscS1UNy
        loAzBavxbqvkx2Ox8Yfj27R10jenO4r9FNrrtj8=
X-Google-Smtp-Source: ABdhPJxy6UDzQPmLbpxO4tODIgE2cEmSdwWn4GI0EOnsSiUfL/dEkicLE5DpRAp4PYBguAubLqjBucjxgSlqc9nBcUk=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr7248950oto.345.1613272460186;
 Sat, 13 Feb 2021 19:14:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <pull.843.v3.git.1612970140.gitgitgadget@gmail.com> <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
 <xmqq4kigvkct.fsf@gitster.c.googlers.com> <CABPp-BHyYOAw939vU20oA_tOSFRVm=EaLKuw+4M1oP1GDDV5cg@mail.gmail.com>
 <xmqqblcnttcr.fsf@gitster.c.googlers.com> <CABPp-BErByO=6jE+tZQHSsGJacr92AqVL7dnctE9MjQzmeQfcg@mail.gmail.com>
 <CAPc5daVVNaBiWt8vRv3xrXd7GvNPwRGRF=W31DUJCnZRo+9qtA@mail.gmail.com>
In-Reply-To: <CAPc5daVVNaBiWt8vRv3xrXd7GvNPwRGRF=W31DUJCnZRo+9qtA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 13 Feb 2021 19:14:09 -0800
Message-ID: <CABPp-BGYZBKhgLPSwGc0z+WO7UGAVS6A9W+cXoDn8nZDh2ZTJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] t4001: add a test comparing basename similarity
 and content similarity
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 13, 2021 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I do not consider "the same file changed in place" the same as "we
> seem to have lost a file in the old tree, ah, we found one that has
> the same basename in a different directory" at all, so your argument
> still does not make any sense to me, sorry.

I'm not set on the commit message wording, you asked why I had used
the terms I did and I tried to explain.  I also explained how the
wording seemed to have helped Stolee understand.

If you'd like to suggest an alternative commit message, I'm happy to take i=
t.

> 2021=E5=B9=B42=E6=9C=8813=E6=97=A5(=E5=9C=9F) 17:25 Elijah Newren <newren=
@gmail.com>:
> >
> > On Sat, Feb 13, 2021 at 3:56 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > >
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > > > This is not true.  If src/main.c is 99% similar to src/foo.c, and i=
s
> > > > 0% similar to the src/main.c in the new commit, we match the old
> > > > src/main.c to the new src/main.c despite being far more similar
> > > > src/foo.c.  Unless break detection is turned on, we do not allow
> > > > content similarity to trump (full) filename equality.
> > >
> > > Absolutely.  And we are talking about a new optimization that kicks
> > > in only when there is no break or no copy detection going on, no?
> >
> > Yes, precisely, we are only considering cases without break
> > detection...and thus we are considering cases where for the last 15
> > years or more, sufficiently large filename similarity (an exact
> > fullname match) trumps any level of content similarity.  I think it is
> > useful to note that while my optimization is adding more
> > considerations that can overrule maximal content similarity, it is not
> > the first such code choice to do that.
> >
> > But let me back up a bit...
> >
> > When I submitted the series, you and Stolee went into a long
> > discussion about an optimization that I didn't submit, one that feels
> > looser on "matching" than anything I submitted, and which I think
> > might counter-intuitively reduce performance rather than aid it.  (The
> > performance side only comes into view in combination with later
> > series, but it was why I harped so much since then on only comparing
> > against at most one other file in the steps before full inexact rename
> > detection.)  I was quite surprised by the diversion, but it made it
> > clear to me that my descriptions and commit messages were far too
> > vague and could be read to imply a completely different algorithm than
> > I intended.  So, I tried to be far more careful in subsequent
> > iterations by adding wider context and contrasts.
> >
> > Further, after I wrote various things to try to clarify the
> > misunderstandings, I noticed that Stolee picked out one thing and
> > stated that "This idea of optimizing first for 100% filename
> > similarity is a good perspective on Git's rename detection algorithm."
> > (see https://lore.kernel.org/git/57d30e7d-7727-8d98-e3ef-bcfeebf9edd3@g=
mail.com/)
> >  So, that particular point seemed to help him understand more, and
> > thus might be useful extra context for others reading along now or in
> > the future.
> >
> > Given all the above, I was trying to address earlier misunderstandings
> > and provide more context.  Perhaps I swung the pendulum too far and
> > talked too much about other cases, or perhaps I just worded things
> > poorly again.  All I was attempting to do in the commit message was
> > point out the multiple basic rules with filename and content
> > similarity, to lay the groundwork for new rules that do alternative
> > weightings.
> >
> > Anyway, I've added a few more tweaks to try to improve the wording for
> > the next round I'll submit today.  Given my track record so far, it
> > would not be surprising if it still needed more tweaks.
