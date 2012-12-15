From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: don't link to example mail addresses
Date: Sat, 15 Dec 2012 12:20:18 -0500
Message-ID: <20121215172018.GA18696@sigill.intra.peff.net>
References: <20121215150314.GC2725@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjvPl-0006x8-7r
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 18:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab2LORUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 12:20:24 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55509 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab2LORUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 12:20:23 -0500
Received: (qmail 22262 invoked by uid 107); 15 Dec 2012 17:21:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 12:21:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 12:20:18 -0500
Content-Disposition: inline
In-Reply-To: <20121215150314.GC2725@river.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211534>

On Sat, Dec 15, 2012 at 03:03:15PM +0000, John Keeping wrote:

> Mail addresses in documentation are converted into mailto: hyperlinks in
> the HTML output and footnotes in man pages.  This isn't desirable for
> cases where the address is used as an example and is not valid.
> 
> Particularly annoying is the example "jane@laptop.(none)" which appears
> in git-shortlog(1) as "jane@laptop[1].(none)", with note 1 saying:
> 
> 	1. jane@laptop
> 	   mailto:jane@laptop

Thanks, this is definitely worth fixing.

> Fix this by quoting example mail addresses with "$$", preventing
> Asciidoc from processing them.
> 
> In the case of mailmap.txt, render the address monospaced so that it
> matches the block examples surrounding that paragraph.

I think I'd just render them monospace everywhere. We are very
inconsistent about which form of quotes we use in the documentation (I
think because most of the developers read the source directly and not
the rendered asciidoc). And then we don't have to worry about the "$$"
construct (and IMHO it makes the source much more readable, and marking
the address as a literal looks good in the output, too).

-Peff
