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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7949E1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 00:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZAD7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 20:03:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFZAD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 20:03:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so238309wmj.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ztwW1p0aQ2mCbzMuBeWwugeB5xsSD7QoczddYbD4PI=;
        b=l56y2c0sKKNaHy+z0CK1MjSehPe3YMkaPqXNLNkadFLRSAmVZtdPm+FoxWRi4NFfoo
         c4Tc7kLxAVftlCoQ3XARdbmUBLkEgOFgyvKgJcrUkc54tDBGjw2jtnsQynnH3R4L2OnF
         42EdF0HIzk4IoO6QiCfP+It/0MM0njk7QwhTNLvepIlXN4jmKckyGE4jrueMf94jmvM9
         ua72HRuCdduMpIoUgWAfO5P8nGEW1Pg01koCMRBteyHSDPNdpy9/QXwECufpjMjOPQOM
         lRiNR0X6yqFCdI6TyiEDHJ/YPx5wIJan2270kQmNayroRCe+4Dd3XR0XYayYGgslNdSk
         qGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ztwW1p0aQ2mCbzMuBeWwugeB5xsSD7QoczddYbD4PI=;
        b=VEnJm0NMRwlf9QQ+dR05tK34yCQSW/KAEBIEG+2p0UJ85PVmuHYCecw3RjKY8ziHUz
         3tgBnixCIC+Ur33X+9SYGjejyYmLg9b/GHWBDy5C1kS6cGrJp1KzZrA1B1fzddNqgltx
         WwsCtPF3mDF1+Q+yYElzcKWlpxmCJZmYoVzpOwVU4hc5p3e4N7G3zat7WbK/CHyBfI6n
         C/L67N26Vo+1rl9coTyUNexBifl2AhxR5fQw0rTbMdyiXdfIPYZh7ED9+S7W3y7jYfmd
         M2T355iqOcY85zeFtSBKwrXifmKiEhyHkpzysZpkzJuKsxLJxsR7+GvVkkCzfQSqSiDD
         fFyA==
X-Gm-Message-State: APjAAAWZtPJee44a6ZyJBzwfh9M2AAawAbzweQWpwLXGLSFrunjiboZw
        cefLGYKKTL/YhJ4CmX62pecfrHtB58k=
X-Google-Smtp-Source: APXvYqwuxFOVkRX6TDquTfgTs9NrEIKnjOAGznYvqYsEDC1vJxwqPLrp73E6rwfeyHixlZBpIbzs8g==
X-Received: by 2002:a1c:9d86:: with SMTP id g128mr272900wme.51.1561507434886;
        Tue, 25 Jun 2019 17:03:54 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm33645982wrg.40.2019.06.25.17.03.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 17:03:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 2/7] grep tests: move "grep binary" alongside the rest
Date:   Wed, 26 Jun 2019 02:03:24 +0200
Message-Id: <20190626000329.32475-3-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <87r27u8pie.fsf@evledraar.gmail.com>
References: <87r27u8pie.fsf@evledraar.gmail.com>
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

