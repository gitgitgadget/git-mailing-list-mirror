Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AFFC433FE
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiEUOtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355285AbiEUOtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242726CAA0
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j25so14925267wrc.9
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O+l7uPKj2yOB/MlovFVopVk+H7ZTAfVlgNsDTtydHvA=;
        b=MfAtMbqasTede3PRFfpqnYeJNEVf253VxXDj8QlDLoQUNwWgj+ffDdU9dZXZzroxDY
         bPdrpqffhOBrfkMRQ/hPHMcTzUNEgcKo8jCN+v1++aruPVLxhL51+PWEc2FLwoilxG2N
         ICySJAanxGDsyVHu5QsGwQOTnK/z9xawmIqYmHzMZtJbfbs6uNXqwNs24SER4+6M0R87
         VNWwspTZejkXpJ9QjvFMmj/gYd25VoQxbXaFOrqBzm4s/uta0kV3Mdf0G6kOFkldcRJZ
         2uj0K18w0r2WPyT2/mV9UJSLtC5HR9OqXeSuAykLLq5xlNFuWFMkX7hY1Jk3JKG6MIKu
         1Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O+l7uPKj2yOB/MlovFVopVk+H7ZTAfVlgNsDTtydHvA=;
        b=MpH5ryx9GXPB0/NggCIELnMVMDb0/zwRWSb5F3dDa34xvj5QBFtADZqqtshzibRZ6M
         +I5WDd6L7pqihTqg80vgutrG31Hps6EKsiojZTgUlzEOptHy8ff7V2dwWmdw4gku7ZT8
         2DKMNYDtLgLB/W/9JQqRmoWHWx8joYdbafxVjLeamIochSSjZVofSYWMBLj8pjX9GFqa
         5xc88jOljnBUvmBIyvaHkYlnsej5XWNNS77m8YxkHszpHn8ORtlvxxN2/QEjd9HOcZZv
         7zlpsNgEDy4j1EqR3tg7GlXvFmztVLqEfjV/8gZ6i6+tuEG7/D4Rdl9pV2DK+LwVZH/R
         b1OA==
X-Gm-Message-State: AOAM533xeMo2hCU9bvGguwl3/PbX5It7JNpnb8P7LIdQb6roYmXL/bs/
        E5o4pz0p3iYfQvTS0T/+w9iUMtQ3Ktw=
X-Google-Smtp-Source: ABdhPJwaosZl+S0iiKftWbGwyFXrbD55noMcNJ2hcnvI+T8ZeEEaYNhtJGnEY89HV2UhtsNpQOLaFw==
X-Received: by 2002:a5d:4d8a:0:b0:20d:2ba:7db8 with SMTP id b10-20020a5d4d8a000000b0020d02ba7db8mr12479006wru.624.1653144553263;
        Sat, 21 May 2022 07:49:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020adfc846000000b0020d02cbbb87sm5342125wrh.16.2022.05.21.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:12 -0700 (PDT)
Message-Id: <af60ef1b5a40b97eed6b07248af6600ae4b77841.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:55 +0000
Subject: [PATCH v3 04/15] bisect--helper: really retire --bisect-next-check
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
index 39556d60eab..658390952b2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1278,7 +1278,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
@@ -1294,8 +1293,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

