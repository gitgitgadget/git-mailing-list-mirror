From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 10:56:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291051460.18901@ppc970.osdl.org>
References: <200504291734.KAA25263@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mpm@selenic.com, seanlkml@sympatico.ca,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:49:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRZc3-0005Ec-6k
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 19:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVD2Ryt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVD2Ryt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 13:54:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:52179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262859AbVD2Ryj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 13:54:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3THsVs4023024
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 10:54:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3THsUKh026873;
	Fri, 29 Apr 2005 10:54:31 -0700
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504291734.KAA25263@emf.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Tom Lord wrote:
>
> 	1) the ancestry of their modified tree
> 
> 	2) the complete contents of their modified tree
> 
> 	3) input data for a patching program (let's call it "PATCH")
> 	   which, at the very least, satisfies the equation:
> 
> 		MOD_TREE = PATCH (this_diff, ORIG_TREE)
> 
> On the other hand, signing documents which represent a {(1),(3)} pair
> with robust accuracy is, in most cases, much much less expensive than
> signing {(1),(2)} pairs with robust accuracy. 

Not so.

It may be less expensive in your world, but that's the whole point of git: 
it's _not_ less expensive in the git world. 

In the git world, 1 and 2 aren't even separate things. They go together. 
And you just sign it. End of story. It's so cheap to sign that it's not 
even funny.

More importantly, signing 3 is meaningless. 3 only makes sense with a 
known starting point. You should never sign a patch without also saying 
what you're patching. 

And once you do that, 1+2 and 1+3 are _exactly_ the same thing.

And since git always works on the 1+2 level, it would be inexcusably
stupid to sign anything but that. 3 doesn't even exist per se, although 
it's obviously fully defined by 1+2.

So I don't see your point. You complain about git signing, but you 
complain on grounds that do not _exist_ in git, and then your alternative 
(1+3) which is senseless in a git world doesn't actually end up being 
anything really different - just more expensive.

		Linus
