From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Mon, 12 Nov 2007 22:17:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711122212540.4362@racer.site>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com>
 <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr>
 <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0711121702030.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irhbt-00055k-4e
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865AbXKLWSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755732AbXKLWSJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:18:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:48343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755520AbXKLWSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:18:07 -0500
Received: (qmail invoked by alias); 12 Nov 2007 22:18:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 12 Nov 2007 23:18:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ox8NhFQpo1/o1tctfCOKZR7ibe8AMgp99BXWBKP
	bA4o6I74cNTjG7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0711121702030.21255@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64721>

Hi,

On Mon, 12 Nov 2007, Nicolas Pitre wrote:

> On Mon, 12 Nov 2007, Junio C Hamano wrote:
> 
> > His second point is also a real issue.  If you allowed cloning
> > an empty repo (either bare or non-bare), then you and Bill can
> > both clone from it, come up with an initial commit each.  Bill
> > pushes his initial commit first.  Your later attempt to push
> > will hopefully fail with "non fast forward", if you know better
> > than forcing such a push, but then what?  You need to fetch, and
> > merge (or rebase) your change on top of Bill's initial commit,
> > and at that point the history you are trying to merge does not
> > have any common ancestor with his history.
> 
> While that could well be true, I don't see this condition happening 
> solely in the context (hence because) of an empty clone.

Hehe.  That is a very delicate play with predicates.

If Alice and Bob clone from an empty repository, and both work on it, 
there is _no way_ that they can have a common ancestor[*].  Hence, an 
empty clone _would_ be a cause of that condition.

The only way to _not_ have this condition would be at least one side 
starting with a non-empty clone.  Or with an _effectively_ non-empty 
clone.

Ciao,
Dscho

[*] Oh yes, theoretically they could commit the same commit with the same 
author info and author timestamp, but to be a common ancestor, they would 
also have to use the same _committer_information, which means that Alice 
== Bob, as far as Git is concerned.  Do I have to go on?
