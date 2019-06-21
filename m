Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA8A1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 18:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFUSvp (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 14:51:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34283 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 14:51:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so6884803ljg.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pANZyP6tnKeqfoJ8PxaaGo1GfMuzIxHoobK9QtK6OKg=;
        b=g4bFvj6alKa9h2RPQajsKDhv+qlOW3Jh39ocPt7dN8qsbGNk7owwhkgJoSYHLhat8N
         tj3ys8vQcpFEctbaeaIPI11jBY62F8FxMBHLS0KkSitW9TDSm96BMKv/epWRTuDfr88A
         DcbRvRP7c1G/W9vhj7soI+WDFnJu5Lvt+eLBTX9SeRVX2WCnZ98F0SIW5lbS6I6eyoA8
         rutcjh0rePwjFU1JnhtsBQVH1ZIiZwyn0D1t/xumL8C733fKto92RYeTTrjkSkb2fNfC
         RNJCL9FPHfEmjnHFd74j0zI7SqMHUvyeKQ5ACzl/urZvDoPjLHQBhzq7HFEEn4+yoFpn
         m5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pANZyP6tnKeqfoJ8PxaaGo1GfMuzIxHoobK9QtK6OKg=;
        b=BLJLP4vB6GIqs86bggSaiDATs6XCNPx5ugNWDCdPQfy7cdV1HK8Khwa9QF44dOTaeO
         YyMUhNbctoZ9ZinAYXMIAznqNHhL4de8f65onenobmBQCwCMWNqVF2yz8hxWCK4OWNRU
         24AHv8fNbczKbWrdIW7Cr7LcHObJtV4J8mkR1olMvSm2mXIRwfIxIV0pHygsmKcKaHFl
         EteKkyfyQKkXGpD6GmksgBXqx9w91U37VBgdhPSmi20/yTE7M0+gLs+CVqbtSqCsZn93
         yMtrgRr8ijnB7myXp0Rw1R4wfyyGYRnE1OAfidfK1PcnnUv1uLuHgT7ucU8AZf62zcEc
         9QmQ==
X-Gm-Message-State: APjAAAXNYeWLdi6DQFOIezZHllr6LzFOoyHxZ01LWjK/L3QMK3XCOvDl
        2QZyjA7rGJieUj6G4qGD4TvBR/ydhJWmOg==
X-Google-Smtp-Source: APXvYqxf4dlFSBVcBNezZCZoA8e554dreO3Ne2gPm4OaQzxFGgvP9/JCjXPwZRymqvy05pzB7O3sxg==
X-Received: by 2002:a2e:9950:: with SMTP id r16mr40406454ljj.173.1561143102574;
        Fri, 21 Jun 2019 11:51:42 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id h4sm508661ljj.31.2019.06.21.11.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 11:51:41 -0700 (PDT)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] l10n: localizable upload progress messages
Date:   Fri, 21 Jun 2019 21:50:51 +0300
Message-Id: <20190621185051.77354-1-dimitriy.ryazantcev@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 progress.c | 3 ++-
 strbuf.c   | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/progress.c b/progress.c
index a2e8cf64a8..3d47c06495 100644
--- a/progress.c
+++ b/progress.c
@@ -151,7 +151,8 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
 	strbuf_humanise_bytes(buf, total);
 	strbuf_addstr(buf, " | ");
 	strbuf_humanise_bytes(buf, rate * 1024);
-	strbuf_addstr(buf, "/s");
+	/* TRANSLATORS: per second */
+	strbuf_addstr(buf, _("/s"));
 }
 
 void display_throughput(struct progress *progress, uint64_t total)
diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..c309df1f5e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -814,19 +814,19 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf, "%u.%2.2u GiB",
+		strbuf_addf(buf, _("%u.%2.2u GiB"),
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u MiB",
+		strbuf_addf(buf, _("%u.%2.2u MiB"),
 			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
 	} else if (bytes > 1 << 10) {
 		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf, "%u.%2.2u KiB",
+		strbuf_addf(buf, _("%u.%2.2u KiB"),
 			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else {
-		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
+		strbuf_addf(buf, _("%u bytes"), (unsigned)bytes);
 	}
 }
 
-- 
2.22.0

