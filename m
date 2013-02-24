From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: [PATCH 1/1] Fix git compilation without libiconv
Date: Sun, 24 Feb 2013 20:04:55 +0200
Message-ID: <CAHXAxrPq0oEaY=GG4Nb4aDL0TGLsE3eWb0vKqvem-WikZZQiWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 19:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9g2B-0004Nv-Mt
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 19:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab3BXSKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 13:10:08 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:47503 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3BXSKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 13:10:07 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so989903qcs.6
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=0LCOS8xfxsYX8oRlNSBN8Xj4hKE9RL5TH6h/ZFiLc90=;
        b=d6uYdtTcAh1vzcjd2C1rIPxdjNB2DR7IwQ+C0xcY5SPm8Rg1mOvi0t+75cPioImvQ/
         8ylWRBAHlnCfzhcpIKENpD8rWaOxAIMHhZ/LIYIhIxKmEkrgLcsn9SjH8sI3DecG5TGD
         gfuYKXxWuwtvloBb+6IgNtCDHcjGVljX73fVjs9OoRlOOLl88OT7sV9otSc9R/zDoBrf
         w2WHBWH7qf7LTSX6awNIdPLan44e/dF/XiIgawbly0rQT4XNyiEmTDV0jNldE2pUeXZ2
         nZXEED6Ric1VPL12WTN4OH0gR8IOEu7gf3Fxvh4m6FVwH8mbVrzMlqh/czIgZvx2H4Is
         klmw==
X-Received: by 10.229.179.23 with SMTP id bo23mr1768778qcb.104.1361729095139;
 Sun, 24 Feb 2013 10:04:55 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Sun, 24 Feb 2013 10:04:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216997>

Fix git compilation without available libiconv library.

From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1991258..d0e82c1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -566,7 +566,9 @@ for l in $lib_order; do
 	[AC_MSG_RESULT([yes])
 	NO_ICONV=
 	break],
-	[AC_MSG_RESULT([no])])
+	[AC_MSG_RESULT([no])
+	NEEDS_LIBICONV=
+	])
     LIBS="$old_LIBS"
 done

-- 
1.8.2-rc0
