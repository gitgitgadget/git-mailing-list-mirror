From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: re-encode commit messages before grepping
Date: Mon, 11 Feb 2013 16:14:29 -0500
Message-ID: <20130211211429.GE32740@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <20130211205958.GA32740@sigill.intra.peff.net>
 <7vmwvalfnn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50iG-0001zR-AV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab3BKVOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:14:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44609 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078Ab3BKVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:14:32 -0500
Received: (qmail 27090 invoked by uid 107); 11 Feb 2013 21:16:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 16:16:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 16:14:29 -0500
Content-Disposition: inline
In-Reply-To: <7vmwvalfnn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216091>

On Mon, Feb 11, 2013 at 01:11:24PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   1. I suppose we could also use $LANG or one of the $LC_* variables to
> >      guess at the encoding of the user's pattern. But I think using the
> >      output encoding makes the most sense, since then the pattern you
> >      searched for will actually be in the output.
> 
> I agree.  In addition, if we were to do anything with LANG/LC_CTYPE,
> it should be done at the layer that implements log-output-encoding
> (e.g. lack of configured encoding with nonstandard LANG/LC_CTYPE
> would use the locale, or something), I think.

Yeah, I had the same thought. I'll leave it to somebody who knows/cares
more about i18n. In my world view, utf8 is good enough for everyone. :)

-Peff
