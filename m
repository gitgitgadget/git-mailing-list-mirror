Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15501FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 19:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbdJHToT (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 15:44:19 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:40349 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbdJHToS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 15:44:18 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:41816 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e1HUn-0003Gk-30; Sun, 08 Oct 2017 15:44:17 -0400
Date:   Sun, 8 Oct 2017 15:44:14 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <20171008184046.uj7gcutddli54ic3@thunk.org>
Message-ID: <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain> <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain> <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain> <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net> <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain> <1507412674.8322.4.camel@mad-scientist.net> <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <1507473160.8322.12.camel@mad-scientist.net> <20171008184046.uj7gcutddli54ic3@thunk.org>
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

On Sun, 8 Oct 2017, Theodore Ts'o wrote:

> On Sun, Oct 08, 2017 at 10:32:40AM -0400, Paul Smith wrote:
> > Personally I don't use Git's magical globbing capabilities, and
> > use "git rm" as if it were UNIX rm.  So in your request above I'd
> > use:
> >
> >    git rm $(find . -name Makefile)
> >
> > which I find simpler.
>
> I have to agree that git's magical globbing capabilities are...
> strange.  (And apologies to Robert for my earlier post; I didn't
> understand what he was complaining about.)  I don't use it either,
> although I tend to use:
>
>     find <find args> | xargs git rm
>
> myself.

  that's what i would have normally used until i learned about git's
magical globbing capabilities, and i'm going to go back to using it,
because git's magical globbing capabilities now scare me.

> One thing which is interesting is that not only is the git's magical
> globbing capabilities have somewhat unusual semantics, the how
> globbing is done in .gitignore entries are completely different.

  i know ... it would have made way more sense to try to be
consistent. oh, well, live and learn. at least now i'm aware of the
weirdness.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
