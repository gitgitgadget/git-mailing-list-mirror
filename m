From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/38] resolve_gitlink_ref(): rename path parameter to submodule
Date: Fri,  3 Jun 2016 23:03:53 +0200
Message-ID: <2c2adb2b2ffdfd2f644d6345dbe8b08b8e08d829.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wIU-0001b3-7U
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbcFCVGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:03 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53972 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161047AbcFCVFB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:01 -0400
X-AuditID: 12074412-51bff700000009f7-df-5751f0f90c31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 30.A4.02551.9F0F1575; Fri,  3 Jun 2016 17:04:57 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kci003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:55 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqPvzQ2C4wZNWTYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdsO8dacJS/4szlPSwNjMt4uhg5
	OSQETCSWXLrD2sXIxSEksJVR4tH5VcwgCSGB40wS59exgNhsAroSi3qamUBsEYEIiYZXLYwg
	DcwCc5gkbj/sBGrg4BAWCJA4dkMTpIZFQFXi+pT1YHN4BaIkDu/cxQSxTE7i8vQHbCA2p4CF
	RMvnVawQu8wlGk8dZpnAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukm
	RkjACe1gXH9S7hCjAAejEg9vwbPAcCHWxLLiytxDjJIcTEqivHvvAIX4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8Ka8BsrxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnw
	ygMjS0iwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFP7xxcAIAEnxAO3lBmnnLS5I
	zAWKQrSeYlSUEuc99B4oIQCSyCjNgxsLSyOvGMWBvhTmTQap4gGmILjuV0CDmYAGFzzyBxlc
	koiQkmpg1J5gqtb0sOIoo+U25bea93S3teg6NbD5rMkSObjK2+p6ctKseM/t4bZ/c1iunVn1
	tymvPaZtE2fZFRudg+e/7/qypyLvC5+6yQWbSJ3pskanDXgD/oQdNl5/dErlNPbM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296394>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 ++++++-----
 refs.h |  9 +++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 7a8ef6d..c39f85a 100644
--- a/refs.c
+++ b/refs.c
@@ -1299,22 +1299,23 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 				       resolve_flags, sha1, flags);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+int resolve_gitlink_ref(const char *submodule, const char *refname,
+			unsigned char *sha1)
 {
-	size_t len, orig_len = strlen(path);
+	size_t len, orig_len = strlen(submodule);
 	struct ref_store *refs;
 	int flags;
 
-	for (len = orig_len; len && path[len - 1] == '/'; len--)
+	for (len = orig_len; len && submodule[len - 1] == '/'; len--)
 		;
 
 	if (!len)
 		return -1;
 
 	if (len == orig_len) {
-		refs = get_ref_store(path);
+		refs = get_ref_store(submodule);
 	} else {
-		char *stripped = xmemdupz(path, len);
+		char *stripped = xmemdupz(submodule, len);
 
 		refs = get_ref_store(stripped);
 		free(stripped);
diff --git a/refs.h b/refs.h
index 52ea93b..132dcef 100644
--- a/refs.h
+++ b/refs.h
@@ -77,11 +77,12 @@ int is_branch(const char *refname);
 int peel_ref(const char *refname, unsigned char *sha1);
 
 /**
- * Resolve refname in the nested "gitlink" repository that is located
- * at path.  If the resolution is successful, return 0 and set sha1 to
- * the name of the object; otherwise, return a non-zero value.
+ * Resolve refname in the nested "gitlink" repository in the specified
+ * submodule (which must be non-NULL). If the resolution is
+ * successful, return 0 and set sha1 to the name of the object;
+ * otherwise, return a non-zero value.
  */
-int resolve_gitlink_ref(const char *path, const char *refname,
+int resolve_gitlink_ref(const char *submodule, const char *refname,
 			unsigned char *sha1);
 
 /*
-- 
2.8.1
