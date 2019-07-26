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
	by dcvr.yhbt.net (Postfix) with ESMTP id D66681F97E
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfGZPJA (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41142 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfGZPI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:08:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so51590716wrm.8
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tQD2pikR3lL/BmDCOR9dB2uMiWSXy6uvRqu3bpgCps=;
        b=R5ww8XTost5Vx8hBIKVFsCA2oCeA+DHSxeJ7Ehfl589BDwyi/+uLkV0jV+ciy9RbFa
         MoOkgYMiXuEok7B/GRJ3ZhR9CRCJBSmlVkj5fuDWRRCTCEzV3qRW+sYVlB5yzKsq5Xac
         oFlrAZ1xoHeCCvFphU24gFUeK9S8tdRMLVu+x/wV819KgDh2fy7kP/SZfI4/s5mtGeYl
         T87USHM4m07BD2xtZBrxrJJgVdazuSzF2rj4hbJ5DyGfEn8NSLEkgwuTuMSo3bClIKdC
         RnjdZjtNh/Px+rUVcf6oOxIRHQUREB6M9JcBnd5lOcYyJm1XGr5C1IYkdkrMkqKKyVKb
         b9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tQD2pikR3lL/BmDCOR9dB2uMiWSXy6uvRqu3bpgCps=;
        b=FA8zcOtLYLtR9RXkhowFLWSGaKS17HRTfjVzn9BS8ZJVwUx9UjeAdN+xGOAU/oXlji
         cQ8VlxfhiH40GpPYgw/3HpZqys08SepJ0iOoi9R4gLi32tm/z55R9OJzL88EL+Z5Up69
         2msvddrOsru4uO1OLgEZoYDk04Q3hlDnAX5VYn55JNUgWBjfMKjzmajpInhepKhXYYaV
         KwEIAKpsh466F9pTGwy1/rScbY4MHawPVfW1J5dVEgRumfhOM4fYJ+NZhZbL2XwFNaXc
         GZydyErMDJrEd99r0YPo5+zkQB+0vNvQzH2IO0FeQmziJXueVSDY7y78wwK/lSYLQMoP
         f/Lw==
X-Gm-Message-State: APjAAAUXxND479Ww0gRfJzP4fI+wNpyMa3kZjmwZ7twkgR0V3jvcMMcj
        mZmdp63ji6Wsfu1+U0Sgd1oX49uW
X-Google-Smtp-Source: APXvYqypFZPwCr93wRiY7O+oTFutE346edJCxZ7e2qXn3kxaxTLKV2JZsah3Qvx5GeAyT9SdmUJu1w==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr21017196wrh.135.1564153737937;
        Fri, 26 Jul 2019 08:08:57 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.08.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:08:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] grep: remove overly paranoid BUG(...) code
Date:   Fri, 26 Jul 2019 17:08:11 +0200
Message-Id: <20190726150818.6373-2-avarab@gmail.com>
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

Remove code that would trigger if pcre_config() or pcre2_config() was
so broken that "do we have JIT?" wouldn't return a boolean.

I added this code back in fbaceaac47 ("grep: add support for the PCRE
v1 JIT API", 2017-05-25) and then as noted in f002532784 ("grep: print
the pcre2_jit_on value", 2019-07-22) incorrectly copy/pasted some of
it in 94da9193a6 ("grep: add support for PCRE v2", 2017-06-01).

Let's just remove this code. Being this paranoid about the
pcre2?_config() function itself being broken is crossing the line into
unreasonable paranoia.

Reported-by:  Beat Bolli <dev+git@drbeat.li>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index 0937c5bfff..95af88cb74 100644
--- a/grep.c
+++ b/grep.c
@@ -394,14 +394,11 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
 #ifdef GIT_PCRE1_USE_JIT
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
-	if (p->pcre1_jit_on == 1) {
+	if (p->pcre1_jit_on) {
 		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
 		if (!p->pcre1_jit_stack)
 			die("Couldn't allocate PCRE JIT stack");
 		pcre_assign_jit_stack(p->pcre1_extra_info, NULL, p->pcre1_jit_stack);
-	} else if (p->pcre1_jit_on != 0) {
-		BUG("The pcre1_jit_on variable should be 0 or 1, not %d",
-		    p->pcre1_jit_on);
 	}
 #endif
 }
@@ -510,7 +507,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
-	if (p->pcre2_jit_on == 1) {
+	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
 			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
@@ -545,9 +542,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		if (!p->pcre2_match_context)
 			die("Couldn't allocate PCRE2 match context");
 		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
-	} else if (p->pcre2_jit_on != 0) {
-		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
-		    p->pcre2_jit_on);
 	}
 }
 
-- 
2.22.0.455.g172b71a6c5

