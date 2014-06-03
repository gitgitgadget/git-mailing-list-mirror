From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 41/41] refs.c: make write_ref_sha1 static
Date: Tue,  3 Jun 2014 14:37:59 -0700
Message-ID: <1401831479-3388-42-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSF-0007H4-9m
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbaFCVjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:12 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:39894 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934327AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so807215qab.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rb/BxfstuZyylZV8hb31p2D0jmRsP1PT07sk5IY9wM4=;
        b=RBMivCHC22lpqRspRWtRXfac8l5MG052uXL6+k9xgeNTj/4RuzlMP9TZ9RaPRmRczz
         bwSVRYWI+Qp3JVbZyTEGZs8lVBRTvNYHGBKwUGWjCD8z9omshhZuDPbf4aBmvBze/NPu
         rId58j1ePM6QrzxLFAy9E4vmrrqAaaQBxiNZOSc0lU4UogJJ8YWP28qQVtZhpObWdeFS
         Gg4FDEwVu4eyhAuCLx03nrfBXbNBKtDbqKnlWdpSxn6COVhSd0rgyj6vj02ftOwqLv4W
         r1p1YgJ6BEhfmtQMztw4laMuef2sQNpW0z9zWkd2xD/+gIdfiGnUiT1k4EEhPIIiH33a
         TvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rb/BxfstuZyylZV8hb31p2D0jmRsP1PT07sk5IY9wM4=;
        b=ga6ftGKZCtk+VwMEsmFJKYWszRi8F64IKQVNa1+n/8r0BwHfB8gbZHogAYHQV/eufE
         VlgQOjslqixQaYKyH86fn31r2LbD6mHzIQzlJcyGB6BUyIH2cQMuoVSET7GbM4WfJRAe
         Qe9LAtAE+O8Waa52kL4T+x9RDFNe6q12VDftgiVWjb2hK9I+0D8/dAhHFyXoJY4o5ATu
         vBEcDz6MXBk6T+bd+RkVz+VPMG87SZNnvW8aRd+5Qb6nU8bj/ZB0ii1+XV44cN8H/VL0
         Hw+XOoeDRJWOAyVI2whs+U8WE9tsFVIA45wRTK6XpPUm0LvhfP2ZiUw9mxcQ9Ny3DtQD
         E78g==
X-Gm-Message-State: ALoCoQmDcvSBa9iX+ExmJJWmjXLgV9JpdOD4zuyE6tnucEULhOY+nicfuB8FYzVyILLN7IzX2Aq8
X-Received: by 10.58.29.14 with SMTP id f14mr18633943veh.32.1401831488676;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si30413yhg.2.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 858455A43C6;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 67F71E06DA; Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250665>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 refs.h | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index bcf238e..f8a6c9a 100644
--- a/refs.c
+++ b/refs.c
@@ -2634,6 +2634,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2885,7 +2888,8 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+/** Writes sha1 into the ref specified by the lock. **/
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index 1583097..8177052 100644
--- a/refs.h
+++ b/refs.h
@@ -195,9 +195,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.567.g64a7adf
