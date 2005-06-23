From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 21:54:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
 <07be01c577a7$05108660$03c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 06:47:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlJcN-00013R-W0
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 06:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVFWEwu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 00:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVFWEwt
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 00:52:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbVFWEw2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 00:52:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N4qIjA022938
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 21:52:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N4qHZS026535;
	Wed, 22 Jun 2005 21:52:17 -0700
To: Adam Kropelin <akropel1@rochester.rr.com>
In-Reply-To: <07be01c577a7$05108660$03c8a8c0@kroptech.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Adam Kropelin wrote:
> 
> I know I shouldn't invoke this particular acronym, but I rather like 
> CVS's approach.

The problem I have with "git commit" committing everything dirty by
default is that it encourages exactly the wrong kind of behaviour, ie the 
"commit it all in one go without thinking about it".

Also, CVS really doesn't have much choice, since CVS doesn't _have_ the 
notion of marking files for commits. In contrast, in git the index file 
really does end up beign a good way to say which files are ready to be 
committed.

And "git status" really isn't that hard to type, and it will tell you 
exactly what you've already marked for commit, and what you have dirty in 
the tree but isn't marked for commit yet.

So I think the "git commit <file-list>" thing is very convenient, but it's
convenient exactly because it's concise yet still precise and doesn't 
encourage the "just commit whatever random dirty state I have right now" 
mentality.

And if you have more than a few files dirty in your tree, I really think
it's much better to do "git status" and think about it a bit and select
the files you do want to commit than it is to just do "git commit" and let
it rip.

Now, I could well imagine adding an "--all" flag (and not even allow the 
shorthane version) to both git-update-cache and "git commit". So that you 
could say "commit all the dirty state", but you'd at least have to think 
about it before you did so.

		Linus
