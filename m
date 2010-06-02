From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-compat-util.h: use apparently more common __sgi macro to detect SGI IRIX
Date: Tue,  1 Jun 2010 20:55:36 -0500
Message-ID: <4gJWLBIdRVtK7gq22o-LadCixyvOA-9FlEvk-ZrCHyUsGwArvR9oPkV-qlez-T-Nsn0v6UO633Y@cipher.nrlssc.navy.mil>
References: <20100514093838.421864000@mlists.thewrittenword.com>
Cc: git@vger.kernel.org, drafnel@gmail.com,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	"Gary V. Vaughan" <gary@thewrittenword.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 02 03:56:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJdCN-0001gU-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495Ab0FBB4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 21:56:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40538 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685Ab0FBB4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:56:46 -0400
Received: by mail.nrlssc.navy.mil id o521u0Gu012619; Tue, 1 Jun 2010 20:56:00 -0500
In-Reply-To: <20100514093838.421864000@mlists.thewrittenword.com>
X-OriginalArrivalTime: 02 Jun 2010 01:56:00.0756 (UTC) FILETIME=[C0271340:01CB01F6]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148190>

From: Gary V. Vaughan <git@mlists.thewrittenword.com>

IRIX 6.5.26m does not define the 'sgi' macro, but it does define an '__sgi'
macro.  Since later IRIX versions (6.5.29m) define both macros, and since
an underscore prefixed macro is preferred anyway, use '__sgi' to detect
compilation on SGI IRIX.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Hi Gary,

Here's a resubmit of your patch with an updated commit message.  Since the
__sgi macro seems to be more common than the sgi macro, I modified your
patch to check for only the __sgi macro.  I know Junio suggested checking
for both macros, but I'm the one that Junio was talking about when he made
his comments, and __sgi works for me.

It's such a simple little patch, but still I removed your signed-off-by line
since I modified the patch, and I am not you.  Please do reply to this message
with a signed-off-by if you sign off on the patch.  Junio will add it to the
patch when he applies the it.

-brandon


 git-compat-util.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index edf352d..c0198dd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -56,7 +56,7 @@
 # define _XOPEN_SOURCE 500
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
-      !defined(_M_UNIX) && !defined(sgi) && !defined(__DragonFly__)
+      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
1.6.6.2
