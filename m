Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC3E20D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdFBAPM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:15:12 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36099 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFBAPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:15:11 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so40805746pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wt4PIToFstVnhVUi/ElisMFzbPESMYDPt/inuHw45yk=;
        b=JGwDYtUXSBgGY13DQ2g6Ajrk/HlfVb+R6zxriJFu3Jd69cQIcjgte0RGqKnbsMfTjh
         ZhOfqTY9xA3sbdYuUL1HqSIWNtULvLOGuVoIQY9ELh82Vm1dfCvIiZY/Fe4rxnhkrqgY
         G9Zjb0pTL8uxqCHLUqRLcfPMLFlSKDQQCBfmunxWrG7sHRp7hTAc2FxNieigxJiq4Tuj
         NI0oKRELeO2AlXvTPslK1cbRaw5X3qZ9Pxi8rvqgZjDRlw2Jmc2/Ze2b26Jp+5rPxHkJ
         2qC3HGyHX2p/+IFd+t1GcvGvqXYrBn/+Oxdwz9SrybKv07yyNbrpiJr5GzAO2OfxMkYA
         QGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wt4PIToFstVnhVUi/ElisMFzbPESMYDPt/inuHw45yk=;
        b=GEG8US9+8XNsd7s65RLDmdSkj94Lv5yqidpGGyJ2gjDksWrdmK766T5OzLPp1GGMVZ
         KEgnnw3fJ8stg+bjZ0l9gWfdwyTEzML4Gfh7eNryB/hTUfgo6XJJPrA7UX7BZRtw011n
         r1jj/r6deg067Sm0NoI5dUQnr8M+beX55+QhPyz3jh/sipfgq6b8hKr6dU5BjEJhg1cg
         PYOukZpXbD3MhVG/tlnR8ntAbt7TeAWhQn1h/Hc5K7soiropZKZZlHo3KXxN47519438
         odNt5Ud14QJSu3ibdNd1lEtrR9LhjMayIyrujJaMN33q4ToP7bqDoYbAyAMU2cczcRlO
         3RxQ==
X-Gm-Message-State: AODbwcDT2fQsi0I793Ri0LhuHxjVT7dVZDSQRcJ0fgrZmFz+0or0dhjp
        ZiFhQS1JXsUx5I1F
X-Received: by 10.84.197.3 with SMTP id m3mr65685114pld.40.1496362510534;
        Thu, 01 Jun 2017 17:15:10 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id s23sm38046377pfg.81.2017.06.01.17.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:15:09 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
Subject: [WIP 1/2] pack-objects: rename want_.* to ignore_.*
Date:   Thu,  1 Jun 2017 17:14:54 -0700
Message-Id: <5e8aebf2726481ef63838291c32e07439289d922.1496361873.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd-goog
In-Reply-To: <cover.1496361873.git.jonathantanmy@google.com>
References: <cover.1496361873.git.jonathantanmy@google.com>
In-Reply-To: <cover.1496361873.git.jonathantanmy@google.com>
References: <cover.1496361873.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, pack-objects conflates the concepts of "ignoring an object"
and "including it in to_pack". This is fine for now, but a subsequent
commit will introduce the concept of an object that cannot be completely
ignored, but should not be included in to_pack either. To separate these
concepts, restrict want_found_object() and want_object_in_pack() to only
indicate if the object is to be ignored. This is done by renaming these
methods and swapping the meanings of the return values 0 and 1.

We also take the opportunity to use the terminology "preferred_base"
instead of "excluded" in these methods. It is true that preferred bases
are not included in the final packfile generation, but at this point in
the code, there is no exclusion taking place - on the contrary, if
something is "excluded", it is in fact guaranteed to be in to_pack.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80439047a..1062d8fe2 100644
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
@@ -1079,7 +1079,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (have_duplicate_entry(sha1, exclude, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
+	if (ignore_object(sha1, exclude, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			warning(_(no_closure_warning));
@@ -1106,7 +1106,7 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, 0, &pack, &offset))
+	if (ignore_object(sha1, 0, &pack, &offset))
 		return 0;
 
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
-- 
2.13.0.506.g27d5fe0cd-goog

