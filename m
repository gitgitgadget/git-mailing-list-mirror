Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C6BCCA488
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbiFGSHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350871AbiFGSB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 14:01:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0B14D785
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:43:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q15so17128830wrc.11
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E6bKO0VsQQCQlvKxYxRlprN8bVF9guaXMMN/6yBgq20=;
        b=WaD+ND5HcaeL73T3pEEQsYUnHm0ncEQIYGPP04uL9JBbMwXUr7qeeZEYwvVzGYhRsb
         3VKVU4yySwXrAa7p0sJc6sSX+NK2VaDKovfWiw4FwPdBi/Yw2u1QnfH2rt7juKXvcoSX
         AKcS9yu5r86ZFvAFQkiJ6wgPTA70RNbQyHDbLWWLEEXR1HpnjGb0yNUYj+kqU2LhEj5l
         J1hghzkrbGo2PsecCRA6aunVv8Yohx0FglTWXfhv5BT987NxlFgCgKGEV/PBP7T1tQdb
         2MhL9+Rz2CtEdHEaCZEQoyHy9esyk+SqH1QF5omxQGmtQmfDwF3RYGQGvdiJIHNeSZR4
         QVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E6bKO0VsQQCQlvKxYxRlprN8bVF9guaXMMN/6yBgq20=;
        b=zakoMx7EYlfs/Vu5XQaS4I6N7DFMzX0/bFGbU8+qq9h7qPsYNmw7/Whm3mfGYUD2kQ
         +7c3SlU86/m7siUr63GJ+PCpInMPNgK++JfmrD53pcdmvuCzss3cWxEuSRJujaY+LSVa
         d6jgnVtsi4rLRV4bdKUled2t9GznHMG7aUk+EzoD1jxCjCL4qmWKuqKgTAmDLPzgGwcR
         R4+/pttnd1ToUdWqWsGkXVo/+SsygYf393l4yB3p+5Y02FyOViR5sXYFpdpY7eilEBmb
         6+Z6e/UIU9+e0FzQz7MdSwbh+4VSt+CjhBuBcjFrhIibDeZsXfBIZTnC2NIUkDx1qWjB
         hGcQ==
X-Gm-Message-State: AOAM531QxqJr1MoYrS/gkQii/7A/qsXLN3+Tx7PgMm6oVcGp7g0YYVLh
        DGCf/wAoE45KiJvkZk0MmCGiLVWO8ToaBD1n
X-Google-Smtp-Source: ABdhPJycNLGH4lG8jI3A7pNH2qa5Gb+LT3Ql3Fhsn7kbuprcWIAqLSqeke5jsWu32KGNVZh1niJn/Q==
X-Received: by 2002:adf:eccc:0:b0:212:f1ef:943c with SMTP id s12-20020adfeccc000000b00212f1ef943cmr28202422wro.179.1654623817561;
        Tue, 07 Jun 2022 10:43:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az13-20020a05600c600d00b0039c47767e23sm188445wmb.33.2022.06.07.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:43:36 -0700 (PDT)
Message-Id: <a1b9bd9af90df88b7ce14de60a9626d2a1f2d3e8.1654623814.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 17:43:32 +0000
Subject: [PATCH v2 1/3] bitmap-format.txt: feed the file to asciidoc to
 generate html
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Documentation/Makefile does not include bitmap-format.txt to generate
a html page using asciidoc.

Teach Documentation/Makefile to also generate a html page for
Documentation/technical/bitmap-format.txt file.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d3f043f50d2..8d405a14330 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -94,6 +94,7 @@ TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
+TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
-- 
gitgitgadget

