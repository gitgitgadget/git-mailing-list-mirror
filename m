From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: 26 Oct 2008 15:15:57 +0100
Message-ID: <m3r663h276.fsf@localhost.localdomain>
References: <ge0rla$mce$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 15:17:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku6Qr-0002ES-Rw
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 15:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbYJZOQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 10:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYJZOQP
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 10:16:15 -0400
Received: from main.gmane.org ([80.91.229.2]:43833 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbYJZOQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 10:16:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ku6Pb-0005M3-2r
	for git@vger.kernel.org; Sun, 26 Oct 2008 14:16:11 +0000
Received: from abxb216.neoplus.adsl.tpnet.pl ([83.8.251.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 14:16:11 +0000
Received: from jnareb by abxb216.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 14:16:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git,gmane.comp.version-control.mercurial.general
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxb216.neoplus.adsl.tpnet.pl
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99163>

[Cc: gmane.comp.version-control.git,
     gmane.comp.version-control.mercurial.general]

walt <w41ter@gmail.com> writes:

> No, no, I'm not the one calling for a vote.  You old-timers here
> will know the name Matt Dillon, who is leading the dragonflybsd
> project (www.dragonflybsd.org).
> 
> Matt is the one who is calling for the vote in his thread "Vote
> for your source control system" in the dragonfly.kernel group,
> accessible via nntp://nntp.dragonflybsd.org.
> 
> I've already cast my vote for git, which I confess is not very
> honest because I've never even tried mercurial.  I would truly
> be grateful to anyone here who knows both git and mercurial who
> could contribute verifiable facts to that debate.

I also used only Git, but I have read a bit about Mercurial; however
the information I have on Mercurial might be out of date.

Below I have tried to compare Git with Mercurial, pointing the most
important (to me) facts:

1. Documentation and ease of use. 

   Mercurial is supposedly better documented and easier to use; I
   think this descends from the early days of Git, where it was not
   very user friendly. IMHO Git has much improved since.  Mercurial
   had 'hgbook' from the beginning; Git User's Manual is more recent.

   I also think that ease of use is just different learning curve.
   I am also biased and I think that Mercurial starts easy, but it has
   more difficult things (like e.g. merging, multiple branches in
   single repository etc.) harder than it Git.

   I'll admit that Mercurial UI is better designed; Git UI was not as
   much designed as it evolved from 'stupid content tracker' to
   full-featured SCM, therefore there are a few oddities (for example
   git-revert might do not what you expect, if you are accustomed to
   Subversion UI).

2. Implementation, portability, bindings and extending

   Mercurial is implemented in Python, with core written in C for
   better performance.  It has a plugin system, and additional extra
   features implemented through extensions.  I don't know what is the
   status of bindings (or implementations) in other programming
   languages; but it has some API for use in extensions at least.

   Git is implemented as mixture of C, shell scripts, Perl and Tcl/Tk
   (for GUI).  The main way of extending it is by scripting around
   powerfull set of low level tools, called 'plumbing', meant to be
   used in scripts.  JGit is for example _reimplementation_ of Git in
   Java.

3. Repository design and performance.

   Git is designed around idea of content adressed object database;
   objects are adressed by their content (by SHA-1 of their type and
   content).  Commits for example have information about author and
   comitter, pointer to zero or more parent commits, and pointer to
   tree object (representing top directory in project).  Branches
   and tags are just pointers to DAG (Direct Acyclic Graph) of
   commits; current branch is denoted by HEAD pointer to branch.
   There is explicit staging area called 'index', used for conflict
   resolution dureing merges, and which can be used to make commit in
   stages, allow uncomitted changes in tree (in working directory).
   Git design supports very well multiple branches in single
   repository, and tracking changes in multiple remote repositories
   each with multiple branches.

   Mercurial, from what I have read of its documentation, and from the
   few discussion on #revctrl IRC channel, and from what I understand
   is based on changes stored per file, with information about files
   and their versions stored in manifest (flat) file, and with changes
   described in changelog-like file (changerev).  One of limitations
   of "record" database (as opposed to Git's object database) is that
   commits can have zero (root commit), one or two (merge commits)
   parents only.  There is apparent in design that Mercurial was
   developed with single branch per repository paradigm in mind.
   Local branches from what I understand are marked in CVS-like
   fashion using tags.  Tags are implemented as either local to
   repository and untransferable, or as .hgtags versioned file with
   special case treatment.  (But I'm obviously biased here).

   Git and Mercurial have similar performance, although it is thought
   that due to design Mercurla has faster patch applying and is
   optimized for cold cache case, while Git has faster merging and is
   optimized for warm cache case.

   Mercurial may have (or had) problems with larger binary files, from
   what I have heard.

3. Advanced features, interfaces and tools

   I don't know much about Mercurial beside basic usage, what I
   remember from 'hgbook', but I think that most if not all advanced
   Git features are available either in Mercurial core, or as
   Mercurial extensions (plugins).

   For example both Git and Mercurial have bisect command for finding
   bug by searching (possibly nonlinear) history for commit which
   introduced bug, ForestExtension is rough equivalent of git
   submodules (or third party git-externals), there is Transplain
   extension for git-rebase, etc.

   Mercurial has hgserve which can function as both web repository
   browser and as anonymous server; in Git they are split between
   git-daemon for anonymous repository access, and gitweb (or other
   web interfaces: cgit, git-php, ViewGit, Gitorious,..) for web
   interface.

   NOTE: In Git repacking and garbage collecting is explicit
   (although can be automated with "git gc --auto", and some of it
   happens automatically); Git use _rename detection_ rather than
   _rename tracking_, which has its advantages and disadvantages.


They are many articles comparing Mercurial and Git; if they are blog
posts please read the comments too.  Among them are:
* "Git vs. Mercurial: Please Relax" (Git is MacGyver, Mercurial
   is James Bond)
  http://importantshock.wordpress.com/2008/08/07/git-vs-mercurial/
* "The Differences Between Mercurial and Git"
  http://www.rockstarprogrammer.org/post/2008/apr/06/differences-between-mercurial-and-git/
* "Git vs. Mercurial"
  http://blog.experimentalworks.net/archives/38-Git-vs.-Mercurial.html
* "Git versus Mercurial..."
  http://codeheadsystems.wordpress.com/2008/05/10/git-versus-mercurial/
* "Git vs Mercurial"
  http://www.simplicidade.org/notes/archives/2007/12/git_vs_mercuria_1.html

Note however that the comparison at "Better SCM Initiative" has some
wrong information about Git: see
* "Git at Better SCM Initiative comparison of VCS (long)"
  http://thread.gmane.org/gmane.comp.version-control.git/95809/focus=97253
-- 
Jakub Narebski
Poland
ShadeHawk on #git
