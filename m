From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: on subtree checkout
Date: Tue, 26 Feb 2008 11:23:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261119590.17164@racer.site>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>  <alpine.DEB.1.00.0802260156350.3322@eeepc-johanness> <ee77f5c20802251830p47c6de60je97a31cb34bc3105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 12:24:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTxun-0007rR-5u
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 12:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbYBZLX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 06:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbYBZLX2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 06:23:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751089AbYBZLX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 06:23:27 -0500
Received: (qmail invoked by alias); 26 Feb 2008 11:23:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 26 Feb 2008 12:23:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xaGQmMJwxQMEJp/MGAO8Zfyq2dAxZBfH9TEEyZJ
	TDg44HeHMf0DOH
X-X-Sender: gene099@racer.site
In-Reply-To: <ee77f5c20802251830p47c6de60je97a31cb34bc3105@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75121>

Hi,

On Mon, 25 Feb 2008, David Symonds wrote:

> On Mon, Feb 25, 2008 at 5:59 PM, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > But I agree with others that you should think about sane 
> > implementations of rebase/merge with partial checkouts.
> 
> I, too, was shortly going to attempt a partial checkout/clone 
> implementation. The intended context of my implementation was similar to 
> the KDE scenario in that you might only care about /pkgA and /pkgB, so 
> changes to /pkgC are usually irrelevant and independent to your 
> work-flow, so I was planning to assume a simplistic "theirs" merge 
> strategy for /pkgC, etc.

That might work for the people who have partial checkouts.  But I see a 
lot of problems looming there: just imagine a documenter rebased on top of 
'master', and _then_ on top of a branch by another documenter, which is 
newer with respect to documentation, but older with respect to the code.

It is _really_ easy to break code if you have no intention to test the 
result of a merge, _especially_ so when it is a "theirs" strategy.

Ciao,
Dscho
