From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/33] remove_dir_recursively(): add docstring
Date: Fri,  6 May 2016 18:13:46 +0200
Message-ID: <728af2832c3e58222965521682414adb9a80932b.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOl-0007yb-JF
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572AbcEFQOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54137 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758542AbcEFQOb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:31 -0400
X-AuditID: 12074413-487ff700000008c7-ae-572cc2e60149
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D2.32.02247.6E2CC275; Fri,  6 May 2016 12:14:30 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUl031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:28 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqPvskE64wcoOGYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8a0zwdZC15zVfSsfczcwHiDo4uRk0NCwERi/pnX
	TF2MXBxCAlsZJd7sWg3lHGeSuHxqDytIFZuArsSinmYmEFtEIEKi4VULYxcjBwezwGdGiZXc
	IGFhAUeJY5OnMIPYLAKqEnsXn2EDsXkFoiReP7zJCrFMTuLy9AdgcU4BC4lDvcfBRgoJmEt0
	rL3BPoGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkAAT3sG466Tc
	IUYBDkYlHt6Mk9rhQqyJZcWVuYcYJTmYlER5vxfohAvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS
	4b2yDyjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgDToI1ChYlJqe
	WpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioD4YmAMgKR4gPbKg7TzFhck5gJFIVpPMepy
	HNl/by2TEEtefl6qlDivAUiRAEhRRmke3ApYOnnFKA70sTDvZZAqHmAqgpv0CmgJE9CS93M1
	QZaUJCKkpBoYU0LfW9T+ds7+u00g/eIN3kknt2TJfkp2ZvAyaXgR+eYz47yYSfu1das7mT7e
	3nNdrdhIcfoUqY1ySpKzXnQ6HLiRlVb33Hjiidkfe9bP7BRIevpmJ2tttwVr8w3J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293797>

Add a docstring for the remove_dir_recursively() function and the
REMOVE_DIR_* flags that can be passed to it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 dir.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/dir.h b/dir.h
index 301b737..5f19acc 100644
--- a/dir.h
+++ b/dir.h
@@ -262,9 +262,32 @@ extern int is_empty_dir(const char *dir);
 
 extern void setup_standard_excludes(struct dir_struct *dir);
 
+
+/* Constants for remove_dir_recursively: */
+
+/*
+ * If a non-directory is found within path, stop and return an error.
+ * (In this case some empty directories might already have been
+ * removed.)
+ */
 #define REMOVE_DIR_EMPTY_ONLY 01
+
+/*
+ * If any Git work trees are found within path, skip them without
+ * considering it an error.
+ */
 #define REMOVE_DIR_KEEP_NESTED_GIT 02
+
+/* Remove the contents of path, but leave path itself. */
 #define REMOVE_DIR_KEEP_TOPLEVEL 04
+
+/*
+ * Remove path and its contents, recursively. flags is a combination
+ * of the above REMOVE_DIR_* constants. Return 0 on success.
+ *
+ * This function uses path as temporary scratch space, but restores it
+ * before returning.
+ */
 extern int remove_dir_recursively(struct strbuf *path, int flag);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
-- 
2.8.1
