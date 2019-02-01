Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2161F211B5
	for <e@80x24.org>; Fri,  1 Feb 2019 07:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfBAHiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 02:38:55 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:34038 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfBAHix (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 02:38:53 -0500
Received: by mail-vs1-f44.google.com with SMTP id y27so3648807vsi.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 23:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycmVyZyVhmPn3DSlj/8taFBozIpq8dyYEaQ+KkpeV7U=;
        b=doqmVEijCCtZVESqdxbfOaW9dz+n8gNqReHjTUp4NjJzeuT6YeGv3E+NhKZbYur3rq
         /sTAY6jtOHFzMNCscH+qDZ0Yj/ts3Bh4niZhiFmJooifO0B48lW8RSGLRWrm3pLBG6nf
         2BsR7FvmSvi0vLj9808ewRF14eKCJ0wmce5nKGNPoclyaLxv4hMWl+fjxcxQfNJUpzSq
         6G9t1IiwPwFM+P4vKrYps/vqMMri2GusLd7eDtkuSbrTuwMyFJ9s0BOzBMZqS2DNChf6
         bhgGY/EHGq8ngHujtyUgMgq24cU0NPSMZW6xttLSPYbs3gh6kpPbVleuBjJMH/imf+Xi
         rCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycmVyZyVhmPn3DSlj/8taFBozIpq8dyYEaQ+KkpeV7U=;
        b=EENnGlnhgurzIjuZAFDL13mKQ8fruNZL8FpfkzKYb/r3J6sZbY45JtoibhZIecU91h
         irBTsUwUtdSLBb/8NNdQoEyxF4ZC4ngApLGoTN3MysSgA+vmyTSCQ4v58AdLFqGqg6VU
         g9vkyaIcyyjpMh4kQXl8hUVSJD7hpU7QcflNxCnSTcEUlf6PehOulc4StUSRfSTSg81B
         ZrmLWuCikDoowHCVoP8dpibMQGckB1ZDt+jCJoKDxMWAPhrbFyh1pqs2FLVInbZJkw+/
         aJwG+1hrHvD7g4IwzFKiw7rYmd/b2TcFYjAEsz76vu2JA8xfpgmLeOf+sZP8QPlSvbsY
         1yyQ==
X-Gm-Message-State: AJcUukfXtxE0NcCO+DRranwVdHso3RHnC0WcD8ApenM7K9guDf4+htBQ
        vvoaaSCrdidYjiU9hwtDaXC7vX6yuqTH1eCZMeE=
X-Google-Smtp-Source: ALg8bN7imvbUKmM98RciwSjx3leN3RLkHnhaKeYJhq1aHNgXhwuw5lwWfMPaqitaIQhczoiGZoX9yljRYR6gKcbSiaY=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr15657201vsi.136.1549006731895;
 Thu, 31 Jan 2019 23:38:51 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
 <xmqq36p83aq4.fsf@gitster-ct.c.googlers.com> <CABPp-BH==w5APkz9cvUYq7m4qieJ3LWCsYySevgJuZ8bi2RzjQ@mail.gmail.com>
 <CAFY1edZ6hS5Dz9z5ZAhU59he9SjxetvfTN+ndzUZkjxhsuwEZA@mail.gmail.com>
In-Reply-To: <CAFY1edZ6hS5Dz9z5ZAhU59he9SjxetvfTN+ndzUZkjxhsuwEZA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Feb 2019 08:38:40 +0100
Message-ID: <CABPp-BFvKk9D9h-XMjAnOrziKDhfGDG-rX410kb-pt+jF5cinA@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     Roberto Tyley <roberto.tyley@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Roberto,

First of all, thanks for the feedback, and for the awesome work on BFG
repo filter!

On Fri, Feb 1, 2019 at 12:36 AM Roberto Tyley <roberto.tyley@gmail.com> wrote:
>
> On Thu, 31 Jan 2019 at 22:37, Elijah Newren <newren@gmail.com> wrote:
> > On Thu, Jan 31, 2019 at 8:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > > > git-filter-repo[1], a filter-branch-like tool for rewriting repository
> > > > history, is ready for more widespread testing and feedback.  The rough
> > > > edges I previously mentioned have been fixed, and it has several useful
> > > > features already, though more development work is ongoing (docs are a
> > > > bit sparse right now, though -h provides some help).
> > > >
> > > > Why filter-repo vs. filter-branch?
>
> I like the name! I think a lot of users are interested in filtering
> their entire repo, rather than rewriting a single branch.
>
> > > How does it compare with bfg-repo-cleaner?  Somehow I was led to
> > > believe that all serious users of filter-branch like functionality
> > > are using bfg-repo-cleaner instead.
> >
> > No, bfg-repo-cleaner only covers an important subset of the usecases.
>
> That's true - the focus with BFG Repo-Cleaner is on removing unwanted
> data - completely eradicating it from a repo's history. There are some
> mistakes in history that repo owners just really *do not* want to
> share (ie large files, private data/credentials), and they can be a
> critical blocker to sharing or working with a Git repo. In terms of
> rewriting history, my internal criterion for what I features I really
> want to be in the BFG is: is this unwanted data completely stopping
> many users from sharing their code or doing their work?
>
> I understand that when it comes to rewriting history, there are loads
> of other operations that people sometimes want to perform, beyond
> removing unwanted data - merging/splitting of history,
> anonymization/renaming of committers, etc. Some of those might be nice
> to add to the BFG - but as with many OSS-maintainers, I have limited
> time, and a life to balance outside of software...!

Totally understand; you picked a certain set of usecases and provided
a really good tool for those ones.  I focused more on repository
migration (not between different version control systems, but some
other special flag-day event.  e.g. we have a whole bunch of plugins,
several of them are unmaintained, they are in lots of different code
hosting platforms; and someone decides we want to put all the widely
used plugins into a big monorepo for various reasons.)  It's just that
when doing some kind of big migration is a good time to do cleanup as
well, especially when typical actual plugin size history might be a
few hundred kilobytes, but for some reason many are dozens or hundreds
of megabytes, so filter-repo also provides some facilities for
cleaning unwanted stuff out as well.

> > bfg-repo-cleaner does a really good job if your goal is to remove a
> > few big files and/or to remove some sensitive text (matched via
> > regexes) from all blobs.  It was designed for that specific role and
> > has more options in this area than filter-repo currently has.  But
> > even within this design space it was optimized for, it is missing two
> > things that I really want:
> >
> >   * pruning of commits which become empty due to filtering
>
> There certainly have been several users asking for this feature on the
> BFG, and even a kindly contributed PR for the functionality which I've
> yet to merge. As it doesn't actually stop users from doing work - so
> far as I can see - it's something that I've done a poor job of
> following up.

Just as a heads up: It may be a lot uglier than it at first looks;
there's all kinds of special cases and I'm not quite sure I've got it
all right in filter-repo yet:

* Some projects intentionally create empty commits for versioning or
publishing or other reasons, and do not want these commits to be
removed.  Thus, it's important to remove commits that *become* empty
(due to other filtering rules), not commits which started empty.
* There's a special case for the above rule: if a user only wants the
history of a certain directory, then any empty commits that pre-dated
that directory aren't wanted/needed.  The way I handle this is that if
a commit which had no changes relative to its parent became an orphan
(its parent and all other ancestors were pruned due to becoming
empty), then the fact that it was orphaned implies that it *became*
empty and is thus prunable.
* There are also topological changes possible: If a parent and all
further ancestors on one side of history are pruned, a merge commit
may become a non-merge commit.  Often that will make the merge commit
itself prunable, though there is the possibility that the merge had
other changes tucked into it.
* Merges also may become degenerate:
  * Case 1: both sides of history may have commits pruned away (due to
becoming empty) all the way back to the merge base, meaning the merge
commit now has the merge base for both parents.  I think having
redundant parents is senseless and the redundant ones should be
pruned.  In most cases, this should also mean the merge commit is no
longer empty as it'll likely have no changes relative to the merge
base.
  * Case 2: one side of history may have commits pruned away back to
the merge base, meaning that the merge commit now merges one parent
with an ancestor of that parent.  If the merge commit has no changes
relative to the newer parent, then it could potentially be pruned
away.  However: What if this merge commit *started* as a merge of some
commit with its own ancestor?  If the second parent is the newer
commit, this was likely a --no-ff merge and probably shouldn't be
pruned.  But, if a project has a strong policy of always doing --no-ff
merges to incorporate changes, then even if the merge commit didn't
start out looking like a --no-ff merge we should probably keep it even
if it ends up looking like one.  (But, of course, in either case if
the first parent is the newer one, then it's not a --no-ff merge and
unless the merge commit has extra file changes in it, we should be
able to prune it.)
* Also, if your scheme checks for changes against the first parent to
see what changes exist in a merge commit, if the first parent
history is pruned away due to filtering choices (e.g. it didn't touch
the directory of interest), then your methodology may miss the fact
that this merge commit has an empty set of changes relative to its
remaining parent and thus mistakenly retain some commits which became
empty and were expected to be pruned.  I believe I saw filter-branch
messing this up, though I'd have to double check.
* There might be other special cases I've overlooked, though I've
tried to cover them all.

I'm currently thinking that perhaps a flag or pair of flags might be
useful here (perhaps --empty-pruning={always,never,auto}
--no-ff-pruning={always,never,auto}) with 'auto' perhaps being pruning
of commits which didn't start out that way (empty or a no-ff merge)
but became so.  I'm still undecided on this...

> >   * providing a way for the user to know what needs to be cleaned up.
> > It has options like --strip-blobs-bigger-than <size> or
> > --strip-biggest-blobs <NUM>, but no way for the user to figure out
> > what <size> or <NUM> should be.
>
> For users of GitHub, It's normally 100MB with
> --strip-blobs-bigger-than <size> :-)

