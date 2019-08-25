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
	by dcvr.yhbt.net (Postfix) with ESMTP id 702271F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfHYJME (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:04 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:32938 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYJMD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:03 -0400
Received: by mail-io1-f45.google.com with SMTP id z3so30294730iog.0
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aJqreQ1u4yffuKur/dcuZd7kRv6dWtyTb9G88XCHYcY=;
        b=Y4xkqfSSmfpTY+AhfHzmLanETUQQ8KVTjeQMqGBhjZNoZGr0cUgDbSdPODFAmvtQhL
         2JieKFeWpWXEZvbBxFJcCNp3CFVZWWAtvL6JKiR0jszmyZQqvVayBje6dTUcu1i+bigw
         qOWgqgIq3x1dJ35BsP2Rmnvsl8DolCixd6M1odcN8Zy7aLMkauKyRNG7rBm8C5IypORn
         +GmoBX62qZPqGEITsaVh3dMhErJ8XZxedbhv6ud2clj1UVxMO/+4bcDyZ0B2cmFc3IcM
         ZOUZZawAhiV23A83TlX7aCZzWIlzjUeoMqpvj3YpzbB4s/D7auMhJQz0xFjBgMEyMxhc
         FSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJqreQ1u4yffuKur/dcuZd7kRv6dWtyTb9G88XCHYcY=;
        b=SdBvpX+EEhBy8rGIYsitJaUTsH09Ky3KrvFJqbfMk9OVL0NH/6u9SrDbfqRBE9OgDP
         fOxwRzE68bXKCO15WBgnsQTx8/KYKJ4L0wSgs6G49NgL2pMFadmwfyhFTDOvSGaQC2dO
         QRcv04GlPMejaVwB0VapeeqZj/kfj7+oOawz5NPQLjM31vyIISzqMueZng3HXfHWfcD9
         Kb2Cs66hm75YC/TsXy5IyCTSe+Fz42HBf+ZARsrC5SSuO2OIm79MxqsqmE+TtwUBZ2gW
         Fejt0Hvlx63+qR01n50Ii9bO/6Afk6vGH++1f8/0lUi3HtD8q4aMa5qcjJb/EvgTzSPW
         QhsA==
X-Gm-Message-State: APjAAAWqNgW0p4JjG5fzICM4cXP7gMxu2A/KwV//trnfIgDIKPY9wICZ
        AfYe++gg6qJQs1rb++v3t/BNCP57
X-Google-Smtp-Source: APXvYqyv1XCRJnrg9y1a3lbBK6CfmETXXltfeQUOrmf5aaQ6ZFvGSaIxxPzSrOcCGMyawftlqMHdjQ==
X-Received: by 2002:a6b:f008:: with SMTP id w8mr3914471ioc.60.1566724322615;
        Sun, 25 Aug 2019 02:12:02 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id h9sm7806216ior.9.2019.08.25.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:02 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:00 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 2/9] t3432: test rebase fast-forward behavior
Message-ID: <bc8998079dfce14e88e3c6145740fda04d1c82fe.1566724236.git.liu.denton@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebase is run on a branch that can be fast-forwarded, this should
automatically be done. Create test to ensure this behavior happens.

There are some cases that currently don't pass. The first case is where
a feature and master have diverged, running
"git rebase master... master" causes a full rebase to happen even though
a fast-forward should happen.

The second case is when we are doing "git rebase --fork-point" and a
fork-point commit is found. Once again, a full rebase happens even
though a fast-forward should happen.

Mark these cases as failure so we can fix it later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 t/t3432-rebase-fast-forward.sh

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
new file mode 100755
index 0000000000..f49af274e0
--- /dev/null
+++ b/t/t3432-rebase-fast-forward.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='ensure rebase fast-forwards commits when possible'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	test_commit D &&
+	git checkout -t -b side
+'
+
+test_rebase_same_head () {
+	status="$1" &&
+	shift &&
+	test_expect_$status "git rebase $* with $changes is no-op" "
+		oldhead=\$(git rev-parse HEAD) &&
+		test_when_finished 'git reset --hard \$oldhead' &&
+		git rebase $* &&
+		newhead=\$(git rev-parse HEAD) &&
+		test_cmp_rev \$oldhead \$newhead
+	"
+}
+
+changes='no changes'
+test_rebase_same_head success
+test_rebase_same_head success master
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head success --onto master... master
+test_rebase_same_head success --no-fork-point
+test_rebase_same_head success --fork-point master
+test_rebase_same_head failure --fork-point --onto B B
+test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head success --fork-point --onto master... master
+
+test_expect_success 'add work to side' '
+	test_commit E
+'
+
+changes='our changes'
+test_rebase_same_head success
+test_rebase_same_head success master
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head success --onto master... master
+test_rebase_same_head success --no-fork-point
+test_rebase_same_head success --fork-point master
+test_rebase_same_head failure --fork-point --onto B B
+test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head success --fork-point --onto master... master
+
+test_expect_success 'add work to upstream' '
+	git checkout master &&
+	test_commit F &&
+	git checkout side
+'
+
+changes='our and their changes'
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head failure --onto master... master
+test_rebase_same_head failure --fork-point --onto B B
+test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head failure --fork-point --onto master... master
+
+test_done
-- 
2.23.0.248.g3a9dd8fb08

