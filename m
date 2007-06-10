From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] Softrefs: Add softrefs header file with API
 documentation
Date: Sun, 10 Jun 2007 07:58:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100750440.4059@racer.site>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net>
 <200706092021.43314.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:02:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxHRB-0002Bm-F5
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760200AbXFJHCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760198AbXFJHCF
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:02:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:58982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759496AbXFJHCC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:02:02 -0400
Received: (qmail invoked by alias); 10 Jun 2007 07:02:01 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp053) with SMTP; 10 Jun 2007 09:02:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JZvMlnL3JCvctXDS+VgjrkQWm8RbNN7i6zQ7sPS
	sdHciIi+KTtF2X
X-X-Sender: gene099@racer.site
In-Reply-To: <200706092021.43314.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49658>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> See patch for documentation.

This is preposterous. Either you substitute the patch for a documentation, 
or you document it in the commit message. I consider commit messages like 
"See patch for documentation" as reasonable as all those CVS "** no 
message **" abominations.

> + * The softrefs db consists of two files: .git/softrefs.unsorted and
> + * .git/softrefs.sorted. Both files use the same format; one softref per line
> + * of the form "<from-sha1> <to-sha1>\n". Each sha1 sum is 40 bytes long; this
> + * makes each entry exactly 82 bytes long (including the space between the sha1 + * sums and the terminating linefeed).
> + *
> + * The entries in .git/softrefs.sorted are sorted on <from-sha1>, in order to
> + * make lookup fast.
> + *
> + * The entries in .git/softrefs.unsorted are _not_ sorted. This is to make
> + * insertion fast.

This sure sounds like you buy the disadvantages of both. Last time I 
checked, it was recommended to look at your needs and pick _one_ 
appropriate data structure fitting _all_ your needs.

Besides, your lines are way too long. Yes, it is not in 
Documentation/SubmittingPatches, but even just a cursory look into the 
existing source shows you that it is mostly 80-chars-per-line. I think it 
goes without saying that you should try to imitate the existing practices 
in any project, and since you have to read the source to get acquainted 
with it _anyway_, it would only be a duplication to have it in 
SubmittingPatches, too.

Ciao,
Dscho
