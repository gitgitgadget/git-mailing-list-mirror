From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Grammar and wording fixes in gitrepository-layout
Date: Fri, 19 Aug 2011 22:43:07 -0400
Message-ID: <1313808187-1666-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 20 05:32:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QucIV-00087h-Qm
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 05:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab1HTD1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 23:27:24 -0400
Received: from jerry.cquest.utoronto.ca ([192.82.128.5]:45595 "EHLO
	jerry.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab1HTD1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 23:27:24 -0400
X-Greylist: delayed 2640 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Aug 2011 23:27:24 EDT
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:39340 ident=93)
	by jerry.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QubWh-0002bH-It; Fri, 19 Aug 2011 22:43:11 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QubWh-0000RN-Hs; Fri, 19 Aug 2011 22:43:11 -0400
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179751>

This patch corrects a few grammar issues in gitrepository-layout.txt
and also rewords a few sections for clarity.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Documentation/gitrepository-layout.txt |   46 +++++++++++++++----------------
 1 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index eb3d040..02a6167 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -23,32 +23,30 @@ objects::
 	Object store associated with this repository.  Usually
 	an object store is self sufficient (i.e. all the objects
 	that are referred to by an object found in it are also
-	found in it), but there are couple of ways to violate
-	it.
+	found in it), but there are a few ways to violate it.
 +
 . You could populate the repository by running a commit walker
-without `-a` option.  Depending on which options are given, you
+without `-a` option.  Depending on the options given, you
 could have only commit objects without associated blobs and
 trees this way, for example.  A repository with this kind of
 incomplete object store is not suitable to be published to the
-outside world but sometimes useful for private repository.
+outside world but is sometimes useful in a private repository.
 . You also could have an incomplete but locally usable repository
-by cloning shallowly.  See linkgit:git-clone[1].
-. You can be using `objects/info/alternates` mechanism, or
-`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanism to 'borrow'
+by creating a shallow clone.  See linkgit:git-clone[1].
+. You could be using the `objects/info/alternates` or
+`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanisms to 'borrow'
 objects from other object stores.  A repository with this kind
 of incomplete object store is not suitable to be published for
-use with dumb transports but otherwise is OK as long as
-`objects/info/alternates` points at the right object stores
-it borrows from.
+use with dumb transports but is otherwise OK as long as
+`objects/info/alternates` points at the right object stores.
 
 objects/[0-9a-f][0-9a-f]::
 	Traditionally, each object is stored in its own file.
-	They are split into 256 subdirectories using the first
-	two letters from its object name to keep the number of
-	directory entries `objects` directory itself needs to
-	hold.  Objects found here are often called 'unpacked'
-	(or 'loose') objects.
+	The objects are splayed over 256 subdirectories using
+	the first two characters of the sha1 object name to
+	keep the number of directory entries in `objects`
+	itself to a manageable number. Objects found
+	here are often called 'unpacked' (or 'loose') objects.
 
 objects/pack::
 	Packs (files that store many object in compressed form,
@@ -85,7 +83,7 @@ objects/info/http-alternates::
 
 refs::
 	References are stored in subdirectories of this
-	directory.  The 'git prune' command knows to keep
+	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
 	its subdirectories.
 
@@ -120,15 +118,15 @@ HEAD::
 HEAD can also record a specific commit directly, instead of
 being a symref to point at the current branch.  Such a state
 is often called 'detached HEAD', and almost all commands work
-identically as normal.  See linkgit:git-checkout[1] for
+as they normally would.  See linkgit:git-checkout[1] for
 details.
 
 branches::
 	A slightly deprecated way to store shorthands to be used
-	to specify URL to 'git fetch', 'git pull' and 'git push'
-	commands is to store a file in `branches/<name>` and
-	give 'name' to these commands in place of 'repository'
-	argument.
+	to specify a URL to 'git fetch', 'git pull' and 'git push'.
+	A file can be stored as `branches/<name>` and then
+	'name' can be givent to these commands in place of
+	'repository' argument.
 
 hooks::
 	Hooks are customization scripts used by various git
@@ -173,9 +171,9 @@ info/exclude::
 	at it.  See also: linkgit:gitignore[5].
 
 remotes::
-	Stores shorthands to be used to give URL and default
-	refnames to interact with remote repository to
-	'git fetch', 'git pull' and 'git push' commands.
+	Stores shorthands for URL and default refnames for use
+	when interacting with remote repositories via 'git fetch',
+	'git pull' and 'git push' commands.
 
 logs::
 	Records of changes made to refs are stored in this
-- 
1.7.4.1
