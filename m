From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 15:23:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071520220.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <m1vf3muwxw.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 00:30:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqerz-0006jw-8G
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 00:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVGGW04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 18:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGGWYe
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 18:24:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbVGGWXX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 18:23:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67MNCjA017620
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 15:23:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67MNBaa029464;
	Thu, 7 Jul 2005 15:23:11 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1vf3muwxw.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Eric W. Biederman wrote:
>
> For optimizing network bandwidth that sounds like the way to go.  For
> adhoc development I don't know.  For a central sever you still need
> an authenticated way to push content, which makes it another dimension
> of the problem.

I'm convinced that "ssh" is the only sane way for pushing. If you don't 
trust somebody enough to give him ssh access, you shouldn't trust him with 
write access to your project in the first place.

git can actually do ssh with a _very_ restricted shell, if people are 
worried about shell access. In fact, the _only_ think the shell needs to 
be able to do is execute one of two programs, so you could have something 
_really_ trivial in your /etc/passwd as the login shell that doesn't allow 
anything else. But you'd still use ssh as the authentication protocol.

So I don't worry about pushing. I think we've got that covered. It's 
really the anonymous pulling that needs something.

		Linus
