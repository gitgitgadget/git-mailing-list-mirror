From: Jeff King <peff@peff.net>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 08:56:18 -0400
Message-ID: <20080422125618.GA27577@sigill.intra.peff.net>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <efault@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:57:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoI3j-00030L-0m
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 14:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbYDVM4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 08:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbYDVM4V
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 08:56:21 -0400
Received: from peff.net ([208.65.91.99]:3357 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbYDVM4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 08:56:21 -0400
Received: (qmail 19593 invoked by uid 111); 22 Apr 2008 12:56:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 08:56:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 08:56:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80111>

Mike wrote:

> > > Thanks a bunch.  I'll try it.  I notice that origin and linux-next
> > > already had + prefix.  Presumably that came from the home repo.

Dscho wrote:

> It was a concious decision, but maybe it was wrong.
> 
> My rationale was this: if I mirror another person's repository, I want all 
> the history.  And I do want to keep it, even if the other person decides 
> to clean the original repository out.
>
> (In this case, the reflogs would not help, since I do not have a HEAD 
> reflog for all the deleted branches, and deleting the refs deletes their 
> reflogs, too.)

Hmm, there is an inconsistency here, though, since we set it up one way
on clone and another way on "remote add". Though if clone does finally
become "init + remote add + checkout" that will resolve itself.

Still, I think I prefer the old "+" behavior. We don't actually
_delete_ branches, we just allow non-fast-forward updates. The reflogs
will still be there.

-Peff
