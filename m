From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 1 Oct 2006 12:56:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610011255030.3952@g5.osdl.org>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org> <7vlknz27qm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 21:57:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU7Qi-0006X6-FF
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWJAT4e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWJAT4e
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:56:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbWJAT4d (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 15:56:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k91JuTaX027244
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 Oct 2006 12:56:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k91JuSdi028691;
	Sun, 1 Oct 2006 12:56:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlknz27qm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28196>



On Sun, 1 Oct 2006, Junio C Hamano wrote:
> 
> Everybody hated the perl crud, so we removed Git.xs and is not
> even part of the source anymore.
> 
> This is a symptom that Git.c leftover from an earlier build was
> in the working tree.  Could you try running "rm -f perl/Git.c"
> before building and see if it helps?

Nope.

Then I just get

	make[1]: Entering directory `/home/torvalds/git/perl'
	Running Mkbootstrap for Git ()
	chmod 644 Git.bs
	rm -f blib/arch/auto/Git/Git.so
	gcc  -shared -L/usr/local/lib Git.o  -o blib/arch/auto/Git/Git.so       \
	        \
	  
	gcc: Git.o: No such file or directory
	gcc: no input files

instead.

If that file isn't even supposed to _exist_, then why do we have build 
rules etc crap to do all this? It sounds like the makefiles are broken.

		Linus
