From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 40/40] refs.c: make write_ref_sha1 static
Date: Fri,  6 Jun 2014 15:29:18 -0700
Message-ID: <1402093758-3162-41-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2eH-0002Zm-Ia
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaFFWaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:00 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:50762 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so742175obc.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bKVD8QqFQVa7TvgAAEXwUidW1m6j4CgS9nXMGddBgW8=;
        b=K9A6YVuEJg+28S/PN/mySiKR9Mx6GJkJQljCPXI3eLXUOtqu2WL0QA5bemlmJnn/qI
         U8JyGIkNVPrdz6ANs6b9/sjwhHpaPEMglcv1EbESmcEwYpTmfbXhTcvP9k2Z5mnZAlJ9
         SkyFyXk1SP8+dtWMcvYxQPYrJoPCN7YdNWGl1pqyY1XDI4p/zZK2ipQCU+M1U4SeX5iJ
         CNKiXCpF4uPsBd4yD5yZ4fjO81zmlkdb2cV+7+x9GMWV/vwISDNB1GI1/RrH5pbHfuAS
         aYrv+27PA7vN7zbRsGoD6gmN6fue0R9VUJXKYjlbgH3xH3XC/9vs8NQyleesJuhzDK7G
         a9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bKVD8QqFQVa7TvgAAEXwUidW1m6j4CgS9nXMGddBgW8=;
        b=HogxPWWHUhc725euhs49lK94InegOghamG8wUr9z5icumZt1WaxkwLiWLEa0Jd3upJ
         9UwPMO3Gu/DI3Y648lH7e9IhztUdxM8IYfOBkc/dEApstnXZJeF64CId0InElAR3Hj9M
         VqVhgY0x+ZHpMLiquDHj2te3puPw1YpU2+tj7wKeHWFVNvvaHsAsoQYHWJFBus/xv9Hk
         M6X0iqSebqEYlSQfGBU0PoWcZnL3lRVT2iV+yOmi0kP9fXIz9GqLuZRfhnEuR3M+wE3D
         ed1l97zvmRaUaT9oWBIZmwRV3ZvjvP3H2EL0lHwide3CcgKDf7zSQHa1bbO5Bpmbzo05
         jbNA==
X-Gm-Message-State: ALoCoQkjp1o+txk6xKh2zyWHyeJMO953aSha03IuSJZ/FziU99KFmOn6u5IJRldAAM7fSU/c5Di5
X-Received: by 10.182.118.162 with SMTP id kn2mr4451825obb.42.1402093763434;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si751223vda.3.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 322F031C62B;
	Fri,  6 Jun 2014 15:29:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1269EE047D; Fri,  6 Jun 2014 15:29:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250987>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 refs.h | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 9a3a501..c9d2a89 100644
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
@@ -2882,7 +2885,8 @@ static int is_branch(const char *refname)
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
2.0.0.582.ge25c160
