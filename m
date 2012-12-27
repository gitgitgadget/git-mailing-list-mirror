From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 18/19] setup.c: document get_pathspec()
Date: Thu, 27 Dec 2012 02:32:37 +0000
Message-ID: <1356575558-2674-19-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hp-0006Tl-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab2L0CdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:33:08 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53769 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab2L0Ccz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:55 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 22F9D2E5DB
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:54 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212178>

Since we have just created a new pathspec-handling library, now is a
good time to add some comments explaining get_pathspec().

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 setup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/setup.c b/setup.c
index 7663a4c..03d6d5c 100644
--- a/setup.c
+++ b/setup.c
@@ -249,6 +249,21 @@ static const char *prefix_pathspec(const char *prefix, int prefixlen, const char
 		return prefix_path(prefix, prefixlen, copyfrom);
 }
 
+/*
+ * prefix - a path relative to the root of the working tree
+ * pathspec - a list of paths underneath the prefix path
+ *
+ * Iterates over pathspec, prepending each path with prefix,
+ * and return the resulting list.
+ *
+ * If pathspec is empty, return a singleton list containing prefix.
+ *
+ * If pathspec and prefix are both empty, return an empty list.
+ *
+ * This is typically used by built-in commands such as add.c, in order
+ * to normalize argv arguments provided to the built-in into a list of
+ * paths to process, all relative to the root of the working tree.
+ */
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
-- 
1.7.11.2.249.g31c7954
