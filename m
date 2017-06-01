Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C50520D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdFASVY (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:24 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34925 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFASVU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:20 -0400
Received: by mail-wm0-f41.google.com with SMTP id b84so168903083wmh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=076kAI+6eXTrxG6mNoNrEy4sAoaf5ALj7d+ZLhYiztg=;
        b=M5SBd4mLY9XyuwKYKhs1GQDsid5yGP1Z44iF2kfisS9gQl1m7agJRL5A7xcU2mvTJT
         ekWQEWLxulTVe6VfFls7EtVf2vo3wc6h/Cj4DCkkOBqnFdKS0bG/3icJZHBoA6Kj82AH
         Wcuf1DJXsVLsqmDnNsgJ4Xz2vbcG5vcNFAp0wHBvJzunAzqjsblq5YbX/JlMobfS5/ly
         SJf+0cbbDLX6i+9AhXSVEh9kztsOFSmH+0UmT2rEUz9NEWKqEL2DRSCwQMcknx7NgfHT
         X2gP2AOezFPT62OuVxiF1p1YUXqXx9gtf73G4O8LVM4ZQPjTkImBlwgBvRyWiwFtC01l
         UlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=076kAI+6eXTrxG6mNoNrEy4sAoaf5ALj7d+ZLhYiztg=;
        b=A5fuYJdMbPv9pn9rZ695QgAk0pqTsLdXqYY27EumxNhHEYhpfBVEUrcwtnh0UC99LW
         CrdqtZPMU6KgGmFPWR+GHaC4nsGrniFw5s2NK5Lriqhz5buB9bwrQPAt1rC5kEBy1Rna
         Z5bJjYV8a+oTIjSICENWSs30f/nnUOc8JrycOCklD0j6T9odC2ZSZ/Be92lVDBgz2R5J
         uf3OwT9TAcsTlwl3p4mI2U0IpBbWCRw7hKj2iGXM18r0NWQp9qru07sGGWq65WZ9q/8w
         /ZsQDhFwuw8I602LM3YjaZc8U34AYzx7NT0efCaH5kLHVP29e0XpIlFhEjwUlDyOsV3t
         cZIg==
X-Gm-Message-State: AODbwcBkxXIV6tbqIC9aZLjn+fHQChfjltqx1xKBAes/CrAnlWie7DHp
        s5ACG4IYdKyDTLuq3IrYwQ==
X-Received: by 10.223.142.202 with SMTP id q68mr2204807wrb.25.1496341278511;
        Thu, 01 Jun 2017 11:21:18 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:17 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/8] grep: add support for the PCRE v1 JIT API
Date:   Thu,  1 Jun 2017 18:20:52 +0000
Message-Id: <20170601182056.31142-5-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170601182056.31142-1-avarab@gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com>
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
    7820.3: perl grep 'how.to'                      0.35(1.11+0.43)   0.23(0.42+0.46) -34.3%
    7820.7: perl grep '^how to'                     0.64(2.71+0.36)   0.27(0.66+0.44) -57.8%
    7820.11: perl grep '[how] to'                   0.63(2.51+0.42)   0.33(0.98+0.39) -47.6%
    7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       1.17(5.61+0.35)   0.34(1.08+0.46) -70.9%
    7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.43(1.52+0.44)   0.30(0.88+0.42) -30.2%

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

That there's no assignment of `p->pcre1_jit_on = 0` when
PCRE_CONFIG_JIT isn't defined isn't a bug. The create_grep_pat()
function allocates the grep_pat allocates it with calloc(), so it's
guaranteed to be 0 when PCRE_CONFIG_JIT isn't defined.

I you're bisecting and find this change, check that your PCRE isn't
older than 8.32. This change intentionally broke really old versions
of PCRE, but that's fixed in follow-up commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 40 ++++++++++++++++++++++++++++++++++++----
 grep.h |  6 ++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index d03d424e5c..ffe95995ee 100644
--- a/grep.c
+++ b/grep.c
@@ -365,9 +365,22 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
-	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, 0, &error);
+	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, PCRE_STUDY_JIT_COMPILE, &error);
 	if (!p->pcre1_extra_info && error)
 		die("%s", error);
+
+#ifdef PCRE_CONFIG_JIT
+	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
+	if (p->pcre1_jit_on == 1) {
+		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
+		if (!p->pcre1_jit_stack)
+			die("Couldn't allocate PCRE JIT stack");
+		pcre_assign_jit_stack(p->pcre1_extra_info, NULL, p->pcre1_jit_stack);
+	} else if (p->pcre1_jit_on != 0) {
+		die("BUG: The pcre1_jit_on variable should be 0 or 1, not %d",
+		    p->pcre1_jit_on);
+	}
+#endif
 }
 
 static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
@@ -378,8 +391,19 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
-			0, flags, ovector, ARRAY_SIZE(ovector));
+#ifdef PCRE_CONFIG_JIT
+	if (p->pcre1_jit_on) {
+		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
+				    eol - line, 0, flags, ovector,
+				    ARRAY_SIZE(ovector), p->pcre1_jit_stack);
+	} else
+#endif
+	{
+		ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
+				eol - line, 0, flags, ovector,
+				ARRAY_SIZE(ovector));
+	}
+
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
 	if (ret > 0) {
@@ -394,7 +418,15 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
-	pcre_free(p->pcre1_extra_info);
+#ifdef PCRE_CONFIG_JIT
+	if (p->pcre1_jit_on) {
+		pcre_free_study(p->pcre1_extra_info);
+		pcre_jit_stack_free(p->pcre1_jit_stack);
+	} else
+#endif
+	{
+		pcre_free(p->pcre1_extra_info);
+	}
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
2.13.0.303.g4ebf302169

