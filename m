Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A783B211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 20:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLFUVH (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 15:21:07 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:44588 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFUVH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 15:21:07 -0500
Received: by mail-it1-f202.google.com with SMTP id x82so2232548ita.9
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=d3+vQhSqyaxygJlzhZeldNtlmUKr6M3Gb3T2Z59tjnY=;
        b=tI+Qrk2RTpqrguLl4P9iAllPhkdklXk88Fe+ShdpG4KKJDcajK/jy6iwjCOeNmsPYg
         bJ/AknrZnIdlYlpaEfmDn0FJYBHbV5f5EbtU2iwmyeCVT5Q8tGeGv6rUac42CJLtLxq0
         JjBkuAcsCG/z6twuaWSiRSlz+Bfa8bJskTWfTD2rTNmS/Rmk7aVMZ7qZD0kfwRedc4+i
         6Mcej4R4MlXEUgiepIbRAyefnPOmFyUbJ/p3Pe9t1NSATPUcFGfnt0DzIJghFalUQXqG
         MW/soMnqMA2wi8vIf2tV1Ti7i5iqOSw2KB+w3oLt741LFLDCDw5oVDO6JQb6/m5JuVbF
         ENtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=d3+vQhSqyaxygJlzhZeldNtlmUKr6M3Gb3T2Z59tjnY=;
        b=WmlTWuQc7lLCIQWNaeCs59rNWabfCewp3atRUQqC9qxLDM4+Ux2kkmCYfejyXDW08P
         lPq9IzcqhncoudV+QcIclZL52a/x0VLtGnFyOH9pDBJJngLSsg39EAare2bdvx3uEj9l
         Tzx4mGU/e3LHCMZq2LsbYKfwtSLn9lFwHmn7g3mzYL2YcNSYFTaL6gL9WNYogyADo0bx
         tQ9ZLaIa83cxfdpxd8UsdVoJFuJDHX1iu6UB4rsvAqJdpPtqX1Q7jnlOkJ4cKD2txQ7f
         TE++R6Cbqjc0B+QGS6iF5zTHj7VKIoM0RWouKazmtEIASZkTLL7Rx/+vvs8l2YjuCPk9
         2hXQ==
X-Gm-Message-State: AA+aEWaymedNa+hhaVjA8D+LdKYoECyTZT+yIYSvBq95/4dDejSS/BsE
        x0ledjSzDtEGxZ504n6S2UuXAYqfqarTldgBOJFT0wGq8yEy9kFRIVNEVYD1PZCfnpxsV027f2k
        plftHyn5ANTtaiETf/7IAuF+DRB3VWxjPDJEEoLoYbqNvagCxdQyc2i6AXkPV2XU=
X-Google-Smtp-Source: AFSGD/WmLmCuohYEZ1z5jP/vPY4Cg6cDMHb90tVze3eSSDa6FTsNmnnRNjWDD4OrW4x5PdHk/EjtxBKgjtQvwQ==
X-Received: by 2002:a24:dcb:: with SMTP id 194mr10261450itx.25.1544127666127;
 Thu, 06 Dec 2018 12:21:06 -0800 (PST)
Date:   Thu,  6 Dec 2018 12:20:55 -0800
In-Reply-To: <cover.1544127439.git.steadmon@google.com>
Message-Id: <7519fc76df085ce8e34cbedde2814bf8ac12d7b5.1544127439.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1544127439.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v2 3/3] Makefile: correct example fuzz build
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b72f37c29..bbcfc2bc9f 100644
--- a/Makefile
+++ b/Makefile
@@ -3104,7 +3104,7 @@ cover_db_html: cover_db
 # An example command to build against libFuzzer from LLVM 4.0.0:
 #
 # make CC=clang CXX=clang++ \
-#      FUZZ_CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
+#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
 #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
 #      fuzz-all
 #
-- 
2.20.0.rc2.10.g7519fc76df

