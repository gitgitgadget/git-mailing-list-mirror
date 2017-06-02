Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E562027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFBTiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:38:55 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32894 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBTix (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:38:53 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so56126597pfh.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WDU5iLnMgMJzDsuYFVj5Ai4szjOO0S57N3/22d2oXYY=;
        b=qDr0BiPtrEFyRFg7t1i3L1+t3ciqRYJGDTNXN2iraT13fp43GpY105lGIK6b82Sw6E
         sLj2kJJXGgBsGAqxvQZcoBfioiRQ4QlP7XdeL5mzsOtRiho3wC9rha4caEaJkdhkE6HV
         1jPRtplY1Atdf2gqn3qFDsAqHfUKIGHBzh5rDi94f4PmiWKJrAf+/5M34Qz7uZCBMXAE
         XUgzPKTyV02MVit5XTf1xuE9EeodnH5RAk/XaWTYDWfTA5KrswP5jsQyEYA/WHIZoqZg
         3kkx4aYkhu0BE9rqoFp4X3TKmVK36umd2+FkvFTUwoOuZtlhEFbkVTZnGQ3QwByN+OtH
         fD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WDU5iLnMgMJzDsuYFVj5Ai4szjOO0S57N3/22d2oXYY=;
        b=nv7nSJndzHHBd5tgqGA/mgRgO0P7cj1p6tmZZ4BWHcE/Pz0t9Q24ljUirxrcGeNScs
         ieop9tJdowGWTWxrJ8dYzRuQFYCvqKMSt3W2rCbs8PuhwbsSyMVukT8K6f0zgIaidJl2
         dUTQLBmVNFtuFMpOeMU9WI44Xe9HN29Sb2c9mOJjUNEZ6pbBM3bVfs8vXE4qnKjABmDD
         Yi8vWZH9JlGf61sEeiEtdZYEGEVcKP0JI/cZnfGCl5kCoCD/9QkLFXTfKMhu+192TDW9
         edZAk7c0G8KLQlrt3wdXlJIl/hxWozifJsWix8ez9Q0aXimTcgHqovAlJXyUtwULJ91H
         H6ww==
X-Gm-Message-State: AODbwcB+Mjrt9YyeBDgwIL9sS+DQzeGucc0cZp87VtdGJTj1uCH+mWWE
        FEhMficyfvuR5IBTZSVHwQ==
X-Received: by 10.98.79.28 with SMTP id d28mr8369910pfb.56.1496432332339;
        Fri, 02 Jun 2017 12:38:52 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id p89sm42789627pfk.67.2017.06.02.12.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:38:50 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [WIP v2 1/2] pack-objects: rename want_.* to ignore_.*
Date:   Fri,  2 Jun 2017 12:38:44 -0700
Message-Id: <efea86d5542d56a34211230b36c1e3e1b856570c.1496432147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd-goog
In-Reply-To: <cover.1496432147.git.jonathantanmy@google.com>
References: <cover.1496432147.git.jonathantanmy@google.com>
In-Reply-To: <cover.1496432147.git.jonathantanmy@google.com>
References: <cover.1496361873.git.jonathantanmy@google.com> <cover.1496432147.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, in pack_objects, add_object_entry() distinguishes between 2
types of non-preferred-base objects:

 (1) objects that should not be in "to_pack" because an option like
     --local or --honor-pack-keep is set
 (2) objects that should be in "to_pack"

A subsequent commit will teach pack-objects to exclude certain objects
(specifically, blobs that are larger than a user-given threshold and are
not potentially a Git special file [1]), but unlike in (1) above, these
exclusions need to be reported. So now we have 3 types of
non-preferred-base objects:

 (a) objects that should not be in "to_pack" and should not be reported
     because an option like --local or --honor-pack-keep is set
 (b) objects that should not be in "to_pack" and should be reported
     because they are blobs that are oversized and non-Git-special
 (c) objects that should be in "to_pack"

add_object_entry() will be taught to distinguish between these 3 types
by the following:

 - renaming want_found_object() and want_object_in_pack() to ignore_.*
   to make it clear that they only check for (a) (this commit)
 - adding a new function to check for (b) and using it within
   add_object_entry() (a subsequent commit)

The alternative would be to retain the names want_found_object() and
want_object_in_pack() and have them handle both the cases (a) and (b),
but that would result in more complicated code.

We also take the opportunity to use the terminology "preferred_base"
instead of "excluded" in these methods. It is true that preferred bases
are not included in the final packfile generation, but at this point in
the code, there is no exclusion taking place - on the contrary, if
something is "excluded", it is in fact guaranteed to be in to_pack.

[1] For the purposes of pack_objects, a blob is a Git special file if it
    appears in a to-be-packed tree with a filename beginning with
    ".git".

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80439047a..730fa3d85 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -946,12 +946,12 @@ static int have_duplicate_entry(const unsigned char *sha1,
 	return 1;
 }
 
-static int want_found_object(int exclude, struct packed_git *p)
+static int ignore_found_object(int preferred_base, struct packed_git *p)
 {
-	if (exclude)
-		return 1;
-	if (incremental)
+	if (preferred_base)
 		return 0;
+	if (incremental)
+		return 1;
 
 	/*
 	 * When asked to do --local (do not include an object that appears in a
@@ -969,19 +969,19 @@ static int want_found_object(int exclude, struct packed_git *p)
 	 */
 	if (!ignore_packed_keep &&
 	    (!local || !have_non_local_packs))
-		return 1;
+		return 0;
 
 	if (local && !p->pack_local)
-		return 0;
+		return 1;
 	if (ignore_packed_keep && p->pack_local && p->pack_keep)
-		return 0;
+		return 1;
 
 	/* we don't know yet; keep looking for more packs */
 	return -1;
 }
 
 /*
- * Check whether we want the object in the pack (e.g., we do not want
+ * Check whether we should ignore this object (e.g., we do not want
  * objects found in non-local stores if the "--local" option was used).
  *
  * If the caller already knows an existing pack it wants to take the object
@@ -989,16 +989,16 @@ static int want_found_object(int exclude, struct packed_git *p)
  * function finds if there is any pack that has the object and returns the pack
  * and its offset in these variables.
  */
-static int want_object_in_pack(const unsigned char *sha1,
-			       int exclude,
-			       struct packed_git **found_pack,
-			       off_t *found_offset)
+static int ignore_object(const unsigned char *sha1,
+			 int preferred_base,
+			 struct packed_git **found_pack,
+			 off_t *found_offset)
 {
 	struct mru_entry *entry;
-	int want;
+	int ignore;
 
-	if (!exclude && local && has_loose_object_nonlocal(sha1))
-		return 0;
+	if (!preferred_base && local && has_loose_object_nonlocal(sha1))
+		return 1;
 
 	/*
 	 * If we already know the pack object lives in, start checks from that
@@ -1006,9 +1006,9 @@ static int want_object_in_pack(const unsigned char *sha1,
 	 * are present we will determine the answer right now.
 	 */
 	if (*found_pack) {
-		want = want_found_object(exclude, *found_pack);
-		if (want != -1)
-			return want;
+		ignore = ignore_found_object(preferred_base, *found_pack);
+		if (ignore != -1)
+			return ignore;
 	}
 
 	for (entry = packed_git_mru->head; entry; entry = entry->next) {
@@ -1027,15 +1027,15 @@ static int want_object_in_pack(const unsigned char *sha1,
 				*found_offset = offset;
 				*found_pack = p;
 			}
-			want = want_found_object(exclude, p);
-			if (!exclude && want > 0)
+			ignore = ignore_found_object(preferred_base, p);
+			if (!preferred_base && ignore > 0)
 				mru_mark(packed_git_mru, entry);
-			if (want != -1)
-				return want;
+			if (ignore != -1)
+				return ignore;
 		}
 	}
 
-	return 1;
+	return 0;
 }
 
 static void create_object_entry(const unsigned char *sha1,
@@ -1070,16 +1070,16 @@ static const char no_closure_warning[] = N_(
 );
 
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
-			    const char *name, int exclude)
+			    const char *name, int preferred_base)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
-	if (have_duplicate_entry(sha1, exclude, &index_pos))
+	if (have_duplicate_entry(sha1, preferred_base, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
+	if (ignore_object(sha1, preferred_base, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			warning(_(no_closure_warning));
@@ -1089,7 +1089,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	}
 
 	create_object_entry(sha1, type, pack_name_hash(name),
-			    exclude, name && no_try_delta(name),
+			    preferred_base, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
 
 	display_progress(progress_state, nr_result);
@@ -1106,7 +1106,7 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, 0, &pack, &offset))
+	if (ignore_object(sha1, 0, &pack, &offset))
 		return 0;
 
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
-- 
2.13.0.506.g27d5fe0cd-goog

