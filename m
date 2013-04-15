From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 4/4] glossary: improve definitions of refspec and
 pathspec
Date: Mon, 15 Apr 2013 19:50:07 +0200 (CEST)
Message-ID: <1496585271.996545.1366048207561.JavaMail.ngmail@webmail19.arcor-online.net>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 19:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnXk-0004Lc-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933553Ab3DORuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:50:09 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:35432 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755644Ab3DORuI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 13:50:08 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 9FA47BE09E;
	Mon, 15 Apr 2013 19:50:07 +0200 (CEST)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 9431D18F03;
	Mon, 15 Apr 2013 19:50:07 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 8B7888258;
	Mon, 15 Apr 2013 19:50:07 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-16.arcor-online.net 8B7888258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1366048207; bh=+XJhOPG/eJd4ygk9b7xwoGTzLmeLYHoUg94x46bs5YQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ifyyz5nUx4Z3okWRqfkR8xRE2DtwiZKE7KyF6b/ry5u0hZ0HH18xQCynLbshlg3Ws
	 4N6jp2AnexRe6ftjqXrfG1WjqT1xX6C9z6veb+bYtfTW6gxYzooQwdTV5PI2FRG5mO
	 bECgxeoinBNGFvtpFvtJsMsv2Efxsi2uug6a1r4k=
Received: from [188.105.109.185] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Mon, 15 Apr 2013 19:50:07 +0200 (CEST)
In-Reply-To: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.109.185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221272>


The exact definition of "refspec" can be found in git-fetch
and git-push manpages. So don't duplicate this here in the glossary.

Actually the definition of "pathspec" should be moved to a separate
file akin to the way it's done with "refspec". But this will only
be wortwhile when there's more to say about it. So for the time being
just improve the first sentence a little bit; fix the idendation of
the first paragraph after the bullet list and remove the one-item
list of magic signatures with its - for the user - unnecessary
introduction of "magic word 'top'".

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 2734947..c36283c 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -268,7 +268,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	pack.
 
 [[def_pathspec]]pathspec::
-       Pattern used to specify paths.
+	Pattern used to limit paths in Git commands.
 +
 Pathspecs are used on the command line of "git ls-files", "git
 ls-tree", "git add", "git grep", "git diff", "git checkout",
@@ -277,6 +277,8 @@ limit the scope of operations to some subset of the tree or
 worktree.  See the documentation of each command for whether
 paths are relative to the current directory or toplevel.  The
 pathspec syntax is as follows:
++
+--
 
 * any path matches itself
 * the pathspec up to the last slash represents a
@@ -286,11 +288,12 @@ pathspec syntax is as follows:
   of the pathname.  Paths relative to the directory
   prefix will be matched against that pattern using fnmatch(3);
   in particular, '*' and '?' _can_ match directory separators.
+
+--
 +
 For example, Documentation/*.jpg will match all .jpg files
 in the Documentation subtree,
 including Documentation/chapter_1/figure_1.jpg.
-
 +
 A pathspec that begins with a colon `:` has special meaning.  In the
 short form, the leading colon `:` is followed by zero or more "magic
@@ -306,18 +309,10 @@ and a close parentheses `)`, and the remainder is the pattern to match
 against the path.
 +
 The "magic signature" consists of an ASCII symbol that is not
-alphanumeric.
-+
---
-top `/`;;
-	The magic word `top` (mnemonic: `/`) makes the pattern match
-	from the root of the working tree, even when you are running
-	the command from inside a subdirectory.
---
-+
-Currently only the slash `/` is recognized as the "magic signature",
-but it is envisioned that we will support more types of magic in later
-versions of Git.
+alphanumeric. Currently only the slash `/` is recognized as a
+"magic signature": it makes the pattern match from the root of 
+the working tree, even when you are running the command from 
+inside a subdirectory.
 +
 A pathspec with only a colon means "there is no pathspec". This form
 should not be combined with other pathspec.
@@ -389,15 +384,7 @@ should not be combined with other pathspec.
 [[def_refspec]]refspec::
 	A "refspec" is used by <<def_fetch,fetch>> and
 	<<def_push,push>> to describe the mapping between remote
-	<<def_ref,ref>> and local ref. They are combined with a colon in
-	the format <src>:<dst>, preceded by an optional plus sign, +.
-	For example: `git fetch $URL
-	refs/heads/master:refs/heads/origin` means "grab the master
-	<<def_branch,branch>> <<def_head,head>> from the $URL and store
-	it as my origin branch head". And `git push
-	$URL refs/heads/master:refs/heads/to-upstream` means "publish my
-	master branch head as to-upstream branch at $URL". See also
-	linkgit:git-push[1].
+	<<def_ref,ref>> and local ref. 
 
 [[def_remote_tracking_branch]]remote-tracking branch::
 	A regular Git <<def_branch,branch>> that is used to follow changes from
-- 
1.8.1.msysgit.1


---
Thomas
