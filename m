From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Dumb servers (was: [ANNOUNCE] Cogito-0.12)
Date: Thu, 7 Jul 2005 19:27:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071918230.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <m1vf3muwxw.fsf@ebiederm.dsl.xmission.com>
 <42CDDCF0.9020906@qualitycode.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 04:28:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqiao-0004xP-Mj
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 04:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVGHC1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 22:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVGHC1t
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 22:27:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261427AbVGHC1n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 22:27:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j682RYjA003771
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 19:27:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j682RXXr008664;
	Thu, 7 Jul 2005 19:27:34 -0700
To: Kevin Smith <yarcs@qualitycode.com>
In-Reply-To: <42CDDCF0.9020906@qualitycode.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Kevin Smith wrote:
> 
> Absolutely. For the kernel it might not make sense, but I view it as a 
> really important feature for tiny projects around the world. Even a CGI 
> requirement makes it impossible to serve a project from free or really 
> cheap web hosts. Plain HTTP is the only protocol available to people who 
> have no extra money to spend on hosting accounts.

Well, the http approach always works as well as an "rsync", ie you can 
always replace "rsync" with "wget -r -c" or similar.

But the end result will be a purely dumb mirror of what the other side 
had, ie it will have all the same problems rsync has with things like 
multiple branches etc (it will get all of them, not just the objects 
needed from the one branch you're trying to pull).

So it's not pretty. But it obviously does work: pack-files haven't changed
the fact that git is a append-only thing that lives entirely in the
filesystem space and doesn't have any "dynamic content" (ie nothing is 
hidden inside server state).

		Linus
