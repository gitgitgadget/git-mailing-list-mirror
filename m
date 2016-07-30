Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A2F1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbcG3RZg (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:25:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35173 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbcG3RZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:25:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so20039280wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ll/WHIn5E3LSGCQHHsYPRWPiKHEEwstjF1rRDd8hH7g=;
        b=YLxas0gF38fTcDCWR9L71Z5b8UtLSGxnvLLzStcKpIlYBfX2g9wy2XXnkKQpcaTCLc
         NHeQlZocQELrrDRqAXxf1FqBpm8QPue62DqS0jwssKhmKt62d9FaonWPGYKkiyPIKU2I
         f54cbXzW9lNJswC2kJxOPWid700IR1bJuujNy0vwiaPoMK9mcBlJhyO74RfwbBWDAQ3z
         9RFUT7rF/YXG/Bc7LlOLXGD45dk3Z+ClRgPYBRlI2q49lR1HDWo8GRbSbu62uI/gYuMG
         CrvXjbeZpTolJm+jRJtGf7SCPATMGsi3w3JhO/W4Gv2GgfZNFeOwthf3uPGHoQ1OP5Uj
         OecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ll/WHIn5E3LSGCQHHsYPRWPiKHEEwstjF1rRDd8hH7g=;
        b=USlm2+541YmC8xgFb2KEZoPNjgCQ14s93cvLsO2bGrWevoDRSw43PI47MnWtevaNSB
         6JIwu7BJGgPi4zPYoA8A8iTMiF0dWM1StXlnY0RGTVtfz7nRX3QY4+B5p4PfqK/DT9Jg
         ZsvNmW1c5X8yIMc7JHKsAPZdiBKcq3eOj3rfc/X1ZUre6pP9E2xsi5xsghLqgeHlfa3t
         /EjkXbiOkfUApOhN7dPfHn3gFN4st0McIzT3MWN7ZaQ09F+0tBYUY4NeMLOPw6q/cxoZ
         90rnTuo+a/hmE/Ol233CdmSAzSKdUIcRoJQ2c1+eruffABFFyRPba4I1cJ+hEyd0sZvz
         lfxg==
X-Gm-Message-State: AEkoouvxdI3wDWqvvcpPzal0HLu98oUKT0znlL7Kpg3KvF/2uhrSq/Z/GmL8/72qBSQDHw==
X-Received: by 10.28.60.136 with SMTP id j130mr51696207wma.93.1469899526590;
        Sat, 30 Jul 2016 10:25:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:25 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 04/41] builtin/apply: read_patch_file() return -1 instead of die()ing
Date:	Sat, 30 Jul 2016 19:24:32 +0200
Message-Id: <20160730172509.22939-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing. Let's do that by returning -1 instead of
die()ing in read_patch_file().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 435030a..e710ef7 100644
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
+	if (read_patch_file(&buf, fd))
+		return -128;
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.9.2.558.gf53e569

