From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion filesystem
Date: Sat, 22 Mar 2008 01:02:39 -0400
Message-ID: <3e8340490803212202r6dbaa9eel544ba2b4b8e8d0c7@mail.gmail.com>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Harvey Harrison" <harvey.harrison@gmail.com>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Jakub Narebski" <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 06:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcvtG-0005Xx-Bj
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 06:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbYCVFCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 01:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYCVFCo
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 01:02:44 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:41806 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYCVFCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 01:02:41 -0400
Received: by py-out-1112.google.com with SMTP id u52so2521822pyb.10
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 22:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=D24BO5HRxMF+iJ+GPzWDf1ERx2G02m2OuQY4gK565EE=;
        b=isJ3YG93A71PF5v69Oxb1pLoLQILM6lI8gXEfec9ZpBogx28PjeVq9DZWBc6Uutgh7eYC9excPfi+kh5j+PLafNTvT1KEumKCObBXirMhLTG8TPbvZ0/hXOjkYSuD09415vWArkZd3fDP+l6wN3qOEfpbxy80SJGph7G2A10Vt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e1tvHCiaxMO3BSx/kq+clhYACGMuSeSoCuymOCG79rPZQDYtyCVWZc7pcuoHdWbKleXPHuys3+O2h5Xswkt7ymvM5rFELgC+apL9VA3776rVTTtdk85SAwxzGuiG8JBnC/OcerIRiiZBNhETGKtXWfr++7pcdu3bGFTL/UqyG8s=
Received: by 10.65.158.9 with SMTP id k9mr8059891qbo.41.1206162159788;
        Fri, 21 Mar 2008 22:02:39 -0700 (PDT)
Received: by 10.64.195.14 with HTTP; Fri, 21 Mar 2008 22:02:39 -0700 (PDT)
In-Reply-To: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77791>

On Wed, Mar 19, 2008 at 12:08 AM, Bryan Donlan <bdonlan@gmail.com> wrote:
> Hello,
>
>  I'm planning to apply for the git summer of code project. My proposal
>  is based on the project idea of a subversion gateway for git,
>  implemented with a new subversion filesystem layer. A draft of my
>  proposal follows; I'd appreciate any comments/questions on it before
>  the application period proper begins.

Hi all,

Thanks for all the comments. To try to avoid spamming the list, I've
replied in a single message, if it'd be better to reply individually
in the future please let me know.

On Thu, Mar 20, 2008 at 12:31 AM, Sam Vilain <sam@vilain.net> wrote:
> Bryan Donlan wrote:
>
>  > Here are some tentative milestones:
>  > * Read-only access from SVN to the master branch (no trunk/ etc layout)
>  >   = Conversion of git commit information into svn revprops
>  >   = git mode/.gitignore -> svn property conversion here?
>
>  This seems like a large milestone.  Can you break this up any more?
>
>  For instance, your design notes on storing the necessary mapping
>  information are good.  How about a separate milestone of having a test
>  suite for the library functions you make for accessing that information.

That seems reasonable - eg, a milestone for cloning over a git tree
into the .git-svn branch.

>  I would be tempted to check the protocol -
>  http://svn.collab.net/repos/svn/trunk/subversion/libsvn_ra_svn/protocol
>  - and make milestones for each request type that the protocol allows
>  for.  Perhaps there is a more relevant list that you can find, such as
>  groups of tests in the back-end test suite that ships with Subversion.
>  Even taking the list of svn sub-commands, and deciding which fit into
>  each category would be a good enhancement.

I haven't decided I will try to take this into the subversion tree
proper - but I could try to shoehorn on the subversion tests. That
said, they tend to work by checking in test data, then verifying it,
so they won't work until write support works.

I could set milestones based on specific libsvn_fs APIs, but once I've
got the metadata cloned over I don't think any individual operation
will be particularly difficult in itself (they'd all be just giving a
view of the /tree/ in the .git-svn branch)

>  >   = Bidirectional svn:execute and svn:ignore conversion.
>  >   = Copyfrom and file property information needs to be recorded
>  >   = Test importing a largish repository (without converting merge information)
>  >     to git (the svn toplevel stuff would be left as-is in the git tree)
>  >   = Consider developing git-svn-fs on a git-svn-fs repository itself for
>  >     testing purposes
>
>  An honourable notion, but I'd steer away from worrying about
>  self-hosting, if it is irrelevant to the task at hand.  Focus more on a
>  finding a good test suite to check you supported all the operations.
>  Eg, can the test suite bundled with the Subversion project run against
>  your back-end?

