Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E871F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfH0Fhw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:37:52 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:36192 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Fhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:37:52 -0400
Received: by mail-io1-f53.google.com with SMTP id o9so43432835iom.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aJqreQ1u4yffuKur/dcuZd7kRv6dWtyTb9G88XCHYcY=;
        b=IT5YMkP2gQa6QeKRlOOlOKc3JLL6PhVT94tZ4fucTpghJijkrMivy3akzyjt2R4HPj
         eFiPCdwtGy5k+anekR6b5tmje99TGJq2cv6FtdnJCc70D3xDKasNVPOe0j5cXxd9dw9c
         SU/aYwLo+wv39Hy8kw1lzgXLzHL/JbHQmICVhIN1FYhNW0lFKZamzqLoFLIhs3DrxfEO
         vU9Q2mEIZrX14s+6/7RoQFMJKm4qHTJtWPjehYwLkG7XSujPa9n/zlMjz0uSVP2TQRzi
         9C0TlBNPgvI91sx7CpS3Oa7ZhXFis0kyRgj5pMDFxRgcybQUDPEEk3BxG/EbTOS51jCg
         0gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJqreQ1u4yffuKur/dcuZd7kRv6dWtyTb9G88XCHYcY=;
        b=C2s3HWC/aLU5bO3B5xCK4EK00H08PtNfDJgcWBdX4zoFVxgMNvYNmCJw03UrGbV/nz
         vhDKIvE46DcfzzSXILToe4ZNfD30ywUGFeRgimApOEYzTVJLDbidwzXuyp8LFCMOTlon
         jNbgbbS7H4qLNh4Pco00Ky4WtvNt0CGI/5E4+3HwbLAbMyY9jwnWyT5H8F3t8QSgPRMZ
         mfmfcjZH72UOvVU9rDydxIFNnx3DLij9ydl1H/mH/L+LZUuBpKVMnTHyMjzNOc/GzDU9
         kIP/IKKpiZrzWSQfQ0wnFfev+2IqMY0EbXVyYzq0Ec8HCovHzT8ITduIxVCJ6Y195JI0
         UjOg==
X-Gm-Message-State: APjAAAXe79HaCMzvOGV45O6ub+dkzCrUDsT0+/gX+rAH+EskpjMAEh0+
        4DIj7pEZF9kXy8nc5RUPZVnIO3Uy
X-Google-Smtp-Source: APXvYqwPxpcVIlQq+knYMNUrxEyxlHDK8ixAYd+UV+wFeZ5q13rVOpio2EBPJxRq/LGAvjjzzN8klw==
X-Received: by 2002:a5e:9244:: with SMTP id z4mr3614925iop.127.1566884271288;
        Mon, 26 Aug 2019 22:37:51 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id j11sm707406ioa.55.2019.08.26.22.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:37:50 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:37:49 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 2/9] t3432: test rebase fast-forward behavior
Message-ID: <bc8998079dfce14e88e3c6145740fda04d1c82fe.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566884063.git.liu.denton@gmail.com>
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

