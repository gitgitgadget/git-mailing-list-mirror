Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCB420248
	for <e@80x24.org>; Mon,  1 Apr 2019 11:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDALw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 07:52:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42452 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfDALw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 07:52:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so11605431wrx.9
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnDxTY7/ZS55dgLcWzElM8Dh936JJMBgA0ELfkgun00=;
        b=l4xyXp3LwWm5xqTw96LGcFvrpQK8tCOAlCxr3h21XzPXcIKNmfoOlJ8DP0hS8+IimX
         m48QiJqJWy4GYtqPpmDZQEtcROkar8uixz+8zsMEQpl9yESV3sXnio9YVxJF1MefZfGQ
         OjwoLb5TE4U2f1lzGndyYp+721ihAL+GgZEWH0ElcwKv4deVlOHMUx7kywFB6f6CGgap
         /fn15rCFWxy1ahub8GinRBuau5z58saGsjlM62GRUKwdtmrNX6ZmLkktkeV2aMeSk6S+
         7IWyyizVFmksRi3TmRP8kiC6EzvQBEUeYkisXcWq2tbOM2V8Bs5bsAVYRqAiwQfWragA
         Wrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnDxTY7/ZS55dgLcWzElM8Dh936JJMBgA0ELfkgun00=;
        b=JBCDc7TboDw7K2qGH1TH2sEtVgV8DRKWZM4XbXL8ZMUMPrmR8Ms0x0S1NA2AMIijks
         Gnrjy7jy5EHZFwBiuEhb+JCMTjaVKbjmI7XtTXFuDM9kCZ3fViRwFQx0E5fyNa0MQHOh
         IntPY/W5r672F31xCW88PYCerbILEKJHnalf2G46h8NGTCVKpqDjOYRNrhc9YcBUGXe+
         4aDZrgx9bfiFKbetlYRaz2FlsCEAxENAlMHc4hs5gCgM5wMD9vpgK+Ry4TuRC2OvvB8v
         nEoQD2Yx3FuqbejNjSlqcRQux91nPBEzP+sKmgejDuu722lssSdHuAYILucYKeVyQVu6
         hXLw==
X-Gm-Message-State: APjAAAVASSoWxt3Ph907ZAMIMmGcelg3u2Fxe6xLNEXrPbqP8eLlzoHq
        /pQ+F/jqVraUcHPeYb5LK9o=
X-Google-Smtp-Source: APXvYqy0mhkSgjAaVEJKjScMjQ0WqbojoaE78Kvwv3FEQe2uj8E/e2hBuS/tedhur496N+SEHo7qfg==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr42266839wrx.24.1554119545492;
        Mon, 01 Apr 2019 04:52:25 -0700 (PDT)
Received: from localhost.localdomain (x4db6660d.dyn.telefonica.de. [77.182.102.13])
        by smtp.gmail.com with ESMTPSA id f11sm11250970wrm.30.2019.04.01.04.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 04:52:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/4] progress: clear previous progress update dynamically
Date:   Mon,  1 Apr 2019 13:52:16 +0200
Message-Id: <20190401115217.3423-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190401115217.3423-1-szeder.dev@gmail.com>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190401115217.3423-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the progress bar includes throughput, its length can shorten as
the unit of display changes from KiB to MiB.  To cover up remnants of
the previous progress bar when such a change of units happens we
always print three spaces at the end of the progress bar.

Alas, covering only three characters is not quite enough: when both
the total and the throughput happen to change units from KiB to MiB in
the same update, then the progress bar's length is shortened by four
characters (or maybe even more!):

  Receiving objects:  25% (2901/11603), 772.01 KiB | 733.00 KiB/s
  Receiving objects:  27% (3133/11603), 1.43 MiB | 1.16 MiB/s   s

and a stray 's' is left behind.

So instead of hard-coding the three characters to cover, let's compare
the length of the current progress bar with the previous one, and
cover up as many characters as needed.

Sure, it would be much simpler to just print more spaces at the end of
the progress bar, but this approach is more future-proof, and it won't
print extra spaces when none are needed, notably when the progress bar
doesn't show throughput and thus never shrinks.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index 842db14b72..3149ecd460 100644
--- a/progress.c
+++ b/progress.c
@@ -84,6 +84,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
+	int last_count_len = counters_sb->len;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -110,10 +111,11 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 
 	if (show_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
-			const char *eol = done ? done : "   \r";
-
-			fprintf(stderr, "%s: %s%s", progress->title,
-				counters_sb->buf, eol);
+			const char *eol = done ? done : "\r";
+			int clear_len = counters_sb->len < last_count_len ?
+					last_count_len - counters_sb->len : 0;
+			fprintf(stderr, "%s: %s%-*s", progress->title,
+				counters_sb->buf, clear_len, eol);
 			fflush(stderr);
 		}
 		progress_update = 0;
-- 
2.21.0.539.g07239c3a71.dirty

