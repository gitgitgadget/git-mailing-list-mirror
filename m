From: Steven Grimm <koreth@midwinter.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 18:24:09 -0700
Message-ID: <4626C4B9.1040707@midwinter.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com> <200704181426.29969.andyparkins@gmail.com> <462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 03:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeLNs-0004EO-FM
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 03:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031032AbXDSBYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 21:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031050AbXDSBYE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 21:24:04 -0400
Received: from tater.midwinter.com ([216.32.86.90]:52412 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031032AbXDSBYD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 21:24:03 -0400
Received: (qmail 5018 invoked from network); 19 Apr 2007 01:24:01 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.133?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 19 Apr 2007 01:24:01 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <f06d4m$3rs$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44973>

Jakub Narebski wrote:
> In my opinion the update-then-commit workflow CVS and SVN forces on users
> is one of the more annoying features, forcing the user to resolve conflicts
> if he/she wants to be up-to-date.
>   

I'm not eager to jump to svn's defense -- there's a reason I'm using git 
and trying to get my coworkers to do the same -- but how does git allow 
you to stay up to date without resolving conflicts? Granted that git is 
smarter about resolving certain kinds of conflicts automatically, but 
fundamentally if the latest revision you've pulled down (from any kind 
of version control system) makes a change that conflicts with a local 
change (whether or not you've committed it locally first) you're going 
to have to resolve it by hand, yes?

Also, last I checked, git wouldn't let me push into a branch that had 
revisions I hadn't yet pulled down. Isn't that just another way of 
enforcing an update-then-commit workflow? If anything, svn wins in that 
area -- it allows me to commit without updating as long as my change 
doesn't touch any files that have changed upstream.

One can argue about whether allowing partial commits like that is a good 
idea, but it's just not true that svn forces you to always update before 
you commit, and if you're pushing into a branch that other people are 
also updating, the ability to commit files that didn't change upstream 
means it is actually *less* insistent on update-then-commit than git is 
(if you take "commit" to mean "commit-and-push" on the git side as was 
suggested in the message I replied to originally.)

Unless, of course, I'm misinterpreting you here.

> The update-then-commit assumes that you merge on update local modifications
> with current server version, assuming that ancestor is current local
> committed version. This makes off-line committing impossible, and makes
> rare updates (server version advanced by more than one commit) unnecessary
> hard.

That last point is completely counter to my experience. At my company 
(where the svn repository is still the official code base) the 
repository is constantly changing. I'll sometimes let hundreds or even 
thousands of revisions go by between updates of my svn client. When I'm 
at a good point to do integration testing and I'm using an svn client 
instead of a git-svn one, I type "svn up", do roughly the same manual 
conflict resolution I'd do after a "git pull" that brought down a 
similar number of new revisions -- often none at all if I'm the only one 
working on a particular corner of the code base -- and I'm good to go. 
What's unnecessarily hard about that? How would it be any better in git?

Local commit capability is absolutely a huge win in git, though, and is 
one of the main features I use to sell people on it internally. No 
argument there. I just don't like being *forced* to do a local commit 
when I have no reason to do so other than to satisfy the version control 
tool. I end up either cluttering my history with dummy revisions or 
having to type extra commands to get rid of them.

And in particular -- this being the original topic of the thread -- when 
an svn user sees me doing that, they do not immediately think of the 
fact that merging between immutable revisions may have some benefits. 
They see me typing four commands (commit, fetch, rebase, reset) to do 
the same thing they can do in one command with svn, and conclude that 
git is harder to use. That some of them choose to use it anyway is a 
testament to how great git is in other areas.

-Steve