If you're only interested in what GitHub won't allow for you to
continue working with your repo, sure.  If you are migrating your repo
for some reason and want to take the chance to clean it up at the same
time so everyone doesn't have to pay heavy clone costs, there are many
other interesting values.  :-)

> > Also, since it just focuses on really
> > big blobs, it misses cases like someone checking in directories with a
> > huge number of small-to-moderately sized files (e.g. bower_components/
> > or node_modules/, though these could also contain a few big blobs
>
> For those use-cases, it might be that BFG's --delete-folders flag is
> useful, especially given the protected-head-commit feature of the BFG.

Absolutely.  However, this somewhat assumes the user doing the
filtering knows what parts of history are extraneous.  I've seen many
cases where the original author(s) of some repo weren't that familiar
with version control and committed a whole bunch of things they
shouldn't.  They then left the company or project and a few years
later, someone else deletes those files in a new commit, possibly even
mentioning in the commit message that it was stuff that was never
needed.  Several more years go by, the second individual isn't with
the project any more either, and someone else comes along, possibly
not even familiar with the language or build tools the project uses
but was tasked with migrating the history anyway.  Having a tool which
can tell them why this small plugin happens to be much bigger than
expected with pointers to relevant bits ("what's this
bower_components/ directory that accounts for most the size and was
deleted four years ago?") is very helpful.

I've also seen this with big repos where there are lots of ugly
travesties in all kinds of different places, and no one still around
knows about more than a couple of them.  The developers may be willing
to go through a flag day to have the history rewritten to expunge the
things that never should have been committed to get clone times down,
but only removing a few big blobs or expecting there to be an
individual who knows which directories can be nuked isn't always the
best answer.  Given enough time, anyone can run enough git commands to
kind of figure out what are the big things, but I wanted something
that made that job easier.


Granted, 'git filter-repo --analyze' is a separate read-only step
(other than the reports it writes), so even if people wanted to use
BFG repo cleaner or other filtering tools they could use this aspect
of filter-repo to guide decisions.

> It's getting late for me, must be even later in Brussels - I wish I
> could have made it there to join in! Merry Git Merge to you all, and
> good luck to you Elijah with git-filter-repo.

Thanks again for all the feedback; maybe we'll get to meet at a future
conference.  Best of luck to you as well.

Elijah
