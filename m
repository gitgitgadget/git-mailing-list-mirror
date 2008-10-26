From: "David M. Syzdek" <david.syzdek@acsalaska.net>
Subject: [PATCH] Add Makefile check for FreeBSD 4.9-SECURITY
Date: Sun, 26 Oct 2008 03:52:47 -0800
Message-ID: <1225021967-11902-1-git-send-email-david.syzdek@acsalaska.net>
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 13:08:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku4QH-0007jp-UJ
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 13:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbYJZMHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 08:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYJZMH2
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 08:07:28 -0400
Received: from iris.acsalaska.net ([209.112.173.229]:23092 "EHLO
	iris.acsalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYJZMH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 08:07:27 -0400
Received: from localhost.localdomain (209-193-51-248.static.acsalaska.net [209.193.51.248])
	by iris.acsalaska.net (8.14.1/8.14.1) with ESMTP id m9QBqlBP055335;
	Sun, 26 Oct 2008 03:52:47 -0800 (AKDT)
	(envelope-from david.syzdek@acsalaska.net)
X-Mailer: git-send-email 1.6.0.2.GIT
X-ACS-Spam-Status: no
X-ACS-Spam-Score: 1.3 (x)
X-ACS-Spam-Tests: HELO_LH_LD,ACS_BOGUS_LOCALHOST
X-ACS-Scanned-By: MD 2.63; SA 3.2.4; spamdefang 1.122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99157>

If the system is FreeBSD 4.9, then NO_UINTMAX_T and NO_STRTOUMAX is defined.

Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index bf6a6dc..c568314 100644
--- a/Makefile
+++ b/Makefile
@@ -679,6 +679,10 @@ ifeq ($(uname_S),FreeBSD)
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
+	ifeq ($(uname_R),4.9-SECURITY)
+		NO_UINTMAX_T = YesPlease
+		NO_STRTOUMAX = YesPlease
+	endif
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
-- 
1.6.0.2.GIT
