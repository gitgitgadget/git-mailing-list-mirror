Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF951F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbdKMVHF (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:07:05 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:37295 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbdKMVHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:07:05 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:36084 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eELwe-00060s-0Q; Mon, 13 Nov 2017 16:07:04 -0500
Date:   Mon, 13 Nov 2017 16:06:31 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: man page for "git-worktree" is a bit confusing WRT "prune"
In-Reply-To: <CAPig+cRLcJ2a=QKyKAkaNiewoWMQvKr_AWePKYVpGS5S9g-i1Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1711131603340.6299@localhost.localdomain>
References: <alpine.LFD.2.21.1711130938080.5262@DESKTOP-1GPMCEJ> <CAPig+cRLcJ2a=QKyKAkaNiewoWMQvKr_AWePKYVpGS5S9g-i1Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Nov 2017, Eric Sunshine wrote:

> On Mon, Nov 13, 2017 at 9:48 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:

... snip ...

> >   finally, the prune "--expire" option is truly confusing:
> >
> >     --expire <time>
> >         With prune, only expire unused working trees older than <time>.
> >
> > suddenly, we encounter the verb "expire", which means ... what?
> > how does "expiring" a worktree differ from "pruning" a worktree?
> > and what makes a worktree "unused"? the normal meaning of "unused"
> > is that you haven't, you know, *used* it lately. in this context,
> > though, does it mean deleted? and if it means deleted, what does
> > it mean for it to be older than some time if it's already gone?
>
> This dates back to the original behavior of automatically pruning
> administrative information for deleted worktrees. As discussed
> elsewhere in the document, a worktree may be placed on some
> removable device (USB drive, memory stick, etc.) or network share
> which isn't always mounted. The "expire time" provides such
> not-necessarily-mounted worktrees a grace period before being pruned
> automatically.

  how is this "expire time" measured? relative to what? i've looked
under .git/worktrees/<wtname>, and i see a bunch of files defining
that worktree, but it's not clear how a worktree stores the relevant
time to be used for the determination of when a worktree "expires".

  oh, and is it fair to assume that if a worktree is temporaily
missing, and is subsequently restored, the expire time counter is
reset? otherwise, it would get kind of weird.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
