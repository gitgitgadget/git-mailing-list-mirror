Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45531F461
	for <e@80x24.org>; Tue,  2 Jul 2019 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGBSXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 14:23:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35500 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBSXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 14:23:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so17973306ljh.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6Z5hEvS9wMpA/RPJc4dlc2BRpgyRlaZDnhYc21xwy0=;
        b=Y2pZaTQKaLYPK0NtjL2a4dhJMPK4Ml45PTY7y8LGxq6KWJRkjPZ71SMiYul9LNWrC0
         ujrUs+UTWWULTqYbcQXYw8XVf/lL/ltMnymZnt0RfNvwVYJJvgxM6j6a6VP1IOxhAz9f
         KBkpEOFmjNg0ciB41LZHvlk9DWUpqyzjeLDd2wXvaFIok6oQ3HwVOvgMsmYmp1TW72vK
         7c9i644jk41LaOTa1wlTm80Klpngt0g+w3qKLvWdTa9R4Lw6tK3/xZxVi9ck7XKkzY/l
         8/P5lZkbU5T7BDYj0cgvW4D9EO9X820dnUkpDcFmlsXoU3CTdbiPP/FE4jWa2XGBSjeh
         eEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6Z5hEvS9wMpA/RPJc4dlc2BRpgyRlaZDnhYc21xwy0=;
        b=dshDqXbfvXJtw17KIFOMRv8CNYYqxA//g/KhlVYJuokv2NOrZyTt4MrcUDRfEGx3Ut
         i8EcdqI9f90UMkd7v8V/z6aQ18eLCihuPR/HMyhRXXFOnSb6Fy1U7fD8sgRVXmv2EWEW
         4AAhaJGAh5q9Po1NCQSnHkQaiNkWtqtG4OyrB27scc2qj6q+pS9byFpUlujuNVh4uVRE
         YjU7yiRsmUWJ9VRIjyDWkwiADegkuXD7eQ5aIt7LNvLzlPg6lzDQ0tLMIJr4bbTXdVs6
         4vmATED3nUU6+P3anEfNoGIC7FIaOE+sASb0ICIvi71rWuEf1Kk0uIrW//31oDRwq1CE
         bPjw==
X-Gm-Message-State: APjAAAVU0X+aS2V/6GeYuIglTJ/DwF39IzNPzazj8hMWqiVZDju4QOJh
        DQnnc5/+y1wd5BRYB8xRIf3t5B2G0A2ASg==
X-Google-Smtp-Source: APXvYqw3Yi4wt5lq+xOW1xBB6oTCG1rviCCA2p1Ojr+CnFUOJHXLJHU32vU3PdaHockSt6Uodo0JEQ==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr6730515ljj.170.1562091789838;
        Tue, 02 Jul 2019 11:23:09 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id c74sm2086163lfg.57.2019.07.02.11.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jul 2019 11:23:08 -0700 (PDT)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH v6] l10n: localizable upload progress messages
Date:   Tue,  2 Jul 2019 21:22:48 +0300
Message-Id: <20190702182248.5322-2-dimitriy.ryazantcev@gmail.com>
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
 strbuf.c   | 42 +++++++++++++++++++++++++++++++++++++-----
 strbuf.h   |  6 ++++++
 3 files changed, 44 insertions(+), 7 deletions(-)

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
index 0e18b259ce..d30f916858 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -811,25 +811,57 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), reserved);
 }
 
-void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
+static void strbuf_humanise(struct strbuf *buf, off_t bytes,
+				 int humanise_rate)
 {
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf, "%u.%2.2u GiB",
+		strbuf_addf(buf,
+				humanise_rate == 0 ?
+					/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
+					_("%u.%2.2u GiB") :
+					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
+					_("%u.%2.2u GiB/s"),
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u MiB",
+		strbuf_addf(buf,
+				humanise_rate == 0 ?
+					/* TRANSLATORS: IEC 80000-13:2008 mebibyte */
+					_("%u.%2.2u MiB") :
+					/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second */
+					_("%u.%2.2u MiB/s"),
 			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
 	} else if (bytes > 1 << 10) {
 		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u KiB",
+		strbuf_addf(buf,
+				humanise_rate == 0 ?
+					/* TRANSLATORS: IEC 80000-13:2008 kibibyte */
+					_("%u.%2.2u KiB") :
+					/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second */
+					_("%u.%2.2u KiB/s"),
 			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else {
-		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
+		strbuf_addf(buf,
+				humanise_rate == 0 ?
+					/* TRANSLATORS: IEC 80000-13:2008 byte */
+					Q_("%u byte", "%u bytes", (unsigned)bytes) :
+					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
+					Q_("%u byte/s", "%u bytes/s", (unsigned)bytes),
+				(unsigned)bytes);
 	}
 }
 
+void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
+{
+	strbuf_humanise(buf, bytes, 0);
+}
+
+void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
+{
+	strbuf_humanise(buf, bytes, 1);
+}
+
 void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
 {
 	if (!*path)
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

