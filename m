X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Unnecessary fetch warning
Date: Mon, 18 Dec 2006 03:16:31 -0500
Message-ID: <20061218081631.GA9727@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 08:16:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34729>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDfs-0003UG-UZ for gcvg-git@gmane.org; Mon, 18 Dec
 2006 09:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753501AbWLRIQi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 03:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbWLRIQi
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 03:16:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54106 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753501AbWLRIQh (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 03:16:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwDfl-00087o-MQ for git@vger.kernel.org; Mon, 18 Dec 2006 03:16:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A0AB420FB65; Mon, 18 Dec 2006 03:16:31 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Current 'next':

  $ git fetch
  Warning: No merge candidate found because value of config option
           "branch.sp/username-reflog.merge" does not match any remote branch fetched.

uhhh.. i asked for a fetch, not a merge.

I have no branch.*.merge or branch.*.remote in my .git/config,
and I only use the remote.*.url/remote.*.fetch format for my
remote configs.

Commit 62b339a5 added the warning, and its intended for pull, but
it is tripping during fetch too.

What about removing this warning from fetch, letting it mark
everything as `not-for-merge` and let pull trigger the warning
instead?

-- 
