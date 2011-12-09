From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 12/13] credentials: add "store" helper
Date: Fri, 9 Dec 2011 18:19:09 -0500
Message-ID: <20111209231909.GA14526@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <20111206062305.GL29233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 00:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ9in-0005d4-7h
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab1LIXTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:19:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45434
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab1LIXTM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:19:12 -0500
Received: (qmail 9779 invoked by uid 107); 9 Dec 2011 23:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Dec 2011 18:25:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2011 18:19:09 -0500
Content-Disposition: inline
In-Reply-To: <20111206062305.GL29233@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186702>

On Tue, Dec 06, 2011 at 01:23:05AM -0500, Jeff King wrote:

> +int main(int argc, const char **argv)
> +{
> +	const char * const usage[] = {
> +		"git credential-store [options] <action>",
> +		NULL
> +	};
> +	const char *op;
> +	struct credential c = CREDENTIAL_INIT;
> +	char *file = NULL;
> +	struct option options[] = {
> +		OPT_STRING_LIST(0, "file", &file, "path",
> +				"fetch and store credentials in <path>"),
> +		OPT_END()
> +	};

Eek, this should be OPT_STRING, of course. I'll fix it in my next
re-roll, but I wanted to mention it in case anybody is reviewing v2.

-Peff
