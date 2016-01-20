From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Documentation: remove unnecessary backslashes
Date: Wed, 20 Jan 2016 09:21:37 -0800
Message-ID: <1453310497-7971-1-git-send-email-kraai@ftbfs.org>
Cc: Matthew Kraai <matt.kraai@abbott.com>
To: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 18:38:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLwid-000633-54
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 18:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934625AbcATRiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 12:38:51 -0500
Received: from 46-22-115-26.ip.axbyte.se ([46.22.115.26]:38921 "EHLO
	kvm.ftbfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934158AbcATRit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 12:38:49 -0500
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2016 12:38:49 EST
Received: from kraai by kvm.ftbfs.org with local (Exim 4.84)
	(envelope-from <kraai@ftbfs.org>)
	id 1aLwS6-00025D-4a; Wed, 20 Jan 2016 09:21:50 -0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284456>

From: Matthew Kraai <matt.kraai@abbott.com>

asciidoctor does not remove backslashes used to escape curly brackets from
the HTML output if the contents of the curly brackets are empty or contain
at least a <, -, or space.  asciidoc does not require the backslashes in
these cases, so just remove them.

Signed-off-by: Matthew Kraai <matt.kraai@abbott.com>
Reported-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d85e303..fa4bdb2 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -61,11 +61,11 @@ some output processing may assume ref names in UTF-8.
 '@'::
   '@' alone is a shortcut for 'HEAD'.
 
-'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
+'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
-  pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
-  second ago\}' or '\{1979-02-26 18:30:00\}') specifies the value
+  pair (e.g. '\{yesterday\}', '{1 month 2 weeks 3 days 1 hour 1
+  second ago}' or '{1979-02-26 18:30:00}') specifies the value
   of the ref at a prior point in time.  This suffix may only be
   used immediately following a ref name and the ref must have an
   existing log ('$GIT_DIR/logs/<ref>'). Note that this looks up the state
@@ -73,7 +73,7 @@ some output processing may assume ref names in UTF-8.
   'master' branch last week. If you want to look at commits made during
   certain times, see '--since' and '--until'.
 
-'<refname>@\{<n>\}', e.g. 'master@\{1\}'::
+'<refname>@{<n>}', e.g. 'master@\{1\}'::
   A ref followed by the suffix '@' with an ordinal specification
   enclosed in a brace pair (e.g. '\{1\}', '\{15\}') specifies
   the n-th prior value of that ref.  For example 'master@\{1\}'
@@ -82,13 +82,13 @@ some output processing may assume ref names in UTF-8.
   immediately following a ref name and the ref must have an existing
   log ('$GIT_DIR/logs/<refname>').
 
-'@\{<n>\}', e.g. '@\{1\}'::
+'@{<n>}', e.g. '@\{1\}'::
   You can use the '@' construct with an empty ref part to get at a
   reflog entry of the current branch. For example, if you are on
   branch 'blabla' then '@\{1\}' means the same as 'blabla@\{1\}'.
 
-'@\{-<n>\}', e.g. '@\{-1\}'::
-  The construct '@\{-<n>\}' means the <n>th branch/commit checked out
+'@{-<n>}', e.g. '@{-1}'::
+  The construct '@{-<n>}' means the <n>th branch/commit checked out
   before the current one.
 
 '<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
@@ -139,7 +139,7 @@ from one location and push to another. In a non-triangular workflow,
   '<rev>{caret}1{caret}1{caret}1'.  See below for an illustration of
   the usage of this form.
 
-'<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
+'<rev>{caret}{<type>}', e.g. 'v0.99.8{caret}\{commit\}'::
   A suffix '{caret}' followed by an object type name enclosed in
   brace pair means dereference the object at '<rev>' recursively until
   an object of type '<type>' is found or the object cannot be
@@ -159,13 +159,13 @@ it does not have to be dereferenced even once to get to an object.
 'rev{caret}\{tag\}' can be used to ensure that 'rev' identifies an
 existing tag object.
 
-'<rev>{caret}\{\}', e.g. 'v0.99.8{caret}\{\}'::
+'<rev>{caret}{}', e.g. 'v0.99.8{caret}{}'::
   A suffix '{caret}' followed by an empty brace pair
   means the object could be a tag,
   and dereference the tag recursively until a non-tag object is
   found.
 
-'<rev>{caret}\{/<text>\}', e.g. 'HEAD^{/fix nasty bug}'::
+'<rev>{caret}{/<text>}', e.g. 'HEAD^{/fix nasty bug}'::
   A suffix '{caret}' to a revision parameter, followed by a brace
   pair that contains a text led by a slash,
   is the same as the ':/fix nasty bug' syntax below except that
-- 
2.7.0.windows.1
