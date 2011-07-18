From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 2/4] mingw: fix compilation of poll-emulation
Date: Mon, 18 Jul 2011 20:08:34 +0200
Message-ID: <1311012516-4836-3-git-send-email-kusmabite@gmail.com>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 20:09:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QisFZ-0006Ch-RY
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab1GRSIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 14:08:50 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35701 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1GRSIt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:08:49 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so7013726fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Jb7ZvA1CvVCI2J0vSB0woh29snljppt3Ni+mVthLLTM=;
        b=S7OHJKgORQleJkq/ncQlRJz4bqez6RIAI33+ZD8nJR969IAeA0s7Nqvjv8pn0Ls5AY
         VPiIis3K7Cmm7YBf57cJD5yvjYhOsau1jGNMn6G4mr8CvKC7H0EV+va3c2YFBo70jbhI
         yH6x2S1fgvP7JxsPZEqBqXuBDzf8DqDrmtQuI=
Received: by 10.223.67.194 with SMTP id s2mr10578311fai.124.1311012528550;
        Mon, 18 Jul 2011 11:08:48 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id l12sm3089953fam.8.2011.07.18.11.08.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 11:08:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
In-Reply-To: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177390>

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
1.7.6.135.g378e9
