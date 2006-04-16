From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 10:07:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 19:07:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVAiZ-00053K-87
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 19:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDPRHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWDPRHU
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 13:07:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWDPRHT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 13:07:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3GH7FtH005577
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 10:07:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3GH7ErN010305;
	Sun, 16 Apr 2006 10:07:15 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18793>



On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> 
> But you missed my point. The file log-tree.c had some opt handling. I 
> changed it (as can be seen in my patch for combined diffstat), so the 
> merge did not go well with next, which removed that code.
> 
> So I tried to be clever and find the (non-merge) commit where this 
> happened. With what you describe, I should have hit *exactly one* commit 
> removing the code.
> 
> But I hit *exactly none* with "git log --cc master log-tree.c".

Do you have the tree somewhere?

In the current git tree, there really _is_ just one commit that touches 
log-tree.c in "master". And "git log log-tree.c" picks that out without 
trouble.

Did you mean to do

	git log --cc next log-tree.c

instead, perhaps? (Note the "next" branch specifier) That definitely shows 
three commits, including very much the one that moves the common option 
parsing to revision.c (do "git log --cc --full-diff next log-tree.c" if 
you want to see the whole diff whenever something touches log-tree.c).

Maybe I'm still missing something, but it seems to do the right thing 
for me..

		Linus
