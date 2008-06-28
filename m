From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: report local storage errors in status table
Date: Sat, 28 Jun 2008 00:21:15 -0400
Message-ID: <20080628042114.GB9451@sigill.intra.peff.net>
References: <1214509350.28344.31.camel@odie.local> <20080627030245.GA7144@sigill.intra.peff.net> <20080627035747.GC7144@sigill.intra.peff.net> <20080627035950.GA21382@sigill.intra.peff.net> <7vprq2moua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>,
	git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 06:22:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCRwz-0007vO-Ik
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 06:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbYF1EVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 00:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYF1EVR
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 00:21:17 -0400
Received: from peff.net ([208.65.91.99]:3227 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbYF1EVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 00:21:17 -0400
Received: (qmail 8445 invoked by uid 111); 28 Jun 2008 04:21:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 28 Jun 2008 00:21:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jun 2008 00:21:15 -0400
Content-Disposition: inline
In-Reply-To: <7vprq2moua.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86700>

On Fri, Jun 27, 2008 at 04:37:33PM -0700, Junio C Hamano wrote:

> > With this patch, the output takes into account the status of
> > updating the local ref:
> >
> >   error: there are still refs under 'refs/remotes/origin/foo'
> >   From $url_of_repo
> >    ! [new branch]      foo        -> origin/foo  (unable to update local ref)
>
> Makes sense --- thanks.  This is something we can have automated tests,
> isn't it?

We don't currently have any tests for either the fetch output or the
push output. Note that we aren't changing the output _status_. Fetch
always knew that this condition was a failure, and exited appropriately.
So it really would just be testing the expected human-readable output in
these situations, something I thought we usually didn't include in the
tests.

But if you think it is worth doing, I can whip up a few tests.

-Peff
