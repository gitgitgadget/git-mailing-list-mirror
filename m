Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DABE1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162499AbeBNTAy (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:00:54 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:42038 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162458AbeBNTAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:00:50 -0500
Received: by mail-yw0-f201.google.com with SMTP id h187so12936178ywb.9
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0PCLzOmwCkZzNfuTWgLJk++C5JYUyABdzQiyb4LuP0o=;
        b=t3EPijgiwXg9wI4OHWcitrFVaHqq3+vbuwUrP5FDbbebQkv7shnfnANTF+Pg6ojVpn
         xeXs6q3/Fk3PjBh7Pe0vFP3LFL0Sq252tPfVvcTJ/P8dYDw/O1vx2u9jRls9PWN1Dmd6
         m73eFTcOdqDqPWA0lgbuvyM1Umtoak0q0GWKUOW9oHzqlZtHaqlcrNhR9gCeQwRjvVEU
         0xczyaF1mfPcfp1XuOfktZChddzPA922hlX9fcruMbKcL9etfWicjLorOEiauYt26rGP
         iywx9hJh9Mdef/UB1Et7ASmLf1ZHVcPkQndswbXp8DZrA6VtpJHBzyZLggw/NjRJZw4G
         v3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0PCLzOmwCkZzNfuTWgLJk++C5JYUyABdzQiyb4LuP0o=;
        b=plmM/CAAaNo+bE/1r/Kq11UzzykRRYIUrhkZhLxjozFD8+JDfHiWuSc5WqwFDfdCyW
         WXD7ewUfmvVHh9hHf+rMiPygQs4/gaMCF15aqNw44zXZCxmkEJU0D1jzPJTBSlCMa5Fe
         KfNTZvY3iLD8kQemMd3hfBctTNY56NUe0dM+Vt3mWAQ+AynjDtn3zbLKjcZq7LfAcJMh
         XVkbxWvNB9QzEJCUxkZxhEu2LGORFIm2c9IXw0olgq4zExfNw4+u5Cg/D6FQsINV82gX
         JhG3jC+mnSYhPpMbdg1xTHCA+mcrE4DM/ZXRBLK+r54Qx2xbsBeGMiiqRXJx1/Qmd1pW
         MxnA==
X-Gm-Message-State: APf1xPAgCCg/t3n0z0hLzOwKMygxDIqd/ap91/w8Q7cejSzHpGjxni/R
        mg44zhpH4VRN+phEw2LohbtZBnn7EQdC9334OS0C4/UIkQ3elSNwgnCkfcMcaey2d1GMsK9zjE3
        qxbS0Qh/MnyaI6Ai0oko3sMcMto5iQMhPwIpZybNQI4bb8IG9gW8QKpMSCg==
X-Google-Smtp-Source: AH8x224eQZRvINm2zPP51vUhb44i+yMvkOs+2Q0xU6T8gw2UgfBbsLS6DXKRI824TZS0zs6LUzlG3Xt/ccw=
MIME-Version: 1.0
X-Received: by 10.37.97.15 with SMTP id v15mr2943825ybb.21.1518634850211; Wed,
 14 Feb 2018 11:00:50 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:25 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-4-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 03/37] blame: rename 'this' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
2.16.1.291.g4437f3f132-goog

