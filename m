Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE0ECAAD8
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiH3SvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiH3Suv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C634BA6C
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b16so7783307wru.7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=DT36J2AiUWjj01U72IlyGg7tjGHbNeTie3KA+xZ3VDU=;
        b=epez/TThT9Ci7y9rrxa5ZW3/j51uVhXvvUJhIhwukkGlLmbJ0/A5CFHRw2HBoAPm95
         0F8XR30jYLuzd0ePGAfZwHU3wPtVNqWHTTHks8H7CYR1bC8nvMl6v66Y6uWCSQUqvizR
         fsTG9vBaOVTl6OZLQ2XkkNF+nEB9TIZ/oz5Pz/X4ncp1E5H/5hmCVmREXpGkq8b1CqG8
         jLhdp4K1Ta+ND8wX7hU8rxNI8/cltJFublEjary75a1DPHGjU1VU5AOkPKLgFUDUAekJ
         bILcKB8BAHQOxBirEz4w2AbpkjEmHJrVQvaBHYUsiCzDTInHzZ99FYuYRIsbClT/zFNw
         ABpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=DT36J2AiUWjj01U72IlyGg7tjGHbNeTie3KA+xZ3VDU=;
        b=r6PzRj8SJ3pAMIiz3NCX3Fcm04pGQerFTQp4XynlC1XcRUioViEGOzcQ+NDEOM1PVW
         qQXNtUDv/RaHG/FTSAWwcAZa5gp3X76F5dALV063BEppeLrb+FUrk83o5Lt4LFoPBWdB
         UfQ3wWaPW7UaqHU/i98J/Op310ZuMqylMBDk7VBporAgJWsODzWsGMkWox9kzPyZ9QSC
         8CNDJS8IoqBWB3PrHDPCXsQhdpMqMr5p8nUKpaddFy7ePl5mbCA1f4NvE5muXs3LpgWR
         SVcmNz7/uaX8aLMqVBvCWVUB3hTkxBPjAYp2dMKnHIFSQ4DfvNPmN2SSHdw1RB1vSaGc
         EwxA==
X-Gm-Message-State: ACgBeo1lVLem3ZrmhDnJ7dT22c2dBKcrvrOd+HX5c0KvcBvgJYX9ZGhP
        KVcnHiKl5G9nwDzwit0DvhAGPMG90S0=
X-Google-Smtp-Source: AA6agR4kcZ97xDPhKAXahZ+pUDpSiyW7uTrQOPaTbc50lQwS+NBIptqaU6myhgpjAAJbRwhwRegwzg==
X-Received: by 2002:adf:d0c9:0:b0:225:8c08:288d with SMTP id z9-20020adfd0c9000000b002258c08288dmr9933902wrh.213.1661885434238;
        Tue, 30 Aug 2022 11:50:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm10456554wrs.74.2022.08.30.11.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:33 -0700 (PDT)
Message-Id: <3376b4508671491ff5c3e770ad3cd17203208bac.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:14 +0000
Subject: [PATCH v6 11/16] bisect--helper: calling `bisect_state()` without an
 argument is a bug
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

The `bisect_state()` function is now a purely internal function and must
be called with a valid state, everything else is a bug.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 05fe619c47c..ac3b2e5b61c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -997,6 +997,8 @@ static enum bisect_error bisect_state(int argc, const char **argv,
 	struct strbuf buf = STRBUF_INIT;
 	struct oid_array revs = OID_ARRAY_INIT;
 
+	if (!argc)
+		BUG("bisect_state() called without argument");
 
 	if (bisect_autostart(prefix))
 		return BISECT_FAILED;
-- 
gitgitgadget

