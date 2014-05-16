From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 29/44] refs.c: make lock_ref_sha1 static
Date: Fri, 16 May 2014 10:37:17 -0700
Message-ID: <1400261852-31303-30-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6T-00027x-Mc
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136AbaEPRjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:24 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:54726 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757971AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so886248vcb.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kCp2bjqB2i5xWykbPKnXBTPuiCKLRkwtLFLU/uKfyKE=;
        b=e+xOlREXOQ/S97JCm9Wv3Zz9u1VOhYqwz5XZ7LTiXJzEjdJnKJLuorvquErpAomuwx
         4SkX9qP0eeRTHfYLHaENzSmfqLBfekVbw2ynHqAQ7SAjZhRu8NKqMdphNV2U5GLmFogK
         tKTOJR39XGoySu+Z5tblONlDGJTklcoIV0aKg/7lysGZ405noSJ6kG5Ub55reb2SbvDT
         LwEKst4/WMWlpYxtn0b8lpMsILxlM6EymBpM3hVJIj2+7mQAZGlOHA6Iee5Zjp5irofL
         6Is+5SCpPCGFS0+7tQtCFxP8v4X/i12TCYzrf+0K8lbfK/l3mCLoufNCSvtP72sjCtoU
         PhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kCp2bjqB2i5xWykbPKnXBTPuiCKLRkwtLFLU/uKfyKE=;
        b=fGMs+KjA1bL4gBYedT2miVjDYPgLX01uXeO6OeUIK9ZQ3AG+u8PJS2oQ7eNO0Ko1Rs
         VJYq2md8fI4jpsEfru7dsmjFD7iRA2xkDSlkuC7+L33m1WhxbTZ/R+WWkzdQsFz0SPpz
         p3B87OmLKVYxa91MnrdZz2cIIXeNk0fstIZ0Hz2XRGHoI1+nOcwnz68XZL3evn4mkdB2
         rK1kdnbhzzfSm18vGa64QT1ThRW1a3Nr3xqAXZ8UDSRPDXp2gvlfFxol9qvAU0E5hfzf
         JDKpK/0FV5JoAnODiSf0NiVte2PFI4TKWIOZzV4E+ek7VwKSXNMZfsoyvN0LA0stO3qu
         GZKQ==
X-Gm-Message-State: ALoCoQm5C7o55ERh8nI3tXqoohOzwzAULGEtbbP9NdBSCvnCllE1yMDEqvAztXyWIeR0YotGawZZ
X-Received: by 10.58.18.200 with SMTP id y8mr1109623ved.20.1400261858033;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si441759yhb.6.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DD1C45A40F6;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BAE42E0D39; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249382>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 93e2cd2..2d9789f 100644
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
index 0c4d043..90c7fb4 100644
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
2.0.0.rc3.510.g20c254b
