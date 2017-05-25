Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6C020284
	for <e@80x24.org>; Thu, 25 May 2017 19:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036759AbdEYTsA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:48:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34298 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036734AbdEYTrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so55400904wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJvr9dz1HhTYQSrc3WrztsuuPwBPhV7KkZH3nQDHX/U=;
        b=Otu3FsU8ilSqVjLTjuumdhjUZVyK7drY6wj7Urqrs5GToysgPIakNkuTJSh9tpxvPy
         roGuh9RqawqcN1g4rK9w3NeuWEyehuA9BIx4DvNEpZOOTyYBogDLx8LNPRlnfglm1UbH
         y9S7hBRt5kO7b1h6spNu5VDvVRxgYLqxAl1d77r5sHh8ntfeWM1aonSkGhEXvPmv4Qn3
         Fz47hBc/aaEyY0+uGUiLpkQ8dKd5pfXNCigu6YkjpH71oTWxYFb9A8uB9wacBrHmKDHc
         q1DNixmLned/NlMFQBSgXYrF65e/zrToGs/wMrOFGzyNfnKOffW2T4p+Gs7FIL+XHmN+
         q7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJvr9dz1HhTYQSrc3WrztsuuPwBPhV7KkZH3nQDHX/U=;
        b=iw7hBztxM3QiTDZd85tcsXX34oTfmar1qQ3MZELudVfvV9iHyQOvDDbyIGE2ReKMiT
         STrzC+IMuvEEl7Mk3Iy+nPqTMUyOqgN0wI2NAXkO//Y41t4Nm6do/4NzgTIRg5FMYsE4
         wU30eotJYfOqzCpqnrrM/W47ssMelNYaFRlc/ux1R/6sI5wLwqNIiSchFIzM3BnYhm6Z
         3Fbz3ZO+AE9wUjSV0GMbwB08C1nxBT0H9C7t3hwU58MORisYPiEa/OoMnKur5QOEDjjj
         c5dfwbLkloKeuP8oiyR1J7XuFAme/wzVZ1yT0aFzht7zi1pzyU/5eTjJmyHu6FfIhhET
         y0Dw==
X-Gm-Message-State: AODbwcC/A3cfh7D2M6beV88roCo0BY0kuLgj3guRozfEXDcphkNWbyqr
        EyP7VrafJRXmwg==
X-Received: by 10.223.131.34 with SMTP id 31mr29469946wrd.95.1495741643230;
        Thu, 25 May 2017 12:47:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 26/31] grep: move is_fixed() earlier to avoid forward declaration
Date:   Thu, 25 May 2017 19:45:30 +0000
Message-Id: <20170525194535.9324-27-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_fixed() function which are currently only used in
compile_regexp() earlier so it can be used in the PCRE family of
functions in a later change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/grep.c b/grep.c
index 2d54baeaa3..d03d424e5c 100644
--- a/grep.c
+++ b/grep.c
@@ -321,6 +321,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
+static int is_fixed(const char *s, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (is_regex_special(s[i]))
+			return 0;
+	}
+
+	return 1;
+}
+
 static int has_null(const char *s, size_t len)
 {
 	/*
@@ -402,18 +414,6 @@ static void free_pcre1_regexp(struct grep_pat *p)
 }
 #endif /* !USE_LIBPCRE1 */
 
-static int is_fixed(const char *s, size_t len)
-{
-	size_t i;
-
-	for (i = 0; i < len; i++) {
-		if (is_regex_special(s[i]))
-			return 0;
-	}
-
-	return 1;
-}
-
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.13.0.303.g4ebf302169

