Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1157201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbdBVOIf (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:08:35 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34654 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932562AbdBVOId (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:08:33 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so560987pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oRs25nOSmyvYMLH4WNidBo8c+VIwNUr059FVBWSMGE=;
        b=ZBFBsGMb1K4gIja1Lm6c5fTbE1JnGUxkUQa2QnJwKxKW1YLUAT90r6zE4y6AczAD16
         B0neHwUn3zw9/oci+dRLDTWBzpdeLuVHt3Kt3UrC+sVBkN7P/Myd5kI6iXKk9AfSl7eL
         FiPfL1Yh5XQdSc/ximnfQhgqQ3QRus2N7YS05ge/y/re/psfHpdyaucYynwmKIOkjAyF
         kRtvlvBx6o2YES2xaSsJJcZLYyyVGBc33WbwTbaOGAz7scC8fYUECfCJg3kc2RaW5row
         adVVCKBcrJ4weTPI/mJOWUm4LHlZOvhktUGirabP4iYpuoTj67t7/9KbTWS5wU9tkvOQ
         Z0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oRs25nOSmyvYMLH4WNidBo8c+VIwNUr059FVBWSMGE=;
        b=aj+VoZENBCmAQb0qwu5SvtxXqgU5P6y5/N1awmIrwTXtiy3Wap1JUmlFoE7zZvsurO
         MyNq7R+sayMYlRQwQ0Sd0lgWtGpPomaYPohlIpcSEvK87OL0qiwfDfuX/AkjxrLSaJE3
         VuTftWd6DO2ceURvQEdADhTdKWIe2ozaMMba6aewOGG9qeZpctYtgO14fUy/Q6aWckIf
         BAH8hvMrtiaKS7U38ChH1ZlXHAcVVGfT4F2SJathDDkptmHT0d3quZbocAuUL6zP9dLJ
         FBnr8fQWhDGyTJ7u3TeEyDIvD7YqpyUdRuwF43hO0l9PAcPPBRZHHUL8jq7Pj4Ve0zVa
         HDWg==
X-Gm-Message-State: AMke39l4LJTbX8a8R5bq0MfM2jXfXjHM3DTTBIkZ+IVwm33PqREQKq00oBt156ie85kCfw==
X-Received: by 10.99.124.3 with SMTP id x3mr30883165pgc.146.1487772512475;
        Wed, 22 Feb 2017 06:08:32 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id q90sm4086545pfk.73.2017.02.22.06.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:08:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:08:25 +0700
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
Subject: [PATCH v5 23/24] t1405: some basic tests on main ref store
Date:   Wed, 22 Feb 2017 21:04:49 +0700
Message-Id: <20170222140450.30886-24-pclouds@gmail.com>
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
 t/t1405-main-ref-store.sh (new +x) | 123 +++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 t/t1405-main-ref-store.sh

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
new file mode 100755
index 000000000..0999829f1
--- /dev/null
+++ b/t/t1405-main-ref-store.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description='test main ref store api'
+
+. ./test-lib.sh
+
+RUN="test-ref-store main"
+
+test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
+	test_commit one &&
+	N=`find .git/refs -type f | wc -l` &&
+	test "$N" != 0 &&
+	$RUN pack-refs 3 &&
+	N=`find .git/refs -type f | wc -l`
+'
+
+test_expect_success 'peel_ref(new-tag)' '
+	git rev-parse HEAD >expected &&
+	git tag -a -m new-tag new-tag HEAD &&
+	$RUN peel-ref refs/tags/new-tag >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'create_symref(FOO, refs/heads/master)' '
+	$RUN create-symref FOO refs/heads/master nothing &&
+	echo refs/heads/master >expected &&
+	git symbolic-ref FOO >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
+	git rev-parse FOO -- &&
+	git rev-parse refs/tags/new-tag -- &&
+	$RUN delete-refs 0 FOO refs/tags/new-tag &&
+	test_must_fail git rev-parse FOO -- &&
+	test_must_fail git rev-parse refs/tags/new-tag --
+'
+
+test_expect_success 'rename_refs(master, new-master)' '
+	git rev-parse master >expected &&
+	$RUN rename-ref refs/heads/master refs/heads/new-master &&
+	git rev-parse new-master >actual &&
+	test_cmp expected actual &&
+	test_commit recreate-master
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
+test_expect_success 'resolve_ref(new-master)' '
+	SHA1=`git rev-parse new-master` &&
+	echo "$SHA1 refs/heads/new-master 0x0" >expected &&
+	$RUN resolve-ref refs/heads/new-master 0 >actual &&
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
+	$RUN for-each-reflog-ent HEAD >actual &&
+	head -n1 actual | grep one &&
+	tail -n2 actual | head -n1 | grep recreate-master
+'
+
+test_expect_success 'for_each_reflog_ent_reverse()' '
+	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep recreate-master &&
+	tail -n2 actual | head -n1 | grep one
+'
+
+test_expect_success 'reflog_exists(HEAD)' '
+	$RUN reflog-exists HEAD
+'
+
+test_expect_success 'delete_reflog(HEAD)' '
+	$RUN delete-reflog HEAD &&
+	! test -f .git/logs/HEAD
+'
+
+test_expect_success 'create-reflog(HEAD)' '
+	$RUN create-reflog HEAD 1 &&
+	test -f .git/logs/HEAD
+'
+
+test_expect_success 'delete_ref(refs/heads/foo)' '
+	git checkout -b foo &&
+	FOO_SHA1=`git rev-parse foo` &&
+	git checkout --detach &&
+	test_commit bar-commit &&
+	git checkout -b bar &&
+	BAR_SHA1=`git rev-parse bar` &&
+	$RUN update-ref updating refs/heads/foo $BAR_SHA1 $FOO_SHA1 0 &&
+	echo $BAR_SHA1 >expected &&
+	git rev-parse refs/heads/foo >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'delete_ref(refs/heads/foo)' '
+	SHA1=`git rev-parse foo` &&
+	git checkout --detach &&
+	$RUN delete-ref refs/heads/foo $SHA1 0 &&
+	test_must_fail git rev-parse refs/heads/foo --
+'
+
+test_done
-- 
2.11.0.157.gd943d85

