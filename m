Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F7820188
	for <e@80x24.org>; Sat, 13 May 2017 23:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757561AbdEMXqW (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:46:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36538 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757248AbdEMXqV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:46:21 -0400
Received: by mail-qt0-f196.google.com with SMTP id j13so11250327qta.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LW/ynlGBx6ttRRzaUDZOfpOuBOU5ROYPuDC8KN9PsdM=;
        b=D1zuWPeqkUCnYk/WXaU0nGJcWtGKGUqtOoPB+Hn8QisJ6p+kobyw8xBJ5YN1gzuMl6
         TpFJMPR5PF6DK3NyJwc6RqC5yY+vL73v7qsqZeFbZzMQSc/Lcr/aHavJa0Rcng/svlgP
         tlZYmRaQK4cpUpQRbbbpz2MhA1Hbx/N6o26oYBoRYM0bCr+IUrSBoTCbxnJbraVXAIx8
         GWQfGC8BBOITjczFXVi/kxqU5T6GbIjb859xG+zYkq7M/Y4xvXU1BJfgy/pCW/gAkbJ8
         SXBUJLwGTAWzp6LgjbUYDIt9K42HGn1QCYpyPu6D/Jr3K1xJfjhyF594VNSN5gOeA9zp
         Giqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LW/ynlGBx6ttRRzaUDZOfpOuBOU5ROYPuDC8KN9PsdM=;
        b=KmXJIhV1XAgwxzvbiUk7Gu9MrfWyhBdCMAJ1dt2bUOKKgqSsAVbreKUFwnVHQNDmTg
         BROOsQ0xwBBFIKUDiuYbXNLVgKfWfMicsmzKQIvNcGceBLd5jY/7pehyAQdTvDhqqnt9
         SbYRR+KCRrAvUBpJfYE4ikomJDzPmPjtVDXBC4omfZJt1fhy596r0vZIxAf63jC91YDR
         HHEUNgBemBWUhcHoygrnSo4IMS5Eqwkv86AwbaytNer17RvWrLjvu+WMt7Xr2F45w4fF
         C/yYjPHPJXU0augeFArEvBiTa7v/hMRMUYzsVjB/d3vXHCUUtVoaQDZZdH3oLTFUBehE
         HcGg==
X-Gm-Message-State: AODbwcD+qigqoT+3QvviS8JNJG8DQK4GLWoQA9IvG0P57K7T+BBZnNDV
        JCvwq5KSY8l9iA==
X-Received: by 10.200.47.36 with SMTP id j33mr9969177qta.175.1494719175100;
        Sat, 13 May 2017 16:46:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h14sm5319234qta.18.2017.05.13.16.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:46:14 -0700 (PDT)
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
Subject: [PATCH v2 5/7] grep: un-break building with PCRE < 8.32
Date:   Sat, 13 May 2017 23:45:33 +0000
Message-Id: <20170513234535.12749-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513234535.12749-1-avarab@gmail.com>
References: <20170513234535.12749-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend my change earlier in this series ("grep: add support for the
PCRE v1 JIT API", 2017-04-11) to un-break the build on PCRE v1
versions earlier than 8.32.

The JIT support was added in version 8.20 released on 2011-10-21, but
it wasn't until 8.32 released on 2012-11-30 that the fast code path to
use the JIT via pcre_jit_exec() was added[1] (see also [2]).

This means that versions 8.20 through 8.31 could still use the JIT,
but supporting it on those versions would add to the already verbose
macro soup around JIT support it, and I don't expect that the use-case
of compiling a brand new git against a 5 year old PCRE is particularly
common, and if someone does that they can just get the existing
pre-JIT slow codepath.

So just take the easy way out and disable the JIT on any version older
than 8.32.

The reason this change isn't part of the initial change PCRE JIT
support is because possibly slightly annoying someone who's bisecting
with an ancient PCRE is worth it to have a cleaner history showing
which parts of the implementation are only used for ancient PCRE
versions. This also makes it easier to revert this change if we ever
decide to stop supporting those old versions.

1. http://www.pcre.org/original/changelog.txt ("28. Introducing a
   native interface for JIT. Through this interface, the
   compiled[...]")
2. https://bugs.exim.org/show_bug.cgi?id=2121

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 8 ++++----
 grep.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index accf1c45e6..81337638ca 100644
--- a/grep.c
+++ b/grep.c
@@ -351,7 +351,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	const char *error;
 	int erroffset;
 	int options = PCRE_MULTILINE;
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	int canjit;
 #endif
 
@@ -372,7 +372,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_extra_info && error)
 		die("%s", error);
 
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	pcre_config(PCRE_CONFIG_JIT, &canjit);
 	if (canjit == 1) {
 		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
@@ -392,7 +392,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	if (p->pcre1_jit_on)
 		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
 				    eol - line, 0, flags, ovector,
@@ -420,7 +420,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	if (p->pcre1_jit_on) {
 		pcre_free_study(p->pcre1_extra_info);
 		pcre_jit_stack_free(p->pcre1_jit_stack);
diff --git a/grep.h b/grep.h
index 14f47189f9..73ef0ef8ec 100644
--- a/grep.h
+++ b/grep.h
@@ -3,6 +3,11 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
+#ifdef PCRE_CONFIG_JIT
+#if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
+#define GIT_PCRE1_CAN_DO_MODERN_JIT
+#endif
+#endif
 #ifndef PCRE_STUDY_JIT_COMPILE
 #define PCRE_STUDY_JIT_COMPILE 0
 #endif
-- 
2.11.0

