From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Fri, 15 Jan 2016 13:30:10 -0500
Message-ID: <20160115183010.GA10431@sigill.intra.peff.net>
References: <20160114202608.GA8806@sigill.intra.peff.net>
 <alpine.DEB.2.20.1601150743590.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:30:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK98e-00040N-8i
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 19:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbcAOSaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 13:30:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:54536 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750975AbcAOSaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 13:30:13 -0500
Received: (qmail 5630 invoked by uid 102); 15 Jan 2016 18:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 13:30:13 -0500
Received: (qmail 22287 invoked by uid 107); 15 Jan 2016 18:30:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 13:30:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 13:30:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1601150743590.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284195>

On Fri, Jan 15, 2016 at 07:45:16AM +0100, Johannes Schindelin wrote:

> > This sort-of applies on top of js/dirname-basename, which is in next.
> > Textually, it's fine, but that topic is based on v2.6.5, and xsnprintf
> > was only added in the v2.7.0 cycle. The simplest thing is probably to
> > wait for it to graduate to master, and then apply there as a new topic
> > (if we do v2.6.6, it's OK for it not to have this patch).
> > 
> > I can hold and resend in a week or two if that's easier.
> 
> If you have a patch to make dirname/basename safer based on xsnprintf, I
> would like to have that as soon as possible (next was rewound to 2.7.0,
> no?)...

I'm not sure what you mean. `dirname/basename` themselves don't have any
problems. It's only the `strcpy` in the test program that I wanted to
fix.

If Junio wants to rebase js/dirname-basename on a more recent tip (say,
current "master") as part of the rewind, this could be applied directly
(or just squashed in).

-Peff
