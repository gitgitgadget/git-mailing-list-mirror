From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] configure: fix some output message
Date: Wed, 24 Oct 2012 17:34:27 +0200
Message-ID: <b67d9e47dc92c2c316495ac4bd8e7ba93d339781.1351091006.git.stefano.lattarini@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 17:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR2z3-00072X-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 17:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210Ab2JXPem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 11:34:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59866 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964999Ab2JXPek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 11:34:40 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so321693wey.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hWNNMuGe6+lAZSZgSfgoP8kQGGSIzLVxzP0asB0Lm9w=;
        b=YSku6qbkuenudYF49jElg6mKDNJpQx8PlulrYDt2kKPUwpEjuWxse15ITq77h34a8Q
         +QFDDY/laeJ9RPB9fck46AH5eazbkh/tLyCLiNtqHTU8LcCWiX/ufbPG/+cmCLrOfbxW
         gOtIya5Ee14QEhA5ArbEyg0XP6rI/HfhSQxvnrZ+plb6g8LAY2PCoKqexYNu6TztJ6qM
         0g5sANxGwDbG+wSkTVsCgP5/+iIqlybYXrNVoGg/4Z67Yq7/j1k1oVQX+LwMBs6o/BE2
         1Swn3MisUTNW7+ERjsu9Q73d22vdz42CfwxurlkthXXXnJgk2uow457s566FdDnAtaAR
         Uq4g==
Received: by 10.180.87.74 with SMTP id v10mr6739937wiz.21.1351092878555;
        Wed, 24 Oct 2012 08:34:38 -0700 (PDT)
Received: from localhost.localdomain (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id hv8sm4919052wib.0.2012.10.24.08.34.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 08:34:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.11.gd25c58c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208308>

Before this change, output from ./configure could contain
botched wording like this:

    checking Checking for POSIX Threads with '-pthread'... yes

instead of the intended:

    checking for POSIX Threads with '-pthread'... yes

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c85888c..ad215cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1024,7 +1024,7 @@ elif test -z "$PTHREAD_CFLAGS"; then
   for opt in -mt -pthread -lpthread; do
      old_CFLAGS="$CFLAGS"
      CFLAGS="$opt $CFLAGS"
-     AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
+     AC_MSG_CHECKING([for POSIX Threads with '$opt'])
      AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
@@ -1044,7 +1044,7 @@ elif test -z "$PTHREAD_CFLAGS"; then
 else
   old_CFLAGS="$CFLAGS"
   CFLAGS="$PTHREAD_CFLAGS $CFLAGS"
-  AC_MSG_CHECKING([Checking for POSIX Threads with '$PTHREAD_CFLAGS'])
+  AC_MSG_CHECKING([for POSIX Threads with '$PTHREAD_CFLAGS'])
   AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
-- 
1.8.0.rc2.11.gd25c58c
