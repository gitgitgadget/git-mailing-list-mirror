Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9587D1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 23:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfH3XW0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 19:22:26 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43248 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfH3XW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 19:22:26 -0400
Received: by mail-vs1-f65.google.com with SMTP id l63so5761953vsl.10
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7qAcPvDLuGoyAOr3XlyYgaT+1Hllza5ICy1Ly/xwRk=;
        b=CH0KT2P8XLb5EuMQZGZlGUbP1RS/IahoKTnvZCu5vBp5cATYYve7HhAJeKzwk7f98k
         j3u+4VwP+qYdicqtGCDGSuIr0jbFNiMOQBchkt0dQ4K4NNDDl4WCL/ftJ4l2RQDr21C6
         V10CBarZ/NhLG16y96QOTDSSxX3Upi5rgq9+zMuic4tl3AL2NVQOs617WHRjbUaztr29
         6cny6bmnDTx26gxrXYL7J3mK4oVtgknwacOGk6yxGwpJCem3qWFppw2y/KbgCJQOctQL
         K6g9bWKDKGEA9vff6cSW/4j8JZqZ+Gly1ZHi4KdvwIKZdQ4UskRKyebGLP+6L4iqZW/W
         Fziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7qAcPvDLuGoyAOr3XlyYgaT+1Hllza5ICy1Ly/xwRk=;
        b=FGSYhVLpY5Sh0hQnIoJH3/m6Lk5ujADMNqrmlmBdjfg9NpdOEO9HUMeJFQd0d4E947
         8cs2X0QP1mHKoCpXjrLj9bwdcNNSUCXYJOpTFZ116sbhsM8IfW+/HHSc8zf9cEQ/wp1h
         eMKu27aM95yloCq/v0C5ow6rrWQmSbwkKGevRq31h+UU2RrYSwfm6SiDLDsY7qtauI5f
         auL1O9YgWy7ud5sojSZZsoJHewJr7EM1zWMFHrsTf/l1DqP+7NgDqyhh/hZWhUKWzT7Y
         +3A+jVZYry372JV3ZbknGgTGwKkiEUjNpgIts+fCZIvpMS+ZCT2wTQ/KU0CzU5iA7Ngw
         mwdQ==
X-Gm-Message-State: APjAAAWP/jgZGRuzcX8jqZhDYCj7dp2Fyp4Fd1+KBLPZ+YU4qpnZo0kK
        H6+ldaJWZJlFUlGFFEhKTrKcjP73XPbZ4oaqQdc=
X-Google-Smtp-Source: APXvYqw1UehqgTqn6Vk2Dv7zpLX3Bpd/hLtlWaGgaxfOQdHnzkzfahLx98xhzdyi54/i0EEemYpJRG+gycj7eMButZY=
X-Received: by 2002:a67:f08e:: with SMTP id i14mr1609366vsl.175.1567207344572;
 Fri, 30 Aug 2019 16:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com>
 <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru>
 <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com>
 <87blw93c5n.fsf@osv.gnss.ru> <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1908302221210.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908302221210.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Aug 2019 16:22:10 -0700
Message-ID: <CABPp-BHMXAQGPaBYyg2dtVeN5h8fW8G4YdhddCeAjY5r74BAzw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Aug 30, 2019 at 1:40 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
>
> On Wed, 28 Aug 2019, Elijah Newren wrote:
>
> > Hi Sergey,
> >
> > On Wed, Aug 28, 2019 at 1:52 AM Sergey Organov <sorganov@gmail.com> wrote:
> > >
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > > > On Tue, Aug 27, 2019 at 1:43 AM Sergey Organov <sorganov@gmail.com> wrote:
> > > >>
> > > >> Eric Wong <e@80x24.org> writes:
> > > >>
> > > >>
> > > >> [...]
> > > >>
> > > >> > AFAIK, filter-branch is not causing support headaches for any
> > > >> > git developers today.  With so many commands in git, it's
> > > >> > unlikely newbies will ever get around to discover it :)
> > > >> > So I think think we should be in any rush to remove it.
> > > >>
> > > >> Nah, discovering it is simple. Just Google for "git change author". That
> > > >> eventually leads to a script that uses "git filter-branch --env-filter"
> > > >> to get the job done, and I'm afraid it is spread all over the world.
> > > >>
> > > >> See, e.g.:
> > > >>
> > > >> https://help.github.com/en/articles/changing-author-info
> > > >
> > > > Side note: Is the goal to "fix names and email addresses in this
> > > > repository"?  If so, this guide fails: it doesn't update tagger names
> > > > or email addresses.  Indeed, filter-branch doesn't provide a way to do
> > > > that.  (Not to mention other problems like not updating references to
> > > > commit hashes in commit messages when it busy rewriting everything.)
> > >
> > > No. Maybe the original goal was like that, by I, personally, use
> > > modified version of this to change my "Author" credentials from
> > > "internal" to "public" in branches that I'm going to send upstream, so
> > > the actual aim is to change e-mail of particular Author from a@b to c@d
> > > in all the commits in a (feature) branch.
> >
> > There's an interesting usecase I hadn't heard of or thought of before.
>
> I'll throw in another use case that's kinda related: extracting the
> history of one file (or subdirectory).

