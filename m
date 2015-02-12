From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/12] update_ref(): improve documentation
Date: Thu, 12 Feb 2015 12:12:22 +0100
Message-ID: <1423739543-1025-12-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLroh-0007gg-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbbBLLUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:20:12 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50428 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755012AbbBLLUL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:20:11 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2015 06:20:11 EST
X-AuditID: 1207440f-f792a6d000001284-73-54dc8ab001f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.A0.04740.0BA8CD45; Thu, 12 Feb 2015 06:12:48 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7e003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:46 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLuh606IwauHPBZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzJp6+wVywRLii5+sP5gbG/fxdjJwcEgImEnNOHmWHsMUkLtxbz9bF
	yMUhJHCZUeL36ZdQzgkmieZv39lAqtgEdCUW9TQzgdgiAmoSE9sOsYDYzAKrmSS23gWq4eAQ
	FrCVONnOARJmEVCV2DvnNtgCXgEXibWPL0Etk5M4f/wnM4jNCRR/d6mBEcQWEnCW2NW2hXUC
	I+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCFBxr+DsWu9zCFGAQ5G
	JR7eFaZ3QoRYE8uKK3MPMUpyMCmJ8nK1AoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8Po2AeV4
	UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK85Z1AjYJFqempFWmZOSUI
	aSYOTpDhXFIixal5KalFiaUlGfGgyIgvBsYGSIoHaK8YSDtvcUFiLlAUovUUo6KUOG8mSEIA
	JJFRmgc3FpY6XjGKA30pzCsBTCRCPMC0A9f9CmgwE9DgiTNugwwuSURISTUwas/8qGSR+sgh
	Q+4nj/+zkzluppcSjzUkGLC+3jz3iPNBd8NP9ZMDmzdWMu4S4T8mc+9Ugd67KYtNbMQCL5+T
	N1578/NmxmDZXD/vnVsNYuI//G3UydRIvv+7L2mbuIBTe5r7o/bIWUbJGWevfFqR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263728>

Add a docstring for update_ref(), emphasizing its similarity to
ref_transaction_update(). Rename its parameters to match those of
ref_transaction_update().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c |  8 ++++----
 refs.h | 15 +++++++++++----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 489eec9..bea918d 100644
--- a/refs.c
+++ b/refs.c
@@ -3738,8 +3738,8 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
 }
 
-int update_ref(const char *action, const char *refname,
-	       const unsigned char *sha1, const unsigned char *oldval,
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       int flags, enum action_on_err onerr)
 {
 	struct ref_transaction *t;
@@ -3747,8 +3747,8 @@ int update_ref(const char *action, const char *refname,
 
 	t = ref_transaction_begin(&err);
 	if (!t ||
-	    ref_transaction_update(t, refname, sha1, oldval,
-				   flags, action, &err) ||
+	    ref_transaction_update(t, refname, new_sha1, old_sha1,
+				   flags, msg, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
diff --git a/refs.h b/refs.h
index 02d6e39..08abd2c 100644
--- a/refs.h
+++ b/refs.h
@@ -344,10 +344,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
  */
 void ref_transaction_free(struct ref_transaction *transaction);
 
-/** Lock a ref and then write its file */
-int update_ref(const char *action, const char *refname,
-		const unsigned char *sha1, const unsigned char *oldval,
-		int flags, enum action_on_err onerr);
+/**
+ * Lock, update, and unlock a single reference. This function
+ * basically does a transaction containing a single call to
+ * ref_transaction_update(). The parameters to this function have the
+ * same meaning as the corresponding parameters to
+ * ref_transaction_update(). Handle errors as requested by the `onerr`
+ * argument.
+ */
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1, const unsigned char *old_sha1,
+	       int flags, enum action_on_err onerr);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
-- 
2.1.4
