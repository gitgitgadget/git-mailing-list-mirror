From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 0/3] Request for help: graph-based UI
Date: Sun, 12 Jul 2009 16:46:49 +0200 (CEST)
Message-ID: <cover.1247408350u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, robin.rosenberg@dewire.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 12 16:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ0In-0002r3-Jw
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 16:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZGLOo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 10:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbZGLOoy
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 10:44:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:40458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752197AbZGLOoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 10:44:54 -0400
Received: (qmail invoked by alias); 12 Jul 2009 14:44:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 12 Jul 2009 16:44:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FspsBXmrFVnrhGeKPthwbiRWQ8wFweGtD4SmP+w
	Y1DDQHx5bE+UHC
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123149>

Hi,

unfortunately, the GSoC project for the graph-based UI failed.

Unwilling to give up on the idea, I ask you for help to make it become 
a reality, though.

The basic concept is this: show the user a graph instead of a list of 
objects.  This should make things much more intuitive, especially when the 
user can not only see the history, but "make" it in this UI, too!

Just imagine being able to drag 'n drop a commit onto HEAD, and it is 
cherry-picked.  Or drag 'n drop files or directories onto the window, and 
you see the history filtered to see only commits touching those files or 
directories.

Things like that are as near in the future as you make it.

Don't be intimidated by the size of the overall patch; almost half of it 
are license boiler-plates.

Now, as for some low-hanging fruits I can think of, here is a short list:

- I am crap at annotation, so that is lacking.

- I am crap at documentation, so that is lacking.

- It should be possible to read the commits on demand (maybe in the 
  background, too, with a MIN_PRIORITY thread).

- At the moment, only (part of) the commit subject is shown.  It would be 
  nice to have tooltips for the full subject, maybe a panel that shows the 
  full commit metadata, and maybe make it configurable what is to be shown 
  in the boxes to begin with.

- The boxes could be resizable, automatically resizing the graph.

- Coloring commits provides a very nice way to convey additional 
  information; I could imagine that it would be nice to have a color 
  coding of authors, for example.

- It should be possible to reinitialize the GraphWalk with different 
  options/refs.

- I am developing using vi and bash, but that is not the way most Java 
  developers work; Eclipse seems to be the most popular development 
  platform.  There should be a little how-to for people wanting to hack on 
  JGit GUI.

- The commits are shown in a rigid grid.  Maybe it would be nice to be 
  able to rearrange them interactively.  Or to make that grid less rigid?  
  (Well, the latter is not so low-hanging anymore...)

- Nothing in the GUI let's you access the file revisions of the commits 
  yet.  What would be the most intuitive interface for that?

- I have a rudimentary diff implementation in my repository 
  (http://repo.or.cz/w/jgit/dscho.git where you can find the "gui"  
  branch, too) which could be used to show the diffs corresponding to the 
  commits.

Interested?

Ciao,
Dscho

Johannes Schindelin (3):
  Add a rudimentary graph-based user interface
  Add license boiler-plates
  Introduce the command 'jgit gui'

 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Gui.java              |  100 +++++++++++
 .../src/org/spearce/jgit/gui/CommitGraph.java      |   64 +++++++
 .../src/org/spearce/jgit/gui/CommitGrid.java       |  184 ++++++++++++++++++++
 .../src/org/spearce/jgit/gui/CommitPainter.java    |   80 +++++++++
 .../src/org/spearce/jgit/gui/CommitRow.java        |   69 ++++++++
 .../src/org/spearce/jgit/gui/GraphCommit.java      |   78 ++++++++
 .../src/org/spearce/jgit/gui/GraphWalk.java        |   73 ++++++++
 8 files changed, 649 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Gui.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java
