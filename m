Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29661FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 22:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935147AbdDSWmG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 18:42:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35249 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765212AbdDSWmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 18:42:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so5116239wrc.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JrO17ELm8uJPkmTSJffVyNLvZBdWyYnWjB+klcnZwY=;
        b=UF2kNr5NGsp9HqHFuN+jpZqsu5wEeeG/SzoiFN9WQrRHxTx0ZpFWCw5U3F3Z4CohaO
         Ih1o7GJFkt59ZHdhPYaGtpBj/BYYFHgi5lE9lw4PZXmDLi4Vw1MBvlaOu0Ler+Nqc9LN
         u/xSt1BjE06Z7qEYBd9f7NxVDz1ZNndaYI5gs+UtFMBXdVEnIlSgoxyw6sKJoykHqPfC
         3S6G2XCpcye5HH7qeoQfJ0Vl2xMksuwCuyfYdkxNoRiFYhZkbKTcVDU15QXAcpCdkuSA
         gfnoRCd9PQP5v2O7b9SHpCXZHtbRqHxmTLZgmQYkS4de7GCC6c7zcSCV8qLzb+ILXMAh
         NPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JrO17ELm8uJPkmTSJffVyNLvZBdWyYnWjB+klcnZwY=;
        b=ZunbnN06Tsr0ULRWIQCFA/+T51wD4mwyJuHXZh8V1n15MV9yi6w8pu9UcAuPK9ADz3
         6P5wKrzVFhiOqrbRhzTpuU1AFWd/IlkMD7a0MRp2hF1pKuQ1+wurH+yReP3LZCpFqQn6
         vjFlPmiUaS15q749sEBS7C6c6FVS3CnQlPrhGiSxQeoS/gEnEOrxnC4jAK99Av5PdcpB
         UvWbxBVTxtv3QRT7OJ8/89yaTKsRsui5IwB0iNQPX5/A/GUcJgzP6im/gvuJ5nnikKRY
         f0vPDJZwkpwr+IfuQR4mtNy2anLlhB7boGC97nWpWE0auw/M/b8AH2iRKNzyMDEt8bpx
         CNYw==
X-Gm-Message-State: AN3rC/49FGsQkTQa53l9QDDo0sSMM9Ql3lvTrVYl/RrekgB72jdUKuAg
        a7B6ObwhlYcAiA==
X-Received: by 10.223.175.218 with SMTP id y26mr4579729wrd.63.1492641715762;
        Wed, 19 Apr 2017 15:41:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q130sm21128996wmd.29.2017.04.19.15.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 15:41:54 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/13] grep: add support for the PCRE v1 JIT API
Date:   Wed, 19 Apr 2017 22:40:52 +0000
Message-Id: <20170419224053.8920-13-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170419224053.8920-1-avarab@gmail.com>
References: <20170419224053.8920-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the grep PCRE v1 code to use JIT when available. When PCRE
support was initially added in commit 63e7e9d8b6 ("git-grep: Learn
PCRE", 2011-05-09) PCRE had no JIT support, it was integrated into
8.20 released on 2011-10-21.

When JIT support is enabled the PCRE performance usually improves by
more than 50%. The pattern compilation times are relatively slower,
but those relative numbers are tiny, and are easily made back in all
but the most trivial cases of grep. Detailed benchhmarks are available
at: http://sljit.sourceforge.net/pcre.html

With this change the difference in a t/perf/p7820-grep-engines.sh run
is, shown with git --word-diff:

    7820.1: extended with how.to                               [-0.28(1.23+0.44)-]{+0.28(1.18+0.39)+}
    7820.2: extended with ^how to                              [-0.26(1.15+0.38)-]{+0.27(1.13+0.40)+}
    7820.3: extended with \w+our\w*                            [-6.06(38.44+0.35)-]{+6.11(38.66+0.32)+}
    7820.4: extended with -?-?-?-?-?-?-?-?-?-?-?-----------$   [-0.37(1.57+0.38)-]{+0.37(1.56+0.42)+}
    7820.5: pcre1 with how.to                                  [-0.26(1.15+0.37)-]{+0.19(0.39+0.55)+}
    7820.6: pcre1 with ^how to                                 [-0.46(2.66+0.31)-]{+0.22(0.67+0.44)+}
    7820.7: pcre1 with \w+our\w*                               [-16.42(99.42+0.48)-]{+0.51(3.05+0.24)+}
    7820.8: pcre1 with -?-?-?-?-?-?-?-?-?-?-?-----------$      [-81.52(275.37+0.41)-]{+5.16(19.31+0.33)+}

The conditional support for JIT is implemented as suggested in the
pcrejit(3) man page. E.g. defining PCRE_STUDY_JIT_COMPILE to 0 if it's
not present.

There's no graceful fallback if pcre_jit_stack_alloc() fails under
PCRE_CONFIG_JIT, instead the program will abort. I don't think this is
worth handling, it'll only fail in cases where malloc() doesn't work,
in which case we're screwed anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 27 ++++++++++++++++++++++++++-
 grep.h |  5 +++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index d2c87ee2c3..eb68bdaa2a 100644
--- a/grep.c
+++ b/grep.c
@@ -331,6 +331,9 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	const char *error;
 	int erroffset;
 	int options = PCRE_MULTILINE;
+#ifdef PCRE_CONFIG_JIT
+	int canjit;
+#endif
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern))
@@ -345,9 +348,19 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
-	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, 0, &error);
+	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, PCRE_STUDY_JIT_COMPILE, &error);
 	if (!p->pcre1_extra_info && error)
 		die("%s", error);
+
+#ifdef PCRE_CONFIG_JIT
+	pcre_config(PCRE_CONFIG_JIT, &canjit);
+	if (canjit == 1) {
+		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
+		if (!p->pcre1_jit_stack)
+			die("BUG: Couldn't allocate PCRE JIT stack");
+		pcre_assign_jit_stack(p->pcre1_extra_info, NULL, p->pcre1_jit_stack);
+	}
+#endif
 }
 
 static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
@@ -358,8 +371,15 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
+#ifdef PCRE_CONFIG_JIT
+	ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
+			    0, flags, ovector, ARRAY_SIZE(ovector),
+			    p->pcre1_jit_stack);
+#else
 	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
 			0, flags, ovector, ARRAY_SIZE(ovector));
+#endif
+
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
 	if (ret > 0) {
@@ -374,7 +394,12 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
+#ifdef PCRE_CONFIG_JIT
+	pcre_free_study(p->pcre1_extra_info);
+	pcre_jit_stack_free(p->pcre1_jit_stack);
+#else
 	pcre_free(p->pcre1_extra_info);
+#endif
 	pcre_free((void *)p->pcre1_tables);
 }
 #else /* !USE_LIBPCRE1 */
diff --git a/grep.h b/grep.h
index fa2ab9485f..29e20bf837 100644
--- a/grep.h
+++ b/grep.h
@@ -3,9 +3,13 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
+#ifndef PCRE_STUDY_JIT_COMPILE
+#define PCRE_STUDY_JIT_COMPILE 0
+#endif
 #else
 typedef int pcre;
 typedef int pcre_extra;
+typedef int pcre_jit_stack;
 #endif
 #include "kwset.h"
 #include "thread-utils.h"
@@ -48,6 +52,7 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre1_regexp;
 	pcre_extra *pcre1_extra_info;
+	pcre_jit_stack *pcre1_jit_stack;
 	const unsigned char *pcre1_tables;
 	kwset_t kws;
 	unsigned fixed:1;
-- 
2.11.0

