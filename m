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
	by dcvr.yhbt.net (Postfix) with ESMTP id 496391F461
	for <e@80x24.org>; Thu, 27 Jun 2019 23:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF0Xjc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 19:39:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56138 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfF0Xja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so7280339wmj.5
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ztwW1p0aQ2mCbzMuBeWwugeB5xsSD7QoczddYbD4PI=;
        b=cxGQkmbarAdp3cbegdmEnGXrgoWBDPm+Qu4Q6qmTaPMFcOKAb3UYdtdXV3QRTGxEyr
         B3AFPVIDFA9ObLGN1frfkhWiIu1Pwn2ZsEp+JrAcLImWvSjMOQXqfxPqlkCiFWPKwFit
         OVX/BlkaiH7DloHz+PMfmKrkxlF4YjhrUidcVzki3j2bfdPet93zet5isX0hZufpty5N
         6j0m2XNNev+Q+i7jeOMLJhIHOLBcic+PGO4b0JM13jUym//G75M1g7a3g87Q643JIDwW
         ff1KDvyV56K5gBvDEMq2FwnuAJ4uqnQ0i5Sz89EZyAUghGDWA8WGOlPwE1bo2HR4XQ4I
         Qy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ztwW1p0aQ2mCbzMuBeWwugeB5xsSD7QoczddYbD4PI=;
        b=GydlzfYjZTmi2OM6jUYnJu3vOWl5Z+YSKTmu66BCDB4TC5Ssz4OKZMrGUllMoU5RJT
         WrVBK+NrZ3wxkCb1QmrqHKNRuHnfC82ajuiVOn6NNF4bOMRLvhG/V6brBVPXnJMymuX0
         btquNK9NkpSl76kuynWnbNBWyV9w/XOeWv00vzVUuRI+cszuONMB7MW04LbRMpmNB5Pp
         8JyqbIHZ+wzZUhf3XNARweXUmX7+iFU4UbD4Bl7NeJi1iunwXyohJKJvo0yubL6O4wn2
         xdsgJ19bx/w0e5jdZqxFC6sQKnNY/3FeL5zBAYhpLwDufnziR/jKpRD/qzSO8VlaToW5
         nIeA==
X-Gm-Message-State: APjAAAX5+JVtU1gojmF6cBuz0nyl+0yemw4INcZy3yNkIUiorBS3fnkx
        uHgH7P8u7zrMDYbZyHZY3r6M+B5Ad78=
X-Google-Smtp-Source: APXvYqyJa36w8+rCajDLm7Yugjl/vFMen392v9yyNYNvzCc+CZJ6L0fPLi00iS3sD4uQ0BisL0ZXRQ==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr4966265wmk.40.1561678768730;
        Thu, 27 Jun 2019 16:39:28 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x16sm720530wmj.4.2019.06.27.16.39.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:39:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] grep tests: move "grep binary" alongside the rest
Date:   Fri, 28 Jun 2019 01:39:07 +0200
Message-Id: <20190627233912.7117-5-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190626000329.32475-1-avarab@gmail.com>
References: <20190626000329.32475-1-avarab@gmail.com>
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

