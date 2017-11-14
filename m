Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9454F201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbdKNJTG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 04:19:06 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:38905 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdKNJTE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:19:04 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:40184 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEXN1-0001Ex-Ex
        for git@vger.kernel.org; Tue, 14 Nov 2017 04:19:03 -0500
Date:   Tue, 14 Nov 2017 04:18:30 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: why can *some* git commands not be run from within .git directory?
Message-ID: <alpine.LFD.2.21.1711140409020.13653@localhost.localdomain>
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


  just noticed something i was unaware of -- some git commands can't
be run if i'm in the .git directory, while others can. for example,
if i "cd .git", commands like this work just fine:

  $ git show
  $ git branch
  $ git log

but others seem unwilling to determine the "working tree":

  $ git status
  fatal: This operation must be run in a work tree
  $

and:

  $ git stash list
  fatal: /usr/libexec/git-core/git-stash cannot be used without a working tree.
  $

what's the distinction between commands that can work this way, and
commands that can't?

rday

p.s. i will refrain from pointing out the inconsistency in using the
phrases "work tree" and "working tree" to mean the same thing, when
there is a distinct "worktree" entity.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
