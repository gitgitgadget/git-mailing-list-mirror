From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Compile fix for MSVC: Move poll.h out of sys-folder
Date: Fri, 18 Nov 2011 14:47:50 +0100
Message-ID: <1321624070-4246-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, kusmabite@gmail.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 14:48:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RROnm-0002mN-Et
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 14:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab1KRNsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 08:48:15 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40202 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757961Ab1KRNsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 08:48:13 -0500
Received: by fagn18 with SMTP id n18so4293202fag.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 05:48:11 -0800 (PST)
Received: by 10.204.148.75 with SMTP id o11mr3451720bkv.95.1321624091555;
        Fri, 18 Nov 2011 05:48:11 -0800 (PST)
Received: from localhost.localdomain (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id e18sm725952bkr.15.2011.11.18.05.48.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 05:48:10 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185659>

In v1.7.7.1-432-g0f77dea (Oct 24 2011; Erik Faye-Lund; mingw: move
poll out of sys-folder) poll.h was moved out of the compat/win32/sys
folder. As the change in the Makefile also affects the MSVC build,
the same must be done for poll.h in compat/vcbuild/include/sys/poll.h.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 compat/vcbuild/include/poll.h     |    1 +
 compat/vcbuild/include/sys/poll.h |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)
 create mode 100644 compat/vcbuild/include/poll.h
 delete mode 100644 compat/vcbuild/include/sys/poll.h

diff --git a/compat/vcbuild/include/poll.h b/compat/vcbuild/include/poll.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/poll.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
diff --git a/compat/vcbuild/include/sys/poll.h b/compat/vcbuild/include/sys/poll.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/poll.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
-- 
1.7.4.1
