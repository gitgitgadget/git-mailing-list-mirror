Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6092F1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 22:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfBFWJr (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 17:09:47 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39344 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBFWJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 17:09:46 -0500
Received: by mail-wr1-f41.google.com with SMTP id t27so9339607wra.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mo9oGsYjyTgq9hsKCJUelvYyVWdZSjaH7W2sQfd27+U=;
        b=cpcZomjfWlkn5LY/EaaPRIzrGhIZ9eeyQOW3D5raaJc5rIONqxSfQdqfD1Uyi9a3tH
         tcUncZEdOp2lYJB0+oyOd7sn4aYJg6Q5a/wweHONnVroi/EN9AyJyVi/UDLC4Cr4AtLe
         E5fPBNIlUlkYzK8lUKkgXJ1AU8NPqDNLlYs86/+OFw8D2ZC4BLLpq/tJUHf0IEQ03QAM
         QVkTlBoYiC2/uqz9EYPFFLjYaBeqwFkGFNlQkQhgV9ocyt3bGvkTixbMj7qxg5cggPo8
         4mlyMO4SwtL/iwGpD3H3PYQdZmHeAnXm1CMgKvSZjzbVFSXN9FSc/5I86dShtCIGqKNP
         ZY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mo9oGsYjyTgq9hsKCJUelvYyVWdZSjaH7W2sQfd27+U=;
        b=JX0hPj82TPMvRRRtU85Tjxk5e872kLCM/7bZM96Lc0QVR5X/ywAmEF+daGFkaU688g
         nZV+NSabsQvfMtm7hD2TgTO/RSRsQQeZSkz/r6P3b+wypjkcO77CK5p1k/UTvKM4hPZZ
         XXaDM6vWxH2OCo9W0yCVxnLY2eKPra0GbR3sNIaaPnd9CHkPm0EPKdIb3ZFtDDtqSKMC
         /pDtiKU8oCP2ZkmhqOKCFBzggAdikrzJOFvr7ear/eTINCU3M7iFx8viomQi+PmbzLhy
         mlK7m2Q3ruv2KEV2bGAmqpYya+sJ4lf/Z4jZBGjnESPW088W9oDsiz38J29/h1SfqV/E
         HFvw==
X-Gm-Message-State: AHQUAuasG+LofEM57RNQuqDasEhhHxjXehEEoHH+INrDmjDym/UDqFjk
        RA9X/qKwzh9ry0KK3cQOfFw=
X-Google-Smtp-Source: AHgI3Ib7hzltdtcjHIyLPanpbtJ4dSD15v6LXR5BeGjo8n8c/TU5hKxZFnCteAGw4I+d6REoH5YtnA==
X-Received: by 2002:a5d:6b8b:: with SMTP id n11mr9322142wrx.216.1549490984100;
        Wed, 06 Feb 2019 14:09:44 -0800 (PST)
Received: from localhost ([109.180.252.133])
        by smtp.gmail.com with ESMTPSA id x3sm30738379wrd.19.2019.02.06.14.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 14:09:42 -0800 (PST)
Date:   Wed, 6 Feb 2019 22:09:42 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190206220942.GE6085@hank.intra.tgummerer.com>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com>
 <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05, Christian Couder wrote:
> On Tue, Feb 5, 2019 at 10:17 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > [Dropped Stefan from the Cc list, as his email bounces]
> >
> > On 02/04, Thomas Gummerer wrote:
> 
> > The idea is to add an option to 'git stash push', so it can stash
> > merge conflicts, and restore them with 'git stash pop'.  The various
> > stages of the files could be represented as commits, and the stash
> > commit would be an octopus merge of those commits, so they could be
> > re-created later.  The same idea can also be extended to store staged
> > vs. unstaged changes, so we can re-create the index state as it was
> > before creating the stash.
> >
> > Thoughts?
> 
> I think it would be an interesting GSoC project indeed. I think though
> that over the years we have been favoring refactoring projects over
> possibly more interesting projects, as the refactoring projects are
> usually easier to do step by step and to get code merged step by step
> which is encouraging.
>
> In general the refactoring projects are worthwhile to do even if the
> project is not finished at the end of the GSoC and if the student
> stops contributing after that. In those cases it is often a good idea
> to later finish the refactoring either by ourselves or by proposing it
> to another GSoC student or Outreachy intern.
> 
> With a project that implements a feature, there is a risk, if it's too
> complex or too difficult, that the feature will not be finished and
> that nothing (or nearly nothing) will have been merged during the
> GSoC. There is also the risk that another way to implement the feature
> will appear later in the GSoC and all, or nearly all, the work of the
> student and mentors will have been mostly wasted. It could also appear
> that the use cases the feature was envisioned to be used in, are
> better addressed by other improvements or a different workflow.

Right, it being too complex or too difficult is my main worry here.  I
don't necessarily agree that we should draw a line between refactoring
and feature work here.  The more important distinction in my opinion
is whether it is possible to implement the project in steps, that
individually make sense, and further work could be based on.

For example in Paul-Sebastians stash-in-c series (just to take a
recent example, that I was following closely), we didn't get anything
merged until stash was fully converted into C.  We could possibly have
merged half of the work, but maybe we would have waited until someone
else picks it up before merging anything, I don't know how to judge
that now.

I think the idea here could definitely be split into a couple different
phases, that could be individually useful, and can be merged
individually, though I don't know if they would necessarily be.  Of
the top of my head:

 - write test_expect_failure tests for the expected new behaviour

   This may not be worth including in git.git yet, but it can be a
   very useful starting point for somebody else continuing the feature
   if the student finds they don't have time for it.

 - implement pushing the index state, without dealing with conflicts
 - implement poping the index state, without dealing with conflicts

   This can already be individually useful, and I think this is
   something people asked for on the mailing list, though I didn't try
   digging up old threads for now.  After these two steps stashing and
   restoring a merge conflict would still not work, but we have a good
   first step that could be merged.

 - implement pushing/poping conflicted state

   This would obviously be the end goal.

> Another potential issue is that a new feature might be prone to naming
> or user interface discussions which could last for a long time or
> could not result in clear decisions.

Yes, this is definitely a potential pitfall.  I haven't thought in
depth about the interface yet, but I think the discussion around that
would be something we as mentors could and should guide the student
through.  We also wouldn't make the feature the default from the
beginning, but introduce it behind a new flag/maybe a config option,
to make sure we don't introduce any backwards compatible changes.

It's probably also something the student should include in their
proposal, so we can get eyes on it early in the process.

> So I think we should be very careful if we propose a project that
> implements a new feature to a student. We should at least consider the
> above potential issues and see if they can be mitigated before the
> project starts.

Thanks for bringing these issues up, they are definitely useful to
work through.  

> Thank you anyway for proposing this idea,
> Christian.
