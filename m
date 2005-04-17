From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 09:29:05 +1000
Message-ID: <20050417232905.GA2721@gondor.apana.org.au>
References: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, pasky@ucw.cz, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:27:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJAP-0005sX-5X
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVDQXal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVDQXal
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:30:41 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6924 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261552AbVDQXaV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:30:21 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DNJCn-0007WL-00; Mon, 18 Apr 2005 09:29:33 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DNJCL-0000iL-00; Mon, 18 Apr 2005 09:29:05 +1000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 03:35:17PM -0700, Linus Torvalds wrote:
> 
> Quite the reverse. Again, you bring up totally theoretical arguments. In 
> _practice_ it has indeed been shown that using two hashes _does_ catch 
> hash colissions.
> 
> The trivial example is using md5 sums with a length. The "length" is a 
> rally bad "hash" of the file contents too. And the fact is, that simple 
> combination of hashes has proven to be more resistant to attack than the 
> hash itself. It clearly _does_ make a difference in practice.

I wasn't disputing that of course.  However, the same effect can be
achieved in using a single hash with a bigger length, e.g., sha256
or sha512.

> So _please_, can we drop the obviously bogus "in theory" arguments. They 
> do not matter. What matters is practice.

I agree.  However, what is the actual cost in practice of detecting
collisions?

I get the feeling that it isn't that bad.  For example, if we did it
at the points where the blobs actually entered the tree, then the cost
is always proportional to the change size (the number of new blobs).

Is this really that bad considering that the average blob isn't very
big?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
