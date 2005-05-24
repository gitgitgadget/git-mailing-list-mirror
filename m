From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cogito - how do I ???
Date: Mon, 23 May 2005 20:05:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505232000400.2307@ppc970.osdl.org>
References: <E1DaP7k-0007ar-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sithglan@stud.uni-erlangen.de, seanlkml@sympatico.ca,
	sam@ravnborg.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 05:04:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaPhU-0005cL-FT
	for gcvg-git@gmane.org; Tue, 24 May 2005 05:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVEXDEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 23:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVEXDEK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 23:04:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:8126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261344AbVEXDEE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 23:04:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O33KjA011789
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 20:03:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O33I9n003721;
	Mon, 23 May 2005 20:03:19 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1DaP7k-0007ar-00@gondolin.me.apana.org.au>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Herbert Xu wrote:
> 
> Yes please.  Can we also have a rev-* command that outputs parent
> relations instead of a simple list? That is,
> 
> <tree-1> <parent-1>
> <tree-1> <parent-2>
> <tree-2> <parent-3>

That's not <tree-n>, it's <commit-n>.

I think that would be "git-rev-list --parents" or something - that 
wouldn't impact any existing users.

Patches welcome.

As to git-rev-tree, that's likely used by scripts in various places 
(cogito, gitk, gitweb etc), so changing that is nastier, but at least the 
output could be _sorted_ better.

Of course, I really think that the bigger problem with git-rev-tree
currently is that global reachability analysis, which is just not
acceptable performance-wise.

		Linus
