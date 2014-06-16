From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 35/48] refs.c: make lock_ref_sha1 static
Date: Mon, 16 Jun 2014 11:04:06 -0700
Message-ID: <1402941859-29354-36-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbI6-0004n2-Kl
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbaFPSFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:22 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:53988 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so1155778iec.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ia5+3bPxOfallJrmqSk3pD/cGUY2rZgtvDaYwtWk8Bg=;
        b=JyIssyzL3jXJ9xqOVNRtUULHUMo9/G0kDN6DGvQDeolPH+9irQgXkRnkTGqS1xW0cG
         Q+wFL4r+Mu/KpaBQpIFSzBSL6J9ppq/Mq5301nhSBz+zLTelNyGIl+pgRZQOm21Wgj1I
         xnwoc2r0Y21RpDR1E/TzhkJq8pnS/kh3ai4WmN9Fb0ppCNm9XfY2W86POKB+56UyFKgi
         ccPPixCmYLEK/yMNY3iZ6bucLMUnOXyLEhZogd6u+m5dydhm/uc8sKgPzNh6i8L3kC+r
         gMOxNcV4UacoNyxYxTS/tSvOuqnepuo7++oVosOhqqXUxYiO1m4eA5qiScV7uD7MTErv
         NLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ia5+3bPxOfallJrmqSk3pD/cGUY2rZgtvDaYwtWk8Bg=;
        b=TXO+JEZx943L9vMaEZ4OLau6lzf7uIJGM7ViXuZe0zJ2GWnoYfsY03fOT3PyfqbZJv
         jHt8qIlZyTRkI7SeU9pMqUhmzREbljKwtBsH9yZY1r4GUvcrMiLpTsjh9OKjzdtJxrPG
         OeAipVXO/pyw4eQGLiT8BO0m6qlwMJVU1eidG6sBWOPNjIUfISv/T7//HqYucydQeomI
         0yNKb9+oHHq66jjJBHGYNlaWMS/xD2bKlyzSyXyAgZNNwEauYbocfUjzWT/G9kT9K1EF
         yS1fvPaWZnke4m00VawirR2q/h8jq6m9KSystzzGc4Yk8NRpYmymyPGDF124QsfmtMKN
         kKXA==
X-Gm-Message-State: ALoCoQlSBM1nOwHwn7MyVRTuOXcwwG9dbVqvNj6vPqemgj3cS6r5Fob/+e726emqXpQiSmJfNvmI
X-Received: by 10.182.166.36 with SMTP id zd4mr2814518obb.43.1402941863756;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996135yhl.7.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 98D1031C8AC;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 77B34E0961; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251753>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 50e5475..bb12e65 100644
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
2.0.0.282.g3799eda.dirty
