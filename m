Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2421F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162512AbeBNTBF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:05 -0500
Received: from mail-it0-f74.google.com ([209.85.214.74]:54274 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162210AbeBNTA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:00:59 -0500
Received: by mail-it0-f74.google.com with SMTP id m184so13118410ith.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HeRJDhl8jtvW8PLijKtyEiD60JLS53YSxJHClJu5FgY=;
        b=DibeTzyubWL71sZw5Kv7Ce81eK4YOQoCjrrACveeWUp5zXH0fdK4dByR61cNiaJ8yX
         2vVgBxIcELfFmYiv9W59sQE4bpVyhsG3RXzeUIueVLTuO+ldAV908dvPG1fiqHTe7EtF
         gevGKN8R+8i1o4U1Qo8P5cFSvsorr7jqL0YuMrkCrQBt+1ppX+QXbtLoh0SOeFaVJRYK
         Kb3VsKDaQFk1aXBKJsNfN+Yvj2Qn/xTtwzZk3pA6gW3hWkdtOKC7IY15ZQGWd9SKJg8c
         ctmOM0LntrrdpPyT2gFwLEEn4EIMRs+bvHq4YjSo1UQaZisLMBMuRRTxLimI4Q42TKBr
         FyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HeRJDhl8jtvW8PLijKtyEiD60JLS53YSxJHClJu5FgY=;
        b=i+nFKzkuJCHGJbkNu8+tK3N0UPO3R6YiC3IMjQlMtNXE9elPSwD5JIfjlur5AO8R0N
         ztx4bqIetzRPJ6YGpjbVnpMTvU//FSCfhwOFB55xLlUTbUr0S1weibfp0WgpONX+gvA7
         mamOqDRNpdt7/SNXcKETm24PSUAjDcoTRytRnq17zz7VLMI3arsQuFho04+OaiIhgwDD
         NMYa8romWRyUW2Mbht2iNrp2cd1ABI0Khb3YDcEY9xQ2ylJFseEgtno1MviCeKGT256T
         ejYzsYMxhT8sIQ9hRtoGnaNhotMMKgD/UA2vaJ41Kg0S0GZNLMbNjSDjmQw4rAYd3OJI
         Vpdg==
X-Gm-Message-State: APf1xPAKmXx7vW9edWy/slU+HJ5ltbdFTpyBo/XvuDmOX5MZ4GZScI8m
        vfZK0yTmD0MJr6fKlGUIwZfknQ/45xua/cY0pYhWvRRNQ86ojRSj9BqsatO3JUEQ/ycZFKruqVi
        DTLEjjPgtAP0U35GI558+l/YYMXyCPs6olxo+/nyorlNUKPV05CmZbNzI1w==
X-Google-Smtp-Source: AH8x225QMgGNmImPrAUknu6MZeFwvdD/WBiJ2eX/vUvr8caIFRoo3/P3Zr1Y4pwl8t4e5PNNOt9llH+Almc=
MIME-Version: 1.0
X-Received: by 10.36.47.131 with SMTP id j125mr2504itj.40.1518634858355; Wed,
 14 Feb 2018 11:00:58 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:28 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-7-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 06/37] diff: rename 'this' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 0a9a0cdf1..d682d0d1f 100644
--- a/diff.c
+++ b/diff.c
@@ -2601,7 +2601,7 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 	while (dir->nr) {
 		struct dirstat_file *f = dir->files;
 		int namelen = strlen(f->name);
-		unsigned long this;
+		unsigned long sum;
 		char *slash;
 
 		if (namelen < baselen)
@@ -2611,15 +2611,15 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 		slash = strchr(f->name + baselen, '/');
 		if (slash) {
 			int newbaselen = slash + 1 - f->name;
-			this = gather_dirstat(opt, dir, changed, f->name, newbaselen);
+			sum = gather_dirstat(opt, dir, changed, f->name, newbaselen);
 			sources++;
 		} else {
-			this = f->changed;
+			sum = f->changed;
 			dir->files++;
 			dir->nr--;
 			sources += 2;
 		}
-		this_dir += this;
+		this_dir += sum;
 	}
 
 	/*
-- 
2.16.1.291.g4437f3f132-goog

