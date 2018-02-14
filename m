Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50CC51F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162562AbeBNTBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:48 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:40419 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162554AbeBNTBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:42 -0500
Received: by mail-vk0-f74.google.com with SMTP id w3so3155544vkh.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=vy7FgLjJUrxkBYOA5X09pF8EXFdKT2kv9CoRpLz2B64=;
        b=wMj9npRYATOcHDSYqsYSH1qdAElfsF6D92SW97KnaU46GvgRO/v/MRk2mil8Zrewdv
         Ue+5HQS/0jmo64jZFC5MG6BZBelA8vZajl4HY2rSHOcW0NUQehQqE4ZAdOA5LXvReM7/
         dSp3vbN9VjSppGplWYs3IR/3w1a/jJRUfJ93yWtMdIHw5+hK+idL4iCHExkOWAccM/ea
         jOSUNqGgoTcQI6r6TuvFjZB21ic4B7Nr5kkkI3sqL9aQpnbXGBJ0PnPJYeg3UyFKmsmT
         fs7j3L1hsqfx3LV4dbsjPEgULfMMB5ayO36y/fJpDHEbUw6LTBOv1NkNs1Nz9K5imh3M
         wV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=vy7FgLjJUrxkBYOA5X09pF8EXFdKT2kv9CoRpLz2B64=;
        b=hs9dP2Gw94jtwaQlNxUzYPNtW1xdn+ynMIF/2kfRYH39+86vtD7vLWUegBO4m+0qBC
         q+tOICuu2pXrjd7OyJMrI0gT0ppz34J5AJkqW952wiprgvpHRc6UpC2yI2dea2Cic8Su
         30nZ7fSkJAuYV/5qrzMeEDxZoqjVLshNIAqv4fEorQ/UilvrRXcQXy7WEmrl29QuPma6
         FKRnHBuzc5kW3CLENX2HFNNp++gZMUmDpgILRrRupRftMUXQJuoBb13/At23EeJ0IZN7
         KNeN7bdEnhmA1teC6mcsrJmeEwaLwZx5sFyCw6XIXLW+Mex3TI+nkTq+tX4g+4x4is0o
         NFdQ==
X-Gm-Message-State: APf1xPCJaoooRZUbxhxIdyD87mY5w7le1b1fyUlK+8sk0HV/hrgYGAw8
        nt5aqLp5+cDHQrtWtdHtFpQsp01re34EFHyn/G4+ocFzg4SGiCRgjHhYvsE1+kgYFIeC4SOna6W
        FoGrO3u7lsdw0RGwnQNw4sr+QwVXHka7Zo5Z1n2Jb3xQZs6YO6RgG6r9esw==
X-Google-Smtp-Source: AH8x226jm11zoeVlDGHKNlOgEY/7VM7w5vqBDVVK1FpLGcEluqM1RlXOsdLZzgfhiPl9wxmhsgBTPV2mwAU=
MIME-Version: 1.0
X-Received: by 10.31.156.74 with SMTP id f71mr2636813vke.93.1518634901315;
 Wed, 14 Feb 2018 11:01:41 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:44 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-23-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 22/37] line-log: rename 'new' variables
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
 line-log.c | 56 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/line-log.c b/line-log.c
index 545ad0f28..cdc2257db 100644
--- a/line-log.c
+++ b/line-log.c
@@ -151,29 +151,29 @@ static void range_set_union(struct range_set *out,
 
 	assert(out->nr == 0);
 	while (i < a->nr || j < b->nr) {
-		struct range *new;
+		struct range *new_range;
 		if (i < a->nr && j < b->nr) {
 			if (ra[i].start < rb[j].start)
-				new = &ra[i++];
+				new_range = &ra[i++];
 			else if (ra[i].start > rb[j].start)
-				new = &rb[j++];
+				new_range = &rb[j++];
 			else if (ra[i].end < rb[j].end)
-				new = &ra[i++];
+				new_range = &ra[i++];
 			else
-				new = &rb[j++];
+				new_range = &rb[j++];
 		} else if (i < a->nr)      /* b exhausted */
-			new = &ra[i++];
+			new_range = &ra[i++];
 		else                       /* a exhausted */
-			new = &rb[j++];
-		if (new->start == new->end)
+			new_range = &rb[j++];
+		if (new_range->start == new_range->end)
 			; /* empty range */
-		else if (!out->nr || out->ranges[out->nr-1].end < new->start) {
+		else if (!out->nr || out->ranges[out->nr-1].end < new_range->start) {
 			range_set_grow(out, 1);
-			out->ranges[out->nr].start = new->start;
-			out->ranges[out->nr].end = new->end;
+			out->ranges[out->nr].start = new_range->start;
+			out->ranges[out->nr].end = new_range->end;
 			out->nr++;
-		} else if (out->ranges[out->nr-1].end < new->end) {
-			out->ranges[out->nr-1].end = new->end;
+		} else if (out->ranges[out->nr-1].end < new_range->end) {
+			out->ranges[out->nr-1].end = new_range->end;
 		}
 	}
 }
@@ -696,18 +696,18 @@ static struct line_log_data *line_log_data_merge(struct line_log_data *a,
 static void add_line_range(struct rev_info *revs, struct commit *commit,
 			   struct line_log_data *range)
 {
-	struct line_log_data *old = NULL;
-	struct line_log_data *new = NULL;
+	struct line_log_data *old_line = NULL;
+	struct line_log_data *new_line = NULL;
 
-	old = lookup_decoration(&revs->line_log_data, &commit->object);
-	if (old && range) {
-		new = line_log_data_merge(old, range);
-		free_line_log_data(old);
+	old_line = lookup_decoration(&revs->line_log_data, &commit->object);
+	if (old_line && range) {
+		new_line = line_log_data_merge(old_line, range);
+		free_line_log_data(old_line);
 	} else if (range)
-		new = line_log_data_copy(range);
+		new_line = line_log_data_copy(range);
 
-	if (new)
-		add_decoration(&revs->line_log_data, &commit->object, new);
+	if (new_line)
+		add_decoration(&revs->line_log_data, &commit->object, new_line);
 }
 
 static void clear_commit_line_range(struct rev_info *revs, struct commit *commit)
@@ -1042,12 +1042,12 @@ static int process_diff_filepair(struct rev_info *rev,
 
 static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
 {
-	struct diff_filepair *new = xmalloc(sizeof(struct diff_filepair));
-	new->one = pair->one;
-	new->two = pair->two;
-	new->one->count++;
-	new->two->count++;
-	return new;
+	struct diff_filepair *new_filepair = xmalloc(sizeof(struct diff_filepair));
+	new_filepair->one = pair->one;
+	new_filepair->two = pair->two;
+	new_filepair->one->count++;
+	new_filepair->two->count++;
+	return new_filepair;
 }
 
 static void free_diffqueues(int n, struct diff_queue_struct *dq)
-- 
2.16.1.291.g4437f3f132-goog

