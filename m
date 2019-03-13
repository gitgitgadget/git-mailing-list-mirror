Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D633820248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfCMXdg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:33:36 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:35814 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCMXdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:33:36 -0400
Received: by mail-qt1-f201.google.com with SMTP id x12so3650092qtk.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=12Z/m5YDUM84tdGRvR47JgmciR7HxImmWbdrccXxMs4=;
        b=MwZjerySUvo50lo1IEaQ8V4YtEVwqrJsV6aL+k4LJ2oo8sWqfotd0n0Jqk1MHdLBYG
         vMeh3aVkPsAuakgyawuJjUKWCYxUobajTTChXLN15+TLyrBlSYowoY0zYBLbt7NMUbsS
         7BIsBch3iw00WyNgI9TpMxA0klydZQ/apjGecxkciRHb3FAlLE9yBYUkCYlI0mDpyEkW
         8oukZq1mtISonVsDwsItR7yqUrq+/CLVZ4lfmOxpKTtFYX8HSxvSpXWgDHOhALm1CYIW
         AcXoD6bqYprz92ORNj7GfuBKAaCm1UA4E9bjAVi4K0qLHo21CjGqka5kD0ECMRgyTa7a
         ivEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=12Z/m5YDUM84tdGRvR47JgmciR7HxImmWbdrccXxMs4=;
        b=pCvhiK3hjzKeuVUggNUuGvQrsQGVbl8jFS4atnqSY8RkkJxB1OuBZLgOPoLkMcC5l6
         2O9mrlUGhLaa60RySXRK59PbEoygu4dHMvLZ+56Xb9itXLYFZXyjGa1OA46S1/1p8knZ
         NFsp5gtCYrIe0Qz+D2fd9iWiIk2kpGVaa8s0ngYVkC4hLKVtXjgf6WJzgzrJBful0ZOv
         xOiYyPHbm1A6GIPzHpagx2EzSyB9Rzg9p7jTkFro3qc5Yj69uLP5pkllxtDUYFixMbpO
         CE1R6gJ7lGha8qDWEx7FHn4Iq9RJ390a8m3b2ivG1doLes0kW1ItERvVuQmIUAILQ3vx
         Dkxw==
X-Gm-Message-State: APjAAAUUDZ3pZV6ZFQlE9dC77/OjhfG350U34rvYc47x31Q5sHOzaDnD
        YAenqEsrMrZXu8GUIaGmHRPkJXqPRmUV6NKDJtH/tGs9qAbF2n/0folqhvddD9LO5cR2SX+vXH6
        6j7LspRvMwK9aJn2fSL8liIvhEoYbpNbgDrB6XKV8mQn8f0iidGYGRihJgJckbks=
X-Google-Smtp-Source: APXvYqyPgEILhjkoSX0c5BLKCDqmKTR3cBDbDLHLUekKzws3oAd32O55SV879dLsH7pt4EnjwZmgNY5i/xJ3LA==
X-Received: by 2002:a05:620a:c:: with SMTP id j12mr19890486qki.29.1552520015434;
 Wed, 13 Mar 2019 16:33:35 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:33:28 -0700
In-Reply-To: <cover.1552519463.git.steadmon@google.com>
Message-Id: <e6b01ad4bfe48cbf09c120756d0e7cac198ea6f0.1552519463.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1552519463.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH 1/2] date: make get_time() public
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_time() is the standard way to get the current time while also
respecting frozen timestamps for tests. Expose this for use in other
files.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 cache.h | 1 +
 date.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index abd518a9a2..0a2c436d0a 100644
--- a/cache.h
+++ b/cache.h
@@ -1489,6 +1489,7 @@ struct date_mode {
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
+void get_time(struct timeval *now);
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
 void show_date_relative(timestamp_t time, const struct timeval *now,
 			struct strbuf *timebuf);
diff --git a/date.c b/date.c
index 8126146c50..33576d2deb 100644
--- a/date.c
+++ b/date.c
@@ -115,7 +115,7 @@ static int local_tzoffset(timestamp_t time)
 	return local_time_tzoffset((time_t)time, &tm);
 }
 
-static void get_time(struct timeval *now)
+void get_time(struct timeval *now)
 {
 	const char *x;
 
-- 
2.21.0.360.g471c308f928-goog

