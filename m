From: Jeff King <peff@peff.net>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 15:52:54 -0400
Message-ID: <20090319195254.GA17028@coredump.intra.peff.net>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net> <20090319044313.GA341@coredump.intra.peff.net> <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:54:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOKL-0005NQ-01
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbZCSTxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbZCSTxG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:53:06 -0400
Received: from peff.net ([208.65.91.99]:46346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbZCSTxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 15:53:05 -0400
Received: (qmail 3032 invoked by uid 107); 19 Mar 2009 19:53:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 15:53:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 15:52:54 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113814>

On Thu, Mar 19, 2009 at 11:36:50AM +0100, Johannes Schindelin wrote:

> > +void sort_string_list_with_fn(struct string_list *list,
> > +			      int (*fn)(const void *, const void *))
> > +{
> > +	qsort(list->items, list->nr, sizeof(*list->items), fn);
> > +}
> > +
> 
> Do we really want an API for that?  Calling qsort() directly should be 
> obvious enough, no?

I'm fine with that, too. I was just encapsulating out of habit. But if
it is normal to peek directly at list->nr and list->items, then calling
qsort directly is fine.

-Peff
