From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Thu, 18 Dec 2008 17:27:23 -0800
Message-ID: <20081219012723.GI6912@linux.vnet.ibm.com>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness> <20081219000218.GA23990@linux.vnet.ibm.com> <7vabatf1pg.fsf@gitster.siamese.dyndns.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 02:28:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDUAY-0001tE-U1
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 02:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYLSB11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 20:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYLSB10
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 20:27:26 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:55224 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbYLSB1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 20:27:25 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBJ1QWuZ006775;
	Thu, 18 Dec 2008 20:26:32 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id mBJ1ROX7178260;
	Thu, 18 Dec 2008 20:27:24 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id mBJ2RXUa027587;
	Thu, 18 Dec 2008 21:27:34 -0500
Received: from paulmck-laptop.localdomain (paulmck-laptop-009047022065.beaverton.ibm.com [9.47.22.65])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id mBJ2RXHN027556;
	Thu, 18 Dec 2008 21:27:33 -0500
Received: by paulmck-laptop.localdomain (Postfix, from userid 1000)
	id F316C14FBEE; Thu, 18 Dec 2008 17:27:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vabatf1pg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103525>

On Thu, Dec 18, 2008 at 04:28:11PM -0800, Junio C Hamano wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> > On Fri, Dec 12, 2008 at 07:57:38PM +0100, Johannes Schindelin wrote:
> > ...
> >> I am sure we want to have something like that in git.git.
> >
> > So am I.  Except that I am not being sarcastic.  ;-)
> 
> Hmm, but we seem to already have too many intro-to-git documents in tree.
> Perhaps good points in the document can be used to augment or replace
> parts of existing documents?  For example, which part of the new
> documentation would have helped you avoid the pain you mentioned below...

I would be OK with it being in linux-2.6.git rather than git.git,
if that helps.  Certainly there seems to be room for a description
of how to use git within the Linux community.

> > In particular, David's guide was quite helpful to me.  It would have been
> > even more helpful had it existed when I first tried (unsuccessfully)
> > to use GIT.  In particular, GIT's requirement that I tell it about new
> > versions of existing files (either with "git add" or "git commit -a")
> > was extremely counter-intuitive, and caused me no end of pain.
> 
> ... and which part of the existing user manual or tutorial should have
> talked about it to help you?

The part that describes the differences between git and traditional
source-code-control packages.  A few examples:

o	Having to add files that are already there when changing them.
	"Why do I need to add it?  Can't git see that it is -already-
	-there-???"  ;-)

	The key point is that traditional source-code has a file as a
	first-class concept.  Not git, which instead has a particular
	revision of a file as the front-and-center first-class object.
	Simply saying this is insufficient, as both git and (say) RCS
	track both files and revisions to files.  If you do simply state
	this, the RCS guy will think he understands you, but he won't
	have a clue.

o	The fact that git's log changes depending on what branch
	you are on is quite confusing to those of us who are used
	to history being invariant.  I am learning to do "git branch -l"
	to see where I have been in my own git trees.  No doubt there
	is some way to dump out the relationship between the various
	branches and some convention for "the current revision" for
	the upstream git tree, but I have not found it yet.

	Not that I have looked all that hard.  The Linux kernel has
	a nice linear series of version tags that tell me what I need.
	But that is only because I work on stuff that is out of the
	quickly changing mainstream.  My own projects I still remember,
	and keep textfiles listing what each branch is intended for.

o	The fact that you can put a git archive into a state so that
	"git remote update" changes the archive, but doesn't change
	your view, nor any obvious-to-the-newbie attribute of the view.
	The only way I know to get out of this is to carefully record
	the new SHA hash that "git remote update" prints, and then do a
	"git checkout" on that SHA hash.  Given a quiescent archive,
	how do I find the points of interest?  For -tip, I can usually
	check out "tip/core/rcu" and get where I need to go, but I am
	quite unclear on navigation through a git archive.  For one
	thing, git will sometimes interpret "tip/core/rcu" as a path
	name rather than as a navigation point (or whatever the heck
	it really is).

