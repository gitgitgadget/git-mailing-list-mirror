From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t0300-credentials: poll failed: invalid argument
Date: Fri, 9 Sep 2011 16:13:13 +0200
Message-ID: <201109091613.13137.trast@student.ethz.ch>
References: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com> <01E9C05C-A19D-45B0-B15D-DA6B911C11A9@silverinsanity.com> <20110829174309.GA11524@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:13:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21pZ-0006N6-Na
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 16:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175Ab1IIONQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 10:13:16 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:11325 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab1IIONP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 10:13:15 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 16:13:11 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 16:13:13 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20110829174309.GA11524@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181070>

Jeff King wrote:
> On Mon, Aug 29, 2011 at 01:28:05PM -0400, Brian Gernhardt wrote:
> 
> > > Ugh, sorry, this is my fault. The check_expiration() function can return
> > > a totally bogus value before we actually get any credentials.
> > > 
> > > Does this patch fix it for you?
> > 
> > Yes it does!  Surprisingly enough, non-bogus parameters keeps poll
> > from erroring with EINVAL.  Funny that.  ;-)
> 
> Great. I'm working on a few more patches on top of that topic, so I'll
> add it to my list to send out in the next day or so.

I'm still seeing this with current pu (from repo.or.cz), but only on
OS X

  $ uname -a
  Darwin mackeller.inf.ethz.ch 11.1.0 Darwin Kernel Version 11.1.0: Tue Jul 26 16:07:11 PDT 2011; root:xnu-1699.22.81~1/RELEASE_X86_64 x86_64

Where "this" is:

  --- expect-stderr       2011-09-09 14:12:13.000000000 +0000
  +++ stderr      2011-09-09 14:12:13.000000000 +0000
  @@ -1,2 +1,3 @@
   askpass: Username:
   askpass: Password:
  +fatal: poll failed: Invalid argument

for each of the tests 15--19.  Is it supposed to be fixed?

I don't have time to look into it without knowing what to search for,
but if you want me to test anything on that OS X just ask.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
