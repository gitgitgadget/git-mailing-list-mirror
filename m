From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Tue, 24 Mar 2009 23:19:47 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242304530.19665@iabervon.org>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>  <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>  <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>  <alpine.LNX.1.00.0903241304090.19665@iabervon.org> 
 <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>  <alpine.LNX.1.00.0903242118270.19665@iabervon.org> <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Irene Ros <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJgt-00015w-EU
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbZCYDTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbZCYDTu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:19:50 -0400
Received: from iabervon.org ([66.92.72.58]:51031 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbZCYDTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:19:50 -0400
Received: (qmail 12443 invoked by uid 1000); 25 Mar 2009 03:19:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 03:19:47 -0000
In-Reply-To: <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114551>

On Tue, 24 Mar 2009, Irene Ros wrote:

> Hi All,
> 
> Thank you for the good advice. I may be the case I am somehow misusing
> git... I couldn't resolve the issue and so I created a new project off
> of the same repo. Switching to the same branch in question yielded an
> even stranger result: In this new project, the commits were there (I
> could see them in git log and in git log origin/myBranch) whereas in
> the previous older project I did not... does that make sense? Our
> origin branches are located on a central server so can't quite figure
> out why viewing the log of the same remote branch from two different
> projects would yield different results. Any suggestions? At this
> point, I'm just really curious.

origin/* is a copy of what git saw the last time it talked to the remote 
repository. This may be different from what the remote repository now 
contains. (Also, there are a few cases in which pushing to a remote 
repository doesn't count as talking to it; fetching with a configured 
remote always counts.) The local copies are handy for being able to 
compare the work you've done locally with what is in the remote repository 
when you don't necessarily have a network connection, don't expect 
constant updates remotely, or don't want to be distracted by remote 
changes. For example, you might have your local work, and you might want 
to compare it with what other people have done. You want to avoid having 
additional changes that other people make while you're making this 
comparison show up in the middle.

Of course, when you make a new clone of the same repository, this clone 
will look at the repository when you make the clone, and will have the 
latest information (as of that time). 

In order to get an existing repository to see changes to a remote 
repository, use "git fetch <remote>" (you can leave off the <remote> to 
get the oone you gave to "clone", which is configured as "origin"). 
Alternatively, you can use "git pull" to get the data and also merge it in 
the same command, which may or may not be a useful addition depending on 
your workflow.

	-Daniel
*This .sig left intentionally blank*
