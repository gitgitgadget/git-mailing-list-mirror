From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Fri, 22 May 2015 02:49:23 -0400
Message-ID: <20150522064922.GA27716@peff.net>
References: <20150521041435.GA18978@peff.net>
 <20150521041619.GC5196@peff.net>
 <8895881cd3f324d2b8a827e311296a48@www.dscho.org>
 <3516DC60279A42188EE2AA394921FC70@PhilipOakley>
 <1be7702fa53d1705e913aff2e00eac21@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 22 08:49:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvglw-0003dm-Rf
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 08:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbbEVGt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:49:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:34491 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbbEVGt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 02:49:26 -0400
Received: (qmail 17042 invoked by uid 102); 22 May 2015 06:49:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 01:49:26 -0500
Received: (qmail 12433 invoked by uid 107); 22 May 2015 06:49:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 02:49:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 02:49:23 -0400
Content-Disposition: inline
In-Reply-To: <1be7702fa53d1705e913aff2e00eac21@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269695>

On Fri, May 22, 2015 at 08:37:56AM +0200, Johannes Schindelin wrote:

> > +--seed <repository|bundle>::
> > +    Fetch objects from <repository> or <bundle> instead of the clone
> > URL when possible. This is useful when a (possibly partial) clone
> > already exists locally, to avoid transferring the same objects again.
> > 
> > I haven't checked if the invocation would accept a bundle filename,
> > but I'm presuming it can in the same way that clone does.
> 
> The proof would lie in the pudding ;-) Would you mind testing whether it works with bundles?

I can't imagine that it would with my patch. The implementation is based
on --reference, which is going to try to set up the bundle as an
alternate.

Having slept on it, I really think "--seed" should be "fetch from the
seed into temp refs", and not what I posted earlier.

-Peff
