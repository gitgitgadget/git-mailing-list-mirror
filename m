From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Fri, 11 Jul 2008 01:59:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807110155040.3279@eeepc-johanness>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <200807102126.37567.chriscool@tuxfamily.org> <7vd4llpkxq.fsf@gitster.siamese.dyndns.org> <200807110036.17504.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
 <7v7ibtnx09.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:01:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH64Y-0005fz-Ap
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 02:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbYGJX7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbYGJX7l
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:59:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:53776 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754900AbYGJX7l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:59:41 -0400
Received: (qmail invoked by alias); 10 Jul 2008 23:59:39 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp038) with SMTP; 11 Jul 2008 01:59:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qvB8chpFq0JnFTW7uyvYXu7D97BryJ2W/jQdUQF
	jcCiaCflfjXQB8
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v7ibtnx09.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88062>

Hi,

On Thu, 10 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > You are opening a can of worms here, and I doubt that this is a good idea.
> >
> > git-bisect as-is has very precise, and _simple_ semantics, and users 
> > should really know what they are doing (i.e. not marking something as 
> > "good" which is on a branch containing a fix).
> >
> > Trying to be too clever here might just make the whole tool rather 
> > useless.
> 
> Have you read the original thread yet?  I do not think this is trying to
> be clever at all, but trying to be helpful.
> 
> As you explained, bisection *requires* that Good is ancestor of Bad.

Thanks, I got that already.

Of course it can be that the user commits a pilot error and says "but that 
unrelated version was good", while the fork point(s) between good and bad 
was bad (and this might be even the intention of the user, to find _one_ 
commit that introduced the bug).

Speaking of plural, what if some of the merge bases are good, some are 
bad?

Without carefully thinking it through, you might even _break_ the tool.

All I was proposing is keeping the current semantics, keeping the 
mechanism simple, and therefore reliable.

Ciao,
Dscho
