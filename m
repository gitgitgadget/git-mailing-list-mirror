Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F5C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiBVQbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiBVQaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:30:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBF166E26
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:29 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y5so1479145wmi.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nrizBZKt+VyuJsDADoVTARJpUUkpuKeTV9I+dT0npuQ=;
        b=ofEYtFoyjvX1e0igRozxy0jIutjtpSSFEmPVRUZ/g1tg0SCfGsdLf+k5DBASWiVuyU
         bcBolmtLPrbcGnulf3l1elLZQiPVFzfBjtZ1GGAwBESOdLhcahUPIeeAqXaFnvCuPCof
         Xsfzcu3TLwBWrLiFIJ5kaixDdXnbyQHJ+WQ+uIFN1PMP6qIt4Pm1b2R0zJN4d3g2N255
         Zpu7P7GeTRksRgY4XHvDKX73c4bLtjHLUYmZA0NRVLZ9Zf9kvs1AmpnZRtOb7K1J4u5Q
         ZfZ8h/ovyi/mv1iFhlSSY2N2x6Zyh3MTxCn5IYc8h2n1CD9WQzHbAfwUs4Z16lPpGZFA
         qZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nrizBZKt+VyuJsDADoVTARJpUUkpuKeTV9I+dT0npuQ=;
        b=BzT2H7cYqeVY2aYmbK4pJuSIa34ybueR/e2P38e6QNj9vroo2ep6NmaLmokW98H1Qw
         F7jQsdMdDpj0fZ/mdgftl2hdXMB5eYZZwyAW6mL5vUO5zY1LlGVVb4bGAw/bMkB09jFy
         yRz3z/Fg7MqkooN8amrcTIaOxBRpxWRSJCoHjppj/Uhgc+XqKIjExz13dd5VScARhc9E
         31Njns4+1WSsMCH/33xB6g8zRL3rVxeRTqRRaG5Tt5SDXS3/g8wOXDz1KzoR14JpNMcI
         QmriDjLtKY8jKjIc61LpGZjPzKGfQod+jKNHl+aOr0b80+lzRhhA/V5Vek3vzbyuzxlT
         L5OQ==
X-Gm-Message-State: AOAM530/5HEkPH5/LtROfDkWjbqfkrSMacVlF+CxdFHtR67wjPhREVU+
        tI7KgDRNHml7qEIdGP63njxKWGqhH5I=
X-Google-Smtp-Source: ABdhPJxEvOjKvGqKnxMv+bOJjJb2xWP9c6oSwJPlMcSXbuvw6e4Aqw6Iyw1p2s5DbS1QpPqzJMKldg==
X-Received: by 2002:a05:600c:4c13:b0:37b:c4c7:26bc with SMTP id d19-20020a05600c4c1300b0037bc4c726bcmr3996196wmp.169.1645547428189;
        Tue, 22 Feb 2022 08:30:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm24261791wro.104.2022.02.22.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:27 -0800 (PST)
Message-Id: <b914fe64dda22697123446a4490379cb6511af71.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:13 +0000
Subject: [PATCH v2 04/14] bisect--helper: really retire --bisect-next-check
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
index 71a6f8f5192..4ee708e34c7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1170,7 +1170,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
@@ -1186,8 +1185,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

