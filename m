From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-compat-util.h: remove superfluous test for __sun__
Date: Wed, 19 Aug 2009 20:27:08 -0500
Message-ID: <ZUMLsyRzm8CaPjRJDxp6IuUm1_m9f1dLWBj6Z5IUF8KBVpNTSnESx0ur_aqSCnNRKOLfSdPh12w@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 20 03:27:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdwRC-0005w2-2g
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 03:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbZHTB10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 21:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbZHTB10
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 21:27:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57504 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbZHTB1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 21:27:25 -0400
Received: by mail.nrlssc.navy.mil id n7K1RNV5016373; Wed, 19 Aug 2009 20:27:24 -0500
X-OriginalArrivalTime: 20 Aug 2009 01:27:22.0817 (UTC) FILETIME=[5E09E310:01CA2135]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126600>

From: Brandon Casey <drafnel@gmail.com>

This 'ifndef' macro is entered only when __sun__ is not defined.  This test
will never fail since it is located inside of the 'else' branch of an 'if'
macro which tests whether __sun__ is defined.  It has had no effect since
the merge at 436f66b7.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-compat-util.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9f941e4..71b5acb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -57,10 +57,8 @@
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#ifndef __sun__
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-#endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
-- 
1.6.4
