From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 48/48] refs.c: make write_ref_sha1 static
Date: Thu, 19 Jun 2014 08:53:30 -0700
Message-ID: <1403193210-6028-49-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxef8-0006a7-1I
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbaFSPxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:55 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:54517 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758079AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so290912pde.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3oB7O63JL4t1rlJLn+OI4hUVar8dOFbdfqwNslRKUo=;
        b=UmEiJa+W/yUJoLL6ow1xpfYUNRGHeTnpTmI3YizJTE+dRw//WNyprxHJK9eFEBCBwj
         UAn/AqKgHyBZy3qVHyMUyk2Vvtv+1Z1253gfcH4M1TR2gv71Z/C6Jk7bCmJ5DbwBA1Gx
         ms9WEEdXECngSCxjFkPsvQZl/bQRama7quoRIrGUUrXZyp/iS4T/oorwlV1dS8wbfNoj
         LORgOtfs7XCt58DvXoXjOd8VIFlgQJtpbDfXap/Y7LLdnTOFP3VbFpepD2JOOsq52Ir0
         fJRyv1FKumkGoCv0RBgCRUZnMLsNWpEdHzTW0RubHMyAyK8bxBlGklCEHg1yCvnNoOQP
         mRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3oB7O63JL4t1rlJLn+OI4hUVar8dOFbdfqwNslRKUo=;
        b=RV1onhJ9tL5k0sTauaeIjyuMy1ArIbqqsarbS8TbeONXo8/0nHS8q+axjlmrQ47vQa
         Pk7l3rPnzIcmucaB4MmQPo9hQDNhrjBkK/u1nc6NHn8+WtR2jSsW96ybdG+FZ7x+LhOg
         b6WQNxFC4W49DY1QeG9FAoB/LvXz9qeHYe5put2rucgVIT8wmdAjNa0sv94vyFFnhaq3
         bJflI+bSvBqbefnpmXL5EhgasXYUlPK9n7JMEigMlg+1G2DpE/e048ZkOWFA2cRFhziC
         giKoiB2Vw5uWaLMhqqNGrNutlaRHfSqDk5myDP07ErfGDeRBqDGeh40i37LmV75pOWJS
         8ZhQ==
X-Gm-Message-State: ALoCoQle+1LkQEfNma4r+ygnRhIhgV2o/lIgeoovgm/tZxswBRMoNLYeAvuV/2MbO9x0awgTV5vB
X-Received: by 10.66.66.109 with SMTP id e13mr2568292pat.1.1403193214718;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si419498yhk.4.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8633E31C416;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6A645E0FFA; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252123>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index f4234b9..1529a26 100644
--- a/refs.c
+++ b/refs.c
@@ -2665,6 +2665,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2914,8 +2917,11 @@ static int is_branch(const char *refname)
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
index 5c0543d..db463d0 100644
--- a/refs.h
+++ b/refs.h
@@ -203,9 +203,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.0.0.438.g337c581
