From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 15:13:52 -0400
Message-ID: <490A0770.5060600@xiplink.com>
References: <18696.32778.842933.486171@lisa.zopyra.com>	<1225343538.10803.9.camel@maia.lan>	<18697.41702.241183.408377@lisa.zopyra.com>	<18697.42140.459170.891195@lisa.zopyra.com>	<4909A7C4.30507@op5.se>	<2008-10-30-14-52-52+trackit+sam@rfc1149.net>	<4909BF58.9010500@op5.se>	<2008-10-30-15-23-16+trackit+sam@rfc1149.net>	<4909CABD.1040708@op5.se>	<2008-10-30-16-04-08+trackit+sam@rfc1149.net>	<4909D1FE.2080403@op5.se> <18697.54743.601331.133842@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Samuel Tardieu <sam@rfc1149.net>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 20:14:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvcyV-0003lH-LX
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 20:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbYJ3TNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 15:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYJ3TNM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 15:13:12 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:50790 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYJ3TNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 15:13:11 -0400
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id 5F39744E396;
	Thu, 30 Oct 2008 15:13:10 -0400 (EDT)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 29F9044CC65;
	Thu, 30 Oct 2008 15:13:10 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <18697.54743.601331.133842@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99521>

Bill Lear wrote:
> 
> the reason being that every manual our users read says "use git push",
> use "git pull", the examples being written for 'master' branch usage,
> and people just assume that 'git push'/'git pull' are smart enough to
> know which branch you are on and do the same logical thing as a bare
> 'git push'/'git pull' does when on master.

I agree that this is a 'gotcha' for git-push.  I'm a new git user, and 
I've been experimenting with git and reading the documentation for the 
last few weeks.  But I would not have known about this behavior if it 
weren't for this thread.

Yes, push's man page is clear about what happens if you push with no 
refspec, and the fetch & pull man pages both have an obscure note to 
"never do your own development on branches that appear
on the right hand side of a <refspec> colon on 'Pull:' lines".  But 
still the behavior is not what I expected.  Before I read this thread, I 
missed the implications of what those parts of the man pages were saying.

One could call this a failure of the documentation (man pages and 
beyond).  Personally, though, I tend to expect minimal commands to do 
minimal things.  So a plain "git push" would do the minimum amount of 
pushing, and if I want it to do more I'd add extra parameters to the 
command.

The current behavior seems fairly harmless if you always follow the 
pattern of creating topic branches for all your work.  But git (rightly) 
doesn't enforce that pattern, and so I think push shouldn't default to 
doing something potentially harmful just because you forgot to create a 
topic branch one day.  (Or maybe you decided to be clever and give one 
of your local branches the same name as a remote's branch...)

		Marc
