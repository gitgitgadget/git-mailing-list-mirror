From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 27/42] refs.c: make lock_ref_sha1 static
Date: Thu,  1 May 2014 13:37:27 -0700
Message-ID: <1398976662-6962-28-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxl5-0001wU-LC
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbaEAUix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:53 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:53941 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaEAUh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:56 -0400
Received: by mail-yh0-f73.google.com with SMTP id b6so549326yha.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IZMqyULmk0q4uepIcIcTI6VoXfCnqeaGf/jhLr6OOF4=;
        b=LbeDZ1PzMzcITHnvWXDatEzFboafV9rblwLB80IIpfbgc1T20vKw6NzVpc1shwXGaU
         6LyEA7nFxuC3jexoXgtO+XKbY+zdl5eSbyNrFwAEkdilsEWcU95NWmKyxk6a9HBvphHt
         rAOPnIfpA+lS3jPuSbN2XrQqtdOEGrbfsjvdbpFy5BmoYsmbH7Txksh74BCCGalD5Rn0
         pIQTjxkEqPKUfsdEqecekX6w8LKwB5y0EXkkH+5XtHX7mqn3AbGdbprMkSor6xSNkOTm
         4KsfgrmWVkOvnOzOjia5wIQcshX4w44nd9LZtL1hu//1cpqbH8p+BClWldLgCJ2tWNbr
         iJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IZMqyULmk0q4uepIcIcTI6VoXfCnqeaGf/jhLr6OOF4=;
        b=VWUdRRJNc+FL7tYixcHAA1hyxTOkXCU1jBrYbVkgkTy8uwVeQ3K1WqkuMi0J8K/V+Z
         anlKhVTFmtkfm00rKqOm/8oJYsAdy3ER+vJ79BBW858QgSa6GW+tLm95r0HBXPrXLzKR
         lKaXPUnm4uwkSHImTcNskXhcSgpNRDCg1z8piMoVfSrEaHeNTcs3eaXBaJLP7qP8mzx9
         ycS2ofAWzE46RHXwSNhxf80RnvGLd9HXeL+23uLeCSq+HPdwxsp3lUcxVBSJ2AVnfzXK
         btd7mDlHkwxfcXAaWNh3nPDKcUtKqBpdE6NhtI2DCONqPZHqJ2zqp4lRLQJJWgleiWqB
         gsTQ==
X-Gm-Message-State: ALoCoQlE+bkxtni236SSCMBnWitesXnI8cMa+nb1bNFvXiYYeI0dbWYgVEvk95oKAN98SS87TRMH
X-Received: by 10.52.2.129 with SMTP id 1mr5924170vdu.4.1398976676038;
        Thu, 01 May 2014 13:37:56 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si3104414yhj.2.2014.05.01.13.37.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:56 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D42E531C1CC;
	Thu,  1 May 2014 13:37:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 98CF6E097F; Thu,  1 May 2014 13:37:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247858>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 020eadf..a82d6ba 100644
--- a/refs.c
+++ b/refs.c
@@ -2130,7 +2130,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index bc8a95b..b14fe86 100644
--- a/refs.h
+++ b/refs.h
@@ -132,9 +132,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-- 
2.0.0.rc1.351.g4d2c8e4
