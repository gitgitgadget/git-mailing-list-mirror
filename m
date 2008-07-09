From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Provide fallback definitions of PRIu32 and PRIx32
Date: Wed, 9 Jul 2008 22:38:14 +0200
Message-ID: <200807092238.14656.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGgRw-00082B-Kq
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 22:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbYGIUie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 16:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYGIUie
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 16:38:34 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:43540 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYGIUid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 16:38:33 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 1465910AA70;
	Wed,  9 Jul 2008 22:38:25 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1B8B819E67;
	Wed,  9 Jul 2008 22:38:15 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87910>

Since 6e1c23442 we make use of these C99 constructs, but this commit did
not provide fallbacks for non-C99 systems.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-compat-util.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 545df59..8c7e114 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -110,6 +110,14 @@
 #define PRIuMAX "llu"
 #endif
 
+#ifndef PRIu32
+#define PRIu32 "u"
+#endif
+
+#ifndef PRIx32
+#define PRIx32 "x"
+#endif
+
 #ifndef PATH_SEP
 #define PATH_SEP ':'
 #endif
-- 
1.5.6.1.216.g8c89b
