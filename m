From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/22] api-lockfile: expand the documentation
Date: Tue,  1 Apr 2014 17:58:17 +0200
Message-ID: <1396367910-7299-10-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16B-0008Th-QU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbaDAP7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:03 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56969 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822AbaDAP6u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:50 -0400
X-AuditID: 1207440d-f79d86d0000043db-bb-533ae2395342
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.07.17371.932EA335; Tue,  1 Apr 2014 11:58:49 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbD027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:48 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqGv5yCrYYM0/U4uuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xbc911oI2gYot5+8xNjDO4e1i5OCQEDCRuPUtu4uRE8gUk7hwbz1bFyMXh5DAZUaJ
	dUtfsUM4x5gkFj56wQhSxSagK7Gop5kJxBYRUJOY2HaIBcRmFkiRePV3F5gtLGArcW/lQmYQ
	m0VAVeL7y1tsIMt4BVwkbs5ngVgmJzHl9wJ2EJsTKHzpwR5WEFtIwFni9JvFzBMYeRcwMqxi
	lEvMKc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAko3h2M/9fJHGIU4GBU4uE9eN4q
	WIg1say4MvcQoyQHk5Io74+7QCG+pPyUyozE4oz4otKc1OJDjBIczEoivLNuAuV4UxIrq1KL
	8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK81x4ANQoWpaanVqRl5pQgpJk4OEGG
	c0mJFKfmpaQWJZaWZMSD4iK+GBgZICkeoL0rQdp5iwsSc4GiEK2nGBWlxHlDHgIlBEASGaV5
	cGNhaeIVozjQl8K8m0DaeYApBq77FdBgJqDB3OvABpckIqSkGhhV3HKjEv3Ul79o3Hei3sbt
	3DIfHpv5Eqyx/b9r78gFtYf+SjlQEn9KN/n7n5vpavu0TY3iswInZBR4zz4qc7xfk2/XypUf
	JesFvGU2y4r3x0zVvpmqYb0uVf/qPdte5QcfOPUUOV+Uzp2w2ycl69iNPer8XZ8y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245601>

Document a couple more functions and the flags argument as used by
hold_lock_file_for_update() and hold_lock_file_for_append().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 36 +++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index dd89404..95ed03b 100644
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
+unable_to_lock_index_die::
+
+	Like `unable_to_lock_error()`, but also `die()`.
 
 commit_lock_file::
 
-- 
1.9.0
