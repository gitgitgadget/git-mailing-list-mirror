Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624E720248
	for <e@80x24.org>; Sun, 24 Mar 2019 01:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCXBqX (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 21:46:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36929 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXBqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 21:46:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so4031774pgq.4
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 18:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lVhMard+wBg19zW1nwO2pWgZocnQEwwhwcalTiUxdts=;
        b=j3qg7V8Z1k4MAakpAxOAmH3bSnSuRYDvOkYHbbzLykwmhfStwaSuvSCwqLAgnrxnto
         IXtcjRMfm9xEEB79gKZqfNQaRl+hhwynnpU+3AlBcPTH2xM62gK552W/JqMPsuzGtJLm
         mhW/fBxx4Uld7kwzyxgYfD7otWDOYwB7wMQsp9mJqzRq2cpAML3tM1crY4A3+pohLu4t
         bnGtB/UsAA144cEskQIyjpM08/P1icVg70Bw2w+F0ddob0XzzrJGpNP3dCQw5ELGyPyk
         ZZy9pWg8N1/RfoYsOtmDRRasU2ThTVeg8pn1O+WeFHYDhqAFqkmfeepjWIgmUnE9unRy
         XmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lVhMard+wBg19zW1nwO2pWgZocnQEwwhwcalTiUxdts=;
        b=eoJl9rLxNYbskBzgVlDSNAhT9hBN3ZXbZptEZpe6sUoj/wCkF77h95SZPR41QzE35M
         HO6n8+NZPJPkJ8dAyYwUF8a41Vbjtp+MhVcnzxm8ss2cCSsu44tW8TXOA0moR05iLHcn
         OfxSVHFx6fq0QqzskWoDML4WseScGWNbfZ+K45wroxEtpY1fLtrSdTuRiXNuSzh0O+Ur
         gWB/yBmARshBEkQH+/ixn+pX/heaxR4HOWBTLHJqQCiTLRyBJ9Wo4OECaSQxUBXS3JOk
         B2DSa/xVljGP1PvWHNV4IJncm8sy6wR6cTKouVkEgplm7gn8IaAzMZivSLyZhHkz95jz
         2mMg==
X-Gm-Message-State: APjAAAW2DcUyw3hB0x5pGELs61lGz2wgj+s+2o6ENx9Ue183WzHZk1m/
        yNlaop6GBpcI4uQmT+5tZPI=
X-Google-Smtp-Source: APXvYqwuqhojIn77xYZx0DLyMwqJbgemYOBSIBvrpNrFuuw5ZCUaP+AXdmsdxNDve56GCSxEICqi8w==
X-Received: by 2002:a17:902:e90b:: with SMTP id cs11mr17406464plb.197.1553391981387;
        Sat, 23 Mar 2019 18:46:21 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id f192sm20701038pfc.180.2019.03.23.18.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 18:46:20 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     newren@gmail.com
Cc:     Johannes.Schindelin@gmx.de, artagnon@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        rohit.ashiwal265@gmail.com, s-beyer@gmx.net, t.gummerer@gmail.com,
        rafa.almas@gmail.com
Subject: Re: [GSoC][RFC] Proposal: Improve consistency of sequencer commands
Date:   Sun, 24 Mar 2019 07:15:30 +0530
Message-Id: <20190324014530.8218-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABPp-BEdgSHGTkUcg_UDRu50Ag+cCqigmvU4_JaRZRnDpgWcdA@mail.gmail.com>
References: <CABPp-BEdgSHGTkUcg_UDRu50Ag+cCqigmvU4_JaRZRnDpgWcdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah!

On Sat, 23 Mar 2019 18:07:17 -0700 Elijah Newren <newren@gmail.com> wrote:
> Hi Rohit!
> 
> On Fri, Mar 22, 2019 at 8:12 AM Rohit Ashiwal
> <rohit.ashiwal265@gmail.com> wrote:
> > PS: Point one is missing in the timeline from the ideas page[0], can someone
> >     explain what exactly it wants?
> 
> I don't understand the question; could you restate it?

I was talking about this point: " The suggestion to fix an interrupted rebase-i
or cherry-pick due to a commit that became empty via git reset HEAD (in builtin/commit.c)
instead of git rebase --skip or git cherry-pick --skip ranges from annoying to confusing.".

> > Points to work on:
> > ------------------
> >     - Add `git cherry-pick --skip`
> 
> I'd reword this section as 'Consistently suggest --skip for operations
> that have such a concept'.[1]

Alright! I'll correct this in comming revisions.

> >     - [Bonus] Deprecate am-based rebases
> >     - [Bonus] Make a flag to allow rebase to rewrite commit messages that
> >           refer to older commits that were also rebased
> 
> I'd reorder these two.  I suspect the second won't be too hard and
> will provide a new user-visible feature, while the former will
> hopefully not be visible to users; if the former has more than
> cosmetic differences visible to user, it might transform the problem
> into more of a social problem than a technical one or just make into
> something we can't do.

There is no "order" in these points, just a rough TODO list, but I get your point here.
 
> > Proposed Timeline
> > -----------------
> >     + Community Bonding (May 6th - May 26th):
> >         - Introduction to community
> >         - Get familiar with the workflow
> >         - Study and understand the workflow and implementation of the project in detail
> >
> >     + Phase 1  (May 27th - June 23rd):
> >         - Start with implementing `git cherry-pick --skip`
> >         - Write new tests for the just introduced flag(s)
> >         - Analyse the requirements and differences of am-based and other rebases flags
> 
> Writing or finding tests to trigger all the --skip codepaths might be
> the biggest part of this phase.  Implementing `git cherry-pick --skip`
> just involves making it run the code that `git reset` invokes.  The
> you change the error message to reference `<command> --skip` instead
> of `git reset`.  What you're calling phase 1 here isn't quite
> microproject sized, but it should be relatively quick and easy; I'd
> plan to spend much more of your time on phase 2.
> 
> >     + Phase 2  (June 24th - July 21st):
> >         - Introduce flags of am-based rebases to other kinds.
> >         - Add tests for the same.
> 
> You should probably mention the individual cases from "INCOMPATIBLE
> FLAGS" of the git rebase manpage.  Also, some advice for order of
> tackling these: I think you should probably do --ignore-whitespace
> first; my guess is that one is the easiest.  Close up would be
> --committer-date-is-author-date and --ignore-date.  Re-reading, I'm
> not sure -C even makes sense at all; it might be that the solution is
> just accepting the flag and ignoring it, or perhaps it remains the one
> flag the interactive backend won't support, or maybe there is
> something that makes sense to be done.  There'd need to be a little
> investigation for that one, but it might turn out simple too.  The
> --whitespace={nowarn|warn|fix|error|error-all} flag will be the
> kicker.  I don't know how long that one will take, but I'm certain
> it's harder than the other flags and it might conceivably take up most
> the summer or even extend beyond.
> 
> >     + Phase 3  (July 22th - August 19th):
> >         - Act on [Bonus] features
> >         - Documentation
> >         - Clean up tasks
> 
> I'd prefer that Documentation updates were made as you went; you'll
> particularly need to look at Documentation/git-cherry-pick.txt and
> Documentation/rebase.txt, especially the "INCOMPATIBLE OPTIONS" and
> "BEHAVIORAL DIFFERENCES" sections of the latter.

Thanks for advice, yes, of course, the documentation and implementation will go
hand in hand.
 
> Also, as far as timing goes, the rewriting of commit messages seems
> relatively straightforward; you may want to consider doing it before
> the --whitespace flag (despite the fact that I originally suggested it
> as a bonus item).  Deprecating am-based rebases, on the other hand, is
> a bit of a wildcard.  It depends on Phase 2 being completed so it
> definitely makes sense to be last.  If phase 2 is complete, it's
> conceivable that deprecating am-based rebases only takes a little more
> work, but it might expand to use up a lot of time.
> 
> > Relevant Work
> > =============
> > Dscho and I had a talk on how a non-am backend should implement `git rebase
> > --whitespace=fix`, which he warned may become a large project (as it turns
> > out it is a sub-task in one of the proposed ideas[0]), we were trying to
> > integrate this on git-for-windows first.
> > Keeping warning in mind, I discussed this project with Rafael and he suggested
> > (with a little bit uncertainty in mind) that I should work on implementing
> > a git-diff flag that generates a patch that when applied, will remove whitespace
> > errors which I am currently working on.
> 
> It's awesome that you're looking in to this, but it may make more
> sense to knock out the easy parts of this project first.  That way the
> project gets some value out of your work for sure, you gain confidence
> and familiarity with the codebase, and then you can tackle the more
> difficult items.  Of course, if you're just exploring to learn what's
> possible in order to write the proposal, that's fine, I just think
> once you start on this project, it'd make more sense to do the easier
> ones first.

Yes, I'm looking into the code to get some clear vision.

> Hope that helps,
Yes! The vision in now clearer. Thanks Elijah. :)
> Elijah

Thanks for the review
Rohit
