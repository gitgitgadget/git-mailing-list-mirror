X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 02:45:46 -0800
Message-ID: <7vodr7brfp.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
	<20061116051240.GV7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 10:46:42 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061116051240.GV7201@pasky.or.cz> (Petr Baudis's message of
	"Thu, 16 Nov 2006 06:12:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31569>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkelD-00079s-NA for gcvg-git@gmane.org; Thu, 16 Nov
 2006 11:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423743AbWKPKps (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 05:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423750AbWKPKps
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 05:45:48 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26858 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1423743AbWKPKpr
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 05:45:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116104547.IQHC9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 05:45:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nNlt1V0071kojtg0000000; Thu, 16 Nov 2006
 05:45:53 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> (v) Library issues...
> Git has the advantage of
> simply putting that part in C, which is though something I should've
> been doing more frequently too.

It should be stressed that git-core plumbing written in C is not
just for git Porcelain-ish, and it will continue to be shared
service.  We would add core support for what Porcelains need and
we would try hard to keep them generic enough so that other
Porcelains can use them.  Keeping the core and Porcelain-ish in
the same project has made it easier to keep them in sync and to
find and add missing features that would benefit Porcelains (not
limited to git Porcelain-ish).  But that should not be mistaken
as plumbing somehow belongs more to git Porcelain-ish than to
Cogito or others.

I also think you should take credit for some core improvements
you did yourself (e.g "ls-files -t" format was originally added
for the sole purpose of helping Cogito, but now others use it,
too).
