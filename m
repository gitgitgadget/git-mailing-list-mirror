From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Subject: [PATCH] Assorted changes to glossary
Date: Thu, 18 Aug 2005 03:20:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508180319320.25908@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Aug 18 03:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Zah-0003IZ-Er
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 03:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVHRBwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 21:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVHRBwz
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 21:52:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30095 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932081AbVHRBwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 21:52:54 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AA13D10646C; Thu, 18 Aug 2005 03:47:14 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8BDAAB0958; Thu, 18 Aug 2005 03:47:14 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5FCBDB0941; Thu, 18 Aug 2005 03:47:14 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 93619FB646; Thu, 18 Aug 2005 03:20:08 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Based on the discussion on the git list, here are some important changes
to the glossary. (There is no cache, but an index. Use "object name"
rather than "SHA1". Reorder. Clarify.)

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 Documentation/glossary.txt |  104 ++++++++++++++++++++++++++------------------
 1 files changed, 61 insertions(+), 43 deletions(-)

8d8a819f8f1d93c460c0b76a006f1a3830fb1f06
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -3,21 +3,27 @@ object::
 	the SHA1 of its contents. Consequently, an object can not
 	be changed.
 
+object name::
+	The unique identifier of an object. The hash of the object's contents
+	using the Secure Hash Algorithm 1 and usually represented by the 40
+	character hexadecimal encoding of the hash of the object (possibly
+	followed by a white space).
+
 SHA1::
-	A 20-byte sequence (or 41-byte file containing the hex
-	representation and a newline). It is calculated from the
-	contents of an object by the Secure Hash Algorithm 1.
+	Synonym for object name.
+
+object identifier::
+	Synonym for object name.
+
+hash::
+	In git's context, synonym to object name.
 
 object database::
 	Stores a set of "objects", and an individial object is identified
-	by its SHA1 (its ref). The objects are either stored as single
-	files, or live inside of packs.
-
-object name::
-	Synonym for SHA1.
+	by its object name. The object usually live in $GIT_DIR/objects/.
 
 blob object::
-	Untyped object, i.e. the contents of a file.
+	Untyped object, e.g. the contents of a file.
 
 tree object::
 	An object containing a list of blob and/or tree objects.
@@ -29,42 +35,43 @@ tree::
 	dependent blob and tree objects (i.e. a stored representation
 	of a working tree).
 
-cache::
-	A collection of files whose contents are stored as objects.
-	The cache is a stored version of your working tree. Well, can
-	also contain a second, and even a third version of a working
-	tree, which are used when merging.
+index::
+	A collection of files with stat information, whose contents are
+	stored as objects. The cache is a stored version of your working
+	tree. Truth be told, it can also contain a second, and even a third
+	version of a working tree, which are used when merging.
 
-cache entry::
+index entry::
 	The information regarding a particular file, stored in the index.
-	A cache entry can be unmerged, if a merge was started, but not
+	An index entry can be unmerged, if a merge was started, but not
 	yet finished (i.e. if the cache contains multiple versions of
 	that file).
 
-index::
-	Contains information about the cache contents, in particular
-	timestamps and mode flags ("stat information") for the files
-	stored in the cache. An unmerged index is an index which contains
-	unmerged cache entries.
+unmerged index:
+	An index which contains unmerged index entries.
+
+cache::
+	Obsolete for: index.
 
 working tree::
-	The set of files and directories currently being worked on.
-	Think "ls -laR"
+	The set of files and directories currently being worked on,
+	i.e. you can work in your working tree without using git at all.
 
 directory::
 	The list you get with "ls" :-)
 
-checkout::
-	The action of updating the working tree to a revision which was
-	stored in the object database.
-
 revision::
 	A particular state of files and directories which was stored in
 	the object database. It is referenced by a commit object.
 
+checkout::
+	The action of updating the working tree to a revision which was
+	stored in the object database.
+
 commit::
-	The action of storing the current state of the cache in the
+	As a verb: The action of storing the current state of the cache in the
 	object database. The result is a revision.
+	As a noun: Short hand for commit object.
 
 commit object::
 	An object which contains the information about a particular
@@ -72,14 +79,15 @@ commit object::
 	tree object which corresponds to the top directory of the
 	stored revision.
 
+parent::
+	A commit object contains a (possibly empty) list of the logical
+	predecessor(s) in the line of development, i.e. its parents.
+
 changeset::
 	BitKeeper/cvsps speak for "commit". Since git does not store
 	changes, but states, it really does not make sense to use
 	the term "changesets" with git.
 
-ent::
-	Favorite synonym to "tree-ish" by some total geeks.
-
 clean::
 	A working tree is clean, if it corresponds to the revision
 	referenced by the current head.
@@ -94,13 +102,12 @@ head::
 
 branch::
 	A non-cyclical graph of revisions, i.e. the complete history of
-	a particular revision, which does not (yet) have children, which
-	is called the branch head. The branch heads are stored in
-	$GIT_DIR/refs/heads/.
+	a particular revision, which is called the branch head. The
+	branch heads are stored in $GIT_DIR/refs/heads/.
 
 ref::
 	A 40-byte hex representation of a SHA1 pointing to a particular
-	object. These are stored in $GIT_DIR/refs/.
+	object. These may be stored in $GIT_DIR/refs/.
 
 head ref::
 	A ref pointing to a head. Often, this is abbreviated to "head".
@@ -108,7 +115,10 @@ head ref::
 
 tree-ish::
 	A ref pointing to either a commit object, a tree object, or a
-	tag object pointing to a commit or tree object.
+	tag object pointing to a tag or commit or tree object.
+
+ent::
+	Favorite synonym to "tree-ish" by some total geeks.
 
 tag object::
 	An object containing a ref pointing to another object. It can
@@ -120,6 +130,8 @@ tag::
 	a tag is not changed by a commit. Tags (not tag objects) are
 	stored in $GIT_DIR/refs/tags/. A git tag has nothing to do with
 	a Lisp tag (which is called object type in git's context).
+	A tag is most typically used to mark a particular point in the
+	commit ancestry chain.
 
 merge::
 	To merge branches means to try to accumulate the changes since a
@@ -133,9 +145,18 @@ resolve::
 
 repository::
 	A collection of refs together with an object database containing
-	all objects, which are reachable from the refs. A repository can
+	all objects, which are reachable from the refs, possibly accompanied
+	by meta data from one or more porcelains. A repository can
 	share an object database with other repositories.
 
+git archive::
+	Synonym for repository (for arch people).
+
+file system::
+	Linus Torvalds originally designed git to be a user space file
+	system, i.e. the infrastructure to hold files and directories.
+	That ensured the efficiency and speed of git.
+
 alternate object database::
 	Via the alternates mechanism, a repository can inherit part of its
 	object database from another object database, which is called
@@ -150,10 +171,6 @@ chain::
 	reference to its successor (for example, the successor of a commit
 	could be one of its parents).
 
-parent::
-	A commit object contains a (possibly empty) list of the logical
-	predecessor(s) in the line of development, i.e. its parents.
-
 fetch::
 	Fetching a branch means to get the branch's head ref from a
 	remote repository, to find out which objects are missing from
@@ -176,8 +193,8 @@ pack::
 	space or to transmit them efficiently).
 
 pack index::
-	Contains offsets into a pack, so the pack can be used instead of
-	the unpacked objects.
+	The list of identifiers, and other information, of the objects in a
+	pack, to assist in efficiently accessing the contents of a pack. 
 
 plumbing::
 	Cute name for core git.
@@ -196,3 +213,4 @@ SCM::
 
 dircache::
 	You are *waaaaay* behind.
+
