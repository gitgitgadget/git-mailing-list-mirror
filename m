From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/25] api-lockfile: expand the documentation
Date: Mon,  7 Apr 2014 01:33:43 +0200
Message-ID: <1396827247-28465-2-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbL-000602-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbaDFXf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:26 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53200 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754570AbaDFXeo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:44 -0400
X-AuditID: 1207440e-f79c76d000003e2c-58-5341e49355e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BE.29.15916.394E1435; Sun,  6 Apr 2014 19:34:43 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWm011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:42 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqDv5iWOwwbt2PYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MFmfeNDJadHZ8ZXRg9/j7/gOTx85Zd9k9nvXuYfS4eEnZY/EDL4/P
	m+Q8bj/bxhLAHsVtk5RYUhacmZ6nb5fAnTF7yhy2ggaBisebJzE2ME7j7WLk5JAQMJE4PHcp
	C4QtJnHh3no2EFtI4DKjxORlXF2MXED2cSaJfzO6GUESbAK6Eot6mplAbBEBNYmJbYdYQIqY
	BW4wSrzbdxhskrCAg0TPnjZmEJtFQFViy6zf7CA2r4CLxP9X01khtslJnDw2GczmFHCVWDd5
	LgvEZhegOffYJjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokREnp8
	Oxjb18scYhTgYFTi4V1xyDFYiDWxrLgy9xCjJAeTkiiv5T2gEF9SfkplRmJxRnxRaU5q8SFG
	CQ5mJRHeAzeAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd6jj4Ea
	BYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGxEV8MjA6QFA/Q3osg7bzFBYm5QFGI
	1lOMilLivDMfASUEQBIZpXlwY2EJ5RWjONCXwrzLQNp5gMkIrvsV0GAmoMENYXYgg0sSEVJS
	DYyyHCHRb2ImhPrW3nafO+tHqGas5ekt3rdXeF5YUfFvh/C11L+LVFUXmG6QnTAnq8RwYZnL
	r4f7lNfEC8tt1PBbWX1a8mp2UeLbT1FJXYvD1UJ+OdkGL2svj93Fv+IEz8Irmwzu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245802>

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
