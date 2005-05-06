From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I...
Date: Fri, 6 May 2005 10:09:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
References: <427B3DB3.4000507@tuxrocks.com> <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
 <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 19:01:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU6CB-0001pp-JK
	for gcvg-git@gmane.org; Fri, 06 May 2005 19:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVEFRH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 13:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFRH3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 13:07:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:40880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261208AbVEFRHW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 13:07:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46H7EU3006230
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 10:07:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46H7DSc019132;
	Fri, 6 May 2005 10:07:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Junio C Hamano wrote:
> 
> LT> Guys - whoever wrote one of the scripts, can you please send out your 
> LT> current version to the git list and cc me, and explain why yours is 
> LT> superior to the other peoples version. Please?
> 
> I think I mentioned and posted an interactive version called
> jit-trackdown.  It is part of JIT found at [*1*].  You may have
> an older version that does not have the command.

Actually, I spent some time just now to improve the interface to 
git-diff-tree, allowing it to take a list of trees to compare from stdin.

And if you only give it one entry on stdin, it assumes it is a commit,
and lists the tree difference between that and the parent(s). If it's a 
merge commit, it will ignore it unless you use "-m".

So now you can do

	git-rev-list HEAD --max-count=10 | git-diff-tree --stdin update-cache.c

to see which of the last 10 commits changed "update-cache.c".

And if you add the "-p" flag, it will show it as a diff too.

Damn, I'm good. It was just a few lines of code added to git-diff-tree.

		Linus
