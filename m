Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82AD20954
	for <e@80x24.org>; Sat, 25 Nov 2017 17:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbdKYRsl (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 12:48:41 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:42115 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdKYRsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 12:48:40 -0500
Received: by mail-wr0-f180.google.com with SMTP id o14so22798766wrf.9
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KPk0MxiYDXO15C0JYGaCGnddvjzesViDsx4HqoY4MD8=;
        b=kuY+qGTwLXaP2crmdCyRYpCodsJJRnOpzTJw3ypWciUWyguPSrwCb97s88Qdpdkw7v
         c3RDUIan21BIIlzC0AZoYgKvpKPJ8svzEtMY/2HXUyq5cypkd6vQewBt3OM8QLIC83IA
         Pod4BZ+1r1Y4uisGOIQdGUS98SgBo5p7srSIyPGdkj3N5EW0Z46f8EPYjG7vFabB7xGG
         av3EgV3iyWQTvwZ2HodayTA4PGs8x0PG+ggIW53W/6VL566rVcmztRQFSiXtmEiCKaGQ
         7uc+bWS2Q+TncUQ9cm8DAJqYd2ErJkg/4LKeohXTfvt9gzXHxPwq6dFbgSKZb3NjwetF
         73dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPk0MxiYDXO15C0JYGaCGnddvjzesViDsx4HqoY4MD8=;
        b=N8G/EfOoIWGkYGJgnLgDOsqpdYiedjzLRs285BYxnQ9OhHovX6I+CHHCNmMGaaLFLa
         IbMOM6bHCwEY0wuId7zmqQ26ndN2xFGSFI8yJacwcoz/XIq6UWutwdjnb87RvQCIWSv5
         akVNbosWXO0LRyK4ECkj4+zRMohGAjlN3Xhf7hhQ8yz69i2E8VZRVX4yl9gCNFHK9Lei
         TfalWl3C+veqN0sVH+O/NR2ZP+uh6CtTFv/hWnFDJOWvroLqalDEEL1MTXqyki8IPBHp
         SyloBEOuzoyRfrBeYBZlyxCXLmZT/fXOdgLk4k0n2Of7nhj22IJ37GPmXz9gkEgvlck0
         aqGg==
X-Gm-Message-State: AJaThX5nx32V041319LkHAD+7L3L8hsE7jphR97g6gEdlGGNL9NyZ2aO
        /tKqycQwtTF324OIfTYbaok=
X-Google-Smtp-Source: AGs4zMY01dNHqXQi9LmAtdsBlyym+u87IWqBMgSFvSlMVRkfbtFrF3jBMJsaje7iRhhipigUKmdu8A==
X-Received: by 10.223.159.15 with SMTP id l15mr21221768wrf.155.1511632119245;
        Sat, 25 Nov 2017 09:48:39 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id n143sm26210419wmd.31.2017.11.25.09.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Nov 2017 09:48:38 -0800 (PST)
Date:   Sat, 25 Nov 2017 17:50:11 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
Message-ID: <20171125175010.GB14993@hank>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171122223020.2780-5-t.gummerer@gmail.com>
 <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Currently 'git worktree add <path>' creates a new branch named after the
> > basename of the <path>, that matches the HEAD of whichever worktree we
> > were on when calling "git worktree add <path>".
> >
> > Make 'git worktree add <path> behave more like the dwim machinery in
> > 'git checkout <new-branch>', i.e. check if the new branch name uniquely
> > matches the branch name of a remote tracking branch, and if so check out
> > that branch and set the upstream to the remote tracking branch.
> >
> > This is a change of behaviour compared to the current behaviour, where
> > we create a new branch matching HEAD.  However as 'git worktree' is
> > still an experimental feature, and it's easy to notice/correct the
> > behaviour in case it's not what the user desired it's probably okay to
> > break existing behaviour here.
> 
> Is it "easy to notice"?  I doubt it.  Even if you assume that
> everybody uses bash prompt that shows the name of the branch, the
> user sees the same name of the branch in either mode.

With "easy" I meant at creation time, looking at the output of 'git
worktree add', which with the new version shows that the the new
branch has been set up to track the remote branch, and also shows the
commit HEAD now points to.

This would be the output in the new version:

     $ git worktree add ../bla
     Branch 'bla' set up to track remote branch 'bla' from 'origin'.
     Preparing ../bla (identifier bla)
     HEAD is now at 4aade43 bla

vs. the output without the changed behaviour:

     $ git worktree add ../bla
     Preparing ../bla (identifier bla)
     HEAD is now at 0f215c9 initial import

Of course that assumes that it's used directly, not in scripts, and
that users will actually read the output of the command when they
invoke it.  Maybe these are not safe assumptions to make though, and
we'd rather not have this on by default then.  As I mentioned
previously I would prefer having this as default, but I'm happy to
hide this behaviour behind a flag if we want to be more careful about
introducing this.  Dunno?


> > In order to also satisfy users who want the current behaviour of
> > creating a new branch from HEAD, add a '--no-track' flag, which disables
> > the new behaviour, and keeps the old behaviour of creating a new branch
> > from the head of the current worktree.
> 
> I am not sure if this is a good match for "--track/--no-track";
> which branch is to be checked out (either "automatically from the
> unique remote-tracking branch" or "the current one") is one choice,
> and whether the resulting branch is marked explicitly as integrating
> with the remote or not is another choice within one branch of the
> first choice.  IOW, this makes it impossible to say "create the branch
> based on the unique remote-tracking branch, but do not add the two
> branch.*.{merge,remote} variables".

Hmm good point.  Maybe we'll need another flag for this.  Maybe
--[no-]guess-remote would work, and a corresponding
worktree.guessRemote config would work?  That's the best I could come
up with, better suggestions are definitely welcome.

> Also, you have several mention of "remote tracking branch" in these
> patches.  Please consistently spell them as "remote-tracking branch"
> to be consistent with Documentation/glossary-content.txt and avoid a
> casual/careful reference to "tracking branch" if possible, unless it
> is quite clear to the readers that you are being loose for the sake
> of brevity.  Some people used "tracking branch" to mean the local
> branch that is marked as the branch to integrate with the work on
> a branch at a remote that caused user confusion in the past.

I must admit I wasn't aware of Documentation/glossary-content.txt and
have seen "tracking branch" in other places, so I was just repeating
the pattern.

> That is
> 
>     refs/remotes/origin/topic is a remote-tracking branch for the
>     branch 'topic' that came from the 'origin' remote.
> 
>     when you have branch.foo.remote=origin and
>     branch.foo.merge=refs/heads/topic, then your local branch foo is
>     marked to integrate with the 'topic' branch at the 'origin'
>     remote.
> 
> and these two are quite different things that people in the past and
> over time loosely used a phrase "tracking branch" to cause confusion.


Thanks for the clarification, will fix in the re-roll.
