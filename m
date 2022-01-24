Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C90C433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbiAXTBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbiAXS7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E519C061252
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so34187wms.3
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0+6ZofhIChFrhi0R37fNMY11dRkTRc5ZEYlAU1BlzXA=;
        b=hAYWloshxoO9iMvkry+wMyXe87nQayYaoMr/lNU7l3xEvoVpYP0vQJTbgRG0EUZOuy
         rn79m8/FDG1yILxx+B+YkM6FD0AbpkEwItGJoNjGOenAxNcU7ONZYoWi3W2TZVDjhypi
         XSQW1NJLVKdbtVWFUQfRS1nZiziqn52oH7NLWmWU6tOhtB4mXC7jRbp0VTb+Lxzgqeav
         kkne3WBPuOgDGjR00GJ+N3bPq6KvMSwk2JrTbunHesI0ET2Du/yL5de95MRy1ZiU/I2V
         QqG8q3hoQTwP5sLPxj2r/cZCVP7WaPG/WhDVOPSB566qNEBmeSWG/ijZgfu9USlkGBvz
         QEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0+6ZofhIChFrhi0R37fNMY11dRkTRc5ZEYlAU1BlzXA=;
        b=pVDTbcjB4HZAA9VA9n48QTjDQPi4rRRQbURoPUpN+nzMyCbcoCcHFf1d2EaKm5BsTU
         USVj7Cz4wwLWOn7+8uUgnAkPfEd2hzlO0C/9JiXq6shWMweHBjGy8W23+GUJ1SOJb7Qh
         oDdaiOaQZS+Erd+1a44HMsT3/sZaOY/LT7uohzoVQYDlcTFBQT97/nWR74O5Z7wgcjhk
         UFx2Nap/mv9AS9Xkz2wSSRhQBDsqK/wvw/sL4Al/P+zKiTst3EAppt5TQ9RnPcpz6uKL
         50XV+1kpqmoZE8Djchyxhc/E1Z4nSPC9WjZuBYLrEeImieHzJY7Et7zaGrrIVpbQlAsA
         crfw==
X-Gm-Message-State: AOAM531bHANiGSlYA7IHXwgv+QCKviGO/M60LeYA4ICFkOx9WsYbF7Av
        34gSyEbI3BNv5fUC130Q5hV7XXogZUQ=
X-Google-Smtp-Source: ABdhPJwYPeXcO9uUDMHvhP8bcZz0tesdHN/EfOuFMfivlq1ywsH2aY4t78un+n4kLnwrbx7WLCLxpA==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr3030756wmi.41.1643050577943;
        Mon, 24 Jan 2022 10:56:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm14463268wrq.82.2022.01.24.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:17 -0800 (PST)
Message-Id: <db08b07c37a81866c63b062c92d9ee78976d1b34.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:06 +0000
Subject: [PATCH 1/9] ci: fix code style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In b92cb86ea14 (travis-ci: check that all build artifacts are
.gitignore-d, 2017-12-31), a function was introduced with a code style
that is different from the surrounding code: it added the opening curly
brace on its own line, when all the existing functions in the same file
cuddle that brace on the same line as the function name.

Let's make the code style consistent again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 9d28ab50fb4..ebb502640fa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -69,8 +69,7 @@ skip_good_tree () {
 	exit 0
 }
 
-check_unignored_build_artifacts ()
-{
+check_unignored_build_artifacts () {
 	! git ls-files --other --exclude-standard --error-unmatch \
 		-- ':/*' 2>/dev/null ||
 	{
-- 
gitgitgadget

