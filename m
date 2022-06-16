Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA1C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376960AbiFPNOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376906AbiFPNN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:13:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC33584D
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o8so1849999wro.3
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CroZ7wVEHD5BnTdKaPi1CT8nA1TvimJ9eubRklrt+3Y=;
        b=OAcRHrzGk0DJZryYw6PCpzNqq9YmdF1YgHU/Fd7X2foVtNcrPiuWAyd7oAMEgPU/Im
         D+kwLBlesMOJSlb6Ck40fhW1QLTzAmwVUdMfD3RYJymenrBDc0Y9+iYVKtguR7Q82ZFc
         Q536WLlgfVYWXsH/7heEMG3Ag8uoyuvry9TMQhMTFwvM0usTq52BVAgb5usIYOPz+HNV
         DQC3kFBz0MRK4+8yTTVSwN7Dkvc6XN95ahrtkZLCNkuHxMtlyq8acbcaXIUb7Ff13jNp
         JTwF94vbsw4OR5z5s4RjYEQrdx4JM/6vO9v2FtTOwOtRcpeT3PAwqFqFzPs3q16NT236
         v1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CroZ7wVEHD5BnTdKaPi1CT8nA1TvimJ9eubRklrt+3Y=;
        b=XT6KBLfDWvdTvxC3o0uu9DW9OIe4z3dutC39KfWqeXse8UEvUpE1lVu0/4qRAAmYFI
         l4JQDYaacA2/56NibUiI2OpFTYrs5swsnd+Bz93GQJGAD4PrloamDYrZ/7I8qn7pJZOX
         ndaq7xcKh1zPUyAC/yfIuBnDFkSZA9K+0OUCaZ87b3P+pTMfPFDIi0wLTuEm9lCMqNaA
         v3/9YPtOl+UoYo6UclYjWsfoYUuO+e1RefXcEjCcMLW19sZgrWPDTkB0qVlF7Hi83dgN
         NNSzNJmApn3j0Bn5DtgAs7hg7lpLLOoIeLK+vqwuTLIPzE5jLfTFuTarZQjSJ0/Zb/+u
         LIpA==
X-Gm-Message-State: AJIora89Td4wpKcUHc8GZsc6kHIKPxFG0aDAok53xLzcEqphv/NMAsJO
        6pVuB89Sb++3lVrZjwPhww4gTG9PfzLj9w==
X-Google-Smtp-Source: AGRyM1vFWS18gJd73WOk9yW1Y0OANlE5NpWsoq+RgE8A4d6BMUKHv79Yzpy0zNx1cZ7cG57REi8ueg==
X-Received: by 2002:a05:6000:230:b0:210:31ca:28b8 with SMTP id l16-20020a056000023000b0021031ca28b8mr4682436wrz.538.1655385234008;
        Thu, 16 Jun 2022 06:13:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7-20020adfea47000000b0021863a560f6sm1854555wrn.3.2022.06.16.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:13:53 -0700 (PDT)
Message-Id: <ca5dbc29e40e62f03cd0676996e16e5cdd6bedbd.1655385230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
        <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 13:13:48 +0000
Subject: [PATCH v2 2/4] t5329: test 'git gc --cruft' without '--prune=now'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Replace a 'git repack --cruft -d' with the wrapper 'git gc --cruft' to
exercise some logic in builtin/gc.c that adds the '--cruft' option to
the underlying 'git repack' command.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5329-pack-objects-cruft.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index b481224b93d..8968f7a08d8 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -451,11 +451,13 @@ test_expect_success 'expiring cruft objects with git gc' '
 		sort <reachable.raw >reachable &&
 		comm -13 reachable objects >unreachable &&
 
-		git repack --cruft -d &&
+		# Write a cruft pack containing all unreachable objects.
+		git gc --cruft --prune="01-01-1980" &&
 
 		mtimes=$(ls .git/objects/pack/pack-*.mtimes) &&
 		test_path_is_file $mtimes &&
 
+		# Prune all unreachable objects from the cruft pack.
 		git gc --cruft --prune=now &&
 
 		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
-- 
gitgitgadget