Once commits work, I think it should be possible to get it working
(it's already engineered to support two backends). svnadmin create
support might be needed as well though.

>  > * Standard toplevel SVN layout (trunk/ tags/ branches/)
>  >   = SVN branch creation might come a bit later
>  >   = Test importing a largish repository with tags and branches carried across
>  >     (might not efficiently support copy-from information)
>  > * Merge information annotation (git->svn)
>  >   = Try to guess the copy source for a new tag or branch - and for merges
>
>  I don't like this word "guess".  It might be dangerous to not
>  deterministically or repeatably answer a request.  If any random
>  decisions were made, or information derived based on things that might
>  change, then it should be stored in your mapping information branch.  In
>  this instance, we didn't 'guess', we decided.

Indeed, it would be saved by creating subversion commits (recorded in
the .git-svn branch as changes to /tree etc) corresponding to any
changes to branches or tags. The reason I say 'guess' is because,
since git commits are not unique, it is difficult to attribute them to
a single branch. eg:

branch2     C
           /
branch1   B-D
         /
master  A---E

Commit 'B' would have to be attributed to one or the other of branch1
or branch2, but given just the final state of (C,D,E) we can't
uniquely determine which it should go to. Thus some kind of heuristic
will be needed. Merges can be worse:

branch    D-----E
         /     / \
master  A-----B---C

If commit 'E' is from a remote branch, we won't have enough branches
to go around, and either the merge information would be discarded
(leaving an incomplete view of history), or an automatically-named
branch would need to be made with the history of the other branch.

>  > * Merge information annotation (svn->git)
>  > * Import of a largish repository with svk or similar merge information into git,
>  >   and vice versa (eg, exporting git.git with merge tracking as a subversion
>  >   repo)
>
>  Whew!  That's a lot of big milestones, but it's your summer ... :)
>
>  I think the merging thing is a nice-to-have, and doing it would just
>  prove that you can use the metadata that you have collected well.

Okay, I think I'll move some of the milestones into 'nice to have, but
might run out of time' then :)



On Thu, Mar 20, 2008 at 12:56 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Bryan Donlan <bdonlan@gmail.com> wrote:
>  > I'm planning to apply for the git summer of code project. My proposal
>  > is based on the project idea of a subversion gateway for git,
>  > implemented with a new subversion filesystem layer. A draft of my
>  > proposal follows; I'd appreciate any comments/questions on it before
>  > the application period proper begins.
>
>  Very cool.  Have you had a chance to look at the prototype python
>  implementation of an SVN server that Julian Phillips started?
>
>   http://git.q42.co.uk/w/git_svn_server.git
>
>  I'm just curious what your take is regarding this approach.  Why
>  would you choose to construct libsvn-fs-git over a standalone server?
>  There are several advantages and drawbacks to both approaches.
>  I am not advocating over the other, but want to make sure you have
>  thought it through for yourself.

The main reason is generality - I want to give the user the choice of
svn://, http://, or even (for testing, I hope) file:// access to the
repository. Also, it may be possible to convert a subversion
repository to git with just a svnadmin load, once sufficient support
is in place.

Allowing the svn server and repository access layer to go in front of
the git filesystem also lets me benefit from any sanity checks in
there, hopefully reducing the impact of any possible security bugs.

Finally, it seems a bit simpler of an API than the libsvn_ra API that
svnserve wraps. For one, I don't need to keep track of the client's
working copy state, nor to I need to mess with non-blocking IO to
avoid deadlocks.

>  > I intend to support the following:
>  > * Full or near full (possibly forbidding modification of the toplevel
>  > trunk/ branches/ tags/ structure) read/write access from subversion
>
>  That's probably the only sane way to go about it; disallow read/write
>  on the top level, map whatever branch "HEAD" points to in Git to the
>  trunk/, put the other branches in branches/ and the tags under tags/.
>  Block everything else.

It'd be nice to unblock later, to allow svnadmin load to effectively
convert a svn repository to git.

>  > * Support for syncing svn:executable with git file mode information
>  > * Representation of git merge data using svk:merge and/or svn:mergeinfo
>  > * Syncing .gitignore and svn:ignore data
>
>  These are gravy.  Sure they are going to be difficult to make work,
>  but people can limp by without them.  Most users who want an SVN
>  client to speak to a Git repository are trying to do so from a
>  platform that does not honor executable bits (hi Windows!) and
>  telling users to edit the funny ".gitignore" file to alter ignore
>  lists is something they can work around without too much trouble
>  if they are already able to modify and commit files.
>
>  Though their clients won't provide the proper ignore support out
>  of the box.  *sigh*

