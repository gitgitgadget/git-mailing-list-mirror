From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Makefile: Set compiler switch for USE_NSEC
Date: Sun,  8 Mar 2009 17:22:51 -0400
Message-ID: <1236547371-88742-1-git-send-email-benji@silverinsanity.com>
References: <70A401B0-C10D-4B4D-9DCC-D0968CE5EAF7@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQTw-0003fX-57
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 22:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbZCHVW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 17:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZCHVW4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:22:56 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:55220 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbZCHVWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 17:22:55 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 7AFC11FFC3FB; Sun,  8 Mar 2009 21:22:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	by silverinsanity.com (Postfix) with ESMTPA id D97121FFC043;
	Sun,  8 Mar 2009 21:22:45 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.222.g01cbd
In-Reply-To: <70A401B0-C10D-4B4D-9DCC-D0968CE5EAF7@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112646>

The comments indicated that setting a Makefile variable USE_NSEC would
enable the code for sub-second [cm]times.  However, the Makefile
variable was never turned into a compiler switch so the code was never
enabled.  This patch allows USE_NSEC to be noticed by the compiler.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 4bdaad7..b96c2b3 100644
--- a/Makefile
+++ b/Makefile
@@ -929,6 +929,9 @@ endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
+ifdef USE_NSEC
+	BASIC_CFLAGS += -DUSE_NSEC
+endif
 ifdef USE_ST_TIMESPEC
 	BASIC_CFLAGS += -DUSE_ST_TIMESPEC
 endif
-- 
1.6.2.222.g01cbd
