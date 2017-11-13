Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603971F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbdKMOtK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 09:49:10 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:35864 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdKMOtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 09:49:09 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:39578 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEG2u-0002AN-98
        for git@vger.kernel.org; Mon, 13 Nov 2017 09:49:08 -0500
Date:   Mon, 13 Nov 2017 09:48:36 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: man page for "git-worktree" is a bit confusing WRT "prune"
Message-ID: <alpine.LFD.2.21.1711130938080.5262@DESKTOP-1GPMCEJ>
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


  once more, into the man pages ... "git worktree" seems like a fairly
simple command, but there is some confusion about the function of

  $ git worktree prune

the normal meaning of "prune" (certainly with git commands) is to
actually delete some content, and the initial impression of this
command is that it will delete an actual worktree. however, further
reading reveals:

" ... or you can run git worktree prune in the main or any linked
working tree to clean up any stale administrative files."

  ah, so one learns that the subcommand "prune" does *not* do any
actual pruning as people would *normally* understand it, it simply
deletes the administrative information about an already-deleted
worktree, do i read that correctly?

  that's emphasized further down in the actual definition of "prune":

    prune
        Prune working tree information in $GIT_DIR/worktrees.

but perhaps that explanation could be extended to say it only works on
already-deleted trees, since that's certainly not clear from that
single sentence.

  finally, the prune "--expire" option is truly confusing:

    --expire <time>
        With prune, only expire unused working trees older than <time>.

suddenly, we encounter the verb "expire", which means ... what? how
does "expiring" a worktree differ from "pruning" a worktree? and what
makes a worktree "unused"? the normal meaning of "unused" is that you
haven't, you know, *used* it lately. in this context, though, does it
mean deleted? and if it means deleted, what does it mean for it to be
older than some time if it's already gone?

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
