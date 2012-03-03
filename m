From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.proxy: also mention https_proxy and all_proxy
Date: Sat, 3 Mar 2012 12:42:52 -0500
Message-ID: <20120303174252.GC28602@sigill.intra.peff.net>
References: <20120303145053.GA29948@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Mar 03 18:42:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3syx-0006Wn-6K
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab2CCRmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:42:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36104
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2CCRmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:42:54 -0500
Received: (qmail 8094 invoked by uid 107); 3 Mar 2012 17:43:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 03 Mar 2012 12:43:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2012 12:42:52 -0500
Content-Disposition: inline
In-Reply-To: <20120303145053.GA29948@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192120>

On Sat, Mar 03, 2012 at 03:50:53PM +0100, Clemens Buchacher wrote:

> The current wording of the http.proxy documentation suggests that
> http_proxy is somehow equivalent to http.proxy. However, while
> http.proxy (by the means of curl's CURLOPT_PROXY option) overrides the
> proxy for both HTTP and HTTPS protocols, the http_proxy environment
> variable is used only for HTTP. But since the docs mention only
> http_proxy, a user might expect it to apply to all HTTP-like protocols.

Hmm, I didn't know that. This certainly adds an interesting twist to the
patch in a nearby thread to start reading http_proxy ourselves.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index abeb82b..7d197bb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1258,9 +1258,10 @@ help.autocorrect::
>  	This is the default.
>  
>  http.proxy::
> -	Override the HTTP proxy, normally configured using the 'http_proxy'
> -	environment variable (see linkgit:curl[1]).  This can be overridden
> -	on a per-remote basis; see remote.<name>.proxy
> +	Override the HTTP proxy, normally configured using the 'http_proxy',
> +	'https_proxy', and 'all_proxy' environment variables (see
> +	linkgit:curl[1]).  This can be overridden on a per-remote basis; see
> +	remote.<name>.proxy

Text looks OK. I think this linkgit:curl is wrong, though. In the
manpages, it formats as simply curl(1), but in the HTML pages, it
creates a link to curl.html, which does not exist. This is not a problem
introduced by your patch, obviously, but maybe it is worth cleaning up.
I think just using:

  `curl(1)`

might be sufficient.

-Peff
