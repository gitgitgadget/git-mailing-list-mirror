From: Johan Herland <johan@herland.net>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 23:02:57 +0200
Message-ID: <200707202302.57788.johan@herland.net>
References: <858x9ez1li.fsf@lola.goethe.zz>
 <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 00:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC0ZE-0008Dy-6s
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 00:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759515AbXGTWDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 18:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758595AbXGTWDM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 18:03:12 -0400
Received: from smtp.getmail.no ([84.208.20.33]:51978 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758333AbXGTWDL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 18:03:11 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2007 18:03:11 EDT
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JLH00403X578B00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 20 Jul 2007 23:03:07 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JLH001YAX4Y0J90@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 20 Jul 2007 23:02:58 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JLH00D8HX4Y9U20@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 20 Jul 2007 23:02:58 +0200 (CEST)
In-reply-to: <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53123>

On Friday 20 July 2007, Linus Torvalds wrote:
> [...]
> 
> But that doesn't change the fundamental issue: the limitation with 
> executable bits and symlinks is a limitation of the broken environment, 
> not of git. But "directories stay around after the last file is gone" is 
> not that, it would simply be a design mistake in git itself.
> 
> There are other reasons to not do it. What about file renames? Maybe the 
> directory got *renamed*. From a pure content angle, this is "all the files 
> in that directory went away". If you have stupid rules like "directories 
> stay around even though all the files went away", you would again have 
> problems with this common case.
> 
> In other words: I don't care one whit about the whiners. What's MUCH more 
> important than some random whiny person saying "Daddy, daddy, I want a 
> pony" is whether you can afford to maintain that pony in the future. And 
> this pony is just stupid.
> 
> So here:
> 
> 	No, you cannot have a pony. NOT YOURS.
> 
> but I still think we should support the concept of importing things from 
> other systems, and thus eventually support empty directories. Just not any 
> crazy semantics with sticky histories.

Does this mean that you are firmly opposed to the concept of storing 
directories in the index/tree as such, or that you are only opposed to 
(some of) the implementation ideas that have been discussed so far?

If the former is the case, does this mean that there will be no support for 
empty directories in git, alternatively that such support is limited to 
incorporating e.g. Dscho's .gitignore workaround into porcelain commands 
(i.e. "git add --directory some_dir" will be mangled/transformed 
into "touch some_dir/.gitignore && git add some_dir/.gitignore")?

(Granted, Dscho's .gitignore workaround is fairly elegant as workarounds go, 
but it still reeks of inheriting a CVS misfeature.)


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
