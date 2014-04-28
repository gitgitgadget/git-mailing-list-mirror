From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 11/12] MINGW: do not fail at redefining pid_t on MinGW-W64
Date: Mon, 28 Apr 2014 17:51:36 +0400
Message-ID: <1398693097-24651-12-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wem4r-0003DE-C1
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbaD1N62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:58:28 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:39576 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbaD1N6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:58:24 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyM-0004qo-Nt; Mon, 28 Apr 2014 17:51:55 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247340>

pid_t is available in sys/types.h on both MinGW and MinGW-W64

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/mingw.h | 1 -
 compat/msvc.h  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index c502a22..8850109 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -5,7 +5,6 @@
  * things that are not available in header files
  */
 
-typedef int pid_t;
 typedef int uid_t;
 typedef int socklen_t;
 #define hstrerror strerror
diff --git a/compat/msvc.h b/compat/msvc.h
index cb41ce3..e2fda48 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -18,6 +18,8 @@
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
 
+typedef int pid_t;
+
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
 	int size1 = strlen(s1);
-- 
1.9.1
