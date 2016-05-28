From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: new git-splice subcommand for non-interactive branch
 splicing
Date: Sat, 28 May 2016 09:06:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605280841000.4449@virtualbox>
References: <20160527140811.GB11256@pacific.linksys.moosehall> <alpine.DEB.2.20.1605271701500.4449@virtualbox> <20160527163652.GC11256@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sat May 28 09:07:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6YLC-0006k6-Vk
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 09:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbcE1HHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 03:07:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:58301 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbcE1HHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 03:07:04 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MVN0w-1b1b4v2K58-00Yleh; Sat, 28 May 2016 09:06:59
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160527163652.GC11256@pacific.linksys.moosehall>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ciFkwugp/9fpCZNYDg1Lf7re7FkAyQp7nNbG7i+PYwCwX08qxVp
 0vGB7jqPZDOyzSlMBHhTLucjuVM3P5ZbDy8O9sSHZu5BU1kUKMVMRZ3EGd9LWOrbThooY+O
 WIlyNXyWTB0sYlm7lADrvrEwlVnpIwIYcioYGwW+IQ5vh6tC2VP7WKpkuFgogsG08aBC91A
 9vVB1ts1rdf4zv0gsZxUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ya79u+eULCE=:3eUh0UarU5IYHQn7oDSmPX
 b71FHOsvHDvG/x8Q4VQpAZoGgm+aZpWf2jEnBvM5VNf/xHyrPzxgvO06CtSHqk6swszYQD4rZ
 XVnzNYAyTwu9uw4Nays4Ckih+xyfKAWo8HuEmrq49Y6RO+5qt11IwjG6ee89+h7n4OnyIfc+O
 vgDKLy+bGO0/VjytPZWLK2xEGjROnFYZsY4tYR2PJoJMda0m5B/FkzuZ7ubDFpDE6okOgjNq3
 BOxt7+rIZjPEKW7kmyhPpZOV3bHL7XnglISkdxFu5nI0GeU4M+sdNt2gmGTqJQ9sztXceX873
 igvbg8qPvyFQrkqM556+IXKkTsPh5GETDnpz/G0N9VaLFPbBsFGu7sD+4SAtNxgZudvv/aZOU
 UH/V9m+ImNPPIrDTQaTOTXbGyp7cijZX4ZYT2kpSU+6fkHaiJJUyufwKp8YC/oM+KdXLreOgS
 WhItQMlXuP2Fzwpt+476jW8rNG7RyeysQa0FuI/DHu4aeH2HV0gaE18ukfALQj5VxJl260nGD
 dwW4A8TXpNyDrVF1gl6maH5tKVkb4pEG4dVxh4MwoaUQ+6YIgmpW4vkXy5tT8S1VWU4MkD8YF
 KAJ3kRq6eEnZ5KOcJnT69j2GHLUD0+C6jNjBzvHXQ2IpGN9BkP7Tr09auiaok+9P4zxc6FfmD
 TpRB1DtrDGKahrZXEu39owqazRGxP49MljvQXRvTEWv7VecnHzGB1uYFZvrKFjSE3EBro/CsI
 +h8BnFto6YDNWEo+/+FKDNX8kTbs+823rKSstSKZ+756Y16XsdRAI9l9R/dufGvBZtDv7wrm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295804>

Hi Adam,

please reply-to-all on this list.

On Fri, 27 May 2016, Adam Spiers wrote:

> My feeling is that rebase -i provides something tremendously
> important, which the vast majority of users use on a regular basis,
> but that git is currently missing a convenient way to
> *non-interactively* perform the same magic which rebase -i
> facilitates.

Would it not make sense to enhance `rebase -i`, then?

I, for one, plan to port my Git garden shears (at least partially) once I
managed to get my rebase--helper work in. The shears script is kind of a
"--preseve-merges done right":

	https://github.com/git-for-windows/build-extra/blob/master/shears.sh

It allows you to (re-)create a branch structure like this:

	bud
	pick cafebabe XYZ
	pick 01234567 Another patch
	mark the-first-branch

	bud
	pick 98765432 This patch was unrelated
	mark the-second-branch

	bud
	merge the-first-branch
	merge the-second-branch

Of course, this is interactive. But quite frankly, you want to be able to
perform quite complicated stuff, and I think the command-line offers only
an inadequate interface for this.

> I suspect the most popular use-case in the short term would be the
> infamous "oops, I only just noticed that I put that commit on the
> wrong branch, and now there's already a whole bunch of other commits
> on top of it".

I have two workflows for that. The simpler one:

	git checkout other-branch
	git commit
	git checkout @{-1}

Sometimes I need to call `git stash -p` before, and `git stash apply`
after those calls.

