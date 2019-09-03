Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175DE1F4B7
	for <e@80x24.org>; Tue,  3 Sep 2019 17:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfICRhV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 13:37:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33978 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICRhV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 13:37:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id r17so9018592vso.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4CpqZqggfToZaHMV+WeQpoWFy7S1kwdjiPMJn63iCw=;
        b=hItimLc9PIppIhyMsmOLvonsWhZxo7adeg/yYtbUXZAjVLFzEQI1SRmHJMYrFQH1hl
         vKr4JO3D7d4Tbtx16oSAwQeOBLkOzX1WJ6fqe05mF9N9WipVQsCPip9o+MkXRzjf1kGs
         GiiFLhLILgUaxKauTtk37HDczgb3aYuZkkt0PirydA4aKbSZndYmV661DEg7QnwS8oK3
         JcmoFURsy2W/pzPguPEPFEtvqiR0GBJeeQ/OlMHf+nqnptCFuYZPhlavblhBOyNc/y9s
         m1saLNlxJEse0O9bofIlyPcXrR62jOmdk7tuJmkbRnwyW7QO0Tatto9TNLE6CA7E2Y/r
         qlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4CpqZqggfToZaHMV+WeQpoWFy7S1kwdjiPMJn63iCw=;
        b=ED0B34OxG7IT2Ef9WqXlkpFZOJ2IyxDdLNLjGqGcX6NctF5nYSCwqshIOmZ9YBexy+
         6nYgWvT/qpX0a6/i4Or0bksJmyC5HOdhwVG0nXAdKHzAWbBH+88jj5VoqytIpM0giCh6
         0bcXtNPZgoBEa7j/ZOc7QIyGDhOmidyERH5Hod9JDk/N5HsnRp/280gS4tQYnCMEo2zf
         RfEUBLAfWois442w2Tfo6rdPWD9289rwo2J8IQHFCw9U6Fph+G6hiPFyfVUftlmYGSo+
         OM4Yr3ueKOaKevLv2FhiHO0uBvViemRAXuBbBAgiJR7CPVSfEyd4BdrUwmQXBtTfoImf
         nPOg==
X-Gm-Message-State: APjAAAXkTs04e0btwbZL5fKg4Zh+xELVOTXz3DcSS/mpYgGwWQNYs2bI
        64PMvXxNhuTi8kCJP/HWUXEpNQbx9k7+4i8uBgc=
X-Google-Smtp-Source: APXvYqycOqtnRQqX5m4Wp/QMWvQDLUCkmr+oAHU/DUAMEtQsBG/HT9p2TVWiBH2PmzzmyquK3T4HUKlcUASgF+pdE3Q=
X-Received: by 2002:a67:c11b:: with SMTP id d27mr156449vsj.175.1567532240079;
 Tue, 03 Sep 2019 10:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com>
 <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru>
 <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com>
 <87blw93c5n.fsf@osv.gnss.ru> <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1908302221210.46@tvgsbejvaqbjf.bet> <CABPp-BHMXAQGPaBYyg2dtVeN5h8fW8G4YdhddCeAjY5r74BAzw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1909021111440.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1909021111440.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Sep 2019 10:37:08 -0700
Message-ID: <CABPp-BF5Y415ALi288CWnuJSG4nrdbjBvh5pHJ1752V-qQFPKw@mail.gmail.com>
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

On Mon, Sep 2, 2019 at 2:30 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Fri, 30 Aug 2019, Elijah Newren wrote:
>
> > On Fri, Aug 30, 2019 at 1:40 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >
> > > [...]
> > > In my most recent instance of this, I wanted to publish the script I
> > > used to use for submitting patch series to the Git mailing list,
> > > maintaining tags for iterations and generating cover letters from branch
> > > descriptions and interdiffs (this script eventually became GitGitGadget,
> > > https://github.com/gitgitgadget/gitgitgadget/commits?after=6fb0ede48f86e729292ee1542729bc0f5a30cfa6+0
> > > demonstrates this).
> > >
> > > To do that, I ran a `git filter-branch` in the repository where I track
> > > all the scripts I deem unsuitable for public consumption, to remove all
> > > files but `mail-patch-series.sh`, then pushed it to
> > > https://github.com/dscho/mail-patch-series
> > >
> > > Please note that most crucially, I wanted to rewrite a newly-created
> > > branch, and only that branch.
> > >
> > > Could I have done the same using `git fast-export`, filtering the output
> > > with a Perl script, then passing it to `git fast-import`? Sure, I was
> > > really tempted to do that. In the end, it took less of _my_ time to just
> > > let `git filter-branch` do its work with a not-too-complicated index
> > > filter.
> >
> > Why a perl script?  Shouldn't
> >     git fast-export [--no-data] HEAD -- $PATH | git fast-import --force --quiet
> > do the trick?  And it's probably simpler and shorter than the index
> > filter you used.
>
> Does that not keep the full `$PATH`? I wanted the resulting branch to
> have the file in the top-level directory.

