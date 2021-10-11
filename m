Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44EEC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB08260F14
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhJKUca (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhJKUc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58168C06161C
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e3so26293895wrc.11
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BfoqpXwFV4NtR5yoX+ONX0rNlMcxUly/tVDZ9BHmZXk=;
        b=Ehz/1BOmkfYbJ9Cwf7R017VwGOVAleUz2UD+NFWanQTMq+CcyLkEwjt+QLw3/aXXrU
         ZnPUl/j4mHeMOyYDY4SGnVe/k/Ull/5d8MKIS6omCTaKBFj/H8ypyMwXzdhaiyLZSREo
         nJncZhDgvZk+2bf7VR0hfJm0FvNZJO+xlfta77pYUUirrabWJG1KN/enlfLjFGp4zJmL
         PewehfbEIRPooWBQc37NVsJe6+SkuXZ+tx6Z42HvhiFzy9QqQ6Wdi4ijlj8/7hQV5gK7
         CxjiVJXTZ8mu6bKtqN3CRUARAp4xspKVnyllryYnUTP4hBOsXniu677xuAybjzZ8FmaQ
         mijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BfoqpXwFV4NtR5yoX+ONX0rNlMcxUly/tVDZ9BHmZXk=;
        b=oiumiYPnlUumNuwiXz1cCNRdriFAsvRNYzvvq1SetPdWSesqKTqcgDBUMCZFbR17QO
         vXZipo4jMh8mQb30Ax6+TohjkgdqZ7sHf596dmBrJnscYU51AvCxkmEaAt4HuWAp5oRm
         4wsuDF3ZXeCgyHz5hIQZzbE2STFP+Cz0Nu8qVSNHPRaAtznc5uH0ers7eZ5xApsMChew
         SoNcR+6PLErWJR8GvPEIDn2ao9Nbl3kLb4dDYm7JP6TXMzkemCf8rbFIH+Zpb20uWtNu
         yNi5bOZk9mrcEZylDcoBEGz0f5bEEoAZFbq2aVeL0Q/sykCpKh7opQ3hH+CtUB7I1lyF
         mHjA==
X-Gm-Message-State: AOAM530c3VaPOiYtJgpPXUINA3dHxrQbtzu+HCL/AAW/Y++IJHJvnb8+
        7a2na+Adr/LnYrmDs97lPUH6kI7cxzc=
X-Google-Smtp-Source: ABdhPJyk7aLEdn2sN0O06Osv9fXnomZhVLg4fKfnz5uByllgw1zjCFXkfx/M5tG7SZ1rWlr645L1Ag==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr1212942wmc.141.1633984225994;
        Mon, 11 Oct 2021 13:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm8912883wra.52.2021.10.11.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:25 -0700 (PDT)
Message-Id: <c4df0d6b1368a534491e21f2aaf1f5dc3e448821.1633984222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:17 +0000
Subject: [PATCH v4 3/8] sparse-index: update command for expand/collapse test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

In anticipation of `git reset --hard` being able to use the sparse index
without expanding it, replace the command in `sparse-index is expanded and
converted back` with `git reset -- folder1/a`. This command will need to
expand the index to work properly, even after integrating the rest of
`reset` with sparse index.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 889079f55b8..e1422797013 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -631,11 +631,15 @@ test_expect_success 'submodule handling' '
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
 '
 
+# When working with a sparse index, some commands will need to expand the
+# index to operate properly. If those commands also write the index back
+# to disk, they need to convert the index to sparse before writing.
+# This test verifies that both of these events are logged in trace2 logs.
 test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		git -C sparse-index reset -- folder1/a &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
-- 
gitgitgadget

