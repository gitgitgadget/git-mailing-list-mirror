From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/25] api-lockfile: expand the documentation
Date: Mon, 14 Apr 2014 15:54:32 +0200
Message-ID: <1397483695-10888-3-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhO9-0003BE-TJ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbaDNNzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:10 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49174 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786AbaDNNzJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:09 -0400
X-AuditID: 12074411-f79ab6d000002f0e-00-534be8bc8444
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E7.A6.12046.CB8EB435; Mon, 14 Apr 2014 09:55:08 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt092010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:06 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLvnhXewwck7ihZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGfMnjKHraBBoOLx5kmMDYzTeLsY
	OTgkBEwkmvrNuhg5gUwxiQv31rOB2EIClxklps507GLkArJPMkl0PT0IlmAT0JVY1NPMBGKL
	CKhJTGw7xAJSxCzQziRxaEcvWEJYwEHi/6EbzCA2i4CqxPW/e8CaeQVcJBZ9esYCsU1O4uSx
	yawgR3AKuEos/JAFsdhF4u6XKawTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvN
	LNFLTSndxAgJRMEdjDNOyh1iFOBgVOLh7ZjjHSzEmlhWXJl7iFGSg0lJlDfjBlCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCK/rVqAcb0piZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFM
	VoaDQ0mC1xgYcUKCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoLiILwZGBkiKB2hv
	0nOQvcUFiblAUYjWU4yKUuK8JSAJAZBERmke3FhYennFKA70pTCvBMh2HmBqgut+BTSYCWgw
	SzvY4JJEhJRUA2Pdgi/8H0vneC94Ur3d6sTZyT4Pu79Pe1nLaMisdX/LllNO59OEorbuKFZn
	r1lmcf/BUoVf2ypPPr6pIdRhbKRo/jVVO3L59jPtMp+SPqpNXjbnrd63pgQZ9Ync 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246245>

Document a couple more functions and the flags argument as used by
hold_lock_file_for_update() and hold_lock_file_for_append().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 36 +++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index dd89404..b53e300 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -28,9 +28,39 @@ hold_lock_file_for_update::
 	the final destination (e.g. `$GIT_DIR/index`) and a flag
 	`die_on_error`.  Attempt to create a lockfile for the
 	destination and return the file descriptor for writing
-	to the file.  If `die_on_error` flag is true, it dies if
-	a lock is already taken for the file; otherwise it
-	returns a negative integer to the caller on failure.
+	to the file.  The flags parameter is a combination of
++
+--
+LOCK_NODEREF::
+
+	Usually symbolic links in path are resolved in path and the
+	lockfile is created by adding ".lock" to the resolved path;
+	however, if `LOCK_NODEREF` is set, then the lockfile is
+	created by adding ".lock" to the path argument itself.
+
+LOCK_DIE_ON_ERROR::
+
+	If a lock is already taken for the file, `die()` with an error
+	message.  If this option is not specified, return a negative
+	integer to the caller on failure.
+--
+
+hold_lock_file_for_append::
+
+	Like `hold_lock_file_for_update()`, except that additionally
+	the existing contents of the file (if any) are copied to the
+	lockfile and its write pointer is positioned at the end of the
+	file before returning.
+
+unable_to_lock_error::
+
+	Emit an error describing that there was an error locking the
+	specified path.  The err parameter should be the errno of the
+	problem that caused the failure.
+
+unable_to_lock_die::
+
+	Like `unable_to_lock_error()`, but also `die()`.
 
 commit_lock_file::
 
-- 
1.9.1
