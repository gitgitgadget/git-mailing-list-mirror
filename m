X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: changing log entries
Date: Wed, 13 Dec 2006 18:24:52 -0500
Message-ID: <20061213232452.GE32568@spearce.org>
References: <1166051281.1808.1.camel@jcm.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 23:25:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1166051281.1808.1.camel@jcm.boston.redhat.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34254>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudTA-0000hg-1K for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751740AbWLMXY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWLMXY4
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:24:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39521 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751740AbWLMXY4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 18:24:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GudSv-0000a5-3f; Wed, 13 Dec 2006 18:24:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C17FA20FB6E; Wed, 13 Dec 2006 18:24:52 -0500 (EST)
To: Jon Masters <jcm@redhat.com>
Sender: git-owner@vger.kernel.org

Jon Masters <jcm@redhat.com> wrote:
> Hi,
> 
> So I figured out that the problem with "Can't lock ref" was down to not
> having set one of the scripts executable on the http server. Great.
> 
> Anyway, now I would like to change an existing log entry to make it a
> bit cleaner (read: add a first line that's under 80 characters). What's
> the best way to change an existing log entry for a commit?

If its the most recent commit on that branch, "git commit --amend".

Otherwise dump out the branch to patches with git format-patch,
amend the commit in question, then replay the patches with git am.

Or use StGIT to uncommit the changes, pop them off, fix the commit,
then repush the patches and recommit in StGIT.


Note that any of the above methods change the SHA1 of that commit
and every commit which follows it on that branch.  Consequently it
is generally considered to be impolite to edit commits without
warning which you have already published, as another person may be
basing their own work off that commit.

-- 
