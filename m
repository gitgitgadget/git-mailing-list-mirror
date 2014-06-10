From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 35/48] refs.c: make lock_ref_sha1 static
Date: Tue, 10 Jun 2014 15:29:23 -0700
Message-ID: <1402439376-25839-36-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZV-0005nz-1G
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbaFJWbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:05 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:51038 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so1417576qab.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pld1VqcTnazD1VDSqkXiJV/X4zhl0cac5zIhGALsgVo=;
        b=kSuIN5qD/CvjVgU7x+GPvV/NLdLtyIcvCyRGNU4hP4clc7tBeovdJUt6rSzklNMVOA
         udp8FuJ3U/m/1bAINZmrGjXwi7zT3/J/jbLH2lJovjPbjDLwqOiN52MCVlS9vxO765Xn
         zlXPcf6yh2yWhrGjPxxhsp32oDBqGjZtAg9z+FwtusZd2e33gTvjmihWym33OkeT76lg
         4xkW/M0PBFv6oZitmCpQIan6RC71XsQfG3CmqV5Zy6Pdntw2EmJ4KNlwzV+g8Xqn+3K3
         h+KQ/u2zONYizGsoe1xErPZID9k7ZeQ7w8prdZeWiE6GmzEFdotxFG1mi2mREeqL3p5K
         6VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pld1VqcTnazD1VDSqkXiJV/X4zhl0cac5zIhGALsgVo=;
        b=lUg2SqS+mG8b6QQpX2C0jJ0DY6MaskN6ZlZbTPyh8+aaoIjPdllQT7rhuXEMBEZW+Z
         QjlA6yG/Sg7c8HwFaW6ql+l5OP+Zpbafel7ECCv5ppp4oti8RUpOhBIpt32cMjSH8xUA
         1r6NklvJAf7bPlrTC56/G8FmvsAVx4P6OOte0n9ASncPrDY/VNP+I+Jem4hMBeV5C4XQ
         ASyk+Hw5NnIShdxM+R9/UdbaqlEc8AfxAYn+shGHD9JSEZx/Nm8vGTxeJA2/x9XfZXiV
         m5BzWGv2f6yxJPlL1WD3LV5yaBOf+2+7Np/Br2OVCw+yd/WTBZchQrxaEuTztH/wROlO
         RxJw==
X-Gm-Message-State: ALoCoQnp45lWlLE8DPVY4IW0BOMBIZ8hV0d+LUjwc70DIBAMUFyE7Cer1+ulKlmvgh4EiV0vQ+XX
X-Received: by 10.236.87.73 with SMTP id x49mr5960095yhe.30.1402439381498;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si1396566yhe.1.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5C8105A473D;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3B1BDE0616; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251287>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index b9a6adc..ace6f87 100644
--- a/refs.c
+++ b/refs.c
@@ -2143,7 +2143,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index c27467e..21ec3f9 100644
--- a/refs.h
+++ b/refs.h
@@ -173,12 +173,6 @@ extern int ref_exists(const char *);
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
2.0.0.574.g30c2c5e
