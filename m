From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 48/48] refs.c: make write_ref_sha1 static
Date: Tue, 17 Jun 2014 08:54:02 -0700
Message-ID: <1403020442-31049-49-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvie-00041f-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933388AbaFQPyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:37 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:64520 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so1052279yha.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eaifeTL5j+qOBk+X2QV9YCVNxMmUK3XJgDD9RZPZh9k=;
        b=Xd8IY9b6H/bJLrrf4bLsyoIINVvqk5SX74G90JApY/gKvHA5HrNj88gX6D42jNh8ig
         TLDobhFde65p9A66kInYpTUD0rsxmXgTQtzcE5KIx2IiN405Iy2r1YvR/d20U9TTbKmI
         FmjhsU3QTcJWKoBpUArCqXRE80hxkW1lOyPwdKF52kS3jZicIJKvw2H7bGrOclVerXMt
         tdCO6ylDEFUX3o3VyOBUQm9Ke8AtzeWxxIMX1FpMgyJwWeRu4sCjl0AwTkvQbby4+izS
         JFa3bdvq4pJb9GLLoTkP6FJsVQ10SaG0W7RXLontPuBHuhs0WHbycHO2g26Qmx6WB2DE
         qhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eaifeTL5j+qOBk+X2QV9YCVNxMmUK3XJgDD9RZPZh9k=;
        b=LxETT0xDD8j6dIki4nKZIr96j9daZl8HQNRFulQU4D5cZp9xA7TQOjutRp3y4hLCqO
         atE46Wr2CYsjq7foReQsIfKevFFW74wYGxLytMj8+02HNzz28L46W96U56A+viVOhXOy
         od8oyu13+b2G8IxmnulJeuL1bc8H/IdJ7wvwcpvL0EUn2VRVS1k5+TFuy156WzDIW19t
         9cRpbegS9sjvCBMAhrhcJ8X4IZvOwbkEVukSGBKakV2O8k2scW9dJu2TbUQEZ/LiJRMD
         nUaf27bsgoBOjGMoFenn6UR4bNA05349kwNfO/qEX37jaOvRlEBVyHF3mIB0nP5Vqb3T
         jaLQ==
X-Gm-Message-State: ALoCoQm3rdNnusPapRjK9m9qRsyPBULSwwxEoNVWFTy39u8ufhtawFPv38nptv2lKlkKV8tTdKKZ
X-Received: by 10.58.227.10 with SMTP id rw10mr709246vec.39.1403020446164;
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1208596yhj.5.2014.06.17.08.54.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0931731C76B;
	Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DFBF0E0FBE; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251881>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 362ff1b..dfbf003 100644
--- a/refs.c
+++ b/refs.c
@@ -2666,6 +2666,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2915,8 +2918,11 @@ static int is_branch(const char *refname)
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
2.0.0.438.gec92e5c
