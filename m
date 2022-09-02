Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1452ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiIBQFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbiIBQEk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:04:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741FA7FE50
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 08:58:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so3580504wmk.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=/HvDjiBfNJ5PehflNIlfNvxGBnMwPZc+kTxB7s8veMU=;
        b=LRFuqFGuiUadYVkMSjdCCAHlZW0XyBwawv1AnfSi5FvH1sxx5klPMkYxGKmGNr8CFm
         sy0KfVQWNPZ4+O5syBXkDOUTXDHYLT6gJtl3+iuqIM2bi05/N30zt4cv6N6W5m87g/N0
         K+Jz3b1A3ANzaaPnSBHRmk/BxJMSmOUBu3ZCj0EEg66Q5RwMZweMer7fuUqSSGMMoZ9S
         +RG92iYuscTxCkcE815bPbZfwbij/uSE0bT6VhDX9VlScD1q5FSNRJNcPR8cT4HQ9dD6
         sefSP2BOgkTDuzVQDa3IRoDDC+0MlaIi0wp+rEvC7yeo6ZTRKWgJpMiLgzt9x2gUy9U6
         uEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/HvDjiBfNJ5PehflNIlfNvxGBnMwPZc+kTxB7s8veMU=;
        b=6T1xVO5d/1kUfAqku6KC4HTUZHn0CVAkXhWuQu4XM1pIa28zVX+xOTaf145jDS07Qa
         yZupB99bnm0PrP7NKuivaPgplAMio8lt/ZPBdZ6T86JkTPLvpZHAL0uqesinD3Ci9vBr
         EcMzmUVywACLBxrMs86PAJj1jVqXzv3USbF83RReBIEyT3Kv52dLWV0f2xmyNMDXKynC
         V1Qbh10Tk41Ji7ShFBGyib2hd5Ep3CCReFAA5OuRa6AVD8IIS+YGtegs2HGlYP3k5h/A
         dGno0AKpzAAAoH2fAjlN74OceBZK16AMdOxvNBBg3gciYgZD80diDkwM8eQf7GE5GDD1
         d8FQ==
X-Gm-Message-State: ACgBeo04M25RXzTpYJlSpCfh6rsa96uYw6fhZmTx9UgKnWMFEHgGk084
        Zios2yPbTfnmcdzgh7/2k6gE38xvcFA=
X-Google-Smtp-Source: AA6agR5PMFxoTc1NIZJWI4FTh7kIp6aG2T4XbaUL9AAUWP7wPa0wuxfltFIAA4+pYCcpYaQ2y5V2PA==
X-Received: by 2002:a05:600c:1e8b:b0:3a6:acc:ebfb with SMTP id be11-20020a05600c1e8b00b003a60accebfbmr3429678wmb.66.1662134213653;
        Fri, 02 Sep 2022 08:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm9947456wms.23.2022.09.02.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:56:52 -0700 (PDT)
Message-Id: <614cbdc629ddb099f4a30ad6d217d1f1c716da83.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:42 +0000
Subject: [PATCH v2 1/9] scalar: fix command documentation section header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rename the last section header in 'contrib/scalar/scalar.txt' from "Scalar"
to "GIT". The linting rules of the 'documentation' CI build enforce the
existence of a "GIT" section in command documentation. Although 'scalar.txt'
is not yet checked, it will be in a future patch.

Here, changing the header name is more appropriate than making a
Scalar-specific exception to the linting rule. The existing "Scalar" section
contains only a link back to the main Git documentation, essentially the
same as the "GIT" section in builtin documentation. Changing the section
name further clarifies the Scalar-Git association and maintains consistency
with the rest of Git.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 1a12dc45077..f33436c7f65 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -161,6 +161,6 @@ SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
 
-Scalar
+GIT
 ---
-Associated with the linkgit:git[1] suite
+Part of the linkgit:git[1] suite
-- 
gitgitgadget

