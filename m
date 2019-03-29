Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1253320248
	for <e@80x24.org>; Fri, 29 Mar 2019 15:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfC2Pfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 11:35:48 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39223 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfC2Pfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 11:35:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id d5so811912uan.6
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuSl+UK1gGbxYyx5+D97972UGyPUWfFU4pxZ8rZlgR8=;
        b=AS6FTt6lfeWf2j7jOCO3Z013gpLmX5WySW3V8vCCkomYyHKeYYkdgj9YobsN3Dd4oQ
         eM7e4FpckEMn1KKPAChn0MlC9T8cSJhoUpeg2Y/okWyd4msrjf5AFY89mDGpcGrN12WK
         JstOOA2bC90RUm8xRo1dosb6xHPxKrnioRbhFSvQPH2Hw26lgLQEtck8rQi580IA2bNJ
         R1FuMDVuPThXmDGa++GnkK8e7oq3vFayxuvSlVyjR/jPsoEfHMdFAhmw6lnRzY/GRUMC
         prgy0iH0U3E5+RRcgK+zdDhraKcLgy2YoFnEhhQXyo+NxFzfQyzVL1ay+FWAtdIaC0ta
         X6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuSl+UK1gGbxYyx5+D97972UGyPUWfFU4pxZ8rZlgR8=;
        b=kH5lNhuzTx3kG5n+mJvVhMgGFyfTLx1DfgsEAEh7BFsViV0RMc9NxppAT8+iyYQsp8
         oo3K5WI2We09yXqIy6VSYSKulhQluIYW4MfaDMR953YxlAmqwcw/ocfDXJiSjlP81CyJ
         VRlai9N1DowRzvyAJLGNDPPKg+fb5sqBLFcRtnmTh4WR9htHYiClVpq2kxwVKpsY6dlL
         uy074TbAd6mRTjHa+pVYtqP/42AMAFg+kqFvKr9k75d0ROzzt2EeqExIwchSCnpabX+l
         4LUBbGf+IQrLffjHjZu4NaLCdoV23Bg/JOem3VGbKZC6/IWwpfAt1Tk1kXFb28gpXExa
         E8Tw==
X-Gm-Message-State: APjAAAX63TVq94glrDPtWloffuOOOXVkgtwoQxN4daBhYQbGtsQShnlk
        inyXwAmUOEOCMNXQasconQLHUJyIU7/+/qLDT3M=
X-Google-Smtp-Source: APXvYqw40Doax5ksnnPTrqiK5ozyaIyISZP5PgokqCrIQXzDQsHUJFWbidWIb0IeBtxVQjjGSm+8Oth0wXsNJ9Z60Ok=
X-Received: by 2002:ab0:21c5:: with SMTP id u5mr18034955uan.81.1553873747153;
 Fri, 29 Mar 2019 08:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
 <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
 <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com> <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
 <a68ce0b4-81c5-e889-fc90-ed8b17a10d4a@gmail.com> <CABPp-BHsD=o=3jPKH6gH+XbEdNVqzhr18BSfupbaSNpxAgaqdw@mail.gmail.com>
 <42ba7f39-4a8e-9866-eebd-2a4dd5ff8414@gmail.com>
In-Reply-To: <42ba7f39-4a8e-9866-eebd-2a4dd5ff8414@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Mar 2019 08:35:34 -0700
Message-ID: <CABPp-BGE49LyxQSMd8v_af=X_N9b0GyOk6TMK6jb8w1GMy6x+g@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, Mar 29, 2019 at 4:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 28/03/2019 17:39, Elijah Newren wrote:
> > On Thu, Mar 28, 2019 at 9:23 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >> On 28/03/2019 11:04, Duy Nguyen wrote:

