From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Wed, 19 Nov 2014 13:40:24 -0800
Message-ID: <1416433224-29763-3-git-send-email-sbeller@google.com>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 19 22:40:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCzc-0000TG-9w
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbaKSVkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:40:46 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:60130 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260AbaKSVkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:40:33 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so3699040igi.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 13:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2vIJmaOqzgvMRz5G8nLohDJkCGWGKKSAoPRCb08C/XA=;
        b=i8O11CZECokevlHqADw2auKb6cD2JwLi3at7Jw1/96p6OXz3l4k2QgtUipJqe3l0V0
         PhQRxAgwHeM0Cs/4d096feOZ28KmdC+ZAweJ9uuLRd/3XEdOpkzQJBI5wgbLbhSqWlKO
         NYWGSb07LsVrQaqeT86YPimAEIIj0nAR30EEcgNsaDRk7uQgOiGvrwGyaXGeVf1VFm94
         rsWpHaJVCS6p1RtozatqT7adwU5QepGaF4NNlJQW6bvOGNnFgUi3LLmkDoo+ySQA8iz8
         gqT08vr6htN9DpJY8+3bhWHynLJ2CUXv0UHG3pZewDhfVkmHfnhJAqUzWPhIff/qcL4A
         Xz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2vIJmaOqzgvMRz5G8nLohDJkCGWGKKSAoPRCb08C/XA=;
        b=aLAIipYvdWKDAAF7f7vqzkGtf+OjqzV5iX4PI5H1jsqoWvFBKI3fUP1HqwoIAEZ8kb
         DIJAqZ1wEIFiW+/ZDov2JhYtz/4BF+/Eb0dhIPZc27ygy37bdp/0iSwmwv+DeOtB+et0
         DVQHrJZWmiUxsA2XwJzoGMY7QHiSf17AQwEEvidgLWFgCaQiKKFVrizGyjyp/VhoG10K
         W0XsSRIXj3npiiQnEk4NjBbWt/7hcuP6fTOUacsBW/z/e8neTak1bF3Oa/UK83ltXpIR
         5/rEooRV8hg5/5C1qWu/6ZvAhasXbrJQAKj2Ldld5D1MX1FiqnoJiECjA95KIJVgV/hY
         vW6Q==
X-Gm-Message-State: ALoCoQlqYdmrhU//+pp4Jdl13KbMedP+dEVCXOX3ICZ+07thOwbvJr4S5PKYy4Ob02eZxI3S3Jaf
X-Received: by 10.42.176.66 with SMTP id bd2mr1519744icb.84.1416433233191;
        Wed, 19 Nov 2014 13:40:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:7876:7c52:1268:8374])
        by mx.google.com with ESMTPSA id d140sm223428ioe.38.2014.11.19.13.40.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 13:40:32 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.13.g0786cdb
In-Reply-To: <1416433224-29763-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 The same as sent 2 days before as part of the ref-transactions-reflog series
 http://thread.gmane.org/gmane.comp.version-control.git/259712
 
 no changes since then.

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
2.2.0.rc2.13.g0786cdb
