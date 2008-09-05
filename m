From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show decoration
Date: Thu, 4 Sep 2008 20:37:10 -0400
Message-ID: <20080905003710.GA17731@coredump.intra.peff.net>
References: <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx> <20080905001133.GA17463@coredump.intra.peff.net> <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 02:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbPLG-0003L8-6m
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 02:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYIEAhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 20:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbYIEAhN
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 20:37:13 -0400
Received: from peff.net ([208.65.91.99]:2221 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbYIEAhM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 20:37:12 -0400
Received: (qmail 13476 invoked by uid 111); 5 Sep 2008 00:37:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 04 Sep 2008 20:37:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Sep 2008 20:37:10 -0400
Content-Disposition: inline
In-Reply-To: <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94983>

On Thu, Sep 04, 2008 at 05:28:13PM -0700, Junio C Hamano wrote:

> > The whole series looks good to me, and I am happy if it is applied
> > as-is. The only question I might raise is whether we want to use "%d"
> > for this, or use something longer to anticipate a collision with other
> > "d" words (I think you mentioned "describe" at one point).
> 
> How about using "%d()" for this one, so that later enhancements can
> specify their features inside parentheses?

I am slightly opposed to that, just because it then is very inconsistent
with the other formatting specifiers. I think it is worth introducing a
new, consistent syntax, providing that syntax for all specifiers (e.g.,
%(body), %(decorate)), and then saying "the existing %b, %d, et al are
still available and will be available forever. BUT they will never grow
the more interesting features like %(body:wrap=80) or
%(decorate:delim=, ).

-Peff
