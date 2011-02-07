From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 00:11:23 -0500
Message-ID: <20110207051123.GA4748@sigill.intra.peff.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070022.51403.johan@herland.net>
 <vpqtyggk9i2.fsf@bauges.imag.fr>
 <201102070451.37370.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 06:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmJOa-0006yt-Rt
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 06:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856Ab1BGFLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 00:11:30 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab1BGFL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 00:11:29 -0500
Received: (qmail 25246 invoked by uid 111); 7 Feb 2011 05:11:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 05:11:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 00:11:23 -0500
Content-Disposition: inline
In-Reply-To: <201102070451.37370.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166229>

On Mon, Feb 07, 2011 at 04:51:37AM +0100, Johan Herland wrote:

> > Take the example of the interim maintainer cited somewhere else in
> > this thread. If Shawn fetches from Junio, he'll get a junio/v1.7.4
> > tag, and on my side, I do not want to end up having
> > shawn/junio/v1.7.4, especially if this means that people fetching from
> > me would end up with a me/shawn/junio/v1.7.4 ...
> 
> You won't end up with "shawn/junio/v1.7.4". When Shawn fetches from Junio, 
> what he actually gets is "refs/remotes/junio/tags/v1.7.4" ("junio/v1.7.4" is 
> a shorthand; "v1.7.4" is an even better shorthand).

But keep in mind that this proposal will have to live alongside repos
that are using older versions of git. So Shawn might very well have
refs/tags/v1.7.4 from Junio if he is using (or has ever used) pre-1.8.0
git.

No, that won't give you me/shawn/junio/v1.7.4, but it does mean we have
to gracefully handle the case of ambiguous duplicate tags (that happen
to point to the same thing).

Which I think you are implying here:

> Next, you should never pull from Shawn's work repo, but rather from the repo 
> he has published. In that repo he will typically have pushed the "v1.7.4" 
> tag (as described above). When you pull from Shawn's public repo, you will 
> get the "v1.7.4" tag at "refs/remotes/shawn/tags/v1.7.4" (but "v1.7.4" is an 
> unambigious shorthand).

But I wanted to point it out explicitly.

-Peff
