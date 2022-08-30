Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A158CECAAD8
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiH3Su3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiH3SuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1117AA2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k9so15450595wri.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mUxdgs/oj7+z9X3ltpWKwdv75dd+R2a119akogQaQkk=;
        b=GSm9XFO2N5BaxVzf5R8x24opKKvkv08yKnZxAJOhpHFKvESNqmL5eCOSva0yIhdOUg
         jHWT5wVng6qAGVIn1WInvIKcTqUD0ymwqGLQjDBI00kAKG01AF22my+eoWo8jRZ8MhWs
         SiPopZCRrOTdibihItp/imr8QdN8QRxisW517a1UdFtsCB5JC952P1L56tATos3ODAQJ
         jRwL2qHPIAOaO6KpdXR90VbVJidZUm3hVxSrymWJXgp/+FXSmb+ObTd3R+h7Tnpd/ykg
         TH1E+9qxItd7eZrcCxns29iIEL4iY/rG0to4+pHFUmnDzmkhuXu4HAlAmOj3WLuc/w7m
         0WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mUxdgs/oj7+z9X3ltpWKwdv75dd+R2a119akogQaQkk=;
        b=I8ZG6Tay0kLTJmTclXFX9JfExD0rHbv8aJnZ5yXPDqcflXGM8AjQbg9y0HvMjE/HEW
         ekfWhfxq9U7HOCNqJ3m5OmxrALZbSrfbesnRPatszToC5nYvzIfyDCCbrJv2zOeIwCS6
         qwijY9BkNLJ6jv6JPbYmDTqg3GgW7+5o73Pev+LyOl/KZXCFA6Wx1Xusdpybtvn2ZZXE
         lXXs4OnckpDAbNAsnqVkEQF8uly7W62SsjaH/wOIxj3TFXvHah3rIwdCwDohhaL5zaqO
         OVwrJvGYySsWGaKnEU84eaTZLz9x0O3hSCHDVC7dE95gkHj8+xnlr3+ptG8JhdZxPCH+
         eIFQ==
X-Gm-Message-State: ACgBeo3/wK4EindyFwhRAt6r9nqz0TSQJ36ROPUmCiPXUD+DcWiK3Uz+
        0IbEAejup94Lx4DeaT45MMLsMVYBz94=
X-Google-Smtp-Source: AA6agR7XtP2A/fg/xq4bXWWJDEx5gms9Jx5UQiy4/7ppTDhH7+Iw++/pe0a7p5PBJHctZ/YYOBGpyw==
X-Received: by 2002:adf:9cca:0:b0:226:dfa0:3fb7 with SMTP id h10-20020adf9cca000000b00226dfa03fb7mr4451050wre.412.1661885422832;
        Tue, 30 Aug 2022 11:50:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b003a5c064717csm14574929wmq.22.2022.08.30.11.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:22 -0700 (PDT)
Message-Id: <05262b6a7d1b20a0d2f2ca2090be284ffb8c679c.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:04 +0000
Subject: [PATCH v6 01/16] bisect--helper: retire the --no-log option
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

Turns out we actually never used it, anyway...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7097750fc6b..2cc69e1eee5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1292,7 +1292,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
@@ -1316,8 +1316,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-- 
gitgitgadget

