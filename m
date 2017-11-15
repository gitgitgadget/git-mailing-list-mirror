Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76316202A0
	for <e@80x24.org>; Wed, 15 Nov 2017 08:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbdKOItR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 03:49:17 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:45636 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdKOItQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 03:49:16 -0500
Received: by mail-wm0-f54.google.com with SMTP id 9so1326030wme.4
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsH5fvXk5o0TKq32xuwqpl9ekXczoTcKM2deh9LDqFI=;
        b=eAtFnPrBuN772bQUdAsBjUfqpRC1LCIrv9VnI75RJcnhGspgH5xewyHbQ6mv8W63AK
         nUvO0U0kSGf1TS1CGPFvasm1zV41su92GE95XqiVOfVfRuDyxIIYnXvUz1YPxm3zgMRB
         k/Y2SXoJCshn2CgSwc1GrK1bAYdhGrwTlN5LfdCLxEoGHNe6wT9VC9WK8mMw9M+1nctJ
         87gYDYEL59KyZ0RDl9JIpZ2zRcMdFqCEY0QSV716c1qIj1XQ0SPLw2YNFblsqJiGYdd2
         RYNxOt/2yw/aFL2hmoxCzuNncYoyL0EUN0MArx0KLNk1YT3xyr0fQnUZe1I/J1h6jCbP
         2iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsH5fvXk5o0TKq32xuwqpl9ekXczoTcKM2deh9LDqFI=;
        b=R7PVSO6qfPYnU4Okjn0bjFtxKjzqdNgObzGf+8otkS67Dt1lKyvoemdH7ipfIwsObV
         oc0FilwKDu05FxiOoEaNm2lv2EEiLlptcCjhu0q81mIGomknd0nB1Xdna0XtfOQfk0Gm
         xUKnLJlKDGmFkR07avbzpQ6GDKstnnzcSaLBgmEFkTHbw3bzksRoUlLTk2k+3y7zqT2K
         sfE2Uf30grgAZ0wOzVTOwSc02um/pKvK78vijSrIk7JcrkdnlKI9Q77YNt3AjgqyPIic
         168MP+Zgy1bzpU8fN93PUwRUNfkWRApelArEByQyo4LDY+slu1VSoP+JdrHwAJuBB16K
         923w==
X-Gm-Message-State: AJaThX6RhrMKuRhh2TpMSUc403foaaFkF87FP4m8sckBtSGwjAa8GQRo
        G9s4q3NlyewMocDglAg6Aik=
X-Google-Smtp-Source: AGs4zMZXIg3B1qaIgLB2yZoPE92SFsA1sGm8WVonlPrF1LeHGxxPiRby+aXyeTR2y6Wyl37yPpeKTQ==
X-Received: by 10.28.10.195 with SMTP id 186mr10284324wmk.136.1510735754611;
        Wed, 15 Nov 2017 00:49:14 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id z11sm5867020wre.73.2017.11.15.00.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Nov 2017 00:49:13 -0800 (PST)
Date:   Wed, 15 Nov 2017 08:50:39 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
Message-ID: <20171115085039.GA32324@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <20171112134305.3949-2-t.gummerer@gmail.com>
 <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com>
 <20171114084517.GA12097@hank>
 <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14, Eric Sunshine wrote:
