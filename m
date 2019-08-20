Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CF51F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfHTHS5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:18:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39320 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:18:57 -0400
Received: by mail-io1-f68.google.com with SMTP id l7so9347643ioj.6
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Il9LwpJVzdzduiFquLf1KD7uEGxhXQfU8tLcnW9qImI=;
        b=QU/j/+Vb6dJ4qymUrPH8SKuu4ZcybgBKrox0q7d71TjDjVBq7iZVGte76ZaThEi/Xg
         2i95LS9fPif85ozp1XbTXLx7h9IGYEKImcP9GqSKBzbrp0BLWBva7VDGaFjVG8lu7fST
         6Swq7VF7UfFmEAwMLJy1fU9IqNDSlUJ3nZk8pRTkEVBhdwQkTAsvJtxHnik9/ITV/qAJ
         Hatet7s9YczQn0t/QEzBtMeWhXiU23Guw98juzFQK0hQ6cGteQrQQsb4+Jj8bkD+Q2dB
         7lazvTlmKugFHswxyW6rdFIbtV9VS6SvKFpi0+TJqXUhO6Gi5Wn2mIaz/+ZwNjuPU95f
         Ru+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Il9LwpJVzdzduiFquLf1KD7uEGxhXQfU8tLcnW9qImI=;
        b=XG5Yh0QVYKhwH/v2GqA/xyG2CaUBL3zMP5HLyK3qqzmVp7R26Od6EJasZ30kij09Tm
         JuYq6tArWIsCrqf2kbyWFczDrEMFTX1TNdOg3wpWPFnkNmPCQHDlHSeW6xlfDiAJO51l
         zx+hmR/A9uQmEFXVAJXx2qu/F3xwO63Kdy7UGZt1sUKlaej/V72jXiKrAvGu8DfOiprg
         qi4zkPPMgPG0PXSrCdfWNA5y7cgRk1Yqii9zYN9zI5+EkZYJyN003Q11C7GWJd/wPRns
         5CnBbXX84LOnkdNZlQAklLnza20p1MU6IWu3MtMvgVD8Yq9Nj8J5D97+9ITUw9IgwvqS
         rspw==
X-Gm-Message-State: APjAAAWGg34WZqe/wgu1EFaKYWPu2nLjWN3iEm09m+jLbmN/ju4ZBkn6
        D3sxMoCUx0BphASGzthblRzmpHP4
X-Google-Smtp-Source: APXvYqwmjZlrh2vrEHm2gTPvNzXSR3n+SPz/6GNJV1LUc/Okr6smQG/uI21l5E5SGQONAPZ2OizPRA==
X-Received: by 2002:a05:6602:c7:: with SMTP id z7mr1034624ioe.130.1566285536168;
        Tue, 20 Aug 2019 00:18:56 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id n21sm10536389iom.69.2019.08.20.00.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:18:55 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:18:53 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/13] t4014: use sq for test case names
Message-ID: <66bf2e3dd4ecfa2d389d3865929226ad02818b55.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention is for test case names to be written between
single-quotes. Change all double-quoted test case names to single-quotes
except for one test case name that uses a sq for a contraction.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5e8eb6fb27..a7b440b003 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -58,20 +58,20 @@ test_expect_success setup '
 	git checkout master
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream" '
+test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout master..side >patch0 &&
 	cnt=$(grep "^From " patch0 | wc -l) &&
 	test $cnt = 3
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream" '
+test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
 	cnt=$(grep "^From " patch1 | wc -l) &&
 	test $cnt = 2
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
+test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 	git tag -a v1 -m tag side &&
 	git tag -a v2 -m tag master &&
 	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
@@ -94,14 +94,14 @@ test_expect_success "format-patch doesn't consider merge commits" '
 	test $cnt = 3
 '
 
-test_expect_success "format-patch result applies" '
+test_expect_success 'format-patch result applies' '
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
 	cnt=$(git rev-list master.. | wc -l) &&
 	test $cnt = 2
 '
 
-test_expect_success "format-patch --ignore-if-in-upstream result applies" '
+test_expect_success 'format-patch --ignore-if-in-upstream result applies' '
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
 	cnt=$(git rev-list master.. | wc -l) &&
-- 
2.23.0.248.g3a9dd8fb08

