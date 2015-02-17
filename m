From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/13] update_ref(): improve documentation
Date: Tue, 17 Feb 2015 18:00:22 +0100
Message-ID: <1424192423-27979-13-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:01:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlWH-0003v4-4R
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbBQRAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:53 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61593 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752295AbbBQRAw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:52 -0500
X-AuditID: 1207440f-f792a6d000001284-ff-54e373c33b7d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.5E.04740.3C373E45; Tue, 17 Feb 2015 12:00:51 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXh000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:49 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqHu4+HGIwYFH/BZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgztpw+z1LwVKjiypmCBsY2/i5GTg4JAROJ6wsaGSFsMYkL99azgdhC
	ApcZJTbuZYawjzNJvLquBWKzCehKLOppZgKxRQTUJCa2HWIBsZkFVjNJbL0L1issYCsxc88X
	sBoWAVWJr7MbwWxeAVeJ7jWTmCB2yUmcP/4TbD4nUHzZr2XsELtcJOZ3zGaawMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZIgPHvYOxaL3OIUYCDUYmH12LCoxAh
	1sSy4srcQ4ySHExKorzhRY9DhPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwBqUA5XhTEiurUovy
	YVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErymIEMFi1LTUyvSMnNKENJMHJwgw7mk
	RIpT81JSixJLSzLiQVERXwyMC5AUD9BePZB23uKCxFygKETrKUZFKXHeFJCEAEgiozQPbiws
	bbxiFAf6Uph3HUgVDzDlwHW/AhrMBDR4/p9HIINLEhFSUg2MvUcseOadbOjZlzUzbN+P81xX
	l37pOndYRLZWXaT541nGP3tOf/CSEeD5Few5fVnfs8/3JaQ+9fd/2JdveeTPkmydvrzLz5lc
	F+p03GQW+mpY9uLTDt5FHOnuep7+cltZn77p0DU/nvgydYnHi7jfX5durjP/zFE1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263960>

Add a docstring for update_ref(), emphasizing its similarity to
ref_transaction_update(). Rename its parameters to match those of
ref_transaction_update().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c |  8 ++++----
 refs.h | 13 ++++++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 1aaba3f..8d46b08 100644
--- a/refs.c
+++ b/refs.c
@@ -3738,8 +3738,8 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
 }
 
-int update_ref(const char *action, const char *refname,
-	       const unsigned char *sha1, const unsigned char *oldval,
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr)
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
index 5e139d5..bb9d7b5 100644
--- a/refs.h
+++ b/refs.h
@@ -344,9 +344,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
  */
 void ref_transaction_free(struct ref_transaction *transaction);
 
-/** Lock a ref and then write its file */
-int update_ref(const char *action, const char *refname,
-	       const unsigned char *sha1, const unsigned char *oldval,
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
 	       unsigned int flags, enum action_on_err onerr);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
-- 
2.1.4
