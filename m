From: Linus Torvalds <torvalds@osdl.org>
Subject: Ugly merge messages
Date: Sun, 18 Sep 2005 17:05:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181649390.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Sep 19 02:06:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH9A0-0008So-3Y
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 02:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVISAFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 20:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVISAFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 20:05:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932279AbVISAFY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 20:05:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8J05KBo027642
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 17:05:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8J05IrX003660;
	Sun, 18 Sep 2005 17:05:19 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8822>


Junio,
 your merge messages are pretty ugly.

You often merge from a local branch in the current tree, which is fine, 
but it generates a message like

	Octopus merge of the following:

	refs/heads/pu from .
	branch 'nuker' of .
	branch 'merge' of .

which just looks wrong. At least to me, the dot looks more like a 
end-of-incomplete-sentence than a source of data.

Also, the "first" branch is really special, since that's the branch you're 
merging _into_. 

Wouldn't it look a lot nicer if this read as

	Octopus merge of the following:

	branch 'nuker'
	branch 'merge'
	into branch 'pu'

or something?

But that still has the problem that the single-line description (ie gitk,
shortlog etc) is totally useless. So maybe we shouldn't care about the
destination branch (we don't do that for normal merges), and just aim for
something like

	Octopus merge of branches 'nuker', 'merge'

instead?

Hmm? At least for the kernel, the shortlog really is pretty important, 
because the full log is often so big that it's easy to miss things in it.

		Linus
