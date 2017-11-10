Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA59C1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 16:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbdKJQLi (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 11:11:38 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:59277 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdKJQLi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 11:11:38 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:47200 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDBu5-0005II-LW
        for git@vger.kernel.org; Fri, 10 Nov 2017 11:11:37 -0500
Date:   Fri, 10 Nov 2017 11:11:14 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: proper patch prefix for tweaking both git-bisect.sh and
 git-bisect.txt?
Message-ID: <alpine.LFD.2.21.1711101056440.5836@DESKTOP-1GPMCEJ>
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


  digging through both git-bisect.sh and git-bisect.txt, and it seems
pretty clear they're both a bit out of date WRT documenting the newer
alternatives "old"/"new" as opposed to the older "good"/"bad" terms,
and a few other things.

  first, trivially, neither the script nor the man page mention "view"
as an alternative to "visualize", but that's easy to fix. however,
most of the inconsistency involves that good/bad/old/new stuff.

  the man page reads (in part):

  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]

which i assume should actually read:

  git bisect (bad|new|<term-bad>|<term-new>) [<rev>]
  git bisect (good|old|<term-good>|<term-old>) [<rev>...]

unless there's some implicit assumption that isn't mentioned there.

  also from the man page, i'm guessing that:

  git bisect terms [--term-good | --term-bad]

might need to say:

  git bisect terms [--term-good | --term-bad | --term-new | --term-old]

and so on, and so on (again, unless the generality of those terms is
understood).

  so given that all of that is, technically, documentation (even the
usage message in the script), if one submits a patch to change both
files appropriately, what is the subject line prefix to use?

  anyway, maybe i'll do this in bite-size pieces to keep it
manageable. my first patch to the code base ... whoo hoo!

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
