From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-pull and tag objects
Date: Sun, 11 Feb 2007 09:49:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702110948120.8424@woody.linux-foundation.org>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 18:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGIpS-0003EB-Ft
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 18:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbXBKRtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 12:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbXBKRtb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 12:49:31 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53278 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbXBKRta (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 12:49:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1BHnNUI007093
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Feb 2007 09:49:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1BHnLdw010086;
	Sun, 11 Feb 2007 09:49:22 -0800
In-Reply-To: <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39301>



On Sat, 10 Feb 2007, Junio C Hamano wrote:
> 
> Although it is correct that the people who already saw the
> original tag would not lose the tag object from their repository
> when you publish a replacement tag, we have _always_ overwritten
> the refs/tags/$tag to point at the new one, effectively losing
> the original.
> 
> * 0a623e7c (Jul 5, 2005)
> In this version "git fetch $repo tag v2.6.13" would have done just
> 
> 	echo "$head" >"$GIT_DIR/$destination"
> 
> without checking if it already existed.

Yes, but only if you actually explicitly asked for it, methinks.

If you just do a "git pull", it won't do it.

So I think it's ok. 

		Linus
