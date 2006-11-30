X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 07:58:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
 <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 15:59:19 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456EBBE7.8030404@op5.se>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32759>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoJY-0002WL-MV for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030627AbWK3P7F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbWK3P7E
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:59:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:20688 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030627AbWK3P7B (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:59:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUFwCjQ025877
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 07:58:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUFw9gJ009594; Thu, 30 Nov
 2006 07:58:09 -0800
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Andreas Ericsson wrote:

> Linus Torvalds wrote:
> > 
> > That said, I have to admit that I usually (a) don't do this very often (ie
> > this is not part of my daily routine) and (b) I tend to do "git reset"
> > fairly soon afterwards (or alternatively, just "git commit -a") to get back
> > to the situation where the index will match the current HEAD 100% again. So
> > the "index doesn't match HEAD" situation is always just a _temporary_ thing
> > for me.
> 
> A staging area is per definition meant to keep temporary things before they
> are committed to their designated place so there's nothing odd about that.

Sure. It's just that some people seem to expect the index to be different 
from HEAD, and are afraid of being "confused" by it.

The fear seems to be about "git diff" getting different results from "git 
diff HEAD", and always having to _check_ the two.

So I wanted to make it clear that I never have that situation, because I 
never leave the index "dirty". I agree that there is nothing odd about it, 
but I think that people who don't actively use the index (or don't use git 
at all, and just worry about it) see it as a kind of separate entity with 
a life all its own.

I can see that if you think the index is likely to be out of kilter with 
HEAD, you'd always worry about "ok, so maybe the diff I get from 'git 
diff' isn't the _true_ diff, so now I have to do _both_ 'git diff' and 
'git diff HEAD' to make sure I know what's up".

I just wanted to clarify that that is never the case for me, and I doubt 
anybody else really does it either. For a very complicated merge, I could 
possibly see somebody having a dirty index for a day or two and taking a 
break with the index dirty, but

 (a) I've certainly never seen that myself (and it would have to be 
     something very messy indeed - I remember multi-day merges with CVS, 
     but that was because CVS is so bad at merging, not because the merges 
     per se would have been all that messy)

 (b) if you have a merge _that_ messy, I don't think you're likely to 
     forget about it, and rather than be confused about the difference 
     between 'git diff' and 'git diff HEAD', you'll be really really happy 
     that you have some way of seeing just the _remaining_ pieces, rather 
     than all the crud you already fixed up.

In other words, the fact that the index _normally_ matches the HEAD may be 
obvious, but it's also important - it's important to allay fears from 
non-index users about it being somehow scary and confusing. It's not.

