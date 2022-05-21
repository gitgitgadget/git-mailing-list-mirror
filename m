Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D70C433FE
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355307AbiEUOtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355161AbiEUOtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCB6CA9B
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m20so3814285wrb.13
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m6lfHmTVg76/Ms+dk9+LfC4GtStf7+QPlzIEK1unnOY=;
        b=PMJWfqWJtaom4R/N96ytUIbs53iwtPQ3YMdiloyXlwOi0fhzhYIgnd4hyWcrprl3VG
         bjIfcdLXLUTad7974eql3L6aDaJYCZj1E95NeUcP3ceV8FFSuqo9xlcwQzxCLniWF8NY
         YPwiGe240WlV+99LW2N+qoMGTpvU4o1tvQ3huedVoyO3SLgkN9KJV84+SvqTJT35XzR2
         sNHcWUMahMXJlz0BDsZT1hNa7a8OYY3HxqwhThbu0/7RBTkbyNGu6ETZp6U1iZ3uVeJw
         IO/IAwlT3cC42Gmr30rWYIwOpoGyuNnEqj/cn0RxHl9/+wCTXYX5CQZfxtJrWcG7YtG9
         Z9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m6lfHmTVg76/Ms+dk9+LfC4GtStf7+QPlzIEK1unnOY=;
        b=5+mCuknjifORtXpodk+cJiOvxNyUbOCOQwgxf2PX1lnXGbkrGaxJkHqldBsIUJP7CJ
         atXbfmTYmEttJKw3kYJq3st3zNBMXM0C8H53xJf7mmQ+9NfTTyGc7TmImnSwTI/fB333
         ZO1DWO0k+uy8wz3arFAc4V6t9ZyxjO+S1K4r+C808M1WiV4/Gem67+ltw6Dgcl1sAGsg
         hRei6QZAkNE4waxsK+xtL//iuTm41VxZOSFWSNAkR0SDYa1YpNMtU1C2L99FsysdTGFY
         Ab2bF+OZlhA7n1WW8n5Z8nSqXcs1Bu7VJNl+eZyUhOqZQ17744eG/kQ7P+bUYsJGlPmE
         IMlg==
X-Gm-Message-State: AOAM532ft7kuSXDZw7lfD6HBuu8iZhEki1Z6P7V6Qk8gS19nXBHwRlhH
        mkbxLx1jhcSd6ZK11l9u0sCoNIOf9Z4=
X-Google-Smtp-Source: ABdhPJyMvxQ3omWcz/dayBSNKFp2qE9jg51/e/UnO7hWWSCVIks7PAPzLeZjlgPIg4r5Z/0AfjOXmQ==
X-Received: by 2002:adf:f550:0:b0:20e:69df:5f05 with SMTP id j16-20020adff550000000b0020e69df5f05mr10745009wrp.194.1653144552128;
        Sat, 21 May 2022 07:49:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020adfc5c2000000b0020fcd1704a4sm1318079wrg.61.2022.05.21.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:11 -0700 (PDT)
Message-Id: <abcbc25966ce101ca1d5085c8ed22abddb65ce5b.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:54 +0000
Subject: [PATCH v3 03/15] bisect--helper: retire the --no-log option
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

Turns out we actually never used it, anyway...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0f49f52ac10..39556d60eab 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1290,7 +1290,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
@@ -1314,8 +1314,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