Mhm, perhaps I'll move this to a later (would-be-nice-if-there's-time)
milestone then.

>  > As both subversion and git are written in C, this driver will also be in C.
>
>  I think you may have underestimated the challenges associated with
>  linking "libgit.a" (which is _not_ a library) with SVN.  Critical
>  routines within libgit that you want to be able to invoke will do
>  not so nice things like leak massive amounts of memory or cause
>  your process to terminate if the function is fed an invalid input.
>
>  Most of the C code of Git is designed for single-shot execution.
>  We leak memory like mad because it is more efficient to load up what
>  we need, exit, and let the OS just return the pages to the free pool.
>  Long running processes have simply not been something we do.

Mmm, and on further inspection there's global variables everywhere, no
locking, and what looks like not much support for multiple git
directories. I might have to skip libgit and just write my own code to
access the git object store - subversion requires thread safety, and
support for opening multiple filesystems (or even the same filesystem
multiple times).

>  > My current plan for storing the additional information the subversion side will
>  > need (fileprops, revprops, copyfrom information...) is to create an additional
>  > branch on the git repository (possibly .git-svn or similar) to hold the
>  > necessary metadata. Configuration, including author maps, branch/tag maps,
>  > etc, would be on another branch (git-svn-config or similar).
>  >
>  > The layout might look like this:
>  >
>  > /tree/{trunk/,branches/,tags/} - the tree as svn currently sees it
>
>  I don't think you'd want to put a copy of the tree inside of a tree,
>  as this can then get out of sync with changes made directly through
>  git, plus you run into issues about connecting the two histories
>  together in a meaningful way.
>
>  I would suggest having the root directory of the SVN tree be built
>  on the fly based upon the list of available branches and tags in
>  the Git repository (aka the output of git-show-ref).

Subversion absolutely requires that revisions be immutable - the
client will do things like present the server with a revision number
and ask for all changes since then. As such, once we decide what a
revision looks like, we must record that and use the same tree in the
future. Explicitly saving the tree seemed to me like the most
effective way to do that - and it also means many of the filesystem
access APIs can simply directly inspect this git tree.

As for synchronization, it'll be necessary to explicitly convert git
commits to subversion revisions anyway, as actions such as making a
new branch, which in git doesn't need a new commit, do require a copy
operation and commit in subversion.

>  > /props/{trunk/,branches/,tags/} - file properties; props on directories will be
>  >   represented with a reserved filename (._GIT-SVN-DIRPROPS perhaps)
>  >   copyfrom information might be in /props, or in a seperate tree
>
>  How critical are file properties to an SVN client for proper
>  functioning?  Given the challenges already in front of you for this
>  project I would almost encourage you to avoid dealing with file
>  level properties.  Its hard enough to make something that speaks SVN
>  on the wire but reads/writes Git on disk, not to mention you have
>  to somehow "flatten" the Git DAG down into a sequential revision
>  namespace to make the SVN clients happy.  So deferring property
>  support until later may be wise.

Okay. Property support is probably not too difficult, but I see no
problem with moving it to a later milestone.

>  > /revprops/NNN - revision properties for the given revision number
>
>  Ditto.  Aside from the special merge properties you mentioned,
>  I wonder if you can simply avoid implementing support for these
>  early on.

Merge properties are actually file properties. Revprops are needed for
svn log support; they store the commit message, author, and date at
the least. It may be possible to get the subversion client limping
along without them though.

>  > /revmap/NNN - a reference to the commit hash in the .git-svn branch
>  >   corresponding to the given subversion revision number
>
>  How about using a simple flat file interface?  To initially prime
>  the file you can do something like:
>
>         git rev-list --topo-order --date-order --reverse --all >.git/svn-map
>
>  and then number the revisions by the line number that they appear on.
>  Locating a Git SHA-1 for a specific SVN revision would be a simple
>  case of lseek(fd, 41 * rev, SEEK_SET).  Going the other direction
>  would be more of a challenge, but is still doable.
>
>  Updating the file should just require appending new commits; if
>  the SVN client wants a new commit you append on and return the
>  line number.  If Git has caused new commits not in this file you
>  need to rebuild the log.  This would have to be done incrementally,
>  to prevent changing a prior SVN revision number that clients may
>  already know about.

