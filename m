From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 13/14] refs.c: remove lock_any_ref_for_update
Date: Mon, 17 Nov 2014 17:35:49 -0800
Message-ID: <1416274550-2827-14-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXiZ-0000Mh-MH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbaKRBgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:24 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43882 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbaKRBgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:11 -0500
Received: by mail-ie0-f177.google.com with SMTP id tr6so3975447ieb.8
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VE8w0Nzf8PFsOxKX/2ElFh1KW1YAxSb1JJekndTF5Xc=;
        b=h4J1D+UlMy3dKIJOg1X/1/km4WkmVE4wgDQalBNqS113zzgHiuz4LWh96QiCWnskqi
         sdSD9ZdmIcmqTlwMF7n2Y4xRRHrKzvM6CjhGYkHARvA2mq9NnyZRIulCYfxBjjmtuKe/
         P2h7CsU56XDKxI9dVMfKLT6ZzXCYtBEAPrfmbV+aPSB32Nqy1hEYS9sUvMYa0Z8ii/Cx
         tvxGLsFLe7fn59jbn8Ymne7jZrk559R7OQZMRuwREVf/+0gluecDH4Ff7H4Z/M9uisYn
         pRVhqKu3ilRTK1DcjKNJJVhvZ+Hjnlhd7WdAlM/yt2+hxQxh2imR20wyfH0iUxUfqSf3
         QKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VE8w0Nzf8PFsOxKX/2ElFh1KW1YAxSb1JJekndTF5Xc=;
        b=I/DMH4B9eB0LE8Xa8D5/c10uC6JrxLP9v8w+9kH+RNkS9o7HYHyffZ1sb54ATVGsZk
         9ZG0KeFofugM2aYmxmozSXvjJHt9UBc+UItiR7PQP0NJlWjM7w6G3PzHjcksoWCh0i8/
         Q9oQsSGYcoll9x4be5iC4HnJRXUwAbXHRc0+0BzcxgLnYm2iLhyA+mFOn5V05ftaeNPs
         nwwWYgBFNrUJnax4auVdbb607fbsU642cKWYKbI2sadpM1J+zYdUgra0F+VnYhqNBCWa
         81Apn2EA/0w7B/2N4aFOngiL29wPoOAg2M2G1BtTjWgrjwep4/S4nBd4uElQyAhv7uPd
         p9yA==
X-Gm-Message-State: ALoCoQkMW4Vn65N0u+w2CehiY+dQYXSJOjuUFOmFeCciqoIkxXcKRbSRy8jK+0GGDSKukxMrYY4k
X-Received: by 10.42.71.194 with SMTP id l2mr5210979icj.71.1416274571180;
        Mon, 17 Nov 2014 17:36:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id ig10sm6855502igb.18.2014.11.17.17.36.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:10 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

No one is using this function so we can delete it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 7 -------
 refs.h | 9 +--------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index e49ae11..b318888 100644
--- a/refs.c
+++ b/refs.c
@@ -2352,13 +2352,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *refname,
-					 const unsigned char *old_sha1,
-					 int flags, int *type_p)
-{
-	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
-}
-
 /*
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
diff --git a/refs.h b/refs.h
index 025e2cb..721e21f 100644
--- a/refs.h
+++ b/refs.h
@@ -181,8 +181,7 @@ extern int is_branch(const char *refname);
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /*
- * Flags controlling lock_any_ref_for_update(), transaction_update_ref(),
- * transaction_create_ref(), etc.
+ * Flags controlling transaction_update_ref(), transaction_create_ref(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  * REF_DELETING: tolerate broken refs
@@ -191,12 +190,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  */
 #define REF_NODEREF	0x01
 #define REF_DELETING	0x02
-/*
- * This function sets errno to something meaningful on failure.
- */
-extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-						const unsigned char *old_sha1,
-						int flags, int *type_p);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.2.0.rc2.5.gf7b9fb2
