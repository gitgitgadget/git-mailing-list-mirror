From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 18:47:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311845020.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com>
 <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com>
 <86hdaxf6wq.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510311822080.27915@g5.osdl.org>
 <86r7a1drji.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 03:52:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWmEO-0000ds-9p
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 03:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVKACuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 21:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVKACuc
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 21:50:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964946AbVKACuc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 21:50:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA12l9W6032740
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 18:47:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA12l7O8011348;
	Mon, 31 Oct 2005 18:47:08 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86r7a1drji.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10922>



On Mon, 31 Oct 2005, Randal L. Schwartz wrote:
> 
> Linus> Start a new branch before the sequence you want to clean
> Linus> up. Then, move the cleaned-up history to that branch, and
> Linus> eventually you can just delete the old one.
> 
> So if I toss something in git/refs, the objects pointed to by that are
> eventually reclaimed?  Do I need to git-fsck-objects to do that?  Or
> is there some cg command to do the whole thing?

You can do "git prune". It's pretty expensive, though, and the extra 
objects don't _hurt_, so there's no reason to do pruning very 
aggressively. I tend to prune immediately just because I run 
git-fsck-objects all the time, and if you don't prune, it will nag you 
about "dangling commit".

You may also decide to just rename the old broken branch. Keeping it 
around for local historical reasons and never push it out.

		Linus
