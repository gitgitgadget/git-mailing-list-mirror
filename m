From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/5] MinGW: use POSIX signature of waitpid()
Date: Sat, 23 May 2009 10:04:49 +0200
Message-ID: <1243065891-13270-4-git-send-email-prohaska@zib.de>
References: <1243065891-13270-1-git-send-email-prohaska@zib.de>
 <1243065891-13270-2-git-send-email-prohaska@zib.de>
 <1243065891-13270-3-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 10:30:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mck-0005CC-1Z
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZEWIaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbZEWIaD
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:30:03 -0400
Received: from mailer.zib.de ([130.73.108.11]:34254 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbZEWIaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:30:00 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 04:29:52 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4N84wta001294;
	Sat, 23 May 2009 10:05:03 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4N84pOM028553;
	Sat, 23 May 2009 10:04:57 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243065891-13270-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119766>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git's source code expects waitpid() to return a signed int status.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/mingw.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 762eb14..b1156b8 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -109,7 +109,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
-static inline int waitpid(pid_t pid, unsigned *status, unsigned options)
+static inline int waitpid(pid_t pid, int *status, unsigned options)
 {
 	if (options == 0)
 		return _cwait(status, pid, 0);
-- 
1.6.3.1.54.g99dd
