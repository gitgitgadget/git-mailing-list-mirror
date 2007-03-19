From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] glossary: clean up cross-references
Date: Sun, 18 Mar 2007 23:18:00 -0400
Message-ID: <14903.6772003912$1174274345@news.gmane.org>
References: <117427428145-git-send-email-> <1174274281887-git-send-email-> <11742742813855-git-send-email-> <1174274281258-git-send-email-> <11742742811304-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8Oc-0000J6-FY
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933804AbXCSDSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933801AbXCSDSN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:18:13 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45764 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933804AbXCSDSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:18:06 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8Nl-0003Jd-TK; Sun, 18 Mar 2007 23:18:01 -0400
X-Mailer: git-send-email 1.5.0.3.g6c05
In-Reply-To: <11742742811304-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42573>

From: J. Bruce Fields <bfields@citi.umich.edu>

Manual clean-up of cross-references, and also clean up a few definitions (e.g.
git-rebase).

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/glossary.txt |   58 ++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 82e17db..2465514 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -13,7 +13,7 @@ GIT Glossary
 	<<def_revision,revision>> control. That is, all of the `git`
 	administrative and control files that would normally be present in the
 	hidden `.git` sub-directory are directly present in the
-	`<<def_repository,repository>>.git` <<def_directory,directory>> instead,
+	`repository.git` directory instead,
 	and no other files are present and checked out. Usually publishers of
 	public repositories make bare repositories available.
 
@@ -23,7 +23,7 @@ GIT Glossary
 [[def_branch]]branch::
 	A non-cyclical graph of revisions, i.e. the complete history of a
 	particular <<def_revision,revision>>, which is called the
-	<<def_branch,branch>> <<def_head,head>>. The <<def_branch,branch>> heads
+	branch <<def_head,head>>. The heads
 	are stored in `$GIT_DIR/refs/heads/`.
 
 [[def_cache]]cache::
@@ -133,7 +133,7 @@ GIT Glossary
 	together by recording fake ancestry information for commits. This way
 	you can make git pretend the set of parents a <<def_commit,commit>> has
 	is different from what was recorded when the <<def_commit,commit>> was
-	created. Configured via the `.git/info/<<def_grafts,grafts>>` file.
+	created. Configured via the `.git/info/grafts` file.
 
 [[def_hash]]hash::
 	In git's context, synonym to <<def_object_name,object name>>.
@@ -205,7 +205,7 @@ GIT Glossary
 
 [[def_object_type]]object type::
 	One of the identifiers
-	"<<def_commit,commit>>","<<def_tree,tree>>","<<def_tag,tag>>" and "blob"
+	"<<def_commit,commit>>","<<def_tree,tree>>","<<def_tag,tag>>" or "<<def_blob_object,blob>>"
 	describing the type of an <<def_object,object>>.
 
 [[def_octopus]]octopus::
@@ -217,7 +217,7 @@ GIT Glossary
 	at least one upstream project which they track. By default
 	'<<def_origin,origin>>' is used for that purpose. New upstream updates
 	will be fetched into remote tracking branches named
-	<<def_origin,origin>>/name-of-upstream-branch, which you can see using
+	origin/name-of-upstream-branch, which you can see using
 	"git <<def_branch,branch>> -r".
 
 [[def_pack]]pack::
@@ -271,14 +271,15 @@ GIT Glossary
 	<<def_reachable,reachable>> from that <<def_commit,commit>>. More
 	generally, one <<def_object,object>> is <<def_reachable,reachable>> from
 	another if we can reach the one from the other by a <<def_chain,chain>>
-	that follows tags to whatever they <<def_tag,tag>>, commits to their
-	parents or trees, and trees to the trees or blobs that they contain.
+	that follows <<def_tag,tags>> to whatever they tag,
+	<<def_commit_object,commits>> to their parents or trees, and
+	<<def_tree_object,trees>> to the trees or <<def_blob_object,blobs>>
+	that they contain.
 
 [[def_rebase]]rebase::
-	To <<def_clean,clean>> a <<def_branch,branch>> by starting from the
-	<<def_head,head>> of the main line of development
-	("<<def_master,master>>"), and reapply the (possibly cherry-picked)
-	changes from that <<def_branch,branch>>.
+	To reapply a series of changes from a <<def_branch,branch>> to a
+	different base, and reset the <<def_head,head>> of that branch
+	to the result.
 
 [[def_ref]]ref::
 	A 40-byte hex representation of a <<def_SHA1,SHA1>> or a name that
