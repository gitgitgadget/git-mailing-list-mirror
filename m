Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE7BECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiH3Sui (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiH3Su2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505963DBD7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j26so6251789wms.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oaO05srWf/I52sc2LqNWTDuaqmQesAxh5GR52Lgsn+E=;
        b=RZ1Rw0BRPSCUPudP4g9b2zMksAntN9lsq9LjTnb6dUBqMS7u0BR31j/vo6K1Xlt0aJ
         XdFKdOQv5lXhEAxlaFZmOGwOuHUtRm/7JfhrrfwOui/lq5VSFWtiB0oZq2P7Aman1QUu
         q1kVU6Ct1Ib9NVIAYLO8/RCo6Y1MZQdpVZW1SJOR7uiR1NhjE3rOf2OuiD6s+gsh9KpB
         EPBYLyBWW+BCGUwe02qQNrnWILFn2y4s1E5DO0Tkh1lEj3dl+g7ZuXqcL2euMSPmgsh+
         cXX8XaxCEnz/Na1meHZm9LpKFPj8BiOaDZ/ynw2sN3V7Z4YwheFQlWKJiCrnUYzfvog8
         NBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oaO05srWf/I52sc2LqNWTDuaqmQesAxh5GR52Lgsn+E=;
        b=wwPwjVZCJpKyMCSKGQjQrpzC97G6oOiH8vt6RlaozLfqmOzbeAPJ9EPbZZXEOeTlP5
         A7VSzhT+QCLSQhpJP9Yx29R663RXP5UBxQf4/GER2m5lpVdnQfOgsMWmhoY1tPq1SVO5
         e5SgjoQpQIw645PvaV/HkYyGkn+Soj199JFFU4+cS7BewXKvn6r3/Jw6if7NZAuKmCNI
         x8hYEe64qyW0AqY7PnL6HeGEwU8LqRKsBhtPBkrc4x3vTpyS76SfNIdUpQwhIu6SM2ra
         Qp9hykx4akL5VE0KUUI5a+RAvkmTow9gp4UT3fAwGC/OAG4WixOpiRI/za6O3LLJVL65
         3uZg==
X-Gm-Message-State: ACgBeo0MUck0Cz9AF2SoCq7FUuXZaOJ3mVwUBOtddIRo7rKx4C6vVlFA
        c4z95ef0q9xkHW1vwGjgbAuXRNxfCLM=
X-Google-Smtp-Source: AA6agR4qu3D3iFwWzx9XsK3S/C5uB3xrEK/4Sqht6YS7CimobI76Ezvp2WlFOdFfyymrT4rLvpoMFg==
X-Received: by 2002:a05:600c:350:b0:3a5:3473:1c23 with SMTP id u16-20020a05600c035000b003a534731c23mr10811097wmd.9.1661885425647;
        Tue, 30 Aug 2022 11:50:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a62400724bsm15750620wmq.0.2022.08.30.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:25 -0700 (PDT)
Message-Id: <9ab30552c6ae6a5d0a85d7a7bbdd10af4a4cf7ec.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:07 +0000
Subject: [PATCH v6 04/16] bisect--helper: simplify exit code computation
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

We _already_ have a function to determine whether a given `enum
bisect_error` value is non-zero but still _actually_ indicates success.

Let's use it instead of duplicating the logic.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index aa94c25ec73..2f9c7f54f3f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1380,12 +1380,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	}
 	free_terms(&terms);
 
-	/*
-	 * Handle early success
-	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
-	 */
-	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
-		res = BISECT_OK;
-
-	return -res;
+	return is_bisect_success(res) ? 0 : -res;
 }
-- 
gitgitgadget