> On Tue, Nov 14, 2017 at 3:45 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 11/13, Junio C Hamano wrote:
> >> If so, as long as the new DWIM kicks in ONLY when "topic" does not
> >> exist, I suspect that there is no backward compatibility worries.
> >> The command line
> >>
> >>     $ git worktree add ../a-new-worktree topic
> >>
> >> would just have failed because three was no 'topic' branch yet, no?
> >
> > Indeed, with this there would not be any backwards compatility
> > worries.
> >
> > Ideally I'd still like to make
> >
> >     $ git worktree add ../topic
> >
> > work as described above, to avoid having to type 'topic' twice (the
> > directory name matches the branch name for the vast majority of my
> > worktrees) but that should then come behind a flag/config option?
> > Following your reasoning above it should probably be called something
> > other than --guess.
> >
> > Maybe --guess-remote and worktree.guessRemote would do?  I'm quite bad
> > at naming though, so other suggestions are very welcome.
> 
> For my own edification...
> 
> git worktree add ../dir branch
> 
> * Checks out branch into ../dir if branch exists.
> 
> * Errors out if branch does not exist. However, if we consider the
> history of the implementation of worktrees[*1*], then this really
> ought to try the "origin/branch -> branch" DWIM before erroring-out.
> Implementing this DWIM could be considered a regression fix according
> to [*1*] and, as Junio points out, should not pose backward
> compatibility worries.

Agreed, I think it is not very controversial that this would be an
improvement.

> git worktree add ../topic
> 
> * Correctly errors out, refusing to create a new branch named "topic",
> if "topic" is already a branch.
> 
> * Creates a new branch named "topic" if no such local branch exists.
> 
> The desired new DWIMing would change the second bullet point to:
> 
> * If no local branch named "topic" exists, DWIM it from "origin/topic"
> if possible, else create a new local branch named "topic".
> 
> But that's a behavior change since, with the existing implementation,
> a newly created local "topic" has no relation to, and does not track,
> any origin/topic branch. The proposed --guess option is to avoid users
> being hit by this backward incompatibility, however, one could also
> view the proposed DWIMing as some sort of bug fix since, at least
> some, users would expect the DWIMing since it already takes place
> elsewhere.

I'm not sure we can call it a bug fix anymore, since as Junio pointed
out the current behaviour of creating a new branch at HEAD is
documented in the man page.

However git-worktree is also still marked as experimental in the man
page, so we could allow ourselves to be a little bit more lax when it
comes to backwards compatibility, especially because it is easy to
take corrective action after the new DWIMing happened.

> So, at least two options exist:
> 
> * Just make the new DWIMing the default behavior, accepting that it
> might bite a few people. Fallout can be mitigated somewhat by
> prominently announcing that the DWIMing took place, in which case the
> user can take corrective action (say, by choosing a different worktree
> name); nothing is lost and no damage done since this is happening only
> at worktree creation time.
> 
> * Add a new option to enable DWIMing; perhaps name it -t/--track,
> which is familiar terminology and still gives you a relatively short
> and sweet "git worktree add -t ../topic".
> 
> Given the mentioned mitigation factor and that some/many users likely
> would expect it to DWIM "origin/topic -> topic" anyhow, I'd lean in
> favor of the first option (but perhaps I'm too daring with other
> people's workflows).

Yeah, I'm leaning towards the first option as well, but I'm clearly
biased as that's how I'd like it to behave, and others might want the
other behaviour.  Unfortunately I don't know many worktree users, so I
can't tell what the general consensus on this would be.

I guess the second option would be the safer one, and we can still
switch that to be the default at some point if we wish to do so
later.

tl;dr I have no idea which of the options would be better :)

> FOOTNOTES
> 
> [*1*]: When Duy first implemented worktree support, he incorporated it
> directly into the git-checkout command ("git checkout --to worktree
> ..."), which means that he got all the git-checkout features for free,
> including the "origin/branch -> branch" DWIM. When worktree support
> was later moved to git-worktree, it lost most of the features
> inherited implicitly from git-checkout, such as -b, -B, --detach, so
> those were added back to git-worktree explicitly. However, at that
> early stage, git-worktree was still piggy-backing atop git-checkout,
> thus likely was still getting the "origin/branch -> branch" DWIM for
> free. A final iteration converted git-worktree away from heavyweight
> git-checkout to lightweight git-reset, at which point he DWIMing was
> lost. If you take this history into account, then loss of
> "origin/branch -> branch" DWIMing is a regression, so restoring it
> could be considered a bug fix.
