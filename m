From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2] MinGW: Add missing file mode bit defines
Date: Tue, 29 Dec 2009 02:19:33 +0100
Message-ID: <hhblfa$di8$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 02:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPQlI-0000JX-Ia
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 02:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZL2BUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 20:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbZL2BUI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 20:20:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:51254 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbZL2BUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 20:20:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NPQkn-00008Z-LP
	for git@vger.kernel.org; Tue, 29 Dec 2009 02:20:05 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 02:20:05 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 02:20:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135776>

MinGW: Add missing file mode bit defines

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/mingw.h |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index af2f810..885be51 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -12,12 +12,24 @@ typedef int uid_t;
 #define S_IFLNK    0120000 /* Symbolic link */
 #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
 #define S_ISSOCK(x) 0
+
+#ifndef _STAT_H_
+#define S_IRUSR 0
+#define S_IWUSR 0
+#define S_IXUSR 0
+#define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
+#endif
 #define S_IRGRP 0
 #define S_IWGRP 0
 #define S_IXGRP 0
-#define S_ISGID 0
+#define S_IRWXG (S_IRGRP | S_IWGRP | S_IXGRP)
 #define S_IROTH 0
+#define S_IWOTH 0
 #define S_IXOTH 0
+#define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
+#define S_ISUID 0
+#define S_ISGID 0
+#define S_ISVTX 0
 
 #define WIFEXITED(x) 1
 #define WIFSIGNALED(x) 0
-- 
1.6.5.rc2.13.g1be2
