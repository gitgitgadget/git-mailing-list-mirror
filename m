From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/6] Fix signature of fcntl() compatibility dummy
Date: Sat,  6 Mar 2010 16:40:40 +0100
Message-ID: <dc9be33a660733a88e1c2fd8a3d9c190a7779d5d.1267889703.git.j6t@kdbg.org>
References: <cover.1267889703.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15t-0004YU-Q7
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab0CFPms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:42:48 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47686 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751438Ab0CFPmn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:42:43 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5D4432C4007;
	Sat,  6 Mar 2010 16:42:42 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8641119F703;
	Sat,  6 Mar 2010 16:41:01 +0100 (CET)
X-Mailer: git-send-email 1.7.0.rc2.65.g7b13a
In-Reply-To: <cover.1267889703.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Obviously, this function was never called with two arguments in Windows
code sections, but this will be the case in a subsequent patch.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index e254fb4..f53bcca 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -89,7 +89,7 @@ static inline int getuid()
 { return 1; }
 static inline struct passwd *getpwnam(const char *name)
 { return NULL; }
-static inline int fcntl(int fd, int cmd, long arg)
+static inline int fcntl(int fd, int cmd, ...)
 {
 	if (cmd == F_GETFD || cmd == F_SETFD)
 		return 0;
-- 
1.7.0.rc2.65.g7b13a
