From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] api-credential.txt: show the big picture first
Date: Mon, 4 Jun 2012 07:51:08 -0400
Message-ID: <20120604115108.GA27676@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 13:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbVof-0002e5-78
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 13:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757787Ab2FDLvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 07:51:17 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:42443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516Ab2FDLvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 07:51:16 -0400
Received: (qmail 2078 invoked by uid 107); 4 Jun 2012 11:51:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Jun 2012 07:51:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2012 07:51:08 -0400
Content-Disposition: inline
In-Reply-To: <1338739804-32167-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199130>

On Sun, Jun 03, 2012 at 06:10:02PM +0200, Matthieu Moy wrote:

> The API documentation targets two kinds of developers: those using the
> (C) API, and those writing remote-helpers. The document was not clear
> about which part was useful to which category, and for example, the C API
> could be mistakenly thought as an API for writting remote helpers.
> 
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I took Jeff's explanation, but I insist in having a picture ;-).

Thanks. I had meant to follow-up, but it was among the least interesting
things for me to work on, so I procrastinated. And here I am being
rewarded for it with somebody else doing the work. :)

Looks good overall to me. Two minor comments:

> +The git code (typically a remote-helper) will call the C API to obtain
> +credential data like a login/password couple (credential_fill). The

I found the word "couple" odd here; I think "pair" would be more
idiomatic English.

> +API will itself call a remote helper (e.g. "git credential-cache" or
> +"git credential-store") that may retrieve credential data from a
> +store. If the credential helper cannot find the information, the C API
> +will prompt the user. Then, the caller of the API takes care of
> +contacting the server, and do the actual authentication.

s/do/does/

-Peff
