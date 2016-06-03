From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/38] refs: add a transaction_commit() method
Date: Fri,  3 Jun 2016 23:03:45 +0200
Message-ID: <5ae6c74b12f7dbbaf6bf72c2a0deec7e6c6167f4.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHH-0000Yi-EY
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbcFCVEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:04:55 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61153 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752977AbcFCVEr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:47 -0400
X-AuditID: 1207440f-8bbff700000008e4-f9-5751f0eab9e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E5.EB.02276.AE0F1575; Fri,  3 Jun 2016 17:04:42 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kca003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:41 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqPvqQ2C4wfw+a4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbfFvQo3FmTeNjA6cHn/ff2Dy2DnrLrvHgk2lHs96
	9zB6XLyk7LF/6TY2j8UPvDwWPL/P7vF5k1wAZxS3TVJiSVlwZnqevl0Cd8amWx3MBX9EKr5N
	z2hg3CLYxcjBISFgIvFkH2MXIxeHkMBWRomtk1pZIJzjTBIn/mxk62Lk5GAT0JVY1NPMBGKL
	CERINLxqAetgFjjDJDF9djs7SEJYwE5iU/9KsCIWAVWJs907GEFsXoEoif1rdrCC2BICchKX
	pz8AG8opYCHR8nkVWFxIwFyi8dRhlgmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro
	5WaW6KWmlG5ihIQgP9CG9TKHGAU4GJV4eE+8CAwXYk0sK67MPcQoycGkJMq79w5QiC8pP6Uy
	I7E4I76oNCe1+BCjBAezkghvymugHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoR
	TFaGg0NJgnfRe6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAExBcDYwAkxQO0
	l/sDyN7igsRcoChE6ylGRSlx3kMgcwVAEhmleXBjYYnlFaM40JfCvIEg7TzApATX/QpoMBPQ
	4IJH/iCDSxIRUlINjBsqP9+oMD5zRtp1z8nb3vPm3Vzvph9tol/xlE3iH7v8Rq/vAfofOD9f
	v877sj4+JPH7onWM18z/zf34c+6OzQtkN+3k6HX8o9R5N2TJPTPH5oO7n6ck2DXf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296377>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  9 +++++++++
 refs/files-backend.c | 10 ++++++----
 refs/refs-internal.h |  5 +++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 5e20ae0..904e758 100644
--- a/refs.c
+++ b/refs.c
@@ -1375,3 +1375,12 @@ void assert_main_repository(struct ref_store *refs, const char *caller)
 	if (*refs->submodule)
 		die("BUG: %s called for a submodule", caller);
 }
+
+/* backend functions */
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->transaction_commit(refs, transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0d64a3d..fea4487 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3703,11 +3703,12 @@ static int lock_ref_for_update(struct ref_update *update,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_store *ref_store,
+				    struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "ref_transaction_commit");
+		files_downcast(ref_store, 0, "ref_transaction_commit");
 	int ret = 0, i;
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
@@ -4097,5 +4098,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
-	files_ref_store_create
+	files_ref_store_create,
+	files_transaction_commit
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d6c74cf..e24366b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -530,10 +530,15 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
  */
 typedef struct ref_store *ref_store_init_fn(const char *submodule);
 
+typedef int ref_transaction_commit_fn(struct ref_store *refs,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_store_init_fn *init;
+	ref_transaction_commit_fn *transaction_commit;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.8.1
