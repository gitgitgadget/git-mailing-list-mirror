Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D426201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756523AbdETVnz (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35530 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756513AbdETVnu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so5761208wrg.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9k3ucbHMPEBwDQm4JKKfeyroezbzDYoKpY6jLbmztis=;
        b=HJ60O9KoOP92YjrVO5UOIOn2eCz4x797rdHE6jsHpZROhdnb11KgY/yaB+8YFQGjj5
         gUv13c8RE72/xv7+kJrn240FS0CaZBHeyTeq5nYRhOGeYvGtQOp554HbdzuGT+YhDd4j
         Hk3XU8EpS0ODa0SHpPW8oSyAhju3nl8Bj/6o+BRANQ3Phhrn4kVaYMmvYdaDW2vmZGS1
         fSxP6hCGa2DKnfuhQHNxFx/v4kbpkVdz5Rft5J1SfoauKCKvqfYoojGBZ/3A5muGgZkd
         Hy5EAurIG+QLKUcbJZRApiRBueyky04FAeKlH12wmAlMvopuiiG76OCfrVcxACCX55re
         flwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9k3ucbHMPEBwDQm4JKKfeyroezbzDYoKpY6jLbmztis=;
        b=omNPdrD+R5qKC0Vn7v/exDkHaSrEaYQP/GSE8uHm6MM4pWyU9+6EBp9AYT8CcMe5ZQ
         7WsycVzsvc5WXfSiBGPKZipYC97VxtzqhyJCHcarpFNEdJCVnnLF4dShmXCpkOgLCBV+
         MGvrZUmN/guI7Fg+wCT96jaSiQQPGTbB22iW1FfM5MZ8LUfs46DZEfERz/FGbHXcnK7n
         nCqkF8lwMCh7jHfa+b7iw5+xFEoDX0iTvxnawXnqgC3O+MZy6sQO1E2SzdJMCjZJqUNa
         +JUssnBuBe1zFfIc1ZRLtXqcRc3jj7QN2EEniZOn9iTDgdTm/dHyp5dPFz5lEDdPcAQ/
         biNA==
X-Gm-Message-State: AODbwcAJ9Qls4gdThSVbns4yjoshVH4tU0+idQQkUro/AJc+O4LwxIlJ
        NrhI/aEeyIZRWA==
X-Received: by 10.223.183.16 with SMTP id l16mr7901031wre.42.1495316623947;
        Sat, 20 May 2017 14:43:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:43 -0700 (PDT)
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
Subject: [PATCH v3 22/30] grep: factor test for \0 in grep patterns into a function
Date:   Sat, 20 May 2017 21:42:25 +0000
Message-Id: <20170520214233.7183-23-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor the test for \0 in grep patterns into a function. Since commit
9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
\0 is considered fixed as regcomp() can't handle it.

This change makes later changes that make use of either has_null() or
is_fixed() (but not both) smaller.

While I'm at it make the comment conform to the style guide, i.e. add
an opening "/*\n".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index bf6c2494fd..79eb681c6e 100644
--- a/grep.c
+++ b/grep.c
@@ -321,6 +321,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
+static int has_null(const char *s, size_t len)
+{
+	/*
+	 * regcomp cannot accept patterns with NULs so when using it
+	 * we consider any pattern containing a NUL fixed.
+	 */
+	if (memchr(s, 0, len))
+		return 1;
+
+	return 0;
+}
+
 #ifdef USE_LIBPCRE
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -394,12 +406,6 @@ static int is_fixed(const char *s, size_t len)
 {
 	size_t i;
 
-	/* regcomp cannot accept patterns with NULs so we
-	 * consider any pattern containing a NUL fixed.
-	 */
-	if (memchr(s, 0, len))
-		return 1;
-
 	for (i = 0; i < len; i++) {
 		if (is_regex_special(s[i]))
 			return 0;
@@ -451,7 +457,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	 * simple string match using kws.  p->fixed tells us if we
 	 * want to use kws.
 	 */
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
 	else
 		p->fixed = 0;
-- 
2.13.0.303.g4ebf302169

