X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 23:42:06 -0400
Message-ID: <20061028034206.GA14044@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 03:42:32 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30359>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdf5N-0001r0-53 for gcvg-git@gmane.org; Sat, 28 Oct
 2006 05:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751694AbWJ1DmO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 23:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWJ1DmO
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 23:42:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52712 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1751693AbWJ1DmN
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 23:42:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gdf5I-0001Sk-Ru; Fri, 27 Oct 2006 23:42:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4995720E45B; Fri, 27 Oct 2006 23:42:07 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
[snip]
> Can we perhaps have reader-writer lock on the filesystem to
> pretect the repository?  "prune" can also be made into a writer
> for that lock and "fetch-pack --keep" would be a reader for the
> lock.  That reader-writer lock would solve the issue rather
> nicely.
> 
> > That said, I think some of the "git repack -d" logic is also unnecessarily 
> > fragile.
> 
> Noted; will fix.

So a reader-writer lock is preferred over
a non-locking solution such as I posted in
http://article.gmane.org/gmane.comp.version-control.git/30288 ?

Not to mention that such a solution would also fix the -d issue
Linus points out above.

-- 
