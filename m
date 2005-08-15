From: Ryan Anderson <ryan@michonline.com>
Subject: Git 1.0 Synopis (Draft v4)
Date: Mon, 15 Aug 2005 00:55:46 -0400
Message-ID: <20050815045546.GA7001@mythryan2.michonline.com>
References: <20050729082941.GD32263@mythryan2.michonline.com> <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 15 06:56:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4X0t-0003uT-UL
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 06:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVHOEzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 00:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVHOEzu
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 00:55:50 -0400
Received: from mail.autoweb.net ([198.172.237.26]:723 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750952AbVHOEzt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 00:55:49 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E4X0l-0001AQ-NL; Mon, 15 Aug 2005 00:55:47 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E4X0k-0002KM-00; Mon, 15 Aug 2005 00:55:46 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E4X0k-0000Di-Mw; Mon, 15 Aug 2005 00:55:46 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 31, 2005 at 06:15:40PM -0400, Horst von Brand wrote:
> Ryan Anderson <ryan@michonline.com> wrote:
> > Source Code Management with Git
> 
> More bugging...

Ok, I think I've got all this addressed (plus the other email).

It just took me a lot longer to get to it than I planned.

Junio, do you want to pull this into the git tree?  (I'll reply with a
patch)

==========

Source Code Management with git

In Linus's own words as the creator of git:
"git" can mean anything, depending on your mood.

 - random three-letter combination that is pronounceable, and not
   actually used by any common UNIX command.  The fact that it is a
   mispronunciation of "get" may or may not be relevant.
 - stupid. contemptible and despicable. simple. Take your pick from the
   dictionary of slang.
 - "global information tracker": you're in a good mood, and it actually
   works for you. Angels sing, and a light suddenly fills the room. 
 - "goddamn idiotic truckload of sh*t": when it breaks

git is a "directory content manager".  git has been designed to handle
absolutely massive projects with speed and efficiency, and the release of the
2.6.12 and (soon) the 2.6.13 version of the Linux kernel would indicate that it
does this task well.

git falls into the category of distributed source code management tools,
similar to Arch or Darcs (or, in the commercial world, BitKeeper).  Every git
working directory is a full-fledged repository with full revision tracking
capabilities, not dependent on network access to a central server.

git provides a content-addressable pseudo filesystem, complete with its own
version of fsck.

  o Speed of use, both for the project maintainer, and the end-users, is
    a key development principle.

  o The history is stored as a directed acyclic graph, making long-lived
    branches and repeated merging simple.

  o The core git project considers itself to provide "plumbing" for other
     projects, as well as to serve to arbitrate for compatibility between them.
     The project built on top of the core git are referred to as "porcelain".
     Stgit, Cogito, qgit, gitk and gitweb are all building upon the core git
     tools, and providing an easy to use interface to various pieces of
     functionality.

  o Some other projects have taken the concepts from the core git project, and
    are either porting an existing toolset to use the git tools, or
    reimplementing the concepts internally, to benefit from the performance
     improvements.  This includes both Arch 2.0, and Darcs-git.
  
  o Two, interchangeable, on-disk formats are used:
    o An efficient, packed format that saves space and network
      bandwidth.
    o An unpacked format, optimized for fast writes and incremental
      work.

To get a copy of git:
	Daily snapshots are available at:
	http://www.codemonkey.org.uk/projects/git-snapshots/git/
	(Thanks to Dave Jones)

	Source tarballs and RPMs at:
	http://www.kernel.org/pub/software/scm/git/

	Debian packages should be availabe in unstable (sid) as "git-core"

	Or via git itself:
	git clone http://www.kernel.org/pub/scm/git/git.git/ <local directory>
	git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ <local directory>

	(rsync is generally faster for an initial clone, you can switch later
	by editing .git/branches/origin and changing the url)

To get the 'Porcelain' tools mentioned above:
	SCM Interface layers:
	cogito - http://www.kernel.org/pub/software/scm/cogito/

	Patch Management (similar to Quilt):
	StGIT - http://www.procode.org/stgit/

	History Visualization:
	gitk - http://ozlabs.org/~paulus/gitk/ (Included in the standard git
		distribution)
	gitweb - http://www.kernel.org/pub/software/scm/gitweb/
	qgit - http://sourceforge.net/projects/qgit


git distributions contain a tutorial in the Documentation subdirectory.
Additionally, the Kernel-Hacker's git Tutorial at
http://linux.yyz.us/git-howto.html may be useful.  (Thanks to Jeff Garzik for
that document)

git development takes place on the git mailing list.  To subscribe, send an
email with just "subscribe git" in the body to majordomo@vger.kernel.org.
Mailing list archives are available at http://marc.theaimsgroup.com/?l=git

(This summary written by Ryan Anderson <ryan@michonline.com>.  Please bug him
with any corrections or complaints.)


-- 

Ryan Anderson
  sometimes Pug Majere
