Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC771F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeA2Whv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:37:51 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:42344 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeA2Wht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:37:49 -0500
Received: by mail-ot0-f201.google.com with SMTP id e19so6448458otj.9
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=7q3iIhvKJcVia2srYg44BBlrSaXoFtMZa5Yc6d35Fqg=;
        b=mCP2SneCrpSQSMk2RaHb2fn8yMzlSyIBT01slkUo+K7w+FpCjezzRGAwES+bwUei8l
         foeS6SWI0eKip7Nkmn9Q9rSIgV1dh0/V9slmtBtwiShtS/uW/oiMY27Moh2TwRR9cNQt
         9LusZf/70HlxAl5MywW/Xa1S7Ho75gzYpVVJVLPLfdM5HHbjcTRzs6Jwx7sDAgOLo613
         g02PKWZIkWLqjWph83wutPAfNSJ6AsTVHHd7m4+xt0W4EWTc/T53TsXD9cZ37SGub0rL
         Xhc4DAijmt48gg1fGHd5JZgMwAGq3jOQGl7R+xmomfA0gY+0ul7svM8KlniibtyBvug5
         xksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=7q3iIhvKJcVia2srYg44BBlrSaXoFtMZa5Yc6d35Fqg=;
        b=biHWDhLrQMaXBa7RSWwbN/AOAbvymy9XXyvzlIFZepH23aB0TLqPpoUGC97Y5IH5gs
         aYPHM5wesyabzi23J8jKfWJ7UodzikUE7UnmO4SCEz0nPklglQvgy6TK0F/41Lc3XtAL
         wdAWSHsrBtUtAj318zh27LKE1bNIrEn7DGUnDEaWOJkXgI+9PqX/wnRZstq+dvpCtCnk
         ati4QEchcRLR1qM1XdYQxJeNU1DTiQtuKNs8Lz1KL40LCgkfX2sZoXMzAlHmujBxESMx
         ASup2pOdJf76U7G6j7FJf8L+ZJGbckfL9hdFEyc7juG0mIksLfolnwXjMpXctrQLLS7E
         V5iQ==
X-Gm-Message-State: AKwxytfQUypP7Mm9tUiZ+sIhOcHRFXmNNJnR7z2G33wyTmfaOxgOa/99
        35HIMVHUPzYWUuAvVNmzGAiT4GzDf2xF4JPS9hIhw1jHVAIDwUJ0S6kri/i0zlnfQsrVgEw80gq
        SGijV2PZCKG6bw/8qz7Kk7aGb6eBmEkngf92EGFIr1PmPJL/9D/qe530+kQ==
X-Google-Smtp-Source: AH8x225mYR9ad+0vWOBvSRDGaFwGG5VdlGwykS0tS0w3aUod6PY718c9zQSnEdbkY2fYkgsfCwwpEwF+iG0=
MIME-Version: 1.0
X-Received: by 10.157.85.177 with SMTP id m46mr3146920oth.106.1517265468225;
 Mon, 29 Jan 2018 14:37:48 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:36:54 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-4-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 03/37] blame: rename 'this' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 blame.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/blame.c b/blame.c
index 2893f3c10..21c867664 100644
--- a/blame.c
+++ b/blame.c
@@ -998,28 +998,29 @@ unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e)
 }
 
 /*
- * best_so_far[] and this[] are both a split of an existing blame_entry
- * that passes blame to the parent.  Maintain best_so_far the best split
- * so far, by comparing this and best_so_far and copying this into
+ * best_so_far[] and potential[] are both a split of an existing blame_entry
+ * that passes blame to the parent.  Maintain best_so_far the best split so
+ * far, by comparing potential and best_so_far and copying potential into
  * bst_so_far as needed.
  */
 static void copy_split_if_better(struct blame_scoreboard *sb,
 				 struct blame_entry *best_so_far,
-				 struct blame_entry *this)
+				 struct blame_entry *potential)
 {
 	int i;
 
-	if (!this[1].suspect)
+	if (!potential[1].suspect)
 		return;
 	if (best_so_far[1].suspect) {
-		if (blame_entry_score(sb, &this[1]) < blame_entry_score(sb, &best_so_far[1]))
+		if (blame_entry_score(sb, &potential[1]) <
+		    blame_entry_score(sb, &best_so_far[1]))
 			return;
 	}
 
 	for (i = 0; i < 3; i++)
-		blame_origin_incref(this[i].suspect);
+		blame_origin_incref(potential[i].suspect);
 	decref_split(best_so_far);
-	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
+	memcpy(best_so_far, potential, sizeof(struct blame_entry[3]));
 }
 
 /*
@@ -1046,12 +1047,12 @@ static void handle_split(struct blame_scoreboard *sb,
 	if (ent->num_lines <= tlno)
 		return;
 	if (tlno < same) {
-		struct blame_entry this[3];
+		struct blame_entry potential[3];
 		tlno += ent->s_lno;
 		same += ent->s_lno;
-		split_overlap(this, ent, tlno, plno, same, parent);
-		copy_split_if_better(sb, split, this);
-		decref_split(this);
+		split_overlap(potential, ent, tlno, plno, same, parent);
+		copy_split_if_better(sb, split, potential);
+		decref_split(potential);
 	}
 }
 
@@ -1273,7 +1274,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			struct diff_filepair *p = diff_queued_diff.queue[i];
 			struct blame_origin *norigin;
 			mmfile_t file_p;
-			struct blame_entry this[3];
+			struct blame_entry potential[3];
 
 			if (!DIFF_FILE_VALID(p->one))
 				continue; /* does not exist in parent */
@@ -1292,10 +1293,10 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 
 			for (j = 0; j < num_ents; j++) {
 				find_copy_in_blob(sb, blame_list[j].ent,
-						  norigin, this, &file_p);
+						  norigin, potential, &file_p);
 				copy_split_if_better(sb, blame_list[j].split,
-						     this);
-				decref_split(this);
+						     potential);
+				decref_split(potential);
 			}
 			blame_origin_decref(norigin);
 		}
-- 
2.16.0.rc1.238.g530d649a79-goog

