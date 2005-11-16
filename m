From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Wed, 16 Nov 2005 12:10:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511161208140.13959@g5.osdl.org>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com> 
 <7vveys8n8q.fsf@assigned-by-dhcp.cox.net> <46a038f90511161201h54c5fa73l20b5dcf3b5c19399@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Franck <vagabon.xyz@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:15:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTd7-0007R2-3V
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbVKPULP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVKPULP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:11:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030483AbVKPULN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 15:11:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAGKB2nO031269
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 16 Nov 2005 12:11:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAGKAvRk012425;
	Wed, 16 Nov 2005 12:10:59 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511161201h54c5fa73l20b5dcf3b5c19399@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12049>



On Thu, 17 Nov 2005, Martin Langhoff wrote:
>
> cg-clone already does this. One tricky thing with the selective
> cloning is that you want to pull the named head plus all its related
> objects, and then pull only the _relevant_ tags.

Well, if you keep to native git protocols, you can trivially do that by 
just fetching the required heads, and then fetching only the tags for 
which you have the pointed-to object (ie look for the ^{} thing in 
git-ls-remote, and check if you have that object, then get those tags).

For rsync, since you get all objects anyway, there's no point to limiting 
the branches. Might as well just delete them and prune them.

		Linus
