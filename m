From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 12/16] refs.c: make the *_packed_refs functions static
Date: Fri,  7 Nov 2014 11:39:01 -0800
Message-ID: <1415389145-6391-13-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:49:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpXD-0005jd-AK
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbaKGTtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:49:19 -0500
Received: from mail-pd0-f202.google.com ([209.85.192.202]:34473 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbaKGTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:49:07 -0500
Received: by mail-pd0-f202.google.com with SMTP id ft15so641620pdb.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lnoSAl8KBoryTpJtQ+Wpm1VO+U1l6SnlGEysAJwEkZM=;
        b=jrLdAytCAGZqPo0wqnJvtRjmtfLAHGCRIBtFQO03p95enVp2/86PODoQs5Pbjt4ADP
         kl1DdTMQKd05UPkBwfRvT3+lZSDRKWvYKF0zezfIAmGHZUgRZO6GXBNBYoziubPqOERP
         161iLXQTubzX/md/Bw/UcGMJ/gUZMntfxZarD3ncwOT3ovkmkNoXmVvzSmtqCx68yZVg
         KpD0vqAw55ZGzfMjkZZqnzaQYl4ROSqcIH9tqFJKiQNKQaGOMGPFZhUptw7citl6Lrpk
         sstPYPFmUy+iDJY21DWNnoZCaRNjJCnw+I7yj7buqcACVAwKuosJjc+4akl6j+Ai/+xp
         Xk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lnoSAl8KBoryTpJtQ+Wpm1VO+U1l6SnlGEysAJwEkZM=;
        b=UgUlXo8QLUBizpaSS/TmBTqgQCxBMQvHUVYncpBv9fSJ78r2xS+6lmwoobrjB0c0Kd
         XECAzeGZqtxYI99McENl5ta9GfmFM0c90NJcVr74zoSudi3i82d6WzaxpVKmWoq/Op5U
         qDpbNESxe2R0LvOqCnAqdEAcufj3w56vW6c3EhuIVu4TKmQ8wPx6YprrZNNQ32MShbcQ
         pl8sqlyA8a/HS3v+UCMek8VvZcYHXtU/ViMMKoaa9TGB4uOfZZZsl/h/w4EeKl7JnKzF
         MTw3+E3xUL5o26wnaI8Mw/TZ3XUR65Yr62iY0wCKdjjhhpA9pXf6jRduxiLxdX4TrUjw
         UqZg==
X-Gm-Message-State: ALoCoQk03xQ6n9ECX3sCni6S4m8Kj9KW2h61bn3rlz6tMXf6tP4vmxYXUodFGRAJpFZOXYY6Z6jx
X-Received: by 10.70.61.33 with SMTP id m1mr10415879pdr.0.1415389746934;
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id r6si370741yhg.1.2014.11.07.11.49.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id eEifbDlT.1; Fri, 07 Nov 2014 11:49:06 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E04D0E0C72; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We no longer need to expose the lock/add/commit/rollback functions
for packed refs anymore so make them static and remove them from the
public api.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  8 ++++----
 refs.h | 30 ------------------------------
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/refs.c b/refs.c
index 2c6b0f6..eee9a14 100644
--- a/refs.c
+++ b/refs.c
@@ -1229,7 +1229,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-void add_packed_ref(const char *refname, const unsigned char *sha1)
+static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2398,7 +2398,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 }
 
 /* This should return a meaningful errno on failure */
-int lock_packed_refs(int flags)
+static int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
@@ -2421,7 +2421,7 @@ int lock_packed_refs(int flags)
  * Commit the packed refs changes.
  * On error we must make sure that errno contains a meaningful value.
  */
-int commit_packed_refs(void)
+static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2450,7 +2450,7 @@ int commit_packed_refs(void)
 	return error;
 }
 
-void rollback_packed_refs(void)
+static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index ce290b1..70a2819 100644
--- a/refs.h
+++ b/refs.h
@@ -120,36 +120,6 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
 /*
- * Lock the packed-refs file for writing.  Flags is passed to
- * hold_lock_file_for_update().  Return 0 on success.
- * Errno is set to something meaningful on error.
- */
-extern int lock_packed_refs(int flags);
-
-/*
- * Add a reference to the in-memory packed reference cache.  This may
- * only be called while the packed-refs file is locked (see
- * lock_packed_refs()).  To actually write the packed-refs file, call
- * commit_packed_refs().
- */
-extern void add_packed_ref(const char *refname, const unsigned char *sha1);
-
-/*
- * Write the current version of the packed refs cache from memory to
- * disk.  The packed-refs file must already be locked for writing (see
- * lock_packed_refs()).  Return zero on success.
- * Sets errno to something meaningful on error.
- */
-extern int commit_packed_refs(void);
-
-/*
- * Rollback the lockfile for the packed-refs file, and discard the
- * in-memory packed reference cache.  (The packed-refs file will be
- * read anew if it is needed again after this function is called.)
- */
-extern void rollback_packed_refs(void);
-
-/*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
  * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
-- 
2.1.0.rc2.206.gedb03e5
