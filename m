From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 06/11] Move #include <sys/select.h> and <sys/ioctl.h> to git-compat-util.h.
Date: Tue, 13 Nov 2007 21:05:01 +0100
Message-ID: <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21E-0001Be-NG
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761430AbXKMUFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761196AbXKMUF2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:28 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49201 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762490AbXKMUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:11 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id B15A710ACB9;
	Tue, 13 Nov 2007 21:05:08 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64847>

... since all system headers are pulled in via git-compat-util.h

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-compat-util.h |    2 ++
 help.c            |    1 -
 pager.c           |    2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7b29d1b..6a8b592 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -52,6 +52,8 @@
 #include <fnmatch.h>
 #include <sys/poll.h>
 #include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/select.h>
 #include <assert.h>
 #include <regex.h>
 #include <netinet/in.h>
diff --git a/help.c b/help.c
index 8217d97..d340b6a 100644
--- a/help.c
+++ b/help.c
@@ -7,7 +7,6 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "common-cmds.h"
-#include <sys/ioctl.h>
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
diff --git a/pager.c b/pager.c
index 8bac9d9..fb7a1a6 100644
--- a/pager.c
+++ b/pager.c
@@ -1,7 +1,5 @@
 #include "cache.h"
 
-#include <sys/select.h>
-
 /*
  * This is split up from the rest of git so that we might do
  * something different on Windows, for example.
-- 
1.5.3.5.1592.g0d6db
