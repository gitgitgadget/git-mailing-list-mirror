From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 2/4] mingw: fix compilation of poll-emulation
Date: Thu, 29 Sep 2011 22:59:21 +0200
Message-ID: <1317329963-6656-3-git-send-email-kusmabite@gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 22:59:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Nhm-00020c-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab1I2U7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 16:59:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39978 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694Ab1I2U7f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 16:59:35 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1097794bkb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6PNw5B9W6TYjECb2munKA4Yphf9HCHSFIG2xswwUvX0=;
        b=GpqX6X4gKtVeuWbMhDnHrx7BT0HJzzn+dhrzEryFUAbU3t8vptnMONlitrGMCZX4ED
         /PDjIQGxtNvmAq9OemjoE240lod0M/KZ8FCb47KRJjg5wwnK7j39+Z/ZtakKdV963qCV
         B+3GSRF4WTqv5wikddGUhutH1jRvEunpaKohI=
Received: by 10.204.147.155 with SMTP id l27mr8113001bkv.86.1317329975160;
        Thu, 29 Sep 2011 13:59:35 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no. [84.215.188.225])
        by mx.google.com with ESMTPS id s13sm2840346bkb.11.2011.09.29.13.59.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 13:59:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.355.g842ba.dirty
In-Reply-To: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182435>

gnulib has changed the inclusion of poll.h from double quotes
to single-quotes. But because compat/win32/sys/ isn't in our
include-path, this breaks compilation. Change it back the way
it was.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/win32/sys/poll.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
index 403eaa7..225ddce 100644
--- a/compat/win32/sys/poll.c
+++ b/compat/win32/sys/poll.c
@@ -29,7 +29,7 @@
 #include <sys/types.h>
 
 /* Specification.  */
-#include <poll.h>
+#include "poll.h"
 
 #include <errno.h>
 #include <limits.h>
-- 
1.7.6.355.g842ba.dirty
