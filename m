From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 16:29:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181617010.15725@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>
 <20050417195742.D13233@flint.arm.linux.org.uk> <20050418231652.C16789@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:24:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfay-0006uu-Jt
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDRX2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDRX17
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:27:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:17855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261198AbVDRX1w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 19:27:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3INRks4009834
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 16:27:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3INRjwH011488;
	Mon, 18 Apr 2005 16:27:45 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050418231652.C16789@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Russell King wrote:
>
> Ok, since the last one was soo successful, and I'm up for more
> punishment, here's another attempt.  The diffstat is rather
> interesting in this one, claiming no changes.  It should look
> like this:
> 
>  arch/arm/lib/bitops.h |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+)
> 
> However, it seems that git diff can't handle new files appearing
> yet.

It should definitely be able to do that. 

Do a "git log | less" to look up the trees involved, and do a "git diff
<parent-tree> <child-tree>" to see the output. If you don't see your new
file, then either you have an old "git diff" that doesn't like the new
tools (and you need to add a "-z"  flag to diff-tree), or you didn't 
check in the new file successfully ;)

You can also always do "tree-diff -r old-tree new-tree" which will show
you the tree-level changes. That's the low-level plumbing stuff: it 
doesn't show you the actual file contents, just how the tree changed.

> The other interesting thing to note is that patches are generated
> for '-p0' rather than '-p1' application, which is contary to our
> historical requirements.  This is going to confuse people - can
> we make it generate -p1 patches please?

That should already be the case now after the latest diffs from Junio.

> Linus - assuming I un-messed-up my tree properly (it appears to
> be correct and fsck-cache $(commit-id) is happy) please merge
> this. 

Looks ok, which seems to mean that your scripts are buggered since they 
didn't pick up the new file.

Merge pushed out.

			Linus
