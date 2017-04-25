Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551A9207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993561AbdDYVG7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:59 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34847 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954741AbdDYVGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:54 -0400
Received: by mail-wr0-f178.google.com with SMTP id z52so74134347wrc.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2Lyk/WlBnl99HqLNCgXkULY7fvsf4VFERAdL5kqdBw=;
        b=X/Rkjq8Hq3DyLo9awuaYIlRffQ9z6xEIl22Xu7NrxM3Y20TATQHGYW5mdpFYBoD5yI
         vUDF30xKQ/qGnY8oiApQ4LwJFtkdhwjkU8Xyozx0uCSG0d2ZdgR2f2zcK08ceCL2Uym1
         h375Yl3mxGYxoYne+26zw0kcw82RKL65Jr/GaAhrxWBLckhvUruYG5ec5d/jN44lUhmC
         AGuqYU7Ti5zTXHVS47LNk1GI1l1oG3j60ja19oqjvn2AlFPWYgKVJZlfpDi2AEqqdNw8
         5acZmgkr5OkFvZb72w9icVbHWglWJAwwG4PUm7q7ZAeKWMn++oD349WlThH7VrTdIO0z
         mQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2Lyk/WlBnl99HqLNCgXkULY7fvsf4VFERAdL5kqdBw=;
        b=VH9cSPiRM4TthfEFsAp8r1bJlTwgqCRDizwGmYwSGy78/bMvnB5U62t1SLqF1Mi/57
         2W/rHxn2LboyytVAoHOA/AOVjB/WJjv29UZfa26KgG+XoCUwJ5I/rlRBA5CTf0wQyimc
         VCCW+d4rzg9SRpSDh+//WaMhAMix7hLyWgXOjNt7dmuZidU2ZOZ5dpDqRDV/9cr3f4aR
         w6griT90C1czWjVVJ6NwkQB+H1af2HDIINM4z2SNd0h+m4H6RX37tahDLOvkhV4mUxVo
         fEsOj0dmYShNmCq+HPpUTQE94Wm2Y2XuG3Syo/O9e9weO/9ZtE5MExvavg5qIyRLvt1a
         ioiA==
X-Gm-Message-State: AN3rC/6zuc22G751Lf+c3lFIMPAZLtWeanpUditoMPxjEtmYzCUXJha8
        0kIjc7n+eMYLrg==
X-Received: by 10.223.163.91 with SMTP id d27mr4512592wrb.27.1493154407642;
        Tue, 25 Apr 2017 14:06:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:46 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/19] grep: add support for the PCRE v1 JIT API
Date:   Tue, 25 Apr 2017 21:05:45 +0000
Message-Id: <20170425210548.24612-17-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
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
index c61e69deaa..8e3ba164b5 100644
--- a/grep.c
+++ b/grep.c
@@ -329,6 +329,9 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	const char *error;
 	int erroffset;
 	int options = PCRE_MULTILINE;
+#ifdef PCRE_CONFIG_JIT
+	int canjit;
+#endif
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern))
@@ -343,9 +346,19 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
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
@@ -356,8 +369,15 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
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
@@ -372,7 +392,12 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
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

