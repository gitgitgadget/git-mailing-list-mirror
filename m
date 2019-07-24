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
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DB01F462
	for <e@80x24.org>; Wed, 24 Jul 2019 15:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfGXPO4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 11:14:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbfGXPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 11:14:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so47379910wru.10
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pF3nbeSRno6FpOr1XD6hB9MoXJBaQiNhzoKP63+gqFk=;
        b=J1Lnm8qenq1iF0qZcBw2kXJXf5RFccIeiEXcze55FKT3fKXg0I+x0/sdHxObCNTPl3
         rnu4OtLazaxFxda/py1ACTJufApXzbNgZ8kahJHzQEJJv0zDQNY/hJIdYC1XmuSV7j+g
         x6df35r78XYR9Z/4UKJ6O2ucxDVNUgAYLP9gvmr3+jXlxZE0XQLZ6XbTJITeCv2P7Yaa
         gelGtp9cBo4d6d+QUhrBfPEwOJUkXRbF6rtdSemVvaX6qO9LuplLPpPoLftwWIlZXBxx
         U2Fctzc4GbOL8Bo0s7EropT31tfzs1RXfhcnZ3V2F5qDthBRL5WS0ymJkgkZXEwwfnxn
         wFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pF3nbeSRno6FpOr1XD6hB9MoXJBaQiNhzoKP63+gqFk=;
        b=VcYCahTLrX9sVw2loO3gbHVSZPmzpC0GZHs/y13cS5EMXruGi+LXY7pocrwz7oNfEn
         ST8Gz29PEatH9+wjZlAwUYOB7m8YEiZRtaUHFcr3tczqyxDS5mTq4CWh8DNRcgPlm5hZ
         OIQ9WLdw29XUJbYQPXQgMHmWWrWj2ukApEh+lMKt8MJenHNiPCZmRVRIJ6pFnBc4wknb
         UqVl/r1Oo5wMBn7Pnw42JJ3ARzrUyexXucg42CwgSAHvjbqSRaMgwMPidjPu1bz1vOKa
         DhFwN2rzXlVZepJmSaJ1FOa3en4Udum6NsOe01Oe6i2pfCxrJZDvrwNK+bczYs6tdX0d
         hCRA==
X-Gm-Message-State: APjAAAXGvUaE7m80SKbNmF/gUk3hCeDBC0m+ZOVoBahWqat7QIfGhEqZ
        Gibd4cUZYi4hjRM3KUFtW1iaGwItNUA=
X-Google-Smtp-Source: APXvYqz30i1Co1lElL9+i26IHbGlt3SbM/M7vu/YwFc2X/2h387ZezzCLww94WnWTVdPug+5YEuENw==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr91446782wrr.147.1563981291291;
        Wed, 24 Jul 2019 08:14:51 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c78sm66970530wmd.16.2019.07.24.08.14.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:14:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] grep: stop using a custom JIT stack with PCRE v1
Date:   Wed, 24 Jul 2019 17:14:15 +0200
Message-Id: <20190724151415.3698-4-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190721194052.15440-1-carenas@gmail.com>
References: <20190721194052.15440-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the PCRE v1 code for the same reasons as for the PCRE v2 code
in the last commit. Unlike with v2 we actually used the custom stack
in v1, but let's use PCRE's built-in 32 KB one instead, since
experience with v2 shows that's enough. Most distros are already using
v2 as a default, and the underlying sljit code is the same.

Unfortunately we can't just pass a NULL to pcre_jit_exec() as with
pcre2_jit_match(). Unlike the v2 function it doesn't support
that. Instead we need to use the fatter pcre_exec() if we'd like the
same behavior.

This will make things slightly slower than on the fast-path function,
but it's OK since we care less about v1 performance these days since
we have and recommend v2. Running a similar performance test as what I
ran in fbaceaac47 ("grep: add support for the PCRE v1 JIT API",
2017-05-25) via:

    GIT_PERF_REPEAT_COUNT=30 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8 USE_LIBPCRE1=Y CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre/inst' ./run HEAD~ HEAD p7820-grep-engines.sh

Gives us this, just the /perl/ results:

    Test                                            HEAD~             HEAD
    ---------------------------------------------------------------------------------------
    7820.3: perl grep 'how.to'                      0.19(0.67+0.52)   0.19(0.65+0.52) +0.0%
    7820.7: perl grep '^how to'                     0.19(0.78+0.44)   0.19(0.72+0.49) +0.0%
    7820.11: perl grep '[how] to'                   0.39(2.13+0.43)   0.40(2.10+0.46) +2.6%
    7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.44(2.55+0.37)   0.45(2.47+0.41) +2.3%
    7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.23(1.06+0.42)   0.22(1.03+0.43) -4.3%

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 28 +++++-----------------------
 grep.h |  5 -----
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/grep.c b/grep.c
index 20ce95270a..6b52fed53a 100644
--- a/grep.c
+++ b/grep.c
@@ -406,12 +406,6 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
 #ifdef GIT_PCRE1_USE_JIT
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
-	if (p->pcre1_jit_on) {
-		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
-		if (!p->pcre1_jit_stack)
-			die("Couldn't allocate PCRE JIT stack");
-		pcre_assign_jit_stack(p->pcre1_extra_info, NULL, p->pcre1_jit_stack);
-	}
 #endif
 }
 
@@ -423,18 +417,9 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-#ifdef GIT_PCRE1_USE_JIT
-	if (p->pcre1_jit_on) {
-		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
-				    eol - line, 0, flags, ovector,
-				    ARRAY_SIZE(ovector), p->pcre1_jit_stack);
-	} else
-#endif
-	{
-		ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
-				eol - line, 0, flags, ovector,
-				ARRAY_SIZE(ovector));
-	}
+	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
+			eol - line, 0, flags, ovector,
+			ARRAY_SIZE(ovector));
 
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
@@ -451,14 +436,11 @@ static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
 #ifdef GIT_PCRE1_USE_JIT
-	if (p->pcre1_jit_on) {
+	if (p->pcre1_jit_on)
 		pcre_free_study(p->pcre1_extra_info);
-		pcre_jit_stack_free(p->pcre1_jit_stack);
-	} else
+	else
 #endif
-	{
 		pcre_free(p->pcre1_extra_info);
-	}
 	pcre_free((void *)p->pcre1_tables);
 }
 #else /* !USE_LIBPCRE1 */
diff --git a/grep.h b/grep.h
index a65f4a1ae1..a405fc870c 100644
--- a/grep.h
+++ b/grep.h
@@ -14,13 +14,9 @@
 #ifndef GIT_PCRE_STUDY_JIT_COMPILE
 #define GIT_PCRE_STUDY_JIT_COMPILE 0
 #endif
-#if PCRE_MAJOR <= 8 && PCRE_MINOR < 20
-typedef int pcre_jit_stack;
-#endif
 #else
 typedef int pcre;
 typedef int pcre_extra;
-typedef int pcre_jit_stack;
 #endif
 #ifdef USE_LIBPCRE2
 #define PCRE2_CODE_UNIT_WIDTH 8
@@ -86,7 +82,6 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre1_regexp;
 	pcre_extra *pcre1_extra_info;
-	pcre_jit_stack *pcre1_jit_stack;
 	const unsigned char *pcre1_tables;
 	int pcre1_jit_on;
 	pcre2_code *pcre2_pattern;
-- 
2.22.0.455.g172b71a6c5

