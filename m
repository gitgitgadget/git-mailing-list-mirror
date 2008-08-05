From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/6] Mark completed items (commit, fetch, push, graphic log) in TODO file
Date: Mon,  4 Aug 2008 19:47:13 -0700
Message-ID: <1217904436-1989-4-git-send-email-spearce@spearce.org>
References: <1217904436-1989-1-git-send-email-spearce@spearce.org>
 <1217904436-1989-2-git-send-email-spearce@spearce.org>
 <1217904436-1989-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCbU-0006tq-5D
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbYHECr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757512AbYHECr0
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:47:26 -0400
Received: from george.spearce.org ([209.20.77.23]:45377 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbYHECrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:47:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 76C9B38447; Tue,  5 Aug 2008 02:47:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id ADECE38368;
	Tue,  5 Aug 2008 02:47:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217904436-1989-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91412>

These are done and don't need to be mentioned anymore.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 README |    3 --
 TODO   |   66 ----------------------------------------------------------------
 2 files changed, 0 insertions(+), 69 deletions(-)

diff --git a/README b/README
index a10b8d4..db11c25 100644
--- a/README
+++ b/README
@@ -177,9 +177,6 @@ For some operations it may just be the preferred solution also. There
 are not just a command line, there is e.g. git-gui that makes committing
 partial files simple.
 
-- GIT network protocol to pull objects from a remote repository or
-  push objects to a remote repository.
-
 - Merging. 
 
 - Repacking from within the plugin.
diff --git a/TODO b/TODO
index a7ef2b9..5f35b25 100644
--- a/TODO
+++ b/TODO
@@ -3,27 +3,6 @@
 Now that we have some basic features in the Eclipse plugin, we need
 to focus on making it usable by average users doing daily tasks.
 
-== Commit ==
-
-Commit all (or selected) files to current branch.
-
-This feature is trivial if the repository is fully mounted within
-Eclipse, as Eclipse has the entire working tree available, making
-it easy to write out the blobs and tree objects needed to form the
-root tree for the new commit.
-
-Its less easy when the repository is not fully mounted within
-Eclipse.  (See for example the egit repository itself; the
-repository has 3 projects in it so Eclipse doesn't see the top
-level directory.)  In this case egit needs to preseve the files
-that are currently either in HEAD or in the index for the parts
-of the tree it cannot see, while using the files it has in memory
-for the parts of the tree that it can see.  In this latter case I'm
-thinking that preserving HEAD rather than the index is the right way
-to go here, as jgit does not play nicely with core Git's index file.
-Consequently users should be discouraged from trying to create a
-commit based on the results of both tools.
-
 == Create Branch ==
 
 Create a new branch from any revision specification.
@@ -48,29 +27,6 @@ preventing the switch or doing an implicit commit when the working
 directory is dirty) without having to worry about merging. ''--
 Steven Grimm''
 
-== Fetch ==
-
-Fetching changes from a remote repository into a tracking branch.
-Aka "git fetch".
-
-I'd like to keep egit/jgit 100% pure Java, to make it easier to
-install the plugin on a wide varity of systems.  This means we
-need to implement a good amount of code for the network protocol
-and the --objects-edge feature of rev-list.  Although a lot to code
-its probably only slightly more effort than forking out to run git
-fetch and deal with its error conditions.
-
-Fetching over SSH should be possible through the jsch library
-included in Eclipse; this is what CVS uses for its SSH2 connections.
-Fetching from a local directory should just be a matter of creating a
-Repository object on that directory path (no need to fork a process
-like core Git does).
-
-Initially I'd like to stay away from the commit walkers (e.g. HTTP).
-Actually supporting them is likely a really good argument for at
-least making it possible for the user to configure jgit to invoke
-"git fetch" in an external process.
-
 == Merge ==
 
 Merging changes from one local branch to another.
@@ -82,28 +38,6 @@ available, or do what core Git just did and implement a 3 way in
 memory merge algorithm.  git-merge-recursive is only 1336 lines of C
 so it should not be too difficult to port the algorithm to pure Java.
 
-== Push ==
-
-Pushing changes to a remote repository.
-
-A lot like fetch, we should be able to support the native Git
-protocol for SSH based push, and for local directory access we just
-need to mount the other repository as a new Repository object and
-copy the object data from one to the other.  Probably easier than
-it is for core Git.
-
-As far as packing data over the network goes I don't want to
-implement the binary delta algorithm in pure Java right now.  So this
-means we would send packs containing only whole objects (no deltas).
-This shouldn't really be an issue for the receiving end, except
-that we will have a slightly higher network transfer cost coming
-from egit than if core Git was used to push the same set of objects.
-
-== Graphical History Viewer ==
-
-A graphical history viewer similar to gitk or qgit, but in SWT/JFace
-so it can run within the Eclipse workbench.
-
 == SVN Integration ==
 
 It would be swell -- but put it at the bottom of your priority list
-- 
1.6.0.rc1.250.g9b5e2
