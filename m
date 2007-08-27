From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: name-rev does not show the shortest path
Date: Mon, 27 Aug 2007 10:57:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271049000.28586@racer.site>
References: <20070823103817.GF6573@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
 <20070824125230.GA12030@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk>
 <7v6434eq9o.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0708251701150.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070826092323.GB30474@coredump.intra.peff.net>
 <Pine.LNX.4.64.0708261733400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070827092422.GA20340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbJd-0004zw-8M
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 11:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbXH0JzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 05:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbXH0JzR
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 05:55:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:42448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753378AbXH0JzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 05:55:14 -0400
Received: (qmail invoked by alias); 27 Aug 2007 09:55:12 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp010) with SMTP; 27 Aug 2007 11:55:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QyHwUX+2QSAgLUz9n93kgqct23tgRd15yPWOunZ
	h/RuH3QtQsUrVk
X-X-Sender: gene099@racer.site
In-Reply-To: <20070827092422.GA20340@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56800>

Hi,

On Mon, 27 Aug 2007, Jeff King wrote:

> On Sun, Aug 26, 2007 at 05:38:22PM +0200, Johannes Schindelin wrote:
> 
> > The old code _should_ have worked; it is more likely that your 
> > different metric just hides the bug.  The old metric tried to favour 
> > less merge traversals over more traversals, but at the same time, it 
> > favoured smaller numbers over larger ones (but as you found out, only 
> > in the last component).
> 
> Right, the problem is that we have effectively _thrown away_ the
> "smaller numbers over larger ones" information for components other than
> the last.

You're right.  I misremembered name-rev to use a fifo instead of stupid 
recursion.

Will fix.

Ciao,
Dscho
