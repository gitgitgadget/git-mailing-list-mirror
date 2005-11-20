From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Diffs "from" working directory
Date: Sun, 20 Nov 2005 10:13:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>
References: <200511201817.15780.blaisorblade@yahoo.it> <20051120174359.GA24177@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Blaisorblade <blaisorblade@yahoo.it>, Chuck Lever <cel@netapp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 19:14:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdthE-0006JX-GQ
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 19:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKTSNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 13:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVKTSNp
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 13:13:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbVKTSNo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 13:13:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAKIDXnO009409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 20 Nov 2005 10:13:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAKIDWkE011549;
	Sun, 20 Nov 2005 10:13:32 -0800
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20051120174359.GA24177@fieldses.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12391>



On Sun, 20 Nov 2005, J. Bruce Fields wrote:
> 
> That's a diff *to* the working directory.  My complaint was that there
> wasn't a convenient way to get a diff *from* the working directory.

Something like

	git diff -R -M -p

should do it, no?

("git diff" has the strange property that if you give it any diff flags at 
all, it forgets all the default ones. So it defaults to "-M -p", but if 
you just say "-R", it will drop its own defaults, and use _just_ "-R").

[ Which is almost certainly not what most users want, but it's practical 
  when you want to get the internal git format. Whether that is important 
  enough to confuse users or not, I dunno ]

		Linus
