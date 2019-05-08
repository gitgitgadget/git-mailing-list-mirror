Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBF31F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEHANK (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:10 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46255 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHANJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:09 -0400
Received: by mail-wr1-f45.google.com with SMTP id r7so24619534wrr.13
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQ7XxDyjeVv7EJvFP5NNziTP961SVcs/eqr8f7gM980=;
        b=K/ERM4q4yTgPMmxYEXbzleU5lFn+xxidu+VtQUmZ/kXonk9kpBJ7o+dy4QR6qX255e
         9q8QbUsosxDwiwouFUE9lIM5q9tuetwnkOJ7vKWrThuclmEX2bZNNX9t1GzZlZ/YAgxc
         CZWlM8ybBQvIeCGBMdiBi/lVPDY4DTI/5smfDwLqooWF80RcLlsYdNRUp/gdhWrs26zT
         sp82SkPfGnQ0YiC7u7FMNIs6pHK7UjV0kk6509Rb+FLlNwB2tku5v8UoWrAERIkKdD6d
         EyVQj5diji9Rf6///B7t+56AHXT1z1Z6yAZp5UaeoZF5jvFu57dJA0Gcs1PUTQbi5GIH
         xDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQ7XxDyjeVv7EJvFP5NNziTP961SVcs/eqr8f7gM980=;
        b=gN08TnD8zoMp307IVWzl8O4ej4uIhFhBP1jAP1SL7+pmoMwcp6O6MmEkv2Mnnijoxi
         Ltk37TqhhTv4lY9ySGYhXZUHcELT8DGBkf7rBdsY3U8nH3qVLYoPGdKYNyzz4ZNpaeuM
         jgdoYoKrHr8rYaooHEWTiUiP4Wzp0Z8dnq+c9Lvip00pFn722991fkF8/1ep3W3itRk2
         nZoI9famh3ht3Yk0/9wtg9KVxWZin8jgYO992Wa/vOyekLeVEalCRp8To0OWmvmcWiyU
         Ff+w9B/S0Zb87h+ol4dJvG8lV25iC7aaAVB8ri+2WZPslJkmQNI6jXhDvqBRYomczV6E
         XEHQ==
X-Gm-Message-State: APjAAAWXbyUf2TnHdWDzxYs/vmDnJvTuo7hYnseYK8L2VXcB7O0QzhS8
        YmLXqnHlLaxDPLdiiFGv4RaH5fcYE8A=
X-Google-Smtp-Source: APXvYqw7yYk/5lcLrlJoeKWTj34ezigCNcSWKUzLbPVXN+BcUVOqSwtiX/8jzI/gDEnaOLftG28I6Q==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr1796998wrp.67.1557274387830;
        Tue, 07 May 2019 17:13:07 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC WIP PATCH v8 01/13] t3431: add rebase --fork-point tests
Date:   Wed,  8 May 2019 02:12:40 +0200
Message-Id: <20190508001252.15752-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.21.0.1020.gf2820cf01a

