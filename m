From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Sat, 26 May 2007 11:10:36 +1000
Message-ID: <20070526011036.GA4169@gondor.apana.org.au>
References: <465750FE.9000406@iii.hu> <20070526004028.GA8940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Szekeres Istvan <szekeres@iii.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 26 03:10:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrko2-0004lg-FQ
	for gcvg-git@gmane.org; Sat, 26 May 2007 03:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbXEZBKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 21:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbXEZBKs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 21:10:48 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:4453 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753044AbXEZBKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 21:10:47 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1Hrknp-0007J2-Nc; Sat, 26 May 2007 11:10:41 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1Hrknk-00015c-00; Sat, 26 May 2007 11:10:36 +1000
Content-Disposition: inline
In-Reply-To: <20070526004028.GA8940@sigill.intra.peff.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48440>

On Fri, May 25, 2007 at 08:40:28PM -0400, Jeff King wrote:
> 
> Hmm. It even happens with this:
> 
> bash$ export test=$(echo foo \\n bar)
> bash$ dash
> dash$ echo $test
> foo
>  bar
> 
> I'm not sure what the best workaround is.  I am cc'ing Herbert Xu to see
> if he has any helpful comments.

If you need to echo something that may have escapes in it, the portable
way to do it is

printf '%s\n' "$test"

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
