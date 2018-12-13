Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A390C20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeLMNBO (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:01:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35228 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbeLMNBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:01:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so1060708plo.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 05:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l+ZlTTjuWcEQJ47EVMvPBSlaPdeZ3cwX547G0KWd43o=;
        b=KaIxTjxW1TtveYzPtIq1nqFBWviarsSKY7CHy1n8SXdm/JC4RuBELkHj+KYgHZVzbm
         GgNFdoEOfXMwArJCPlBTCAiHPBXgUlTgaVvh1agmUCCdt0JMSlCjarae+/Ieh0b4oa5T
         Gzxvi8JU6rosx1nZtplqDG/nKSPHlz1pUZpqyj5T7ABHHPg/J/qt/Rr3AA1KlQ503yiT
         zoEt4VmWE1syW0tF/QMXmL3I28eJCqw5KQjjQ60LvABBu+CaLWKZ9zuo0w8WTRUwV7ob
         TYySTi/LpuM2sI9lIHvl2xtxdyaszl5d4Q6VcpL0MJ1nh17/WjBlgZkOAzX+90jetMzx
         /akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l+ZlTTjuWcEQJ47EVMvPBSlaPdeZ3cwX547G0KWd43o=;
        b=kex8eV4lAu2WN0iMnhxLM9bpAKjknvfoWSuFldbZEbpinnR9PhXfgC3SQ8p+A0zMuZ
         Au1dvn1lmmJqSAzmlZkYLh4hViIxOYMg6W7V2PdpmEA8aO9b/3FFKTPIrVcd+uT221bt
         njHWg6Kb5Mjs8BQIVuVJCqywrFgYe/oJNkMSvZYxcOtFqYZJtswohpOa/GCeQguOKgt9
         tPJUOkEmj+K+fHI1qyHNarQif6WzaOIAY1PcywiQml++GBvJoj6cViE2uR+ihccYD4Ba
         EZPD2daQ0TOk+grS12bEUth14CtbkLmsHTXBDf8Ia3g/g45pP/MJa/czrkf/XEldDAVF
         PlUQ==
X-Gm-Message-State: AA+aEWb3X1Ks6p3d+aRMmwVuZqYPZ4en/qvQuZFFvaUwbJjhBVfOHIWo
        jGv00St0OSSQOobKrhMNQD6puVVn
X-Google-Smtp-Source: AFSGD/Xw7FYqVpLCy2hqk8h3FoYjD/Lx0qU+QH0Yt3X2Jl72WPQvFPkKCl/4wOFlysSNLXgXnoXk4Q==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr23912637plb.76.1544706073693;
        Thu, 13 Dec 2018 05:01:13 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id o84sm2782617pfi.172.2018.12.13.05.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:01:13 -0800 (PST)
Date:   Thu, 13 Dec 2018 05:01:13 -0800 (PST)
X-Google-Original-Date: Thu, 13 Dec 2018 13:01:09 GMT
Message-Id: <32e6bf2dd37a4a4e43211cf7efa4656b2a15ce6d.1544706070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.99.git.gitgitgadget@gmail.com>
References: <pull.99.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t9902: 'send-email' test case requires PERL
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With NO_PERL, the `git send-email` script errors out with code 128,
mentioning that Git was built without Perl support.

Therefore, when the completion tries to ask for possible completions via
`git send-email --git-completion-helper`, it won't provide what is
necessary for that test case to pass.

So let's mark it with the PERL prerequisite.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d01ad8eb25..137fdc9bd5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1539,7 +1539,7 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
-test_expect_success 'send-email' '
+test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" "--cover-letter " &&
 	test_completion "git send-email ma" "master "
 '
-- 
gitgitgadget
