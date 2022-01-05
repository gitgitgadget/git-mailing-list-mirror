Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A9C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiAEUCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbiAEUCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A50C061212
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c66so371322wma.5
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=6B3Wz5JTSb7Z5RBwq2lLEIjujXvQYK+iJjyySfyByyA=;
        b=R2S1btn2AjRK7b1/RCoQFj2/8o8eCav368+PvOCozgy03ji1L+NHhMS75nj7jRVZI9
         Fop1alnUkNRcByV8jWIIofNIpORrKJDMn/Cc1s9lyG+dEMUvJfLUKL0CeFK1auZLkW9G
         i9zF3uhkydsFYR78e43oyrVEzP1lvpqtg9iTXzkF7BkPcuk/s+55rSANcU5LMMllDHBr
         lkMhf1ZX2RucsdXjhGqppwJ/B7X7V62ViuD862NUYuZJoAiotEFiDrnadGwOd9T+eCIp
         XAk6pdBdxUaBDH9+UJV43K1v1WtbugIfa+38NtBUlhb+pUpRCH8IIEW5uPIIYPCppnvE
         YznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=6B3Wz5JTSb7Z5RBwq2lLEIjujXvQYK+iJjyySfyByyA=;
        b=K8G3iLl+vX0sCJjonuFlJN8teDOtSVuJWE11bvAhsxajm29TcyLTHaE9aFDqwHEuMn
         OqKrvkRU64OPp/PBrw/3V3Jgo7coXGbbjvwGyx3B5TbLmT0R5o7dT++0RjQ/59GlwOqA
         U4FTma4Gkv1SPrcBKYaiFu3EADNDTlwI78t1O+zf/ndkaz9YoATqFh/F8pbFvEor7Olf
         so0InflOYSw0YXZ866VYNSNgc3oru2ATvifmPeSd9AAJ5ybMZijhQwM4XaytpjUeZ+c9
         3x9uEvf4iowYKCWPz1E5mDX231XY/yicvNJ8luOBH5aP30v2p6nAOLVA0quyCKn5zVJp
         XQuQ==
X-Gm-Message-State: AOAM533IiSyVcJI92Ts+KF9l+z0358KHOZLI2BpMF4WI7tsBBrdyrVDf
        DwZ6H61fwPI+dUSREVAoVkDeLOxna9g=
X-Google-Smtp-Source: ABdhPJytWiU6JZ+cLBMhOntRtTBZuXcCqIHyQ+gs/bSs5YX2zMGnFwdkgDCltGBg2XaHvLNQzS2C2g==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr4202095wmj.168.1641412949720;
        Wed, 05 Jan 2022 12:02:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m35sm7469973wms.1.2022.01.05.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:29 -0800 (PST)
Message-Id: <ad58bc8d8a989af335f271c00a55805d9a7f7d82.1641412945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:18 +0000
Subject: [PATCH v5 05/11] i18n: tag.c factorize i18n strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/tag.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index dfdcfd37956..8f372a41078 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret = 0;
+	const char *only_in_list = NULL;
 
 	setup_ref_filter_porcelain_msg();
 
@@ -542,15 +543,19 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	if (filter.lines != -1)
-		die(_("-n option is only allowed in list mode"));
-	if (filter.with_commit)
-		die(_("--contains option is only allowed in list mode"));
-	if (filter.no_commit)
-		die(_("--no-contains option is only allowed in list mode"));
-	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed in list mode"));
-	if (filter.reachable_from || filter.unreachable_from)
-		die(_("--merged and --no-merged options are only allowed in list mode"));
+		only_in_list = "-n";
+	else if (filter.with_commit)
+		only_in_list = "--contains";
+	else if (filter.no_commit)
+		only_in_list = "--no-contains";
+	else if (filter.points_at.nr)
+		only_in_list = "--points-at";
+	else if (filter.reachable_from)
+		only_in_list = "--merged";
+	else if  (filter.unreachable_from)
+		only_in_list = "--no-merged";
+	if (only_in_list)
+		die(_("the '%s' option is only allowed in list mode"), only_in_list);
 	if (cmdmode == 'd') {
 		ret = delete_tags(argv);
 		goto cleanup;
-- 
gitgitgadget

