From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/4] Writing refs in git-ssh-push
Date: Mon, 6 Jun 2005 20:17:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506062008560.2286@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 05:13:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfUVr-0000sx-6m
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 05:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVFGDPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 23:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVFGDPx
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 23:15:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:26599 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261764AbVFGDPj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 23:15:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j573FHjA011113
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Jun 2005 20:15:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j573FG9c001400;
	Mon, 6 Jun 2005 20:15:16 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Two comments on git-ssh-push from a quick try-to-use-it-but-fail..

 - hardcoding the name of the command on the other side kind of sucks. 
   Especially when the user may end up having to install his own version
   under his own subdirectory. You really want to have some way of saying 
   "execute /home/user/bin/git-ssh-pull", and since it will depend on the 
   site you're pushing to, it should probably be available as a cmd line 
   option.

   I have a

	PATH=$PATH:~/bin

   in my .bashrc, but sshd at the other end doesn't end up caring..

 - the host/path parsing is pretty simplistic and just silly. Nobody I 
   know uses that ssh://host/path format, people use the shorter host:path 
   format.

Both look pretty simple to fix, but now I'm going to put the kids to bed.

		Linus
