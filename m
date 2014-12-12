From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/24] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Fri, 12 Dec 2014 09:56:41 +0100
Message-ID: <1418374623-5566-3-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3Z-0005ZP-1R
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934672AbaLLI5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:18 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:59490 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933358AbaLLI5R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:17 -0500
X-AuditID: 1207440e-f79d26d000001b6e-29-548aadeb86fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CA.45.07022.BEDAA845; Fri, 12 Dec 2014 03:57:15 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nC023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:13 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqPt6bVeIwdm1YhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLf5NqLHYvLmdxYHd4+/7D0weO2fdZfdYsKnU4+IlZY/Pm+QCWKO4
	bZISS8qCM9Pz9O0SuDPufvjNVnCIv2Jpx0TGBsZzPF2MHBwSAiYSk89xdjFyApliEhfurWfr
	YuTiEBK4zCgx6/IzFgjnGJPEnEXbmEGq2AR0JRb1NDOB2CICahIT2w6BFTEL/GCUmDj7CFiR
	sECSxKtVzewgNouAqsTva7PB4rwCzhKL3+xmg9gsJ7F1nTdImFPAReJiyxMWEFsIqGTrik7W
	CYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEhBjfDsb29TKHGAU4
	GJV4eCckd4UIsSaWFVfmHmKU5GBSEuX9PhkoxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3bxRQ
	jjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwXt0DVCjYFFqempFWmZO
	CUKaiYMTZDiXlEhxal5KalFiaUlGPCgy4ouBsQGS4gHay7YWZG9xQWIuUBSi9RSjopQ472mQ
	uQIgiYzSPLixsMTxilEc6Eth3jMgVTzApAPX/QpoMBPQ4OVbOkAGlyQipKQaGK02PquZsnv1
	tsg72wtvqz39ffPkoYwTjDO3vjjy0zLl9bob07gu37VdlX/F3DBm+eIwg6jOzxxVtfzck52C
	XjHWH4yYH3w4a9P65Ja8q/s7lv9aUrfH5mnstV0OfPVzpJkCNF7mCuo3yajrxIhl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261343>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 22 ++--------------------
 refs.h |  2 +-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 005eb18..05cb299 100644
--- a/refs.c
+++ b/refs.c
@@ -3633,26 +3633,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: delete called for transaction that is not open");
-
-	if (have_old && !old_sha1)
-		die("BUG: have_old is true but old_sha1 is NULL");
-
-	update = add_update(transaction, refname);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old) {
-		assert(!is_null_sha1(old_sha1));
-		hashcpy(update->old_sha1, old_sha1);
-	}
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 2bc3556..7d675b7 100644
--- a/refs.h
+++ b/refs.h
@@ -283,7 +283,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
-- 
2.1.3
