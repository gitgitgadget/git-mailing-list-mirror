Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2346720248
	for <e@80x24.org>; Mon, 25 Mar 2019 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfCYPmM (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 11:42:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35968 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYPmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 11:42:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id d18so6358816lfn.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkhSWwdsR4jZUMiXLHmA6oAmHPhe30BMoYsfQpY/ADY=;
        b=G775IXjMr7pIYRxSdQF0tXe15xKfi28OCjmfbysvhD4LYLfsmogxFgped50uW3WOi8
         bnFRRizeAjZG5IO5GiqKLh4cY3imdMl1qP/7/XG/e7JyrlCg8JLsEtl5hP/mhP4Mnan1
         +BW8sQMjwX37U0RyXjB21DTWw7CM1PyK4pHVwsFeGi+LPMbhHFw1GApDC1I/KjFTkRMt
         htouIWmY4D7KvFao7oKkvGziMm2BsnPsBYzEPDo03TLnq5sGpsPg2q7vbm43idkR5Jay
         qfUrTd++cFGzFBad4e9KI74FdNBgzeYiTLxF8ytV4+4w9iISDW4C13NtvTSxuChfxBo2
         +maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkhSWwdsR4jZUMiXLHmA6oAmHPhe30BMoYsfQpY/ADY=;
        b=T6g9Q49rC6jZl9o5s0Gxxryk9hYIsBSR167L5Ho8yTX1kcEf0YaCRiFlV4+FFA9OU1
         E4nILY8rcdfNq0XPgx2pwZpbOT5co3vjIuNusLYP07cClRRZ5/VgNp94nci3rI7uLTcs
         PDGkRnXhn4lKMBwroP0Y5Bm5OCdhO/r/hgnmfjGmc1NrBz9J5fhNOX3wuOr/Bz5/nHXA
         kY6ZH0XtVRpRfZrS90dF+wAumxwjP35vVPzsV9s5+znruFBylKF6YeiF7kE3yWSY8LvG
         T4COypQZOOPNUd5bjKfmbTetEXrJ7vsmkjr4Y3N35l/avrsX0rc2fPGtqIJ5B6xKmzjk
         gB4g==
X-Gm-Message-State: APjAAAU3TGy4oBwvwuGgald6/U4t+60TqFZNqvYmWYDpTjK/u1FmkrOz
        M5NeVrtwtHxP1b9Xnv7HaRfDZgL1i14b1AlUFMW2aH8WBGE=
X-Google-Smtp-Source: APXvYqzjyXKnsfWVbHTintr+TdPaMcpbPdenHhJvJVIDFeRGVbkDhOoRB+/dzTfA0vuHduyJJHDYjD5aEHZrKk0q+HM=
X-Received: by 2002:ac2:5479:: with SMTP id e25mr11563786lfn.121.1553528527589;
 Mon, 25 Mar 2019 08:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
 <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com> <871s31vjo7.fsf@javad.com>
 <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
 <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com> <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
 <87pnqklr8a.fsf@javad.com> <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
 <878sx8lpqw.fsf@javad.com> <xmqqbm24sk68.fsf@gitster-ct.c.googlers.com>
 <87k1gsh1zs.fsf@javad.com> <xmqqy357r6im.fsf@gitster-ct.c.googlers.com>
 <8736nfc4t9.fsf@javad.com> <CALm+SV+mD0oKfQqZBDUixyB6ckHLchj83=0mh7wxuhC5G6kfgQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1903251544260.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903251544260.41@tvgsbejvaqbjf.bet>
From:   "C.J. Jameson" <cjcjameson@gmail.com>
Date:   Mon, 25 Mar 2019 08:41:56 -0700
Message-ID: <CALm+SVL6ZyVVPqLEiwEzXru8TOjP7JVfpH=THdT9nLvH84O_Mg@mail.gmail.com>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 7:56 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi C.J.
>
> On Fri, 22 Mar 2019, C.J. Jameson wrote:
>
> > Confirming Sergey's summary: at this point, I think my only residual
> > opinion is that requiring `-m 1` or `--mainline 1` is a little cryptic
> > for someone who's just cherry-picking a single commit, which happens
> > to be a merge commit.
>
> Two points:
>
> - You do not happen to cherry-pick a merge commit. If you do that, and do
>   not realize that it is a merge commit, then you have no idea what you
>   actually wanted to pick (the changes relative to the first parent? or the
>   to the second parent?). The fact that Git does not let you do that gives
>   you the opportunity to pause, think, and then be sure what you actually
>   want.
>
>   So Git does the right thing there.
>
> - If it is a little cryptic that `-m 1` (or `-m 2` or `-m 3` or...) is
>   needed, then this needs to be made less cryptic. A fantastic idea would
>   be to teach Git to mention this hint in the exact circumstance when it
>   matters most: when the user just tried to cherry-pick a merge commit.
>
>   I actually do not know whether Git does the right thing there. If it
>   does not, that would be a good direction to focus your efforts on.
>
> > `--no-forbid-merges` would be the thorough way of accommodating it, but
> > it's even more verbose and you'd still need to discover it...
>
> But it would definitely make sure that we do not pretend that merge
> commits are anything like non-merge commits.
>
> As I pointed out elsewhere in this thread: non-merge commits' purpose in
> life is to introduce something new, in a relatively small, neat package.
> If it does not fit into one small, neat package, you need to split it
> among multiple non-merge commits.
>
> A *merge commit*'s purpose in life is not to introduce something new, but
> to reconcile diverging changes. I.e. it is more of a moderator, a mediator
> between battling non-merge commits. Often, the only real changes a merge
> commit introduces are changes that are necessary to make the two diverging
> branches work well together.
>
> It can be hard in practice to appreciate the difference, but it is very
> real.
>
Totally. My context is that we have way too many low-value / no-value merge
commits in our repo, and we put our version tags on the merge commits rather
than the non-merge commits (the ones with the meaningful code changes).
I wish it were different...

It's cool you phrase it this way, because it highlights how our repo's settings
stray from the meaningful purpose-in-life of these git fundamentals. In Gitlab
(same is possible in Github), we have our repo configured to:

- always create a merge commit when merging to master, even if it's
  fast-forwardable
- auto-squash all Merge Requests / Pull Requests into one commit
  when merging

Thank you all for helping me get a very deep understanding of the matter,
because it enables me to keep pushing my team to select different settings.

> For example, when you `git cherry-pick -m 1 <merge>`, you will typically
> end up with a *ton* more merge conflicts than when you cherry-pick a
> non-merge commit.
>
> And when you cherry-pick a merge commit, it is much more like performing a
> squash merge than performing a cherry-pick, and resolving the merge
> conflicts looks a lot more like bringing peace to a shouting match, much
> like when you resolve merge conflicts during a *merge* (as opposed to
> resolving merge conflicts during a cherry-pick, which feels a lot more
> like helping a patch move into a new city it does not yet quite know).
>
Yea... we don't feel the pain of squash-like merging at cherry-pick time,
because pull-requestors' merge requests have already been squashed down
whether they like it or not...! :( uff da

> (This is at least what my experience is, from working with 70+ branches
> in Windows that I maintain on top of core Git.)
>
> Ciao,
> Dscho
>
> > I'd be fine abandon this -- thanks again!
> >
> > C.J.
> >
> > On Fri, Mar 22, 2019 at 8:22 AM Sergey Organov <sorganov@gmail.com> wrote:
> > >
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >
> > > > Sergey Organov <sorganov@gmail.com> writes:
> > > >
> > > >>> With it reverted, "[alias] cp = cherry-pick -m1" can be used to train
> > > >>> the user to blindly pick a range that has a merge without thinking,
> > > >>> which is what I meant by "ship has already sailed".
> > > >>
> > > >> Did you mean "With it *not* reverted" here?
> > > >
> > > > Thanks for a correction.  Yes, if we do not revert it, then that
> > > > would allow people to follow a bad workflow we do not want to
> > > > recommend (and I think that is what Elijah does not want to do), and
> > > > that is why I said the ship has already sailed.
> > >
> > > I still don't think it makes sense to revert the patch (that fixed a
> > > real-life issue) on the sole ground that, as a side-effect, it has
> > > provided an opportunity that could potentially be abused, specifically
> > > by defining a random alias, and then shooting oneself in the foot with
> > > it. And even then no irreversible damage actually happens.
> > >
> > > Moreover, if somebody actually wants to "follow a bad workflow", he
> > > still needs to ask for it explicitly, either by providing '-m 1', or by
> > > defining and using an alias, so let him do it please, maybe he even does
> > > know what he is doing, after all.
> > >
> > > >
> > > >> Those who don't like such alias are still free not to define or use it.
> > > >
> > > > That's not the point.  Those who do want to be careful can learn to
> > > > use a new option --forbid-stupid-things, but why should they?
> > >
> > > Sure thing, who said they should? Fortunately, that's exactly the
> > > current state, no need to invent and specify any --forbid-stupid-things
> > > option, and even if we pretend the option is already there and is
> > > active by default, still no need to revert anything.
> > >
> > > > They should be forbidden from doing stupid things by default, which is
> > > > the point of this exchange.
> > >
> > > I already agreed before to assume this, and it seems that we now all
> > > agree this safety should be preserved, as there are those who actually
> > > care. However, as merges are already forbidden right now with all the
> > > current defaults, I fail to see how it could justify reverting of
> > > already applied patch.
> > >
> > > To me, the actual question here is: what's the option that overrides
> > > that default? The current answer is: "-m 1", that admittedly is not very
> > > nice, but has not been introduced by any of the recent patches, so is
> > > not solvable by reverting any of them.
> > >
> > > To summarize, as it looks to me, it's mostly the current way of allowing
> > > merges, that cryptically reads as "-m 1", that makes the OP unhappy.
> > > This was already the case before the "allow '-m 1' for non-merge
> > > commits" patch, so reverting it won't solve the problem in any suitable
> > > way.
> > >
> > > Due to all the above, may we please finally let alone the already
> > > applied patch and focus on finding (or denying) actual solution to the
> > > original issue of this thread?
> > >
> > > If so, I'm still on the ground of providing new, say,
> > > "--no-forbid-merges" option, if anything. I'm with Duy Nguyen that the
> > > way suggested by RFC, making value optional for yet another short
> > > option, is to be avoided at all costs.
> > >
> > > -- Sergey
> >
