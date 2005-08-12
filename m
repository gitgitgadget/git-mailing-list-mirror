From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Fri, 12 Aug 2005 15:27:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508121513530.3295@g5.osdl.org>
References: <20050812190739.AC222352633@atlas.denx.de>
 <Pine.LNX.4.63.0508121634570.12816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:29:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3i0f-000779-VV
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 00:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVHLW2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 18:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVHLW2L
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 18:28:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932113AbVHLW2K (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 18:28:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7CMRujA015584
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 15:27:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7CMRqCW015366;
	Fri, 12 Aug 2005 15:27:54 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508121634570.12816@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 12 Aug 2005, Daniel Barkalow wrote:
> 
> The git architecture makes the central server less important, and it's 
> easy to run your own.

On the other hand:

 - the git architecture is admirably suited to an _untrusted_ central
   server, ie exactly the SourceForge kind of setup. I realize that the 
   people at SourceForge probably think they are trustworthy, but in the 
   big picture, even SF probably would prefer people to see them as a
   _distribution_ point, not the final authority.

   IOW, with git (unlike, for example CVS), you can have a useful 
   distribution point that is _not_ one that the developers have to 
   control or even necessarily want to control. Which is exactly the
   kind of setup that would match what SF does.

   So with git, developers don't have to trust SF, and if SF is down or 
   something bad happens (disk crash, bad backups, whatever), you didn't 
   "lose" anything - the real development wasn't being done at SF anyway, 
   it was a way to _connect_ the people who do real development.

 - Every developer wants to have their own history and complete source
   control, but very few developers actually have good distribution 
   resources. "kernel.org" works for a few projects, and might be fine to
   expand a bit past what it does now, but kernel.org doesn't eevn try to
   do (nor _want_ to do, I bet) the kinds of things that SF does.

   Yes, developers can just merge with each other directly, and git allows 
   that, but it's actually not very convenient - not because of git
   itself, but because of just doing the maintenance. For example, I don't 
   allow incoming traffic to my machines, and I feel _much_ better that
   way. No MIS, no maintenance, and much fewer security issues.

   This is _exactly_ where something like SF really ends up being helpful. 
   It's a _hosting_ service, and git is eminently suitable to being 
   hosted, exactly because of its distributed approach. It needs very few 
   hosting services: you could make do with a very very limited shell 
   access, and in fact I tried to design the "git push" protocol so that 
   you could give people ssh "shell" access, where the "shell" was not a 
   real shell at all, but something that literally just implemented four
   or five commands ("git-receive-pack" and some admin commands to do 
   things like creation/removal of whole archives etc).

> Also, kernel.org is providing space to a set of people with a large
> overlap with git users, since git hasn't been particularly publicized
> and kernel.org is hosting git.

kernel.org certainly works well enough for the few projects that use it, 
but I don't think it's going to expand all that much. 

And it's possible that git usage won't expand all that much either. But
quite frankly, I think git is a lot better than CVS (or even SVN) by now,
and I wouldn't be surprised if it started getting some use outside of the
git-only and kernel projects once people start getting more used to it. 
And so I'd be thrilled to have some site like SF support it.

bkbits.net used to do that for BK projects, and there were a _lot_ of 
projects that used it. 

		Linus
