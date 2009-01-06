From: "Tim Visher" <tim.visher@gmail.com>
Subject: Comments on Presentation Notes Request.
Date: Tue, 6 Jan 2009 17:33:02 -0500
Message-ID: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 23:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKKWV-00032f-CN
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 23:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758985AbZAFWdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 17:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758997AbZAFWdM
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 17:33:12 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:51751 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758976AbZAFWdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 17:33:03 -0500
Received: by an-out-0708.google.com with SMTP id d40so2613935and.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=V8T+uLueDG06SSUbTT59sgQ/tKHjQzxmd0i8nvy8Va0=;
        b=U2d4qe4+Z4kj3ytPJjYUHdWgxRyDZssJZfCVgAACwKUUPE93skxdLGBPlHwlR+HjAh
         3rjw/xdfZNb2wKhHaLaAqyGjslGaGsvR0zpKc4CsjW+G9fnE1Nf4HA6nt0tknZfXMssG
         PNT1V0N6maP9BtWPCuQUA4eU9IpkabNjEJBTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oAQ0Hj2ffgsera11zHtkjU+IT2ce6R4frGFxUsQHi2zq6W1pn1E3Oe02DTm/EuI33O
         2skdzH3vvfb9/Jwl+7G/acDT0jWauhcsaTmREiMRiLcXzpBFNzFvzR4ZUDS+HvlHplP+
         yZoO+k4S+1w4Ft1fLPgCBUSZq2CTCaVm2XoUg=
Received: by 10.100.127.15 with SMTP id z15mr12065687anc.10.1231281182152;
        Tue, 06 Jan 2009 14:33:02 -0800 (PST)
Received: by 10.100.33.9 with HTTP; Tue, 6 Jan 2009 14:33:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104732>

Hello Everyone,

I'm putting together a little 15 minute presentation for my company
regarding SCMSes in an attempt to convince them to at the very least
use a Distributed SCMS and at best to use git.  I put together all my
notes, although I didn't put together the actual presentation yet.  I
figured I'd post them here and maybe get some feedback about it.  Let
me know what you think.

Thanks in advance!

Notes
---------

SCM: Distributed, Centralized, and Everything in Between.

* What is SCM and Why is it Useful?

** Definition

SCM is the practice of committing the revisions of your source code to
a system that can faithfully reproduce historical snap shots of your
source code.

** Advantages of SCM

*** One Source to Rule Them All.

Instead of having a bunch of source files spread across multiple
developers machines with multiple versions on each machine that may or
may not be labeled correctly, you have one repository containing every
artifact that your project includes.

*** Unlimited Undo/Redo.

Not only is it unlimited, but it's random access.  If you changed a
function a week ago, continued to work, and then decide that you want
the function back the way it was, it's as simple as pulling the
function back out of the SCMS.

*** Safe Concurrent Editing.

Many people can edit the same code base at the same time and know,
without a doubt, that when they pull all those changes together, the
system will merge the content intelligently or inform you of the
conflict and let you merge it.  You don't need to lock files.
Obviously, if there is bad coordination then the possibilities of
conflicts rise, but this should not happen regularly.

*** Diff Debugging

You can find where a bug was introduced by learning how to reproduce
the bug and then doing a binary chop search back through the History
to come to the exact commit that introduced the bug.

* SCM Best Practices

** Commit Early, Commit Often

The more you commit, the more fine grained control you have over the
undo feature of SCM.  Most documents that I have read suggested a TDD
approach wherein you commit whenever you have written just enough code
for your test to pass. But...

** Don't Commit Broken Code (To the Public Tree)

Of primary concern is the fact that your central HEAD should _always_
build.  This is why practices like Continuous Integration and TDD are
so important.  TDD gives you the freedom to be sure that a change you
made hasn't broken anything you weren't expecting it to break.
Continuous Integration allows you to be sure that your whole system
will build every time.  Thus, you should _never_ commit broken code to
the (public) tree.

