From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 09:15:35 +0200
Message-ID: <47204297.5050109@op5.se>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikwwb-0004jW-MF
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 09:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbXJYHPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 03:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbXJYHPm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 03:15:42 -0400
Received: from mail.op5.se ([193.201.96.20]:53878 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756221AbXJYHPl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 03:15:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 79C9617306FF;
	Thu, 25 Oct 2007 09:15:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SeHFmD4KdbT; Thu, 25 Oct 2007 09:15:37 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 66E7817306F3;
	Thu, 25 Oct 2007 09:15:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710250021430.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62281>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 25 Oct 2007, Steffen Prohaska wrote:
> 
>> On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:
>>
>>> But I think I have to drive my message home again: if what you desire 
>>> becomes reality, you take away the clear distinction between local and 
>>> remote branches.  In fact, those branches are neither local (because 
>>> the next pull will automatically update them with remote changes, but 
>>> _only_ if they fast-forward) nor remote (because you plan to work on 
>>> them locally).
>> Exactly, because I do not work on those branches alone. These are 
>> _shared_ branches. I can work on such a branch with a group of 
>> developers. I'm willing to accept this bit of chaos.
> 
> It is not just a chaos.  I see a serious problem here.  On _your_ 
> computer, you do _not_ have a shared branch.  Which is visible _even_ in 
> your modified work flow when you have unpushed changes.
> 

Ofcourse it is. People might pull from it. That's the whole point of a
distributed model.

> So your desired illusion that your local branches are anything but local 
> branches will never be perfect enough.
> 
>> Your rebase workflow is not possible if more than one dev wants to work 
>> on the topic branch together.
> 
> Why not?  I do it all the time.  CVS users do it all the time, for that 
> matter.
> 

For 200 branches at a time, where any of them might have changed? Do they
*really* go into all those branches and make really, really sure they run
git pull before they ever do anything? Isn't there a teensy weensy risk of
them forgetting that sometime when they really meant to do it?

On the other hand, if they absolutely *must* fork a branch at a specific
point in history (rather than "the latest published work this branch has"),
won't they run gitk/qgit/git-log/whatever, regardless of where their branch
head is?

> 
> The problem I see here: you know git quite well.  Others don't, and will 
> be mightily confused why pull updates local branches sometimes, and 
> sometimes not.

Do you know this, or are you just guessing? I'm getting the exact same
confusion with the current behaviour. "Why the hell doesn't git update
all the branches I told the damn stupid tool to auto-merge when I pull?"
frequently echoes around the office. My co-workers aren't interested in
learning about git internals, or its reasons for doing what it does.
They don't give a damn about local vs remote namespaces for their branches.
They want to get some work done the smoothest way possible, but with our
small forest of repositories and the bushel of branches in each repo
makes life difficult for them, because they just can't imagine that
git doesn't do what they told it to, which is "this branch tracks that".
They may work on "this", but still want it to track "that" so they don't
have to run "git-update-all.sh", or "git-walk-everything.sh" or any other
of a dozen small and near-identical scripts floating around the office.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
