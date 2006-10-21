From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 14:10:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211405380.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca>
 <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca>
 <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
 <87irie1wvv.wl%cworth@cworth.org> <453A7D7E.8060105@utoronto.ca>
 <BAYC1-PASMTP07D0D16EAA6ABADDAD39B1AE020@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Carl Worth <cworth@cworth.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 23:11:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbO7p-0002HG-Bc
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 23:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWJUVLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWJUVLV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 17:11:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161065AbWJUVLU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 17:11:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9LLB1aX009895
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 14:11:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9LLAxNW001427;
	Sat, 21 Oct 2006 14:11:00 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP07D0D16EAA6ABADDAD39B1AE020@CEZ.ICE>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29677>



On Sat, 21 Oct 2006, Sean wrote:
> 
> Since the utility provided by revno's seems so minimal even in the
> case where they do work, Git simply doesn't bother with them.  And
> "our" experience is that Git really does work well without them.

Yes. This really is what it boils down to.

The _only_ time you actually use revision numbers (as opposed to 
branch-names or tag-names) is when you want a _stable_ number.

It's that simple. You never really need a revision number otherwise. In 
other situations, you do things like 

	git log --since=2.days.ago
	gitk v2.6.18..
	git diff --stat --summary ORIG_HEAD.. 

or whatever. It's clearly not "stable", but it's also clearly not a 
revision number from a UI perspective.

When you want a revision number is _exactly_ when you're moving things 
between branches, or reporting a bug to somebody else, or similar. And 
that's also _exactly_ when you want the number to be stable and meaningful 
(ie the other end should be able to rely on the number).

And if you need refer to a central repository to do that, it's clearly not 
distributed. Not needing such a central reference point is what the word 
"distributed" _means_ in computer science for chrissake!

			Linus
