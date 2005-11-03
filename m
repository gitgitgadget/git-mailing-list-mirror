From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: binary safe?
Date: Thu, 3 Nov 2005 14:50:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511031447020.27915@g5.osdl.org>
References: <86br115r0z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 23:52:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnue-0006jc-3M
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVKCWuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVKCWuZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:50:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932610AbVKCWuY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 17:50:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA3MoMnO018664
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Nov 2005 14:50:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA3MoLWP006866;
	Thu, 3 Nov 2005 14:50:21 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86br115r0z.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11106>



On Thu, 3 Nov 2005, Randal L. Schwartz wrote:
> 
> I'm currently about to abandon CVS for my website management,
> replacing it with git.
> 
> What problems, if any, will I have using git to manage the binary
> files for my site, like the custom icons?  CVS is doing that just fine
> now.

Git doesn't have any textual representations anywhere.

So the _only_ problem should be "git diff" (and related patch-based tools 
- git-apply etc). They'll simply not work. For similar reasons, a 
three-way merge will obviously fail.

> I presume emailing diff-patches is out of the question, but if all I'm
> doing is git-push and git-pull (using the shared central repository
> model), and if I'm stupid enough to have a merge error it's OK to just
> blow up on a binary file, will everything else work fine?

Yes. I don't think it's been heavily tested, but the very architecture of 
git should mean that there just shouldn't be any issues with binary files 
outside of the obvious ones.

The only binary file the kernel ever uses is the logo.gif thing, so it's 
been "tested" in the sense that binary files exist, but there's never been 
any changes to that file, so..

		Linus
