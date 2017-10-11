Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8BC20372
	for <e@80x24.org>; Wed, 11 Oct 2017 09:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756915AbdJKJEM (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 05:04:12 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:60376 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdJKJEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 05:04:10 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:56638 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e2Cvy-0001g5-7L
        for git@vger.kernel.org; Wed, 11 Oct 2017 05:04:10 -0400
Date:   Wed, 11 Oct 2017 05:04:07 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: slight addition to t.gummerer's proposed "git stash" patch
Message-ID: <alpine.LFD.2.21.1710110454240.11490@localhost.localdomain>
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


  was perusing thomas gummerer's proposed "git stash" patch here:

https://www.spinics.net/lists/git/msg313993.html

and i'd make one more change -- i'd separate the OPTIONS entries for
"git stash push" and "git stash save" so they don't end up being
rendered all crushed together when displaying the man page:

OPTIONS
   save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet]
   [<message>], push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all]
   [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]
       Save your local modifications to a new stash and roll them back to HEAD (in the working
       tree and in the index). The <message> part is optional and gives the description along
       with the stashed state.
       ... snip ...

so rather than:

OPTIONS
-------

push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
[-a|--all] [-q|--quiet] [-m|--message <message>] [--]
[<pathspec>...]::
save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
[-a|--all] [-q|--quiet] [<message>]::

    Save your local modifications to a new 'stash entry' and roll them
    back to HEAD (in the working tree and in the index).
    The <message> part is optional and gives
    the description along with the stashed state.
    ...

i'd suggest:

push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
[-a|--all] [-q|--quiet] [-m|--message <message>] [--]
[<pathspec>...]::

    Save your local modifications to a new 'stash entry' and roll them
    back to HEAD (in the working tree and in the index).
    The <message> part is optional and gives
    the description along with the stashed state.
    ...

save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
[-a|--all] [-q|--quiet] [<message>]::

    This option is deprecated in favour of 'git stash push'.


or something like that.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

