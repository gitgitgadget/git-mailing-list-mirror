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
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7D81F461
	for <e@80x24.org>; Sat, 22 Jun 2019 09:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfFVJhl (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 05:37:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44551 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFVJhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 05:37:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so6688322lfm.11
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swVB5F19DlXcQzixwL+mDlcs/0c7mFSIAHfKJU/G03c=;
        b=nqbdfjWyCGoejqmpaENRKw3f1oE2F43tqMXuUv9dIZ5BwRWGe4AZv7/OB/HKfoXdzg
         CDgk8yGA98IByOgjY2+js+LaDaWDa9xfUvaUkDvyjf6pfHZu4dWsAXVbOB0tahTSUv8H
         2i9eeBXRo6O4M6MF56l9/1H/IwHTpPw6vOyR+R4v77cZUlmKBUSwjupX/kxnXG04mDCD
         auplNzk2s2kTRHgGAKLtJS41kuDWAHzQlx5FjK5LjqdMZxGJs6cLIBD7NUOyfYv30Dvk
         G+AYkOxzPpmLl2KuJnUOYpxXB0UIXuOMYx44mafAx40x7ESF33J5RKsRkPa7oxIXZFXa
         NuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swVB5F19DlXcQzixwL+mDlcs/0c7mFSIAHfKJU/G03c=;
        b=jr0wwW07kteZGObnEQ9tUS7pge496clIahXE08CMPKmTkTfZArXAPB/Jm86QZcCs5y
         wE/es1fR21cnp/usKRfLX9Re9QT5wKkuFRc+bvujVQG+YuYwlWNwdi6vTHzQnrCwSEcY
         g+7b5+6ywjUU8OUuvR8Ibnmgf2YOpbKsvmonRWSMj9JNnPw44/WGehmJIxQRFcPaJoWA
         oCdSdjciKo7aaMqUfRnsQ1G+Asafr57kaqpLXdUqiIeW9e2jrPwGoDRuKNCsVWhKiRKx
         Sa8SYDeSjgVoxSJHA5w/dC3L84pLIHIHHYSIhtQOupmJx3x67ALFVjxK1z3i1S9Y3aT7
         DOhA==
X-Gm-Message-State: APjAAAWZq7vDdPdJo12H/UmzW7TY/hn2MIPr/CIO88F6hAishj2zRkCc
        QzSY15IpqbYRMIbXqKCWagkGQnKBDkj0Eg==
X-Google-Smtp-Source: APXvYqxYUHmcUo30+Ey1IGXI+AV6vyHUHWgvSRHukr36XKtV7qNUG2b/iQEse3kYG+/fw/co4hKh9g==
X-Received: by 2002:a19:ab1a:: with SMTP id u26mr33059381lfe.6.1561196258327;
        Sat, 22 Jun 2019 02:37:38 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id u13sm721718lfi.4.2019.06.22.02.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 02:37:37 -0700 (PDT)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH v3] l10n: localizable upload progress messages
Date:   Sat, 22 Jun 2019 12:36:55 +0300
Message-Id: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
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
index a2e8cf64a8..61d8cf5d04 100644
--- a/progress.c
+++ b/progress.c
@@ -151,7 +151,9 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
 	strbuf_humanise_bytes(buf, total);
 	strbuf_addstr(buf, " | ");
 	strbuf_humanise_bytes(buf, rate * 1024);
-	strbuf_addstr(buf, "/s");
+	strbuf_addstr(buf, "/");
+	/* TRANSLATORS: IEC 80000-13:2008, subclause 13-12.b: second */
+	strbuf_addstr(buf, _("s"));
 }
 
 void display_throughput(struct progress *progress, uint64_t total)
diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..0a3ebc3749 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -814,20 +814,28 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf, "%u.%2.2u GiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: gibi */
+		strbuf_addstr(buf, _("Gi"));
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u MiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: mebi */
+		strbuf_addstr(buf, _("Mi"));
 	} else if (bytes > 1 << 10) {
 		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u KiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: kibi */
+		strbuf_addstr(buf, _("Ki"));
 	} else {
-		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
+		strbuf_addf(buf, "%u ", (unsigned)bytes);
 	}
+	/* TRANSLATORS: ISO/IEC 80000-13:2008, subclause 13-9.c: byte */
+	strbuf_addstr(buf, _("B"));
 }
 
 void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
-- 
2.22.0

