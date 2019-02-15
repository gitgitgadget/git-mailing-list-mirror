Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4301F453
	for <e@80x24.org>; Fri, 15 Feb 2019 19:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfBOTZ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 14:25:57 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43030 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOTZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 14:25:57 -0500
Received: by mail-ua1-f66.google.com with SMTP id z11so3585385uaa.10
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 11:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTnjv/CWpqfkufnulS34rhr7FtmL8DPPm5Kd5OOSlws=;
        b=qh/0SCpc62u2vETf906oTZgVP/udgHFTd1sV0PE8A73ZB8Eig442RhxOxqE5Y57KkE
         3CoRG4Yx3YHARxteR7+iMwjpQswSL0BmojtW/cIntR4ZeAwXttElDK8qlFhlHhvZJqQ1
         vrw1SGndFmV/S2epBoYW5P9EwvtU3LTPIJ+uqMeSjEv6q3T3J32ld7l1C0HXjrOw9ewO
         3XKl7JqJ0YUZTMvNdCyhiyDrd9D/c0DBudwXFqTXQQUtlnit8PEdyqkAMpcDJWttUM1L
         CuP3IXTi4LX/qHrscJKFgLnSOCl2J9uS+YPEp8uJhFr81btTOF/+SxBTsM61YXuAfHng
         W9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTnjv/CWpqfkufnulS34rhr7FtmL8DPPm5Kd5OOSlws=;
        b=A/SJA/YeDJykVRcykooKfRPMXwm8q1eR7HUPndjNClORgUe09oo7Spp0eHKqfxFC9v
         Puj0q/ufeDG8wk9u7atKPZetHxRysv/W6zYvli0DApPNL+3y2/C1ppQnyyR1+xICKBMv
         IQIaRy3tGi7vn4FEPVE6HLG7vFqn7mRKWOMppRhjMM+KiU2bP36u4sN9jVbp8YJcmKGh
         MJy9SM2gYc1uHIop8xXCtB2VM3Wag4n9BnmNwLTEt+pR4Sx5d1UFv0Z3c3gztbIQTEOe
         ZYjfByqncv9yLsozlE8G+MiY1zcUqnE06mC+lGZpEoHIuNv/YSUjvPKwhx01KTkoBgjE
         TOZA==
X-Gm-Message-State: AHQUAuYT+a3iuJg8lSGcp/PSSuKtKYTUhnRMAvw33eygQ0Ckgv5a7J9Z
        WGd89xC+ezWj1gb0SHLGxvQleI57cY5tDSXRxkQ=
X-Google-Smtp-Source: AHgI3IYjVGklPHT5m7c33YZwBYbWYiv9yD8EzgALluFV+Bfdtof68PrdesfwAMec9qvPdI1pgHfW+2JPZa8pkV8MBaQ=
X-Received: by 2002:ab0:2046:: with SMTP id g6mr5788326ual.19.1550258755738;
 Fri, 15 Feb 2019 11:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7> <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
 <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com> <20190215185202.GA28019@dev-l>
In-Reply-To: <20190215185202.GA28019@dev-l>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Feb 2019 11:25:43 -0800
Message-ID: <CABPp-BEmPQb4Q_38S2A_68m+Cu75VDDD2UV0qWBDjL1OUAug9Q@mail.gmail.com>
Subject: Re: [Bug report] git diff stat shows unrelated diff
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 10:52 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> On Thu, Feb 14, 2019 at 02:10:53PM -0800, Junio C Hamano wrote:
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > The only thing I seem to be able to retain is the following:  "git
> > > diff D..E is totally useless and should be an error because (1) it
> > > doesn't do what I expect and (2) for folks that want the behavior
> > > currently gotten with that syntax can instead just use a space instead
> > > of a double dot."
> >
> > That sums up pretty nicely.  diff is fundamentally an operation
> > between two endpoints, so the range notation a..b does not work
> > nicely with it at the conceptual level.
> >
> > When we realized that we can take advantage of the above fact, and
> > reuse a range notation to mean something that is generally useful in
> > the context of diff, such as 'one end of the comparison is the merge
> > base between a and b, and the other end is b', it was too late to
> > use "a..b", as an early adopters of Git was already used to the fact
> > that "a..b" happened to mean the same thing as "comparison of one
> > end is a, the other end is b", pretty much implemented without much
> > thought.
> >
> > It might be _possible_ to spend a year (i.e. 4 cycles) to start
> > warning when two-dot notation is used for "git diff" (only, not any
> > plumbing like "git diff-files") and tell the user to use the more
> > logical two-end notation "git diff A B" and then eventually error
> > out when two-dot notation is used, while retaining the three-dot
> > notation throughout and to the eternity.  I am not sure if it is
> > worth the deprecation cost, though.
> >
> Instead of outright deprecating it, would it make sense to include a
> configuration option, say "diff.sensibleDots", that would enable a user
> to set the dots to the other form if they desire?

I think Junio's suggested steps would still have to come first, and
there may also need to be a time period after two-dot notation is an
error before we were to try to repurpose it for something else (e.g.
to make it behave the same as triple-dot).  Adding a config to change
things now without both a deprecation and error period would invite
horrible surprises and bug reports; people need time and warning to
change workflows and fix existing scripts that might be out there.

> This has bugged me for long enough that if there's a desire for this
> from others, I'm willing take on the effort of making this change.

I was going to put the deprecation and erroring steps on my (always
growing) TODO list to eventually get to it, but if you're motivated,
go for it; I wouldn't get to it soon anyway.
