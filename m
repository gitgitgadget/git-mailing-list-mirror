Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76BF720248
	for <e@80x24.org>; Mon, 15 Apr 2019 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfDOW3Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 18:29:24 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42358 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOW3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 18:29:24 -0400
Received: by mail-pl1-f175.google.com with SMTP id cv12so9288048plb.9
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+jGxpYpqOozD2fbHVzCIdAuOR4CHxaRcTMKY/8ZWXc=;
        b=IucAF+bKJMYfvrSDe6qTd6/Av4W51oEsbzzuX1leLworaO9edVcOQ1yBbtLrhLRns2
         xXR3dQnWC8eO0Alj1R1qNMxL6kKDRgrxVdUSuJ45VUBz+hmXcIvDKA7vY3lkWTF/9jJB
         6+6Ldm2PvTxvhv+lf7S8lEmhy3MmbiMsj4X2S3dVbj/9V7Ot0JRx5fPpC5Oefe9PeJsp
         MHAEmPvE7hr8/KfcEjByfzzsgXCu7N/IKafQd6PzdL4fslfDXW/mx+E8TMrDW1ldPkgU
         XUPiSsLiRliCou9tUI8ulBEySuxRcbgdoDK/XaOvmtXh8ES+yH7MmGuL1Cb6pY7kAASE
         QiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+jGxpYpqOozD2fbHVzCIdAuOR4CHxaRcTMKY/8ZWXc=;
        b=Sc4lGSl+LptCFBUW8nWgg3sgAIH5HwGUA8C0xepw92KjZG0Tp2LF6YA6ATu4sqp9r6
         PDS07ve7goiq2YDEJJqIe+qqS/nxsOzawU63USIkoJke9a00c5eZcZff7vR1kffhfgr8
         upX60LGUEXUkZmdLCQ5fbIrsSYKwcImFEjTMEAodyDXQr5QpcpTWs5Bjf2AgkcgCBAGo
         vOosli9QV2Xbyhgt83B2SF/94DCdt/vGHUQJaSnbp9vz8lKIzwGZ68tuFlEOFXLzuE0R
         heRnwKX0wdvOGYGflnc53iwMkuyfeBXnvd3BldswsLVpyrVPWWpVP9o1I3WnTWTgd5S+
         CZsg==
X-Gm-Message-State: APjAAAWjZuRpWJkdAc+2brZ/yAtctabEDejrJRzEussemJzmbUNdH4DS
        Mw+fwywUKmuWKlpa4XGa8xjbSIgQ
X-Google-Smtp-Source: APXvYqwJUlxVdJJOxLpmShdXNdCkmUgCi8+Zltqf4mP0ogwG8C2KscLkhvlYbHUL5RU1c76dugsReQ==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr78080961plt.180.1555367363035;
        Mon, 15 Apr 2019 15:29:23 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id t13sm58495888pgo.14.2019.04.15.15.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:29:21 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:29:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 1/5] t3431: add rebase --fork-point tests
Message-ID: <0f1e9ac5c8b88649a378f676ee924a966ce0693c.1555366891.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555366891.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555366891.git.liu.denton@gmail.com>
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
index 0000000000..6d523123d0
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
+# A---B---D---E       (master)
+#     \
+#      C*---F---G (side)
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
2.21.0.921.gb27c68c4e9

