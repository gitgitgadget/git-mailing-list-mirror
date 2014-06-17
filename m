From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 35/48] refs.c: make lock_ref_sha1 static
Date: Tue, 17 Jun 2014 08:53:49 -0700
Message-ID: <1403020442-31049-36-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvjn-0005YN-PI
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933312AbaFQPzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:50 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:42534 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1489372oag.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gQJhJkiyOj7PMTD/E9/BI0C+CLpPcYm+25sJGRKf+YM=;
        b=bOyq1lDh8sNEi2rULsTdcZ6PR0MK/142Z6dllEE4C0uVeEFLoz70iS9q10Na/6B47J
         B8buJTRDMJOrxMbGjHvYoR9aycUtZlaFeSArYzeyjAgDgVB7c3W6S2peHr4yrfRbX0Ww
         zZN8bYnuylbigYj67miKZih+4FzbTvDxNHWF1Dp/nVQjZ6QGIfjMbNT9BhZIqCUTzcjt
         p+JlugMpTQnSF60WO1uMJmmVT6qOyMF0aBd6m9quBR9Cgbcljj6m/0jU73MCdIywvypt
         f6WapJ6Gqk1E3G6S2lD/3jiYQwW2giT8rMJy/kkdjZ5SEe0MuAr1egSjne3AL9lm3ZB5
         9iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gQJhJkiyOj7PMTD/E9/BI0C+CLpPcYm+25sJGRKf+YM=;
        b=EbqNmHzJIt+0aus7FUojS/gQeyeR6RmEAvv84ViBSQSjJWNDYY5eDr5c17GNmY1L5b
         WaBDOLzf2Cqcey+WTZUiYQuWRMDlyeAl0XK4eWEVI3M1jt6L/4T7j39VnjJURFepdwnA
         Wz6x+wjTieZdpbY16ZIIhh4kH+EuS9bjqDC3yiuvVvbkJd0/1/Dkb90OJu+BexHGjd+n
         RbSajY4PNlM0aeAeoijyQG0T5zvBmX2CYuW6nP2oDkwGwbhLygABpi0XZQSSrpzm1dlU
         qrGCSThdycHfyU0rlSbfEFV0jxQSKkgnEqPuyIqKFvxJVwZEpe8d9oY9JUwaIlSaybuh
         fYdA==
X-Gm-Message-State: ALoCoQnxvH2EtWGqQrqm7OKE/DhJoF43SfLYLMjq8sX1cceupVyCPkQvg9noGLUNx3vp/tgpimuY
X-Received: by 10.182.86.5 with SMTP id l5mr1351571obz.32.1403020445648;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1208716yhk.4.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7A94E31C76E;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 570E6E106F; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251894>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index af211b6..56a52e0 100644
--- a/refs.c
+++ b/refs.c
@@ -2171,7 +2171,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index e94cc27..4ac4a7d 100644
--- a/refs.h
+++ b/refs.h
@@ -177,12 +177,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/*
- * Locks a "refs/" ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningfull.
- */
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 /* errno is set to something meaningful on failure */
-- 
2.0.0.438.gec92e5c
