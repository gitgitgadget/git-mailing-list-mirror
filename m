From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [SoC] egit: pre-proposal, problem recognition
Date: Sun, 23 Mar 2008 03:52:41 -0400
Message-ID: <20080323075241.GL8410@spearce.org>
References: <47E532DD.7030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gsoc@spearce.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 08:53:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdL1O-0008Ht-OE
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 08:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbYCWHwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 03:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYCWHwq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 03:52:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57200 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbYCWHwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 03:52:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JdL0T-0005FW-Oq; Sun, 23 Mar 2008 03:52:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 164B720FBAE; Sun, 23 Mar 2008 03:52:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47E532DD.7030901@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77871>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> 
> Let's start from some clean-up:
> http://git.or.cz/gitwiki/EclipsePluginWishlist - isn't this site a 
> little outdated? It appears that tasks: Commit, Switch Branch (without 
> dirty workspace/merge support) are already done, aren't they?

Yea, I think you may be right.  I haven't been too current on egit
lately, but I think these did get implemented.  Sometimes the wiki
is out of date.  Happens because we would rather be working on code
than updating the wiki.  :)

> Some operations look for me as rather straight-forward to implement - 
> not appropriate for a whole GSoC project (or do I underestimate?). 
> Namely: Create/Delete Branch, Create/Delete Tag, Gitignore, Checkout(?).

I think you are right.  Doing all of them might be a GSoC project,
but a lot of it is just busy work and not that interesting of a
challenge.  Sure, it has to be done by someone, and everyone will
appreciate the effort once its complete, especially if its done well.
But doing just one of them as a GSoC project would be too small.

> GSoC2008 site states, that most wanted tasks are (that's reasonable) 
> Push and Merge implementation. Fetch operation also looks to be not 
> implemented yet?

Fetch and clone are in progress.  Robin Rosenburg (the current egit
maintainer) has it just about finished and will probably contribute
it soon.  But I think its going to cause merge conflicts with my own
revwalk work.  So that's why fetch isn't on the GSoC 2008 ideas list.

> So what can I do:
> I think that 1-2 from 3 main jgit+egit tasks (Push, Fetch, Merge) appear 
> to be well-sized for a GSoC project. IMO, there is also need for a lot 
> of smaller improvements in egit itself: preferences, preference page, 
> user-friendliness related: more icons and information, help in dialogs, 
> wizards, menus etc. I'm thinking of taking 1 main task - implementing 
> first jgit part, then egit part. And if I finish it before time, I could 
> work on set of such smaller improvements in egit itself, to make it 
> easier/nicer for user.

Yes, I agree with that, except no fetch, as it will hopefully merge
before GSoC summer officially starts.  A lot of the polish you are
talking about leaving to the end of the project is critical for any
good GUI.  I would not mind seeing it worked once the major features
are completed.

I did want to start on push work myself.  But if a student comes
along and does it for me, then awesome. :)

> operation) as main-task, but Merge also looks interesting. What is more, 
> I perceive Merge and Fetch operations as most wanted, because being on 
> project critical-path, blocking implementation of other tasks. Merge 
> seems also to be used very often itself.

Yes.  Lots of interesting git features (cherry-pick, revert, rebase)
are heavily based upon diff/apply and merge.  diff/apply can be
implemented in terms of merge in many cases, and we do that a lot
in C Git. So we do really need a working merge implementation.
 
