From: mhagger@alum.mit.edu
Subject: [PATCH v3 01/14] cache.h: add comments for git_path() and git_path_submodule()
Date: Fri, 28 Oct 2011 13:14:28 +0200
Message-ID: <1319800481-15138-2-git-send-email-mhagger@alum.mit.edu>
References: <1319800481-15138-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkPQ-00050t-8s
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab1J1LP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:15:29 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54705 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab1J1LPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:15:07 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkIY-00076m-UW; Fri, 28 Oct 2011 13:08:30 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319800481-15138-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184351>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 2e6ad36..5e807b9 100644
--- a/cache.h
+++ b/cache.h
@@ -662,7 +662,25 @@ extern char *git_pathdup(const char *fmt, ...)
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+
+/*
+ * Return the path of a file within get_git_dir().  The arguments
+ * should be printf-like arguments that produce the filename relative
+ * to get_git_dir().  Return the resulting path, or "/bad-path/" if
+ * there is an error.  The return value is a pointer into a temporary
+ * buffer that will be overwritten without notice.
+ */
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+
+/*
+ * Return the path of a file within the git_dir of the submodule
+ * located at path.  The other arguments should be printf-like
+ * arguments that produce the filename relative to "<path>/.git".  If
+ * "<path>/.git" is a gitlink file, follow it to find the actual
+ * submodule git_dir.  Return the resulting path, or "/bad-path/" if
+ * there is an error.  The return value is a pointer into a temporary
+ * buffer that will be overwritten without notice.
+ */
 extern char *git_path_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
-- 
1.7.7
