From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: revise top of git man page
Date: Sun, 2 Apr 2006 17:54:34 -0400
Message-ID: <20060402215434.GA22707@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 23:54:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQAWv-0007j7-4F
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 23:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWDBVyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 17:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWDBVyh
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 17:54:37 -0400
Received: from mail.fieldses.org ([66.93.2.214]:37306 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964790AbWDBVyg
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 17:54:36 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1FQAWp-0001nU-2Z; Sun, 02 Apr 2006 17:54:35 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18289>

I'm afraid I'll be accused of trying to suck all the jokes and the
personality out of the git documentation.  I'm not!  Really!

That said, "man git" is one of the first things a new user is likely try,
and it seems a little cruel to start off with a somewhat obscure joke
about the architecture of git.

So instead I'm trying for a relatively straightforward description of what
git does, and what features distinguish it from other systems, together
with immediate links to introductory documentation.

I also did some minor reorganization in an attempt to clarify the
classification of commands.  And revised a bit for conciseness (as is
obvious from the diffstat--hopefully I didn't cut anything important).

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 Documentation/git.txt |  103 +++++++++++++++++++++++--------------------------
 1 files changed, 48 insertions(+), 55 deletions(-)

9fc3b77b82004356a6e5fa19e5e31a2b19f088d3
diff --git a/Documentation/git.txt b/Documentation/git.txt
index fe34f50..06b2e53 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,10 +12,14 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-'git' is both a program and a directory content tracker system.
-The program 'git' is just a wrapper to reach the core git programs
-(or a potty if you like, as it's not exactly porcelain but still
-brings your stuff to the plumbing).
+Git is a fast, scalable, distributed revision control system with an
+unusually rich command set that provides both high-level operations
+and full access to internals.
+
+See this link:tutorial.html[tutorial] to get started, then see
+link:everyday.html[Everyday Git] for a useful minimum set of commands, and
+"man git-commandname" for documentation of each command.  CVS users may
+also want to read link:cvs-migration.html[CVS migration].
 
 OPTIONS
 -------
@@ -35,55 +39,38 @@ OPTIONS
 	the current setting and then exit.
 
 
-NOT LEARNING CORE GIT COMMANDS
-------------------------------
+FURTHER DOCUMENTATION
+---------------------
+
+See the references above to get started using git.  The following is
+probably more detail than necessary for a first-time user.
+
+The <<Discussion,Discussion>> section below and the
+link:core-tutorial.html[Core tutorial] both provide introductions to the
+underlying git architecture.
+
+See also the link:howto-index.html[howto] documents for some useful
+examples.
+
+GIT COMMANDS
+------------
 
-This manual is intended to give complete background information
-and internal workings of git, which may be too much for most
-people.  The <<Discussion>> section below contains much useful
-definition and clarification - read that first.
-
-If you are interested in using git to manage (version control)
-projects, use link:tutorial.html[The Tutorial] to get you started,
-and then link:everyday.html[Everyday GIT] as a guide to the
-minimum set of commands you need to know for day-to-day work.
-Most likely, that will get you started, and you can go a long
-way without knowing the low level details too much.
-
-The link:core-tutorial.html[Core tutorial] document covers how things
-internally work.
-
-If you are migrating from CVS, link:cvs-migration.html[cvs
-migration] document may be helpful after you finish the
-tutorial.
-
-After you get the general feel from the tutorial and this
-overview page, you may want to take a look at the
-link:howto-index.html[howto] documents.
-
-
-CORE GIT COMMANDS
------------------
-
-If you are writing your own Porcelain, you need to be familiar
-with most of the low level commands --- I suggest starting from
-gitlink:git-update-index[1] and gitlink:git-read-tree[1].
-
-
-Commands Overview
------------------
-The git commands can helpfully be split into those that manipulate
-the repository, the index and the files in the working tree, those that
-interrogate and compare them, and those that moves objects and
-references between repositories.
-
-In addition, git itself comes with a spartan set of porcelain
-commands.  They are usable but are not meant to compete with real
-Porcelains.
-
-There are also some ancillary programs that can be viewed as useful
-aids for using the core commands but which are unlikely to be used by
-SCMs layered over git.
+We divide git into high level ("porcelain") commands and low level
+("plumbing") commands.
+
+Low-level commands (plumbing)
+-----------------------------
+
+Although git includes its
+own porcelain layer, its low-level commands are sufficient to support
+development of alternative porcelains.  Developers of such porcelains
+might start by reading about gitlink:git-update-index[1] and
+gitlink:git-read-tree[1].
+
+We divide the low-level commands into commands that manipulate objects (in
+the repository, index, and working tree), commands that interrogate and
+compare objects, and commands that move objects and references between
+repositories.
 
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
@@ -248,8 +235,14 @@ gitlink:git-upload-pack[1]::
 	what are asked for.
 
 
-Porcelain-ish Commands
-----------------------
+High-level commands (porcelain)
+-------------------------------
+
+We separate the porcelain commands into the main commands and some
+ancillary user utilities.
+
+Main porcelain commands
+~~~~~~~~~~~~~~~~~~~~~~~
 
 gitlink:git-add[1]::
 	Add paths to the index.
@@ -346,7 +339,7 @@ gitlink:git-whatchanged[1]::
 
 
 Ancillary Commands
-------------------
+~~~~~~~~~~~~~~~~~~
 Manipulators:
 
 gitlink:git-applypatch[1]::
-- 
1.2.4.g0382