The more complicated one comes in handy when a complete rebuild takes a
long time, and branch switching would trigger a rebuild:

	# Here, I stash what I *want* on the other branch
	git stash -p
	git worktree add throwaway other-branch
	cd throwaway
	git stash apply
	git commit

I did use the approach you proposed a couple of times: just commit in the
middle, and sort things out later. The problem: I frequently forgot, and
if I did not, reordering the commits resulted in stupid and avoidable
merge conflicts.

> > > In the longer term however, I'd like to write two more subcommands:
> > > 
> > >   - git-transplant(1) which wraps around git-splice(1) and enables
> > >     easy non-interactive transplanting of a range of commits from
> > >     one branch to another.  This should be pretty straightforward
> > >     to implement.
> > 
> > This is just cherry-pick with a range...
> 
> No it's not:
> 
>   - git-transplant would be able to splice commits from one branch
>     *into* (i.e. inside, *not* onto) another branch.

Okay, but in case of merge conflicts, you still have to switch to the
other branch, right?

>   - git-transplant would also take care of removing the commits from
>     the source branch, but not before they were safely inside the
>     destination branch.

That assumes a workflow where you develop on one big messy branch and
later sort it out into the appropriate, separate branches, right? I admit
that I used to do that, too, but ever since worktrees arrived, I do not do
that anymore: it resulted in too much clean-up work. Better to put the
commits into the correct branch right away. Of course, that is just *my*
preference.

>   - git-transplant would orchestrate the whole workflow with a single
>     command, complete with --abort and --continue.

cherry-pick also sports --abort and --continue.

> > >   - git-explode(1) which wraps around git-transplant(1) and
> > >     git-deps(1), and automatically breaks a linear sequence of commits
> > >     into multiple smaller sequences, forming a commit graph where
> > >     ancestry mirrors commit dependency, as mentioned above.  I expect
> > >     this to be more difficult, and would probably write it in Python.
> > 
> > You mean something like Darcs on top of Git. Essentially, you want to end
> > up with an octopus merge of branches whose commits would conflict if
> > exchanged.
> 
> Something like that, yes, but it's not as simple as a single octopus
> merge.  It would support arbitrarily deep DAGs of topic branches.

Yes, of course. Because

A - B - C - D

might need to resolve into

A - M1 - C - M3
  X        /
B - M2 - D

> > I implemented the logic for this in a shell script somewhere, so it is not
> > *all* that hard (Python not required). But I ended up never quite using it
> > because it turns out that in practice, the commit "dependency" (as defined
> > by the commit diffs) does not really reflect the true dependency.
> >
> > For example,
> 
> [snipped examples]
> 
> Sure - I already covered this concern in footnote [0] of my previous
> mail; maybe you missed that?

I think it deserves more prominent a place than a footnote.

> > So I think that this is a nice exercise, but in practice it will
> > require a human to determine which commits really depend on each
> > other.
> 
> Of course - this is exactly why I wrote "or at least
> semi-automatically" in the first mail of this thread.  But even though
> git-deps / git-explode can never automatically handle *all*
> dependencies, they can handle enough dependencies to be significantly
> useful.  I have concrete real-world experience of that.

I'd love to see those examples where it worked, because it sure did not
work for me (I wasted two weeks to implement that script that I never used
successfully).

> I have made a large bunch of small commits to a single text file
> (design document).  Some are possibly contentious; some aren't.

Ah. Well, as I said, I changed my workflow to use multiple worktrees with
multiple branches. The contentious changes would go into at least one
branch, more likely multiple. The uncontentious changes would go into
another.

And most likely at least some of those branches would cause merge
conflicts. However, they would do so only once, not multiple times during
the cleaning-up phase.

I did actually track the time at some stage to determine what is faster.
Sorting things into multiple branches won hands down (in my hands). And
no: I did not believe it would.

> So I need to split them out into a series of smaller independent patch
> series which I can submit to gerrit for review, thereby making life
> easier for the reviewers and minimizing any bottlenecks where reviews
> for one change are blocked because another change hasn't been reviewed
> yet.  And in this case, because the changes are all applying to a single
> file containing only natural language, git-deps correctly determines
> *all* dependencies, not just textual ones.

I do not buy that. When you introduce a section way down in the document
for which you have to introduce a new definition in one of the first
sections, logically those two changes belong to the same topic branch. Yet
git-deps would have no chance to determine that.

> > You would render me *really* impressed if you could come up with an
> > automated way to determine logical dependencies between patches.
> 
> Hey, I would *really* impress myself if I could do that, too; after
> all, that would be a pretty sophisticated form of artificial
> intelligence :-)

Yep, I will definitely follow your progress!

Ciao,
Johannes
