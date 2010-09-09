From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] Makefile: use compat regex on IRIX 6.5
Date: Thu,  9 Sep 2010 14:15:58 -0500
Message-ID: <aIkKF4vjSeghwDQ63eyGAvzoq81HvE3fJPXM0HchsiJm2ahDUH-dO4jBA6nOEoyKGFpRKLAY7_A@cipher.nrlssc.navy.mil>
References: <HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, avarab@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 09 21:17:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmcR-0001jv-0Q
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab0IITRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:17:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34835 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0IITRD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:17:03 -0400
Received: by mail.nrlssc.navy.mil id o89JG7PW003168; Thu, 9 Sep 2010 14:16:08 -0500
In-Reply-To: <HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 09 Sep 2010 19:16:07.0839 (UTC) FILETIME=[74917AF0:01CB5053]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155886>

From: Brandon Casey <drafnel@gmail.com>

The IRIX 6.5 regex.h header file defines REG_STARTEND, but the feature does
not appear to work.  Since REG_STARTEND is required for proper functioning
of git-grep, set NO_REGEX and use the alternative regex libraries in compat/

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8b7c243..c27e8bc 100644
--- a/Makefile
+++ b/Makefile
@@ -982,6 +982,7 @@ ifeq ($(uname_S),IRIX)
 	# NO_MMAP.  If you suspect that your compiler is not affected by this
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
+	NO_REGEX = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH = /usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
@@ -1000,6 +1001,7 @@ ifeq ($(uname_S),IRIX64)
 	# NO_MMAP.  If you suspect that your compiler is not affected by this
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP = YesPlease
+	NO_REGEX = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
-- 
1.7.2.1
