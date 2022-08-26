Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DA0ECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 09:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiHZJji (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbiHZJjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 05:39:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B2A9DB41
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u5so1113360wrt.11
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=R9n5jXs4FmjziGiQa7WHIy+y0b4GSV/osty3hWFDyCc=;
        b=SIvG56otYmjuYIU+Rldiqv2tfB7/3zo1GrjZGCbyxq/yeMGMXUjdIlV1RTypzED4vV
         ztv9F3HWbooknLd6pdd2ntactEvTMCPHavl1bEFGDmYEInYFNr74mlCaPPW+DjCNq7gy
         BPnYMIfhaM2nPaqeiCBMsWUL1szdQlaYoFhTM8lQPRI/xpuC+mU81SZhilbyUN9q+Wfq
         Gy8QhMIGVBwI8GhRdBOXKqdYpVT4f5cLoPlYg9yH5nT01uBUBIYbW//2/0V4ZJVEZ/c/
         S3rUBNjWqsZ6qOUS4uQflDOtNaZQjlYKvYvRYdiNtjdrBcMIxDjZksDZ1iWBhidz/rYk
         aFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=R9n5jXs4FmjziGiQa7WHIy+y0b4GSV/osty3hWFDyCc=;
        b=GDzm3bUELlPSENeBTrbqStxw/kRH7UvQvGcCPWcLgkad5mEzjz/6PKmPucZotbCOaK
         1ApMcDZpX8Sxh9MCDkJ+c4+VuKX7wVYV+ZnFvm2Eb0FHQfkrRvhh2JHdGH4ZQAxYigcM
         vl+siEOcFFXVqB1TccIcAEafkuZumK/llDg82mTus1D00mn+veXuJrhPw3HRHHKqGmFT
         UxIWAJWinVRECTsZioOYElpJI7b8/zJ2RAQ3svH57w0Mh7zdHE7KqVYiJ9PBqf6fkbIV
         rwXHG+R/dA94p4Wk9aEj45rJv/r6nfbTP4eaRbikemC4hY8muyeJ0k8W+vQJtB5rl27c
         6Brg==
X-Gm-Message-State: ACgBeo39vhRvl8zwsQFbPFxSski5KQ9uiQyuIrSMVIVt1QIJQiS7WTUc
        P8RvHj6xfyFEK9y4pPAAUZOx2t82iPU=
X-Google-Smtp-Source: AA6agR7kIJJGwjKN7S6qTF1vuACSUn0QPUsqz6c1kusk8cNp+GsaxIoseKcFy2HHfP6Fe91HMaJuuQ==
X-Received: by 2002:a5d:6da9:0:b0:225:59e2:ee40 with SMTP id u9-20020a5d6da9000000b0022559e2ee40mr4269381wrs.540.1661506774051;
        Fri, 26 Aug 2022 02:39:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c219000b003a5537bb2besm1834294wme.25.2022.08.26.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:39:33 -0700 (PDT)
Message-Id: <150f29a1c48917577ccaa93c0d4548c871adc1f6.1661506770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
        <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Aug 2022 09:39:28 +0000
Subject: [PATCH v2 1/3] range-diff: reorder argument handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d9c66f0b5bf (range-diff: first rudimentary implementation,
2018-08-13), we introduced the argument handling of the `range-diff`
command, special-casing three different stanzas based on the argument
count.

The somewhat unorthodox order (first handling the case of 2 arguments,
then 3, then 1) was chosen for clarity: the natural argument number is 2
because that is how many revision ranges are used internally. The code
to handle three arguments is relatively trivial, so it was added next.
And finally, the code to ungarble a single symmetric range into two
separate ones was added, because it was the most complicated (the most
inelegant part being about interpreting empty sides of the symmetric
range as `HEAD`).

In preparation for allowing pathspecs in `git range-diff` invocations,
where we no longer have the luxury of using the number of arguments to
disambiguate between these three different ways to specify the commit
ranges, we need to order these cases by argument count, in descending
order.

This patch is best viewed with `--color-moved`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 50318849d65..f8d3869d357 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -55,7 +55,10 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	if (!simple_color)
 		diffopt.use_color = 1;
 
-	if (argc == 2) {
+	if (argc == 3) {
+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
+	} else if (argc == 2) {
 		if (!is_range_diff_range(argv[0]))
 			die(_("not a commit range: '%s'"), argv[0]);
 		strbuf_addstr(&range1, argv[0]);
@@ -63,9 +66,6 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		if (!is_range_diff_range(argv[1]))
 			die(_("not a commit range: '%s'"), argv[1]);
 		strbuf_addstr(&range2, argv[1]);
-	} else if (argc == 3) {
-		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
-		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
 	} else if (argc == 1) {
 		const char *b = strstr(argv[0], "..."), *a = argv[0];
 		int a_len;
-- 
gitgitgadget

