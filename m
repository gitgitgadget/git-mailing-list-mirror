Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A640520248
	for <e@80x24.org>; Sun, 24 Mar 2019 01:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCXBHa (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 21:07:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42197 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXBHa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 21:07:30 -0400
Received: by mail-vs1-f67.google.com with SMTP id f15so3439908vsk.9
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CorDdvYmNzcxQIjNth0oCjM+x82bpQFrhnTpCmee9CI=;
        b=iOa8onQQ2pegKjmJI1+wNROQYCmEadGLbg5OrKSdhuBKBIKZtC3fyY+D4qV72mAo4/
         pchOz7w/3eH5AaNQonMeMBN5I2JjkP4LJaWIn79WQsahEh77HN51OTwFVvrgiF9nSpmg
         nnTq+OxO4F5oq3ITJtop8TYXA4zjQrZvRAvOPjqHVjjoURTgQavNBHKX4engOnrgcVnr
         ls3RoORArCKlAzsthirrGrG3c4QJAJKdmUfpNHByWCfvj7lrRbb8c5HxEUb1Ccq5tEmf
         07v4vuIwu4pcpom7KnBtL+5KPJ/FZVcqQHOMiacagB2ItvMsd1AtujXIOs3x7FG1CzG1
         yuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CorDdvYmNzcxQIjNth0oCjM+x82bpQFrhnTpCmee9CI=;
        b=rLkZV5/vIZg9s721pmrmqUYEXX6hfAzpdrj8QSfXdqo5x74MvrWbujhqFDs1P8aHiS
         bzE0w8r9HsZLHAsLUTfD7V2BOlkd0K35SBa03lHHcjlTiEbKZ63sPQ876st8BECNEYS4
         kc9tWMwYgHm3pnXpIlmYe7Lb7meo2o5GSqKNstbzP3jIwnb7sZ/EU5qBNsuMVuw8YWGa
         DpV5dl2pyMuTmqF7NWHWZqYVTfM+vmiJeY1l2DVMPUxYamXAf0uYD9K/NhZPBM9DJXRs
         kd5NNpv6l9xhgs4ZiTzz2uwXUAqlVt9omL1XlRmF9n0hcmF1+cIDQflor47Hy4zJ2h03
         NP+A==
X-Gm-Message-State: APjAAAWnuEszhM9RmM7vKjSeWG2v5T4hyP8p902S9scI2oaZkjaaRLLv
        uDuwjyyiHb0zPqofKlDW788uXDFp1KMc7gdwkFI=
X-Google-Smtp-Source: APXvYqw7Xs4fNCEVnt3bqxpkOTUvW08kd7A9Ta6WVq5r8LJJIJMngLXMx/Grn2mHTGo8sThuRyFhp2EKiPZw3danuCQ=
X-Received: by 2002:a67:b145:: with SMTP id z5mr10810363vsl.53.1553389648856;
 Sat, 23 Mar 2019 18:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <20190322151157.9550-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190322151157.9550-1-rohit.ashiwal265@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Mar 2019 18:07:17 -0700
Message-ID: <CABPp-BEdgSHGTkUcg_UDRu50Ag+cCqigmvU4_JaRZRnDpgWcdA@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        artagnon@gmail.com, Stephan Beyer <s-beyer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit!

On Fri, Mar 22, 2019 at 8:12 AM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Hey People
>
> I am Rohit Ashiwal and here my first draft of the proposal for the project
> titled: `Improve consistency of sequencer commands' this summer. I need your
> feedback and more than that I need help to improve the timeline of this
> proposal since it looks very weak. Basically, it lacks the "how" component
> as I don't know much about the codebase in detail.
>
> Thanks
> Rohit
>
> PS: Point one is missing in the timeline from the ideas page[0], can someone
>     explain what exactly it wants?

I don't understand the question; could you restate it?

> Points to work on:
> ------------------
>     - Add `git cherry-pick --skip`

I'd reword this section as 'Consistently suggest --skip for operations
that have such a concept'.[1]

Adding a --skip flag to cherry-pick is useful, but was only meant as a
step.  Let me explain in more detail and use another comparison point.
Each of the git commands cherry-pick, merge, rebase take the flags
"--continue" and "--abort"; but they didn't always do so and so
continuing or aborting an operation often used special case-specific
commands for each (e.g. git reset --hard (or later --merge) to abort a
merge, git commit to continue it, etc.)  Those commands don't
necessarily make sense to users, whereas '<operation> --continue' and
'<operation> --abort' do make intuitive sense and is thus memorable.
We want the same for --skip.

Both am-based rebases and am itself will give advice to the user to
use 'git rebase --skip' or 'git am --skip' when a patch isn't needed.
That's good.  In contrast, interactive-based rebases and cherry-pick
will suggest that the user run 'git reset' (with no arguments). The
place that suggests that command should instead suggest either 'git
rebase --skip' or 'git cherry-pick --skip', depending on which
operation is in progress.  The first step for doing that, is making
sure that cherry-pick actually has a '--skip' option.

>     - Implement flags that am-based rebases support, but not interactive
>           or merge based, in interactive/merge based rebases

The "merge-based" rebase backend was deleted in 2.21.0, with all its
special flags reimplemented on the top of the interactive backend.  So
we can omit the deleted backend from the descriptions (instead just
talk about the am-based and interactive backends).

>     - [Bonus] Deprecate am-based rebases
>     - [Bonus] Make a flag to allow rebase to rewrite commit messages that
>           refer to older commits that were also rebased

I'd reorder these two.  I suspect the second won't be too hard and
will provide a new user-visible feature, while the former will
hopefully not be visible to users; if the former has more than
cosmetic differences visible to user, it might transform the problem
into more of a social problem than a technical one or just make into
something we can't do.

> Proposed Timeline
> -----------------
>     + Community Bonding (May 6th - May 26th):
>         - Introduction to community
>         - Get familiar with the workflow
>         - Study and understand the workflow and implementation of the project in detail
>
>     + Phase 1  (May 27th - June 23rd):
>         - Start with implementing `git cherry-pick --skip`
>         - Write new tests for the just introduced flag(s)
>         - Analyse the requirements and differences of am-based and other rebases flags

Writing or finding tests to trigger all the --skip codepaths might be
the biggest part of this phase.  Implementing `git cherry-pick --skip`
just involves making it run the code that `git reset` invokes.  The
you change the error message to reference `<command> --skip` instead
of `git reset`.  What you're calling phase 1 here isn't quite
microproject sized, but it should be relatively quick and easy; I'd
plan to spend much more of your time on phase 2.

>     + Phase 2  (June 24th - July 21st):
>         - Introduce flags of am-based rebases to other kinds.
>         - Add tests for the same.

You should probably mention the individual cases from "INCOMPATIBLE
FLAGS" of the git rebase manpage.  Also, some advice for order of
tackling these: I think you should probably do --ignore-whitespace
first; my guess is that one is the easiest.  Close up would be
--committer-date-is-author-date and --ignore-date.  Re-reading, I'm
not sure -C even makes sense at all; it might be that the solution is
just accepting the flag and ignoring it, or perhaps it remains the one
flag the interactive backend won't support, or maybe there is
something that makes sense to be done.  There'd need to be a little
investigation for that one, but it might turn out simple too.  The
--whitespace={nowarn|warn|fix|error|error-all} flag will be the
kicker.  I don't know how long that one will take, but I'm certain
it's harder than the other flags and it might conceivably take up most
the summer or even extend beyond.

>     + Phase 3  (July 22th - August 19th):
>         - Act on [Bonus] features
>         - Documentation
>         - Clean up tasks

I'd prefer that Documentation updates were made as you went; you'll
particularly need to look at Documentation/git-cherry-pick.txt and
Documentation/rebase.txt, especially the "INCOMPATIBLE OPTIONS" and
"BEHAVIORAL DIFFERENCES" sections of the latter.

Also, as far as timing goes, the rewriting of commit messages seems
relatively straightforward; you may want to consider doing it before
the --whitespace flag (despite the fact that I originally suggested it
as a bonus item).  Deprecating am-based rebases, on the other hand, is
a bit of a wildcard.  It depends on Phase 2 being completed so it
definitely makes sense to be last.  If phase 2 is complete, it's
conceivable that deprecating am-based rebases only takes a little more
work, but it might expand to use up a lot of time.

> Relevant Work
> =============
> Dscho and I had a talk on how a non-am backend should implement `git rebase
> --whitespace=fix`, which he warned may become a large project (as it turns
> out it is a sub-task in one of the proposed ideas[0]), we were trying to
> integrate this on git-for-windows first.
> Keeping warning in mind, I discussed this project with Rafael and he suggested
> (with a little bit uncertainty in mind) that I should work on implementing
> a git-diff flag that generates a patch that when applied, will remove whitespace
> errors which I am currently working on.

It's awesome that you're looking in to this, but it may make more
sense to knock out the easy parts of this project first.  That way the
project gets some value out of your work for sure, you gain confidence
and familiarity with the codebase, and then you can tackle the more
difficult items.  Of course, if you're just exploring to learn what's
possible in order to write the proposal, that's fine, I just think
once you start on this project, it'd make more sense to do the easier
ones first.


Hope that helps,
Elijah
