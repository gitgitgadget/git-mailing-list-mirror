From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix archive-destroying "git repack -a -d" bug
Date: Sun, 18 Sep 2005 10:00:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509180958310.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509171839590.26803@g5.osdl.org>
 <20050918031837.GB23405@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Sep 18 19:02:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH2X4-0005ga-Jc
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVIRRAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVIRRAs
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:00:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751247AbVIRRAr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 13:00:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IH0UBo004654
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 10:00:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IH0Suu021792;
	Sun, 18 Sep 2005 10:00:29 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050918031837.GB23405@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8787>



On Sat, 17 Sep 2005, Dave Jones wrote:
> 
> Hmm, I'm sure I've done this several times in my x86info git repo
> (http://www.codemonkey.org.uk/projects/x86info/x86info.git)
> 
> It seems to look ok to git-fsck-cache though. Would that pick up
> any breakage if present ?

It will literally remove every single object in the system, so yes, there 
would be major breakage. Even "git log" won't work.

Note: this only happens if you haven't done _anything_ in between repacks. 
If you commit anything or do anything else to cause the list of objects to 
change, "git repack" is fine.

			Linus
