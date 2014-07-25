From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 5/5] refs.c: make the *_packed_refs functions static
Date: Fri, 25 Jul 2014 10:55:26 -0700
Message-ID: <1406310926-4080-6-git-send-email-sahlberg@google.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 19:56:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjir-0002S3-EL
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935169AbaGYRzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:55:53 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:52394 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbaGYRza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:55:30 -0400
Received: by mail-oi0-f74.google.com with SMTP id a141so1021289oig.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8upa10JHNcBjRDUjmNsFcsnrteFnMQLDWGSYbv58GCo=;
        b=QRdy/7XE0B/8B1Bkxe0YLTSV9fUeQ3f/SQxBL9HKHTZHAqcr5CRJgiE3pzmpca/Lvd
         YV7YO1RHHdGZKv0LcUJQVD16QSHsxlxi8wYExio6J0DoWsWv2tBFU84RuD03kkyGPgGO
         5x7XYCSnYCj6HCofWUP3fFwptdJql25CfNGi+TB+4IM0gy1VBO+q1+uL6M6hVludbokZ
         NJJQLIK1GtPKlu168cpa/ICLUNpHrZNNrFKEXuLOI4Q/namzBbPueSDyBSaR3pNmHcou
         dWtkLTQ7nUib+gE9M+H4jsZHehNP+oLOYCX0l0mQfJTj83eUnOI8Nl9FF0+/fz9FSjIz
         zENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8upa10JHNcBjRDUjmNsFcsnrteFnMQLDWGSYbv58GCo=;
        b=Nv0+gY+oxYaAPTmOtDdmM08DFfy3eKyo/uub+agA37IkHT6JjlTqE+YOKVMoBqxRSv
         ZlzAIqfTIta2UdxEzMK9wNN4gs0qJRTg4r2D+/kwzl/m5/kxxNe8a257QBkCDMCpgAFb
         z1YTpWZpftyfy5osTbhoQumhzwGyUiSjgPRJ7JytJWqwU67cJHQ0EjxsjfSno5gX1R5Q
         in5VPPMl/GIf+GdYAZ5LnLVj4TEBIg4aNTbpitwXgAvXvf6RzT/UDzyt38EpPVi1jxWL
         OjNoFm757KmMDUlk8JXBrtmqXBEi+vfzuxVn2YzE8mJZbkXiP1QRpVmXkLTTeyO61w+z
         dnHQ==
X-Gm-Message-State: ALoCoQn04C9XdHE67jooOiccR0t+kHZVG3I1xYAwNkOflI7gHRyZ8Phnq2shkFwmwrVWs1WPUa9T
X-Received: by 10.50.41.66 with SMTP id d2mr2856512igl.2.1406310930054;
        Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k15si186856igt.1.2014.07.25.10.55.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 8D8315A4391;
	Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 251ECE0AC8; Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.518.g4f5a8ad
In-Reply-To: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254249>

We no longer need to expose the lock/add/commit/rollback functions
for packed refs anymore so make them static and remove them from the
public api.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  8 ++++----
 refs.h | 30 ------------------------------
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/refs.c b/refs.c
index 5696d18..d2ee8a2 100644
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
@@ -2268,7 +2268,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 }
 
 /* This should return a meaningful errno on failure */
-int lock_packed_refs(int flags)
+static int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
@@ -2291,7 +2291,7 @@ int lock_packed_refs(int flags)
  * Commit the packed refs changes.
  * On error we must make sure that errno contains a meaningful value.
  */
-int commit_packed_refs(void)
+static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2316,7 +2316,7 @@ int commit_packed_refs(void)
 	return error;
 }
 
-void rollback_packed_refs(void)
+static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 7183e8e..ec52e13 100644
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
2.0.1.518.g4f5a8ad
