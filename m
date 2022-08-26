Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E0ECAAD8
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 09:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbiHZJjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiHZJjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 05:39:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D081DAE216
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n17so1136561wrm.4
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=cozaAwc+epvp4IegY/IBfVoSuI833gg9OLEeBehc8B4=;
        b=YVBCwwv9fqU7V+bCVTNBkyn2y5OkxVONC01/q6+ssg78kOsafErILNtvQcSvxv1hbY
         3BeOEC1TgAT1gHQHCObatZMbwuZR0Dr9EKwZDKkvkp+oONUGEEAbnKv6IHZcSI3+fV4/
         5g2SwLrW8cjZmocVdJKVdKWlgM19z0aChau9g71YcOaEs+gVHC6eB2vijlE5J0aP8NFH
         LgDctFStPHo/8iSvAIqnExcsQAgB4eN6oGLAqFY27YZSvfn6yqlFpHHSuhaxnvPytDZY
         vKI/LlQC8LEUkh1JoVUk1IlSXbodqZXcvlACqpYneDOsbiy8bSQij/CAExNwuDH3m+Qi
         FdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=cozaAwc+epvp4IegY/IBfVoSuI833gg9OLEeBehc8B4=;
        b=NcP51Zwpn87aXuW1V7qNlirmIqjYVLN1X7vBUiSNcjFYmgMkM/jEtZy4GmLCVhffJM
         9Jp6RKwHjhHZJ4ZJANRx2EHoYIUX/rhxSul99Q0TEQaucSjxd6Yxikvdde7aVxFWBpIN
         MXQoChQhMvPyct4p+q/5q5UpX0Xv8wg1Zp+jFZLojHvOFxY5/aqsM674X431AUaBZU7R
         G6HW+KsvyqyEGr0mpjYzMd/loylpDdhFimmJAZ12h/HnJCFMwQ/N08LEJAERTH5NnAdw
         wgzrF41DCoRF4u+Y865vvwccSHiAU647zyVpgi4+BNhWxPBk94WJ1MyMsRuWzJafyKKS
         933w==
X-Gm-Message-State: ACgBeo2MoL2kfDj3CvOGHMs5sUyFDqQUyV1JFD05GvjmvsdLSP0RdNDj
        1Mle//xD0kuC5pxr7dj0983lJgQKEJw=
X-Google-Smtp-Source: AA6agR6m1IAa1a3JLdwtbPdcoStrhHI5dvgE61KvKLAMScaPlo2dNITz5F7uITPyAc6ObNF526Adjw==
X-Received: by 2002:adf:e101:0:b0:225:a31:854b with SMTP id t1-20020adfe101000000b002250a31854bmr4288420wrz.143.1661506775142;
        Fri, 26 Aug 2022 02:39:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020adff20b000000b002257f1a227dsm1439999wro.46.2022.08.26.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:39:34 -0700 (PDT)
Message-Id: <4cd7f09557c7d0a4802b07d1e8440015e0a50524.1661506770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
        <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Aug 2022 09:39:29 +0000
Subject: [PATCH v2 2/3] range-diff: consistently validate the arguments
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

This patch lets `range-diff` validate the arguments not only when
invoked with one or two arguments, but also in the code path where three
arguments are handled.

While at it, we now use `usage_msg_opt*()` consistently.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f8d3869d357..71319ed1d84 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -40,6 +40,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	struct option *options;
 	int res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
+	struct object_id oid;
 
 	git_config(git_diff_ui_config, NULL);
 
@@ -56,24 +57,41 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		diffopt.use_color = 1;
 
 	if (argc == 3) {
+		if (get_oid_committish(argv[0], &oid))
+			usage_msg_optf(_("not a revision: '%s'"),
+				       builtin_range_diff_usage, options,
+				       argv[0]);
+		else if (get_oid_committish(argv[1], &oid))
+			usage_msg_optf(_("not a revision: '%s'"),
+				       builtin_range_diff_usage, options,
+				       argv[1]);
+		else if (get_oid_committish(argv[2], &oid))
+			usage_msg_optf(_("not a revision: '%s'"),
+				       builtin_range_diff_usage, options,
+				       argv[2]);
+
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
 		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
 	} else if (argc == 2) {
 		if (!is_range_diff_range(argv[0]))
-			die(_("not a commit range: '%s'"), argv[0]);
-		strbuf_addstr(&range1, argv[0]);
+			usage_msg_optf(_("not a commit range: '%s'"),
+				       builtin_range_diff_usage, options,
+				       argv[0]);
+		else if (!is_range_diff_range(argv[1]))
+			usage_msg_optf(_("not a commit range: '%s'"),
+				       builtin_range_diff_usage, options,
+				       argv[1]);
 
-		if (!is_range_diff_range(argv[1]))
-			die(_("not a commit range: '%s'"), argv[1]);
+		strbuf_addstr(&range1, argv[0]);
 		strbuf_addstr(&range2, argv[1]);
 	} else if (argc == 1) {
 		const char *b = strstr(argv[0], "..."), *a = argv[0];
 		int a_len;
 
-		if (!b) {
-			error(_("single arg format must be symmetric range"));
-			usage_with_options(builtin_range_diff_usage, options);
-		}
+		if (!b)
+			usage_msg_optf(_("not a symmetric range: '%s'"),
+				       builtin_range_diff_usage, options,
+				       argv[0]);
 
 		a_len = (int)(b - a);
 		if (!a_len) {
@@ -85,10 +103,9 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 			b = "HEAD";
 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
-	} else {
-		error(_("need two commit ranges"));
-		usage_with_options(builtin_range_diff_usage, options);
-	}
+	} else
+		usage_msg_opt(_("need two commit ranges"),
+			      builtin_range_diff_usage, options);
 	FREE_AND_NULL(options);
 
 	range_diff_opts.dual_color = simple_color < 1;
-- 
gitgitgadget

