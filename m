From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 11:30:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610191110290.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <87lkncev90.wl%cworth@cworth.org> <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
 <20061019161319.GA75501@over-yonder.net> <Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 20:31:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GacfN-00086c-J2
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 20:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946316AbWJSSaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 14:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946320AbWJSSaq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 14:30:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946316AbWJSSao (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 14:30:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9JIUHaX020057
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 11:30:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9JIUFuC020047;
	Thu, 19 Oct 2006 11:30:16 -0700
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29377>



On Thu, 19 Oct 2006, Linus Torvalds wrote:
> 
> Ahh. They may be that even in BK. I know BK had various 16-bit CRC 
> checksums, but they were probably on the actual _file_ contents, not in 
> the key itself.

Btw, I do believe that bzr seems to be acting a lot like BK, at least when 
it comes to versioning. I suspect that is not entirely random either, and 
I suspect it's been a conscious effort to some degree.

Which is fine, in the sense that there are certainly much worse things to 
try to copy.

That said, at least BK was up-front about the versions changing, and 
didn't try to do anything to hinder it. It still confused some people, and 
it wasn't a great naming system, but it did work.

In the big picture, the version naming between BK and git hasn't been an 
issue for anybody in practice, I suspect.

So if you want to look at features that actually matter more, try out 
something like

	gitk drivers/scsi include/scsi

on the kernel archive (I assume that somebody has tried importing the 
kernel git tree into bzr - quite frankly, if bzr cannot handle that size 
tree without problems, you have much bigger issues!).

In other words, being able to look at history of more than a single file 
has been a _huge_ bonus. 

The other big difference is being able to do merges in seconds. The 
biggest cost of doing a big merge these days seems to literally be 
generating the diffstat of the changes at the end (which is purely a UI 
issue, but one that I find so important that I'll happily take the extra 
few seconds for that, even if it sometimes effectively doubles the 
overhead).

Looking at the dates of the merges yesterday, they're literally half a 
minute apart, and that's not me _scripting_ them - that's me actually 
looking up the emails, typing in the "git pull " and pasting the source 
repository, and git fetching the data over the network and merging it, and 
checking out the result (and me verifying that the resulting diffstat 
matches what the email says). Doing four of those in a row in less than 
two minutes is actually a really big deal.

At some point, "performance" is just more than a question of how fast 
things are, it becomes a big part of usability.

			Linus
