Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBC820248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDLTp2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:45:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43642 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDLTp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:45:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so8704313wrx.10
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErmQJiREhoV0DLwYLbn+aMtYAjsEEmpykhC3s4WEebU=;
        b=r8Hk8AtndilkNi32e5MlyvhPClVwYvLctZhBloqtk14fM7DPCm+qg8b40xr6HF9yug
         a5dyOpP4frGGwYAnswpkLyzbVxquPDTdXR1LX733z6cBbrOTbq4tSUSQE637W8b3crpb
         C/OX5tRHwpcnafvhEDJRmmLcc2CFzYRH1oR3I5oGbJU3nA1vAsAHwg4mzqPsKuX7rtLA
         +WjA9us8sD1xBW5Qa23Tq5YgF4QX/WiW86uiFzLNZ7O+Uw9eHy5Cm3nSA1HImaJLeUpF
         CzPVCZYKcDGts085yHwbGI2nYhIBZyjZk99DnyuMNeCV1Bf69KK66WFTH4RwldxTBHKW
         o6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErmQJiREhoV0DLwYLbn+aMtYAjsEEmpykhC3s4WEebU=;
        b=qwKmo9kP0c+bpnLcybupdvG6200y6G/DyJkPPcX0sakuW3J1yi/7ToLoLNub2TCgDE
         j2sXJVUQFsxqJR2pYk1E21AIBDGAMyR6sBQNMwrMMDJ0OCKX1uboMzHFNuQtXgvNIIDv
         xjIQVLX+W1mrmxGQvh69ur+JTHLodSCQIzjHXYmkKuNRy54mdVt50kujq0SPc960qin0
         7R1J2HPHN+3y5itDEVB4igwhgrVWjj7+ewDAbJotNs2OY2ArZ6j5OgCbm+/NXo4nz2Yq
         paZHFqev/87cdTY5dA01+wZ/xlpiYVHOVzCJF6O54+wWBKYB5/on/lBk6dhVgjlHnnMy
         I2vg==
X-Gm-Message-State: APjAAAUXKmC5Y2wxUhIGZbHbIExaxBVBdlvxUjgTvYyQaaUQcbSiaHWJ
        ubDl7Cjb8NXQtZxMP+16jhc=
X-Google-Smtp-Source: APXvYqwz4NwAtKfWWLdlHh4pRPGA+PWLBSLyVq3sVaaBIoFONm403HpTTknouTJoxwa1noP2P03YPg==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr28794207wrn.89.1555098325134;
        Fri, 12 Apr 2019 12:45:25 -0700 (PDT)
Received: from localhost.localdomain (x4dbe3614.dyn.telefonica.de. [77.190.54.20])
        by smtp.gmail.com with ESMTPSA id x5sm33503081wru.12.2019.04.12.12.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 12:45:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 3/4] progress: clear previous progress update dynamically
Date:   Fri, 12 Apr 2019 21:45:14 +0200
Message-Id: <20190412194515.6244-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.746.gd74f1657d3
In-Reply-To: <20190412194515.6244-1-szeder.dev@gmail.com>
References: <20190405004539.31467-1-szeder.dev@gmail.com>
 <20190412194515.6244-1-szeder.dev@gmail.com>
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
 progress.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index 564845a36b..949a2a576d 100644
--- a/progress.c
+++ b/progress.c
@@ -84,6 +84,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
+	int last_count_len = counters_sb->len;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -110,10 +111,12 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 
 	if (show_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
-			const char *eol = done ? done : "   \r";
-
-			fprintf(stderr, "%s: %s%s", progress->title,
-				counters_sb->buf, eol);
+			const char *eol = done ? done : "\r";
+			size_t clear_len = counters_sb->len < last_count_len ?
+					last_count_len - counters_sb->len + 1 :
+					0;
+			fprintf(stderr, "%s: %s%*s", progress->title,
+				counters_sb->buf, (int) clear_len, eol);
 			fflush(stderr);
 		}
 		progress_update = 0;
-- 
2.21.0.746.gd74f1657d3

