Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EFE1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfGAVVU (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42529 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so15331752wrl.9
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ztwW1p0aQ2mCbzMuBeWwugeB5xsSD7QoczddYbD4PI=;
        b=sehieitpg5I7HYawtF34csBWIpyvxZJuWvZHlMqO8b7K2Ocp3Olo40xK3COxf76NsO
         xzT6EES0m1HzeycD2PSFvU++R1r0UavICX8ACooMZ1KBLQsQezcsU3DbkpfXiSwBzfgQ
         xFu8iaDZ9jBJ9+sbwqAJWSzhHI+Y/+UkCZGWjyw/kQnHV+t7TS73CXPf5H/39DfNfITE
         zJYgeWkaw41p2MW9xewPJjoH+I+cjp9X0/lPrgCrG2XbjmJ4vDhABZ8mpbxdTHXz9qQ4
         3dQ/OumrRMW350tFk0J1vfRiRJasIj7B7BwJf0f9IVWh/DCLgSK0AZCDUPYkxQIjCKDN
         Bu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ztwW1p0aQ2mCbzMuBeWwugeB5xsSD7QoczddYbD4PI=;
        b=GfnmToHM1XBsQ921GYdE3a0SixGU7l+U25+3mhsw6aJAGO73osKGfGLDR2mTqvTRJf
         +fIH22s0RoZh2JHdf0INhkjhRw7HzYh9eEWRaIrxlz61XfcKDISL5U2dtbRz6OuoIcAR
         rDdMBn5rBto6W4TCU9HtuTVUiivaC7yEQCWOIVYUXNtp1BDaGQwR21vn0Ij2WptPZrEn
         Bwt9HITrGo/JwjXrsMFSetlu31dPmbhr+9DpDsm3GHncMjVm5OkI9ATcIi5EBSNdLBLL
         K1yy85jLBjV7KsdmYqXCKJZAvqahaWBxSJjqAKvHbvwaB2uv9HOFpYs6rS9h7gHMogbc
         beHg==
X-Gm-Message-State: APjAAAWKxlWkWgckkS/vZF6CmEzwvWiojVYp9pzVMt0VxYqmI7ebVQ/E
        zgfnkT6FxElV89qPT6WLIYGlQ2NFeiE=
X-Google-Smtp-Source: APXvYqyBL9QZazlvYYD6ylVXOVFGRblWGajQuHrC8oDqWx7uf/G9pvP8qP9+tTQsWWn84UHPgPQBPA==
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr1428811wrm.284.1562016076318;
        Mon, 01 Jul 2019 14:21:16 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/10] grep tests: move "grep binary" alongside the rest
Date:   Mon,  1 Jul 2019 23:20:55 +0200
Message-Id: <20190701212100.27850-6-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "grep binary" test case added in aca20dd558 ("grep: add test
script for binary file handling", 2010-05-22) so that it lives
alongside the rest of the "grep" tests in t781*. This would have left
a gap in the t/700* namespace, so move a "filter-branch" test down,
leaving the "t7010-setup.sh" test as the next one after that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ...ilter-branch-null-sha1.sh => t7008-filter-branch-null-sha1.sh} | 0
 t/{t7008-grep-binary.sh => t7815-grep-binary.sh}                  | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t7009-filter-branch-null-sha1.sh => t7008-filter-branch-null-sha1.sh} (100%)
 rename t/{t7008-grep-binary.sh => t7815-grep-binary.sh} (100%)

diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7008-filter-branch-null-sha1.sh
similarity index 100%
rename from t/t7009-filter-branch-null-sha1.sh
rename to t/t7008-filter-branch-null-sha1.sh
diff --git a/t/t7008-grep-binary.sh b/t/t7815-grep-binary.sh
similarity index 100%
rename from t/t7008-grep-binary.sh
rename to t/t7815-grep-binary.sh
-- 
2.22.0.455.g172b71a6c5

