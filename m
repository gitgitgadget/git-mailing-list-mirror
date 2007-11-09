From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 07:54:22 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <Pine.LNX.4.64.0711072309380.4362@racer.site> 
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> 
 <Pine.LNX.4.64.0711080003080.4362@racer.site>
 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWC8-0001M9-0J
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760801AbXKIPyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760720AbXKIPyl
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:54:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57749 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758686AbXKIPyk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 10:54:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9FsNTg010653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 07:54:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9FsMXv020907;
	Fri, 9 Nov 2007 07:54:22 -0800
In-Reply-To: <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64205>



On Wed, 7 Nov 2007, Jon Smirl wrote:
> 
> Then why doesn't this work?

Jon, lookie here:

> jonsmirl@terra:~/mpc5200b$ git log Documentation
> all the log for Documentation....
> jonsmirl@terra:~/mpc5200b$ cd Documentation
> jonsmirl@terra:~/mpc5200b/Documentation$ git log Documentation

Instead of the above sequence, do:

	jonsmirl@terra:~/mpc5200b$ ls Documentation
	.. all the files in Documentation ..
	jonsmirl@terra:~/mpc5200b$ cd Documentation
	jonsmirl@terra:~/mpc5200b/Documentation$ ls Documentation

and now tell me, why doesn't that work? And can't you see how *stupid* 
your complaint is?

The rule is:
 - git log without arguments gives the whole, unabridged, and full 
   history.
 - git log with arguments gives the *simplified* history for those 
   arguments.

But the arguments - if they exist - are always relative. You want things 
like filename completion to work. Making the pathname arguments absolute 
would be horrible. Think about it: it's just much more logical to always 
be able to say "I want the log for file xyz", and you don't want that to 
be absolute, since you shouldn't care where in the tree you are.

And the fact that git log gives the whole history when you don't give any 
arguments at all IN NO WAY makes it any more sensible to give "absolute" 
pathnames. The history being "whole" has nothing to do with the pathnames 
being "absolute". The two are totally independent issues.

			Linus
