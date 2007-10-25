From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Thu, 25 Oct 2007 09:31:02 +0200
Message-ID: <20071025073102.GD6069@xp.machine.xx>
References: <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkxBY-0001Dk-F4
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 09:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbXJYHbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 03:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbXJYHbH
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 03:31:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:51533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753715AbXJYHbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 03:31:06 -0400
Received: (qmail invoked by alias); 25 Oct 2007 07:31:04 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp032) with SMTP; 25 Oct 2007 09:31:04 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1++GTdXd+2+7WYSRqGUt+AOvKvljNCnrQzEJQ2R+0
	O33zQhFWbVkBlg
Content-Disposition: inline
In-Reply-To: <47204297.5050109@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62283>

On Thu, Oct 25, 2007 at 09:15:35AM +0200, Andreas Ericsson wrote:
> Johannes Schindelin wrote:
>> Hi,
>> On Thu, 25 Oct 2007, Steffen Prohaska wrote:
>>> On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:
>>>
>>>> But I think I have to drive my message home again: if what you desire 
>>>> becomes reality, you take away the clear distinction between local and 
>>>> remote branches.  In fact, those branches are neither local (because the 
>>>> next pull will automatically update them with remote changes, but _only_ 
>>>> if they fast-forward) nor remote (because you plan to work on them 
>>>> locally).
>>> Exactly, because I do not work on those branches alone. These are 
>>> _shared_ branches. I can work on such a branch with a group of 
>>> developers. I'm willing to accept this bit of chaos.
>> It is not just a chaos.  I see a serious problem here.  On _your_ 
>> computer, you do _not_ have a shared branch.  Which is visible _even_ in 
>> your modified work flow when you have unpushed changes.
>
> Ofcourse it is. People might pull from it. That's the whole point of a
> distributed model.
>
>> So your desired illusion that your local branches are anything but local 
>> branches will never be perfect enough.
>>> Your rebase workflow is not possible if more than one dev wants to work 
>>> on the topic branch together.
>> Why not?  I do it all the time.  CVS users do it all the time, for that 
>> matter.
>
> For 200 branches at a time, where any of them might have changed? Do they
> *really* go into all those branches and make really, really sure they run
> git pull before they ever do anything? Isn't there a teensy weensy risk of
> them forgetting that sometime when they really meant to do it?
>
> On the other hand, if they absolutely *must* fork a branch at a specific
> point in history (rather than "the latest published work this branch has"),
> won't they run gitk/qgit/git-log/whatever, regardless of where their branch
> head is?
>
>> The problem I see here: you know git quite well.  Others don't, and will 
>> be mightily confused why pull updates local branches sometimes, and 
>> sometimes not.
>
> Do you know this, or are you just guessing? I'm getting the exact same
> confusion with the current behaviour. "Why the hell doesn't git update
> all the branches I told the damn stupid tool to auto-merge when I pull?"
> frequently echoes around the office. My co-workers aren't interested in
> learning about git internals, or its reasons for doing what it does.
> They don't give a damn about local vs remote namespaces for their branches.
> They want to get some work done the smoothest way possible, but with our
> small forest of repositories and the bushel of branches in each repo
> makes life difficult for them, because they just can't imagine that
> git doesn't do what they told it to, which is "this branch tracks that".
> They may work on "this", but still want it to track "that" so they don't
> have to run "git-update-all.sh", or "git-walk-everything.sh" or any other
> of a dozen small and near-identical scripts floating around the office.
>

What actually wonders me why you guys do have 200 local branches. I
usually just create a local branch from the remote IFF I'd like to do some
work on it. And for inspecting a remote branch, a detached HEAD works just as
fine ...

-Peter
