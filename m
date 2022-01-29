Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB0AC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbiA2RoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiA2RoB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 12:44:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EBAC061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:44:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id h7so27790369ejf.1
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGismbB557uxVkNZyM6RX+pJVwgLCsSlaYk+p4wS2Ns=;
        b=J9ZvPKDoLGgeAUX3sLarDLxiyvXRdX5dfhRII0fykpLy4p2lWbog4wlHdhfDyNGybj
         WxVQB/Yek5eBASW/V7MX9/uUUC2pRecNM1Rvf/HXsEjxsgu7X6DzONpu8AQs6fzvbuSL
         3o0uZ8wyi0UZRo4rrOh2eF6eST8UQYw0DjsGofVYm06TeSsy2fLBmtgjZwYm+D02Mrlf
         vxFgY4IjUbvfGRdwBR0+sGIXOF/y7nDfGHX6E3Vfa6yMn+sES4UbP/25o4HkKpjNSFmZ
         JqvSD3NBPCg+E3G4OdIMZm7HktXUD2jVexgm6aFRsj0Za5YDMrZJ69pX891Vi4zJCB+/
         ryGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGismbB557uxVkNZyM6RX+pJVwgLCsSlaYk+p4wS2Ns=;
        b=r0RvBzoDlJz0N/23poEbUrDSbStZfyoEzvqU+tYL3WixW+s6biOcqPcR0ERcXO3Bhr
         8vTcLmNRy9Qre1fXMPQAhKRFheRKW8SlxWJspVhRtKF73BST75bbuBYSvrFeSc2jCE2+
         Db2e23SEakEhGG/Rw1ChqXDhA4+mrZQpm7zRhrOHl0mgF0Mk2l+qVBPXWHhWTu8K9eIv
         VVOT3BTLNKLv7/V78o7BW4KJljGt3He5CESsjT46bV5L99RfToFoCEvCXZLrJ5Jte09G
         PbMOhoA7gG/sndw5F45MRFv1m5iTLv6+JZa4k62AoWOSFP+yHMo3R2fxXnqQmfhyIyRW
         irog==
X-Gm-Message-State: AOAM532uFY17jYOs5451ewKIwWIMPf7PQ7mS2wFVGhYoB3asWglZxyZr
        AdOcgp111eB6iqwBzWsEIj1a1bzZFKiq6BbkNOA=
X-Google-Smtp-Source: ABdhPJzMLkLSWw9J6q/NxwenmE9plsR+VreHSwXMnbfYM4/IWyh5hUFleCW+gfrfiQbjvF5vQ0F7h8X6igXEKKzYV6M=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr5113529ejc.328.1643478239319;
 Sat, 29 Jan 2022 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
 <CABPp-BH2sWWwy5bgn+R0hnnYQ6o0+1R1=VB-LYzDM+p4NMRhWg@mail.gmail.com> <CAP8UFD243zGGderSFtH5WxOhidAv6566Df6vdUfKRiBb1qu9tg@mail.gmail.com>
In-Reply-To: <CAP8UFD243zGGderSFtH5WxOhidAv6566Df6vdUfKRiBb1qu9tg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Jan 2022 09:43:47 -0800
Message-ID: <CABPp-BGYAgUbfJVMXTOTq3mMcBsFvrvRKA6KpLkcdDj7NvFEhA@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Sat, Jan 29, 2022 at 12:18 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jan 29, 2022 at 8:04 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, Jan 26, 2022 at 12:48 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > > On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
>
> > > > Stuff intentionally NOT included, but which others seemed to feel strongly
> > > > about; they'd need to convince me more on these:
> > > >
> > > >  * Any form of diff output[1]
> > >
> > > It's not a big issue for me to not include them right now as long as
> > > it's possible to add cli options later that add them.
> >
> > My main concern is just that `merge-tree` remain a low-level tool and
> > have machine-parseable output.  I was a little worried that both you
> > and Dscho wanted everything on stdout rather than in separate files,
> > as the <Informational messages> part of the output is rather
> > free-form.  But since it's at the end, and has a machine-parseable
> > beginning, it can just be slurped in and we're all good.  The diff
> > output raises my eyebrow because I'm worried we're losing this
> > property.  If there are clear usecases for adding more output, and we
> > can do so without losing this machine-parseable property, I don't have
> > a problem with adding an option for it.
>
> That's ok for me for now. I will certainly not work on adding options
> for diff output without any usecase.
>
> > One analogy we might use here is that `git merge` provides a diffstat
> > at the end.  What you're asking is more than a diffstat, but might be
> > considered similar-ish in nature.
> >
> > > The reason is
> > > that I think in many cases when there are conflicts, the conflicts
> > > will be small and the user will want to see them.
> >
> > I'm a little worried about the assumption here that conflict size is
> > measurable and visible via diffs.  That might be true in some cases,
> > but a UI written with that assumption is going to be very confusing
> > when hitting cases where that assumption does not hold.  For example:
> >
> >   * What if there is a binary file conflict, or a modify/delete or
> > rename/delete conflict, or failed-to-merge submodule conflict, or a
> > file location conflict? (For these, there is no diff relative to the
> > first parent and hence this conflict would have no diff output for
> > it)?
> >   * What if there was a simple file/directory conflict?  A diff would
> > show a rename (even when neither side did any renames), but not any
> > conflict markers.
> >   * What if there was a rename/rename conflict (both sides renamed
> > same file differently) or a distinct types conflict?  The former
> > results in three different conflicting files, none of them with
> > conflict markers, while the latter results in two different
> > conflicting files both without conflict markers?  Showing individual
> > per-file diffs totally loses all context here -- it'll show no-diff
> > for one of the files, and totally new additions for the ones.
>
> In those cases we just tell users that they cannot resolve those
> conflicts in the user interface, see the following doc:
>
> https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#conflicts-you-can-resolve-in-the-user-interface

