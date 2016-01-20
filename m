From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: remove unnecessary backslashes
Date: Wed, 20 Jan 2016 15:34:30 -0500
Message-ID: <20160120203430.GB6092@sigill.intra.peff.net>
References: <1453310497-7971-1-git-send-email-kraai@ftbfs.org>
 <20160120182421.GA27562@sigill.intra.peff.net>
 <xmqqmvs05722.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>,
	Matthew Kraai <matt.kraai@abbott.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:34:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzSf-0001bD-Ca
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 21:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbcATUed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 15:34:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:57263 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964903AbcATUec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 15:34:32 -0500
Received: (qmail 13815 invoked by uid 102); 20 Jan 2016 20:34:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jan 2016 15:34:32 -0500
Received: (qmail 9371 invoked by uid 107); 20 Jan 2016 20:34:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jan 2016 15:34:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2016 15:34:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmvs05722.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284463>

On Wed, Jan 20, 2016 at 12:28:53PM -0800, Junio C Hamano wrote:

> >> -'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
> >> +'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
> >
> > I see you didn't tweak the middle one here, because it _does_ look like
> > an attribute. Does asciidoctor actually remove the backslashes there?
> 
> A more important question is if it works without the backslashes.
> If not-too-stale versions of asciidoc everybody uses these days are
> all OK without braces quoted with backslashes, and if the same holds
> true for asciidoctor, then we would want consistency here.

The answer to that is implied in the original commit message; no, it
does not work, because it is syntactically an asciidoc attribute.

> On the other hand, if this line must be spelled like the above to
> please asciidoctor, i.e. the first and the last must not have
> backslashes and the second must have backslashes, I'd have to say
> we have a bigger problem.  Perhaps asciidoctor needs to be fixed
> until normal people like we can rely on it.

Yeah, that is the "insane" part I mentioned. It _does_ make sense
syntactically ("-1" cannot possibly be an attribute name, so it does not
parse as one), but I do not like the degree to which writers must know
all of the arcane syntax rules (and cannot rely on something simple like
"{ is special, so I must escape it, and over-escaping is not a
problem").

-Peff
