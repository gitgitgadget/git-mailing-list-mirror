From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Fri, 28 Oct 2005 14:58:37 +1000
Message-ID: <20051028045837.GA1167@gondor.apana.org.au>
References: <E1EVKmt-0003xn-00@gondolin.me.apana.org.au> <4361A5BB.5040100@zytor.com> <20051028043211.GA781@gondor.apana.org.au> <4361AA56.2090906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, smurf@smurf.noris.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 07:03:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVMLB-00022d-8i
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 06:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVJ1E7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 00:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVJ1E7l
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 00:59:41 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:31242 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965096AbVJ1E7k
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 00:59:40 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.36 #1 (Debian))
	id 1EVMK7-0000gh-00; Fri, 28 Oct 2005 14:58:39 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1EVMK5-0000JA-00; Fri, 28 Oct 2005 14:58:37 +1000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4361AA56.2090906@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10759>

On Thu, Oct 27, 2005 at 09:34:30PM -0700, H. Peter Anvin wrote:
>
> >Perhaps you could use dash for your project as well?
> 
> Depends on how big it is.

I just noticed that you were building it with -Os.  So I built
dash with -Os and this is what I get:

$ size dash
   text    data     bss     dec     hex filename
  64397     884   10240   75521   12701 dash
$ size klibc-1.1.1/ash/sh.shared
   text    data     bss     dec     hex filename
  66237     424   70908  137569   21961 klibc-1.1.1/ash/sh.shared

So it looks like as long as dash can link with klibc then:

1) It should be smaller in size.
2) It should be more stable due to much wider testing coverage (Debian).
3) You get some extra bells & whistles thrown in for free like printf.

I'll let you know when I have a version that links with klibc.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