Thanks for sending these along!  I do have some comments, and a bunch
of questions...

> In my most recent instance of this, I wanted to publish the script I
> used to use for submitting patch series to the Git mailing list,
> maintaining tags for iterations and generating cover letters from branch
> descriptions and interdiffs (this script eventually became GitGitGadget,
> https://github.com/gitgitgadget/gitgitgadget/commits?after=6fb0ede48f86e729292ee1542729bc0f5a30cfa6+0
> demonstrates this).
>
> To do that, I ran a `git filter-branch` in the repository where I track
> all the scripts I deem unsuitable for public consumption, to remove all
> files but `mail-patch-series.sh`, then pushed it to
> https://github.com/dscho/mail-patch-series
>
> Please note that most crucially, I wanted to rewrite a newly-created
> branch, and only that branch.
>
> Could I have done the same using `git fast-export`, filtering the output
> with a Perl script, then passing it to `git fast-import`? Sure, I was
> really tempted to do that. In the end, it took less of _my_ time to just
> let `git filter-branch` do its work with a not-too-complicated index
> filter.

Why a perl script?  Shouldn't
    git fast-export [--no-data] HEAD -- $PATH | git fast-import --force --quiet
do the trick?  And it's probably simpler and shorter than the index
filter you used.

That said, yeah it'd be nice to get automatic rewriting of commit
hashes in commit messages and other niceties from filter-repo (e.g.
future automatic reattaching of notes to the rewritten commits).  Some
questions:

  * What's the backup strategy in case you specify the wrong filters
(e.g. you have a typo in the pathnames)?  filter-repo encourages folks
to make a clone and then filter the fresh clone, because if anything
goes awry, you can just delete and restart.  (I am heavily opposed to
the refs/original/ backup mechanism used by filter-branch, for
multiple reasons.)  Is your safety stance just "If I mess up it's my
own fault; do the rewrite?"  Or are you okay with cloning before
filtering?
  * If you're okay with cloning before filtering...then is there an
issue with rewriting all branches, and just pushing the one you need?
(Is there an issue with "this branch is small, the others are huge,
and filter-branch is slow -- so rewriting one branch saves me lots of
time"?  Or are there other issues at play too?)
  * What if the user has auxiliary information for the branch in other
refs?  For example, git-notes pointing at any of the commits, or tags
in the history of the branch that might be relevant, or perhaps even
replace refs in combination with GIT_NO_REPLACE_OBJECTS=1?  Is this an
"I don't care, toss that stuff and just rewrite just this branch?"
  * filter-repo by default creates new replace references so that you
can refer to new commit IDs using old (unabbreviated) commit IDs.
Would that be considered helpful for this usecase?  unhelpful?
irrelevant, since you'll just push the branch you want somewhere and
nuke the temporary clone?


I'm not by any means ruling out the possibility of documenting --refs
and adjusting the defaults when it is used so the user can just run
something like
   git filter-repo --path $PATH --refs $MYBRANCH
but I feel like I need to understand answers to questions like the
above ones so that I can know how to phrase warnings and adjust
defaults and update the documentation.

> In another instance, a long, long time ago, I needed to restart a
> repository which had included way too many files for its own good, then
> rename the old repository and start with a fresh `master` that contained
> but a single commit whose tree was identical to the previous `master`'s
> tip commit. I simply grafted that commit, ran `git filter-branch` and
> had precisely what I needed.

filter-repo supports grafts and replace objects, the same as
filter-branch.  (Although, technically, I didn't have to do a thing to
support it; fast-export does the special handling of rewriting based
on grafts and replace objects.)  So, I'd say this is fully supported.

Side question: the git-replace documents suggest that the graft file
is deprecated.  Are there any timeframes or plans for phasing out
beyond the git-replace manpage existing?  Should I avoid documenting
the graft file support in filter-repo?  Should I include examples
using not just git-replace but also using the graft file?

> I would be _delighted_ if these kinds of use case (rewriting a branch,
> or even just a commit range) became more of a first-class citizen with
> `git filter-repo`.

I've got all the pieces for supporting a single branch or a commit
range (e.g. 'git filter-repo --path foo --refs ^master~4 ^stable~23
mybranch'), but the defaults (error out unless in a bare repo, move
refs/remotes/origin/* to refs/heads/*, disconnect origin remote,
expire reflogs & repack & prune, create new replace references so
folks can access new commits using old commit IDs) may be somewhat
friction-filled for this usecase.  Those defaults other than the new
replace refs happen to all be turned off with the combination of
--force and --target, so, assuming turning them off is what you need,
you could cheat and just specify 'git filter-repo --force --target .
--refs $MYBRANCH' today and perhaps get what you want, but that's a
really non-intuitive command line that is way too ugly to recommend.
And I don't want to tie myself to '--target .' being the magic sauce
in the future either.
