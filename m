Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1D820248
	for <e@80x24.org>; Thu, 21 Mar 2019 01:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCUBwB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 21:52:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39228 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUBwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 21:52:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id m13so3417254lfb.6
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDiBx35RrA+BZnTCCUmd72oP5L3XbAQhTPeKiZuWxog=;
        b=vfb4VBuZ3H/vK9+kgR1hLmfiktjCOHgq+wxVJlGCku5y3KRxfy8TXErrG+fJrfqIZ5
         vJqfO/bshQm+l+YmUgWv6wYi8OsutS+a93Fyp5Ui0daAjCO3c10Zbly+UIOV9GJST+tF
         UF+gr/j/2nYyl7TV04obezd+OUN+pGmO/hklhFdqCy+eD0S63Q3aTM9cEnwRxl7kSCdr
         N+HF3KQxPZpAu65ToJtFQ7cp+k9N4qH4os0RWwjGtRhkRn5AbUsLJ8GatfWixla7A0kc
         G+UOkBgUIh1ZJzPmROQyK9i3UNozhwWzo0M3QAJ0+DGBL7T774mQIXGbqt4Cx99ZY2Z9
         GKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDiBx35RrA+BZnTCCUmd72oP5L3XbAQhTPeKiZuWxog=;
        b=GugjDTrp5DIxd1ROGQjvL7JHIbuMRzyxWatoL18msK3bZiF8egoFWIPZtRC0foU7jS
         91DmzfrotKonAiC2BdrDyUjkJxQO2Yn3zzNDujhevfTvU+k3Kix0y7KNuYHi28//9L4I
         821iWv6IfWhL0HM8aMUoZgG8vnXOS94FKKr/Zg4oIN+M74S2fQJmY4yn4e/H5pRYVxQP
         vKvi98NrAudWuzItPC6naE+Jjnlg6Xlnowr6hjrRHSEnukc0kknkj1fb4yGtX+qEvu7E
         M5cjWVeCAMxvobSZ9KFlgeD6VGalPH1UC2gZtr/IzmfClsAltLlVS2HZVAuBhwCSFamX
         +UkQ==
X-Gm-Message-State: APjAAAV21hQ0UGJbbpysUmgYcKuhFV9fU4VdH/09Ko2+eGTQsy8fo+bn
        5w0V82goudNAAues/OHC3lzv+MdCwXSNrWuy94k=
X-Google-Smtp-Source: APXvYqxWRI2toRXx2i/oGjNcKaxA3t1+OokTdfazCDtPAiU5xWCG+AdL+5BMxTjFr+zfrW1OV7Qb9UIEmmF+tI4GJAM=
X-Received: by 2002:a19:5217:: with SMTP id m23mr442503lfb.19.1553133118275;
 Wed, 20 Mar 2019 18:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
 <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com> <871s31vjo7.fsf@javad.com>
 <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com> <87lg19mt95.fsf@javad.com>
In-Reply-To: <87lg19mt95.fsf@javad.com>
From:   "C.J. Jameson" <cjcjameson@gmail.com>
Date:   Wed, 20 Mar 2019 18:51:46 -0700
Message-ID: <CALm+SVL1JkfaKt-B5oEHybBn40hy+b0zhBCtwv-ijN7EY14-yQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 8:59 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Mar 20, 2019 at 8:09 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> [...]
> >>
> >> > But I do have a very strong opinion against adding yet another
> >> > option that takes an optional argument.  If we want to allow
> >> > cherry-picking a merge commit just as easy as cherrry-picking a
> >> > single-parent commit, "git cherry-pick -m merge" (assuming 'merge'
> >> > is the tip of a branch that is a merge commit) that still requires
> >> > the user to say "-m" is not a good improvement.  We should just
> >> > accept "git cherry-pick merge" without any "-m" if we want to move
> >> > in this direction, I would think.
> >>
> >> Let's just make '-m 1' the default option indeed. No need for further
> >> complexities.
> >>
> >> Exactly according to what Junio has already said before. Here:
> >>
> >> https://public-inbox.org/git/xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com
> >>
> >> Junio wrote:
> >>
> >> > Now, it appears, at least to me, that the world pretty much accepted
> >> > that the first-parent worldview is often very convenient and worth
> >> > supporting by the tool, so the next logical step might be to set
> >> > opts->mainline to 1 by default (and allow an explicit "-m $n" from
> >> > the command line to override it).  But that should happen after this
> >> > patch lands---it is logically a separate step, I would think.
> >>
> >> ... and as that patch already landed...
> >
> > This worries me that it'll lead to bad surprises.  Perhaps some folks
> > cherry-pick merges around intentionally, but I would want that to be a
> > rare occurrence at most.  There are lots of folks at $DAYJOB that
> > cherry-pick things, not all of them are expert git-users, and I am
> > certain several have erroneously attempted to cherry-pick merges
> > before.
>
> Wow, random Joes cherry-picking here and there... Sounds like a bigger
> problem is lurking here.

Indeed, I was the de facto release manager at $DAYJOB and I didn't know
about needing `--mainline` until we happened to need it. At this point,
it's just more fuel for me arguing that the merge commits are extraneous
noise in our repo's history, but projects have inertia-of-git-workflow.
>
> > I would much rather they continued to get an error message
> > and then asked other folks for help so that someone can explain to
> > them what they should instead be doing rather than silently changing
> > the current error into an unwanted operation.  Granted, the users will
> > at least get a confusing "Merge branch <foo>" commit message for
> > something that isn't a merge, but I don't think the users will notice
> > that either.  It just means we've got both confusing and ugly history
> > without the necessary individual commits or with too much having been
> > cherry-picked.
>
> To me it seems that cherry-picking wrong commit is cherry-picking wrong
> commit, no matter if it's a merge or not. I don't think that trying to
> save a user from such a mistake worth the trouble, given that
> cherry-pick is reversible operation, but I still see your point.
>
I'm with Sergey: that people would know what code is being brought in.

We could specifically code it up so that 3-way merges still need
an explicit `-m` to be set...

> > If -m 1 is too much to ask people to specify, could we provide some
> > other shorthand? Or at least make a default-off config option people
> > would have to set if they want a cherry-pick of a merge to succeed
> > without specifying -m?
>
> If we decide we still need this safety precaution, I'd opt to continue
> to require '-m 1' to cherry-pick a merge, rather than adding some
> special support. Not such a big deal.
>
> BTW, doesn't git have generic configuration support to add default
> option to a command, I wonder (I'm aware of aliases, but they don't
> seem to fit)? The C.J. then would simply add '-m 1' to 'cherry-pick' in
> configuration. No luck?
>
I'm not quite sure how I'd do that; pointers?

> -- Sergey
>