Of course, in a centralized system, committing is intrinsically
public.  Even on branches, every time you commit any sort of change,
everyone is able to see it and so you could be breaking the build for
someone (even if it's just yourself and the build system).  One of the
nice features of a distributed system is that your public/private
ontology is much richer and thus allows you to have broken code in
your SCMS.

** Whole Hog

You should put everything necessary to build your system into SCM.
This includes user documentation, requirements documentation, software
tools, build tools, etc.  The only artifacts that don't need to be
managed are auto-generated artifacts such as javadocs, jar files, exe
files, etc.  This is so that you can reproduce entire releases using
only a simple checkout.

** Perform Updates and Commits on the Whole Tree

Updates and Commits should always be done on the whole tree so that
you're sure you have the latest source.  Never assume that nothing has
changed elsewhere.

** Allow and Encourage Customer Participation

Most shops seem to attempt to funnel customer participation through
the developers.  This is a cache miss for many operations such as
developing the user manual by a design team external to the
development team.  Basic operations such as commit and update are
fairly simple to grasp and can even be simplified further through
scripts and other such tools that non-developers can quickly be taught
to use.

Of note is the Tortoise family of tools which integrate directly into
Windows Explorer.  This makes it fairly easy for anyone who is
familiar with Windows Explorer to get into using any of the tools that
there is a Tortoise implementation for.

* The Centralized Model

** We Know About This One

This is traditional, plain vanilla, ubiquitous SCM.

The great majority of the SCMSes out there are centralized.

Closely resembles the Client/Server system model.

** Work Flow

<http://whygitisbetterthanx.com/#any-workflow>

*** 2 basic models: 'Lock, Modify, Unlock' and 'Copy, Modify, Merge'.

Older systems were primarily Lock, Modify, Unlock implementations.
You would checkout a file that you intended to work on, and no one
else would be able to check it out until you unlocked it, signaling
that you were done editing it.  This is inherently inefficient as on a
team of developers, the chances that two are working on the exact same
part of a system without knowing it and coordinating are fairly low.
Also, any disparate features that still touch the same files in the
system cannot be worked on simultaneously.

The answer to this is Copy, Modify, Merge.  In this system, every
developer gets a complete copy of the HEAD.  Everyone changes the HEAD
concurrently.  When commits happen, the system attempts to
intelligently merge them.  If it fails (usually doesn't happen unless
there is bad coordination), then it asks you to merge them.  This has
been proven to work well.

** Key Properties

*** Only One Repository

In centralized systems, there is only one global, public repository.
This has certain significant effects, such as an intrinsically global
name space for branches and tags, a restrictive public/private concept
(no such thing as committed but private), need for a backup process
aware of the possibility of in-progress commits, etc.

Since the repository only exists in a single location, the developers
only have copies of a specific revision and any uncommitted changes
they've made to that copy.

*** All Committed Changes Are Public

This includes regular commits (what we'd typically think of commits),
branches, and tags.

As previously mentioned, in centralized systems, all committed changes
are public.  Even if you are working on a private branch (which you
typically wouldn't be because branches are expensive in centralized
systems), the changes you are making are still visible publicly
because your branch exists in the global, public repository.

*** Intrinsically Uses the Network.

Because you must have a single repository that all developers are
accessing, you must use the network for many common operations.
Commits must be made to the central repository, Logs live centrally,
branches live centrally, diffing between revisions is a network
operation, blaming is a network operation, etc.

*** Backup Becomes A Separate Process

Because there is only a single repository, you need a back-up strategy
or else you are exposing yourself to a single point of failure.
Unfortunately, this is not as simple as it sounds.  The global, public
nature of the repository makes the chances of creating a corrupt back
up very high.  Because of this, tools have grown up around and in many
centralized systems that automate the process of backing it up while
remaining aware of the problems that can arise.  However, the point
remains that there is no intrinsic back up of a centralized system.

*** Need A Repository Admin.

Because the system is centralized, you need a repository
administrator.  This is true in most modern centralized systems where
new repositories are created on a per project basis (as in, not VSS).
In other words, when you want a new repository, you need to go through
some sort of admin interface or through the administrator of the
repository server to make it happen.

* The Distributed Model

** This Ones New

At least new as in unfamiliar.  The concept is over a decade old.

There are a few different popular distributed SCMSes (Git, Mercurial
(hg), Bazaar (bzr), Bitkeeper)

Very closely resembles a peer-to-peer network and the organic
relationships that evolve in that space.

In a distributed system, there is no one point where all development
comes together to for any reason other than policy.  Everyone who is
working on a system intrinsically has their own copy of the entire
repository.  All of the history, all of the source code, all of the
public branches, all of the public tags, etc.  Because of this,
developers can also have private branches, private tags, private
commits, private history.  The distinction between public and private
is very important in this context.  This has several distinct features
which I'll go into now.

** Work Flow (Pick Your Poison)

<http://whygitisbetterthanx.com/#any-workflow>

** Key Properties

*** Private/Public Concept

Distributed SCMSes Private/Public ontology is __much__ richer.
Whereas in a central system, private means only what you have yet to
commit or what you are leaving untracked, in a distributed system,
private means anything that you have not yet _chosen_ to make public.
In other words, you can have private branches, private tags, private
committed changes to your copy of the head, etc.  Anything that you do
not specifically publish to a location that others can access is
intrinsically private.

In other words, you can finally SCM your sandbox!  You can commit as
many broken things as you want to a private repository, giving you the
ability to have a nearly infinite set of undoable and recoverable
changes, without breaking anyone else's build.  Or, you can just as
easily ignore TDD, never commit anything for 3 weeks and then do a
big, massive commit and as long as your final product is tested and
merges with the rest of the tree, you're good to go and no one cares.

Because you have a rich ontology for private/public data, you can also
do crazy things like rewriting your local history before anyone else
sees it.  Because your repository is the only one that has to know
about the history as long as you're dealing with private data, this is
a completely safe (although policy debatable) operation.  Of course,
once data has been published, you really shouldn't mess with its
history anymore.

*** Network(less)

In distributed systems, networks are optional for almost every
operation (and indeed, every operation prior to publishing).  Of
course, you could put your repository on a network drive and then
you'd be doing everything over the network like you would in a
centralized system, but if you put your repository clone on your local
system, then everything you do in that repository is local.  Viewing
your history, committing, branching, merging, everything.

Once you've published, however, not much changes.  Almost everything
except updating and publishing (_not_ committing) remains local.
Remember that committing no longer means publicly publishing.  You can
commit many revisions, even to the master HEAD and nothing at all has
been published until you push those changes to your public HEAD.

*** Natural Backup

Because every developer has a copy of the repository, every developer
you add adds an extra failure point.  The more developers you have,
the more backups you have of the repository.

*** Must Learn New Work Flows.

In order to fully experience the advantages of distributed systems,
new work flows must be learned.  In other words, it's possible to use
distributed systems nearly the exact same way as you use a centralized
system (you just need to learn new commands), but you don't get many
of the benefits except the speed improvements.  The real game change
happens when you realize that you can keep things private until their
finished.  Once you realize that, new branching patterns emerge, new
work flows happen, you commit more often, and have the ability to
become much looser and freer in your development process.

*** Impossible To Completely Enforce A Single, Canonical
Representation of the Code Base.

By nature, a distributed system cannot enforce a single canonical
representation of the code base except by policy, and policies can
always be broken.  Also, any intentionally private data is not backed
up because it is not shared.  However, backup becomes much simpler
because you know that no one else is committing to your repository.

This bears some explanation.  Within a distributed system, you can
have a single official release point that everyone has blessed (or the
company has blessed, or the original developer has blessed, or
whatever).  However, you cannot _stop_ someone else from making a
release point because their repository is just as valid as yours.  You
cannot _stop_ developers from sharing code between themselves without
going out to the official central location.  All you can do is ask
them not to.

* Why Git is the Best Choice

** Fast

Git's implementation just happens to be wickedly fast.  It's faster
than mercurial, it's faster than bazaar, etc.  Everything, committing,
merging, viewing history, branching, and even updating and and pushing
are all faster.

** Tracks Content, not Files

Git tracks content, not files, and it's the only SCMS at the moment
that does this.  This has many effects internally, but the most
apparent effect I know of is that for the first time Git can easily
tell you the history of even a function in a file because Git can tell
you which files that function existed (or does exist) in over the
course of development.

** Extremely Efficient.

Because Git tracks content, it can also be extremely efficient
spacewise, simplifying the files to be nothing but pointers to a set
of objects in Git's internal file system.  Thus, if you have
duplicated hunks, git uses a single object to represent them.  Git has
been proven to be more efficient space wise than any other system out
there.

** (Un)Staged Changes

Git employs the concept of the Index or Cache or Commit Stage.  This
is also unique to Git, and it's pretty strange for developers coming
from a system without it.

Basically, There are 4 states that any content can be in under Git.

1. Untracked: This is content that Git is completely unaware of.
2. Tracked but Unstaged: This is content that has changed that Git is
aware of but will not commit on the next commit command.
3. Tracked and Staged: This is the same as unstaged except that this
content will be committed on the next commit.
4. Tracked and Committed:  This is content that has not changed since
the previous commit that Git is aware of.

This is very powerful yet somewhat awkward to grasp.  Basically, the
upshot of this feature is that you can manually build commits if you
want to.  Say you were working on feature foo and then made some other
changes because you came across feature bar and thought it would be
quick to do.  In any other system, the only way you could commit parts
of what you'd changed is if you were lucky enough for the disparate
changes to be in different files.  In that case, you could commit only
the files that you wanted to change for the different features.
However, if you made disparate changes to the same file, you were
stuck.  In Git, you can stage only parts of the files to an extreme
degree.  This allows you to create as many commits as you want out of
a single change set until the whole change set is committed.

I've found this to be particularly useful when working with an
existing code base that was not properly formatted.  Often, I'll come
to a file that has a bunch of wonky white space choices and improperly
indented logical constructs and I'll just quickly run through it
correcting that stuff before continuing with the feature I was working
on.  Afterwords, I'll stage the formatting and commit it, and then
stage the feature I was working on and commit that.  You may not want
that kind of control (and if you don't, you don't need to use it), but
I like it.

** Excellent Merge algorithms

Git has excellent merge algorithms.  This is widely attributed and
doesn't require much explanation.  It was one of Git's original design
goals, and it has been proven by Git's implementation.  Merging in Git
is _much_ less painful than in other systems.

** Has powerful 'maintainer tools'

Beyond the basics of committing, updating, pushing, viewing logs, etc.
Git is known to have very powerful tools maintainer level tools.  You
can modify your history, you can automatically perform binary searches
to locate errors, you can communicate via patches, it's highly
customizable, has the concept of submodules (projects within
projects), etc.  It gets complicated, but at this level of SCM it is
complicated.

** Cryptographically Guarantees Content

One of the most surprising things I learned as I was researching this
was that most SCMSes do not guarantee that your content does not get
corrupted.  In other words, if the repository's disk doesn't fail but
instead just gets corrupted, you'll never know unless you actually
notice the corruption in the files.  If you have memory corruption
locally and commit your changes, you just won't know.

Git guarantees absolutely that if corruption happens, you will know
about it.  It does this by creating SHA-1 hashes of your content and
then checking to make sure that the SHA-1 hash does not change for an
object.  The details of this aren't as important as the fact that Git
is one of the very few systems that do this and it's obviously
desirable.

* References

- <http://git-scm.com/> - The Git homepage
- <http://whygitisbetterthanx.com/> - An excellent resource explaining
the benefits of using git in relation to other common SCMSes
- <http://www.youtube.com/watch?v=4XpnKHJAok8> - Linus Torvalds's
Google Talk on Git.  Covers mainly what Git is Not and Why
Distribution is the model that works.
- <http://www.youtube.com/watch?v=8dhZ9BXQgc4> - Randal Schwartz's
Google Talk on Git.  Covers what Git is, including some implementation
details, some use case scenarios, and the like.
- <http://book.git-scm.com/> - A community written book on Git with
video tutorials about many of Git's features.
- <http://subversion.tigris.org/> - Subversion's homepage.  An
extremely popular open source centralized system.
- <http://svnbook.red-bean.com/> - Rolling publish book on Subversion.
 Chapter 1 is a good introduction to general centralized SCM concepts
and principles.
- <http://www.perforce.com/perforce/bestpractices.html> - An excellent
set of best practices from the Perforce team.  Some of it (especially
the branches) has a distinct centralized lean, but most of it is quite
good.
- <http://www.bobev.com/PresentationsAndPapers/Common%20SCM%20Patterns.pdf>
- Interesting presentation by Pretzel Logic from 2001 attempting to
outline some common SCM best practices as Patterns.

---------------
End Notes

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
