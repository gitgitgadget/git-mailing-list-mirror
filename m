Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501FCC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 15:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiCQP47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiCQP45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 11:56:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D5E20DB15
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so3395350wmb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIRDfAvtky+I0kP1fZxN/EcjN3kNV94ceUvCQL7GL/E=;
        b=AFrAtqSLi7ipi6TzUbDckp4ERHESbvaVlVgkd665oPT2nVWiNC60dR72CKbfMMgQGr
         C63N/P1AOEWYF+4h9Cfa3vwuC67Rp7zjht+hx6H2irh6YDZVPV70G9ns36Zqm0WlH02k
         EvtfQwvLNI8mqVF+eIvuwUc/VI8Pyi5f/oWCtTTYusMInigFQpZPZB3AOzvQPsss53pi
         Dq0ITrQrVkgSlUnArHK7GLWIblrFx26OWA2L8oH45KrzRKdhN+ZLMz0ZbuLuNuwXu0mg
         0EtQvDDkaQCmT/jJChjaq1PtVyn6uLFA+nY4y6/q2mSbB182vTNBfpLPwNqADP/3JDQ9
         8l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIRDfAvtky+I0kP1fZxN/EcjN3kNV94ceUvCQL7GL/E=;
        b=n9/oL399Lv3f0MbD3G14BUv26i9vxIBsDINhYM4HjPgjrQCrffGPY+EWlZz39EGl8+
         ZXpz64GfCktFSYz73DgrspEhlsDe8/BEGV5YZZShmTUerVL/rYyX6msi7pwYCP+6OAc8
         XRVS6y+djbmZIarkgnYafJsTznh13DGPE2BjM3uPSGl6H6MnRCKECwg+o/VE+E28trav
         e+nLfR4UMuXRPcAkTyoa9XyKZevKN+rYSS4V0RShp1Hg41W8GdZ3ccR67sZ/bmQ/nHSw
         Ax8g7cKU0BnvcaQhTdCSVSPofNRiovR2jW3rZWZNPmgvvfAr6g8wHhVA6xZX7Ix5ywpq
         XUnA==
X-Gm-Message-State: AOAM530iharOTlaWKLaS4EPJKRsq7ui9yVFxP8Crtkki52TIiAUPcCzD
        oUoSXwxQv04Z/RNftNOU7ZrXk7cZjEA=
X-Google-Smtp-Source: ABdhPJym/gfIbitL9PILKAn1CC4TaEX2SRuDUT2U7eccVewBbbiHfzv7egGS0WO+AfNpmNFeBUQV2A==
X-Received: by 2002:a05:600c:1c02:b0:389:cf43:eafa with SMTP id j2-20020a05600c1c0200b00389cf43eafamr4509014wms.203.1647532538770;
        Thu, 17 Mar 2022 08:55:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d64cc000000b00203da79ca2fsm4631750wri.97.2022.03.17.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:55:38 -0700 (PDT)
Message-Id: <d1491d299a94a7f776b2e20b4ff586f544487443.1647532536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
        <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 15:55:34 +0000
Subject: [PATCH v2 1/3] t1092: add sparse directory before cone in test repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a sparse directory 'before/' containing files 'a' and 'b' to the test
repo used in 't/t1092-sparse-checkout-compatibility.sh'. This is meant to
ensure that no sparse index integrations rely on the in-cone path(s) being
lexicographically first in the repo.

Unfortunately, some existing tests do not handle this repo architecture
properly:

* 'add outside sparse cone'
* 'status/add: outside sparse cone'
* 'reset with pathspecs inside sparse definition'

All three of these are due to the incorrect handling of the
'unpack_trees_options.cache_bottom' when performing a cache diff via
'unpack_trees'. This will be corrected in a future patch; in the meantime,
mark the tests with 'test_expect_failure'.

Finally, update the 'ls-files' and 'root directory cannot be sparse' tests
to include the 'before/' directory in their expected index contents.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index dcc0a30d4ad..dcd7061fb3b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -16,7 +16,9 @@ test_expect_success 'setup' '
 		echo "after deep" >e &&
 		echo "after folder1" >g &&
 		echo "after x" >z &&
-		mkdir folder1 folder2 deep x &&
+		mkdir folder1 folder2 deep before x &&
+		echo "before deep" >before/a &&
+		echo "before deep again" >before/b &&
 		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
 		mkdir deep/deeper1/deepest2 &&
@@ -254,6 +256,7 @@ test_expect_success 'root directory cannot be sparse' '
 
 	# Verify sparse directories still present, root directory is not sparse
 	cat >expect <<-EOF &&
+	before/
 	folder1/
 	folder2/
 	x/
@@ -337,7 +340,7 @@ test_expect_success 'deep changes during checkout' '
 	test_all_match git checkout base
 '
 
-test_expect_success 'add outside sparse cone' '
+test_expect_failure 'add outside sparse cone' '
 	init_repos &&
 
 	run_on_sparse mkdir folder1 &&
@@ -379,7 +382,7 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_success 'status/add: outside sparse cone' '
+test_expect_failure 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -590,7 +593,7 @@ test_expect_success 'checkout and reset (keep)' '
 	test_all_match test_must_fail git reset --keep deepest
 '
 
-test_expect_success 'reset with pathspecs inside sparse definition' '
+test_expect_failure 'reset with pathspecs inside sparse definition' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
@@ -1444,6 +1447,7 @@ test_expect_success 'ls-files' '
 
 	cat >expect <<-\EOF &&
 	a
+	before/
 	deep/
 	e
 	folder1-
@@ -1491,6 +1495,7 @@ test_expect_success 'ls-files' '
 
 	cat >expect <<-\EOF &&
 	a
+	before/
 	deep/
 	e
 	folder1-
-- 
gitgitgadget

