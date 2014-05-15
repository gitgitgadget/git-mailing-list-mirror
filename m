From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 29/44] refs.c: make lock_ref_sha1 static
Date: Thu, 15 May 2014 16:15:26 -0700
Message-ID: <1400195741-22996-30-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4u4-0007kY-3O
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbaEOXQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:59 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:55582 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-ig0-f202.google.com with SMTP id r10so7537igi.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UEX7fGuPZlbMtnOwhKKui+MP170ppAdzdzSuK200MpA=;
        b=OdT6wn9nS/H/OPvckdVzPwaqEXq5J7lF1sH17HHIKy2pTX54vKnBwb81ne7MyWDfMa
         l/arWrKzm3hCLt0e6gsvQ2/Pwi4jOMd+j2bNT4ta7HJ6Y7EblI93uJi+xJ8goNheBFht
         qo+IV5sYFlh0C8v4T7KCaGkFrYlKJEJqOV3M3R9yJFgm5U0tLdTMg/l6S/OBj//wvKb3
         b60cC/SigsZKcCZXxacNlceFZhP+IUNZaucc+Bx6qc0nz1zZzD7cFUnNCtwL2MkL6noM
         R2xAQyeBFU8HthIXOhNmsoHwDp3CYTsCknoNtVdt0XuiDCLFUIiw6h9wMe4SDGpXlrQR
         v2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UEX7fGuPZlbMtnOwhKKui+MP170ppAdzdzSuK200MpA=;
        b=M9K0o7tZoNUUeu3I6NpP6vSoZmszu5NlHdmDf1+ntvfI6sUlqsNYwPKCZEnWz+WKmP
         LSYOMSPpZQQyQlavmm83EpE48k9qYA7z6RF4NkASgVBqmCLcmlAh9aaU4H0M+Fox4KFO
         qrfXsFej/IV++JJwVj7uBEqa241kescxnhyCoesVPxMhjpegk1W1xIhPpEzOpa5ZASbY
         H6v7uTD3JhaQGdY7YBEWB8V7+Ip/02dI5iz1ah6sH77x4ie8Filw5SxOq2pueNiRWikV
         CPnc/I9wYEB6QBCSWwUbMQKFCBvi1JAeu2T9oCQ7s9X0Un4x6jlKdr4ci3z9Ww6QGhVP
         VETQ==
X-Gm-Message-State: ALoCoQktcQZhOqaVvA6v19oyueOmlIBYOJxEJopWariRwYp7fuw0WHZthKskZRsy7meBsZKRCltb
X-Received: by 10.42.30.71 with SMTP id u7mr5478589icc.15.1400195745903;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si318883yhq.3.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BB5C331C2BF;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 97C70E103B; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249252>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6151c3c..733dfb3 100644
--- a/refs.c
+++ b/refs.c
@@ -2126,7 +2126,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index a45712c..832d81b 100644
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
2.0.0.rc3.477.gffe78a2
