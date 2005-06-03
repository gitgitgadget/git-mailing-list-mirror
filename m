From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 14:59:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506031727400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason McMullan <jason.mcmullan@timesys.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 23:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeK7b-0007wf-Dx
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 23:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVFCV5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 17:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFCV5m
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 17:57:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:14795 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261499AbVFCV5k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 17:57:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53LvYjA002761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 14:57:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53LvXrH016286;
	Fri, 3 Jun 2005 14:57:34 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506031727400.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, Daniel Barkalow wrote:
> 
> Is this somehow different from rpush/rpull aside from using an
> externally-provided socket and having the proper locking for writing refs
> (which I posted a while ago, but which hasn't been included anywhere yet)?

Deathmatch! 

Anyway, I have to admit that at least as far as I'm concerned, the 
rpull/rpush thing has the same issues as Jason's code - I've not seen the 
usage documented anywhere, and that's the only real reason I don't use it 
myself.

Also, just out of interest, do either or both of these things pipeline the
transfer?

Me, I want to have a fairly simple script that does the equivalent of what
I do now for pushing:

	rsync -av --delete --exclude-from=.exclude .git/ master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

except I'd want it to do the locking and the "only accept trivial pushes" 
stuff (ie no merging, just a pure update).

Maybe git-rpush does this already, and I just never realized.

		Linus
