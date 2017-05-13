Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A08120188
	for <e@80x24.org>; Sat, 13 May 2017 23:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757239AbdEMXqS (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:46:18 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35095 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756894AbdEMXqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:46:15 -0400
Received: by mail-qk0-f181.google.com with SMTP id a72so71567986qkj.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akzYnyKgXWMtqI0FSf0pJE/nVzWqJTN007aApv+PIK4=;
        b=HG3ORp7rimCpcCG60ePxhwdeyjVOb7WCZUlbdtNvvoITmcsiFWDkN7YfseY9Oa1fJm
         sGjAiWaTauGRRLqKZI5hycPpPGLBsxVf26Xy3haCvITXFAhdDwULyyTKU+vsnEZ7fEsO
         2kzgmBeOj3DDRjTC4DC7EZwkCAx4MFrqt1tgFywxJYDNmiFeY7bln7h2VTcxZn/ZY9ag
         wnB+ypNfBbrSqRP9lkcvOW2tzkunlqSNwttTFHW37zCUtNeajUiY5L8qfaUM6h/v9XKY
         JHja5oQQVtZ6MAqnGCvtwCA6PbMhXlM+aFDyNg88291eU8J7AwkMB1tHsn0xIlQrjmfF
         CSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akzYnyKgXWMtqI0FSf0pJE/nVzWqJTN007aApv+PIK4=;
        b=fouk/zFebHkWz6tDYj9LFolcg8xaG7NQJ7xzJsRBxwMSyV9PjCdQ1S9bhvbuzsZXDJ
         YPzjDDstKTQS1pRrsSa4DGjhyhPV2B8XQU1RqFk23CMIpxfmWTh37TgiYh2yHn1J+fkt
         /80DAxbX2G2L7EaP651Hx3zykFTQx8uC/hWZCeFpSAMRQ/i3XwEEevIp+2ZhM/DO4Npk
         Aat/33OVf9bwEOm3+dSE9GRjZKj0Y7CMAzUVNVUo13HnmR0AbJOCvyd21O4BzaKuQoqf
         ybzEKuIPlBJTeY4B5LWi4n56OmeEcTpoyryKN13Kmpu+VTRNCD6ANOvP9a5yL3L+kt57
         bZ8w==
X-Gm-Message-State: AODbwcC47fODJDGKlcrZwzS5UEuZFezAxnnXTA6v7WHm9v1WUrJdgQp+
        GERuwqfgxFQ1Xw==
X-Received: by 10.55.89.4 with SMTP id n4mr9367037qkb.194.1494719169595;
        Sat, 13 May 2017 16:46:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h14sm5319234qta.18.2017.05.13.16.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:46:08 -0700 (PDT)
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
Subject: [PATCH v2 4/7] grep: add support for the PCRE v1 JIT API
Date:   Sat, 13 May 2017 23:45:32 +0000
Message-Id: <20170513234535.12749-5-avarab@gmail.com>
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

Change the grep PCRE v1 code to use JIT when available. When PCRE
support was initially added in commit 63e7e9d8b6 ("git-grep: Learn
PCRE", 2011-05-09) PCRE had no JIT support, it was integrated into
8.20 released on 2011-10-21.

Enabling JIT support usually improves performance by more than
40%. The pattern compilation times are relatively slower, but those
relative numbers are tiny, and are easily made back in all but the
most trivial cases of grep. Detailed benchmarks & overview of
compilation times is at: http://sljit.sourceforge.net/pcre.html

With this change the difference in a t/perf/p7820-grep-engines.sh run
is, with just the /perl/ tests shown:

    $ GIT_PERF_REPEAT_COUNT=30 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8 USE_LIBPCRE=YesPlease CC=~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=YesPlease CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre/inst LDFLAGS=-Wl,-rpath,/home/avar/g/pcre/inst/lib' ./run HEAD~ HEAD p7820-grep-engines.sh
    Test                                           HEAD~             HEAD
    ---------------------------------------------------------------------------------------
    7820.3: perl grep how.to                      0.27(1.18+0.42)   0.19(0.30+0.68) -29.6%
    7820.7: perl grep ^how to                     0.48(2.74+0.41)   0.21(0.64+0.55) -56.2%
    7820.11: perl grep [how] to                   0.47(2.56+0.47)   0.26(0.86+0.56) -44.7%
    7820.15: perl grep (e.t[^ ]*|v.ry) rare       0.88(5.79+0.38)   0.26(1.06+0.54) -70.5%
    7820.19: perl grep m(ú|u)lt.b(æ|y)te          0.32(1.56+0.46)   0.23(0.86+0.48) -28.1%

The conditional support for JIT is implemented as suggested in the
pcrejit(3) man page. E.g. defining PCRE_STUDY_JIT_COMPILE to 0 if it's
not present.

The implementation is relatively verbose because even if
PCRE_CONFIG_JIT is defined only a call to pcre_config() can determine
if the JIT is available, and if so the faster pcre_jit_exec() function
should be called instead of pcre_exec(), and a different (but not
complimentary!) function needs to be called to free pcre1_extra_info.

There's no graceful fallback if pcre_jit_stack_alloc() fails under
PCRE_CONFIG_JIT, instead the program will simply abort. I don't think
this is worth handling gracefully, it'll only fail in cases where
malloc() doesn't work, in which case we're screwed anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 37 ++++++++++++++++++++++++++++++++++++-
 grep.h |  6 ++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 1157529115..accf1c45e6 100644
--- a/grep.c
+++ b/grep.c
@@ -351,6 +351,9 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	const char *error;
 	int erroffset;
 	int options = PCRE_MULTILINE;
+#ifdef PCRE_CONFIG_JIT
+	int canjit;
+#endif
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern))
@@ -365,9 +368,20 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
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
+		p->pcre1_jit_on = 1;
+	}
+#endif
 }
 
 static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
@@ -378,8 +392,20 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
+#ifdef PCRE_CONFIG_JIT
+	if (p->pcre1_jit_on)
+		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
+				    eol - line, 0, flags, ovector,
+				    ARRAY_SIZE(ovector), p->pcre1_jit_stack);
+	else
+		ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
+				eol - line, 0, flags, ovector,
+				ARRAY_SIZE(ovector));
+#else
 	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
 			0, flags, ovector, ARRAY_SIZE(ovector));
+#endif
+
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
 	if (ret > 0) {
@@ -394,7 +420,16 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
+#ifdef PCRE_CONFIG_JIT
+	if (p->pcre1_jit_on) {
+		pcre_free_study(p->pcre1_extra_info);
+		pcre_jit_stack_free(p->pcre1_jit_stack);
+	} else {
+		pcre_free(p->pcre1_extra_info);
+	}
+#else
 	pcre_free(p->pcre1_extra_info);
+#endif
 	pcre_free((void *)p->pcre1_tables);
 }
 #else /* !USE_LIBPCRE1 */
diff --git a/grep.h b/grep.h
index 38ac82b638..14f47189f9 100644
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
@@ -48,7 +52,9 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre1_regexp;
 	pcre_extra *pcre1_extra_info;
+	pcre_jit_stack *pcre1_jit_stack;
 	const unsigned char *pcre1_tables;
+	int pcre1_jit_on;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
-- 
2.11.0

