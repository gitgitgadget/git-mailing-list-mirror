From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 1/7] Windows: disable Python
Date: Fri, 15 Jan 2010 21:12:15 +0100
Message-ID: <20e5ea671a2739df4365616cc5a1a3ca466c5e1b.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:13:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsYL-0004sM-Qh
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab0AOUNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758137Ab0AOUNj
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:13:39 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31563 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758140Ab0AOUNj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:13:39 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DE0DFCDF8D;
	Fri, 15 Jan 2010 21:13:37 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4810E19F60D;
	Fri, 15 Jan 2010 21:12:41 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
In-Reply-To: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1263584975.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137109>

From: Erik Faye-Lund <kusmabite@googlemail.com>

Python is not commonly installed on Windows machines, so
we should disable it there by default.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This patch was not in the previous round, but was already discussed
 on the ML.

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 57045de..6933555 100644
--- a/Makefile
+++ b/Makefile
@@ -995,6 +995,7 @@ ifeq ($(uname_S),Windows)
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
+	NO_PYTHON = YesPlease
 	NO_PTHREADS = YesPlease
 	BLK_SHA1 = YesPlease
 
@@ -1045,6 +1046,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
+	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-- 
1.6.6.218.g3e6eb
