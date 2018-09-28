Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607261F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeI1Wtx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:49:53 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46851 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Wtw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:49:52 -0400
Received: by mail-wr1-f42.google.com with SMTP id z3-v6so6994307wrr.13
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSVc02smMBnnNG2ynPmJ1eG6gU05iQKpjYFioZ3OACY=;
        b=iaf7Jpf3nTCvzZm3OSwZoDH0zJxDbilvaeOCPdgH5+sC+w0rQwgyqx7F9ABBV0YQec
         7J0sLxfygEkyp2gO7wKWjp0EljllmR0IFyrEPv73ydccxY/e95VF1IBe9CT8zBcWe1bL
         lIarwrKkwXCOjsaEq9bcXRkkRDe0TENeGB2j1mXRfnQbMi2l1hT1cIGQJoC6peNe8Ttw
         /NNdhcRHsqEfwDwibSAxp8g4y+vbl3huIdz1nGFoRSSfSTfo959ZLlHbae5XzHpfUk13
         //eHGII8BaWBcC2LbFAyW1FkMIlTEVxlgHFgM4hAkxnjXM3W5dsWqOYxv526f4Hf39DU
         B2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSVc02smMBnnNG2ynPmJ1eG6gU05iQKpjYFioZ3OACY=;
        b=jT2XlpmDJLoVtyjwxAwKE6ro0AOQAp1CenS58zveZIuGyNdQ+RMyyxHCO7O4YJke+e
         n9bQ/Nl38QZ4xHbLteX10WrmpEbOoSIFWCINlnl6eCv1tFaNj5qXK9tBGJnHOUpDy4rt
         3RFI06q+2p14vczjivBC4FWVdefQu6rJDM3Ut8+KejwJGxKLcL1V2KN1Eznmgms1h8PI
         8R4Iq4c1f/50LPuBMUDlfQ4W4yR8nh/giuuwMDo2y3dWtQup9yHG5DcWjn9rDjOgFbtB
         K1wk/mLqcwj8ZtyVZoMx5K9VYAp4ZJOtWki4MvtF8Zr4Rq5/9V41zejtGYAcuL8kdyBb
         ofmw==
X-Gm-Message-State: ABuFfogHdYV7aL1kxmSPiNo9eWvAB4pPoe1QuyPo0iLGyP8tY1RKY2ur
        bo4GjhDx6ghDx/AAwW27G58KxOM/
X-Google-Smtp-Source: ACcGV63Ow8BkLHPyvmi+NRq+ylZ02hCa3yZeJFm3CQvugxulHy0ntG7AnXrq1PvVaH1eyMLdKsK94g==
X-Received: by 2002:adf:bb41:: with SMTP id x1-v6mr4508039wrg.325.1538151920195;
        Fri, 28 Sep 2018 09:25:20 -0700 (PDT)
Received: from localhost.localdomain (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id s24-v6sm1628247wmc.7.2018.09.28.09.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 09:25:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/6] t1700-split-index: document why FSMONITOR is disabled in this test script
Date:   Fri, 28 Sep 2018 18:24:54 +0200
Message-Id: <20180928162459.17138-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
In-Reply-To: <20180928162459.17138-1-szeder.dev@gmail.com>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1700-split-index.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index be22398a85..822257ff7d 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,6 +6,9 @@ test_description='split index mode tests'
 
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
+# A couple of tests expect the index to have a specific checksum,
+# but the presence of the optional FSMN extension would interfere
+# with those checks, so disable it in this test script.
 sane_unset GIT_FSMONITOR_TEST
 
 test_expect_success 'enable split index' '
-- 
2.19.0.361.gafc87ffe72

