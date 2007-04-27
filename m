From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 27 Apr 2007 11:12:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704271110330.9964@woody.linux-foundation.org>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net> <200704271019.56341.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704271002310.9964@woody.linux-foundation.org>
 <200704271903.33263.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 20:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhUxE-0000vY-FX
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 20:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990AbXD0SNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 14:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756995AbXD0SNg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 14:13:36 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:47145 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756987AbXD0SNf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 14:13:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3RICphw012785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2007 11:12:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3RICo4s004193;
	Fri, 27 Apr 2007 11:12:50 -0700
In-Reply-To: <200704271903.33263.andyparkins@gmail.com>
X-Spam-Status: No, hits=-3.008 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45742>



On Fri, 27 Apr 2007, Andy Parkins wrote:
> 
> I was actually surprised how little I'm finding I need submodule support 
> in the porcelain.  The only slight problem at the moment is with 
> git-checkout; switching from a branch with the supermodule to a branch 
> without it and back needs a bit of hoop jumping, but nothing too 
> painful.  All in all - success all over.

Heh, good to hear, but I suspect your habits may differ from other 
peoples...

I agree that "git checkout" needs to have that .gitmodules thing. It 
should actually be fairly straightforward, although there are subtle 
issues (ie right now we can *atomically* say "cannot check out, it's 
dirty" - what happens when you've already checked out five subprojects, 
and the sixth one is dirty?).

"git diff --subprojects" is likely also something people will want, and 
that should be _reasonably_ straigtforward.

"git merge" is the big one. 

		Linus
