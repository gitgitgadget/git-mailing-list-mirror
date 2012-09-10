From: Jeff King <peff@peff.net>
Subject: Re: Probable bug in file run-command.c function
 clear_child_for_cleanup
Date: Mon, 10 Sep 2012 10:10:27 -0400
Message-ID: <20120910141027.GA8284@sigill.intra.peff.net>
References: <504CAB66.1050003@optimisefitness.com>
 <20120910134406.GA7496@sigill.intra.peff.net>
 <CABPQNSaufY9vUAFp9VL2i=6bNmO5_2+anzX6+omfq+UgP03kXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Gould <david@optimisefitness.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 16:10:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB4hF-0001Yl-7q
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 16:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab2IJOKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 10:10:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39592 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab2IJOKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 10:10:30 -0400
Received: (qmail 27849 invoked by uid 107); 10 Sep 2012 14:10:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 10:10:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 10:10:27 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSaufY9vUAFp9VL2i=6bNmO5_2+anzX6+omfq+UgP03kXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205127>

On Mon, Sep 10, 2012 at 03:58:40PM +0200, Erik Faye-Lund wrote:

> >> for (... {
> >>       if (... {
> >>               ...
> >>       }
> >>       last = &p->next;
> >> }
> [...]
> I feel like bikeshedding a bit today!
> 
> I tend to either prefer either the latter or something like this:
> 
> while (p) {
> 	...
> 
> 	last = p;
> 	p = p->next;
> }
> 
> because those approaches put all the iteration logic in the same
> place. The in-body traversal approach is a bit more explicit about the
> traversal details.

Also fine by me.

> And to conclude my bikeshedding for the day: Shouldn't "last" ideally
> be called something like "prev" instead? It's the previously visited
> element, not the last element in the list.

It is the "last" element visited (just as "last week" is not the end of
the world), but yes, it is ambiguous, and "prev" is not. Either is fine
by me.

-Peff
