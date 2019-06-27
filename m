Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4299C1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 23:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfF0Xjb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 19:39:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34136 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0Xja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so4347622wrl.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUiqybTOopFcwW4EfTGYqjTSRi5yZxqzQZSqNSqKeew=;
        b=LSxxHsfxEwlge5r2/28O3+qZpWPzj7RWIAlQrzFri4mPN5auhphy+8KHAGf78Bb4CF
         pGgCRkpWl9uRBR5c0hWsJ5ncFbBVAL/e37VEyDEv26IBPAmsDgqdUl/hm0V+kz7DEVJ0
         4Ma5Yk7+EDkCNI9hsbNKoDRBwI1SenhLin1L3jo64UokpJI/G1kz31og+rb3EigGrw2s
         Z9GcQv+Cvg3Z2xyWxOq/Lhuay0xAt7+7bcHqRfL3ulYIVMxZHSgaqliV2tZRlW+1FKz/
         XoaStWciIGoqG4/unT6tNCA6WkCeUkxJaOwHOvcXnH7RZY2iIeOFKcjpZrS4mk0uMmFE
         hTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUiqybTOopFcwW4EfTGYqjTSRi5yZxqzQZSqNSqKeew=;
        b=X2oQGAdEAwdZNQqzK0bA9KYpN/RnL84BluAPAJVytlLWuyDBnVlSmTWqTtZX2atxk1
         90oNCnvwYG1Rqea7eEZN/edz2Si3bNqU0rIsuI3P9ZxzFKtgkEwVi5u9AAt6dcuvNY6k
         BvE2vmxZxarUSCRRSip7uMKpaquP8qNlsRBSgld13MtmtgRppF3sVDodf456bYDORGt7
         Rdg2TFalwOAXN+9du4WckQIJ3EyUyjmgXEUkrqlW9lHn5wm3gfxyi2sGhPsbDcAlKZiD
         SYobNHn/kmtM1k939eC7hB53ZoqI28XIHKciNMIyGvlAPdqJe/hNJn2U6PKZ2kcLa6xB
         I6fg==
X-Gm-Message-State: APjAAAVRV/Y6eaSuF+YOYuApqGLVeePjpPqbyIdYlpkUi/H3lrXLgSLn
        jRZ6nrp6Y5raIGH8mhvhoMZNLtFT
X-Google-Smtp-Source: APXvYqwNQSAil4vq99j054PNy14hbXlv/Z3maqG7D8b7WByHg/KsZzZf9aGSL9mixxfsLnn3+KUqPQ==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr5281259wrw.8.1561678767491;
        Thu, 27 Jun 2019 16:39:27 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x16sm720530wmj.4.2019.06.27.16.39.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:39:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] grep: inline the return value of a function call used only once
Date:   Fri, 28 Jun 2019 01:39:06 +0200
Message-Id: <20190627233912.7117-4-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190626000329.32475-1-avarab@gmail.com>
References: <20190626000329.32475-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e944d9d932 ("grep: rewrite an if/else condition to avoid
duplicate expression", 2016-06-25) the "ascii_only" variable has only
been used once in compile_regexp(), let's just inline it there.

This makes the code easier to read, and might make it marginally
faster depending on compiler optimizations.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 1de4ab49c0..4e8d0645a8 100644
--- a/grep.c
+++ b/grep.c
@@ -650,13 +650,11 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
-	int ascii_only;
 	int err;
 	int regflags = REG_NEWLINE;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	ascii_only     = !has_non_ascii(p->pattern);
 
 	/*
 	 * Even when -F (fixed) asks us to do a non-regexp search, we
@@ -673,7 +671,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (opt->fixed ||
 	    has_null(p->pattern, p->patternlen) ||
 	    is_fixed(p->pattern, p->patternlen))
-		p->fixed = !p->ignore_case || ascii_only;
+		p->fixed = !p->ignore_case || !has_non_ascii(p->pattern);
 
 	if (p->fixed) {
 		p->kws = kwsalloc(p->ignore_case ? tolower_trans_tbl : NULL);
-- 
2.22.0.455.g172b71a6c5

