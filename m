From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 19:48:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311943290.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> 
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> 
 <1138446030.9919.112.camel@evo.keithp.com>  <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
  <1138529385.9919.185.camel@evo.keithp.com>  <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home>  <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
  <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
 <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ray Lehtiniemi <rayl@mail.com>, Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 04:58:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F498W-0006M7-VR
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 04:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWBAD6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 22:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWBAD6I
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 22:58:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030223AbWBAD6H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 22:58:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k113mdDZ025435
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 19:48:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k113mbxa016986;
	Tue, 31 Jan 2006 19:48:38 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15382>



On Wed, 1 Feb 2006, Martin Langhoff wrote:
> 
> If you have such a tree, your workflow _must_ be such that you know
> exactly what files you have changed. Asking any tool to go out and
> "find which of my 20K files has changed" is doable, but it's just
> magic that it works on recent linuxes.

It's not magic, and it's not all that recent. Linux FS ops have always 
been pretty good, and the dentry cache was introduced in 2.0.x, I think, 
so you'd be hard-pressed to find a Linux system that doesn't have it.

Now, I bet Linux will be better (often by a factor of 2-3) than most other 
systems, but that still doesn't mean that 20k files is totally 
unreasonable on other setups. 

I suspect cygwin is worse than most because (a) the NT VFS layer is 
piss-poor and you need a kernel service to get good performance and (b) 
cygwin probably adds its own overhead for handling symlinks, so the 
"lstat()" call is probably even more expensive.

Now, the networked filesystems are a potential problem for everybody.

		Linus
