Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE4320248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfDEAqh (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:46:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50315 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbfDEAqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:46:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so5001516wmi.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrQBValqjzxHipZkzFJCeG3Y/2eUlvr71huRPXZOqy8=;
        b=aqVhyDQb4QZibroWi3hFPVrF8voXnMfCIe7lbP2cQulkGGnK6py43bbfT0GaWHLDE3
         Jk/bTCbLX0lDiKSa7nem0Tczgpu9Zb/ZuLiUXV3YA9nBMxRO0jFi/6FdKK8ypW1lBIGT
         dhDofWd+BncWcc1k9wyj2cYs38uugNYT9gIMtI3C4XTYTQ4Sgac7qOknq6kHIdk79zcI
         s18h5u+ItKLQ0Pi+W8NSWB1XHR/7Uinl23o6gLXmyinYBzeU5kGJxFiRLkRmjcN+PujP
         Hx9JPiVxmFBULKCoG+T0Qar+Or2XYWIcylVTsavzS6q9Ki9bjfb5h2QK1EOGrBaE9cII
         AV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrQBValqjzxHipZkzFJCeG3Y/2eUlvr71huRPXZOqy8=;
        b=QjK0Z3OuwuoMkq1mFl6PvjcVxAdz9Ncb0zlbgBWAXvpvmndNKaf4Aj0JLioR412TTP
         vHgpf8GSQjJRTnbp8bOOsi0WH/eSbGbo5vAjOhOJaN0QjQSe3v7l6NFjZgbCjlLGQwCv
         3+03KGlZ0MOOX/BjgAs/SqNINlsXxiSQJHt8hrYvgEK9+kJD2zDTEkXLRHMJ5d4t1QfF
         NPZbCkMr4dG+suve18vJglNpVgrNHjFmf2OB0cGsyLQk4/RO8N87ZvoWPN2jSuajtw82
         caFs1XBqKxt9pGQamloP+ijrfBD0F0tc4bioKH2RUNIsJQ+eCqVJmyTL+vWIZ03Wh4B1
         STAw==
X-Gm-Message-State: APjAAAX0gQWhLfM+yNSHUbVw6jpgvyFXBgVb3PVW4Sw8FzFdNMSpPZZV
        k6U0W4kTf9amy9+zeup6JoE=
X-Google-Smtp-Source: APXvYqyaVJmxi9kGMjM93EAPTccXw6kaymCQE1x00tHHlbFO6yhJWWH2gWfXZzaKETPlVTp49RBKdA==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr5685664wmq.102.1554425194510;
        Thu, 04 Apr 2019 17:46:34 -0700 (PDT)
Received: from localhost.localdomain (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id d17sm28137301wrw.88.2019.04.04.17.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 17:46:33 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/4] progress: clear previous progress update dynamically
Date:   Fri,  5 Apr 2019 02:45:38 +0200
Message-Id: <20190405004539.31467-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190405004539.31467-1-szeder.dev@gmail.com>
References: <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190405004539.31467-1-szeder.dev@gmail.com>
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
index 564845a36b..ca0945d2be 100644
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
+			size_t clear_len = counters_sb->len < last_count_len ?
+					last_count_len - counters_sb->len : 0;
+			fprintf(stderr, "%s: %s%-*s", progress->title,
+				counters_sb->buf, (int) clear_len, eol);
 			fflush(stderr);
 		}
 		progress_update = 0;
-- 
2.21.0.539.g07239c3a71.dirty

