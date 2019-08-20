Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A6E1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfHTHTE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41691 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHTE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:04 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so10066219ioj.8
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7cvA63Mls7f/glzSnNwJN2P5f8JSKcVpFamqhfO42o=;
        b=dqYFa4OiP8RkBAkcyeu/aMIOpE7ET8ZanqesNz0RUJobHiXh/JnWy8e6lFq+2IluDP
         zy8tQji7aCn6DDg28veaaLb2W/qi+cZmARWkeJpmYXQBngjtzZkXaEXezDCqBw8PomEL
         8STxQPVAoiynxHGj7Uet4MrHDhb/8B+91KShdO/Apv+zy5QW2ZJp1gBegO0NQzYr56nu
         6hO8ZAk0eOVR2ZG4af1CmBal1EPgRmmH8fPgAYyx0zx92C/AQDVxZhKZyXp5mt/8CeYf
         IsVCXoAEgefRcKIaSD4bKqVOwgNPp4RXNkWvuWEngBiVEskdBdsshjubhpMG1MhOOGK9
         odxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7cvA63Mls7f/glzSnNwJN2P5f8JSKcVpFamqhfO42o=;
        b=L2JGAHWBbOucY2hPT/9jllbEMCDxRTcNCeNV7do2V/rehEMOJitpXGos+AzNZtMUny
         w0XKETyFrUrt17W+ea4QmQWhEXsMe8qAhAHAvECQCFiCZrGwEDFfXVFCfRsE2EkKfnLX
         /V5ip2vzYOurb3yBpPBciAdAxIL2aEuvHxaBXc9QzKkvPmkTiC1ek5yRSzQLmGOJsOls
         rEdeng3jF7nVQQ4oS64FKfLjHLuGAEgqMKT8/ANtUJlYwHQNoOCfFWZhpRNwRgRGks3n
         7wtV359Q3ycqtvpaPJfL4g6cLQuJXTjsxzjKV7iCtlR9iWq8zFucY30/dk4pr4ldEhRt
         9oUw==
X-Gm-Message-State: APjAAAXW0re04FBcHLQUHOnMmtefoKrBQ0LhYfFXryQ0cdBQXxom3QiF
        Tes0cOBCWBaMQYK2YKMfgz9vIOdF
X-Google-Smtp-Source: APXvYqzJrMy5Ge9xWRqeUEZxIupoeHVaEnOHQ8BAEZOuKEIkqprhYGm1QO3ZuHWWss8frvT+EwuhQA==
X-Received: by 2002:a05:6638:310:: with SMTP id w16mr2200135jap.136.1566285543450;
        Tue, 20 Aug 2019 00:19:03 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id y5sm17395164ioc.86.2019.08.20.00.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:19:03 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:19:01 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/13] t4014: drop redirections to /dev/null
Message-ID: <34315412c85e36271bcfe773001a7aa541c6faf0.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since output is silenced when running without `-v` and debugging output
is useful with `-v`, remove redirections to /dev/null as it is not
useful.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c07d868491..2048fb2008 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1502,42 +1502,42 @@ test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (2)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter rebuild-1~2..rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (3)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter ^master rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (4)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master.. >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (5)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 HEAD >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (6)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter with nothing' '
-- 
2.23.0.248.g3a9dd8fb08

