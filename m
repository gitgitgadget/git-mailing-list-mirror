Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007DD20248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDLTpY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:45:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDLTpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:45:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so13325940wrw.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uywhj9yBzhvC96tsOjGIxhXjHzWvIdsEOFLnbNGReaY=;
        b=fvt4pe19jJrmkTFqL0IZACg9NvSM8StEQbxAr4xSf2Kr62BhwaCkgC5PfmHT/d5d7r
         lgrV73kBzjVsCyQ0pFAZ/uI0eTXg/lMbc0eOYPBDBWRBAazZaOfuXd2W3foPbhKY4Ut/
         8Ci4QNYicuK3B9bICVAaubswFtJn7Ly6sK7EbuXyuQKfpnL/BnkKhWrb391Zh/BSjivV
         cAap8uilLspCXPL1phhe7Q3aaS+I0uMTfBHDvJLJwz1yAQaEjOBa0dizx8k8u43kTSMl
         34dHn3/5RQG/1jW9RzW1Am61Oul/LyMFYrrsR/9VhiipoebWcsOtnQ2t9gS4YHpnwG1s
         K06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uywhj9yBzhvC96tsOjGIxhXjHzWvIdsEOFLnbNGReaY=;
        b=A8CqhqJ7O0YU3+r5v+0GvFPkRqavdzuS/BS3SviK5B0xR5CuTf9AQRL78/Qrw7Grc5
         ZvPeFVcJoIdppZI8+pKp2j89C+3FgpOhnPMix67uRgLwiLOo+oM4BdGCCpfrDFrJf3cu
         +4D6wWKdBn+frdOajw26IizwXqQq0tMePCyllmGsLNpZdqPkU8ob4XYINVkP90RkLopw
         Z+8y3HUNy74ramaIsPlCpNGJ82kocy1uNOW7ayLeitVQEF+gSHSrZ7GwCncuO4ipUVny
         TAIkqd7YNYaV3t7AD//JrnUjhyeIX3rka7uYbWmvBPtCUqOK9GdARkJX3XyCCBeCVo66
         NUWg==
X-Gm-Message-State: APjAAAWWbB7/Tm9GKC+GTvrWPGY0Z2k3NNwboH2+LBAT63i5zfwrMnwa
        7WQGv0gkZnUXhrFm5U+EmzY=
X-Google-Smtp-Source: APXvYqyRq78SKqdBH61nkyIbgglsspFtJV1etyrR2OP7w+cjelqJljDo7K4A9TnY1RcUiANHQUUuxA==
X-Received: by 2002:adf:f30b:: with SMTP id i11mr22708574wro.297.1555098321678;
        Fri, 12 Apr 2019 12:45:21 -0700 (PDT)
Received: from localhost.localdomain (x4dbe3614.dyn.telefonica.de. [77.190.54.20])
        by smtp.gmail.com with ESMTPSA id x5sm33503081wru.12.2019.04.12.12.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 12:45:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 0/4] Progress display fixes
Date:   Fri, 12 Apr 2019 21:45:11 +0200
Message-Id: <20190412194515.6244-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.746.gd74f1657d3
In-Reply-To: <20190405004539.31467-1-szeder.dev@gmail.com>
References: <20190405004539.31467-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes two progress display issues by breaking
progress bars longer than the width of the terminal and by properly
cleaning up the previously shown progress bar.  Hopefully for good
this time...

This "properly cleaning up" part, i.e. mainly patch 3, was buggy in
previous versions, because:

  - It used the wrong format flag and the '\r' was padded on the
    right, but should have been padded to the left.

  - The padding was one space shorter than necessary, because I didn't
    account for the '\r' included in the field width as well.


SZEDER Gábor (4):
  progress: make display_progress() return void
  progress: assemble percentage and counters in a strbuf before printing
  progress: clear previous progress update dynamically
  progress: break too long progress bar lines

 progress.c | 74 ++++++++++++++++++++++++++++++++++++++----------------
 progress.h |  2 +-
 2 files changed, 54 insertions(+), 22 deletions(-)

