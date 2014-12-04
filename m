From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/23] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Fri,  5 Dec 2014 00:08:14 +0100
Message-ID: <1417734515-11812-3-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:08:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfW3-0002oj-DC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298AbaLDXIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:47 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:65147 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933201AbaLDXIq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:46 -0500
X-AuditID: 1207440d-f79976d000005643-5e-5480e97d4ddc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.06.22083.D79E0845; Thu,  4 Dec 2014 18:08:45 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8ddx027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:43 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqFv7siHE4N8GHouuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFv8m1Fhs3tzO4sDu8ff9ByaPnbPusnss2FTqcfGSssfnTXIBrFHc
	NkmJJWXBmel5+nYJ3Bl3P/xmKzjEX7G0YyJjA+M5ni5GDg4JAROJqbsZuxg5gUwxiQv31rN1
	MXJxCAlcZpQ4PeMclHOMSeLCrZ1MIFVsAroSi3qawWwRATWJmatmgxUxC/xglHjdsIYZJCEs
	EC+x/Ow2FhCbRUBVYkHXLVYQm1fARWLbt8WMEJvlJLau8wYJcwq4Skyd2Qp2hRBQybNNC9kn
	MPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRESYrw7GP+vkznEKMDB
	qMTDW7C7PkSINbGsuDL3EKMkB5OSKO/Zpw0hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4jY8A
	5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxcL4AaBYtS01Mr0jJz
	ShDSTBycIMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3jKQdt7igsRcoChE6ylGRSlxXmuQ
	hABIIqM0D24sLHG8YhQH+lKYtxSkigeYdOC6XwENZgIafLahFmRwSSJCSqqBMWjrPfEf9iqZ
	FS/nqk7MUkq47ObSzMGuNfF0rK57rGaS7rV5u4+czOypY3fWZ+oqnNWnIM5d7R+3MlMj+MTp
	wyfNZ/5Zuv+fR5f3mhunmbSNjj7d7bHptl7ml/yrYZtXvrvqtGTJNJk006//wv5a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260813>

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
