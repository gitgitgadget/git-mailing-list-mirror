From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 21:59:50 +0000
Message-ID: <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 23:00:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12Bh-0007Xf-UO
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab3AaWAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:00:30 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:55108 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab3AaWA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:00:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E1603CDA59C;
	Thu, 31 Jan 2013 22:00:26 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fT0YPRSwWXA; Thu, 31 Jan 2013 22:00:23 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5E647CDA5B9;
	Thu, 31 Jan 2013 22:00:14 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215173>

When looking up a topic via "git help <topic>", git-help prepends "git-"
to topics that are the names of commands (either builtin or found on the
path) and "git" (no hyphen) to any other topic name.

"git-remote-helpers" is not the name of a command, so "git help
remote-helpers" looks for "gitremote-helpers" and does not find it.

Fix this by renaming "git-remote-helpers.txt" to
"gitremote-helpers.txt".

Signed-off-by: John Keeping <john@keeping.me.uk>

---
Changes since v1:

- add gitremote-helpers.txt to the Makefile since it is no longer caught
  by git-*.txt.

- add a simple git-remote-helpers.html to help people following links to
  the old name.

 Documentation/.gitignore                           |  1 +
 Documentation/Makefile                             |  4 +-
 Documentation/git-remote-helpers.html              | 55 ++++++++++++++++++++++
 Documentation/git-remote-testgit.txt               |  2 +-
 ...it-remote-helpers.txt => gitremote-helpers.txt} |  6 +--
 Documentation/urls.txt                             |  2 +-
 6 files changed, 63 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-remote-helpers.html
 rename Documentation/{git-remote-helpers.txt => gitremote-helpers.txt} (99%)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 2c8b2d6..5f479b8 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,5 +1,6 @@
 *.xml
 *.html
+!git-remote-helpers.html
 *.[1-8]
 *.made
 *.texi
diff --git a/Documentation/Makefile b/Documentation/Makefile
index fe6709c..4ccb828 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,7 +1,7 @@
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
-	gitk.txt gitweb.txt git.txt
+	gitk.txt gitweb.txt git.txt gitremote-helpers.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt gitweb.conf.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
@@ -13,7 +13,7 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
-DOC_HTML=$(MAN_HTML)
+DOC_HTML=$(MAN_HTML) git-remote-helpers.html
 
 ARTICLES = howto-index
 ARTICLES += everyday
diff --git a/Documentation/git-remote-helpers.html b/Documentation/git-remote-helpers.html
new file mode 100644
index 0000000..0c5ec27
--- /dev/null
+++ b/Documentation/git-remote-helpers.html
@@ -0,0 +1,55 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<title>git-remote-helpers(1) - Document Moved</title>
+<style type="text/css">
+/* Cut-down styles from asciidoc.css. */
+
+/* Default font. */
+body {
+  font-family: Georgia,serif;
+}
+
+/* Title font. */
+h1 {
+  font-family: Arial,Helvetica,sans-serif;
+}
+
+body {
+  margin: 1em 5% 1em 5%;
+}
+
+a {
+  color: blue;
+  text-decoration: underline;
+}
+a:visited {
+  color: fuchsia;
+}
+
+h1, h2, h3, h4, h5, h6 {
+  color: #527bbd;
+  margin-top: 1.2em;
+  margin-bottom: 0.5em;
+  line-height: 1.3;
+}
+
+</style>
+</head>
+<body class="manpage">
+<div id="header">
+<h1>
+Document Moved
+</h1>
+</div>
+
+<p>This document is now called <a
+href="gitremote-helpers.html">gitremote-helpers</a>.</p>
+
+<p>Please let the owners of the referring site know so that they can update the
+link you clicked to get here.</p>
+
+</body>
+</html>
diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
index 612a625..f791d73 100644
--- a/Documentation/git-remote-testgit.txt
+++ b/Documentation/git-remote-testgit.txt
@@ -23,7 +23,7 @@ The best way to learn more is to read the comments and source code in
 
 SEE ALSO
 --------
-linkgit:git-remote-helpers[1]
+linkgit:gitremote-helpers[1]
 
 GIT
 ---
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/gitremote-helpers.txt
similarity index 99%
rename from Documentation/git-remote-helpers.txt
rename to Documentation/gitremote-helpers.txt
index e36fdcb..0c91aba 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -1,9 +1,9 @@
-git-remote-helpers(1)
-=====================
+gitremote-helpers(1)
+====================
 
 NAME
 ----
-git-remote-helpers - Helper programs to interact with remote repositories
+gitremote-helpers - Helper programs to interact with remote repositories
 
 SYNOPSIS
 --------
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 539c0a0..3ca122f 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -55,7 +55,7 @@ may be used:
 
 where <address> may be a path, a server and path, or an arbitrary
 URL-like string recognized by the specific remote helper being
-invoked. See linkgit:git-remote-helpers[1] for details.
+invoked. See linkgit:gitremote-helpers[1] for details.
 
 If there are a large number of similarly-named remote repositories and
 you want to use a different format for them (such that the URLs you
-- 
1.8.1.1
