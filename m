From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: [PATCH 1/1] Add getpagesize() function detection to configure script
Date: Mon, 25 Feb 2013 20:34:30 +0200
Message-ID: <CAHXAxrMcmSZhs88OV7Ny0G+=W0qC-KfruCgogAi0_zBtch-Uvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 19:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2t6-0003SP-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758947Ab3BYSec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:34:32 -0500
Received: from mail-qe0-f42.google.com ([209.85.128.42]:53079 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758662Ab3BYSeb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:34:31 -0500
Received: by mail-qe0-f42.google.com with SMTP id f6so1444246qej.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=VcdCmi6rF6gIXi1RsakhJO9szdGN4A6ss2pIuoyF+uw=;
        b=WKJT+CGe8t8i4XBqv1ZvpI4q1VahjxlkJ5KeBzriXzT/BjKL8nItQN4BpkDYjUJTMn
         JaanpZCKPwd5YA9LI7VRA7sIC68FRfhfVTBOPTqj4j8p2Ac5t4VbwFcvnuKJyCjC1qdn
         13hjMhGss7j6Pe0CmOuALOprtj5OLa+uV4lXSoiq29pqyr9ugqdewWEe6B/Xb1t4LGpK
         f+F49xnlEztr00iXAuUW58j+HTwg4LHDuI875QxL5DDtYUUlas134MaQccj3mVI0RurJ
         wEJmBNVllAljz/TbESU22pFogEZa39gteDsJaIi4gUJminDrHoFEvCHUEPCJQ/hs3rhC
         Dr7w==
X-Received: by 10.224.27.136 with SMTP id i8mr13091555qac.63.1361817270733;
 Mon, 25 Feb 2013 10:34:30 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 10:34:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217076>

Add detection of getpagesize() function in libc. Declare
empty "NO_GETPAGESIZE" macro in case if getpagesize()
exists and "NO_GETPAGESIZE=YesPlease" if no.

Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>

---
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index d0e82c1..3963429 100644
--- a/configure.ac
+++ b/configure.ac
@@ -993,6 +993,11 @@ GIT_CHECK_FUNC(initgroups,
 [NO_INITGROUPS=YesPlease])
 GIT_CONF_SUBST([NO_INITGROUPS])
 #
+# Define NO_GETPAGESIZE if you don't have getpagesize in the C library.
+GIT_CHECK_FUNC(getpagesize,
+[NO_GETPAGESIZE=],
+[NO_GETPAGESIZE=YesPlease])
+GIT_CONF_SUBST([NO_GETPAGESIZE])
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
-- 
1.8.2-rc0
