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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF1F1F461
	for <e@80x24.org>; Sun, 23 Jun 2019 09:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfFWJ1m (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 05:27:42 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:40349 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfFWJ1m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 05:27:42 -0400
Received: by mail-lj1-f174.google.com with SMTP id a21so9750695ljh.7
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDJXoP43oai/5WkUrT5YZk4hI2I8oIlp4TjTdJyxqjc=;
        b=EyiojpXJ2KU0xfLEA8ytGVJN9dbs1zdARYSa2QHnQ/9wCih21ztdUkbQeyP7+o4v/R
         YgCuxkV0l5/ovKHJ6rtDNi+UWG37D1Ly1YrI7tNKgK7TiS15j+Qzoko6RHaWkHnFs6+a
         DE44uB98NmZLvW9NUofZkiZ4T4fN0KpG4YRY/OabotIEvT4cfkW+k+pum3RdXglgL3ha
         wbdY8cSGPV69LhQz+5T4AYgKvZzdbKal/BatvOnMUA5sUsIgGsBWT3B9aGVd+eaVHOQR
         K6dFI5YuWxesqn2e4HNSmhnQjrK4qjvczhJRoPncdriaxzr8KgImeMUC28HIWmxrQnwH
         +qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDJXoP43oai/5WkUrT5YZk4hI2I8oIlp4TjTdJyxqjc=;
        b=BrMlkGp/0VXGSVbFrMyXWqvroynR9Qugle1EJ7jLE6gn4auHx+6JNt6eqt/qIUBm7G
         GqJHXTH5R5Lf9CetWLc0vt56u9muVvI79ns4goieaqqanzluBcUswGzQoNEotd/Y7u8K
         yFRXBVHkJY+oDmR7JcRC8ByV4/iWx/c8s7Ci5yi3swXKvjrUA0lysHuuXhQLEXGY/m48
         8GMkH/COUGyCur106snSUGdGHk6XA7lK/lZub6ehL2YeIAatCx3VtXQqFiCgDiHHfH8c
         iyH14yA8NBcDc/2/zDI2hsI08sQP6t6FWNcee0W5Buo9NdDeejvL/MEJo9exFNr0+C4V
         uYDQ==
X-Gm-Message-State: APjAAAWKDw63jO5+D0odK6K3o+8JBmuB0XrUYtBQfVmdft+tk8rLN7m9
        5I7uJu4KPTCW2gELGJV/jcGfNqI9lFRWhQ==
X-Google-Smtp-Source: APXvYqwHe4i/Dk7W+500PVKvKXeLDhE2DTGUvWhhnWmrqtbS9KE3dmhLGaTVovAlPRD6rZt9yVtusA==
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr45511769ljm.69.1561282059493;
        Sun, 23 Jun 2019 02:27:39 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id l25sm1194257lja.76.2019.06.23.02.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Jun 2019 02:27:38 -0700 (PDT)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH v4] l10n: localizable upload progress messages
Date:   Sun, 23 Jun 2019 12:27:17 +0300
Message-Id: <20190623092717.82424-2-dimitriy.ryazantcev@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 progress.c |  4 +++-
 strbuf.c   | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/progress.c b/progress.c
index a2e8cf64a8..fc62941fa4 100644
--- a/progress.c
+++ b/progress.c
@@ -151,7 +151,9 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
 	strbuf_humanise_bytes(buf, total);
 	strbuf_addstr(buf, " | ");
 	strbuf_humanise_bytes(buf, rate * 1024);
-	strbuf_addstr(buf, "/s");
+	strbuf_addstr(buf, "/");
+	/* TRANSLATORS: unit symbol for IEC 80000-13:2008 second */
+	strbuf_addstr(buf, _("s"));
 }
 
 void display_throughput(struct progress *progress, uint64_t total)
diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..706b3b8e42 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -814,19 +814,27 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf, "%u.%2.2u GiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+		/* TRANSLATORS: unit symbol for IEC 80000-13:2008 gibibyte */
+		strbuf_addstr(buf, _("GiB"));
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u MiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+		/* TRANSLATORS: unit symbol for IEC 80000-13:2008 mebibyte */
+		strbuf_addstr(buf, _("MiB"));
 	} else if (bytes > 1 << 10) {
 		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u KiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+		/* TRANSLATORS: unit symbol for IEC 80000-13:2008 kibibyte */
+		strbuf_addstr(buf, _("KiB"));
 	} else {
-		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
+		strbuf_addf(buf, "%u ", (unsigned)bytes);
+		/* TRANSLATORS: unit symbol for IEC 80000-13:2008 byte */
+		strbuf_addstr(buf, _("B"));
 	}
 }
 
-- 
2.22.0

