Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A5FC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiCAKZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiCAKZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8C8EB56
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:24:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p9so19663399wra.12
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0+6ZofhIChFrhi0R37fNMY11dRkTRc5ZEYlAU1BlzXA=;
        b=HKOoA1qsVB0Pmmd2nakVusGY0CJEb2vWn1exkcMgS2adBFjN5r3rLfXfzqUlefL55l
         U96Pm3X9Ye/vfYnw5H3Wq6iMug91710MQFHTOBpaSm0ASPJwL9UUU4zcJT6KEFdXMmvj
         nwMWVu900wnIqK5gM19rKEqdUZ2TlV6tTxllVXC+wY3GggAeeNlK6NqKqQXuUanPrdqq
         GbC26KVrKNosvUzE+94IjHQj1e6MnVbzF8xGU8zOrFyRKgSVjUM3MnaLfLVUEA/68p/O
         el/Z46ak8MoaWZvxoQyvqwSFCzXfyVkJlh7qDi5XT2BYIJvE4b+vFekfIzlpn3/WVUVD
         rbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0+6ZofhIChFrhi0R37fNMY11dRkTRc5ZEYlAU1BlzXA=;
        b=QkFQEDs4NM5OboI7Y4b1yHRIAJCPEobJapvsQ3DzFDkln2baQLcIkDc34wIUm1la1d
         +IMQ55VmkRc+ccH6KrxWNYvjLkX1tC611E6bFXRjSV3MqAC1Sgb4x2FSfebG0ykLBHck
         7B6OUNfUzVhvFjPnBmyqYaaAmgGeuhv2MLhsTlbQchMrxepoaBuTnLMSopS3u+GWcHcA
         e3V4+RPrObXcCPL+wx6znYMa5l7UQw7zdaSXnrB0iWrNXTysqZWp4RFuwumOifkDArwz
         ZqcNnAPkzAcg5NvzCELJhT5Rb0ExycPoTCWbDBIIaC4+O6EGdNMYyDZdAi0y8p0R3H4d
         L5GA==
X-Gm-Message-State: AOAM532WPGfkz+K+/wLajWrREnhGj+68ck/Eu7Xr+93gDXvDz/hoV+1t
        1XkLY9fa44t3PyU6ss7G/j0sYSd1iww=
X-Google-Smtp-Source: ABdhPJyL0MaY3DapzkoR/h9diW6xKXQLbZAfJtkR7TtW4VpjXNDWW/F4pWiPVG4jqCaKeT6UL3vkDQ==
X-Received: by 2002:adf:f70a:0:b0:1ee:33bf:3864 with SMTP id r10-20020adff70a000000b001ee33bf3864mr17295416wrp.4.1646130291038;
        Tue, 01 Mar 2022 02:24:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm2755358wmp.44.2022.03.01.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:24:50 -0800 (PST)
Message-Id: <db08b07c37a81866c63b062c92d9ee78976d1b34.1646130289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:24:41 +0000
Subject: [PATCH v2 1/9] ci: fix code style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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

