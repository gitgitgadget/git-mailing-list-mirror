X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:31:14 -0800
Message-ID: <7virhgjt25.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<200611151858.51833.andyparkins@gmail.com>
	<Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
	<f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	<87velgs9hx.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 21:31:49 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87velgs9hx.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	15 Nov 2006 13:08:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31502>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSM2-00055z-Oj for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161717AbWKOVbb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161729AbWKOVbb
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:31:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36014 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1161717AbWKOVba
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:31:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115213130.DAQZ20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 16:31:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n9Xb1V0161kojtg0000000; Wed, 15 Nov 2006
 16:31:36 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> So there's this goofy circular notion that people end up with
> If we fix it so that a local merge really is performed with
> "git merge <branch>" instead of "git pull . <branch>" then teaching
> pull=fetch+merge really is a lot easier.

I am wondering if that could be "git merge <committish>..."
instead.  I do not care too much about the ... part (i.e. an
Octopus), but I often find myself doing:

	git checkout next
        git merge "Merge early part of branch 'foo'" HEAD foo~3

when earlier part of "foo" topic are worthy to be in 'next' but
not the later ones.

> In the meantime, pull would still be useless to me, I think. But maybe
> that's just the "default branch to merge" selection being broken.

Have you looked into per-branch configuration for default merge
source recently?  It might not be documented well enough,
though, because I do not use it myself, but you should be able
to improve on that (meaning both documentation and setting up
the defaults upon cloning and fetching).
