From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/2] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Thu, 20 Nov 2014 09:39:10 -0800
Message-ID: <1416505150-1913-1-git-send-email-sbeller@google.com>
References: <20141120011136.GC6527@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 20 18:39:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrVhV-0004yZ-1v
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 18:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807AbaKTRjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 12:39:17 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:63606 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788AbaKTRjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 12:39:16 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so3227729iec.30
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FuC+NxHaNS5z6XDKqPJSDdzyynXY+sO8Kn8jPWTG030=;
        b=GGm0pov+gagwh7lIxrmgqnHQyTeDieGr2oykj4HbRFd6A/UnyYF0MwaGznj6bOjhlW
         RH5jueYPlQOlftqDitzUWH3ugF9Fk2HGjNl+Le3Swasog4aVBLqCpXS/4OvvbHwfpK00
         BYIPZ+YB8a6S9hCQ8P9kb8ODgG9KfdHD1ZSH4jpEQHkTpDXS3uw8Py62vQaTZYS9n1QO
         /1jsohR4cJuwaQEgubhtr+T1zVRhlDzzYjYGYENRY41Id1jIsWz4huAlndnRmD7Fh5Xn
         92D3po/VO0mooFDFkomVj9Qf5Gp5vTox9edn0zYAeMdHSbNC34oEkT2AwyobjxGLGnRj
         Qe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FuC+NxHaNS5z6XDKqPJSDdzyynXY+sO8Kn8jPWTG030=;
        b=XeWVPDhZ/iPTmHif5LOZP4qbgx4qfa8EpRfyZRc405G8k6ECePPDEMhbSDQUGnH9j7
         TAAKxbcwkiiH8BLgcmO+erAuRsbGNyKhIbPbRkeFaNFZ/ob0KfZ1PUA2Wy0bIXapavGe
         DddK3PbUC2A8wMqFlS7/LCNtxiB96+SHbrKXb3MVkH2Zu1FW0yR19RXXFzrZP14mwWEA
         8aZGmnlVBYrVKcX7DIHcNyS8ddXnMkhxELmJiWT7No+p0tg2dVixbxZ0vZiibVUDtw+p
         mHWSIIdD64QgoT7fr9dD9z2KKZayie9dmszXiefGlb9Pw7jSnjK571Xvi6jCSK5Z1PmJ
         AQ4Q==
X-Gm-Message-State: ALoCoQkpD4obRArhlc0anplIrzNSMNaoQnARhwm5FQEnbj0LYO/6jkHdGdptQhR+bhvqdiznldWB
X-Received: by 10.50.164.226 with SMTP id yt2mr3794734igb.22.1416505155195;
        Thu, 20 Nov 2014 09:39:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:2878:9312:86d2:4f27])
        by mx.google.com with ESMTPSA id ga3sm784884igd.10.2014.11.20.09.39.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 09:39:14 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.23.gca0107e
In-Reply-To: <20141120011136.GC6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

no changes in code, just removing Jonathans sign off, adding reviewed-by 
by Michael and Jonathan

 refs.c | 22 ++--------------------
 refs.h |  2 +-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 005eb18..05cb299 100644
--- a/refs.c
+++ b/refs.c
@@ -3633,26 +3633,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: delete called for transaction that is not open");
-
-	if (have_old && !old_sha1)
-		die("BUG: have_old is true but old_sha1 is NULL");
-
-	update = add_update(transaction, refname);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old) {
-		assert(!is_null_sha1(old_sha1));
-		hashcpy(update->old_sha1, old_sha1);
-	}
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 2bc3556..7d675b7 100644
--- a/refs.h
+++ b/refs.h
@@ -283,7 +283,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
-- 
2.2.0.rc2.23.gca0107e
