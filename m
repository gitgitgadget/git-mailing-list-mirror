X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 16:57:25 -0500
Message-ID: <20061214215725.GA26202@spearce.org>
References: <200612141519.44294.andyparkins@gmail.com> <200612142123.16291.andyparkins@gmail.com> <7virge17yh.fsf@assigned-by-dhcp.cox.net> <200612142137.54505.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 21:57:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612142137.54505.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34413>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyaG-0006aD-Cb for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964855AbWLNV5a (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWLNV5a
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:57:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37965 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964855AbWLNV53 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:57:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuyZq-0008Tg-CP; Thu, 14 Dec 2006 16:57:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E4C0620FB65; Thu, 14 Dec 2006 16:57:25 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> On Thursday 2006, December 14 21:30, Junio C Hamano wrote:
> 
> > I guess that question indicates that the part of my message you
> > did not quote was not written cleanly enough.
> 
> It was; I'm just stupid.
> 
> Let's make the special case "linux-master" and then Linus gets what he wants 
> and consistency is restored.
> 
> No?  Okay, I give up then. :-)

What about we do instead:

	[branch]
		mergeMessageTemplate = "Merge '%(remoteref)' from '%(remoteurl)' into '%(localref)'
%(summary)"
	[branch "master"]
		mergeMessageTemplate = "Merge '%(remoteref)' from '%(remoteurl)'
%(summary)"

?  IOW let the user supply the merge template message in the
repository config somehow and use string placeholders like what
show-ref accepts?  Then the default can be to not have the "into" at
all, and Linus surely could just set his branch.mergeMessageTemplate
to a string which gives him the message that he and his fellow
kernel hackers find to be useful?

-- 
