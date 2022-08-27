Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A6AECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiH0Moj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiH0Moc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71003137A
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v16so2035795wrm.8
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=4nZ5T9cMdKhWlaoNeMMhrxt/eq5mUn7eiiPvf1i1Ivs=;
        b=bnrsnPagXcSb+GyUfwG6PItwpgs6SZJt9BrP+y8a7QgtldKys4AYqPhaoHMFg7f4+e
         kfKJVYbjcV1JHBCawZ5sJf6CLyPoEXOk/q24qo/go6cskT8bjLC/uKgvqpCMyFA+Lffo
         cQ4nFMurOlJ12Uqc01v5b9aG/ZzDZ/R42RfbjkrNcPYd5o0aTq8lRrOdFHLUozu5dZZl
         TFYv1D/fkJXDliI65g2wdRoy7rl4ycgF4nTweEbFuUrJs5HzQANFypnD2V/9YCbFyqxM
         1/FsNIQfgey8qu9SC+ldcbGIg6xsJYtveVr8vGvaz/qokHvczW7pCrIs8xC9iwzfgfe2
         0VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=4nZ5T9cMdKhWlaoNeMMhrxt/eq5mUn7eiiPvf1i1Ivs=;
        b=yQpvRF5F0n2Z3UcXhCTg1NgdnViTPOXuwE1KVY4rUapL17ZLpmTtS0jbTPba2UJi5g
         /fmxfCo95E59T+J3NDhmWY6xK3ZUMaNI9lm8ZjyupUwuRDxwjLvFn4DoDcXAaBrM8yZG
         KG78CoBeudSTbhVZL5/klldIueWqA4Yi3NVbioTYSTfO+3zQsfb/4rd6m5LE9guWvJgW
         8TT2kUlDZOhDkC/bmZr93uGvnvn4W/XKl7M3nxAbVIpwA/da7tvz/ammTCEcslJvpc76
         IySa9K/JAJpTtJ2ZVpIWcZBuw4Qnru4rBhH0wtyDDHfBPkRH6E5nKdSJsQ1NC5LbUT9j
         cfsA==
X-Gm-Message-State: ACgBeo14MWvUJm8MHWlOi/BNEParh57OD69DoGMD/Qqoa/AnjeCKALPf
        jxQkBZNHhTTLuou+2VCk+94hx8O5VlQ=
X-Google-Smtp-Source: AA6agR6xjNMHoPlRNen16TYuvzDABNW+AoBI0fCAPITTR8FsU4Iry9lnD/kirySeXDk9o/4q15MLcw==
X-Received: by 2002:adf:d081:0:b0:225:8625:53e0 with SMTP id y1-20020adfd081000000b00225862553e0mr2079554wrh.542.1661604270196;
        Sat, 27 Aug 2022 05:44:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c15d400b003a331c6bffdsm2501773wmf.47.2022.08.27.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:29 -0700 (PDT)
Message-Id: <1e43148864a52ffe05b5075bd0e449c0e056f078.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:10 +0000
Subject: [PATCH v5 02/16] bisect--helper: really retire --bisect-next-check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 911aba14205 (bisect--helper: retire `--bisect-next-check` subcommand,
2021-09-13), we removed the usage string and the implementation, but not
actually the option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2cc69e1eee5..bdf7ce18d7a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1280,7 +1280,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
@@ -1296,8 +1295,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
-			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-- 
gitgitgadget

