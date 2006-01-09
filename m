From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 15:07:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 00:09:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew68t-00058F-7E
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWAIXJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAIXJb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:09:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbWAIXJa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 18:09:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k09N7lDZ001929
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Jan 2006 15:07:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k09N7jGq028120;
	Mon, 9 Jan 2006 15:07:45 -0800
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14384>



On Mon, 9 Jan 2006, Luben Tuikov wrote:
> 
> Yes.  Ever since I started used git, I never used branch
> switching, but I do have git branches and I do use git branching.
> 
> I basically have a branch per directory, whereby the object db
> is shared as is remotes/refs/etc, HEAD and index are not shared
> of course.
> 
> This allows me to do a simple and fast "cd" to change/go to a
> different branch, since they are in different directories.
> So the time I wait to switch branches is the time the filesystem
> takes to do a "cd".
> 
> This also allows me to build/test/patch/work on branches
> simultaneously.

Yes. It has many advantages, and it's the approach I pushed pretty hard 
originally, but the "many branches in the same tree" approach seems to 
have become the more common one. Using many branches in the same tree is 
definitely the better approach for _distribution_, but that doesn't 
necessarily mean that it's the better one for development.

For example, you can have a git distribution tree with 20 different 
branches on kernel.org, but do development in 20 different trees with just 
one branch active - and when you do a "git push" to push out your branch 
in your development tree, it just updates that one branch on the 
distribution site.

So git certainly supports that kind of behaviour, but nobody I know 
actually does it that way (not even me, but since I tend to just merge 
other peoples code, I don't actually have multiple branches: I create 
temporary branches for one-off things, but don't maintain them that way).

			Linus
