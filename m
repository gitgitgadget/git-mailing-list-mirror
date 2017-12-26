Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 614BD1F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbdLZJKt (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:10:49 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33596 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdLZJKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:10:48 -0500
Received: by mail-pf0-f193.google.com with SMTP id y89so18542526pfk.0
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAUDof6zRldSiDEc4GoxiLnAwUaJoX8nLlXF3uOTJNc=;
        b=trIeMqRXwhuZb6hD22OE/MR5bcbOtG7DuRcCQ3ujYKAUhqu2lfy+6nz3Ev4bPm5mBc
         wyKBKTj8cDpybbF02b7zWSsUsddomUtLQdEnsdBzUyfRSz3lkjpTLzpeigfkPyyVsm1Q
         PjBMiQ+y4TBEXhCHI0+biuIuqIo+In9bXctNUu6jbvRtvsMLa508WZe2d7RvCYh4GZQp
         tNEkcCbSSI+mthtpXJ48S7sS2RbK3i4PgvQ0Ewt6/vv5Ovu95FBeLpmFeieIUCQlp36i
         tTWv6aHz8yKlG3c8nHatuKkXuG18MYiGCR2AEVPOs6IYhYAyqS/3xxNmgUTHo+5uxNlJ
         NxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAUDof6zRldSiDEc4GoxiLnAwUaJoX8nLlXF3uOTJNc=;
        b=QqpBZ8RAVwboCvIsynkoMy9ZcGJqVx+OXEMliEeaibOjrNW6YcJjkZwAywcMG0d8OL
         w5vC6Bl1tmkilK4ovfQsCmK7AkPjxPshSXL/3yy4CdnIPoLuQEsl0aDz+4JYhVXw5giO
         TAbclKVo92sGbDPtrchlrgUuA6+YumMQ32NygYoL1BP18n+a3IiOHDeQH+tqKj3/hZgG
         +d32kszSdyYuTtSSuF8ttuZyP5W9VglGCee9bEqOeyWhS/01aQY+Qz3lfUKeI1yQ9IcR
         AvHFSN0eKZ6VU8qr2GVfBHnif58doRSQ3mwobT1goJSVxfKjsZY+4H4hNWVuzCzLMdO3
         Ofng==
X-Gm-Message-State: AKGB3mJyZPExYZd5Wzb4tXRjkemtA8OHNsTT9mFTvT4YwOGH0OjmDCMV
        1zW+1gt4QhNVPqLGo4QQu8hlKg==
X-Google-Smtp-Source: ACJfBosfvAuax7LvtN9b81aU+bsmxmjQJyQvkO6W1rdHivZWrNOiMH8cxWccmGW26V5hPFtS6eNHoA==
X-Received: by 10.99.114.30 with SMTP id n30mr21357716pgc.390.1514279448000;
        Tue, 26 Dec 2017 01:10:48 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id d66sm52527015pgc.67.2017.12.26.01.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:10:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 4/7] wt-status.c: rename wt_status_change_data::score
Date:   Tue, 26 Dec 2017 16:10:09 +0700
Message-Id: <20171226091012.24315-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171226091012.24315-1-pclouds@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to adding support for "diff-files" rename, which has its
own rename score in addition to the "diff-index" one. Rename score to
head_score to indicate this score comes from diff-index. The new score
will be named worktree_score.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 wt-status.c | 4 ++--
 wt-status.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index db06fc7c85..0f089c5789 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -532,7 +532,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
 			d->head_path = xstrdup(p->one->path);
-			d->score = p->score * 100 / MAX_SCORE;
+			d->head_score = p->score * 100 / MAX_SCORE;
 			/* fallthru */
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
@@ -2074,7 +2074,7 @@ static void wt_porcelain_v2_print_changed_entry(
 				key, submodule_token,
 				d->mode_head, d->mode_index, d->mode_worktree,
 				oid_to_hex(&d->oid_head), oid_to_hex(&d->oid_index),
-				key[0], d->score,
+				key[0], d->head_score,
 				path_index, sep_char, path_head, eol_char);
 	else
 		fprintf(s->fp, "1 %s %s %06o %06o %06o %s %s %s%c",
diff --git a/wt-status.h b/wt-status.h
index fe27b465e2..f9330982ac 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -44,7 +44,7 @@ struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
 	int stagemask;
-	int score;
+	int head_score;
 	int mode_head, mode_index, mode_worktree;
 	struct object_id oid_head, oid_index;
 	char *head_path;
-- 
2.15.0.320.g0453912d77

