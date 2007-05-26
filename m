From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Sat, 26 May 2007 17:38:55 +1000
Message-ID: <20070526073855.GA6395@gondor.apana.org.au>
References: <465750FE.9000406@iii.hu> <20070526004028.GA8940@sigill.intra.peff.net> <20070526011036.GA4169@gondor.apana.org.au> <20070526034236.GA18169@coredump.intra.peff.net> <7vps4onps0.fsf@assigned-by-dhcp.cox.net> <20070526060748.GA20715@coredump.intra.peff.net> <20070526061942.GA5986@gondor.apana.org.au> <20070526062748.GA21229@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Szekeres Istvan <szekeres@iii.hu>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 26 09:39:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrqsT-00085X-1D
	for gcvg-git@gmane.org; Sat, 26 May 2007 09:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbXEZHjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 03:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXEZHjg
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 03:39:36 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:1578 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751033AbXEZHjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 03:39:36 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1Hrqrn-0000Mn-JR; Sat, 26 May 2007 17:39:11 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1HrqrX-0001fY-00; Sat, 26 May 2007 17:38:55 +1000
Content-Disposition: inline
In-Reply-To: <20070526062748.GA21229@coredump.intra.peff.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48456>

On Sat, May 26, 2007 at 02:27:48AM -0400, Jeff King wrote:
> 
> No, I meant would the shell, while interpolating a double-quoted string
> "\n", always preserve the string and pass the backslash and 'n' to
> printf?  Clearly \\ and \" get interpolated, but I don't know the rules
> for "unrecognized" backslash sequences.

Yep.  Section 2.2.3 says that the backslash within double quotes will
only serve as an escape character for $, `, ", \ and <newline>.  Of
course, you can always use a single quote instead, i.e.,

printf '%s\n' "$VAR"

Then there can be no doubt :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
