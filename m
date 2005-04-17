From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 15:35:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org>
References: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mingo@elte.hu, pasky@ucw.cz, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:30:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNIHX-0001w2-Ny
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVDQWeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVDQWeN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:34:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:6826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261528AbVDQWeI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 18:34:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HMXKs4024459
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 15:33:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HMXIxk011345;
	Sun, 17 Apr 2005 15:33:19 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Herbert Xu wrote:
> 
> Sorry, it has already been shown that combining two difference hashes
> doesn't necessarily provide the security that you would hope.

Sorry, that's not true.

Quite the reverse. Again, you bring up totally theoretical arguments. In 
_practice_ it has indeed been shown that using two hashes _does_ catch 
hash colissions.

The trivial example is using md5 sums with a length. The "length" is a 
rally bad "hash" of the file contents too. And the fact is, that simple 
combination of hashes has proven to be more resistant to attack than the 
hash itself. It clearly _does_ make a difference in practice.

So _please_, can we drop the obviously bogus "in theory" arguments. They 
do not matter. What matters is practice.

And the fact is, in _theory_ we don't know if somebody may be trivially
able to break any particular hash. But in practice we do know that it's
less likely that you can break a combination of two totally unrelated
hashes than you break one particular one.

NOTE! I'm not actually arguing that we should do that. I'm actually
arguing totally the reverse: I'm arguing that there is a fine line between
being "very very careful" and being "crazy to the point of being
incompetent".

		Linus
