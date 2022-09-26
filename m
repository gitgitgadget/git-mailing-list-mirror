Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17FC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 09:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiIZJwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiIZJvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 05:51:42 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0943A150
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:51:35 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-333a4a5d495so62513057b3.10
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rbhN70h9LOrUq/OO+0zPbsObCgakNDnQRN0BiLsjQJE=;
        b=Cd0aUCieTlnS0WQeSDCd3IztJyRYb+5sbd+Aykfj9hJLIZZ2GNSRK5sCAoJetvO1jL
         rSKm9spDv7eSRnF0v+enRz/RQG+NEg0x7Ubeqe6sbRS5VGo/41iVoNtptjNYg8FB2Vhm
         4fs3ftqjsw52RcDOVMMx2+isEKZXyHJxCsvyzOPctRqRVUI4nprT+pg+rsQVxpv7jnyl
         RxPaTOswpgdf2dDzj9TS/0ooH/w6seKWFz+jRl2iL5aV5mRMEWNT4REIeOt5jjQNZtvI
         Rnkwcvzrbo4AAjqTfnnG+jX/opqFUB3pI+8McJdIMYb5Cxj5SX35mSkqAl2vIx6cRtd6
         S36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rbhN70h9LOrUq/OO+0zPbsObCgakNDnQRN0BiLsjQJE=;
        b=mWPmiSNwikScy4jPvp9bleVsgLkgZAnF68Omr4alMama87r6d0fanf5LO0qegFbWfN
         +q8fLWWQOnzKjNSNCW1u/MwrefiBnX3w5AyCkQ3d/hTqkUmwefyQzhlt9Vo1D4zlziZ6
         Bx3DrJekzy5tbvsDwrOXf+jYEcFkDBbS5jeQm4J5mzL6Zsh4RfxWkaILmEyRuGWPyf7O
         wJewrAO2Fvz3sCaPV1WM33DDdUoQ7h51Lo1jmGopkBHg6thedqSRUSfIDr17LmSkGZHG
         AltbVHuR9bQ+GYreHXaoMbwBiO++ROSDVrAlACrX/+tQWxBEy6Glp8V8soNReFlYMJWY
         s30Q==
X-Gm-Message-State: ACrzQf0TlkVLBcmaEBbj6oQwg2XFUcga/R1GXPqyq5/l7e9HdZH+cM/P
        dwwYivcf+CfOt8h3nOa6c4KLQa19oYM6bcYRWf0=
X-Google-Smtp-Source: AMsMyM7+Kp3kvw+rRxne8Y0Z0rEdNOPEHoyLJmLHXhObL9fa3VXCgVNycIsL3qPCeMtRKGBdlS2KYEsTBmUTUyfltmU=
X-Received: by 2002:a81:7851:0:b0:349:5fac:b1ed with SMTP id
 t78-20020a817851000000b003495facb1edmr19675499ywc.311.1664185894818; Mon, 26
 Sep 2022 02:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <Ywzv7Dl6n+LcY//n@nand.local> <CAP8UFD2gUTuae0nRp2jHHoD3yLsVSGTBzEuHkv8QLDGJVAZ-MQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2gUTuae0nRp2jHHoD3yLsVSGTBzEuHkv8QLDGJVAZ-MQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Sep 2022 11:51:23 +0200
Message-ID: <CAP8UFD0+qW9aRVbXeKkvZKKi-6rge851FdT3FxPW98_JH_KLRQ@mail.gmail.com>
Subject: Re: Git in Outreachy? (December 2022)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Aug 30, 2022 at 8:53 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Aug 29, 2022 at 6:57 PM Taylor Blau <me@ttaylorr.com> wrote:

> > Christian and I both got emails from the Outreachy organizers asking if
> > we are interested in participating again this year. Last year we
> > submitted projects, but ultimately did not select anybody from the
> > program.
>
> Yeah, let's hope we get more people applying this year.
>
> > I think it would be good to participate in this year's December cohort.
>
> Yeah, thanks for your email about this.

So we decided to participate and I just submitted one project:

https://www.outreachy.org/outreachy-december-2022-internship-round/communities/git/#unify-ref-filter-formats-with-other-pretty-formats

which is about continuing previous work by GSoC contributors and
Outreachy interns.

The deadline to submit projects is September 29, so next Thursday.

I think Taylor agreed in private discussions with submitting another
project related to improving our https://git-scm.com/ website (which
was discussed previously on the mailing list).

It could help a lot if we could be co-mentoring the project I
submitted and the project about improving our website that Taylor
might also submit. So if you would be interested, don't hesitate to
contact us.

> > September 9th is the initial community application deadline.
> >
> > If we're interested, the project submission deadline is September 23rd
> > By then, we'd need:
> >
> >   - Volunteers to act as mentors
> >   - Updates to our applicant materials on git.github.io (project ideas,
> >     as well as potential microprojects).
> >
> > If folks are interested, I'd be more than happy to answer any questions
> > about participating, and overall logistics of the program.

> Yeah, we need to update our microproject ideas on git.github.io.

We still need to update microproject ideas on git.github.io for
Outreachy applicants.

> About
> project ideas, we need some, but I think we need to add them into
> Outreachy's website.

If there are many possible co-mentors we can still submit more project
ideas into Outreachy's website before the deadline next Thursday.

> It would be nice also if we could discuss with
> Outreachy organizers, and ask them how we could increase our chances
> to get some good applicants.

Such discussions happened privately, but we are not sure yet if we are
going to do something about this. Unfortunately a discussion round
between mentors and potential applicants happened on September 15 when
a lot of us were at the Git Merge.

Thanks!
