From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] git-parse-remote: fix ambiguous shell bug in expand_refs_wildcard
Date: Mon, 7 May 2007 18:01:17 +1000
Message-ID: <20070507080117.GA5302@gondor.apana.org.au>
References: <20061218080941.GA3857@coredump.intra.peff.net> <7v4prtx9hu.fsf@assigned-by-dhcp.cox.net> <20061218224505.GB13034@coredump.intra.peff.net> <20061219003557.GA17799@gondor.apana.org.au> <20070505080313.GA12170@gondor.apana.org.au> <20070507063621.GB31445@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 07 10:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkyAF-0007hU-2a
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbXEGIBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXEGIBk
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:01:40 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:2323 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753631AbXEGIBj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:01:39 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1Hky9w-0005W3-Ow; Mon, 07 May 2007 18:01:28 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1Hky9l-0001Nn-00; Mon, 07 May 2007 18:01:17 +1000
Content-Disposition: inline
In-Reply-To: <20070507063621.GB31445@coredump.intra.peff.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46427>

On Mon, May 07, 2007 at 02:36:22AM -0400, Jeff King wrote:
>
> It looks like bash is actually broken in POSIXLY_CORRECT mode, then:
> 
> $ echo $BASH_VERSION
> 3.1.17(1)-release
> $ POSIXLY_CORRECT=1
> $ foo=bar}
> $ echo "${foo%'}'}"
> bar
> 
> My interpretation of the correct behavior is that it should remove a
> single quote from the end of foo, and then print '} literally (that is,
> single quote and brace).

Well strictly speaking this is allowed by the standard as this usage
contains an odd number of single quotes inside an ${...} expression
enclosed by double quotes, which behaves in an implementation-specific
manner.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