o	I need to work with multiple views of the same git archive.
	Doing "git checkout"s back and forth within a single archive
	does not do what I need.  I have been experimenting with various
	"git clone" archives and usually been getting my fingers burned
	in various ways.  In one case, I got a second archive, but
	all the branches had disappeared.  Why didn't they come across,
	and what do I need to do to see them?  remote/whatever, perhaps?

	Dave's example might not be exactly what a git expert would
	suggest, but at least it is an easy to follow procedure for
	doing what I need to do.

o	If you don't set up branches correctly, pulling in changes
	from a remote copy of your archive will undo your recent changes
	in your local archive.  Fortunately, I was a bit paranoid by the
	time I tried this, so noticed it while I could still easily
	revert it.

o	Troubleshooting guide.  There is some of this in the various
	"git reset --ripcord" options, but it will be necessary to
	learn the mistakes that dinosaurs such as myself tend to make
	with git, and describe how to detect and fix them.  In contrast,
	the existing troubleshooting guides seem designed for someone
	for whom git is the only source-code control system they have
	known.

> > But my experience is that git is at best an acquired taste for those of
> > us who grew up with traditional source-code control systems.  Such
> > people will benefit greatly from a git-haters guide,...
> 
> "Acquired taste" is a much nicer and more diplomatic way to say the same
> thing as what Linus often refers as "unlearning the braindamage inflicted
> by years of using CVS." ;-)

Heh.  From my viewpoint, CVS is a very recent innovation.  So I am sure
that you meant to write "unlearning the braindamage inflicted by years
of using RCS".  ;-)

Heck, my first source-code-control system was a cabinet full of punched
cards.  No joke.  Another project used a whiteboard -- you wrote down the
names of the files that you were modifying in order to avoid conflicts.

So from my viewpoint, even RCS is a fairly recent innovation.  ;-)

> > ..., and git's user
> > population will grow as a result.
> 
> I do not think it constitutes any basis for judging the merit of having
> the document in git.git tree.  The world domination is not our goal, but
> it may come as a mere side effect of being the best in the business.

Not if almost all of the people who grew up with old technology choke
on git the first time they come across it.  I am here to tell you
that had I not been forced to use git in my work on the Linux kernel,
I would not have given it a second look.  My first several experiences
with it were -extremely- frustrating.  Not necessarily due to bugs
in git (though I might have been running into those, for all I know),
but because it invalidates the intuitions one builds when working with
traditional technology.  One does what comes naturally with git, and
very quickly ends up with a steaming pile of bits.  Which a git expert
could no doubt rescue, but which I was forced to remove and re-clone.

So I suppose I should list some of the things I like about git:

o	It very naturally deals with remote repositories.  If someone
	holds your hand the first time, that is.  ;-)

o	Tagging works very nicely.  In contrast, tagging in RCS is
	quite painful and very easy to get wrong -- to the point that
	I never bothered using it.

	With git, I can easily tag the revision corresponding to a patch
	sent to LKML and then very easily see what I have changed when
	it is time to send the next version.  Very handy and nice.
	I suppose I could do the same thing with branches, and might
	try that next.

o	Moving among various branches works nicely -- as long as you
	know the name of all the branches you need to know about.

o	The "git diff" command usually does what I want with a minimum
	of information -- though it sometimes feels the need to list
	out the names of all the files that have not changed, for
	reasons I do not yet understand.  Still, I have often been
	pleasantly surprised when it does what I wanted it to do despite
	my having forgotten to type something I thought was essential.

o	The fact that "git commit" lists all the files that changed but
	are not being committed has saved me much time and trouble.
	As has its listing the names of the files that -are- being
	committed.

o	I have only used "git rebase" a couple of times, but I could
	see that I could come to like it very much.

See?  I am already only partially a git hater!  ;-)

							Thanx, Paul
