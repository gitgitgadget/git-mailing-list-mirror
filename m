Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A650ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiH3Sud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiH3Su0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F9205DE
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j26so6251749wms.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=4nZ5T9cMdKhWlaoNeMMhrxt/eq5mUn7eiiPvf1i1Ivs=;
        b=AYl1ALr0ckoySIn+RmQIGD0Aavi+ZNjdo//xpkMXXElAxd4B7PgJkc0MvhIRxbDeGs
         epyxTWpO1W5vpsJntHNostHSA51aSdOAE0Drz1OUBILJt35Vs4YIvtKyxKA47hDqKEJ8
         qQO8kI3IiIMiQ3ynb+HAVpgFuHaEqaD6kk+8POnFNVAaQ+E/UDW9k6gJdIT3jBUR5+zk
         BnXzR64oCdooSclE0duOGdADl+L0DuVn+vFO6ycLV8/k8q07QyBmOdiNvsbfm1KjCvJa
         zQnzyo/k2uSuDr+FPy5zLRnpFL1pbYUOwP5OWICI9nlNCg+/ChdkRyyfqtkwJEx2MNxg
         fnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=4nZ5T9cMdKhWlaoNeMMhrxt/eq5mUn7eiiPvf1i1Ivs=;
        b=AZibJWN51So/1+kx6sD8NbqaI8hV3U2kEMdTCUL+nc8h9dcROIUvP0QHJ7UeKSga9v
         oWSapUMvcfaRpWxRAmMwpMUzBt4ZU32h3HRMOTbM70UpWogQfhyc9BKaRqe7ZJ6Y6kXC
         e657xL8z6mVj+U6f54BaXyQmFWupT6kMqxE3pC1VlEcS23/Fs6bXUV7K6/jWZLsV59ui
         DO3QwU4L3/0M48W5Jeagc+9Y/Dm9bdWxaOD6Y/uWhPo9q/URdy4/hass6YT5p3phZWa8
         maeRmmUJmaB4IAd1sXYBdUsfi5jMhfWFzGAdXajdoQGaKNGHZN5LpjdwGqtKjWhMAmhW
         Vi2Q==
X-Gm-Message-State: ACgBeo1wZ9Pgskki3v1MdbPs6UIA59Ep+tZpJS3oIAsSGApH+nRYam+5
        hEgOJyoYecRHQKxwbwcKO4/QvPOmIaw=
X-Google-Smtp-Source: AA6agR4tI8IpFdHMeKO2CQ9j+wY2hcec2imf1usfGhv3eyqlGUTK5asd3S+2jSYMTH2HAck/XD6uSw==
X-Received: by 2002:a1c:7c08:0:b0:3a6:2569:4986 with SMTP id x8-20020a1c7c08000000b003a625694986mr10608626wmc.117.1661885423687;
        Tue, 30 Aug 2022 11:50:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18-20020adff2d2000000b0022542581800sm12012667wrp.45.2022.08.30.11.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:23 -0700 (PDT)
Message-Id: <1e43148864a52ffe05b5075bd0e449c0e056f078.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:05 +0000
Subject: [PATCH v6 02/16] bisect--helper: really retire --bisect-next-check
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