Hm, yes, that does seem a better way. Actually since the canonical
revision numbers are in the commits on the metadata branch anyway,
this can just be a cache, and not part of the git tree itself.



On Thu, Mar 20, 2008 at 2:18 AM, Harvey Harrison
<harvey.harrison@gmail.com> wrote:
> On Thu, 2008-03-20 at 00:56 -0400, Shawn O. Pearce wrote:
>  > Bryan Donlan <bdonlan@gmail.com> wrote:
>
> > > /revmap/NNN - a reference to the commit hash in the .git-svn branch
>  > >   corresponding to the given subversion revision number
>  >
>  > How about using a simple flat file interface?  To initially prime
>  > the file you can do something like:
>  >
>  >       git rev-list --topo-order --date-order --reverse --all >.git/svn-map
>  >
>  > and then number the revisions by the line number that they appear on.
>  > Locating a Git SHA-1 for a specific SVN revision would be a simple
>  > case of lseek(fd, 41 * rev, SEEK_SET).  Going the other direction
>  > would be more of a challenge, but is still doable.
>  >
>  > Updating the file should just require appending new commits; if
>  > the SVN client wants a new commit you append on and return the
>  > line number.  If Git has caused new commits not in this file you
>  > need to rebuild the log.  This would have to be done incrementally,
>  > to prevent changing a prior SVN revision number that clients may
>  > already know about.
>
>  Why not just copy the rev_map format git-svn already uses, it's pretty
>  efficient.

2008/3/20 Jakub Narebski <jnareb@gmail.com>:
>  By the way, have you looked into what git-svn uses? IIRC it had some
>  improvements to avoid spending more disk space on SVN revno <-> Git SHA-1
>  mapping than on the repository itself...

git-svn's rev_map format's designed to support gaps in revision
numbers. Since I need to record all revisions, the four-byte revision
number field can go - but apart from that, that seems fine for the
revision map cache.

On Thu, Mar 20, 2008 at 5:22 AM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> On Thu, 20 Mar 2008, Shawn O. Pearce wrote:
>
>  > Bryan Donlan <bdonlan@gmail.com> wrote:

>  >> /props/{trunk/,branches/,tags/} - file properties; props on directories will be
>  >>   represented with a reserved filename (._GIT-SVN-DIRPROPS perhaps)
>  >>   copyfrom information might be in /props, or in a seperate tree
>  >
>  > How critical are file properties to an SVN client for proper
>  > functioning?  Given the challenges already in front of you for this
>  > project I would almost encourage you to avoid dealing with file
>  > level properties.  Its hard enough to make something that speaks SVN
>  > on the wire but reads/writes Git on disk, not to mention you have
>  > to somehow "flatten" the Git DAG down into a sequential revision
>  > namespace to make the SVN clients happy.  So deferring property
>  > support until later may be wise.
>
>  You might need to get svn:eol-style working to prevent the svn client from
>  munging any binary files?  Can't think of any other vital properties atm.

The subversion client won't touch your binaries /unless/ svn:eol-style
is set. If I just return an empty set of properties it'll leave them
alone.

Dealing with eol-style in particular is somewhat hard with git - it
works by transforming the file into a canonical end-of-line style on
the client before sending it to the server, and transforming back when
it's checked out. I don't know how it'd behave if someone on the git
side commited with a different eol style than it expects.

>
>
>  >> /revprops/NNN - revision properties for the given revision number
>  >
>  > Ditto.  Aside from the special merge properties you mentioned,
>  > I wonder if you can simply avoid implementing support for these
>  > early on.
>
>  Since you have to explicitly enable revprop editing in the subversion
>  repository by enabling a hook script, I should think that this was
>  definately something that could be left at the bottom of the TODO list ...
>
>  Though you do need to be able to convert commit info into the appropriate
>  revprops (e.g. commit msg -> svn:log revprop)

Right, and at that point adding full revprop editing ought not to be too hard.


Anyway, I'll rework my milestones a bit before I submit the proper
proposal. Also, after looking at libgit in a bit more detail, I think
it might be necessary to not use it after all, as subversion requires
support for multiple open repositories, as well as thread safety (at
least when accessing different open repo from different threads).
Perhaps a thread-safe git library would be a nice SoC project as well?
:)

Thanks for the feedback,

Bryan Donlan
