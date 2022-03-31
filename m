Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F7C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 18:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiCaSwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbiCaSv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 14:51:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE0A1704F2
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h23so1024136wrb.8
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fLlo4FesdHm9Z5Pf68tm3qfzTDs/F5UeG8LpLQb4aFA=;
        b=lXpNeBSX1DfflyLctf5ASbQAiuXcAMCZ5HpCO1oVVaNQ0k9dMN+kJPMTVz9NEK333y
         52XvmkQCElwPqN7FvO7C3zuhN1vlWcQXCNVDcdROMyVrG9QsHikrBJoRowtud4zvPtxl
         OKPzIuBSTBOG1aHMsIxznnjlP9fAfldMGNHiFKOP+GjPpk7DAxGb/SMrao969miMjFcA
         q8yhFjONs/txIur13kQpXgBPso27NzFlLlQXviIdsdgx09kb7r512WcYzbGxA2sgFuMj
         3lPdOQ3rUepNu7jmjAE4OtNAJJp/TuX26l1uDvwihujGZw7dC9vsoibRy2Gx0dNOTXkb
         hb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fLlo4FesdHm9Z5Pf68tm3qfzTDs/F5UeG8LpLQb4aFA=;
        b=4Kc3XSogzZ0iEAh9vK7K4FP+JVP4q9W66SkNEz9rJ/sM47Y2BhChThSyzkiemsj1Pq
         sBjzRctnpf9env3iDJYjJC5Iu2S3fYZvaOhfPolzYMFSKkS4DPUOLHm3j36Fx+Zxc38T
         JoL5JLNsHxaHEhrMbvBc9XZU8sIwnPl79bbrGdscAoVAfiyqhoVM7bPDO4qmzQaSkWkm
         Irs/UihgsvjBos/1A31w7MoShKelLB2oi+RDt30ImX8d6l21slBOoIJqUSwemozQoVI8
         iB28rexObP0EMKTArSm3UccU7ogeqcxtzbsbGS/4U8tERVlEhuAT4TeMqNv8cOJ1K0Qn
         09Bg==
X-Gm-Message-State: AOAM533X/YfF0z1Rpi+MenQjXWikUELp8RLsvYKnVwGcpIHXgd65Yr4k
        gmHmNBGFMvqLChXHxBIz9Q6pjV/1KNk=
X-Google-Smtp-Source: ABdhPJwJxCBhAf+gIxXcpsZ9IeiRyDzztt9svfaiztVPLLfjjt6Hv37I77srS9q+uYQNClhTWCfY1g==
X-Received: by 2002:a5d:6441:0:b0:205:e06b:f7c5 with SMTP id d1-20020a5d6441000000b00205e06bf7c5mr4981646wrw.174.1648752606620;
        Thu, 31 Mar 2022 11:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b0038cbd13e06esm8391392wmq.2.2022.03.31.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:50:06 -0700 (PDT)
Message-Id: <306858373ccda2da80fe13fe3113ed793db56e91.1648752601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 18:50:01 +0000
Subject: [PATCH v2 4/4] branch: remove negative exit code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Replace an instance of "exit(-1)" with "exit(1)". We don't use negative
exit codes - they are misleading because Unix machines will coerce them
to 8-bit unsigned values, losing the sign.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index ca7f0c3adf8..581afd634da 100644
--- a/branch.c
+++ b/branch.c
@@ -263,7 +263,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
 				tracking.remote, tracking.srcs) < 0)
-		exit(-1);
+		exit(1);
 
 cleanup:
 	string_list_clear(&tracking_srcs, 0);
-- 
gitgitgadget
