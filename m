Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751BDC0502E
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiH0Mo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiH0Mot (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277532073
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq11so4737564wrb.12
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=5RcJoZRTa7C6GfnWGFEECNH5E/ou2jLePAPsBm7pvOI=;
        b=p0SAzbmT382a5eCHQz55P+swwWIHjLeXitb0VoLkTTQucpdTKX54gVioTZ61vBGFA3
         Kc8OAA8RggXWQ9GaNBwvG/vQr0lZR2rpPsjTAGCphyRBYCgcDV7e8Bjypp89XOLWZYki
         SGbaP1u6FzItFQRoOeGPyruGhhdZg1IDOtM4cqjOAlCyMHZB6zmc61HbBi5aiTzSDEzl
         4gy8OK61mC4Yy6w6JLA/ntEQsYAcmuAYGLvInBMFCaVrquIn38afA453O4sKyMm8U7Fh
         2vlXF75Dareioxw/fdLJJDsaGurdImawmd2Z7ctqWMl2op3OeeAv4YLrLCUnSxssOCFH
         DQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=5RcJoZRTa7C6GfnWGFEECNH5E/ou2jLePAPsBm7pvOI=;
        b=hiu/PkUuHx/2LwTOtuzHK6bAp5CrYhTv50V+B9yf1QqcqzWWDzxD+c8eIOTb1XGw9G
         lk0+GWm9ETaiQ3Hf8js6pR2J59JtdbZrn9K+0qtLGd1LGY6VxAEZBeuwBINWvJ1rhMkj
         lvGICDnhu2NKmcjOA+NLaQd3voKFgRV48J+8hmzPOmq/9RE2QEL1eCEAq+4e3Um1udU9
         JkgCZgOhX1k+7F1F0j52rMDal1SfLafignBbt0TKXThdchltIobqF1UI6aTQextnjouz
         xooglBrUZj4U4cBZEDGSbqMRlwlsXCg6o64LSatAUfHdtXlAF2fZG1SgUauv5h5MkpLj
         ySPw==
X-Gm-Message-State: ACgBeo2ApZsWpNvS5gLnOoH+j5fvNcG5nyfb7wRfQ7QRWsmEPg0kzGhi
        m5oC7xjjEuU1QdV9ROnNftta/6OxD7k=
X-Google-Smtp-Source: AA6agR6y0nYqvjvQ89mTL3m/idd+H82tgBILC2CpgCuAJSmsLXKCdnwyGtH7GfaXb4Dd6BE5TESozg==
X-Received: by 2002:a05:6000:1210:b0:225:5eeb:fdf3 with SMTP id e16-20020a056000121000b002255eebfdf3mr2193312wrx.334.1661604281618;
        Sat, 27 Aug 2022 05:44:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b003a1980d55c4sm2974824wmp.47.2022.08.27.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:40 -0700 (PDT)
Message-Id: <8a0adfe3867157102e75d53ed928603ad634b904.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:19 +0000
Subject: [PATCH v5 11/16] bisect--helper: calling `bisect_state()` without an
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
index 5cf688c0dac..3f333cfae76 100644
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

