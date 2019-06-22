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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE441F461
	for <e@80x24.org>; Sat, 22 Jun 2019 09:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFVJ2S (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 05:28:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33250 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFVJ2S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 05:28:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so8134461ljg.0
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRAUyFc2+0JamQXcLQbRw1aBP7YZTT5rU3frot/PGwM=;
        b=J+XpEbAb5+OQ9IvQf/p6kWg2yDT7Ys1B2Rr3r/22y9zp81wEyZqZ07vWKwMT8PDYRO
         6Sir9x5caqB1Q+SkV44KAyJ/ZaiVsJ0bdSqnQOf1pJiGQLRNLChqsvS4pFAPC/vuvGYK
         ePV3kzRjHDKmI8u8IRQ34/L5RfccWNtfewvmDs476fBGaxtkJBoqjJE8IP7VJZ/V1kz9
         /V222eAaYjd18aOnF8ij+WL+b212cRlb9MamIO+i8gHEp4nMZCpXtM2Ylag8xMtsWhsH
         d6xBWXnKZWn/6jOogOsS9g2bYJsMgYCgMX67p/5WCXp3tAn4ovof0nJHUVsRcj95tVaw
         OgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRAUyFc2+0JamQXcLQbRw1aBP7YZTT5rU3frot/PGwM=;
        b=G8SDPOHzn1rQb8ligPrwTlKTlK/MCS70xoaCpNAr5Gcg/PvkgfT2Q69nyfOLMrUGJh
         Cyh6C/obrjoQE41TWStkJnrXGf5+AhGdEZZuMK5uDbjihrr0MJVN6/Uukm3O78IhMA43
         s4OabBtwMRAPZkOwx4BDtt+9JZx8vy++cPk4IA1itUfGzlF/vUV5NtyD8eh8kFmhtuXm
         5Q7ZwP7VFvvTmt1imEstYlVJnnzSsM0dZJSIQeRfV0ZD4df4NarAPlRwu3ExSujP2js1
         4eaHXvmunnP05XoCVsdX3lEcj4CCXaZMkkS1TAwGWt2e1DCVuRANbzh5TlsWY4cEGRHm
         Anag==
X-Gm-Message-State: APjAAAUEJTKdWmKQ7Xz/m0CcTSJaxG4mjuXofEcjYQEu8L+WmUi5MOP+
        s0N5L41+vxy7GgvnBkJd8mw+z2ihb3kxTQ==
X-Google-Smtp-Source: APXvYqyuBIhiE/piDiFWI7vBTLjsPThdbMrsOtvj8RDYkt+QBetZI3PQ9sB1hpzsI5VelTZmVU9UNg==
X-Received: by 2002:a2e:5b5b:: with SMTP id p88mr64961675ljb.192.1561195695663;
        Sat, 22 Jun 2019 02:28:15 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id d2sm710726lfh.1.2019.06.22.02.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 02:28:15 -0700 (PDT)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH v2] l10n: localizable upload progress messages
Date:   Sat, 22 Jun 2019 12:26:10 +0300
Message-Id: <20190622092610.79911-2-dimitriy.ryazantcev@gmail.com>
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
index 0e18b259ce..62144e755c 100644
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
+		strbuf_addf(buf, _("Gi"));
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u MiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: mebi */
+		strbuf_addf(buf, _("Mi"));
 	} else if (bytes > 1 << 10) {
 		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u KiB",
+		strbuf_addf(buf, "%u.%2.2u ",
 			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: kibi */
+		strbuf_addf(buf, _("Ki"));
 	} else {
-		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
+		strbuf_addf(buf, "%u ", (unsigned)bytes);
 	}
+	/* TRANSLATORS: ISO/IEC 80000-13:2008, subclause 13-9.c: byte */
+	strbuf_addf(buf, _("B"));
 }
 
 void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
-- 
2.22.0

