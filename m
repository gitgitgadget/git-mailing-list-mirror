Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B24620248
	for <e@80x24.org>; Fri, 15 Mar 2019 12:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfCOMsZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 08:48:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35614 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCOMsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 08:48:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6so6934788eds.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZeY8M1trfd/JQsXXBLsLNVPrfk2XAAM4VS6FV9t60zE=;
        b=lKBDnZu8YFy9c2lnYQSYUO3s5/qrOsG0PvhVRXyv9J5Yt958VY7IOSWlmBQ01J5ZTE
         0R3+ZkuAUH0yFgfbxKK2i/2yOaWXC/uiSf14EIKQ/3UoPDgHhRrH4J1vievj9pkoEKFP
         FcNVQy3XkAjNdWanWxRqodq1rHRisf7ZZNJ0SatVYA9PQgXsr8csevFJcvh+fOv4Rd/+
         Gby7b25Syn+NOYcZEjnAJQ2GNC2KCf9x/epHr2k8VylX975nQTfktkQli50T9u+UZZIW
         D2l0HhQoy4tA/hrr7gLKcLw4lActDdgrfrsJSVDngkmlf8HOKNQ6w59VgrC7tu6IFMsN
         mVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZeY8M1trfd/JQsXXBLsLNVPrfk2XAAM4VS6FV9t60zE=;
        b=im9n3aGfNZ7iSyPHEjRKeiMpdSBjldOiHkFL6B8fqvmRyUYZeCkavieIspAZ9A9Fpe
         2bdvfEdHQnuMb9OnLnTlSBEWlmdmwJG4mFUEJF4FDTZOl6bvsY+goXXrgPPz5a0B7pMn
         180wuINaHfol2IALuzCQgHBwH/stEUeCJdxdTCxxOJjz6yxbcTe7ryzuC+syh/3SrhaF
         q06TeqE3ip1FA+JgegG5nj6kd+EQRQJMwwRdEsHYTQ0GHBSHHRvE6naJXtjnFqU8yw2t
         0NpD+NpoFOIvDwGoKzHolUSURCK3PVYZ6pVqyEQGrJuflkTuCCb9fMKOHGak7B25Z7KM
         mCRw==
X-Gm-Message-State: APjAAAWvlhiaZfC7P+y2Uj9TDg0VLBz3j7g6n8VAYleME1f+5MZaKnTV
        TTBgWOmJYT9X6xmkbs47LCBkDKsfp2xVA5V4blk=
X-Google-Smtp-Source: APXvYqzev9Ag/9DvJQyGpv6RiuSCbOIdPoDydHHPJStn57vjFtOjLBT9hFArPiwbWPE6vRg4tUGOrdyu0MRII8KtZHg=
X-Received: by 2002:a17:906:69c8:: with SMTP id g8mr2157035ejs.75.1552654102629;
 Fri, 15 Mar 2019 05:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190309164508.GB31533@hank.intra.tgummerer.com>
 <20190310080739.63984-1-ttjtftx@gmail.com> <20190310175924.GF31533@hank.intra.tgummerer.com>
 <CAOAu_YLTft7xmx4xvoM5Qqe0CHjqWrH+DUysHq0zfSEU8vodkg@mail.gmail.com>
In-Reply-To: <CAOAu_YLTft7xmx4xvoM5Qqe0CHjqWrH+DUysHq0zfSEU8vodkg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Mar 2019 13:48:08 +0100
Message-ID: <CAP8UFD09QZd=6HyB5Om1PfV=67+CvfyQkcpLU0tukT48QccD0Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 1/5] t0000-basic: fix an indentation error
To:     jonathan chang <ttjtftx@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 15, 2019 at 2:55 AM jonathan chang <ttjtftx@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 1:59 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 03/10, Jonathan Chang wrote:

> > > Also I found that there is no such function as test_char_count,
> > > is it worthwile to add such function? Here are some stat:
> > >
> > > `git grep 'test_line_count' | wc -l` = 626
> > > `git grep 'wc -l' | wc -l` = 294
> > > `git grep 'wc -c' | wc -l` = 68
> >
> > I do think it would be helpful to introduce that helper, especially if
> > it is useful in this patch series.  There seem to be enough other
> > places where it can be useful to make it worth adding the helper.

Yeah, it would be useful for Git, but it's not necessary of course for
your microproject, which is already more than big enough.

> > > This is a preparatory step prior to removing the pipes after git
> > > commands, which discards git's exit code and may mask a crash.
> >
> > The commit message should also describe why we need this preparatory
> > step. Maybe something like:
> >
> >       To reduce the noise in when refactoring this pipeline in a
> >       subsequent commit fix the indentation.

Or perhaps:

      Fix indentation of a line containing a pipeline to reduce the
noise when refactoring the pipeline in a subsequent commit.

> This has been wrong
> >       since the refactoring done in 1b5b2b641a ("t0000: modernise
> >       style", 2012-03-02), but carries no meaning.
> >
> > > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>

> > Since this patch series is now 5 patches, that commentary should go
> > into a cover letter (see the --cover-letter option in format-patch),
> > so the reviewers can read that first, and read the patches with that
> > in mind, focusing on the patch only, and not additional commentary
> > that applies to the whole series when reading the patch.
>
> I wasn't aware of this option. I tried to produce the format in others
> cover letter using 'git diff' and options like '--stat', '--summary', with no
> success. I consulted Documentation/SubmittingPatches, where I got the
> idea of cover letter, but it doesn't mention the option '--cover-letter' and
> the idea of cover letter is even confused with '--notes'[1].

The issue is that there are different things that can be considered
"cover letter". I agree that it's not very clear in
Documentation/SubmittingPatches.

There is the following which is related to --cover-letter:

"Multiple related patches should be grouped into their own e-mail
thread to help readers find all parts of the series.  To that end,
send them as replies to either an additional "cover letter" message
(see below), the first patch, or the respective preceding patch."

but it doesn't mention --cover-letter and it contains "(see below)"
though I don't see what that refers to.

> I just reread some of the GSoC related mails in the mailing list and
> found one[2] that introduced the usage of 'cover-letter', '--range-diff' and
> '--interdiff'. As a newbie, I personally think it would be helpful to include
> theses options along with others mentioned in SubmittingPatches.

I agree that there is room for improvement in SubmittingPatches.

Thanks,
Christian.
