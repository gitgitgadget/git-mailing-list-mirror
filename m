X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 19:10:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 03:11:21 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Carl Worth <cworth@cworth.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32700>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpcKR-0003nm-Hd for gcvg-git@gmane.org; Thu, 30 Nov
 2006 04:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936172AbWK3DLG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 22:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936177AbWK3DLG
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 22:11:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39629 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S936172AbWK3DLE (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 22:11:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAU3AmjQ017761
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 29
 Nov 2006 19:10:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAU3Alx5022432; Wed, 29 Nov
 2006 19:10:47 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Johannes Schindelin wrote:
> 
> I like it. Sort of a "temporary commit" to check against.

I (very) occasionally do this for patches I get.

You can do

	git-apply --index patch

and it will apply the patch and update the index for you. That's great for 
committing the patch (because it means that it adds and removes your files 
automatically for you), but most of the time when I get an email that I 
want to apply, I just use "git-applymbox".

So where doing the "git apply --index" thing is great is when you see a 
patch that has some obvious deficiency that makes you not want to commit 
it directly, but add some fixup of your own.

That's when it's useful to use the index to your advantage - you can do 
"git diff" (to see just the fixups you did on top of the patch), or you 
can do "git diff HEAD" (to see the combined effect of both the patch _and_ 
your fixups).

That said, I have to admit that I usually (a) don't do this very often (ie 
this is not part of my daily routine) and (b) I tend to do "git reset" 
fairly soon afterwards (or alternatively, just "git commit -a") to get 
back to the situation where the index will match the current HEAD 100% 
again. So the "index doesn't match HEAD" situation is always just a 
_temporary_ thing for me.

