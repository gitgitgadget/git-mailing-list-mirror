From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 09:53:00 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <Pine.LNX.4.64.0711072309380.4362@racer.site> 
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> 
 <Pine.LNX.4.64.0711080003080.4362@racer.site> 
 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com> 
 <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
 <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
 <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqY3E-0000na-D9
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXKIRxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXKIRxh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:53:37 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55962 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976AbXKIRxh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 12:53:37 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9Hr0SK015364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 09:53:01 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9Hr08S025054;
	Fri, 9 Nov 2007 09:53:00 -0800
In-Reply-To: <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64233>



On Fri, 9 Nov 2007, Linus Torvalds wrote:
> 
> In fact, even at the top-of-tree, "git log" and "git log ." are two 
> totally different things [...]

Btw, the reason (and really the *only* reason) this is interesting at all 
is just to show that the notion of "full history" and "relative pathnames" 
really have nothing to do with each other. They really are in totally 
different and orthogonal dimensions.

"Full history" is something that exist *independently* of the pathnames. 

So the fact is, "git log" on its own is really about the *project*. It is 
totally pathname-independent, and I'd argue that many people are often 
just interested in the explanations (even though you obviously can also 
see the patches and the files changed too!) so I seriously doubt that this 
is just an implementation issue or my personal hang-up.

In other words "git log" simply is something *global*. It doesn't matter 
where in the tree you are, the end result is the same - it's about the 
project as a whole.

In contrast, "git log <filename>" is fundamentally different. Now you're 
explicitly stating that it's not something global any more, and that it's 
about the *files*. That's also why "git log" and "git log ." are acually 
different even at the top level.

Because when you're interested in the files, by implication you're not 
interested in commits that don't change the files - and there can be such 
commits even when you give the *total* file list.  

			Linus
