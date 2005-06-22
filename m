From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 10:21:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221009120.2353@ppc970.osdl.org>
References: <1119284365.3926.15.camel@localhost.localdomain>
 <7vbr61j631.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
 <7vmzpihi6x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 19:37:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dl9AA-0007Ei-BV
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 19:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVFVRcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVFVRWl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 13:22:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261797AbVFVRTL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 13:19:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5MHIsjA005139
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 10:18:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5MHIs4W020752;
	Wed, 22 Jun 2005 10:18:54 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzpihi6x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Junio C Hamano wrote:
> 
> Having said that, one automation I would benefit from is to
> automatically find patches that _have_ been accepted and drop
> them from my snapshot pool --- that part should be very easy to
> automate and I have not done so primarily because I _am_ lazy.
> I could call it git-cherry-drop ;-).

Andrew Morton does all of this with quilt, and it ends up being very
effective. Of course, the kernel has had almost 15 years of people making 
it more and more modular, so the kernel really gets rejects very seldom 
indeed, and it would probably not work as well for other projects 
(including git) that tend to have tighter couplings, if for no other 
reason than the fact that they are usually smaller.

Anyway, it's not a trivial problem. You can search for patch matches in
the patch history, but the thing is, that will fail whenever a patch was
edited for whitespace etc (which does end up happening often enough to
matter). The same goes even more for the commit messages (I routinely not
only add my sign-off, of course, but also fix typo's I notice and often
end up reformatting whitespace).

So at the very least, you'd have to have a fuzzy search (but exact enough 
that you'd see if a part of a patch was dropped etc).

			Linus
