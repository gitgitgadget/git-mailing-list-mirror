From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/3] Makefile: add NO_FNMATCH_CASEFOLD to IRIX sections
Date: Wed, 22 Dec 2010 15:58:51 -0800
Message-ID: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 23 01:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYwQ-0002g6-Ka
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 01:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab0LWAVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 19:21:51 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57131 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab0LWAVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 19:21:50 -0500
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2010 19:21:50 EST
Received: by mail.nrlssc.navy.mil id oBMNxH5b031963; Wed, 22 Dec 2010 17:59:17 -0600
X-OriginalArrivalTime: 22 Dec 2010 23:59:17.0441 (UTC) FILETIME=[3E1F0310:01CBA234]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164112>

From: Brandon Casey <drafnel@gmail.com>

IRIX's fnmatch() does not support the GNU FNM_CASEFOLD extension, so set
NO_FNMATCH_CASEFOLD so that the internal fnmatch implementation will be
used.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 57d9c65..ff35154 100644
--- a/Makefile
+++ b/Makefile
@@ -1003,6 +1003,7 @@ ifeq ($(uname_S),IRIX)
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
 	NO_REGEX = YesPlease
+	NO_FNMATCH_CASEFOLD = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH = /usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
@@ -1022,6 +1023,7 @@ ifeq ($(uname_S),IRIX64)
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
 	NO_REGEX = YesPlease
+	NO_FNMATCH_CASEFOLD = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
-- 
1.7.3.1
