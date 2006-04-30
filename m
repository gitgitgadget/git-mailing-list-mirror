From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 17:30:22 -0400
Message-ID: <44552C6E.6090601@garzik.org>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org> <445516F5.1090204@garzik.org> <Pine.LNX.4.64.0604301303010.5231@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 30 23:30:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaJUu-0003mH-DH
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 23:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWD3Va2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 17:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWD3Va2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 17:30:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:22191 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750862AbWD3Va2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 17:30:28 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1FaJUl-00043S-Ps; Sun, 30 Apr 2006 21:30:24 +0000
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604301303010.5231@g5.osdl.org>
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19357>

Linus Torvalds wrote:
> If you want to push other branches, you need to do
> 
> 	git push repo branch1 branch2 branch3 ...
> 
> or
> 
> 	git push --all repo
> 
> where the latter does exactly what it says (use "--tags" instead of 
> "--all" to just send all tags).

After experimenting, "--all" does indeed provide most of the features 
that rsync provides.  A few minor niggles:

1) Doesn't propagate local branch deletions to the remote, like rsync does.

2) git-push "-f" doesn't seem to work, but "--force" does.

3) You still have to provide a $repo argument to 'git pull $repo'. 
Would like to list the default remote push URL in 
.git/remotes/{somefile} so that I need only to do "git push --all" to 
have changes send to any number of remote servers.

4) Propagation of alternatives is unclear (at least in docs).  Without 
my current pack file pre-sharing and hardlinking, I fear needlessly 
uploading vanilla linux-2.6.git changes back to kernel.org, when I do a 
push.  Currently, pack files are downloaded _once_ from kernel.org to 
local, and never re-uploaded.

Regards,

	Jeff
