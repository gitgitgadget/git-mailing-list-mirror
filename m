Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30181F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbeKTH6V (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:58:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43401 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKTH6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:58:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so22401736lff.10
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CK78tuXmMUB/hIHiae+LoKXsYyEkp3DOlqYMc3w0QUE=;
        b=muAuRjtiEW2YzCahJ3E0DI76KQ7KK6TC6k0pEzO/dDvHn+7VL6s2WY9dK8W8ZIH1OC
         /Z8d2TK5rh4ZUsSEds/dTWaYkVODjWH61G+eGFdnA2kp4q8KW8RLaKzqUM7lLRCX9gcL
         3ojDcY4W0ikTpGhMlcgRWuIklQHQZFhJE0hcnPnO/cgB/4paIvTEdtfFbMeTXZQik6gq
         cHX7hpV1qDrK+5cO+Ilfq4yXTpTQdHfgINvWSBrf/N78Dv9nHSoAno0jRWed1re5txgQ
         pUKdvsqs1ahTsMcSuiqlu/JIvoGFe2ydzwL4oFdnoEEpIG/cHG4jUPBWt/AIOdl9cSLU
         81ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CK78tuXmMUB/hIHiae+LoKXsYyEkp3DOlqYMc3w0QUE=;
        b=N19LJgLYzoYQNQ1ZHsPRsF/tvWHTTqfrciyotlwJ4X/Rbm7k6XFW7ptihf+kYIGHpw
         2PlG+ruj/AZsGRFakqHOA8EDp97NZa/nB6Bg28C9aSPiBSEfleAJtJC7/3SOV1cUfxuV
         0CQwG1ObYdxmcjOZyNHuXxIhQVUSOpXr8MrANDjGbZyjiRAPlUHKol6FJUfjhn5lVfl5
         8ALQsdpTbbcnitzZMiB03zk2FpBJmA/72IP4R4vMmS04THMvEisw52cHwTaSzuv0fDAK
         R0S1QMQumAjfpRWF9YWU/Xxp9UFoNFbuKPX3QzYLiUPEN04iD/Iuf4x7Bk3iMRexQq0/
         GZ+A==
X-Gm-Message-State: AGRZ1gJFURmiBL1DqB5Wmvnm8aWBqMUEHYElAOeX/xk9rAMpSKtTYufj
        KBLQSelnCwqH3BWvG3rzGrhRKOZZ5R1d4rfYF8KjJg==
X-Google-Smtp-Source: AJdET5cKZu7E4MvqOJf7ZnX+3Zuc+9UJ+10gBx1rHIIvReb9CTzhrW593MFc3ww8PLb6TKJfUvLWUGYouX+3S4vi6K4=
X-Received: by 2002:a19:9904:: with SMTP id b4mr11128272lfe.95.1542663163933;
 Mon, 19 Nov 2018 13:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <nycvar.QRO.7.76.6.1811151344490.41@tvgsbejvaqbjf.bet>
 <CAPL8Zitk1UBxpVCRWc-SV+1MtaOCJUOYUqCh7eJQcdR_wqpNfQ@mail.gmail.com> <20181119155545.GT30222@szeder.dev>
In-Reply-To: <20181119155545.GT30222@szeder.dev>
From:   Stefan Xenos <sxenos@google.com>
Date:   Mon, 19 Nov 2018 13:32:30 -0800
Message-ID: <CAPL8ZivQGGrxjerGxd_R42mJ2XCi_fFcOji3PL0=pWRAZ_OJQQ@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     szeder.dev@gmail.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subcommand names and --long-options are just as descriptive.

Yeah, I'm convinced about the descriptiveness. If you check the latest
version of the patch, I've already updated the "change" command to use
subcommands rather than lettered arguments.

> If a user wants to deal with reflogs, then there is 'git help reflog'

I guess it depends on whether you prefer having a single big help page
(risk: user may see irrelevant content), or a number of small help
pages (risk: user may need to follow cross-references). My guess is
that we should probably try to hit the sweet spot that minimizes the
amount of irrelevant information on a help page, the probability of
needing to follow a cross-reference to understand context, and the
amount of content that needs to be duplicated between pages.

But assuming we add a bunch of formatting options to obslog that match
log, it may make sense to just have an "--obslog" argument to log.

> I think 'git obslog' should allow the same when showing the log of a chan=
ge.

Sounds good. We should probably also change the default formatting for
the obslog command to be some sort of description of what changed
since the commit message will probably be very similar for every
entry. I'll update the proposal to mention formatting options once we
sort out where obslog will actually live.

> By adding several new commands users will have to consult the manpages of=
 'evolve',
> 'change', 'obslog', etc., even though the commands and the concepts are c=
losely related.

I'm not sure that's the case. There is some common background material
you'd need to understand in order to use any of those commands ("what
are changes?"), but the same could be said of pretty much any git
command ("what are commits?"). Assuming the user knows what a change
is, I'm pretty sure I could write a self-contained description for
evolve, change, or obslog that doesn't require cross-referencing any
of the other commands... and the evolve command could probably be
understood even without understanding changes.

But since several comments have focused on the commands, let's brainstorm!

Here's some options that occur to me:
1. Three commands: evolve + change + obslog as top-level commands (the
current proposal). Change gets a bunch of subcommands for manipulating
the change graph and metas/ namespace.
2. All top-level: evolve + lschange + mkchange + rmchange +
prunechange + obslog. None of the commands get subcommands.
3. Everything under change: "change evolve", "change obslog" become
new change subcommands.
4. Evolve as a rebase argument, obslog as a log argument. Use "rebase
--evolve" to initiate evolve and use "log --obslog" to initiate
obslog. The change command stays as it is in the proposal.
5. Two commands: evolve + change. obslog becomes a "log" argument.

Note that there will be more "evolve"-specific arguments in the
future. For most transformations that evolve uses, there will be a
matching argument to enable or disable that transformation and as we
add transformations we'll also add arguments.

If we go with option 3, it would make for a very cluttered help page.
For example, if you're looking for information on how to use evolve,
you'd have to scroll past a bunch of formatting information that are
only relevant to obslog... and if you're looking for the formatting
options, you'd have to scroll past a bunch of
transformation-enablement options that are only relevant to evolve.

Based on your log feedback above, I'm thinking #5 may make sense.

  - Stefan
On Mon, Nov 19, 2018 at 7:55 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Sat, Nov 17, 2018 at 12:30:58PM -0800, Stefan Xenos wrote:
> > > Further, I see that this document tries to suggest a proliferation of=
 new commands
> >
> > It does. Let me explain a bit about the reasoning behind this
> > breakdown of commands. My main priority was to keep the commands as
> > consistent with existing git commands as possible. Secondary goals
> > were:
> > - Mapping a single intent to a single command where possible makes it
> > easier to explain what that command does.
> > - Having lots of simpler commands as opposed to a few complex commands
> > makes them easier to type.
> > - Command names are more descriptive than lettered arguments.
>
> Subcommand names and --long-options are just as descriptive.
>
>
> > Git already has a "log" and "reflog" command for displaying two
> > different types of log,
>
> No, there is 'git log' for displaying logs in various ways, and there
> is 'git reflog' which not only displays reflogs, but also operates on
> them, e.g. deletes specific reflog entries or expires old entries,
> necessitating and justifying the dedicated 'git reflog' command.
>
> > so putting "obslog" on its own command makes
> > it consistent with the existing logs, easier to type, and keeps the
> > command simple.
>
> > - We could turn "obslog" into an extra option on the "log" command,
> > but that would be inconsistent with reflog and would complicate the
> > already-complex log command.
>
> On one hand, it's unclear to me what additional operations the
> proposed 'git obslog' command will perform besides showing the log of
> a change.  If there are no such operations, then it can't really be
> compared to 'git reflog' to justify a dedicated 'git obslog' command.
>
> OTOH, note that 'git log' already has a '--walk-reflogs' option, and
> indeed 'git reflog [show]' is implemented via the common log
> machinery.  And this is not a mere implementation detail, because "git
> reflog show accepts any of the options accepted by git log" (quoting
> its manpage), making it possible to filter, limit and format reflog
> entries, e.g.:
>
>   git reflog --format=3D'%h %cd %s' --author=3Dszeder -5 branch file
>
> I think 'git obslog' should allow the same when showing the log of a
> change.
>
>
> > Personally, I don't
> > consider a proliferation of new commands to be inherently bad (or
> > inherently good, really). Is there a reason new commands should be
> > avoided?
>
> If a user wants to deal with reflogs, then there is 'git help reflog'
> which in one manpage describes the concept, and how to list and
> expire reflogs and delete individual entries from a reflog using the
> various subcommands.  If a user wants to deal with stashes, then there
> is 'git help stash', which in one manpage describes the concept, and
> how to create, list, show, apply, delete, etc. stashes using the
> various subcommands.  See where this is going?  The same applies to
> bisect, notes, remotes, rerere, submodules, worktree; maybe there are
> more.  This is a Good Thing.
>
> By adding several new commands users will have to consult the manpages
> of 'evolve', 'change', 'obslog', etc., even though the commands and
> the concepts are closely related.
>
>
