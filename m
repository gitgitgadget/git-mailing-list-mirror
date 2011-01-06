From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3] t3032: limit sed branch labels to 8 characters
Date: Wed,  5 Jan 2011 18:30:03 -0600
Message-ID: <gmeXEearzUOUEst4-B2b8mMW8OqKObIqeN20uJhfiKbKa9JUYsiz4cHx7ViGaJpP8z4W9bjGjNI@cipher.nrlssc.navy.mil>
References: <gmeXEearzUOUEst4-B2b8sVUo0XhywYUDm7rCJikom1xi9tIroh9GnJRv-bJTzbCbvqI-4DOU3A@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 06 01:31:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Padkm-0000Xv-QL
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 01:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab1AFAag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 19:30:36 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49408 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab1AFAab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 19:30:31 -0500
Received: by mail.nrlssc.navy.mil id p060USwW019985; Wed, 5 Jan 2011 18:30:28 -0600
In-Reply-To: <gmeXEearzUOUEst4-B2b8sVUo0XhywYUDm7rCJikom1xi9tIroh9GnJRv-bJTzbCbvqI-4DOU3A@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Jan 2011 00:30:27.0370 (UTC) FILETIME=[EA7808A0:01CBAD38]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164612>

From: Brandon Casey <drafnel@gmail.com>

POSIX leaves as unspecified the handling of labels greater than 8
characters.  Apparently, Sun decided to treat them as errors.  Make sed on
Solaris happy by trimming the length of labels to 8 characters.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t3032-merge-recursive-options.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2293797..de9ff89 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -16,13 +16,13 @@ test_description='merge-recursive options
 test_expect_success 'setup' '
 	conflict_hunks () {
 		sed -n -e "
-			/^<<<</ b inconflict
+			/^<<<</ b conflict
 			b
-			: inconflict
+			: conflict
 			p
 			/^>>>>/ b
 			n
-			b inconflict
+			b conflict
 		" "$@"
 	} &&
 
-- 
1.7.3.1
