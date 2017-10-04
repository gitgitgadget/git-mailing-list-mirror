Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DBF20365
	for <e@80x24.org>; Wed,  4 Oct 2017 15:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbdJDPYS (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 11:24:18 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:47000 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbdJDPYS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 11:24:18 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:48302 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dzlWz-0004NE-4R; Wed, 04 Oct 2017 11:24:17 -0400
Date:   Wed, 4 Oct 2017 11:24:14 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Kevin Daudt <me@ikke.info>
cc:     git@vger.kernel.org
Subject: Re: distinguishing between staged and unstaged content in a stash?
In-Reply-To: <20171004150345.GC1667@alpha.vpn.ikke.info>
Message-ID: <alpine.LFD.2.21.1710041121010.12084@localhost.localdomain>
References: <20171004071046.Horde.89FTNuoUz8wPxhsuejrB03G@crashcourse.ca> <20171004150345.GC1667@alpha.vpn.ikke.info>
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

On Wed, 4 Oct 2017, Kevin Daudt wrote:

> On Wed, Oct 04, 2017 at 07:10:46AM -0400, rpjday@crashcourse.ca wrote:
> >
> >   couple (admittedly trivial) questions about stashing. first, can
> > i clarify that when one stashes content, a stash *always*
> > distinguishes between what was staged, and what was unstaged? that
> > is, when one is stashing, the "--keep-index" option relates to
> > whether or not staged changes are left in the index (and,
> > consequently, in the working directory as well), but that option
> > has no effect on the final content of the stash, yes? even if
> > "--keep-index" is used, staged content still ends up in the stash.
> >
> >   also, is there a simple way to distinguish between the staged
> > and unstaged contents of a stash (or, more basically, is this even
> > a useful question to ask)? out of curiosity, i tried to figure out
> > how to do this, and came up with the following.
> >
> > to see staged portion of stash@{0}:
> >
> >   $ git show stash@{0}^2
> >
> > to see unstaged portion:
> >
> >   $ git diff stash@{0}^2 stash@{0}
> >
> > it's not like i have a pressing need to do that, i was just
> > curious if there's a simpler way to do this, or if this is just
> > not something people should need to do on a regular basis.
>
> There was a recent thread about this[0]. The conclusion is that it's
> seen as a good change, someone just needs to supply the patch to do
> this. A possible solution was also provided (from before that
> thread) here [1]
>
> [0]:https://public-inbox.org/git/1505626069.9625.6.camel@gmail.com/
> [1]:https://public-inbox.org/git/20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net/

  ah, i see immediately what sort of worm can this represents, given
the various possible states of files in the stash:

  * staged and tracked
  * unstaged and tracked
  * untracked but not ignored
  * untracked and ignored

  i will continue reading.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
