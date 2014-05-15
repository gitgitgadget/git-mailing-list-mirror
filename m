From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 29/44] refs.c: make lock_ref_sha1 static
Date: Thu, 15 May 2014 10:29:44 -0700
Message-ID: <1400174999-26786-30-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUR-0007Vr-7o
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbaEORaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:35 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:33520 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so288982obc.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwE3lD6+8ingjc4eJNSbARQ41N02rm51DsKP+HV7cdc=;
        b=HBxWqeg2jQVBBbZ0NORTxsnMGGtRbg/cLz5R/BNwXhVMgNW7pwkWSqE0z4Hy3wYvwW
         4bnICbRKzEFESEPP+tdUhdo6p4SDixEUPW/du1Hn+F9T3OgFn2aOIO+WNkNnzCt1yV16
         4RnP1mc5lZAdX9AceLsK5Z2wAoNbg9MqbzI3S76EBi8P64cbqXIRjm5rw/eYNyuOkkk+
         0XB7keppRkQHS/G85K8TO99TpvaUqyHq+2gBTB08war6+5Svs69F7hqtQkdO/3+oF1aM
         lEkVyaXhxVh6cZ9SPdQMYn2osoEp516L9MgYjafp0e1MF9fhdUWDyim944w4tfavzoKm
         Yz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwE3lD6+8ingjc4eJNSbARQ41N02rm51DsKP+HV7cdc=;
        b=A0J0YURwJTxrvId5+Yvzf3Xpb7jc6fvAWK8XNp8ibnuFCKMV/6/3c7P9oft26T8xPW
         MKrRHneGjxyRBweyt6nCcnU1YiW2g1twiwWhhrTIkklDTI8Qy/srace64VYFq7sP/9aT
         BTq9Lz2w0Ks0UI1CxhwcKDrR80n4oAG8t89wXjeuWdChzcY9BmsqHXr4IvllK4q7hg+s
         goEeguJPWJwCGIU6tTFcLgXIb441O75bKzdAyw4abKOD1R2ElmrOIjsMGG6/4tn7A0C0
         RT7TRJOuoNofRt69DKnHv+sIpNIwdHEbIaFycydPlgbVxv5VS86ZHkJvhJ+LT6xQ7SVG
         u5wg==
X-Gm-Message-State: ALoCoQn28btdHsjkAfJdWqOrsLUFyHjSs7ysNjxdlaVExDH3Bkpl0D1fyIMRPCxZXCuTAQAy5/Hd
X-Received: by 10.43.94.71 with SMTP id bx7mr4871546icc.2.1400175007049;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n43si22354yhe.1.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DC9D531C1E7;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B900AE038E; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249128>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index e5729ad..600f9b3 100644
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
index 796e396..221632c 100644
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
2.0.0.rc3.477.g0f8edf7
