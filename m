From: mduft@gentoo.org
Subject: [PATCH 1/2] Add additional build options for Interix, and remove obsolete ones.
Date: Wed, 25 May 2011 16:15:23 +0200
Message-ID: <1306332924-28587-2-git-send-email-mduft@gentoo.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
Cc: Markus Duft <mduft@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 16:25:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPF21-0005IJ-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003Ab1EYOZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:25:44 -0400
Received: from smtp.salomon.at ([193.186.16.13]:57813 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932686Ab1EYOZl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:25:41 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 May 2011 10:25:31 EDT
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id p4PEFMJX022198;
	Wed, 25 May 2011 16:15:49 +0200 (METDST)
Received: from s01en22 ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 25 May 2011 16:15:34 +0200
Received: by s01en22 (sSMTP sendmail emulation); Wed, 25 May 2011 16:15:30 +0200
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
X-OriginalArrivalTime: 25 May 2011 14:15:34.0425 (UTC) FILETIME=[36646090:01CC1AE6]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174405>

Interix versions older than 6.0 (so 3.5 and 5.2) both lack
struct sockaddr_storage and the FNM_CASEFOLD GNU extension,
so disable them both.

The removed options are obsolete, because interix support now
depends on libsuacomp.

Signed-off-by: Markus Duft <mduft@gentoo.org>
---
 Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index db72c45..c47cd4e 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,8 +1113,6 @@ endif
 	X = .exe
 endif
 ifeq ($(uname_S),Interix)
-	NO_SYS_POLL_H = YesPlease
-	NO_INTTYPES_H = YesPlease
 	NO_INITGROUPS = YesPlease
 	NO_IPV6 = YesPlease
 	NO_MEMMEM = YesPlease
@@ -1125,10 +1123,14 @@ ifeq ($(uname_S),Interix)
 	ifeq ($(uname_R),3.5)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_FNMATCH_CASEFOLD = YesPlease
 	endif
 	ifeq ($(uname_R),5.2)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_FNMATCH_CASEFOLD = YesPlease
 	endif
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
-- 
1.7.3.4
