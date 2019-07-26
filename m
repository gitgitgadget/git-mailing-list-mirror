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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7527A1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbfGZPJD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50355 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfGZPJD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:09:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so48330423wml.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIZJUwhkVOxwhAlp0dkrA4dJpBmqoq8e6MyfhV+j5PI=;
        b=WhzjbONTDmZfq2WFZTmYEdQdtw5gLRBm9M62+JehzqYwsuxnNTFfy0bxhKan4ctknu
         u7zjlswrDpELlsF4TK23/0PShgTc0mAihUxr2JyJ5udUwC5XAp872nZZOHTJSAxO2t/6
         w0lsX+E/bpmXHltBJRkxIlbmQofZA4KdvEtlIZsXB16CErXmUOrULjpshma1gJon7K7c
         p3LsaglKRm3Fso/cXAvsDkidzluDqLHLE+9ci0NV7JWCG/pkQc9iNLfhPxoCUryDmsKh
         71OgEULytSPOyuqf6bX5alt5IsuBtf25+DaN52lZEPIEyiSD0+rvTTMa7iVIgyx+k206
         GMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIZJUwhkVOxwhAlp0dkrA4dJpBmqoq8e6MyfhV+j5PI=;
        b=ZicwsqgDl0SBhELV4nSWRq9tdbQgHT42k1pdbQngr9VjE5hfHMiQMea8My+XxAq8Bb
         jD1Qq/Lm/y1znBlOLHgGaqmXUZAI8mCqrFTwTSOPfNjF0dolAqDK/fD91p6KB3DE7tmy
         YTHXP1nBjqWHwMDbMJpIjtFAD2dRO2rhjXAN3dhsYN1pQjMj3/Gm2hkp0sXa2DJbX21H
         olwa7MOeRSX7tMuWco1p2wqPqNLB4Gs9rJb9sSQg7lmwNwNih0NCYTTNfJEV1ij4wiZk
         U3HmhQbNYCOxwv01t0Nkg6zAtcsFYx3AGtBWBsYYXUdIKz5ZX02/gAp1YeCbj8u8Fytp
         S/rg==
X-Gm-Message-State: APjAAAVLuM4iFIrMaezKxMugUUWDGvTObQDemICjXgU5eR95Go/b2pXu
        BLU/ypZyPUKDQTzUSlhjNxspyiU02hY=
X-Google-Smtp-Source: APXvYqwigWF8q9D/+zBZHvBGU9k4OzFNTgzLPWSZ9rEWgiCZ3XAhaOWQI7efT59Xj2HVgZ3NxdAuzA==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr85902565wme.29.1564153740558;
        Fri, 26 Jul 2019 08:09:00 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.08.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:08:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] grep: stop using a custom JIT stack with PCRE v1
Date:   Fri, 26 Jul 2019 17:08:13 +0200
Message-Id: <20190726150818.6373-4-avarab@gmail.com>
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

It will also implicitly re-enable UTF-8 validation for PCRE v1. As
noted in [1] we now have cases as a result where PCRE v1 is more eager
to error out. Subsequent patches will fix that for v2, and I think
it's fair to tell v1 users "just upgrade" and not worry about that
edge case for v1.

1.  https://public-inbox.org/git/CAPUEsphZJ_Uv9o1-yDpjNLA_q-f7gWXz9g1gCY2pYAYN8ri40g@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 28 +++++-----------------------
 grep.h |  5 -----
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/grep.c b/grep.c
index 4b1e917ac5..9c2b259771 100644
--- a/grep.c
+++ b/grep.c
@@ -394,12 +394,6 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
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
 
@@ -411,18 +405,9 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
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
@@ -439,14 +424,11 @@ static void free_pcre1_regexp(struct grep_pat *p)
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
index 4d8e300175..ce2d72571f 100644
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
@@ -85,7 +81,6 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre1_regexp;
 	pcre_extra *pcre1_extra_info;
-	pcre_jit_stack *pcre1_jit_stack;
 	const unsigned char *pcre1_tables;
 	int pcre1_jit_on;
 	pcre2_code *pcre2_pattern;
-- 
2.22.0.455.g172b71a6c5

