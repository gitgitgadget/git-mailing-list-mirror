Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEBE1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeA2Wiv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:51 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:39992 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeA2Wic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:32 -0500
Received: by mail-oi0-f74.google.com with SMTP id s5so5933554oib.7
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Qx7h1fUrRJLlkfTEiT9mBPNiH5w8EtVSRRDJKTcPn2Q=;
        b=aXPt2IYYPigytRWxq3Ec1VjjU58yIkyBSMfUl5wDL902QvCfvpuqYXyGi8q/BxszMv
         ROZPwSKTOYQqud6i5co/q4hNJnPIoHthkY/D/tkKjywN6wKjwWIqDrK1YXzsiWQ3G2Xk
         Ux8V7QO0j0GoIShci3hnP0+Vkt3ehNx99K62wpQsuisZx9/Pd1ZOht8yVzwlFQrxzARV
         slqOySFIGgvOhIp20jUotawsVlNP5+LqYj/fdNqhkuiolpLc37APnqOCwdZFLCL5vX1Z
         tRpVawFBU9C7vP3ANNesHQz5xO+P0p0Ke1DXulEcT5kkOlu+TUu/dMPe6QjJQqHALQCi
         O4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Qx7h1fUrRJLlkfTEiT9mBPNiH5w8EtVSRRDJKTcPn2Q=;
        b=B6dfXgQpxVPf2ryMZ9zeh39Te9owwKyxGQwP0xy9SfMSAtIsWROo9pq2QZNaMEz1P+
         CwQyqhdlr/s//XHDpszoqPjhvdbuf+IhVihqNJvSqBedTPeWedNhQuQLR4j+pTWX5GWE
         A+p4KqtVCmw7MsWYGPz0NHpb3h6A7iKEzp2ipsnuF/KkCnbXlReSI3pKBbN+bKIw6NjQ
         SZzy+ThjSdCffqnhv2XvbmJHYMFJ4GU5eShzQO+UApEpX4ChjgqwobCeQTnneKngbp9d
         m6YtZ4uDybnjiaz6qnpMttsx/lhts6mz1mstfA8Mt/PGcNBinrisdW1zKtiCDKwbOjfq
         YxxA==
X-Gm-Message-State: AKwxytcNBYRETJ7/VqBnuHdl8yNFSmVoe8FWo034pbgyjhqjiu8tzNrP
        Ki/ihTgSHzhJvIALIb01ffvFNNU6H58vDAonk0WNW4c78qnzIMfyfndholcTpHNT2X4vICXADx9
        q7TWtrPsMJrQFr+YI02kKOMrLx6siyhZYFY9Kz6xqicHRDn++tqf5tiMxRw==
X-Google-Smtp-Source: AH8x225b9+Lbk/4l8R1Tz0AxWBN58uzriGKspNtqEGrt/TOUSfCGejS2COcvg08ID0tatpoFHJVuoK7d6vc=
MIME-Version: 1.0
X-Received: by 10.157.17.23 with SMTP id g23mr18375953ote.14.1517265512299;
 Mon, 29 Jan 2018 14:38:32 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:13 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-23-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 22/37] line-log: rename 'new' variables
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
 line-log.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/line-log.c b/line-log.c
index 545ad0f28..346664c3d 100644
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
@@ -697,17 +697,17 @@ static void add_line_range(struct rev_info *revs, struct commit *commit,
 			   struct line_log_data *range)
 {
 	struct line_log_data *old = NULL;
-	struct line_log_data *new = NULL;
+	struct line_log_data *new_line = NULL;
 
 	old = lookup_decoration(&revs->line_log_data, &commit->object);
 	if (old && range) {
-		new = line_log_data_merge(old, range);
+		new_line = line_log_data_merge(old, range);
 		free_line_log_data(old);
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
2.16.0.rc1.238.g530d649a79-goog

