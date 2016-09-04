Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E165520193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbcIDUSy (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:18:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35363 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754535AbcIDUSv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id c133so10465219wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BghMkMCyZnXcJh2hnCbGjXIJjlQa9QzuXS/4pVBi3jU=;
        b=ioft1IVczCjU3Ojoz/IqTKZtgKkRsV0d3b2fmBMYHHYKyaflnx58oKMAFuM5kFmfCF
         1lsc2KS4px7RoH14cuGPlPuKaugYZ3Ric6F5yjX8c2BwBOD0a9owFEJ6G+fR/zQ4e7j5
         mseosm+c4MbzanOkDPhLdkLnFT6PjUf11GAKjFDPfgBxzG+kC2h06ZJMU5/UsBUnY9w/
         jt0qGX4Fl1t6mWYyDM4RZ4EjySpkVq1Mx/yYFAPfTXNGjtnsieUljpPBHkGosXEvP7KZ
         cji0u/p8u9o665ojs8Sm/Y8P5mamvhgc8JrPkbci+TcfdMbbgAHjlFM/KW3KKE5aEQID
         2IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BghMkMCyZnXcJh2hnCbGjXIJjlQa9QzuXS/4pVBi3jU=;
        b=aZpURoEqbk28SK3Rkl/AgitIAStFvY4ORmX2uZMZGKhzYNRHa3id5AAgDfpyH6LBuu
         G3UTTu3+4Ax29fP273OlHzXc/yN6qVKvk2LRKa6CeqaSH5bdNnHfstXHqwXYwcr85qH+
         qvBTGy5BcVJYgxsY1qjCZScx3up0XIZkYFBsMQP44IjJS6HjSvoqkZYXNrE4lQ3FkxCJ
         xkz4ULxp4zQzZKUbWKCTIyQ40kwULs0Gm18fLYQbZpsZaCyQc2s41z1MmZfqL+tXQHId
         Okfq6V8wo3n4vmAqhONoQkTjMk30CfNfBAHsFCvMHJVeZ/Z0/TZAtD++SyT3TvlPASKf
         PSrQ==
X-Gm-Message-State: AE9vXwPhedBwQx8O9AXimCx81i65YUzlW1thQOwkShvIWzuW3fRGv2ayzaWQ1GAzGGvAIg==
X-Received: by 10.194.176.69 with SMTP id cg5mr27462767wjc.52.1473020329975;
        Sun, 04 Sep 2016 13:18:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 04/41] builtin/apply: read_patch_file() return -1 instead of die()ing
Date:   Sun,  4 Sep 2016 22:17:56 +0200
Message-Id: <20160904201833.21676-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing. Let's do that by returning -1 instead of
die()ing in read_patch_file().

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 435030a..dd7afee 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -335,10 +335,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
 
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, int fd)
+static int read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die_errno("git apply: failed to read");
+		return error_errno("git apply: failed to read");
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -347,6 +347,7 @@ static void read_patch_file(struct strbuf *sb, int fd)
 	 */
 	strbuf_grow(sb, SLOP);
 	memset(sb->buf + sb->len, 0, SLOP);
+	return 0;
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -4425,7 +4426,8 @@ static int apply_patch(struct apply_state *state,
 	int res = 0;
 
 	state->patch_input_file = filename;
-	read_patch_file(&buf, fd);
+	if (read_patch_file(&buf, fd) < 0)
+		return -128;
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.10.0.41.g9df52c3