> >>> Just so we're clear, what is your "the way" to go? to remove
> >>> CHERRY_HEAD_PICK and MERGE_HEAD (and other MERGE_* as well) if
> >>> --ignore-in-process is specified? Or to leave MERGE_* and
> >>> CHERRY_PICK_HEAD alone and delete other stuff?
> >>
> >> I was agreeing with Elijah about dropping --ignore-in-progress unless
> >> there's a demand for it or at least restricting it so that it requires
> >> --discard-changes and aborts in-progress merges and single in-progress
> >> cherry-picks/reverts. (I'm worried about people switching branches when
> >> cherry-picking more than one commit, though as you say it can make sense
> >> during a rebase.)
> >
> > I understand the desire to prevent mis-uses, and I agree that if there
> > are staged changes or conflicts it's really likely things will go
> > sideways.  But I think we should instead check for those situations
> > rather than use e.g. rebase vs. merge as a proxy for whether those
> > problems could be present.
>
> When cherry-picking multiple commits if the user commits the conflict
> resolution with 'git commit' then the presence of .git/sequencer is the
> only sign that a cherry-pick is in progress (wt-status.c fails to detect
> this, I've got a fix but no tests yet). rebase can also stop without
> having conflicts or staged changes so I think we need to check for in
> progress commands as well as conflicts (what do we want to do if someone

This whole discussion is about "--ignore-in-progress" which implicitly
implies we are checking for in progress commands and choosing whether
to override it.  So I don't understand what you mean by saying we need
to check for it; isn't that a given?

> tries to switch in the middle of a bisect? - I don't have a strong
> opinion). I agree switch should fail if there are conflicts, but I think
> it is fine to switch with staged or unstaged changes if there isn't a
> merge etc in progress (I quite often start working on something and
> then realize I haven't started a new branch just before I commit). I
> could possibly be convinced that silently switching with staged changes
> is always a bad idea though.

I think we might be missing the big picture by trying to discuss
things in terms of in-progress operations or conflicts or staged
changes or unstaged changes.  Allow me to attempt to reframe the
discussion:  We have identified at least one case where allowing the
--ignore-in-progress flag would be unsafe, and we've identified one
where we think it would be safe and useful, thus we need a rule of
thumb for when it is safe to use and when it isn't.  Here's my
attempt:

  --ignore-in-progress is safe enough for usage if we can switch to
another branch and back with no net overall changes to either the
index or the working tree after the two switches.

This rule could allow for the presence of both staged and unstaged
changes (or maybe even conflicts in some alternate world where
checkout/switch didn't necessarily error out on those), depending on
if switch/checkout can operate without touching those particular files
as part of switching.

> > I am especially concerned with the idea of
> > having something like "git switch --ignore-in-progress
> > --discard-changes" being used to quit merges or cherry-picks or
> > reverts or even rebases. In my opinion, doing so is creating flags to > combine uncommon pairs of git commands (git <operation> --quit + git
> > switch) in a way that is far less clear.  I think that's a bad route
> > to go down, and we should keep the commands orthogonal
>
> keeping commands orthogonal is certainly clearer, if less convenient -
> lets do it (assuming Duy agrees).

Yaay!

> > (if I could
> > start all over, I'd also make reset and checkout and everything else
> > stop modifying any in-progress state).
> >
> > Instead, I would either:
> >
> >    * Drop `--ignore-in-progress` for now.  (Although Duy had a
> > meaningful usecase)
>
> I think it could be useful during a rebase, I'm not sure about any of
> the other operations though.

I think it could be useful during some rebases, but it should not be
allowed if the user can't switch back to the current commit with no
net overall changes to the index or working tree.

Also, I don't see how rebase is unique here.  Rebase, cherry-pick,
merge, and revert can all stop with conflicts, staged changes, and
unstaged changes.  All of them can also stop without any one of those
(e.g. cherry-pick'ing a commit which has been piecemeal applied
already, merging a branch whose individual changes have already been
cherry-picked and when the user has specified --no-commit, or
reverting a commit whose changes have already been unapplied).  Thus,
I continue to believe that which operation is in progress is
irrelevant.  Either we shouldn't allow switching during any
in-progress operation, or we should determine some other criteria for
when it is safe to allow --ignore-in-progress.  Basing it on the
operation would sometimes allow --ignore-in-progress to be used when
it shouldn't be, and disallow it sometimes when it shouldn't.  I'm a
fan of the rule I mentioned up above ("if we can switch and switch
back with no net changes then it's safe enough to allow")

> >
> > OR
> >
> >    * Make `git switch --ignore-in-progress <branch>` leave all process
> > state in place and switch branches, if we would otherwise be able to
> > switch branches (i.e. there isn't dirty or conflicted changes in the
> > way).
>
> I thought we allowed branch switches when there are staged or unstaged
> changes, I don't think that is a problem unless we're in the middle of a
> merge etc. I'm still not sure it's a good idea to switch branches in the
> middle of a multiple cherry-pick, maybe we should print a warning.

I didn't say to disallow it if there were dirty or conflicted changes,
I said to disallow it if there were dirty or conflicted changes *in
the way*.  We don't allow branch switches when dirty changes would be
overwritten or need to be merged, as that can't easily be reversed.  I
think --ignore-in-progress should only be allowed when it can be
easily reversed to get the user back to the right branch/commit.

This "no net changes" rule also reinforces (or is reinforced by) the
other suggestion I made of having --ignore-in-progress be made
incompatible with both -m and --discard-changes.

But I totally agree that switching branches during the middle of some
operation should print a warning -- not just for cherry-pick, but for
merge or rebase or revert too.  In all cases it'll be important to
tell the user both that they could really mess things up if they try
to resume the operation without switching back, and telling the user
how to get back to where they used to be (in rebase's case, that'd be
"git switch --ignore-in-progress <previous-commit>" while for the
other three it'd be "git switch --ignore-in-progress
<previous-branch>").
