Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B461F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfGAVVR (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38617 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so1005324wmj.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUiqybTOopFcwW4EfTGYqjTSRi5yZxqzQZSqNSqKeew=;
        b=B5BFmQwZwJlgt4lKd8Az2Bcq8YEtctpoiGYUe938Cz2OJf29J+LQCPtqFiVPmsqAFo
         Ne6XLaJ/8aDcGrriL0yvZ0DgF/6d2DZEuFotrbp4dI1HYLHn8CkYDn9FUesbbiCmXsas
         BHQdXqa2IvG5+PmOpPrrR930Uq5Mb1LQmK/RAfDxSE7rlSo0CtY92hw0meNVm6pMJncq
         ayRahwxuC6NMsTL4OO3pyZiW9e9lDaLucD94rvucLZYs10hJM7YRqHHS8sAX0EM2n9uZ
         Io/WVSfhhjHnKdvHIdn0BDuNYGrCfxpxSXgfvU1OQGmTa8s88CDQvm3s98yl9zesQ13i
         5bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUiqybTOopFcwW4EfTGYqjTSRi5yZxqzQZSqNSqKeew=;
        b=aryKgvo3hTJjJcXj+RPrhJSJjHrt7YyA1A04PmQp+SoaJ1kIAWzclaJFj+eaprd8jp
         ggsP6vbhhVD2queAoT/EaXbdI1f8zftEvGtLZVQ14lgrtX4NaqINTCcHeTnqGROQ5ksC
         jHymQr+Z0Fa5Pc3Na/BxXAnMDkZT+PPbBr+iF3+GE14oGd8sqi3013TJPn2NtZHNymws
         D7Ll0rJ7ygQ32fTYu71HdaotbkXdM2OJlm0LfGEPBr6oXHaiRukBmdjbbjO9Is3uWSmg
         Oyf5kphWRNfeTzYC7+9HQ5F5DtXQK46UEM/PfUFPKGBkhvisfx+lcgZee/SFyW8vKOby
         zKdA==
X-Gm-Message-State: APjAAAWxRHIeEs6wyM+vlF7YHnCUc9vkTxxR7kM+4gnVk68T4jd8XtXY
        ePfZlze77Udl21Wcmw9vLdpcBr6hulM=
X-Google-Smtp-Source: APXvYqysdHzrlQeofC8reb9+GPI2R4l/SEK17CBHfCLPT394544IMDLe4eGy/RteCybHYjPvIdW3+A==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr704187wme.93.1562016075259;
        Mon, 01 Jul 2019 14:21:15 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/10] grep: inline the return value of a function call used only once
Date:   Mon,  1 Jul 2019 23:20:54 +0200
Message-Id: <20190701212100.27850-5-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
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

