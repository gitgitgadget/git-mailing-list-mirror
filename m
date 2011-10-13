From: mhagger@alum.mit.edu
Subject: [PATCH 01/14] cache.h: add comments for git_path() and git_path_submodule()
Date: Thu, 13 Oct 2011 09:58:22 +0200
Message-ID: <1318492715-5931-2-git-send-email-mhagger@alum.mit.edu>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:59:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGC3-0001nZ-JQ
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab1JMH67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:58:59 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:34327 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab1JMH66 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 03:58:58 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1REG6H-0002Mo-6D; Thu, 13 Oct 2011 09:53:09 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183447>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index e39e160..b94855e 100644
--- a/cache.h
+++ b/cache.h
@@ -660,7 +660,22 @@ extern char *git_pathdup(const char *fmt, ...)
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+
+/*
+ * Return the path of a file within get_git_dir().  The arguments
+ * should be printf-like arguments that produce the filename relative
+ * to get_git_dir().  Return the resulting path, or "/bad-path/" if
+ * there is an error.
+ */
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+
+/*
+ * Return the path of a file within the submodule located at path.
+ * The other arguments should be printf-like arguments that produce
+ * the filename relative to "<path>/.git".  If "<path>/.git" is a
+ * gitlink file, follow it to find the actual submodule git path.
+ * Return the resulting path, or "/bad-path/" if there is an error.
+ */
 extern char *git_path_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
-- 
1.7.7.rc2
