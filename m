From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 34/48] refs.c: make lock_ref_sha1 static
Date: Fri, 20 Jun 2014 07:43:15 -0700
Message-ID: <1403275409-28173-35-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05m-0004LJ-84
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbaFTOqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:11 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:49444 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so979393oac.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CLOfjHXF1HmyGldIm2qM+LVB3nTzpjO0Wo6Tfe18tGM=;
        b=aPYXciv3ghzn4yHVeAMaaB05MlGRcEP0Mbu+sGQANGqDXGKOEBCN6JFzvhHg5rpagR
         9ud+NzafVfE9wyanvKBQ7/J+GfdlR1d08AgFzD20U9kvY60O6MFxRaoXO8VlnoJLQ36k
         Tz8AXZMV7GrG1YCjjoU9iky7IB1x53MT/rSmymQXBCK8dzFBr245MKLGx2xTISoNseOK
         aa5r0PRuiGSfSBA0UfMmoqJiovJojb96ENlq0awbaopapqS9SF3s/t6mknVJeobAlz61
         d6UZ3+/Uglx2Y3Sl5kzNvUh9gVm1wH3LjqX6xZ280dpoOz+YUnYrdWWA9pyf3LumD6o3
         +86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CLOfjHXF1HmyGldIm2qM+LVB3nTzpjO0Wo6Tfe18tGM=;
        b=kwtgQG+JYuOSWEIHZCbWmyWvT7sK2OX3oU188s1kv/yPYv1oQx7dgl8G5c2vbvm/8N
         IbYZ3Pu9ZUocSaD5NoniTUcOdDIMwKFGCjuYc3/2B5XveiCNF/Q4ImHgrD4mgGs9w2Fy
         yxYV8nRDP/yHywZ4c/IqaycZq9Iem/q74wvut6DhfsFhkpfMwW3g3VTDw2iT38pj3i04
         BCNCNSOyqFuCsHp52TRj0bnmjFjWr8dpKnxp2AcQJACn9Na+t2MVfTdBtqnJnviGRVCZ
         rQ3YZeNWImeOFoAMtC61t7LSIpdWR+iybaUH6fTtXflzPOuesidSvXGQhmY9U1pp09J+
         DZnQ==
X-Gm-Message-State: ALoCoQmLwJts9fbuU+vGK3aX5nQ6FSVRKS8Cn1vBcq6Q0BMPcISirVcql5ty578EyKLM5C1NdUgG
X-Received: by 10.43.12.67 with SMTP id ph3mr1418474icb.28.1403275413481;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si663242yhl.7.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 526765A44A6;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 314F4E08AF; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252269>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 4bdccc5..456acdd 100644
--- a/refs.c
+++ b/refs.c
@@ -2170,7 +2170,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index e729ea9..4ac4a7d 100644
--- a/refs.h
+++ b/refs.h
@@ -177,12 +177,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/*
- * Locks a "refs/" ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
- */
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 /* errno is set to something meaningful on failure */
-- 
2.0.0.420.g181e020.dirty
