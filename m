From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/2] refs.c: make the *_packed_refs functions static
Date: Thu,  5 Jun 2014 16:26:28 -0700
Message-ID: <1402010788-8236-3-git-send-email-sahlberg@google.com>
References: <1402010788-8236-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsh3Z-0001yK-Ls
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbaFEX0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:26:38 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:50852 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbaFEX0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:26:37 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so414334veb.0
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=64RHwSdTyuzetyeMlbN/WqsD7yWiTOq+JBhBzEgRisM=;
        b=bSl02vTvXdcbUWgw6wYjBX++hwrnhB11zr93BXzinws3f6XpK9a0Wl+JGZQn8DpMqf
         M51EvEGafNtpVzKPlpF0SE5ge03umg11GcmH06VMXdRk0IMrd6VUBPKs69VQgb3kRCSo
         U6/k4ezqGwPNUJRmkFpRXSobguR3ThYRyOrQOPG/BlL8j9nkgNQcB8osP4E4syVSnO83
         Xo9mkdEcTOixBkmJo21sVAzvlI8hk6x51NAYHsKmVzyMnwN+D6r/2H/GyGjDIiGebTNt
         tHsP41xHGtPnPhxd9HQBpSbbYaV29A6DO+Enf9yHADPpDxl1vB/f9ASj7UkkY1WQKz2E
         t3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=64RHwSdTyuzetyeMlbN/WqsD7yWiTOq+JBhBzEgRisM=;
        b=W+fnTwYy64UXirNN9D4VFMa5YDLwvdbzqXXUUpp2FJn2sZenjT+BsRFbAUfEtBD6Kb
         VUTPD3r14uODZok57A3ccJXMS6OY4S3rwYxhgezygZmwjywZzxci8GL/8k5rIOkL0Rfu
         1zOZsczmCwNdUIHAu8iz9CdNaXKv8jIXgAK2Z/L9cNshi2GG9ItVaWR3PX/XZvR+20Aw
         5LLEzjkX0uyZ/dpZLkiketuhC83oG9FxTosf0S0sz6yaDGoqZrnqcOwm0p+TsVWOr5kJ
         1BaPoM1ywYMYolbBs/Y+PBX4B0/Vn/J4cbH6lpMw36XzTxjaHdIWVTdcb+HLeBGqWLXB
         Nvnw==
X-Gm-Message-State: ALoCoQkHYTTjo8X7Pizf22Y4VyUGWewpQOZXhi3tv8Bt+4iPdgBCnGy2DXp8T30AdV+rLJ3tVK0U
X-Received: by 10.236.192.196 with SMTP id i44mr272949yhn.23.1402010793235;
        Thu, 05 Jun 2014 16:26:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si669199yhl.7.2014.06.05.16.26.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:26:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1ABD931C78A;
	Thu,  5 Jun 2014 16:26:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B5AE7E0575; Thu,  5 Jun 2014 16:26:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
In-Reply-To: <1402010788-8236-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250879>

We no longer need to expose the lock/add/commit/rollback functions
for packed refs anymore so make them static and remove them from the api.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  8 ++++----
 refs.h | 28 ----------------------------
 2 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 6aa64dd..530947e 100644
--- a/refs.c
+++ b/refs.c
@@ -1123,7 +1123,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-void add_packed_ref(const char *refname, const unsigned char *sha1)
+static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2211,7 +2211,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-int lock_packed_refs(int flags)
+static int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
@@ -2234,7 +2234,7 @@ int lock_packed_refs(int flags)
  * Commit the packed refs changes.
  * On error we must make sure that errno contains a meaningful value.
  */
-int commit_packed_refs(void)
+static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2259,7 +2259,7 @@ int commit_packed_refs(void)
 	return error;
 }
 
-void rollback_packed_refs(void)
+static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 3c99619..e92cb92 100644
--- a/refs.h
+++ b/refs.h
@@ -118,34 +118,6 @@ extern int for_each_rawref(each_ref_fn, void *);
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 
 /*
- * Lock the packed-refs file for writing.  Flags is passed to
- * hold_lock_file_for_update().  Return 0 on success.
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
2.0.0.583.g402232d
