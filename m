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
	by dcvr.yhbt.net (Postfix) with ESMTP id 078701F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfGZPJG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44932 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbfGZPJE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:09:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so54778741wrf.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7b/H9pWjz7ysPsDqIE/RUWlARK66YOiOP7x8FPQTDw=;
        b=om3tFF5iSu+QXOxWzS8EaF6GvFjO0tFx6/573LRyqYGLFXfDzuU4hcXmUKzUM1RlRJ
         7u6jJrndnePbkeNzzyZyXqeikkI0PNEz6A9Z0HEebx4mfZ6/qNEBkIAtTBkIahbE1+MW
         qcHnB3uJyz5fnySdahKTRtMwCKEygIpZgur6pNIzj81UzOilAA7c/t+TR9t6/O0Aa3ro
         wqoaml0vjXD5QNtE/uoIv18k9ZHZXyiibTL6gNLbDVVRHmC+1Ml8xswJnMJEOOhuHh1+
         0fzP8klUHS+6X390nidKo3KN5rDlU6CDMW1JXBCpS5rF+TkPSQFRBl47Ab5VC/wAroyQ
         UbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7b/H9pWjz7ysPsDqIE/RUWlARK66YOiOP7x8FPQTDw=;
        b=tY6jzG/Y3vluxUCvzePX7VfwnysyrtaZn24yB/heQmY73sO+0TowOfBvaizMYckaC1
         8lqChCFCdqMHfg8oj/C+zU3emBBlcy5cErm8qjqWxIMVVLSf1skdoT+jrG32+zW+3X6a
         LTBJuC8CXc5MuRRhGnGazgDNgYAue28lUAhtXZngnbd78BYMlqbGDgTc0HLW+osmwklh
         VsPN2HSqqxjb6ml6nJAwN+KSTLc9lXx1FYZrg/Nt9Jwq7S1r7v/8EieQFIKqAHMpW0D8
         JjaR/POK2HP3v6E4jGMy4DmV4WkO7/fDiBc5mtIT5Il/FDYYGomRBBXVnZtTxfnR08l7
         QXzg==
X-Gm-Message-State: APjAAAVxT77iU6uJHYMe64xH7F29vn2cGFtuW9EoZWddFX3T+SNtQy6Y
        Tio9QKAwh8tBe5vBbv2LiA3Bi/UW+1M=
X-Google-Smtp-Source: APXvYqwIPwKvni9GDGXuUCvzn3IQ+llnRmiEmqyPwEWEWjy4AklodaxyLw43wHmFAQ04j58aem728w==
X-Received: by 2002:adf:e483:: with SMTP id i3mr61545662wrm.210.1564153743071;
        Fri, 26 Jul 2019 08:09:03 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.09.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:09:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] grep: create a "is_fixed" member in "grep_pat"
Date:   Fri, 26 Jul 2019 17:08:15 +0200
Message-Id: <20190726150818.6373-6-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190724151415.3698-1-avarab@gmail.com>
References: <20190724151415.3698-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change paves the way for later using this value the regex compile
functions themselves.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 7 +++----
 grep.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index b94e998680..6d60e2e557 100644
--- a/grep.c
+++ b/grep.c
@@ -606,7 +606,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
 	int regflags = REG_NEWLINE;
-	int pat_is_fixed;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
@@ -615,11 +614,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
-	pat_is_fixed = is_fixed(p->pattern, p->patternlen);
-	if (p->fixed || pat_is_fixed) {
+	p->is_fixed = is_fixed(p->pattern, p->patternlen);
+	if (p->fixed || p->is_fixed) {
 #ifdef USE_LIBPCRE2
 		opt->pcre2 = 1;
-		if (pat_is_fixed) {
+		if (p->is_fixed) {
 			compile_pcre2_pattern(p, opt);
 		} else {
 			/*
diff --git a/grep.h b/grep.h
index ce2d72571f..c0c71eb4a9 100644
--- a/grep.h
+++ b/grep.h
@@ -88,6 +88,7 @@ struct grep_pat {
 	pcre2_compile_context *pcre2_compile_context;
 	uint32_t pcre2_jit_on;
 	unsigned fixed:1;
+	unsigned is_fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
 };
-- 
2.22.0.455.g172b71a6c5

