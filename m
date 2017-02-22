Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE0D201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932597AbdBVOIm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:08:42 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32905 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932562AbdBVOIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:08:41 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so563894pgj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JbGnwI8TSciQ+wKgNUm0sJGpyXsufAqOQMUn/orIao=;
        b=EIhtMVOfq3EE+pA6aJxzeMn6Hr/8dL7+yDuvkBsltew4NJaP4X6eCpUVXscOG3X8jB
         GooddrpU+IYWSWLv/rC3cDtKykNgaWuquQLNdbj+UzNEOXu2QsC85Ax9Me34yoK6MPmt
         N3ZAMxUaFTuTWUohTgqoeYmp59lPPRFvTbuIyATHMPzVrkdfa5XnLteSfSPxuQWpGOaD
         4yc7A//QtfqKPVlPjdw9ZJlx1IOpwuK6Zpvyqp1tC5Cij0owXxlL5V4AGDQ3CI9e/PgD
         LkkdU+sWwS5k/vdOJ2ZRWcwQeQmTVZiTiQ6Jghb+W+zQe0qh8yealf6il78G1ZxNRQpF
         w1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JbGnwI8TSciQ+wKgNUm0sJGpyXsufAqOQMUn/orIao=;
        b=WWHb3GjupaNg6Fi6YC93qYG00VAD5Pves6NZor7mHDdOZuiHzYdFFGetPnJmlCSVHd
         ZIDFrUMnqOBbZA1hXwhUSypL1Fm99ub3PSUdpnG8l0z1oAM6+QrmhPJbOtgKetvNL09H
         rvpsEHqtZ52od5IcsjJ752AzG4rAcVlwLZ40bZ5FcszEOkvxfOSYXsGDBEEHT+5czl3L
         ct1i/qTOIfST/Fdgy8+6feDHpHA7OJ6uj7Hv/VxnJpXYprg/kq5n8J6iTzGxXZbgQRra
         oW4XCUPuimSJEH1Z3Ldu3GDBlsAr0QvNVKT84WMFcyTu9LNcdy2mbINRARa0E/I57Oks
         1oWw==
X-Gm-Message-State: AMke39nMlokiowPZFbW6dEiPgsvG6zHJrRR+//ei2tgKEH7gNEW8/6Y9ky2IaPgMR49hgQ==
X-Received: by 10.99.222.17 with SMTP id f17mr42671376pgg.127.1487772520247;
        Wed, 22 Feb 2017 06:08:40 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z7sm4046548pfz.128.2017.02.22.06.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:08:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:08:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 24/24] t1406: new tests for submodule ref store
Date:   Wed, 22 Feb 2017 21:04:50 +0700
Message-Id: <20170222140450.30886-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t1406-submodule-ref-store.sh (new +x) | 95 +++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100755 t/t1406-submodule-ref-store.sh

diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
new file mode 100755
index 000000000..3b30ba62f
--- /dev/null
+++ b/t/t1406-submodule-ref-store.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='test submodule ref store api'
+
+. ./test-lib.sh
+
+RUN="test-ref-store submodule:sub"
+
+test_expect_success 'setup' '
+	git init sub &&
+	(
+		cd sub &&
+		test_commit first &&
+		git checkout -b new-master
+	)
+'
+
+test_expect_success 'pack_refs() not allowed' '
+	test_must_fail $RUN pack-refs 3
+'
+
+test_expect_success 'peel_ref(new-tag)' '
+	git -C sub rev-parse HEAD >expected &&
+	git -C sub tag -a -m new-tag new-tag HEAD &&
+	$RUN peel-ref refs/tags/new-tag >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'create_symref() not allowed' '
+	test_must_fail $RUN create-symref FOO refs/heads/master nothing
+'
+
+test_expect_success 'delete_refs() not allowed' '
+	test_must_fail $RUN delete-refs 0 FOO refs/tags/new-tag
+'
+
+test_expect_success 'rename_refs() not allowed' '
+	test_must_fail $RUN rename-ref refs/heads/master refs/heads/new-master
+'
+
+test_expect_success 'for_each_ref(refs/heads/)' '
+	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	cat >expected <<-\EOF &&
+	master 0x0
+	new-master 0x0
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'resolve_ref(master)' '
+	SHA1=`git -C sub rev-parse master` &&
+	echo "$SHA1 refs/heads/master 0x0" >expected &&
+	$RUN resolve-ref refs/heads/master 0 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'verify_ref(new-master)' '
+	$RUN verify-ref refs/heads/new-master
+'
+
+test_expect_success 'for_each_reflog()' '
+	$RUN for-each-reflog | cut -c 42- >actual &&
+	cat >expected <<-\EOF &&
+	refs/heads/master 0x0
+	refs/heads/new-master 0x0
+	HEAD 0x1
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'for_each_reflog_ent()' '
+	$RUN for-each-reflog-ent HEAD >actual && cat actual &&
+	head -n1 actual | grep first &&
+	tail -n2 actual | head -n1 | grep master.to.new
+'
+
+test_expect_success 'for_each_reflog_ent_reverse()' '
+	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep master.to.new &&
+	tail -n2 actual | head -n1 | grep first
+'
+
+test_expect_success 'reflog_exists(HEAD)' '
+	$RUN reflog-exists HEAD
+'
+
+test_expect_success 'delete_reflog() not allowed' '
+	test_must_fail $RUN delete-reflog HEAD
+'
+
+test_expect_success 'create-reflog() not allowed' '
+	test_must_fail $RUN create-reflog HEAD 1
+'
+
+test_done
-- 
2.11.0.157.gd943d85

