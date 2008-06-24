From: Nicolas Pitre <nico@cam.org>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 18:43:44 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241841150.2979@xanadu.home>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
 <20080624163810.GA4654@sigill.intra.peff.net>
 <alpine.DEB.1.00.0806241750030.9925@racer>
 <alpine.DEB.1.00.0806241808400.9925@racer> <486153DB.3070502@alum.mit.edu>
 <alpine.DEB.1.00.0806242137120.9925@racer>
 <7v8wwubh3j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:45:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHGE-0006BF-7d
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbYFXWnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbYFXWnp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:43:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34699 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYFXWnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:43:45 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Z00C0ZOGWJKF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 18:43:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v8wwubh3j.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86164>

On Tue, 24 Jun 2008, Junio C Hamano wrote:

> Instead of having a set of bisect/good-* refs and a single bisect-bad ref,
> your "fixed and unfixed" mode could work quite differently.  By noticing
> that the topology the user specified with initial good and bad have
> ancient bad and recent good --- that is, "it used to be bad but now it is
> good" --- you could instead use a set of bisect/bad-* refs and a single
> bisect-good ref, and feed good and bad swapped to "rev-list --bisect" in
> bisect_next().  That way, the labels given by visualize will match what
> the user is doing automatically.

... and the final answer would be "the first good commit is ...".

That would be awesome, much nicer than yet more keywords.

> I said "it makes sense in its own way", because it is _quite_ different
> from how git-bisect currently assumes, and restructuring git-bisect to
> operate naturally in a way Michael describes would be a much larger
> surgery with costs (including risks of bugs) associated with it, which
> needs to be weighed in when judging that approach would actually make
> sense.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Nicolas
