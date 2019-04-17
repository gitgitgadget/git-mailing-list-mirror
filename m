Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3B020248
	for <e@80x24.org>; Wed, 17 Apr 2019 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfDQSB2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:01:28 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46755 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDQSB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:27 -0400
Received: by mail-pl1-f180.google.com with SMTP id y6so12366695pll.13
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbooXkmfFrU3lzEiQrq3qhvTIrSt4itjBeJHI2ai+q0=;
        b=Sjc5Frjoe09SrQimI6GyCRcP8RRkRNy/bTKpSD0n4creklu1SY+GMfsR9gLO8lg86t
         KDdsx0mZLBoiBBGVbcKQfQ3wkE93ik+d3EoSxDaw6Jo0pe6q28Bjl5Ay0rsfTLMsJVF9
         /mo8SwResZDteOFwKN0gK3p2qImApWqZw0Le2Xsq7yOIIve/kHjEYieQrvGKy0cA8LOV
         gss4rNU0GJN6Yqc/rTm7FOZUl5bRQSGunfj4h7OXCguRDaPnCft0K+NtcJcalJ/CyP1a
         GgaJqvK58K+iN0UroSy/Su1mDWWQe4zoF7a3TdwTqPS0DphlquDMKs9NzHJnPFrzlDu+
         H7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbooXkmfFrU3lzEiQrq3qhvTIrSt4itjBeJHI2ai+q0=;
        b=iwUxv9tSyygrPRmHv1wA0X8V2GnmoNuIe7ETuops5pjCefPPWLTFkg29LOfcPKmYpj
         J7c93AW2ndLrrltNBJ4wdsO+yx0zGmFj6hnwHa5IPNABDTxYB3Evuw5x+6QfLPL9Ph6H
         2dFi4mGGVjE36JzvAZq7g3UoNFh0tRzdNVN3VzCo+RHqGFdzTDMR8BOH6jgHu8NyzQD7
         JeK78SPVwmboLT4sTMvDj1cvXYwuPUs4lyLvYIJcBaUagjQqx/d2JL/bfVWEHFnvxk5A
         x02MqUDiLkdR/MnHSmPqlhTNymgymw3+sKTk0K06byOwfJ/0dgYA6CJh2roS11T69Zst
         sa9w==
X-Gm-Message-State: APjAAAUGt2R5GVqe1AB/pwU04Zb6GRqB/7IoEAzRUVP2IbBvHobXHU4A
        b5UljNfUV8cYXH/VFEjZ1HqCMwn/tMI=
X-Google-Smtp-Source: APXvYqyKMeBoor0e6qFtp8lBeSCzxyxahy3ADmNBrfHszhmn/SKwahAfd1phgxHwlVF/vwT2d7wrGg==
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr87707338plp.165.1555524086598;
        Wed, 17 Apr 2019 11:01:26 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id i15sm79012768pfd.162.2019.04.17.11.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:01:25 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:01:24 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 1/6] t3431: add rebase --fork-point tests
Message-ID: <eb64f6c91d27a6f9666c9829050995d9f9b52925.1555523176.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555523176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555523176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
index 0000000000..9b517d87a3
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
+test_rebase() {
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
2.21.0.944.gce45564dfd

