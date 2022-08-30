Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94338ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiH3Sue (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiH3Su1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE5D17AA2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e13so14496899wrm.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fputxYI2HUfkFVNx9yxXGsgXMgIUSaa9LOnIcfF5Q2c=;
        b=MqlEfxUm6rx3NyT12Fb9IkeAZ4zMBSbJqqh3aBjJ1b24/nI7wyoiRgvS/M02xeWOA4
         eQXFHtshgy/PMVCDIX0ErFHD74DFFFPXWWDqh1NJ6NX/W3MuYNDZWTQPGKHH/hRMYvEf
         iQpKZ66CMfetSiXDpLeXL+hro0kmWQygDgCfe4FHPRouikEIp+S+E3O3g+X5S5ZtOvip
         8rFvHqAA5GejvlanNrYYt/Z84XVEc57L+p922ct+hnKXstDOk/gsmz3v/5JwLz9nO1aj
         RBY5YYlN1CyL9S3YvUcp3V1dXp+GlkKqYdlVkfHyFzsNWpMbadRaHGgaYPanviTO/i90
         TmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fputxYI2HUfkFVNx9yxXGsgXMgIUSaa9LOnIcfF5Q2c=;
        b=F0rp128ysSDIkG+uOQqsaUKHWlxUp+sLi4+tp+RSMaCBkponF6yEYMNqmJ9iaoivIh
         KHBpvIZPJ0A6/EqQehgbcLlUs39fGoTr42JH4Ji4dFiTsPd0av+f4yWNPo59ngB0Fbhw
         ZYdSpQTMCVFf7bbKM0K2eSbuk8A1jJoM/AINf5zWAgNAqFQSXtj1EU4F+ttH49gMSNOo
         NpPVOn/YCDF5HhGSf9XJyPFH6SvnrJeHjm/JRgfcSjfzdAAZBN2uTh535K4j5h4OJBiH
         790yx7Ku8dlPpnFaUk39g3HMlRD8lumH5GDMeD9DmNQk9cHRdQwVYP307M5kCX0Y2cuY
         /c8w==
X-Gm-Message-State: ACgBeo19i1GZ3+6gDybATuHtHgUbvCVST2Amay+qw8AhNHPmxgHEzJu0
        UnzLPUm2iD31tBxAHog/aa36iW8eDGI=
X-Google-Smtp-Source: AA6agR5V35CRL62/4WFWbIrE8lOV3Ou2yBDawy49mr2GMTNOPBpIINz+2LLjoGv3yIKRww6pL+ZIVQ==
X-Received: by 2002:a5d:47ac:0:b0:226:df12:412f with SMTP id 12-20020a5d47ac000000b00226df12412fmr4978997wrb.675.1661885424633;
        Tue, 30 Aug 2022 11:50:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc18-20020a5d5c12000000b002253604bbefsm4936802wrb.75.2022.08.30.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:24 -0700 (PDT)
Message-Id: <1a1649d9d0d5739f76db82fdafae7e88374bc8a6.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:06 +0000
Subject: [PATCH v6 03/16] bisect--helper: really retire `--bisect-autostart`
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

Since b0f6494f70f (bisect--helper: retire `--bisect-autostart`
subcommand, 2020-10-15), the `--bisect-autostart` option is no more. But
we kept the `enum` value of the command mode around. Let's drop it, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index bdf7ce18d7a..aa94c25ec73 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1282,7 +1282,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET = 1,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-- 
gitgitgadget

