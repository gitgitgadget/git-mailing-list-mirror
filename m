From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 26/42] refs.c: make write_ref_sha1 static
Date: Thu,  1 May 2014 13:37:26 -0700
Message-ID: <1398976662-6962-27-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxl6-0001wU-6K
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbaEAUiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:54 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:59406 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbaEAUh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:56 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so146479qab.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=73AXCkZoI4CDERIp+li5H9olw4rO9D/wnuyhmnHHtzQ=;
        b=AYQdZpZL72W+WDC8IXB0vNRKpivYQRkaXfMEZ0OWO1d7FbFAfji3iJG05eGzbYxDVa
         vAhQ92ifxnNj/RpNYH8eUGgQUguM/v9ucrt7xVgNdp3oCPWjJLN5h/iKtHJtsp4LxL2l
         cHr26av6Q/A0zBxttmkaMDNi6kmTr2jawDEolDu7E5PrjtD0o9crcujxh8HwazgNaP+I
         ZVI7Q2EE9qT4cLN8VmkuwpW4Yr4fjXCry9m887ieniu3VJVgg6OLcaUn/UMUynvz4a2V
         dzk+RRxnistK9lKH5Ky+HIyrxw5pz5HtVjos7UMtNWDIWPNn4I9Gi0mliCAkgeIVkNEo
         TSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=73AXCkZoI4CDERIp+li5H9olw4rO9D/wnuyhmnHHtzQ=;
        b=mSAvWgwOE1NXrt306KERtImUV+hBBvhwiucls24LzwfynXYjJb7c69VcL2NhhgJ2dk
         e/RguAL75ioTsQXhfm5HBCwgMl2gCzD/oNvEkmbxpSMXQ6i65dUT1Nybmm1aXUuZ7gAb
         uNtZWXr70SdsMrepr6zkG5uQeQLk4vJ8J3kHg95D0LQD6/eMhJb8UHlh4+v9KMs/wKPG
         9keg00jsAkgaZDZBbt4/94zaWc8JtilkO2TFFAPld3HP6XDn2SZwLVr7WM9+xB/q6vMh
         UVeoYXROa8P4IL/d800XvmwCcIDnpDjvzqfJJDcsjkpJWCDNZ0mYaarFRcWZAWGmTc4v
         cKxQ==
X-Gm-Message-State: ALoCoQnD+EmqieodXOsUyjCCLq96Lg6QnLXjCezZPYMBM35vHumc6xgRPupkSJXYrAViHF49WHsi
X-Received: by 10.58.82.193 with SMTP id k1mr2513092vey.41.1398976675680;
        Thu, 01 May 2014 13:37:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si2198365yhh.0.2014.05.01.13.37.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 73D5E31C1CC;
	Thu,  1 May 2014 13:37:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 38FA0E0A5B; Thu,  1 May 2014 13:37:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247855>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 refs.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index fcbdf9b..020eadf 100644
--- a/refs.c
+++ b/refs.c
@@ -251,6 +251,8 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int write_ref_sha1(struct ref_lock *lock,
+			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2798,7 +2800,7 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index fcde43e..bc8a95b 100644
--- a/refs.h
+++ b/refs.h
@@ -150,9 +150,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.rc1.351.g4d2c8e4
