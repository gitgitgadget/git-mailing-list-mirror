X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC/PATCH 0/5] WIP status/rerere reporting
Date: Fri,  8 Dec 2006 02:49:25 -0800
Message-ID: <1165574970740-git-send-email-normalperson@yhbt.net>
References: <20061205092126.GE27236@soma>
NNTP-Posting-Date: Fri, 8 Dec 2006 10:49:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <20061205092126.GE27236@soma>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33680>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsdIO-00039f-F0 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425327AbWLHKtd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425343AbWLHKtd
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:49:33 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47161 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425327AbWLHKtc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:49:32 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 0ACB12DC034 for <git@vger.kernel.org>; Fri,  8 Dec
 2006 02:49:31 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 02:49:30 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


This is the stuff I mentioned I had been working on several months
before in a reply to the git-explain/git-wtf/git-whatsup thread.

I've rebased it against the current master and everything still seems
to work (I don't have unit tests for them).

This has been forgotten and abandoned for a while.  I especially don't
expect the changes to git-commit.sh (status) to be applied as-is, as it
should go into the new runstatus (my work predates runstatus).

 git-am.sh       |   18 ++++++++++++++----
 git-commit.sh   |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 git-rebase.sh   |   43 ++++++++++++++++++++++++++++++-------------
 git-rerere.perl |   25 +++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 18 deletions(-)

[PATCH 1/5] rerere: avoid misrecording on a skipped or aborted rebase/am
[PATCH 2/5] status: show files that would have resolutions recorded by rerere
[PATCH 3/5] am and rebase resolve states get picked up by status/commit
[PATCH 4/5] am: run git rerere to record resolution on successful --resolved
[PATCH 5/5] rerere: add the diff command

-- 
