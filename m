From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] git-shortlog.txt: improve documentation about .mailmap files
Date: Fri, 26 Dec 2008 12:18:03 +0100
Message-ID: <1230290283-6268-1-git-send-email-dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 26 12:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGAj8-0003gA-3N
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 12:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbYLZLSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 06:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbYLZLSH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 06:18:07 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3846
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYLZLSG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 06:18:06 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 5927A8027904;
	Fri, 26 Dec 2008 12:18:04 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGAhf-0001dd-IL; Fri, 26 Dec 2008 12:18:03 +0100
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103932>

The previous .mailmap example made it seem like .mailmap files are only
useful for commits with a wrong address for an author, when they are about
fixing the real name. Explained this better in the text, and replaced the
existing example with a new one that hopefully makes things clearer.
---
 Documentation/git-shortlog.txt |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 7ccf31c..69e10a4 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -48,15 +48,32 @@ OPTIONS
 FILES
 -----
 
-If the file `.mailmap` exists, it will be used for mapping author
-email addresses to a real author name. One mapping per line, first
-the author name followed by the email address enclosed by
-'<' and '>'. Use hash '#' for comments. Example:
+If a file `.mailmap` exists in the toplevel directory of the repository,
+it will be used for mapping author email addresses to a canonical real
+name. This can be used to coalesce together commits by the same person
+where their name was spelled differently (whether with the same email
+address or not).
+
+The format of the file is one mapping per line, first the desired author
+name followed by the email address enclosed by '<' and '>'. Use hash '#'
+for comments. For example, if your history contains commits by these
+committers:
+
+------------
+Author: Joe Developer <joe@random.com>
+Author: Joe R. Developer <joe@random.com>
+Author: Jane Doe <jane@the-does.name>
+Author: Jane Doe <jane@laptop.(none)>
+Author: Jane D. <jane@desktop.(none)>
+------------
+
+Then a proper `.mailmap` file would be:
 
 ------------
-# Keep alphabetized
-Adam Morrow <adam@localhost.localdomain>
-Eve Jones <eve@laptop.(none)>
+# Note how we don't need an entry for <jane@laptop.(none)>, because the
+# real name of that author is correct already, and coalesced directly.
+Jane Doe <jane@desktop.(none)>
+Joe R. Developer <joe@random.com>
 ------------
 
 Author
-- 
1.6.1