@@ -290,19 +291,18 @@ GIT Glossary
 	<<def_push,push>> to describe the mapping between remote <<def_ref,ref>>
 	and local <<def_ref,ref>>. They are combined with a colon in the format
 	<src>:<dst>, preceded by an optional plus sign, +. For example: `git
-	<<def_fetch,fetch>> $URL
-	refs/heads/<<def_master,master>>:refs/heads/<<def_origin,origin>>` means
-	"grab the <<def_master,master>> <<def_branch,branch>> <<def_head,head>>
-	from the $URL and store it as my <<def_origin,origin>>
+	fetch $URL refs/heads/master:refs/heads/origin` means
+	"grab the master <<def_branch,branch>> <<def_head,head>>
+	from the $URL and store it as my origin
 	<<def_branch,branch>> <<def_head,head>>". And `git <<def_push,push>>
-	$URL refs/heads/<<def_master,master>>:refs/heads/to-upstream` means
-	"publish my <<def_master,master>> <<def_branch,branch>>
+	$URL refs/heads/master:refs/heads/to-upstream` means
+	"publish my master <<def_branch,branch>>
 	<<def_head,head>> as to-upstream <<def_branch,branch>> at $URL". See
 	also gitlink:git-push[1]
 
 [[def_repository]]repository::
 	A collection of refs together with an <<def_object_database,object
-	database>> containing all objects, which are <<def_reachable,reachable>>
+	database>> containing all objects which are <<def_reachable,reachable>>
 	from the refs, possibly accompanied by meta data from one or more
 	porcelains. A <<def_repository,repository>> can share an
 	<<def_object_database,object database>> with other repositories.
@@ -334,12 +334,12 @@ GIT Glossary
 	object>>). This is sometimes useful when you are interested only in the
 	recent history of a project even though the real history recorded in the
 	upstream is much larger. A <<def_shallow_repository,shallow repository>>
-	is created by giving `--depth` option to gitlink:git-clone[1], and its
-	history can be later deepened with gitlink:git-fetch[1].
+	is created by giving the `--depth` option to gitlink:git-clone[1], and
+	its history can be later deepened with gitlink:git-fetch[1].
 
 [[def_symref]]symref::
 	Symbolic reference: instead of containing the <<def_SHA1,SHA1>> id
-	itself, it is of the format '<<def_ref,ref>>: refs/some/thing' and when
+	itself, it is of the format 'ref: refs/some/thing' and when
 	referenced, it recursively dereferences to this reference. 'HEAD' is a
 	prime example of a <<def_symref,symref>>. Symbolic references are
 	manipulated with the gitlink:git-symbolic-ref[1] command.
@@ -347,11 +347,11 @@ GIT Glossary
 [[def_tag]]tag::
 	A <<def_ref,ref>> pointing to a <<def_tag,tag>> or
 	<<def_commit_object,commit object>>. In contrast to a <<def_head,head>>,
-	a <<def_tag,tag>> is not changed by a <<def_commit,commit>>. Tags (not
-	<<def_tag,tag>> objects) are stored in `$GIT_DIR/refs/tags/`. A git
-	<<def_tag,tag>> has nothing to do with a Lisp <<def_tag,tag>> (which is
-	called <<def_object_type,object type>> in git's context). A
-	<<def_tag,tag>> is most typically used to mark a particular point in the
+	a tag is not changed by a <<def_commit,commit>>. Tags (not
+	<<def_tag_object,tag objects>>) are stored in `$GIT_DIR/refs/tags/`. A
+	git tag has nothing to do with a Lisp tag (which would be
+	called an <<def_object_type,object type>> in git's context). A
+	tag is most typically used to mark a particular point in the
 	<<def_commit,commit>> ancestry <<def_chain,chain>>.
 
 [[def_tag_object]]tag object::
@@ -383,7 +383,7 @@ GIT Glossary
 
 [[def_tree_object]]tree object::
 	An <<def_object,object>> containing a list of file names and modes along
-	with refs to the associated blob and/or <<def_tree,tree>> objects. A
+	with refs to the associated blob and/or tree objects. A
 	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
 
 [[def_tree-ish]]tree-ish::
@@ -393,8 +393,8 @@ GIT Glossary
 	<<def_tree_object,tree object>>.
 
 [[def_unmerged_index]]unmerged index::
-	An <<def_index,index>> which contains <<def_unmerged_index,unmerged
-	index>> entries.
+	An <<def_index,index>> which contains unmerged
+	<<def_index_entry,index entries>>.
 
 [[def_unreachable_object]]unreachable object::
 	An <<def_object,object>> which is not <<def_reachable,reachable>> from a
-- 
1.5.0.3.31.ge47c