So...I think you may have just convinced me that my fears were
justified and that I should probably NAK any attempt to add diffs to
the merge-tree command.  I won't jump to conclusions but you've
provided some pretty strong signal to me against going down that
route.  The list of limitations in the link you provide do mostly
avoid the broken cases I listed above, but it enshrines those
limitations on that webpage as fundamental rather than just as current
implementation shortcomings.  You may not be able to remove those
limitations on that webpage without either expunging the diffs from
the UI or exposing the brokenness of the various cases above.

If you do propose a diff option in the future, come prepared to
discuss how you'll avoid accidentally leading others down into paths
with the same fundamental issues, and/or how the above types of
conflicts might still be meaningfully handled.

Also, the list of limitations you have may not be quite comprehensive
enough to avoid all problems (though it certainly avoids most of
them).  Can I ask a couple clarifying questions about your list of
limitations in that link? :

  * When that page says the file cannot already contain conflict
markers, is the check performed on the version of the file in the two
trees being merged, or is the check performed on the 2nd and 3rd index
stage of the merge result (these are not equivalent checks, even if
they often give the same answer)?
  * When that page says the file must already exist in the same path
on both branches, is the check performed on by checking the path in
the two trees being merged, or is the check performed on the 2nd and
3rd index stage of the merge result (again, these are not equivalent
checks)?

> > Such a problem statement just seems fraught with edge cases to me, and
> > suggests that the problem statement might be in need of revisiting.
>
> Users understand that some kinds of conflicts cannot yet be resolved
> using a user interface. Maybe we will be able to make improvements so
> that more kinds of conflicts can be resolved in a UI in the future
> though. That's why a flexible and extensible output could help.

I think future improvements to handle more conflict types may well
hinge on removing the diff-output-using portion of your interface; I
think it may well be fundamentally incompatible.

I agree we want to leave the output format open for extension, I'm
just saying we have to be careful about what extensions are included
and this one worries me.

> > Don't read this as me closing the door on the possibility of diffs;
> > I'm not trying to do that.  I'm listing my misgivings about how I
> > think they might be used (i.e. be careful if you're headed down this
> > path as you might be digging yourself a never-ending support hole).
> > You can also think of my comments as feedback to consider and address
> > when you propose a future feature addition for adding diffs.  If/when
> > you propose such a feature, we'd probably be able to dive more into
> > specifics and usecases at that time, which may or may not circumvent
> > my concerns.
>
> I know that diffs, or any new single feature, will likely not be a
> silver bullet.

Sure that's fair; not being a silver bullet is fine.  We do need to
avoid providing a kryptonite bullet, though.

> > > So it would be
> > > simpler to just have an option to show any conflict right away, rather
> > > than have the user launch another command (a diff-tree against which
> > > tree and with which options?).
> >
> > Um, this part I'm not sure I get.  I thought the reason for the diffs
> > was performance -- you knew you wanted the diffs, and you wanted it
> > done as part of the same process.  But why would this be simpler?
>
> In the commit message of 4/12 you show an example of using it in simple scripts:
>
> NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
> test $? -eq 0 || die "There were conflicts..."
> ...
>
> So I think it would be simpler for someone interested in seeing the
> conflicts, like a script writer, or maybe someone using it manually
> for example as a dry run before performing a merge, to be able to get
> them right away from the command...

Okay, but the command already does that.  When there are conflicts,
NEWTREE won't actually be a tree; it'll be lots of lines of output.
That's (part of) the reason for the exit status check.  So users
already get that information from the command.

> ...rather than to have to use another
> command (which means finding the right command, arguments and options
> for that) to get them.

As for finding the right arguments and options...

> > Your patch series included three different diffs, and the emails you
> > pointed me at suggested all kinds of configurability.  That suggests
> > the merge-tree command would have to take the exact same options the
> > user would supply to diff, and thus would have to be told all the same
> > options, right?  I don't see how this removes any complexity at all
> > for the user.
> >
> > Unless...is the request in some way similar to merge's diffstat where
> > there is always a very specific type of diff that is wanted and you
> > aren't envisioning much flexibility in what kind of diff or what to
> > diff against -- is that where the simplification comes from?
>
> Well I just think the default diff output could be tailored for the
> most likely usecases and options made available later for more
> advanced usecases or users.

Ah, so this may go against your earlier comments at [1] about a
merge-tree on steroids and a huge array of diff options, or against
your comments about diffs not being provided by default (also [1]).
Because if you have that huge range of diff options, and the diffs are
not provided by default, then it's not clear how you've simplified
things because users would still need to figure out the right
arguments and options to pass, it's just that the user would have to
pass all (or maybe just most?) of those arguments and options to
merge-tree instead of to diff.  Or is the simpler UI you're discussing
really just about not needing to include 1 argument, the name of the
new toplevel tree, since that single argument could be implicit?

I'm having a hard time buying the "simpler UI for script writers"
angle of argument here, especially for script writers who should fully
be able to look up the appropriate commands and use them.  Your
earlier arguments about performance being important (having both the
merge & the diff in the same process) seemed much more convincing to
me.  But maybe I'm still just missing something about your "simpler"
angle?

[1] https://lore.kernel.org/git/CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com/
