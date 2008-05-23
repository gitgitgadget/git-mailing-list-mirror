From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 20/23] Added the class NoGitRepositoryFoundException.
Date: Fri, 23 May 2008 22:34:29 +0200
Message-ID: <1211574872-23676-21-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze04-0006CA-JT
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759178AbYEWUfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759155AbYEWUfK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:10 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45503 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019AbYEWUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:44 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 1A863DC4A2D4
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:43 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyM-0005iq-01; Fri, 23 May 2008 22:34:42 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19MiTR0QkKEQFwpQ9eAxb2LIYQvKD4eEnfRQABB
	V9bsWAmL8NVpH3l16v7vGYcZhhzgDVqv6FRc8OrAQorcMGJhWl
	zuHjCuTSmy4TZAC38unQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82752>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/errors/NoGitRepositoryFoundException.java |   28 ++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/NoGitRepositoryFoundException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/NoGitRepositoryFoundException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/NoGitRepositoryFoundException.java
new file mode 100644
index 0000000..a0c6e83
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/NoGitRepositoryFoundException.java
@@ -0,0 +1,28 @@
+package org.spearce.jgit.errors;
+
+import java.io.File;
+
+/**
+ * No git repository could be found for a file or directory.
+ */
+public class NoGitRepositoryFoundException extends Exception {
+	private final File fileWeSearchedRepositoryFor;
+
+	/**
+	 * @param fileWeSearchedRepositoryFor
+	 *            the file for which a repository was searched.
+	 */
+	public NoGitRepositoryFoundException(final File fileWeSearchedRepositoryFor) {
+		super(String.format("No repository found for file '%s'",
+				fileWeSearchedRepositoryFor));
+		this.fileWeSearchedRepositoryFor = fileWeSearchedRepositoryFor;
+	}
+
+	/**
+	 * @return the file searched for.
+	 */
+	public File getFileWeSearchedRepositoryFor() {
+		return fileWeSearchedRepositoryFor;
+	}
+
+}
-- 
1.5.4.3
