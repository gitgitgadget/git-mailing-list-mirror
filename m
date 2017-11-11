Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2181F201C8
	for <e@80x24.org>; Sat, 11 Nov 2017 11:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdKKLWn (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 06:22:43 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:40414 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdKKLWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 06:22:43 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:48050 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDTs2-0001bP-Ax
        for git@vger.kernel.org; Sat, 11 Nov 2017 06:22:42 -0500
Date:   Sat, 11 Nov 2017 06:22:17 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "git bisect" takes exactly one bad commit and one or more good?
Message-ID: <alpine.LFD.2.21.1711110612290.5087@localhost.localdomain>
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


  more on "git bisect" ... the man page seems to make it clear that
bisection takes *precisely* one "bad" commit, and one *or more* good
commits, is that correct? seems that way, given the ellipses in the
commands below:

  git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
                   [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]

however, other parts of the man page seem less clear. just below
that, a description that bisection takes "a" good commit:

"You use it by first telling it a "bad" commit that is known to
contain the bug, and a "good" commit that is known to be before the
bug was introduced."

and a bit lower, we read "at least one bad ...", which some people
might interpret as one or more *bad* commits:

"Once you have specified at least one bad and one good commit, git
bisect selects a commit in the middle of that range of history, checks
it out, and outputs something similar to the following:"

  if the rules are exactly one bad commit and one or more good, i'll
submit a patch to reword at least the above, and possibly more if
necessary.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
