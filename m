Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E45E20193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbcHHVEC (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32859 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbcHHVD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:03:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so17870175wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:03:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZA6MNDhQHuDyUQxrBIfFD3IY+t/juL3i201JWPtYKas=;
        b=PgDRHdvstObiXuhzxazZUAXwdlFZrtvRDP5v27FyxTPEHYXQfx4KoD6cWfuLVvhfUS
         nGRORrlVBnk/c2B9o+z6ZmU0cK+7dz3mDRgtvmBCrS09P/fYFF5ar9ZJSkz0WSNIIkU4
         QB1ZafkJUXIoVcfjvJuABVDanZSNsmdSyqJFqPdaSvZp5u7HsP8+YZuJDGQFu5ogb9zF
         jnwa9IgljH+D34CGOmTmYWkemCPMPWq8VMuZu5cL5M8kfPJ8EH4CuC0ErL9tkk5IUI1E
         WxFu7jcwXGNGQ60nDEUfrFqY8YEkIGd0JRhUyzIXFL1Ql2q8VbfhrZWNivormA8TV7fz
         /h9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZA6MNDhQHuDyUQxrBIfFD3IY+t/juL3i201JWPtYKas=;
        b=T8bBQMo41+kNyjOja+NEaxl+2d3PuE+ZN1lrvzg9d8WcW/pvfIBFN/riNbjSqEGFxx
         YSr6SiB/5qYXK5++0ESMGBWd+019xEJYNYrQQFMFUFbr+S1sK8bsn7QNZ8/4WiRGKxHN
         jHTHymgHXtgtsJnLN0Kv+CQ5amcrO2ISTkMzQoXP7l2/lW4TAbITxCSrvotZZegJFRtE
         w+ZJpqFq/7TNOpOMMJgPfJLJUUSBC8SyrbL9Tu/ekBlBm7TkCWmlDjFeq7KibMxiFxUu
         iqsF3Y9mUgZ8zUF+ktBAxnSr/cNu1ClK92Omi6QNpNq7UikkYXZDMSD2aIN3zgAX7Yu4
         VlLg==
X-Gm-Message-State: AEkoouvKaTTj3gEMIldkhhmTIPZPfvynfJHDwe/ON/YEDPipu2OAtGF6i0wZBR340HFf/Q==
X-Received: by 10.194.65.170 with SMTP id y10mr24236971wjs.26.1470690237491;
        Mon, 08 Aug 2016 14:03:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:03:56 -0700 (PDT)
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
Subject: [PATCH v10 04/40] builtin/apply: read_patch_file() return -1 instead of die()ing
Date:	Mon,  8 Aug 2016 23:03:01 +0200
Message-Id: <20160808210337.5038-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.9.2.614.g4980f51

