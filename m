From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 2/3] revisions.txt: structure with a labelled list
Date: Mon,  4 Apr 2011 17:27:04 +0200
Message-ID: <b37095f8802face1fc7920359cf2db3536a5d3a2.1301930700.git.git@drmicha.warpmail.net>
References: <cover.1301649867.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 17:30:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6ljx-0007w7-MV
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 17:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab1DDPas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 11:30:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48852 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754814Ab1DDPan (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 11:30:43 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 538F920A61;
	Mon,  4 Apr 2011 11:30:43 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 Apr 2011 11:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=A4BAyppXBWokkSSJPiLY64bc/Ns=; b=ZJ8srp4MZWH4XU0hWpOfkDNSyZlEow91+pT6t8HGEPfjJwafUMMGi1Dlf5GyJuD3S3fjJ+cz0PVyZZRhOsUnnGhUlCVNHCO7IJx+TUZwKkhbEcZiXaXSlYNv5+kPj6EMgOjFKgid0nfjF884E6z25AlU78NS44ITBOViWxVdxRk=
X-Sasl-enc: 4YQqEhXWRYi7Ut5OJDGrA8NDYOXNg/nyW3enD9Ca0olZ 1301931042
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 906584444F4;
	Mon,  4 Apr 2011 11:30:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <cover.1301649867.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1301930700.git.git@drmicha.warpmail.net>
References: <cover.1301930700.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170820>

Currently, the reader has to parse a textual description in order to
find a specific syntax in the list.

Restructure as a labelled list with systematic labels as well as
concrete examples as a visual guide.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/revisions.txt |   86 +++++++++++++++++++++++++-----------------
 1 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index b994bab..92bc662 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -1,23 +1,26 @@
 SPECIFYING REVISIONS
 --------------------
 
-A revision parameter typically, but not necessarily, names a
+A revision parameter '<rev>' typically, but not necessarily, names a
 commit object.  They use what is called an 'extended SHA1'
 syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list are to name trees and
 blobs contained in a commit.
 
-* The full SHA1 object name (40-byte hexadecimal string), or
+'<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
+  The full SHA1 object name (40-byte hexadecimal string), or
   a substring of such that is unique within the repository.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
   name the same commit object if there are no other object in
   your repository whose object name starts with dae86e.
 
-* An output from `git describe`; i.e. a closest tag, optionally
+'<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
+  An output from `git describe`; i.e. a closest tag, optionally
   followed by a dash and a number of commits, followed by a dash, a
   'g', and an abbreviated object name.
 
-* A symbolic ref name.  E.g. 'master' typically means the commit
+'<refname>', e.g. 'master', 'heads/master', 'refs/heads/master'::
+  A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by 'refs/heads/master'.  If you
   happen to have both 'heads/master' and 'tags/master', you can
   explicitly say 'heads/master' to tell git which one you mean.
@@ -30,7 +33,7 @@ blobs contained in a commit.
 
   . otherwise, 'refs/<name>' if exists;
 
-  . otherwise, 'refs/tags/<name>' if exists;
+  . otherwise, 'refs/tags/<refname>' if exists;
 
   . otherwise, 'refs/heads/<name>' if exists;
 
@@ -53,7 +56,8 @@ when you run `git cherry-pick`.
 Note that any of the 'refs/*' cases above may come either from
 the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 
-* A ref followed by the suffix '@' with a date specification
+'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
+  A ref followed by the suffix '@' with a date specification
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
@@ -64,58 +68,68 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   'master' branch last week. If you want to look at commits made during
   certain times, see '--since' and '--until'.
 
-* A ref followed by the suffix '@' with an ordinal specification
+'<refname>@\{<n>\}', e.g. 'master@\{1\}'::
+  A ref followed by the suffix '@' with an ordinal specification
   enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
   the n-th prior value of that ref.  For example 'master@\{1\}'
   is the immediate prior value of 'master' while 'master@\{5\}'
   is the 5th prior value of 'master'. This suffix may only be used
   immediately following a ref name and the ref must have an existing
-  log ('$GIT_DIR/logs/<ref>').
+  log ('$GIT_DIR/logs/<refname>').
 
-* You can use the '@' construct with an empty ref part to get at a
+'@\{<n>\}', e.g. '@\{1\}'::
+  You can use the '@' construct with an empty ref part to get at a
   reflog of the current branch. For example, if you are on the
   branch 'blabla', then '@\{1\}' means the same as 'blabla@\{1\}'.
 
-* The special construct '@\{-<n>\}' means the <n>th branch checked out
+'@\{-<n>\}', e.g. '@\{-1\}'::
+  The special construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
-* The suffix '@\{upstream\}' to a ref (short form 'ref@\{u\}') refers to
+'<refname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
+  The suffix '@\{upstream\}' to a ref (short form '<refname>@\{u\}') refers to
   the branch the ref is set to build on top of.  Missing ref defaults
   to the current branch.
 
-* A suffix '{caret}' to a revision parameter (e.g. 'HEAD{caret}') means the first parent of
+'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
+  A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
-  'rev{caret}'
-  is equivalent to 'rev{caret}1').  As a special rule,
-  'rev{caret}0' means the commit itself and is used when 'rev' is the
+  '<rev>{caret}'
+  is equivalent to '<rev>{caret}1').  As a special rule,
+  '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
   object name of a tag object that refers to a commit object.
 
