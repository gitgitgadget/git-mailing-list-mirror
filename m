From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Tue, 9 Sep 2014 18:31:59 -0400
Message-ID: <20140909223158.GD14029@peff.net>
References: <540F426E.6080908@exec64.co.uk>
 <xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
 <540F554C.5010301@exec64.co.uk>
 <xmqqegvkk2k3.fsf@gitster.dls.corp.google.com>
 <20140909214520.GA13603@peff.net>
 <540F7C70.4010909@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:32:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTxH-0003aK-6M
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbaIIWcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:32:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:46241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752326AbaIIWcB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:32:01 -0400
Received: (qmail 20085 invoked by uid 102); 9 Sep 2014 22:32:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 17:32:01 -0500
Received: (qmail 11482 invoked by uid 107); 9 Sep 2014 22:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 18:32:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2014 18:31:59 -0400
Content-Disposition: inline
In-Reply-To: <540F7C70.4010909@exec64.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256719>

On Tue, Sep 09, 2014 at 11:17:20PM +0100, Harry Jeffery wrote:

> I definitely prefer your more general solution to my
> bare-minimum-to-scratch-itch patch. I'd certainly be willing to take your
> patch and expand upon it (pun unintended) once Junio has weighed in on your
> suggestions.

Thanks. I am always happy to see contributors willing to pick up and run
with ideas.

It is probably out-of-scope for what you want, but while we are talking
about %d, it may be worth considering whether there is something simple
we can do to make formatting list-like items more flexible. E.g., even
with "%D", you are stuck with the format "foo, bar, baz" for multiple
decorations. Some kind of "%join(%d,; )" might work to produce "foo;
bar; baz" (or whatever you want). But that may also be crossing the line
into insanity, and we would be better to allow some Turing-complete
embedded language like lua. For that matter, conditionals might be
crossing that insanity line, too.

> Regardless of what happens with the conditional expansion I think it would
> definitely be a useful addition to be able to print the decorators without
> the " (...)" wrapper. I think it's general enough that it'd warrant its own
> separate patch rather than being part of a patch series for the conditional
> expansion.

Yeah, I agree it can be separate.

-Peff
