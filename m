X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Avoiding uninteresting merges in Cairo
Date: Fri, 15 Dec 2006 11:03:03 -0500
Message-ID: <20061215160303.GG17860@spearce.org>
References: <20061215020629.GK26202@spearce.org> <eluasq$v7q$3@sea.gmane.org> <20061215150130.GB17860@spearce.org> <200612151657.06909.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 16:03:20 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612151657.06909.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34527>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFWn-0006nZ-9y for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752790AbWLOQDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWLOQDJ
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:03:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51754 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752792AbWLOQDH (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 11:03:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvFWV-00024F-Qt; Fri, 15 Dec 2006 11:02:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 932C520FB65; Fri, 15 Dec 2006 11:03:03 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Do you mean "commit" view or "commitdiff" view in gitweb for merges
> is confusing?

The commit view was what was confusing me.
 
> If it is "commit" view, it is fairly easy to remove difftree/whatchanged
> output below commit message for merges. However while git-show nor 
> git-diff-tree doesn't show diff for merge messages, the diftree output
> in "commit" view might be taken as 'damages'; git diff --summary always
> takes summary of diff against first parent.

I can see that, but it depends on what the current branch was when
you do the merge.  In the cairo case I was looking at yesterday the
"damages" from the merge were actually what was already considered to
be in the mainline as part of the project due to committer pulling
the remote master into his own master before pushing.

Given that the "push; whoops; pull; push" pattern is so common to
Git I think it is sort of misleading to show a merge like this;
lots of activity may have been pulled in from the central branch
during that pull.

iirc git whatchanged for a merge shows only files which cannot be
found in any of the parents; these the files which the merge commit
itself contributed directly.  If that set is empty then the commit
just isn't shown by git whatchanged.

-- 
