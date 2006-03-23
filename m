From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Who do I report bugs in the git source web browser thing to?
Date: Thu, 23 Mar 2006 09:03:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603230856250.26286@g5.osdl.org>
References: <200603231143.17762.rob@landley.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 18:05:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMTED-0007on-QI
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 18:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWCWRDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 12:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbWCWRDd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 12:03:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932671AbWCWRDc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 12:03:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2NH3QDZ003558
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Mar 2006 09:03:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2NH3PcA000756;
	Thu, 23 Mar 2006 09:03:25 -0800
To: Rob Landley <rob@landley.net>
In-Reply-To: <200603231143.17762.rob@landley.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17863>



On Thu, 23 Mar 2006, Rob Landley wrote:
>
> When I go to kernel.org, click the tiny C next to linus's name to get the git 
> browser for the tree, click "tree", click the "usr" directory, and then click 
> "history" next to the file gen_init_cpio.c, it says this file appeared out of 
> thin air 59 minutes ago.

It does?

For me, it says that the file has no history at all. Which is true. It 
hasn't been changed since it was imported, and normally git doesn't show 
the root commit at all (exactly because it's the "import" commit). 

Now, gitweb _could_ use the "--root" flag to git-diff-tree to also show 
the root commit as a diff against nothingness, and then each file would 
always have at least _one_ history entry, but if you want that, you might 
as well just click the "blob" button instead, that shows what the file is.

The one commit you see (the "[PATCH] reduce size of bio mempools" thing in 
the header at the thing) is _not_ part of the file history: it's your 
starting point for history searching. In other words, it's the top commit 
that you do your history _off_.

Pick another file, like the Makefile, to see what real history looks like 
(or, better yet, go into a different directory that actually sees more 
real work, like kernel/, and look at the history of files there).

			Linus
