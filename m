From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Mon, 25 Jan 2016 04:56:29 -0500
Message-ID: <20160125095629.GB24452@sigill.intra.peff.net>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
 <20160124071234.GA24084@sigill.intra.peff.net>
 <20160124071815.GB24084@sigill.intra.peff.net>
 <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
 <20160124222736.GA29115@sigill.intra.peff.net>
 <CAPig+cTq0j0ss=qw9Dx8-PqFA5WJwP0mpvoO+5=NXtOt2EUNww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 10:56:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNdt3-0007ZF-N7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 10:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbcAYJ4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 04:56:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:59809 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756443AbcAYJ4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 04:56:32 -0500
Received: (qmail 17312 invoked by uid 102); 25 Jan 2016 09:56:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jan 2016 04:56:32 -0500
Received: (qmail 16703 invoked by uid 107); 25 Jan 2016 09:56:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jan 2016 04:56:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jan 2016 04:56:29 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTq0j0ss=qw9Dx8-PqFA5WJwP0mpvoO+5=NXtOt2EUNww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284729>

On Sun, Jan 24, 2016 at 06:39:05PM -0500, Eric Sunshine wrote:

> > Yeah, "strip=2" would also get the job done, and extends more naturally
> > to the branch case.
> >
> > To be honest, I cannot imagine anybody using anything _but_ strip=2, but
> > maybe there are special cases, like:
> >
> >   git for-each-ref --format='%(refname:strip=3)' refs/heads/jk/
> >
> > to get my list of topics, sans initials.
> 
> What if the option was named ":stripprefix=" in its most general form:
> 
>     %(refname:stripprefix=refs/tags/)
> 
> with plain:
> 
>     %(refname:stripprefix)
> 
> shorthand for ":stripprefix=refs/*/" or something?

That would work, though I was really hoping not to get into something as
complicated as globbing. I'm not sure it really buys us that much here.

-Peff
