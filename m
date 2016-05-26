From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Thu, 26 May 2016 00:36:07 -0400
Message-ID: <20160526043607.GB6756@sigill.intra.peff.net>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160518181500.GD5796@sigill.intra.peff.net>
 <b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
 <vpq8tz0hd2g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr, gitster@pobox.com,
	stefan@sevenbyte.org, jrnieder@gmail.com, rybak.a.v@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 26 06:36:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5n1r-0000Dn-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 06:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbcEZEgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 00:36:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:44434 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750754AbcEZEgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 00:36:11 -0400
Received: (qmail 5379 invoked by uid 102); 26 May 2016 04:36:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:36:10 -0400
Received: (qmail 16876 invoked by uid 107); 26 May 2016 04:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:36:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 00:36:07 -0400
Content-Disposition: inline
In-Reply-To: <vpq8tz0hd2g.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295629>

On Mon, May 23, 2016 at 07:57:43PM +0200, Matthieu Moy wrote:

> Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr> writes:
> 
> > Since 2.8.3 was out recently, we could flip MAN_BOLD_LITERAL on by
> > default for this cycle to shake out problems as Jeff King suggested
> > [2].
> 
> 2.8.3 was a bufix release, and flipping a controversial flag should
> clearly not be done on a bugfix release. So, in this context, "beginning
> of a cycle" means after a x.y.0 release.
> 
> Anyway, a patch enabling MAN_BOLD_LITERAL by default would need to cook
> in pu and next as any other patches, so the time when the patch is sent
> does not really matter.

Yeah, I think a reasonable plan is:

  1. Somebody produces a patch flipping the default. The patch is
     trivial, but the commit message should tell why, and try to dig up
     any possible problems we might see (e.g., why wasn't this the
     default? Particular versions of tools? Some platforms?)

  2. Assuming no problems, Junio merges the patch to "next". We get
     any reports of issues from people using "next" day-to-day.

  3. Assuming no problems, Junio merges to "master". We hit more people
     (who build from master). And also it would be part of the
     pre-generated pages that Junio ships, so we might get reports
     there.

  4. Eventually it's released. We hope to get no problem reports there,
     though it _does_ hit a wider audience at that point.

Steps 1 and 2 can happen now. As we are in the -rc cycle right now,
probably step 3 would happen post-v2.9. But there's no reason not to
start the clock ticking now.

-Peff
