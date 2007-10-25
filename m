From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 08:02:57 +0200
Message-ID: <79366145-3C91-4417-B62C-FFF9EC452076@zib.de>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>, Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 08:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkvqC-0001un-Nm
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 08:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXJYGE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 02:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbXJYGE5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 02:04:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:40471 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbXJYGE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 02:04:56 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9P61VSH007857;
	Thu, 25 Oct 2007 08:04:45 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1580b.pool.einsundeins.de [77.177.88.11])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9P61Tot014073
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Oct 2007 08:01:29 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710250021430.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62276>


On Oct 25, 2007, at 1:28 AM, Johannes Schindelin wrote:

> On Thu, 25 Oct 2007, Steffen Prohaska wrote:
>
>> On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:
>>
>>> But I think I have to drive my message home again: if what you  
>>> desire
>>> becomes reality, you take away the clear distinction between  
>>> local and
>>> remote branches.  In fact, those branches are neither local (because
>>> the next pull will automatically update them with remote changes,  
>>> but
>>> _only_ if they fast-forward) nor remote (because you plan to work on
>>> them locally).
>>
>> Exactly, because I do not work on those branches alone. These are
>> _shared_ branches. I can work on such a branch with a group of
>> developers. I'm willing to accept this bit of chaos.
>
> It is not just a chaos.  I see a serious problem here.  On _your_
> computer, you do _not_ have a shared branch.  Which is visible  
> _even_ in
> your modified work flow when you have unpushed changes.
>
> So your desired illusion that your local branches are anything but  
> local
> branches will never be perfect enough.

Ok, there is not a fundamental difference between local branches
that automatically merge from remotes and local branches that
are purely local and _never_ merge anything automatically. Both
are only local branches.

But these two types of branches already behave differently when
I call "git pull". There is already some kind of "illusion"
that some local branches are more tightly connected to remote
branches than others.

"git pull" could help to make the illusion even better. The
illusion would be better if it was easier to keep the heads
of the local branches near to the heads of branches they
automatically merge from, as long as this is easily possible.


>> Your rebase workflow is not possible if more than one dev wants to  
>> work
>> on the topic branch together.
>
> Why not?  I do it all the time.  CVS users do it all the time, for  
> that
> matter.

You're right. You can rebase your local changes on top of the new
shared remote head. And this is probably the best thing you can do
to get a clean history. Maybe it should be easier.

So, do I understand correctly, what you propose is:
- never merge but only rebase
- Due to lacking support for this in "git pull", never use
   git pull when working with shared branches but instead _always_ use
   "git fetch; git rebase origin/<branch_I'm_on>".

So you say that one of the first messages in "git for CVS users",
"The equivalent of cvs update is git pull origin" [1], is wrong.
I don't think I'm able to sell your proposed workflow with the current
documentation. But maybe I try if I'm absolutely convinced that it
is superior.

[1] http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html


>>> But here is a proposal which should make you and your developers
>>> happy, _and_ should be even easier to explain:
>>>
>>> Work with topic branches.  And when you're done, delete them.
>>
>> Again, if you want to share the topic branch the situation gets
>> more complex.
>
> Hardly so.  In my proposed solution to your problem, there is nothing
> which prevents you from working off of another branch than "master".

Well if you have several local branches checked out that are
shared with others you run into the "git push" problem again ...
(see below at git push origin master).


>>> So the beginning of the day could look like this:
>>>
>>> 	git fetch
>>> 	git checkout -b todays-topic origin/master
>>>
>>> 	[hack hack hack]
>>> 	[test test test]
>>> 	[debug debug debug]
>>> 	[occasionally commit]
>>> 	[occasionally git rebase -i origin/master]
>>>
>>> and the end of the topic
>>>
>>> 	git branch -M master

Isn't this a bit dangerous? It forces to overwrite master
no matter what's on it. You don't see diffstats nor a fast
forward message that confirms what you're doing.


>>> 	git push origin master

I'd like to see "git push" here. But to make this work without
error you'd need to _delete_ master after you pushed. Otherwise
it could happen that you later work on a different shared
branch and "git push" would complain about master. "git push"
would recommend to do a "git pull" and we're back where the
discussion started.

Or do you propose to delete master at this point? That is do
you propose to _never_ have remote branches checked out locally.
Except for a very short period when you do

     git branch -m <shared_branch>
     git push origin <shared_branch>
     git checkout do-not-work-here
     git branch -D <shared_branch>


>>> If you should not be ready to push by the end of the day, no need to
>>> worry.  Just stay on that topic branch, and before pushing, do
>>>
>>> 	git fetch
>>> 	git rebase origin/master
>>>
>>> In _every_ case where I explained git, I found that people  
>>> appreciated the
>>> two-step procedures (like you will find in the examples I showed you
>>> above): one git command to work locally, and one to push/fetch to/ 
>>> from
>>> origin.
>>
>> Maybe. I know git quite well now and in a shared workflow "git pull"
>> with auto-fast-forward would help me. I often need to run "for each
>> local branch: git checkout ; git merge" to get rid of the errors
>> reported by "git push".
>
> The problem I see here: you know git quite well.  Others don't, and  
> will
> be mightily confused why pull updates local branches sometimes, and
> sometimes not.

But it already happens now. "git pull" sometimes merges a
remote branch (--track) and sometimes it reports an error that
is fails to do so (--no-track). It would only do more work
automatically in the future and report appropriate warnings
or errors if it runs into a problem.

	Steffen
