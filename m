X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 11:40:47 -0500
Message-ID: <20061130164046.GB17715@thunk.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se> <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 16:41:51 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32773>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoyT-0005RZ-3F for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759266AbWK3QlV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759270AbWK3QlV
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:41:21 -0500
Received: from thunk.org ([69.25.196.29]:32969 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1759266AbWK3QlV (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:41:21 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1Gpp1b-00033H-5B; Thu, 30 Nov 2006 11:44:39 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1Gpoxr-000865-0c; Thu, 30 Nov 2006
 11:40:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Thu, Nov 30, 2006 at 07:58:09AM -0800, Linus Torvalds wrote:
> So I wanted to make it clear that I never have that situation, because I 
> never leave the index "dirty". I agree that there is nothing odd about it, 
> but I think that people who don't actively use the index (or don't use git 
> at all, and just worry about it) see it as a kind of separate entity with 
> a life all its own.

Well, sure, because the documentation *talks* about it as a separate
entity all its own.  Just look at the man page for git-diff as a great
example of this, or the ascii art diagram of the index.  It is all
technically _correct_, but it is scary as all heck.

> I can see that if you think the index is likely to be out of kilter with 
> HEAD, you'd always worry about "ok, so maybe the diff I get from 'git 
> diff' isn't the _true_ diff, so now I have to do _both_ 'git diff' and 
> 'git diff HEAD' to make sure I know what's up".
> 
> I just wanted to clarify that that is never the case for me, and I doubt 
> anybody else really does it either. 

But then why is the default for "git commit" to commit the index, if
the index is almost == HEAD?  And why is git-update-index given such
prominence in the documentation?

> In other words, the fact that the index _normally_ matches the HEAD may be 
> obvious, but it's also important - it's important to allay fears from 
> non-index users about it being somehow scary and confusing. It's not.

If everyone agrees with this, I think it would be easier to make
changes to the documentation and maybe some UI tweaks about what the
default might be.

One suggestion is that perhaps a mode where warns users when index !=
HEAD for certain critical commands might not be a bad thing.  That
might give users that are just graduating beyond novice git usage, and
just starting to become aware of the index, reassurance because if
they *don't* see the warning message, they can rest assured that they
don't have to do both "git diff" and "git diff HEAD", for example.

