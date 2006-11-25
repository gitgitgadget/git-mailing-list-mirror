X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 03:57:31 -0500
Message-ID: <20061125085731.GG4528@spearce.org>
References: <1164409429445-git-send-email-hjemli@gmail.com> <7v1wns6q41.fsf@assigned-by-dhcp.cox.net> <20061125064901.GB4528@spearce.org> <ek9078$m2j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 08:57:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ek9078$m2j$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32270>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GntM2-0007Aa-P7 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 09:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934495AbWKYI5g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 03:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935147AbWKYI5f
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 03:57:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60344 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S934495AbWKYI5e
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 03:57:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GntLn-000078-PD; Sat, 25 Nov 2006 03:57:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 47C9B20FB09; Sat, 25 Nov 2006 03:57:31 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn Pearce wrote:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> Without -f, it should barf.  With -f, we would want the rename
> >> to happen.  In the latter case, I think it should work the same
> >> way as deleting it and creating it anew, and that would make
> >> sure that reflog for the old one will be lost and a new log is
> >> started afresh; otherwise, the log would say old history for
> >> that branch and it won't be a "rename" anymore.
> > 
> > This patch doesn't rename the reflog when the branch renames.
> > Myself and a few other users I support want the reflog preserved
> > when a branch renames, we all see the reflog as part of the history
> > of that branch and a rename is the same branch but stored under a
> > different name...
> 
> And of course reflog should store the fact of renaming branch.

Yes, I think that's a worthwhile thing to log.  Problem is the
logging system tends to throw away pointless entries (sha1 ->
same sha1) so the rename log entry needs to be forced somehow...

Although without a UI to show the content of the reflog having the
rename entry in there isn't all that critical.
 
> > I had planned to do a rename branch command myself, but its been
> > lower priority than everything else, so I have just never gotten
> > around to it.  I'm glad to see someone is attempting it!
> 
> I have thought that command to rename branch was created to deal
> with simultaneous renaming of reflog + marking rename in reflog.

Yes, that's one of the complex parts of it. :-)

-- 
