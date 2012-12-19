From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0200: "locale" may not exist
Date: Wed, 19 Dec 2012 10:32:05 -0500
Message-ID: <20121219153205.GA22207@sigill.intra.peff.net>
References: <7vlicubkt4.fsf@alter.siamese.dyndns.org>
 <20121219131822.GB7134@sigill.intra.peff.net>
 <7vd2y6awo7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:32:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlLdD-0008Qw-8n
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 16:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab2LSPcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 10:32:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58528 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab2LSPcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 10:32:08 -0500
Received: (qmail 29834 invoked by uid 107); 19 Dec 2012 15:33:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 10:33:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 10:32:05 -0500
Content-Disposition: inline
In-Reply-To: <7vd2y6awo7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211827>

On Wed, Dec 19, 2012 at 07:28:24AM -0800, Junio C Hamano wrote:

> > +test_expect_success GETTEXT,!GETTEXT_POISON 'setup locale' '
> >  	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
> > -	is_IS_locale=$(locale -a | sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
> > +	is_IS_locale=$(locale -a | sed -n "/^is_IS\.[uU][tT][fF]-*8\$/{
> 
> Do we need to do this \$?

I'm not sure. Sane shells leave "$/" untouched, but I do not know if we
need to be conservative.

> > -		say "# lib-gettext: Found '$is_IS_locale' as an is_IS UTF-8 locale"
> > +		say "# lib-gettext: Found \"$is_IS_locale\" as an is_IS UTF-8 locale"
> 
> '\''?

Fine by me. I do not care either way in the output, and the escaped dq
is marginally more readable in the source. But either way the source is
pretty ugly. :)

-Peff
