From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 48/48] refs.c: make write_ref_sha1 static
Date: Tue, 10 Jun 2014 15:29:36 -0700
Message-ID: <1402439376-25839-49-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:33:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZq-00068o-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbaFJWau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:50 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:41485 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so1417580qab.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lz7lHfjTCdRC2f86a97gDkaIfbZDyOgkQMYdjRyXZ/o=;
        b=ReCaOzarO32HZEpkXA1FfRZKLk5Chl3NpHbwAm4L+AYEAEua+Dy31luu/bCIrFrZC2
         xh33VNjG8rA4wBt//Q+mP9PoHiDlvbzK5LT7D8ZZ5CPTB2LBAHQU1Jzbwzn2m+17Ak9f
         bSnGtMJXkS1+ik5/6Xw2Gk44jApAQ3RMdvFSY84m2By97YffzXv+XrxHPcDC5Pf+McrU
         2zqvsHxdw4j9sygkFfUsCUaXlHN25ohvTCSHlq5xj7iPCExSysDPbCzSPxJ+j3FSPRQT
         BdBtCfxdb5k8m1TENbfTzwOQb/IzKNU1/mIXFk2NAJraDL1mqe8Qwzr387w2oOglKaHc
         cC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lz7lHfjTCdRC2f86a97gDkaIfbZDyOgkQMYdjRyXZ/o=;
        b=PsvAPy7OPnp43Ar1NYht4rDdGmBGouxfFW+iXBK06Jdfoe5+YpjaGOgzoX/2O5UUDt
         pJNH/69tq+ciUUNJ5hmgJCV6TIO4LMt8qJc21sv7cHlwyIu3UhrLaDvSNjX0IkPMjDjR
         kqR/1CywtGdBsUYZQ3hMSMXlcKVMHH3+4aAW371za0CBfXisq07hPs/BbUBL5YQrD4iC
         1pdJRDW1z2POarrlG2vYPQcVO3IZGOVtJjSF4sYYmVsefnOv9eO+JKm8ko6dHrkpfmdY
         xNJhd20+GwqqFxAhNCd7g8Cxgs/qSKwuH4CQM+tohHOpfTLJyurUHV5Ggj41u/q0XjTM
         aEJA==
X-Gm-Message-State: ALoCoQlZNSTr5ExCs6h/nelo50bD8UCpSqTRqV17plGnKDijhfrc0FBwn1GVr7UaLch8AVKf3Q5N
X-Received: by 10.52.36.211 with SMTP id s19mr344591vdj.7.1402439382161;
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si1396570yhe.1.2014.06.10.15.29.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0930731C741;
	Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E0732E0A0A; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251271>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 4cee9e70..5617552 100644
--- a/refs.c
+++ b/refs.c
@@ -2639,6 +2639,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2888,8 +2891,11 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-/* This function must return a meaningful errno */
-int write_ref_sha1(struct ref_lock *lock,
+/*
+ * Writes sha1 into the ref specified by the lock. Makes sure that errno
+ * is sane on error.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index e03ab44..da70e63 100644
--- a/refs.h
+++ b/refs.h
@@ -199,9 +199,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.0.0.574.g30c2c5e
