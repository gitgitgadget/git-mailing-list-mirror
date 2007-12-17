From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 18:05:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171804040.9446@racer.site>
References: <20071215155150.GA24810@coredump.intra.peff.net>
 <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net>
 <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org>
 <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net>
 <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net>
 <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net>
 <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com> <Pine.LNX.4.64.0712171038130.9446@racer.site>
 <36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com> <Pine.LNX.4.64.0712171151490.9446@racer.site>
 <57245FA1-361B-4333-B490-A2CC99ED4F9C@wincent.com> <476669A7.1050407@viscovery.net>
 <Pine.LNX.4.64.0712171250550.9446@racer.site> <7vsl218aqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 19:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KMd-0002m6-4T
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbXLQSGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754314AbXLQSGG
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:06:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:35472 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752029AbXLQSGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:06:05 -0500
Received: (qmail invoked by alias); 17 Dec 2007 18:06:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 17 Dec 2007 19:06:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FJfJEcWMFqWFnLzf2gqv2Ua35PweVbswJiGeeTx
	vrRF+ACqqNup1e
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl218aqd.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68587>

Hi,

On Mon, 17 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> >> But as at least one released version of GNU diff has a pretty 
> >> >> serious bug, I would rather not rely too much on diff.  (BTW this 
> >> >> was the reason I wanted --no-index so badly.)
> >> >>
> >> >> So yeah, the second "diff" cannot be "git diff".  Maybe "cmp", but 
> >> >> not "git diff".
> >> > 
> >> > Well cmp would be fine as well, seeing all we want is a boolean "is 
> >> > this the same or not" answer. (I'm not familiar with the GNU diff 
> >> > bug you speak of, but was it so bad that it couldn't even get 
> >> > *that* answer right?)
> >> 
> >> Heh, there's at least one distribution out there (Suse 10.1) that 
> >> comes with a *cmp* that doesn't get that answer right if its output 
> >> is connected to /dev/null, which is the case when you simply 'make 
> >> test'.
> >
> > Yeah.  That's what it was.  I even posted a patch to GNU diff, only to 
> > find out that it was already fixed in CVS.  Sigh.
> 
> Wait.  Are you still talking about diff or cmp, or are you saying that 
> your earlier statement about avoiding GNU diff due to its bugs is 
> unfounded?

I do not remember offhand.  I only remembered that it was the GNU diff 
package.  But maybe it was only the "cmp" tool.  Symptoms were that tests 
were failing without "-i", but succeeding with "-i".

Okay, I found the mail:

http://article.gmane.org/gmane.comp.version-control.git/25107/match=cmp

Seems it was only "cmp".

Sorry for the noise,
Dscho
