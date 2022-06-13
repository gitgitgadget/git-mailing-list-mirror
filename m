Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E4C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiFMPjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351160AbiFMPi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 11:38:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AF157E88
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 06:13:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e5so2960210wma.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M8NOAZr2tUKos2MUTXO8bHJbZ3VbbJO88fU9Ov7RXbs=;
        b=VvydVbsP7HbYc8cSzn+5atkG40HtjaXq38FXmnqv0v2o0btvvX54lf5bdn1/T9EjTq
         XssboKjveBKJmJCXWoPIZDsaiZl3AxEsYF4b9oHxpq2vITXpvuuB0FYsOgjPwQpGzVps
         /dwxwmBjj5mWu5yOcJmIrG1UvBgmc6QbOcpGYKEJIO89kVitKiQPF/XwdZK5v2VLFhPy
         +NAMedsDPLorrdFiedVTs3SHS7Qw8pJlEMvxrWW7UvE0Gih6VP95MFvNQ3Il9ri8kPiz
         ds4B5NxU8sftqan78G0hdq2PIr2ss/YMuQkCBtB9ZctVFAYyV1kSTUjAJ570ZpUV1hFF
         fxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M8NOAZr2tUKos2MUTXO8bHJbZ3VbbJO88fU9Ov7RXbs=;
        b=5yhLJc5rMHE7ipIPgEIICJRXjgcR6pg6GbDDoWrm/f9RkUMgil/0DSEwZaquPWvinW
         S6rNEch9dCj0mGWNExu9H2+rgMz4Yej82Y1hAnE2+Y1RksOy6QU6d40rDZLBLNI6hbwm
         Uuq6EwaaEYrU+rFXoOiXg9o8sNMhSG2+rbVqfkqWkpWxPBhlaHwtVAwetTLOAmWqax+b
         CIVrd633blHOO+stfGq4G4boCNFKVLdKCeY8XCpqa3yJMKKI/zRh0FWz61o+VIz1jsoR
         NsCiZ9MRXIi6f+q169A0C+sTWo3tCxD2MiBx4lW8kVAjyjVpA3L177Z34M9+oB5neq37
         WOsA==
X-Gm-Message-State: AOAM530FFFsWo4xQxqrdEVShOfWRt7mZeOBDgw6FwwytgJKb5QzYEoiQ
        Iyg52NNZb+o8j+rGkLBuE1/hYcyVJpGK3A==
X-Google-Smtp-Source: ABdhPJz1uPjLEwBGdpPu7hTZCeRVI0JcBFMtVI0hV0jN1ddzSQ5geRISZCTpjM1jfxkFbC3Laeb/hA==
X-Received: by 2002:a05:600c:1c10:b0:39c:4708:648d with SMTP id j16-20020a05600c1c1000b0039c4708648dmr14822556wms.85.1655125991349;
        Mon, 13 Jun 2022 06:13:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0020c5253d8casm8440210wrq.22.2022.06.13.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:13:10 -0700 (PDT)
Message-Id: <5212c5ec474b9441046203da363f2205795f213e.1655125988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
        <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 13:13:07 +0000
Subject: [PATCH v2 1/2] ci(github): use grouping also in the `win-build` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already do the same when building Git in all the other jobs.

This will allow us to piggy-back on top of grouping to mark up compiler
errors in the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/make-test-artifacts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 646967481f6..74141af0cc7 100755
--- a/ci/make-test-artifacts.sh
+++ b/ci/make-test-artifacts.sh
@@ -7,6 +7,6 @@ mkdir -p "$1" # in case ci/lib.sh decides to quit early
 
 . ${0%/*}/lib.sh
 
-make artifacts-tar ARTIFACTS_DIRECTORY="$1"
+group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
 
 check_unignored_build_artifacts
-- 
gitgitgadget

