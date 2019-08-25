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
	by dcvr.yhbt.net (Postfix) with ESMTP id 006141F4B7
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfHYJMB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35488 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYJMB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:01 -0400
Received: by mail-io1-f68.google.com with SMTP id b10so21167870ioj.2
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TKDvTqZf80fYls4LhhS3c/qR/fiLjGqIWXxPJZwt39s=;
        b=TV6IQRG23KgMNve8xDNMXdSmD1BGajzJehCiyLMd71qNtZ5BrTDwt45+uaCOKq//oE
         sT23YvoHJsphb2ccpOx0zhjlHuDHEhlAcrwZjnQi0S3C0lX+I3slvDJk0xHERcfpPDa+
         S6bEQAQ5f/jKm3gAkat3+kZ0AmUSD4wJ5dVdv4ipx5v0NbfYqXYFmCPYZUdbOO1Mz9d7
         8qygTfbxk5hem1ad6JpyRHlq6s6etcFaB3tFKiLymmhgmjDwqpyugNxTGiTp6n83b+JT
         wctTaMQ8gqi9E3QiGWr9skmE+ncFTf7M65TSt07Jb+nEQ27WNw+kXpZLvcRTwf/rsQhO
         n2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TKDvTqZf80fYls4LhhS3c/qR/fiLjGqIWXxPJZwt39s=;
        b=Lnn1jnznYZ1yuI/It7by0o5cJcBb5nNtS6d68iUMaL5apZzzsmmeFtCuO0PQDKd2j/
         jq6GAGsPYUGIWjX4QWwnbCTyMLuJFpYWeujGl3tnVT2E3rgHp3z/MIrcozqKE8GSXORS
         DDNokqmWJouD+AP1MZU6wBh0c67Ya6Bpw4YHNi59boHYCPvWQwe+pqUzYrzdXfN0gXQv
         1IJXttvwbw/9grKWGpX4UKcTIvFSv0RRYam6ZEvm+HBR2fXNnbcfc7VNZO2UgEoXrwSg
         USHlEWCmv6IVYXuQwU+AQbX5GwbtcRAApkf5GSMiagW1qxZDOAJyADRaEHKlOS+6Oh99
         hINA==
X-Gm-Message-State: APjAAAUw1seMpDIXrvYQrLYUaRYloDu1PK28Ur66aJRpEuXckZWqn2Uo
        GwTYRni/gK85g2i/GlZ6mjCSsDcY
X-Google-Smtp-Source: APXvYqxElR1OAln/GKnY151RInOBY4J4VeBY3pz9f9SuniQE9V1/5iXeGSxd2eqpr7uWUlpaa/3uxw==
X-Received: by 2002:a6b:f910:: with SMTP id j16mr17232248iog.135.1566724320116;
        Sun, 25 Aug 2019 02:12:00 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id k3sm9654471ioq.18.2019.08.25.02.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:11:59 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:11:57 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 1/9] t3431: add rebase --fork-point tests
Message-ID: <03f769d410447fc2db3b6dd18cdcc5f6eb160f62.1566724236.git.liu.denton@gmail.com>
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

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3431-rebase-fork-point.sh | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 t/t3431-rebase-fork-point.sh

diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
new file mode 100755
index 0000000000..2d5c6e641e
--- /dev/null
+++ b/t/t3431-rebase-fork-point.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='git rebase --fork-point test'
+
+. ./test-lib.sh
+
+# A---B---D---E    (master)
+#      \
+#       C*---F---G (side)
+#
+# C was formerly part of master but master was rewound to remove C
+#
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	git branch -t side &&
+	git reset --hard HEAD^ &&
+	test_commit D &&
+	test_commit E &&
+	git checkout side &&
+	test_commit F &&
+	test_commit G
+'
+
+test_rebase () {
+	expected="$1" &&
+	shift &&
+	test_expect_success "git rebase $*" "
+		git checkout master &&
+		git reset --hard E &&
+		git checkout side &&
+		git reset --hard G &&
+		git rebase $* &&
+		test_write_lines $expected >expect &&
+		git log --pretty=%s >actual &&
+		test_cmp expect actual
+	"
+}
+
+test_rebase 'G F E D B A'
+test_rebase 'G F D B A' --onto D
+test_rebase 'G F C E D B A' --no-fork-point
+test_rebase 'G F C D B A' --no-fork-point --onto D
+test_rebase 'G F E D B A' --fork-point refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F C E D B A' refs/heads/master
+test_rebase 'G F C D B A' --onto D refs/heads/master
+
+test_done
-- 
2.23.0.248.g3a9dd8fb08