> Current implementation status:
> There is currently no Eclipse (GUI, workspace logic) code directly for 
> each of main tasks.
> What about jgit? I haven't looked at details of implementation yet 
> (sorry, I'm starting), but...

Yea, aside from fetch there is no support yet in jgit for any of
the main tasks you were talking about, and the fetch part hasn't
merged to the public egit tree yet.

> For Fetch or Push: I'll need to implement protocol(s) for sure: git, ssh 
> protocols first as wiki-recommends - wisely, I think. What about support 
> from jgit internals: do I need to add some git structures implementation 
> to accomplish Fetch or Push: like object packing, needed objects 
> tracking?

The object packing (aka git-pack-objects in Java) is required
for push.  Object tracking to feed the packer is almost finished
in my revwalk branch, which also has not merged yet.  I started
that work to improve the performance and feature capabilities of
the History view, but its also to provide the object enumeration
functions required for the packfile generator, which is needed for
push to be implemented.

> Or is almost everything available, so I just need to use this 
> structures and concentrate on upload/receive operation and protocol 
> implementation?

Some of it is there.  The packer isn't, and the packer is a key
part of the protocol.  Its what is actually doing the data transfer.
The command part of the protocol is actually fairly simple, and is
even easier on the push side (the fetch side is more complex).

> I've got also some doubts 
> concerning SSH vs git access protocols. Are git-receive-pack and 
> git-upload-pack used by both of these access protocols? If so, it make 
> things easier:)

Yes.  If you dig into the C implementation what we are actually doing for
fetch over SSH is:

	ssh user@hostname git-upload-pack path/to/project.git

and for push:

	ssh user@hostname git-receive-pack path/to/project.git

Now the git:// native protocol just opens a TCP connection to a
server running git-daemon, sends the service name and directory
(which is the last args you see above to SSH), and then the daemon
executes that program.  After that point the SSH vs. native Git
are identical.  The major reason for SSH wrapping is its obvious
security benefits.  The major reason for the native Git protocol
is efficient anonymous publication, especially for popular open
source projects.

> For Merge: I'll need to implement 3-way merge algorithm. Wiki says that 
> one can look at Eclipse, if it is already implemented there. IMHO it's 
> better to implement it at jgit level, independently of egit, basing on 
> original git implementation, don't you think (I've seen that there are 
> some efforts to implement git plugin for NetMeans, basing on jgit 
> library)? I wonder how laborious this task is, i.e. as for Fetch/Push: 
> does translation of this algorithm written in C to Java requires 
> significant changes or improvements to existing jgit code?

Yea, I wrote that statement about using merge code from Eclipse,
but lately I have been thinking that is a bad idea.  Another person
has stated to talk about using jgit to build a Git NetBeans plugin,
and in another case there may be some idea of compiling jgit to
CLR and using it for a Git Mono plugin.

There is currently little-to-no merge support in jgit.  All of it
needs to be ported in, or obtained from a suitable Java library that
we can embed and ship as part of the package.  C Git for example
embeds and ships libxdiff for most of its diff/merge code.
 
> What do you think about importance of each task and what is your feeling 
> about time needed to implement each?

I think merge is a huge task, especially if you have to do your own
file level merge implementation by porting in say libxdiff to Java.
Focusing on merge may take the better part (or all!) of a GSoC
summer, but if you finished early then I would suggest doing the
much needed UI additions like you discussed above.
 
> I've got some experiences with JSch (bad experience...) and Trilead SSH 
> (much more postive) - BSD-licensed SSH implementations for Java.

Interesting that JSch wasn't a good experience.  Eclipse has just made it
an official part of the core platform, even without the IDE and its CVS
plugin.  I was sort of hoping that given it is now fully integrated into
Eclipse, and its key management is just part of the workspace, that we
could take advantage of that in egit.
 
> To this time I was working on many smaller projects, and one bigger (>1 
> year, BSc and grids related), mostly in small teams, sometimes 
> distributed. It seems to be great experience if I can join git community:)

You can join any time.  GSoC is just a good execuse.  :)

> PS BTW: I've wonder what "Checkpoint project" in Eclipse Team menu 
> stands for?

That's my fault.  A long time ago egit stored the workspace back
out as trees, rather than using the standard .git/index file.
It was slow and cost a lot of time, so I tried to put that activity
onto a low priority background job.  The job caused more problems,
so Robin got rid of it.  But the menu option to allow the user to
force a checkpoint is still there.

A checkpoint lets egit construct a tree object for the current
files, so a commit is faster as all of the blobs are already in the
object store.  But with the index and add (aka stage) now in egit,
and the commit dialog, that is less of an issue as the tree gets
created from the index, which you already staged files into.

In short, that menu option needs to come out at some point.

-- 
Shawn.
