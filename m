From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2] gitattributes.txt: Path matching rules are explained
 in gitignore.txt
Date: Wed, 25 Feb 2009 08:54:42 +0100
Message-ID: <49A4F942.1090907@viscovery.net>
References: <1235462493-8761-1-git-send-email-j6t@kdbg.org> <7vskm4jkbk.fsf@gitster.siamese.dyndns.org> <49A3BD25.3000706@viscovery.net> <7vskm3hh8n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 08:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcEcx-0005pO-9m
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 08:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbZBYHyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 02:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757764AbZBYHyy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 02:54:54 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35406 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945AbZBYHyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 02:54:54 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LcEbK-0004BE-Rf; Wed, 25 Feb 2009 08:54:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8CCF3A865; Wed, 25 Feb 2009 08:54:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vskm3hh8n.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111384>

From: Johannes Sixt <j6t@kdbg.org>

The rules how the patterns are matched against path names are the same
for .gitattribute and .gitignore files.

This also replace the notion "glob pattern" by "pattern" because
gitignore.txt talks about "glob" only in some contexts where the pattern
is mentioned.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Junio C Hamano schrieb:
 > Actually, while I was responding to your message, I looked at
 > gitattributes documentation and noticed that it does not say anything
 > about how the "glob" is used to match paths.

 Here's a patch.

 -- Hannes

 Documentation/gitattributes.txt |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 227934f..55668e3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -18,10 +18,10 @@ A `gitattributes` file is a simple text

 Each line in `gitattributes` file is of form:

-	glob	attr1 attr2 ...
+	pattern	attr1 attr2 ...

-That is, a glob pattern followed by an attributes list,
-separated by whitespaces.  When the glob pattern matches the
+That is, a pattern followed by an attributes list,
+separated by whitespaces.  When the pattern matches the
 path in question, the attributes listed on the line are given to
 the path.

@@ -48,13 +48,14 @@ Set to a value::

 Unspecified::

-	No glob pattern matches the path, and nothing says if
+	No pattern matches the path, and nothing says if
 	the path has or does not have the attribute, the
 	attribute for the path is said to be Unspecified.

-When more than one glob pattern matches the path, a later line
+When more than one pattern matches the path, a later line
 overrides an earlier line.  This overriding is done per
-attribute.
+attribute.  The rules how the pattern matches paths are the
+same as in `.gitignore` files; see linkgit:gitignore[5].

 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
-- 
1.6.2.rc0.81.g1e300
