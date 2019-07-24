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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4721E1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 15:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfGXPOx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 11:14:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50863 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbfGXPOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 11:14:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so42212307wml.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCUeVJXfORPUBQ2JLBbL5WWUQ7HNqlFE03QUXcWCw+c=;
        b=QdPXCJ0eS0L5kOmbSo4h7N86Q1fAY94caHau2oPHRCYXN/9lYmSCW1R6SSTS5w02Fx
         3oCtJuGkS7aWAot16cOqC/95qwN18X5pG+fa+HLkce0kP2N5oCHxEfZTaIEGI8qr5ong
         5v/E3CkEfxixWb1P1PTzu1MhA1o3OiDpMzS8XI5d+CKJOs/3QVIgD9z42dptGCOPzl+g
         OgBcdBAzX1MsUYqeG+gTzkdEocat2NUWljN89sYceapLvSiqB33rVFT/Bue/owlh9m6P
         dPDI1iH1LU+2qIo/sVI/Ng0uerRlys3PO3lQszPVXVVpNCz8kZNbxuAucYGaqDwAQJ0X
         zywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCUeVJXfORPUBQ2JLBbL5WWUQ7HNqlFE03QUXcWCw+c=;
        b=rYEP0+tqfaq5VVZ/7w3ShzCttMHkuDbBDjj/x/AZiiSEEohQfhfPlfsggmDDfZKYm2
         2bgEQgNHHCyZcYjA6SORTyCffOZ/QCfEikEmVvQF6PgnYBnngqY8WzzUgddRJbYaYeQ2
         8ZflNrJAPULrxZDc7b7CevTGLNl9t8uquNJMI1lwr/CsW+UUEWlFvKSE9h/U+YKKq2y1
         /xPOBEJQTilqyIEf/Wbvza3w5puwEBMRYo2Xv1KQOUHBxhU9dc+ZK2nd7BlBRqoM1+zu
         01t2zVEYExhWHOTkmO56lSfFZeFagLlCi/7+l65NINzTBcsWuc9qd0EYsvdykT0PDqgK
         7VUw==
X-Gm-Message-State: APjAAAVRTKCrk5Y5ULFC9BYyTRFXDOenkTip8S5WJvIiSH9W+fTu57H4
        UAkfwKS3TSdjXByfRTWIVEfsUqGiGUM=
X-Google-Smtp-Source: APXvYqyNhcMWSNkxCJ2tcKK8Q0K6emZii6y5MpNtlyeVfsU18iThbHOxGKT8ly9C+xn5z7hQRCDtEg==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr73957743wme.76.1563981289961;
        Wed, 24 Jul 2019 08:14:49 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c78sm66970530wmd.16.2019.07.24.08.14.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:14:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] grep: stop "using" a custom JIT stack with PCRE v2
Date:   Wed, 24 Jul 2019 17:14:14 +0200
Message-Id: <20190724151415.3698-3-avarab@gmail.com>
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

As reported in [1] the code I added in 94da9193a6 ("grep: add support
for PCRE v2", 2017-06-01) to use a custom JIT stack has never
worked. It was incorrectly copy/pasted from code I added in
fbaceaac47 ("grep: add support for the PCRE v1 JIT API", 2017-05-25),
which did work.

Thus our intention of starting with 1 byte of stack at a maximum of 1
MB didn't happen, we'd always use the 32 KB stack provided by PCRE
v2's jit_machine_stack_exec()[2]. The reason I allocated a custom
stack at all was this advice in pcrejit(3) (same in pcre2jit(3)):

    "By default, it uses 32KiB on the machine stack. However, some
    large or complicated patterns need more than this"

Since we've haven't had any reports of users running into
PCRE2_ERROR_JIT_STACKLIMIT in the wild I think we can safely assume
that we can just use the library defaults instead and drop this
code. This won't change with the wider use of PCRE v2 in
ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15), a
fixed string search is not a "large or complicated pattern".

For good measure I ran the performance test noted in 94da9193a6,
although the command is simpler now due to my 0f50c8e32c ("Makefile:
remove the NO_R_TO_GCC_LINKER flag", 2019-05-17):

    GIT_PERF_REPEAT_COUNT=30 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8 USE_LIBPCRE2=Y CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre2/inst' ./run HEAD~ HEAD p7820-grep-engines.sh

Just the /perl/ results are:

    Test                                            HEAD~             HEAD
    ---------------------------------------------------------------------------------------
    7820.3: perl grep 'how.to'                      0.17(0.27+0.65)   0.17(0.24+0.68) +0.0%
    7820.7: perl grep '^how to'                     0.16(0.23+0.66)   0.16(0.23+0.67) +0.0%
    7820.11: perl grep '[how] to'                   0.18(0.35+0.62)   0.18(0.33+0.65) +0.0%
    7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.17(0.45+0.54)   0.17(0.49+0.50) +0.0%
    7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.16(0.33+0.58)   0.16(0.29+0.62) +0.0%

So, as expected there's no change, and running with valgrind reveals
that we have fewer allocations now.

1. https://public-inbox.org/git/20190721194052.15440-1-carenas@gmail.com/
2. I didn't really intend to start with 1 byte, looking at the PCRE v2
   code again what happened is that I cargo-culted some of PCRE v2's
   own test code which was meant to test re-allocations. It's more
   sane to start with say 32 KB with a max of 1 MB, as pcre2grep.c
   does.

Reported-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 10 ----------
 grep.h |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/grep.c b/grep.c
index be4282fef3..20ce95270a 100644
--- a/grep.c
+++ b/grep.c
@@ -546,14 +546,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			p->pcre2_jit_on = 0;
 			return;
 		}
-
-		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, NULL);
-		if (!p->pcre2_jit_stack)
-			die("Couldn't allocate PCRE2 JIT stack");
-		p->pcre2_match_context = pcre2_match_context_create(NULL);
-		if (!p->pcre2_match_context)
-			die("Couldn't allocate PCRE2 match context");
-		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
 	}
 }
 
@@ -597,8 +589,6 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_compile_context_free(p->pcre2_compile_context);
 	pcre2_code_free(p->pcre2_pattern);
 	pcre2_match_data_free(p->pcre2_match_data);
-	pcre2_jit_stack_free(p->pcre2_jit_stack);
-	pcre2_match_context_free(p->pcre2_match_context);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 1875880f37..a65f4a1ae1 100644
--- a/grep.h
+++ b/grep.h
@@ -29,8 +29,6 @@ typedef int pcre_jit_stack;
 typedef int pcre2_code;
 typedef int pcre2_match_data;
 typedef int pcre2_compile_context;
-typedef int pcre2_match_context;
-typedef int pcre2_jit_stack;
 #endif
 #include "kwset.h"
 #include "thread-utils.h"
@@ -94,8 +92,6 @@ struct grep_pat {
 	pcre2_code *pcre2_pattern;
 	pcre2_match_data *pcre2_match_data;
 	pcre2_compile_context *pcre2_compile_context;
-	pcre2_match_context *pcre2_match_context;
-	pcre2_jit_stack *pcre2_jit_stack;
 	uint32_t pcre2_jit_on;
 	kwset_t kws;
 	unsigned fixed:1;
-- 
2.22.0.455.g172b71a6c5