-* A suffix '{tilde}<n>' to a revision parameter means the commit
+'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
+  A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
-  commit object, following only the first parent.  I.e. rev~3 is
-  equivalent to rev{caret}{caret}{caret} which is equivalent to
-  rev{caret}1{caret}1{caret}1.  See below for a illustration of
+  commit object, following only the first parent.  I.e. '<rev>{tilde}3' is
+  equivalent to '<rev>{caret}{caret}{caret}' which is equivalent to
+  '<rev>{caret}1{caret}1{caret}1'.  See below for a illustration of
   the usage of this form.
 
-* A suffix '{caret}' followed by an object type name enclosed in
-  brace pair (e.g. 'v0.99.8{caret}\{commit\}') means the object
+'<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
+  A suffix '{caret}' followed by an object type name enclosed in
+  brace pair means the object
   could be a tag, and dereference the tag recursively until an
   object of that type is found or the object cannot be
-  dereferenced anymore (in which case, barf).  'rev{caret}0'
-  introduced earlier is a short-hand for 'rev{caret}\{commit\}'.
+  dereferenced anymore (in which case, barf).  '<rev>{caret}0'
+  introduced earlier is a short-hand for '<rev>{caret}\{commit\}'.
 
-* A suffix '{caret}' followed by an empty brace pair
-  (e.g. 'v0.99.8{caret}\{\}') means the object could be a tag,
+'<rev>{caret}\{\}', e.g. 'v0.99.8{caret}\{\}'::
+  A suffix '{caret}' followed by an empty brace pair
+  means the object could be a tag,
   and dereference the tag recursively until a non-tag object is
   found.
 
-* A suffix '{caret}' to a revision parameter followed by a brace
-  pair that contains a text led by a slash (e.g. 'HEAD^{/fix nasty bug}'):
-  this is the same as ':/fix nasty bug' syntax below except that
+'<rev>{caret}\{/<text>\}', e.g. 'HEAD^{/fix nasty bug}'::
+  A suffix '{caret}' to a revision parameter, followed by a brace
+  pair that contains a text led by a slash,
+  is the same as ':/fix nasty bug' syntax below except that
   it returns the youngest matching commit which is reachable from
-  the ref before '{caret}'.
+  the '<rev>' before '{caret}'.
 
-* A colon, followed by a slash, followed by a text (e.g. ':/fix nasty bug'): this names
+':/<text>', e.g. ':/fix nasty bug'::
+  A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
@@ -124,10 +138,11 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   The regular expression can match any part of the commit message. To
   match messages starting with a string, one can use e.g. ':/^foo'.
 
-* A suffix ':' followed by a path (e.g. 'HEAD:README'); this names the blob or tree
+'<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
+  A suffix ':' followed by a path names the blob or tree
   at the given path in the tree-ish object named by the part
   before the colon.
-  ':path' (with an empty part before the colon, e.g. ':README')
+  ':path' (with an empty part before the colon)
   is a special case of the syntax described next: content
   recorded in the index at the given path.
   A path starting with './' or '../' is relative to current working directory.
@@ -135,10 +150,11 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   This is most useful to address a blob or tree from a commit or tree that has
   the same tree structure with the working tree.
 
-* A colon, optionally followed by a stage number (0 to 3) and a
-  colon, followed by a path (e.g. ':0:README'); this names a blob object in the
+':<n>:<path>', e.g. ':0:README', ':README'::
+  A colon, optionally followed by a stage number (0 to 3) and a
+  colon, followed by a path, names a blob object in the
   index at the given path. Missing stage number (and the colon
-  that follows it, e.g. ':README') names a stage 0 entry. During a merge, stage
+  that follows it) names a stage 0 entry. During a merge, stage
   1 is the common ancestor, stage 2 is the target branch's version
   (typically the current branch), and stage 3 is the version from
   the branch being merged.
-- 
1.7.4.2.668.gba03a4
