From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 5/5] refs.c: make the *_packed_refs functions static
Date: Wed, 30 Jul 2014 14:55:41 -0700
Message-ID: <1406757341-4096-6-git-send-email-sahlberg@google.com>
References: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:56:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbqp-00087L-5P
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbaG3Vz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:55:56 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:60934 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbaG3Vzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:55:43 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so346550pab.5
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jdjfzYeaRAd2aHnPOPXGDXKJ5d7ct5HyuDKHsoNHsyo=;
        b=ptnvacrumE7XIdNgDRqWo9Cb2PI6yuoIeczaTF18qUfbGVL2hfBmfIUSUqKAoSk4EG
         tmuL6pSP2Y0qxehoS1Krz3Fi+w98fk6PYoUg9w7vXSTBHsCKg6RA7eYCbs5A+cVVm1Y6
         v5BkmHf+srK0qeRVW+J2TvY8PKYdIXqb2DR3Sraa7XAruzi15hNWHmfDLuiQN65md+Ff
         czhTGvjFDnapd/hEwvVhxOefd0MvWkHGJ14+sbLDlLVUlDbO+xPXNSM8czzlU5TPDxWF
         otsC8twZeHjpC4j+GkO+s6iiT66JLgK0oSfi0Cbsb/RGhU43BXcM9XWQA749elMV3c9/
         Qo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jdjfzYeaRAd2aHnPOPXGDXKJ5d7ct5HyuDKHsoNHsyo=;
        b=LDT/OsBpD/NLOa2igiUTWHVGphkmkvyt5aSEP7QH8lZQgZxzUX5ZCnNGiB9ycKqccA
         hdgjhXFhS/tjhVAWAlzPRq/1ymY03XjBRnADnkB1WoLSjVJh5UL24Eqn17l/IVqTxq1u
         5T6+NBQwJy4e4e07c4ssw5l5nCeuK4TtmcOSSflq1uJ1SV4wsKFyOb2TT5c16iuih8cv
         O1f7SDUZX0wJ3Bcug1D2xaIEcAGUZnq9iUzkyf7tXPX8aPdp/vcnSd/cjDilJipB9jOo
         hi0yQsWPr1n3FCQ78toJVi/RXUzRzlAUgnrnXN+X06qZHzqFMr+5+wS4KwXAN+Leogmp
         cySA==
X-Gm-Message-State: ALoCoQmpZm0DQkiOraNEnAL+MAOwuXI6AYaUbaVUkHRk5wSFUXZ4T/g/cb12NkGCkgEtRZOZxmtr
X-Received: by 10.68.135.99 with SMTP id pr3mr2903027pbb.9.1406757343433;
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si228365yhv.0.2014.07.30.14.55.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 300E531C53A;
	Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B4B79E0639; Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254526>

We no longer need to expose the lock/add/commit/rollback functions
for packed refs anymore so make them static and remove them from the
public api.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  8 ++++----
 refs.h | 30 ------------------------------
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/refs.c b/refs.c
index fc445e8..46a9595 100644
--- a/refs.c
+++ b/refs.c
@@ -1135,7 +1135,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-void add_packed_ref(const char *refname, const unsigned char *sha1)
+static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2272,7 +2272,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 }
 
 /* This should return a meaningful errno on failure */
-int lock_packed_refs(int flags)
+static int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
@@ -2295,7 +2295,7 @@ int lock_packed_refs(int flags)
  * Commit the packed refs changes.
  * On error we must make sure that errno contains a meaningful value.
  */
-int commit_packed_refs(void)
+static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2320,7 +2320,7 @@ int commit_packed_refs(void)
 	return error;
 }
 
-void rollback_packed_refs(void)
+static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 93f7bd5..54dbe4b 100644
--- a/refs.h
+++ b/refs.h
@@ -112,36 +112,6 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list* refnames);
 
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
2.0.1.523.g0041e8a
