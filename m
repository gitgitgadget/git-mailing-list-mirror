From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: configuration for SunOS 5.7
Date: Mon, 18 Aug 2008 18:55:45 -0500
Message-ID: <gyE6_rJUZSrlchRRxI1_FrybgeJIEHsFMLoTC4uoGAmW1PaknxWOVA@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:57:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEai-0007L7-Fh
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbYHRXzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754669AbYHRXzr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:55:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51789 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbYHRXzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:55:46 -0400
Received: by mail.nrlssc.navy.mil id m7INtj3B029348; Mon, 18 Aug 2008 18:55:45 -0500
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:55:45.0584 (UTC) FILETIME=[EE3E3300:01C9018D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92781>

---
 Makefile |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 551bde9..1e4e66f 100644
--- a/Makefile
+++ b/Makefile
@@ -620,11 +620,23 @@ endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
-	SHELL_PATH = /bin/bash
+	SHELL_PATH = /usr/xpg4/bin/sh
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
+	ifeq ($(uname_R),5.7)
+		NO_IPV6 = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+		NO_STRLCPY = YesPlease
+		NO_INET_NTOP = YesPlease
+		NO_INET_PTON = YesPlease
+		NO_C99_FORMAT = YesPlease
+		NO_STRTOUMAX = YesPlease
+		OLD_ICONV = UnfortunatelyYes
+	endif
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
-- 
1.6.0.11.gecc7e
