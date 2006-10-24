From: David Lang <dlang@digitalinsight.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 11:03:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz> 
 <200610221105.26421.jnareb@gmail.com>  <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
  <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
  <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>  <20061023222131.GB17019@over-yonder.net>
  <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>  <20061024002622.GC17019@over-yonder.net>
  <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>
 <20061024163458.GH17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 20:04:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcQdr-0001oY-3t
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 20:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWJXSEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 14:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWJXSEl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 14:04:41 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:25536 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161123AbWJXSEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 14:04:40 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 24 Oct 2006 11:04:40 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 24 Oct 2006 11:04:20 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061024163458.GH17019@over-yonder.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29996>

On Tue, 24 Oct 2006, Matthew D. Fuller wrote:

> On Tue, Oct 24, 2006 at 08:58:56AM -0700 I heard the voice of
> David Lang, and lo! it spake thus:
>>
>> one key difference is that with bzr you have to do this chopping by
>> creating the branches at the time changes are done,
>
> HUH?  Why on earth do you think that?
>
> To do this in a git data model, you point at 2 (or 3, or 4, or...)
> revisions, anywhere in the revision-space universe.  You derive back a
> DAG of the history from each of them by recursing over parent links.
> You figure out where (if anywhere) those DAG's intersect.  And based
> on that, you alter what and how you display; including or excluding
> certain revs, changing the angles of lines or columnation of dots in a
> graph, etc.
>
> To do it in a bzr data model, you would follow *EXACTLY* the same
> steps.  As in, you do EXACTLY (a), then EXACTLY (b), then...

it sounded like you were saying that the way to get the slices of the DAG was to 
use branches in bzr. to do this you need to create the branches with the correct 
info on each branch. this is only practical if the branches are created as the 
changes are made, if you try to do this after the fact you need to create the 
changes in the branch before you do the slicing.

with git you can look at the DAG and pick any arbatrary points in it as points 
to use for the slicing at display time.

>> what people are saying is that it doesn't easily support a truely
>> distributed workflow. this is a very different statement.
>
> And it's one that carries around a lot of unstated assumptions about
> what "truely distributed" means, which *I*'m certainly not
> understanding, because any meaning I can apply to the term doesn't
> lead me to the conclusions it does you.  Certainly, depending on your
> workflow, certain parts of the UI are of lesser utility than they are
> in mine, down to and including zero.  And it's probably certain that
> some parts of the UI aren't up to handling various workflows, too,
> including OUR workflow.  That's kinda what "in development" means...
>
> But that's a very different statement from the claim that they CAN'T
> be without changes to the conceptual model underneath.  Just because a
> UI is built around maintaining the fiction of a mainline doesn't mean
> the system requires it.  All you'd have to do to abandon it is write a
> different log formatter that didn't show revnos and didn't nest merge
> commits, and change (or add an option to) 'merge' to fast-forward if
> possible.  The difference between the views on how the pieces should
> fit together really IS just that fine.

the claim isn't that bzr can't be modified to support these other workflows (it 
sounds as if just changing to tools to use the internal refid's rather then the 
current refno's would come very close to solving this problem), it's that the 
current refno's (use of which is strongly encouraged by the current UI) cannot 
support some workflows, and therefor the claim that it supports fully 
distributed workflows as well as git is false

remember that this entire thing started with a feature comparison checklist, 
the definitions of some of the items on the checklist is being questioned.

after that there's the issue of if the VCS in question has the feature.

this discussion started with two topologies

1. Centralized: all commits must go to one repository, connectivity required to check-in 
2. Distributed: everything else

since then one additional topology has been defined, and one has been redefined

1. Centralized: all commits must go to one repository, connectivity required to check-in

2. Star: one repository is 'special' or 'primary' and all other repositories 
sync to this, but development can take place against local repositories, 
connectivity is only requred when syncing the repositories. as updates take 
place the history is defined by the primary repository, and can overwrite or 
change the history as defined by local repositories.

3. Distributed: all repositories are equal (any definition of 'primary' is a 
matter of convention, not a requirement of the tool) development can take place 
against local repositories, connectivity is only required when syncing the 
repositories. repositories with no development takeing place can sync back and 
forth with no side effects. History displays the same thing no matter what 
repository is looked at (allowing for the fact that some repositories may not 
have the full history)

everyone agrees that bzr supports the Star topology. Most people (including bzr 
people) seem to agree that currently bzr does not support the Distributed 
topology.

it's just fine for bzr to not support all possible topologies, the only reason 
for discussing these issues (besides everyone understanding each other) is the 
feature checklist that started this entire thread, and what is appropriate there 
for each VCS (see the early part of this discussion to see how that worked with 
git's rename support)

David Lang
