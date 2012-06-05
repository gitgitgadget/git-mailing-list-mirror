From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Tue, 5 Jun 2012 02:59:55 -0400
Message-ID: <20120605065955.GB25809@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org>
 <vpq1ulvuxd9.fsf@bauges.imag.fr>
 <20120604115630.GC27676@sigill.intra.peff.net>
 <vpqpq9en8ol.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:00:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbnkI-0000gO-AU
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 09:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab2FEG75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 02:59:57 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43072
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab2FEG75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 02:59:57 -0400
Received: (qmail 14260 invoked by uid 107); 5 Jun 2012 07:00:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 03:00:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 02:59:55 -0400
Content-Disposition: inline
In-Reply-To: <vpqpq9en8ol.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199206>

On Mon, Jun 04, 2012 at 10:06:34PM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We only build html documentation from technical/, not manpages. So they
> > could just all be switched to link: (the point of linkgit is to format a
> > manpage reference from either html or a manpage).
> 
> OTOH, using linkgit: makes it easier to cut-and-paste from technical/ to
> man pages (which may be sensible for plumbing commands), so I think it's
> OK to keep linkgit:.

Except that you cannot cut-and-paste, since it has ".." in it. :)

But yeah, I guess it does have some other niceties, like adding the
".html" on the end, converting git-config[1] into the right text, etc. I
was just thinking that by using link: directly, we would make it look
nicer (e.g., drop the ".." from the actual link text). Maybe we can even
strip that in the macro, though.

I wonder if we could even make asciidoc work to convert
linkgit:git-config[1] into the right path (i.e., to include the ".."
automatically) when we are in the subdir.

I don't really have a sense how powerful asciidoc macros are, but this
seems like an obvious case that they should handle.

-Peff
