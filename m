From: Edgar Toernig <froese@gmx.de>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 15:22:52 +0200
Message-ID: <20050430152252.0c3fd206.froese@gmx.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	<20050430125333.2bd81b18.froese@gmx.de>
	<1114859594.24014.60.camel@localhost.localdomain>
	<20050430144936.6b05cc90.froese@gmx.de>
	<1114865964.24014.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 15:17:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRrqS-0007fi-UA
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 15:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVD3NW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 09:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVD3NW7
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 09:22:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:19072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261215AbVD3NW5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 09:22:57 -0400
Received: (qmail invoked by alias); 30 Apr 2005 13:22:56 -0000
Received: from p50906D95.dip.t-dialin.net (EHLO dialup) [80.144.109.149]
  by mail.gmx.net (mp025) with SMTP; 30 Apr 2005 15:22:56 +0200
X-Authenticated: #271361
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114865964.24014.77.camel@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
>
> On Sat, 2005-04-30 at 14:49 +0200, Edgar Toernig wrote:
> > +       if (tm.tm_sec > 59)
> > +               return;
> 
> During a leap second, won't tm_sec be 60? And in fact you don't seem to
> handle leap seconds at all, so isn't my_mktime going to be out by one
> second for every leap second which has occurred since 1970?

There are no leap-seconds on POSIX systems.  They allow tm_sec
to be 60 but thats all - 00:00:60 is the same as 00:01:00.

Whether the check should be against 59 or 60?  I don't care.
It's Linus decision.

> There's a reason I'd rather just let glibc handle it :)

Good joke.

Ciao, ET.
