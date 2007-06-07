From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain an
 empty line
Date: Fri, 08 Jun 2007 01:28:48 +0200
Message-ID: <200706080128.48637.johan@herland.net>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
 <200706080108.50042.johan@herland.net>
 <Pine.LNX.4.64.0706080011430.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 01:29:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRPj-0006nn-L5
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966265AbXFGX2y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966215AbXFGX2y
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:28:54 -0400
Received: from [84.208.20.33] ([84.208.20.33]:57812 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966020AbXFGX2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:28:52 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJA00303H83UK00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:28:51 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA00M3NH81HE10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:28:49 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA001QAH80TO50@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:28:49 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706080011430.4046@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49409>

On Friday 08 June 2007, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 8 Jun 2007, Johan Herland wrote:
> 
> > On Friday 08 June 2007, Johannes Schindelin wrote:
> > > 
> > > The first empty line in a tag object separates the header from the 
> > > message. If the tag object has no empty line, do not crash, but 
> > > complain loudly instead.
> > 
> > Aren't tag objects _required_ to have an empty line separating the 
> > headers from the body? At least I wrote the new tag code with that 
> > assumption in mind.
> 
> Yes, evidently you did.
> 
> But even then, isn't it always better to not rely on such assumptions, but 
> fail gracefully? The rest of Git's source code seems to be nicer to 
> failures as this one, IMHO.

I agree that we should fail gracefully, and my code is clearly not doing 
that in this case. My bad.

But the code should also detect invalid tag objects, and in this case I'm 
not yet convinced that the tag object causing the failure is in fact valid. 
If someone can convince me that the blank line after headers is optional, 
then I'll gladly fix the code.

> > Could this be related to the "error: char103: premature end of data" 
> > you're seeing?
> 
> Definitely. It breaks even _fetching_.

Sorry again. Still, if I could get a look at the object that'd help me alot 
in debugging.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
