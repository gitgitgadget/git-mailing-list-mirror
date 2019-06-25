Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDECE1F4B6
	for <e@80x24.org>; Tue, 25 Jun 2019 06:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfFYG0k (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 02:26:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43644 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbfFYG0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 02:26:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so14982366ljv.10
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 23:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pS9JZVCL/WsUZoA6pQ6nVzLrH0h7+sd/dAs5669LLrI=;
        b=L9gUHKUu5SF/KQenQA0dPUveIM12vx2ct/Sxa0a7vP5ofnevPv259eQ/zl14DrQgB+
         LcxkpVxMbgEudD/gJodIR3foo0gLzK0tsr2dfOUj0ZdbeNH8uU7nVmSZVjAQp19VeVIC
         KjD0rPkFHydITMMHMKJ+eKooEdEZXvd+RuzaJjh9MNndlqPlq/k+JQFub9D9P5ZxySs8
         NWTLUwd3mpZB7lKCVyBg6gxJRFVA3gI9TI8Qr83jE90FKfUTqhEKOp3s0w6b9XvstGoq
         hjZeInbHQrX2HvrmT0vkYCCVT1x4pAyCQsKPS1ZuxZCr+e/XWwZH0ikmgktStBynxreg
         Mw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pS9JZVCL/WsUZoA6pQ6nVzLrH0h7+sd/dAs5669LLrI=;
        b=gFJx0c84N5sPYnFSWiFDwCW70zQwr7J8gt6NhM2oW11bIlSHPyAB1C7TCsseQ0jFGQ
         BMUizV/CiEaweLtvHj5l5o0UFgciU8RsQDExfdBbvzBFX/MiaJ/7eWbpOZuaibYGsjdZ
         LQaKZB/X42sRICnqGWa6gLjS9Ipg+Z3MjIkjz1PSoQr7L4WWtod76FFmXkCJxoOUUxjX
         rbVHMyULQfGunfEXOgGD60fZz9b9Gc3srvRPMAXj7/RbmsJqNyI3Tdcu9b8Q1jWq1E+s
         dFPsoc3v2gPWl2klhCFxRVrEsLugxBgFp6577Sn0WmivAUDQqYyzNwfwLN/oJ6qKN4Tn
         PYMw==
X-Gm-Message-State: APjAAAXwY+Qiw31PgE2cHGMhMVG9J+yQRftS/jXmlb+bcLmX6uJsiMab
        yL0YIKOLgYD1eJRMLcGkipcdX2ZYuWsfJQ==
X-Google-Smtp-Source: APXvYqz9xbZQVPoOCmYIX0iJ1Q1b5Je43Gog72DK//K5piaK6QW0JJ7HPXc2pCDrFng5K4uTzfTm7w==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr45174024ljh.175.1561443997742;
        Mon, 24 Jun 2019 23:26:37 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id p15sm2099752lji.80.2019.06.24.23.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 23:26:36 -0700 (PDT)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH v5] l10n: localizable upload progress messages
Date:   Tue, 25 Jun 2019 09:25:40 +0300
Message-Id: <20190625062540.88973-2-dimitriy.ryazantcev@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currenly the data rate in throughput_string(...) method is
output by simple strbuf_humanise_bytes(...) call and '/s' append.
But for proper translation of such string the translator needs
full context.

Add strbuf_humanise_rate(...) method to properly print out
localizable version of data rate ('3.5 MiB/s' etc) with full context.

Strings with the units in strbuf_humanise_bytes(...) are marked
for translation.

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 progress.c |  3 +--
 strbuf.c   | 37 +++++++++++++++++++++++++++++++++----
 strbuf.h   |  6 ++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index a2e8cf64a8..951f7c7461 100644
--- a/progress.c
+++ b/progress.c
@@ -150,8 +150,7 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
 	strbuf_addstr(buf, ", ");
 	strbuf_humanise_bytes(buf, total);
 	strbuf_addstr(buf, " | ");
-	strbuf_humanise_bytes(buf, rate * 1024);
-	strbuf_addstr(buf, "/s");
+	strbuf_humanise_rate(buf, rate * 1024);
 }
 
 void display_throughput(struct progress *progress, uint64_t total)
diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..785c9e5b55 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -814,19 +814,48 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf, "%u.%2.2u GiB",
+		/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
+		strbuf_addf(buf, _("%u.%2.2u GiB"),
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u MiB",
+		/* TRANSLATORS: IEC 80000-13:2008 mebibyte */
+		strbuf_addf(buf, _("%u.%2.2u MiB"),
 			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+		strbuf_addstr(buf, _(""));
 	} else if (bytes > 1 << 10) {
 		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u KiB",
+		/* TRANSLATORS: IEC 80000-13:2008 kibibyte */
+		strbuf_addf(buf, _("%u.%2.2u KiB"),
 			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else {
-		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
+		/* TRANSLATORS: IEC 80000-13:2008 byte */
+		strbuf_addf(buf, Q_("%u byte", "%u bytes", (unsigned)bytes), (unsigned)bytes);
+	}
+}
+
+void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
+{
+	if (bytes > 1 << 30) {
+		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
+		strbuf_addf(buf, _("%u.%2.2u GiB/s"),
+			    (unsigned)(bytes >> 30),
+			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+	} else if (bytes > 1 << 20) {
+		unsigned x = bytes + 5243;  /* for rounding */
+		/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second */
+		strbuf_addf(buf, _("%u.%2.2u MiB/s"),
+			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+		strbuf_addstr(buf, _(""));
+	} else if (bytes > 1 << 10) {
+		unsigned x = bytes + 5;  /* for rounding */
+		/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second */
+		strbuf_addf(buf, _("%u.%2.2u KiB/s"),
+			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+	} else {
+		/* TRANSLATORS: IEC 80000-13:2008 byte/second */
+		strbuf_addf(buf, Q_("%u byte/s", "%u bytes/s", (unsigned)bytes), (unsigned)bytes);
 	}
 }
 
diff --git a/strbuf.h b/strbuf.h
index c8d98dfb95..f62278a0be 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -372,6 +372,12 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
  */
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
 
+/**
+ * Append the given byte rate as a human-readable string (i.e. 12.23 KiB/s,
+ * 3.50 MiB/s).
+ */
+void strbuf_humanise_rate(struct strbuf *buf, off_t bytes);
+
 /**
  * Add a formatted string to the buffer.
  */
-- 
2.22.0

