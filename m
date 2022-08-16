Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C611C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 23:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiHPX6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiHPX6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 19:58:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D5E286DB
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ba1so3824059wrb.5
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=PD0L6ry8tE/Il46XwLLpiQGNHX3D7mXxn2j8YFl6pgM=;
        b=QkYuRPwWKVo0yl1oHKc5DCw+8+tH2X97k/jv7VHt/bnMmc6KNg4sPXcyUJls334lwM
         Tn265yXfQoDq/Z6O8OpH0rb5zb5I1dFe9AZ2tf4yWLpxHYOamTrQrvD5LdPWHU1shUqE
         jn5sGZi8ts8lvxz80SwaqLXEU0ss+J/VrC07pKm9FgONzE5zx7Xx/DMEMTOAVOOZMXCs
         hjUTL+zIwIe9pAfjzbgN2FpSbwCs0tBKAmOUoUyKk6y0HT+IX4sljhlaDsol3Wgp8TUJ
         GRvHQUGc+Ix+foN49Hdr4YrfNYH9KCItGIyaWCYreISgRHLBrX50vfW6KGYInOmngN6F
         ymvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=PD0L6ry8tE/Il46XwLLpiQGNHX3D7mXxn2j8YFl6pgM=;
        b=lWYILKJqpMbktSAmTgWz+cjSzY8LmSuYwdkHmdNcz5fgyFyICT43SHmj3hc9WQtIZ4
         MhJue/MWaG/SeiuBqIuGP8xsntKSUUs3Yx8Io8r37hOowtEjr0kl4COx4zZaG1Dd7jm4
         Y45j9162VSttGWNYIdJV6oyjz4aGb5j4ctikzAWZe6kkcDrVEKHmv75T+f64CV7aEDEf
         vlhjZzH00MVs5VgxGgfMDap6k0uoI00Z0isM1SoXWAvLm4iy0gUOdBDw9nb664VCU45y
         0CYWx8V/4EE6O8Tiep/e12uKdFGdFByMqGfik32DHQ1VuKB/0ebtGkbhysneCf4f5J3P
         aKOA==
X-Gm-Message-State: ACgBeo23EDP4jvE7r9i2R7Wi9oL0WD24N+prcZMAK9kJ79AXXcPcAabl
        2UAKmtZRvvf1oATs9FW/598pCfpuKaM=
X-Google-Smtp-Source: AA6agR75lfwxp04iJFmzNSluX1xX2uAXPdeapbJum8wd8RwQOyONl6ieY56nYLK3PhFQ9tzz4ORjVw==
X-Received: by 2002:a5d:6445:0:b0:225:1a75:7754 with SMTP id d5-20020a5d6445000000b002251a757754mr2546383wrw.239.1660694291956;
        Tue, 16 Aug 2022 16:58:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c2cd700b003a2e1883a27sm373035wmc.18.2022.08.16.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:58:11 -0700 (PDT)
Message-Id: <36fc3cb604d835f06bd5eca22b6eeff73e7117c8.1660694290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 23:58:05 +0000
Subject: [PATCH v2 1/5] scalar-unregister: handle error codes greater than 0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When 'scalar unregister' tries to disable maintenance and remove an
enlistment, ensure that the return value is nonzero if either operation
produces *any* nonzero return value, not just when they return a value less
than 0.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 97e71fe19cd..e888fa5408e 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -253,10 +253,10 @@ static int unregister_dir(void)
 {
 	int res = 0;
 
-	if (toggle_maintenance(0) < 0)
+	if (toggle_maintenance(0))
 		res = -1;
 
-	if (add_or_remove_enlistment(0) < 0)
+	if (add_or_remove_enlistment(0))
 		res = -1;
 
 	return res;
-- 
gitgitgadget

