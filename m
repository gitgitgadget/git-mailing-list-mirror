From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Pushing to a non-bare repository
Date: Sat, 3 Feb 2007 11:48:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702031146050.8424@woody.linux-foundation.org>
References: <45C3FB08.1020805@midwinter.com> <7vfy9ndiqp.fsf@assigned-by-dhcp.cox.net>
 <45C459DD.8080201@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Feb 03 20:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDQvl-00009F-EP
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 20:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXBCTwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 14:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXBCTwJ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 14:52:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48366 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbXBCTwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 14:52:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l13JmnQ5030830
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Feb 2007 11:48:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l13JmkSN014498;
	Sat, 3 Feb 2007 11:48:47 -0800
In-Reply-To: <45C459DD.8080201@fs.ei.tum.de>
X-Spam-Status: No, hits=-0.397 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38592>



On Sat, 3 Feb 2007, Simon 'corecode' Schubert wrote:
> 
> However, your suggestion does not help people who don't know better.  Pushing
> into the HEAD branch of another repo breaks stuff there.  Badly.  This should
> be prevented, really.

No, please don't break it. I do it all the time.

I just do "git push remote".

And then eventually on the remote end I do end up having to "update", but 
that's a simple "git checkout -f".

It's actually really convenient. It works even if the remote end had 
dirty stuff in their tree, and "git diff" still works (because the push 
didn't update the index), and a simple "git diff HEAD" shows that "oops, 
we're not up-to-date".

Yeah, I guess it's a bit error-prone ("Why does 'git log' say I have a new 
version, but the working tree doesn't seem new?"), but it actually does 
work. 

		Linus
