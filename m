Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CE51F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeB0L5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:57:19 -0500
Received: from mail.javad.com ([54.86.164.124]:53085 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752160AbeB0L5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:57:18 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id EFD4E407D0;
        Tue, 27 Feb 2018 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519732637;
        bh=W//0oYnbNClhWMhXOsAb2oVNFs066N9XB9bBAJEyQCo=; l=3356;
        h=Received:From:To:Subject;
        b=ZaTe8rhyprWAwZoA3eMxQre6baoCsv4REW/c+UqjRdNmWTIib22KavJMJoJKrHiqa
         4JMJMBy6kMwrlnMP2NT7YnbhHmHg6EtlyV6hijQCfUzodBFoMkaoq2eO8mBWyz4z8O
         Bq6mFmjuB/DXPaqmZO9LyL18VhsUEC7UXuhTixNY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519732637;
        bh=W//0oYnbNClhWMhXOsAb2oVNFs066N9XB9bBAJEyQCo=; l=3356;
        h=Received:From:To:Subject;
        b=ZaTe8rhyprWAwZoA3eMxQre6baoCsv4REW/c+UqjRdNmWTIib22KavJMJoJKrHiqa
         4JMJMBy6kMwrlnMP2NT7YnbhHmHg6EtlyV6hijQCfUzodBFoMkaoq2eO8mBWyz4z8O
         Bq6mFmjuB/DXPaqmZO9LyL18VhsUEC7UXuhTixNY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519732637;
        bh=W//0oYnbNClhWMhXOsAb2oVNFs066N9XB9bBAJEyQCo=; l=3356;
        h=Received:From:To:Subject;
        b=ZaTe8rhyprWAwZoA3eMxQre6baoCsv4REW/c+UqjRdNmWTIib22KavJMJoJKrHiqa
         4JMJMBy6kMwrlnMP2NT7YnbhHmHg6EtlyV6hijQCfUzodBFoMkaoq2eO8mBWyz4z8O
         Bq6mFmjuB/DXPaqmZO9LyL18VhsUEC7UXuhTixNY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519732637;
        bh=W//0oYnbNClhWMhXOsAb2oVNFs066N9XB9bBAJEyQCo=; l=3356;
        h=Received:From:To:Subject;
        b=ZaTe8rhyprWAwZoA3eMxQre6baoCsv4REW/c+UqjRdNmWTIib22KavJMJoJKrHiqa
         4JMJMBy6kMwrlnMP2NT7YnbhHmHg6EtlyV6hijQCfUzodBFoMkaoq2eO8mBWyz4z8O
         Bq6mFmjuB/DXPaqmZO9LyL18VhsUEC7UXuhTixNY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519732637;
        bh=W//0oYnbNClhWMhXOsAb2oVNFs066N9XB9bBAJEyQCo=; l=3356;
        h=Received:From:To:Subject;
        b=ZaTe8rhyprWAwZoA3eMxQre6baoCsv4REW/c+UqjRdNmWTIib22KavJMJoJKrHiqa
         4JMJMBy6kMwrlnMP2NT7YnbhHmHg6EtlyV6hijQCfUzodBFoMkaoq2eO8mBWyz4z8O
         Bq6mFmjuB/DXPaqmZO9LyL18VhsUEC7UXuhTixNY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519732637;
        bh=W//0oYnbNClhWMhXOsAb2oVNFs066N9XB9bBAJEyQCo=; l=3356;
        h=Received:From:To:Subject;
        b=ZaTe8rhyprWAwZoA3eMxQre6baoCsv4REW/c+UqjRdNmWTIib22KavJMJoJKrHiqa
         4JMJMBy6kMwrlnMP2NT7YnbhHmHg6EtlyV6hijQCfUzodBFoMkaoq2eO8mBWyz4z8O
         Bq6mFmjuB/DXPaqmZO9LyL18VhsUEC7UXuhTixNY=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eqdsh-0008Km-8d; Tue, 27 Feb 2018 14:57:15 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Feb 2018 14:57:15 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Feb 2018 01:07:01 +0100
        (STD)")
Message-ID: <87zi3u4pd0.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Buga,
>
> On Tue, 20 Feb 2018, Igor Djordjevic wrote:
>
>> I`m really interested in this topic, which seems to (try to) address the
>> only "bad feeling" I had with rebasing merges - being afraid of silently
>> losing amendments by actually trying to "replay" the merge (where
>> additional and possibly important context is missing), instead of really
>> "rebasing" it (somehow).
>
> If those amendments are what you are worried about, why not address them
> specifically?
>
> In other words, rather than performing the equivalent of
>
> 	git show <merge>^! | git apply
>
> (which would of course completely ignore if the rewritten <merge>^2
> dropped a patch, amended a patch, or even added a new patch),

You've already bit this poor thingy to death. Please rather try your
teeth on the proposed Trivial Merge (TM) method. Sorry, you will need to
actually read the proposal should you decide to.

> what you really want is to figure out what changes the user made when
> merging,

Exactly! It's all and only about changes, I'm glad you are starting to
get it.

> and what merge strategy was used to begin with.

No. It's in Git core philosophy to store only result, independent on the
way the result has been achieved. Only result matters. I could have got
merge result out of thin air, and Git won't care, and will store it for
me safely.

The proposed (TM) method will ensure it's still stored safely after
rebasing.

> To see what I mean, look at the output of `git show 0fd90daba8`: it shows
> how conflicts were resolved. By necessity, this is more complicated than a
> simple diff: it is *not* as simple as taking a diff between two revisions
> and applying that diff to a third revision. There were (at least) three
> revisions involved in the original merge commit, and recreating that merge
> commit faithfully means to represent the essence of the merge commit
> faithfully enough to be able to replay it on a new set of at least three
> revisions.

Even better: we have at least 3 source revisions and 2 new revisions to
base 3-rd new revision upon. Proposed (TM) method will use all of them.

> That can be simplified to two-way diffs only in very, very special
> circumstances, and in all other cases this simplification will simply
> fall on its nose.

No, Done Right (TM) it won't fall as N-way-diff is nothing more than N-1
simple diffs, trivially combined.

> If the proposed solution was to extend `git apply` to process combined
> diffs, I would agree that we're on to something. That is not the proposed
> solution, though.

I'm glad you finally got the point. Proposed (TM) method effectively
'git apply' combined diffs, yes. I just defined it in terms of commits
rather than diffs, as it's simpler to understand and to reason about it
that way.

>
> In short: while I am sympathetic to the desire to keep things simple,

Proposed (TM) method is complex enough to solve the problem at hand. No
need to ask for more complexity.

> the idea to somehow side-step replaying the original merge seems to be
> *prone* to be flawed.

Exactly! That's why current approach to rebase merges is flawed, and
that's why proposed (TM) method does reply entire original merges.

-- Sergey
