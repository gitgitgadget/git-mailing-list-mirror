From: david@statichacks.org
Subject: [PATCH 2/4] Changed timestamps to time_t in header files
Date: Thu,  6 Nov 2008 09:48:46 -0800
Message-ID: <1225993728-4779-3-git-send-email-david@statichacks.org>
References: <1225993728-4779-1-git-send-email-david@statichacks.org>
 <1225993728-4779-2-git-send-email-david@statichacks.org>
Cc: David Bryson <david@statichacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:50:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8zi-0005K1-NK
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbYKFRsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYKFRsy
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:48:54 -0500
Received: from cryptobackpack.org ([64.105.32.74]:38689 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYKFRsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:48:52 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 026B810D02AE; Thu,  6 Nov 2008 09:48:51 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id D865110D023C;
	Thu,  6 Nov 2008 09:48:49 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 8C6F914462; Thu,  6 Nov 2008 09:48:48 -0800 (PST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1225993728-4779-2-git-send-email-david@statichacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100253>

From: David Bryson <david@statichacks.org>

---
 cache.h    |    2 +-
 refs.h     |    2 +-
 revision.h |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index a3c77f0..2c114f8 100644
--- a/cache.h
+++ b/cache.h
@@ -625,7 +625,7 @@ enum date_mode {
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
-unsigned long approxidate(const char *);
+time_t approxidate(const char *);
 enum date_mode parse_date_format(const char *format);
 
 #define IDENT_WARN_ON_NO_NAME  1
diff --git a/refs.h b/refs.h
index 06ad260..97c4bfe 100644
--- a/refs.h
+++ b/refs.h
@@ -55,7 +55,7 @@ extern void unlock_ref(struct ref_lock *lock);
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
diff --git a/revision.h b/revision.h
index 2fdb2dd..7cc9dbd 100644
--- a/revision.h
+++ b/revision.h
@@ -103,8 +103,8 @@ struct rev_info {
 	/* special limits */
 	int skip_count;
 	int max_count;
-	unsigned long max_age;
-	unsigned long min_age;
+	time_t max_age;
+	time_t min_age;
 
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
-- 
1.6.0.1
