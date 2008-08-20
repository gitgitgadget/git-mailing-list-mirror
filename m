From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] Teach "git diff -p" Python funcname patterns
Date: Wed, 20 Aug 2008 19:57:07 +0400
Message-ID: <1219247827-8742-1-git-send-email-kirr@mns.spb.ru>
Cc: Kirill Smelkov <kirr@mns.spb.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 18:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVqfh-0002Ea-C2
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 18:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbYHTQf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 12:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbYHTQf2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 12:35:28 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:33594 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbYHTQf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 12:35:28 -0400
X-Greylist: delayed 2210 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Aug 2008 12:35:27 EDT
Received: from [192.168.0.130] (helo=tugrik2.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1KVq4z-0004vE-5O; Wed, 20 Aug 2008 19:58:37 +0400
Received: from kirr by tugrik2.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@mns.spb.ru>)
	id 1KVq3X-0002HO-AG; Wed, 20 Aug 2008 19:57:07 +0400
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92993>

Finds classes and functions/methods. The pattern is adapted from the
ruby one.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 Documentation/gitattributes.txt |    2 ++
 diff.c                          |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index db16b0c..a8e29d6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -318,6 +318,8 @@ patterns are available:
 
 - `ruby` suitable for source code in the Ruby language.
 
+- `python` suitable for source code in the Python language.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/diff.c b/diff.c
index 10d5440..91d5a0a 100644
--- a/diff.c
+++ b/diff.c
@@ -1395,6 +1395,7 @@ static struct builtin_funcname_pattern {
 	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
 	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
+	{ "python", "^\\s*\\(\\(class\\|def\\)\\s.*\\)$" },
 };
 
 static const char *diff_funcname_pattern(struct diff_filespec *one)
-- 
1.5.6.3
