From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/7] Add a file comment
Date: Fri, 12 Aug 2011 23:43:04 +0200
Message-ID: <1313185390-19724-2-git-send-email-mhagger@alum.mit.edu>
References: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:43:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzVz-00088C-P7
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab1HLVnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:43:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40850 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab1HLVne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:43:34 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CLhCvG007606;
	Fri, 12 Aug 2011 23:43:26 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179249>

Consolidate here a few general comments plus links to other
documentation.  Delete a comment with an out-of-date description of
the .gitattributes file format.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index f6b3f7e..6bc7ae9 100644
--- a/attr.c
+++ b/attr.c
@@ -1,3 +1,12 @@
+/*
+ * Handle git attributes.  See gitattributes(5) for a description of
+ * the file syntax, and Documentation/technical/api-gitattributes.txt
+ * for a description of the API.
+ *
+ * One basic design decision here is that we are not going to support
+ * an insanely large number of attributes.
+ */
+
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "exec_cmd.h"
@@ -13,12 +22,7 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 
 static const char *attributes_file;
 
-/*
- * The basic design decision here is that we are not going to have
- * insanely large number of attributes.
- *
- * This is a randomly chosen prime.
- */
+/* This is a randomly chosen prime. */
 #define HASHSIZE 257
 
 #ifndef DEBUG_ATTR
@@ -103,16 +107,6 @@ struct git_attr *git_attr(const char *name)
 	return git_attr_internal(name, strlen(name));
 }
 
-/*
- * .gitattributes file is one line per record, each of which is
- *
- * (1) glob pattern.
- * (2) whitespace
- * (3) whitespace separated list of attribute names, each of which
- *     could be prefixed with '-' to mean "set to false", '!' to mean
- *     "unset".
- */
-
 /* What does a matched pattern decide? */
 struct attr_state {
 	struct git_attr *attr;
-- 
1.7.6.8.gd2879
