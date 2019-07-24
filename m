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
	by dcvr.yhbt.net (Postfix) with ESMTP id 498101F462
	for <e@80x24.org>; Wed, 24 Jul 2019 15:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfGXPOv (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 11:14:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbfGXPOv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 11:14:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so47375888wrt.6
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvH81K+r3NXv3FCmq29WhT/+QrtTVhtc15NI6XL0JT4=;
        b=t0ImHc9YzJFLFD/z62Ci/xJ4A2jvAXRWbzwjPeTMB8RV3eKDk6K2W4VljNDQdYTDE9
         Wiw8F3XINiOhTJ3HrSdHkHfXUtfmtKEfsQpwl5m756X3vEfP0LqPn1+69VrhaYNGvHNC
         AgVRj/b41fYiCh6ZlKBgBGOJgr9UkF0Ic9Ns+SG6DLFVXwIooEwBvKX28gRoMnMieHxY
         ecIv0EFl4RTHq9OCV38bFsH3134FjuKc8CaDdhduUwBCLpwGYOZxuNL4NOtz8nmTf9Xj
         /H3EtNrkAZlNr6uM0bA0JyurEM2qBGVDNU55v05Adrp2IB9i6T7sWiEaOIqrpwdFvqM7
         RMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvH81K+r3NXv3FCmq29WhT/+QrtTVhtc15NI6XL0JT4=;
        b=f/rHl45wu9v+FwXERpd7lIRnoq0kAdUypCjpL4cRXTVimspjDfcBPbLoBx9vcoYOQE
         Jk9R/wbBOMloMwlHuHwFJDtiE4znFuEnqBsmDtVUWr5RrxskXloPYj0McMjfigGG/FEa
         ZxVetndgaQ1RUiIxW2n1eALYC/gUIH38sllDIAfMFBggsQF4xL9sLIizogKJA+Mp9uwP
         zGyT+puK7Tgw96ZhnH8YDSy0h9YbWu4LUMytchXCGL57y+57qPWc7D5gqpWDN4R2hahZ
         F0tg+zcFZ7PrRB1dvXabmmx/cjXcbKnjvuQqGaMrNZNuWDxGuZb5Kr/39xxJ5tEvQDfe
         SPnA==
X-Gm-Message-State: APjAAAWv5CovMRuXwnDh30fAZ3J82M45JBUvfV0t29nnPIy+dfeZB753
        araWwetm1KiyZ9WMOXngnbaTq8/8
X-Google-Smtp-Source: APXvYqzf9zpiaWI7V45xcJmVW6SF4E9u1JYVvsczFMqOcOyGhCIeD4J56Fs/hn05jjVBx0c/j1KpVA==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr90052544wrm.24.1563981288556;
        Wed, 24 Jul 2019 08:14:48 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c78sm66970530wmd.16.2019.07.24.08.14.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:14:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] grep: remove overly paranoid BUG(...) code
Date:   Wed, 24 Jul 2019 17:14:13 +0200
Message-Id: <20190724151415.3698-2-avarab@gmail.com>
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

Remove code that would trigger if pcre_config() or pcre2_config() was
so broken that "do we have JIT?" wouldn't return a boolean.

I added this code back in fbaceaac47 ("grep: add support for the PCRE
v1 JIT API", 2017-05-25) and then as noted in [1] incorrectly
copy/pasted some of it in 94da9193a6 ("grep: add support for PCRE v2",
2017-06-01).

Let's just remove it instead of fixing that bug. Being this paranoid
about what PCRE returns is crossing the line into unreasonable
paranoia.

1. https://public-inbox.org/git/20190722181923.21572-1-dev+git@drbeat.li/

Reported-by:  Beat Bolli <dev+git@drbeat.li>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..be4282fef3 100644
--- a/grep.c
+++ b/grep.c
@@ -406,14 +406,11 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
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
@@ -522,7 +519,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
-	if (p->pcre2_jit_on == 1) {
+	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
 			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
@@ -557,9 +554,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		if (!p->pcre2_match_context)
 			die("Couldn't allocate PCRE2 match context");
 		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
-	} else if (p->pcre2_jit_on != 0) {
-		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
-		    p->pcre1_jit_on);
 	}
 }
 
-- 
2.22.0.455.g172b71a6c5

