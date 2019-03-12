Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33DB20248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfCLSOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:14:41 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:51526 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfCLSOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M9Hi+54vyK833dczTTgYiLtf4MtfyEhM+o5beQOMWDs=; b=wA00eYzOKbprXgihXlr/3gMLG
        RgxiqswYC1Gt7uxpz+4vl4xTm9hMbc+Iys3YVvHCk6VdLIUfqt9jQxvQGr+z+iiCC/YeHvn5FfElV
        vFuAUhGACW1c390zLoD2nqdYK4BnQ3Augslvf1J4y0w9w7M6dczQAhthKqptDSqEojhWnz+ck3h2J
        TZWnGGla5GN2rDl9N73CFUWLS5EGUpbFRB7j5RX++iD5PgzbBkwUzzThFuJachl/eSsvOpDqZwpL7
        F3/s22QdxkXpvgZQqPcbr9W6P99v0Z3W/eDyXxwzzkKi0Q1AjXhyPwDC5X+JCc8358sFae+eHYtnU
        9cHHk2CQg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:57862 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h3lvC-00BcJR-Vg; Tue, 12 Mar 2019 14:14:39 -0400
Date:   Tue, 12 Mar 2019 14:14:37 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Bryan Turner <bturner@atlassian.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
In-Reply-To: <CAGyf7-F2wCB7D_JGzd7USaTV0YfmOuFG2Z6GkWVM-JqWKaagQA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1903121411500.17683@localhost.localdomain>
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain> <CAGyf7-F2wCB7D_JGzd7USaTV0YfmOuFG2Z6GkWVM-JqWKaagQA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 12 Mar 2019, Bryan Turner wrote:

> On Tue, Mar 12, 2019 at 10:23 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   never noticed this before ... when i do a regular "git commit" and
> > enter my "vi" edit session and change my mind, i can bail with ":q!",
> > regardless of what i've set up as a commit message, and i'll see:
> >
> >   Aborting commit due to empty commit message.
> >
> > however, i was just playing with "git revert" and, after i ran:
> >
> >   $ git revert <commit SHA>
> >
> >   again, simulating that i changed my mind, i just typed ":q!", but
> > the revert went ahead, anyway. i tried again, this time completely
> > deleting all the lines from the commit msg (as the template
> > suggested), but the revert *still* completed after typing ":q!".
> >
> >   it was only after deleting all the lines and using ":wq" that the
> > revert was cancelled:
> >
> >   Aborting commit due to empty commit message.
> >
> > that seems ... inconsistent. am i misunderstanding something?

... snip ...

> When you use git revert, though, it writes a valid, usable message
> to the file ("Revert <subject>\n\nThis reverts commit <sha>"). When
> you :q!, that's still in the file. Since the file isn't empty, the
> commit moves ahead.

  again, this is also not true. as i think i mentioned in my earlier
note, if you get dropped into the revert edit session, even if you
delete all the usable commit message lines, if you type ":q!", the
revert commit still succeeds and, in fact, with all of the
revert-supplied usable lines that you just finished removing.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
