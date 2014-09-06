From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 02/32] api-lockfile: expand the documentation
Date: Sat,  6 Sep 2014 09:50:16 +0200
Message-ID: <1409989846-22401-3-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAtr-0004ql-1z
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaIFH7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:08 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59871 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750724AbaIFH7F (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:05 -0400
X-AuditID: 1207440f-f79156d000006a5c-26-540abd202736
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 78.1B.27228.02DBA045; Sat,  6 Sep 2014 03:52:00 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH1006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:51:59 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqKuwlyvEYN8+LYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujHmT5jIWNAhU/O56x9rAOI23i5GTQ0LARKJ77RcmCFtM4sK99Wxd
	jFwcQgKXGSW6P2xmgnCOMUmseLWaGaSKTUBXYlFPM1hCRKCNUWLXxc2sIAlmgRSJjufdjCC2
	sICDxOO7G9m7GDk4WARUJWY9FQIJ8wq4SExoncwMsU1OYsPu/2DlnAKuEtObOsFsIaCa9pP9
	TBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3ECAk0/h2MXetlDjEK
	cDAq8fAWOHCFCLEmlhVX5h5ilORgUhLlzVsOFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC2zEZ
	KMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuC9sRuoUbAoNT21Ii0z
	pwQhzcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7T0L0s5bXJCYCxSFaD3FqMuxrvNb
	P5MQS15+XqqUOC/THqAiAZCijNI8uBWwtPKKURzoY2He+yCjeIApCW7SK6AlTEBLzNM5QZaU
	JCKkpBoYk1blhTuzeh8LOJhyNF61YocHT9Ynjzv3taXfbHp4pkHgz0/RVL6v5xdeDTmWGe+R
	My+Cee4fpncrwqJi/ljdMf1bHvD420zf2fHns3e2dv96fSSu+cLWKc1FpW8zWRi/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256565>

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
2.1.0
