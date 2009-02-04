From: Theodore Tso <tytso@mit.edu>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Wed, 4 Feb 2009 18:54:36 -0500
Message-ID: <20090204235436.GA8945@mit.edu>
References: <200902021948.54700.jnareb@gmail.com> <20090202202424.GG14762@mit.edu> <200902040304.05028.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrbE-0007cs-Ak
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbZBDXym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbZBDXyk
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:54:40 -0500
Received: from thunk.org ([69.25.196.29]:53129 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbZBDXyj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:54:39 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LUrZl-0003gS-Bd; Wed, 04 Feb 2009 18:54:37 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LUrZk-0002Qz-EK; Wed, 04 Feb 2009 18:54:36 -0500
Content-Disposition: inline
In-Reply-To: <200902040304.05028.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108473>

On Wed, Feb 04, 2009 at 03:04:02AM +0100, Jakub Narebski wrote:
> 
> I guess that this mailing list is subscribe-only, isn't it?  So doing
> CC to uvc-reviewers wouldn't, unfortunately, cut?

According to the Wayback Archive's record of the uvc-reviewers mailman
listinfo was open for anyone to join, and the archives were public,
which is why I don't mind sharing the archives with anyone who asks.

> > I'll include some of my writings on the subject from the uvc-reviewers
> > mailing list so folks can see where some of this discussion went last
> > time...  (All of this dates from January, 2008, when Eric was last
> > aggressively updating the paper in question.)
> 
> Thank you very much for those excerpts / fragments, even though
> I'd rather have your fresh comments either on current state of 
> "Understanding Version-Control Systems", or on my post.

My comments haven't changed; as you probably noted, I agree with you,
and my arguments largely parallel yours.  I was using a Reductio ad
absurdum argument to show that the same argument that claims that Git
is a primitive, hackish, SCM because it doesn't record user intention
vis-a-vis file renames could also be extended to say that use of all
current DSCM's amount to "Programming Malpractice" because they don't
allow the recording of higher level "user intentions" such as the
renaming of variables, functions, types, and class names.

My comments date from the very end of January 2008, when Eric stopped
updating his paper, and before he could start doing an extensive
description and evaluation of bzr, Mercurial and Git, so it's not
surprising that they are still relevant today.  I suspect that when he
picks up this draft again, and starts writing these sections covering
modern distributed SCM's, the sections for Mercurial, Git, Bzr,
et. al, will cause a huge amount of controversy, because even though
he is claiming to be unbaised, there is very clear in the draft to
date that he would very much like to draw a grand sweeping picture of
progress and evolution starting from "first generation systems" (RCS,
SCCS, et. al), to "second generation systems" (CVS, SVN, et. al), to
"third generation systems" (Arch, Monotone, git, Mercurial, etc.)

There are hints in the draft that he views "container identity" has
the next "evolutionary idea" which "more primitive" systems do not
have, and "more evolved" systems do have.  This can be seen from this
excerpt from his draft:

	First wrong assumption: Conflict resolution by merging is
	intractably difficult, so we'll have to settle for locking. It
	took at least fifteen and arguably twenty years for VCS
	designers to get shut of that one. But it's historical now.

	Second wrong assumption: Change history representation as a
	snapshot sequence is perfectly dual to the representation as
	change/add/delete/rename sequences.. This folk theorem is well
	expressed in the 2004 essay On Arch and Subversion. It is
	appealing, widely held, and dead wrong.

	File renames break the apparent symmetry. The failure of
	snapshot-based models to correctly address this has caused
	endless design failures, subtle bugs, and user misery.

So you can see that Eric seems to believe quite strongly that the
failure to track file renames is as fundamental an error as what he
terms the "First Wrong Assumption".  He later admits that the idea is
controversial, and that people are still "grapling" with it, but I
think he's tipped his hand about what he believes the ultimate correct
answer is with respect to this issue.

I believe, as I think you do, that the hysteria that states that you
*must* record user intention leads inexorably to the requirement to
force users to indicate "intention" by popping up Annoying Dialog
Boxes whenever they suck in a patch that was sent via e-mail so that
the SCM can record information about whether a file rename had
happened in a particular commit.  I believe this requirement to do
record user intentions and to pop up these Annoying Dialog Boxes is a
blind alley ala the vast amount of time wasted arguing over algorithms
such as Codeville precise merges.  I also believe that forcing users
to record "user intention" makes about as much sense as forcing users
to declare they are about to edit a file by explicitly taking locks on
files ala RCS.

I suspect Eric will disagree with me, but regardless of how he
completes his paper, it will almost certainly end up taking sides one
way or another on this controversy, at which point one side or the
other of this particular disagreement will argue that Eric is really
writing an advocacy paper pushing Bzr, Mercurial, or Git (depending on
how he comes out on this issue).


Your suggestion that the proof is going to be in the code makes a lot
of sense.  The examples I would suggest that we create, and then
demonstrate (or make enhancements to git) so that it can handle these
real world examples are:

1) In branch A, the directory src/plugin/innodb-experimental is
   renamed to src/plugin/innodb, and in branch B, a commit (i)
   modifies a file src/plugin/innodb-experimental/table.c, and (ii)
   creates a file src/plugin/innodb-experimental/mod-schema.c.  This
   commit in branch B is then pulled into branch A, where the
   directory rename has taken place.  The user may not know that a
   directory rename had taken place under the covers, so they don't
   give any magic options when they run the "git cherry-pick" or "git
   merge" command.  Does the right thing happen such that the right
   file in src/plugin/innodb is modified, and the new file is created
   in src/plugin/innodb, even though in the original commit, the
   changes were made to files in src/plugin/innodb-experimental?

2) And does the right thing happen if the situation is as described
   above, but in, branch C, which is descended from branch B, a new
   directory, src/plugin/innodb-experimental is created, such that
   src/plugin/innodb and src/plugin/innodb-experimental both exist.
   Now the same commit from branch A is pulled into branch C.  Will
   the correct thing happen in that the correct files in
   src/plugin/innodb are modified and created, even though there is a
   new directory containing a completely unrelated plugin that happens
   to have the name, "innodb-experimental"?

   BTW, it has been asserted that there exists at least one major open
   source project where this sort of thing happens quite often, and
   the fact that git did not do the right thing in these conditions
   was a factor their choosing another DSCM.

> Or "Detecting [Wholesame] Directory Renames"... which can be done
> using 'rename detection' paradigm, and we have patches to prove it![4]
> but unfortunately code didn't made it (yet!) into git.  And it can,
> I think, deal with splitting files into two directories, something
> which I guess in 'container identity' (directory-id) based solution
> is simply impossible

It may be that Yann Dirson's patches will handle case (1) above.
Handling case (2) is much harder, especially without slowing
everything down massively, since it would effectively mean needing to
looking for directory renames along every single commit on the branch.
(This would obviously have to be cached in some cache file.)

It can be done, I'm sure, but it would require a lot of code to get
right.  Whether or not it's worth it is a question which is open to
debate, but I believe the bzr folks have asserted that bzr can handle
both cases (1) and (2) above, and there are some folks who apparently
care.  

Whether or not a particular open source project will really and truly
run into this problem is a different question, and one can argue that
renaming plugins, and then creating new plugins with the same name as
older plugins that have since been renamed will lead to programmer
confusion, and so that's a good enough reason to avoid doing such
crazy things.  Unfortunately, you know how some programmers
are.... telling someone they shouldn't do something is often an
invitation to do exactly what you tell them is a bad idea, and then
they complain when your filesystem or your DSCM doesn't handle that
case particularly gracefully.

						- Ted