Interdiff:
diff --git a/progress.c b/progress.c
index 97e18671e5..2d8022a622 100644
--- a/progress.c
+++ b/progress.c
@@ -116,23 +116,24 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 		if (is_foreground_fd(fileno(stderr)) || done) {
 			const char *eol = done ? done : "\r";
 			size_t clear_len = counters_sb->len < last_count_len ?
-					last_count_len - counters_sb->len : 0;
+					last_count_len - counters_sb->len + 1 :
+					0;
 			size_t progress_line_len = progress->title_len +
 						counters_sb->len + 2;
 			int cols = term_columns();
 
 			if (progress->split) {
-				fprintf(stderr, "  %s%-*s", counters_sb->buf,
+				fprintf(stderr, "  %s%*s", counters_sb->buf,
 					(int) clear_len, eol);
 			} else if (!done && cols < progress_line_len) {
 				clear_len = progress->title_len + 1 < cols ?
-					    cols - progress->title_len - 1 : 0;
+					    cols - progress->title_len : 0;
 				fprintf(stderr, "%s:%*s\n  %s%s",
 					progress->title, (int) clear_len, "",
 					counters_sb->buf, eol);
 				progress->split = 1;
 			} else {
-				fprintf(stderr, "%s: %s%-*s", progress->title,
+				fprintf(stderr, "%s: %s%*s", progress->title,
 					counters_sb->buf, (int) clear_len, eol);
 			}
 			fflush(stderr);
Range-diff:
1:  cb68e5b0ec = 1:  cb68e5b0ec progress: make display_progress() return void
2:  017d095142 = 2:  017d095142 progress: assemble percentage and counters in a strbuf before printing
3:  c5a4def5ac ! 3:  ec9c96d102 progress: clear previous progress update dynamically
    @@ -49,8 +49,9 @@
     -				counters_sb->buf, eol);
     +			const char *eol = done ? done : "\r";
     +			size_t clear_len = counters_sb->len < last_count_len ?
    -+					last_count_len - counters_sb->len : 0;
    -+			fprintf(stderr, "%s: %s%-*s", progress->title,
    ++					last_count_len - counters_sb->len + 1 :
    ++					0;
    ++			fprintf(stderr, "%s: %s%*s", progress->title,
     +				counters_sb->buf, (int) clear_len, eol);
      			fflush(stderr);
      		}
4:  2f44dff84e ! 4:  8fc8e3cf94 progress: break too long progress bar lines
    @@ -69,27 +69,27 @@
      
      static volatile sig_atomic_t progress_update;
     @@
    - 			const char *eol = done ? done : "\r";
      			size_t clear_len = counters_sb->len < last_count_len ?
    - 					last_count_len - counters_sb->len : 0;
    --			fprintf(stderr, "%s: %s%-*s", progress->title,
    + 					last_count_len - counters_sb->len + 1 :
    + 					0;
    +-			fprintf(stderr, "%s: %s%*s", progress->title,
     -				counters_sb->buf, (int) clear_len, eol);
     +			size_t progress_line_len = progress->title_len +
     +						counters_sb->len + 2;
     +			int cols = term_columns();
     +
     +			if (progress->split) {
    -+				fprintf(stderr, "  %s%-*s", counters_sb->buf,
    ++				fprintf(stderr, "  %s%*s", counters_sb->buf,
     +					(int) clear_len, eol);
     +			} else if (!done && cols < progress_line_len) {
     +				clear_len = progress->title_len + 1 < cols ?
    -+					    cols - progress->title_len - 1 : 0;
    ++					    cols - progress->title_len : 0;
     +				fprintf(stderr, "%s:%*s\n  %s%s",
     +					progress->title, (int) clear_len, "",
     +					counters_sb->buf, eol);
     +				progress->split = 1;
     +			} else {
    -+				fprintf(stderr, "%s: %s%-*s", progress->title,
    ++				fprintf(stderr, "%s: %s%*s", progress->title,
     +					counters_sb->buf, (int) clear_len, eol);
     +			}
      			fflush(stderr);
-- 
2.21.0.746.gd74f1657d3