Ah, gotcha; I read your original description to suggest that the
script was already at the toplevel.

> > That said, yeah it'd be nice to get automatic rewriting of commit
> > hashes in commit messages and other niceties from filter-repo (e.g.
> > future automatic reattaching of notes to the rewritten commits).  Some
> > questions:
> >
> >   * What's the backup strategy in case you specify the wrong filters
> > (e.g. you have a typo in the pathnames)?  filter-repo encourages folks
> > to make a clone and then filter the fresh clone, because if anything
> > goes awry, you can just delete and restart.  (I am heavily opposed to
> > the refs/original/ backup mechanism used by filter-branch, for
> > multiple reasons.)  Is your safety stance just "If I mess up it's my
> > own fault; do the rewrite?"  Or are you okay with cloning before
> > filtering?
>
> Please note that the `refs/original/` refs should not have been written
> at all anymore, not after reflogs were introduced.
>
> Incidentally, that is my answer to your question: the reflog is my
> backup.

The reflog is great, but while it works in your special case please note that:

1. Anyone filtering a subset of refs more in number than one may have
some difficulty restoring correctly (they have to look in several
reflogs, and can't script restoring from all older reflog versions).
2. Few folks have core.logAllRefUpdates set to 'always', meaning
they'll lack a backup for some refs if the reflog is relied upon.
3. If the filter specifies only keeping a list of files that happen to
not exist within one of the branches (perhaps a filename was typo'ed)
and if pruning empty commits, then the branch can be deleted, and git
doesn't have a mechanism for deleting a branch without deleting its
reflog as far as I know.

Point 1 is kind of minor, but points 2 and 3 are showstoppers in
regards to me recommending the reflogs as a reliable recovery
mechanism after general filtering operations, and this is true for
either filter-branch or filter-repo.  (That said, I can definitely
allow people to choose their risks and just provide some
here-be-dragons warnings.)

> >   * If you're okay with cloning before filtering...then is there an
> > issue with rewriting all branches, and just pushing the one you need?
> > (Is there an issue with "this branch is small, the others are huge,
> > and filter-branch is slow -- so rewriting one branch saves me lots of
> > time"?  Or are there other issues at play too?)
>
> I am not okay with cloning before filtering.
>
> First of all, it is wasteful.
>
> Second of all, in my case it would have been *particularly* wasteful
> because the repository in question also has quite a few quite large
> blobs (hysterical raisins, don't ask).
>
> >   * What if the user has auxiliary information for the branch in other
> > refs?  For example, git-notes pointing at any of the commits, or tags
> > in the history of the branch that might be relevant, or perhaps even
> > replace refs in combination with GIT_NO_REPLACE_OBJECTS=1?  Is this an
> > "I don't care, toss that stuff and just rewrite just this branch?"
>
> In my case: there are no notes. The only time when I make heavy use of
> notes is in GitGitGadget. I don't use that feature otherwise.
>
> >   * filter-repo by default creates new replace references so that you
> > can refer to new commit IDs using old (unabbreviated) commit IDs.
> > Would that be considered helpful for this usecase?  unhelpful?
> > irrelevant, since you'll just push the branch you want somewhere and
> > nuke the temporary clone?
>
> I definitely did not need that mapping in all of my `git filter-branch`
> use cases.
>
> Of course, I can see how it can come in handy in other circumstances,
> just not in the ones I experienced so far.
>
> > I'm not by any means ruling out the possibility of documenting --refs
> > and adjusting the defaults when it is used so the user can just run
> > something like
> >    git filter-repo --path $PATH --refs $MYBRANCH
> > but I feel like I need to understand answers to questions like the
> > above ones so that I can know how to phrase warnings and adjust
> > defaults and update the documentation.
>
> In all the scenarios where I used `git filter-branch` (some dozen per
> year, so not all *that* many), I needed to rewrite one particular
> branch, typically a freshly-created one. I never, ever ever needed to
> rewrite all the refs in the repository. Not once ;-)

Thanks for answering all these and providing the extra context.  Very helpful.

> > > In another instance, a long, long time ago, I needed to restart a
> > > repository which had included way too many files for its own good, then
> > > rename the old repository and start with a fresh `master` that contained
> > > but a single commit whose tree was identical to the previous `master`'s
> > > tip commit. I simply grafted that commit, ran `git filter-branch` and
> > > had precisely what I needed.
> >
> > filter-repo supports grafts and replace objects, the same as
> > filter-branch.  (Although, technically, I didn't have to do a thing to
> > support it; fast-export does the special handling of rewriting based
> > on grafts and replace objects.)  So, I'd say this is fully supported.
> >
> > Side question: the git-replace documents suggest that the graft file
> > is deprecated.  Are there any timeframes or plans for phasing out
> > beyond the git-replace manpage existing?  Should I avoid documenting
> > the graft file support in filter-repo?  Should I include examples
> > using not just git-replace but also using the graft file?
>
> I had meant to prepare a patch series to remove `grafts` support that
> Junio could carry in `pu` until the time he considers it appropriate to
> merge to `master`, but it seems that this task fell under the rag.
>
> The deprecation itself has been introduced in tags/v2.18.0-rc0~54^2~4,
> i.e. it is official as of Git v2.18.0, which was released in mid-June
> last year.
>
> My personal gut feeling is that we should let it simmer for another year
> before removing support for the `grafts` file (and we may want to update
> the label "grafted" when `git log` shows a shallow commit before we
> remove that support for `grafts`).
>
> So I'll not work on that patch for now.

Thanks for the extra history.

> > > I would be _delighted_ if these kinds of use case (rewriting a branch,
> > > or even just a commit range) became more of a first-class citizen with
> > > `git filter-repo`.
> >
> > I've got all the pieces for supporting a single branch or a commit
> > range (e.g. 'git filter-repo --path foo --refs ^master~4 ^stable~23
> > mybranch'), but the defaults (error out unless in a bare repo, move
> > refs/remotes/origin/* to refs/heads/*, disconnect origin remote,
> > expire reflogs & repack & prune, create new replace references so
> > folks can access new commits using old commit IDs) may be somewhat
> > friction-filled for this usecase.  Those defaults other than the new
> > replace refs happen to all be turned off with the combination of
> > --force and --target, so, assuming turning them off is what you need,
> > you could cheat and just specify 'git filter-repo --force --target .
> > --refs $MYBRANCH' today and perhaps get what you want, but that's a
> > really non-intuitive command line that is way too ugly to recommend.
> > And I don't want to tie myself to '--target .' being the magic sauce
> > in the future either.
>
> I agree. I would love for my use cases to become more of first-class
> citizens. Maybe `--branch <branch>` could serve as the knob?

I think I can put something together to make your usecases better.  I
dislike --branch, though, because:
  * It suggests it doesn't work for tags or other things outside of refs/heads/*
  * It suggests that revision ranges are unwelcome.
So, I'd prefer a more generic --refs which can potentially take
multiple arguments, e.g. any of
  --refs mybranch
  --refs mytag
  --refs HEAD~5..mybranch
  --refs ^origin/master ^origin/other-feature mybranch1 mybranch2

> What I also found really helpful in `git filter-branch` is that it was
> possible to pass one-liner shell scripts directly to the command, giving
> a lot of freedom about the transformations. I understand that Python
> makes it hard to write spaghetti-code one-liners, so you cannot really
> pass the snippet in via the command-line, but I hope there is a way to
> script things in `git filter-repo`?

I agree, having the ability to use a programming language snippet or
even full script for special cases is really nice. You can totally do
that filter-repo, at three different levels:

1. Light-control for easier cases: You can use the command line
arguments --filename-callback, --message-callback, --name-callback,
--email-callback, or --refname-callback and provide python snippets
(usually one-liners) that return a new value.  Most of these are for
editing fields shared across multiple object types (e.g. the name
callback will be used to edit author && committer && tagger names).
However, the filename callback allows both editing the filename and
also filtering based upon filename (you can return the original
filename, OR a new name, OR you can return None to state that you want
files with that name filtered out of commits).

2. Moderate-control: You can use the command line arguments
--blob-callback, --commit-callback, --tag-callback, or
--reset-callback and provide python snippets (possibly one-liners but
more likely to be complex enough that you want newlines) that modify
these fast-import-stream objects.  These provide more control but tend
to be slightly more work. (For example, if you want to rename
branches, you need to worry about three callbacks: commit && tag &&
reset; by comparison, you'd only need to use the refname callback from
lighter control.  Also, if you're worried about filtering based on
filenames, you'll need to dig the filenames (and modes and change
types) out of the list commit.file_changes).

3. All-in: You can write a python script that imports filter-repo as a
python module and (among other things) set up your own
functions/classes as callbacks.  You have to do a bit more setup to
specify the options you are running with, list how many export and
import processes you want to run with, name all your callbacks, etc.,
but it allows you to do anything from just providing a slightly more
involved callback up to and including creating your own filtering tool
with a totally different user interface while still leveraging
filter-repo's capability.  There are multiple examples provided along
that range too (including bfg-ish and
filter-lamely/filter-branch-ish.)

For more details about all of these, see:
https://github.com/newren/git-filter-repo/blob/a6a6a1b0/README.md#callbacks
https://github.com/newren/git-filter-repo/blob/a6a6a1b0/README.md#using-filter-repo-as-a-library
