From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Sat, 19 May 2007 18:55:34 +0200
Message-ID: <200705191855.35104.Josef.Weidendorfer@gmx.de>
References: <200705170539.11402.andyparkins@gmail.com> <200705180857.18182.andyparkins@gmail.com> <464E4C94.5070408@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat May 19 18:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpSDc-0006bP-Qz
	for gcvg-git@gmane.org; Sat, 19 May 2007 18:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbXESQzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 12:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbXESQzl
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 12:55:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:53658 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752277AbXESQzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 12:55:40 -0400
Received: (qmail invoked by alias); 19 May 2007 16:55:38 -0000
Received: from p549691BA.dip0.t-ipconnect.de (EHLO noname) [84.150.145.186]
  by mail.gmx.net (mp030) with SMTP; 19 May 2007 18:55:38 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX183nsQN8aI3AgIRVVhRG5z945Zq3jRs1k5NbNepC0
	qYWzAvNSs+Jwa6
User-Agent: KMail/1.9.6
In-Reply-To: <464E4C94.5070408@midwinter.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47757>

On Saturday 19 May 2007, Steven Grimm wrote:
> Andy Parkins wrote:
> > Bear in mind that what you're suggesting is no different in implementation 
> > from what Junio is suggesting but with one difference: in Junio's option 
> > the "identifier" will act as a default URL if no override is found.
> >   
> 
> I don't like using the URL as the key for one simple reason:
> ...

Another argument against naming the key for subprojects "URL" in
config/.gitmodules:
It can happen quite easily that a superprojects includes 2 subprojects
which really are only different branches of the same project, e.g.
GCC 4.1 and GCC 4.2 branch, e.g. to do regression testing with different
compiler versions.
But these two subprojects would be cloned from exactly the same URL.
So you artificially have to change one of the two URLs for this to
work, already at the start of your subproject.

The same example shows that the SHA1 of a projects root commit can not
work as a subproject key.

Josef
