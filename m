From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 41/41] refs.c: make write_ref_sha1 static
Date: Thu, 29 May 2014 09:07:56 -0700
Message-ID: <1401379676-9307-15-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sj-0006y9-3L
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbaE2QIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:32 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:38888 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757472AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so105525obc.0
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EzNbSGLrT+8VLkz6igFyqj4Q8tp+e2YYqAD4mUHlcrU=;
        b=iR6cT3Iq1K6EAl2mm9ildbRNKWevFCNWP+9lADkOYQffX8wUcsCWAbwBCOg/Uz+cVH
         YDrvpdHbWKZHvX3fM70r638C+CQB8rlpv3qh4QpnRVffhK2xLTgry0/bVjV4Zh0xeyI2
         d/fwTjaB5yQJBarJ3kkCmwx+iSgz1bnlfMqXv3pO8r3ZoaaWIcqZWTajCXImjp9h55yO
         6qgoAe0lK3juZKNPTdLaBqMf98f/TkMOpxXyfY2kih2VWlRSuNgjwh2vD7wKYk9pKz2V
         DPXpyNtakYmj9nc2BNDbD5ZHB49OmtRoEmm4d1QNllPWmmfCyR3qh8m/Ipp2EKlWrZdT
         Uk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EzNbSGLrT+8VLkz6igFyqj4Q8tp+e2YYqAD4mUHlcrU=;
        b=bZcn3yhXz76+rCd8TZnw0enKhSvRafEX8dDZ8Qfabbart7CU5oII4bZt98kJf0NOb1
         qvkfvzEsQCdYwVlGx03aCMJkJh3sO37iRf7RFfw53g0SezG2RsxquV7UHeKHf05OiwRC
         e02Z+LsT04MfBaFD/HQ5g2BT+6p+a8mOLbKoHubFge3fPIJ/A/6gjf5KXCrfO2CaEM2x
         cdaeGfwBjIU0yaD6pGi/0DFJuLbttthcGAc9NXlrIyTLHI0Fw3/p792SQccP/YAa9jaO
         8iF57ZOzAFmoHTEnSfuxQWc//7lnVJ0yLAaPxguwsZ26SmDAoGvKUfTXoZog3WK4eLMB
         vHCg==
X-Gm-Message-State: ALoCoQmzvT2PJW3vHbIAgbl8503u5Liw22vuMj+PH37dQJyp89P0ZD0IhkHNdaAyAhQvecP8DSiE
X-Received: by 10.182.24.104 with SMTP id t8mr3477817obf.34.1401379679715;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si81366yhk.4.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 8DABA5A4351;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 62CF0E1167; Thu, 29 May 2014 09:07:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250384>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 refs.h | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6414afc..aefa5bc 100644
--- a/refs.c
+++ b/refs.c
@@ -2618,6 +2618,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2848,7 +2851,8 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+/** Writes sha1 into the ref specified by the lock. **/
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index 88732a1..88020c5 100644
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
2.0.0.rc3.474.g3833130
