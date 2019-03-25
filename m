Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4AB20248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfCYSOW (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43784 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYSOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so8381812ede.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vwnvz2KiiTfEUjy+0TI9zX00UK2D7BQp/26Y5Y1Hfg8=;
        b=uh30pLAb5P8zM4h5ecn9wlZnuo9oa7YMCWYZHzB/BslRVREU4LnwYBDLH6hsY2AjMM
         SJrs43kWoSCjLMBGBdY8oFyaPyKGdGgb3slKJ2sPtlnYHYbX+cKdwDdnsE52T86OP/tL
         K1DAyeLRod/6U47bHrakDCd3dciwIN4fOIrXbk8uEGNOKUmZ7MduBrqNkP5IVi1zZHFB
         SvG1aE2okkupUAkHmMk12i7xvoVXnqTMKkdCOco+dG775QUn8U6/H2OAlMHa7OPel5s6
         9iWqmUdkiaQ3Marrhjp31ZosCWIHO9J8WUCcywhDoJNL601sO9AWiFCF7uBp4CDjMhFv
         p0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vwnvz2KiiTfEUjy+0TI9zX00UK2D7BQp/26Y5Y1Hfg8=;
        b=VmXFivPE/M2wofadc9YKG3FGiYimfF3FWQY9oTBIdSaQEnMbLvLVo9IhdYjCuPoaB7
         7+YCeeBfoNkRJLS7JmvGA5Hcx45kSnGEB06CZMJS/4Y82LSt2AgEYUgYQUY1t9fHvThJ
         /3TQFjD9RQE4HGkSUvStFUp/F3o1zUSZR02K4sF9SZBfTuIH++lE7JaZjTXQly0Mjsag
         CYzc8IyPIaaQppEK4RJTBHL8q91ionPsOddTgp/f/yCvGsWIsWtyEiUh39yW+Aekl/FJ
         MyHFKIypLor9+1A4Kt29xOu9elZXFCsy8sfH66Z+chcRilYphnh69FtkO+y3RypCXT5H
         /KWg==
X-Gm-Message-State: APjAAAVddNmparI66TvDXfVdElkdME00CSIozF2fAg+679QAxCEkfmoX
        J1PatySw1ywZVL3LUod/HGzhg25S
X-Google-Smtp-Source: APXvYqwRJRqG2pS5fUnLl8ksetnLSVYACYcFUnuvjGJ+xijFWL9fq1Yr9fifmU4WTp/jdHPjE/4CbA==
X-Received: by 2002:a50:be06:: with SMTP id a6mr17425368edi.64.1553537660311;
        Mon, 25 Mar 2019 11:14:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm2174981edr.2.2019.03.25.11.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:19 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:19 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:11 GMT
Message-Id: <7d8f6a2ee6295b9817566853e1cfeca16b144b30.1553537656.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/8] t7810: do not abbreviate `--no-exclude-standard` nor
 `--invert-match`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This script used abbreviated options, which is unnecessarily fragile.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7810-grep.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 43aa4161cf..2e1bb61b41 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -119,33 +119,33 @@ do
 		test_cmp expected actual
 	'
 
-	test_expect_success "grep -w $L (with --column, --invert)" '
+	test_expect_success "grep -w $L (with --column, --invert-match)" '
 		{
 			echo ${HC}file:1:foo mmap bar
 			echo ${HC}file:1:foo_mmap bar
 			echo ${HC}file:1:foo_mmap bar mmap
 			echo ${HC}file:1:foo mmap bar_mmap
 		} >expected &&
-		git grep --column --invert -w -e baz $H -- file >actual &&
+		git grep --column --invert-match -w -e baz $H -- file >actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success "grep $L (with --column, --invert, extended OR)" '
+	test_expect_success "grep $L (with --column, --invert-match, extended OR)" '
 		{
 			echo ${HC}hello_world:6:HeLLo_world
 		} >expected &&
-		git grep --column --invert -e ll --or --not -e _ $H -- hello_world \
+		git grep --column --invert-match -e ll --or --not -e _ $H -- hello_world \
 			>actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success "grep $L (with --column, --invert, extended AND)" '
+	test_expect_success "grep $L (with --column, --invert-match, extended AND)" '
 		{
 			echo ${HC}hello_world:3:Hello world
 			echo ${HC}hello_world:3:Hello_world
 			echo ${HC}hello_world:6:HeLLo_world
 		} >expected &&
-		git grep --column --invert --not -e _ --and --not -e ll $H -- hello_world \
+		git grep --column --invert-match --not -e _ --and --not -e ll $H -- hello_world \
 			>actual &&
 		test_cmp expected actual
 	'
@@ -1010,7 +1010,7 @@ test_expect_success 'outside of git repository' '
 			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
-		git grep --no-index --no-exclude o >../actual.full &&
+		git grep --no-index --no-exclude-standard o >../actual.full &&
 		test_cmp ../expect.with.ignored ../actual.full
 	)
 '
@@ -1051,7 +1051,7 @@ test_expect_success 'outside of git repository with fallbackToNoIndex' '
 			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
-		git -c grep.fallbackToNoIndex grep --no-exclude o >../actual.full &&
+		git -c grep.fallbackToNoIndex grep --no-exclude-standard o >../actual.full &&
 		test_cmp ../expect.with.ignored ../actual.full
 	)
 '
-- 
gitgitgadget

