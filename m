Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7634C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347300AbiEUWTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347292AbiEUWT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C275001E
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h14so15921726wrc.6
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YarBIJlPue3L+upbCIRgj/fBWfMbTxyWkAMZUZCRg3U=;
        b=Xkfmhhh2LtuI+h+nmQ5xcMMPFRXv1Kbb2V4HC/P4tRXR1CqhtJ9XIXj6ZJpISHCFWc
         H4dwsRH+QB7WyQMViJBcXonzbEBTqdk6+owpgo7KgpOcYqoZB3AtavcNRDLM44/Lcinn
         ONiUkXuulEOUOSr9tB7bOhaPpsBOmLWF0xj90vzKxNDijucmltHOAMlKaGZccc2LlnCz
         41IAsXqCLGo2EOw57d1n2/33jJlugWCHb08Lo7rdK8vc3FsLpIRSD4hXvYapX+r/cAO4
         sVk5zONF3Uj6pKSLVPhyP5BOAK5Z5exkJP74JLJuy79uxdaUNEqaiuHCHUDL8+v7W2Ps
         5Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YarBIJlPue3L+upbCIRgj/fBWfMbTxyWkAMZUZCRg3U=;
        b=lsGeROE80MQq2UGvT4Cku0eXvdL63kianxpiPRHG+UU0iTpQQ69kPwAjKHeg6A0Fpo
         mW5qPf+0my77cWjTtB9x44HaIIH4byaApoTUH3hw/nO+tUWFk2topDV6EktQdWBigvl4
         R53Io1KvMiNhi0JAr/vekjmM2xgmCBr8eh5/C73vrlJE98Kj9EmH6JFLCuCKDi+dRnNA
         1U1gqr32/z4aPxZs0xn3fWwe3ZEUgGY7E2yV3Sbi3SLMAJfve5ddz3MJmAQHZRPotO6J
         ZUeYNYr2/L/0JtCCUTR8qj1gpGNrzm8wYXijOkM2x/8Le5QJVmf/znU964Q0iKIwYSYg
         qkhw==
X-Gm-Message-State: AOAM533Z3IdUK1iMYco0SpRCpOsLqugIFqdL75BAB7+rF6VANaXn1cwk
        nVxUWZhPjOjUhWetH6a+hQ3OV0EPR1k=
X-Google-Smtp-Source: ABdhPJziFSA8wS26riQZPG5WN35PoyU1zDmEljOw4WoU0RQWo3ULHzs3Gxq9Mt5bCgySixbcrQ/+9w==
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id e20-20020a5d5954000000b0020c4d551388mr13391759wri.90.1653171550097;
        Sat, 21 May 2022 15:19:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020adfa742000000b0020c5253d8f2sm5916643wrd.62.2022.05.21.15.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:09 -0700 (PDT)
Message-Id: <370b08d3a1154ba3d17b91c0afc5ff015fa4b73c.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:55 +0000
Subject: [PATCH v3 11/12] ci(github): mention where the full logs can be found
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The full logs are contained in the `failed-tests-*.zip` artifacts that
are attached to the failed CI run. Since this is not immediately
obvious to the well-disposed reader, let's mention it explicitly.

Suggested-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index de6532ee8cd..2f6d9d26e40 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -177,6 +177,7 @@ then
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
+			echo "The full logs are in the artifacts attached to this run."
 			cat "t/test-results/$test_name.markup"
 
 			trash_dir="t/trash directory.$test_name"
-- 
gitgitgadget

