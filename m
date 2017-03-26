Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8610B20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdCZCpp (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33356 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdCZCpo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id p189so4078557pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4ALuijeqEe/LymVDdhmZ23csh4tuKP2jw5oIfi5Fs8=;
        b=ZI3Rdt88gOfEMjo3turYLFLSBFTYMT9xWHDstBhQCX9ZZu751SfvtdkAhMxk/PGkQD
         /lYgMU/iV+YM0B6a6TIdF4aFDXv3AtHwIJ9uZO4alKVBa1uZbivpf+fqRxCB2Y+2zj7M
         IqjdHDmtgyV4cPWEuwAR2EmX7iqN9hdYMgQdIFZAU+jn5lDxXKj/jzkUlNxQmehK3f68
         cnBZJ/5DxOcpWPn4nDU/QI9bulzOr/mfmix0eg93aBJf4JzyGM0J7BchI/gBggBIVTGh
         +OxWjSfVpHY5UtqVl2QXWKD4M2hfqNoG3UbOY8tcfdDxs7cG0ABk024jGYGF045Ru/fj
         HxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4ALuijeqEe/LymVDdhmZ23csh4tuKP2jw5oIfi5Fs8=;
        b=f4Rr43JzDsorUnow2terU/6iDYCPokOgg07Ab1dvSmrGd2v0KBS8zqFPms5WJJ5d6L
         /2p/Pp3WeEaNI3D2ECBfihzd+UzsK1Vkt8X+JKb47BrW9mTg78d67G9A2WhijvcdqNsf
         8jd5Cx3wtaESEmafXMye3oY4zPrZlwqBfB1IpjZxawLf5qh8NR4H5WqzeoqM85CRb+U9
         77SFaOIUDumgMrLNgu1sppyd9zRdZu5dQzAlgbWEnPyu1bEmZELZO38Nh3nVouE5ZAlz
         iil48fFQfYijKZEh/8AvTTrPY7uXhC4Spe+0hiWd4NlKd53f1P9RKkOI+y62ZvthdS0n
         VvsA==
X-Gm-Message-State: AFeK/H3Df771zXv2WzPKKj7DAfp1gGCtlObJXBiaz5CTDIHzFrSACm6XR7cL00EvjWOrig==
X-Received: by 10.84.191.165 with SMTP id a34mr20851997pld.62.1490496337761;
        Sat, 25 Mar 2017 19:45:37 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id a21sm12582560pfc.36.2017.03.25.19.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:45:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:45:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 26/28] t1405: some basic tests on main ref store
Date:   Sun, 26 Mar 2017 09:42:39 +0700
Message-Id: <20170326024241.31984-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
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
index 0000000000..77e1c130c2
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
+	$RUN for-each-reflog | sort | cut -c 42- >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	refs/heads/master 0x0
+	refs/heads/new-master 0x0
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
+	$RUN delete-ref msg refs/heads/foo $SHA1 0 &&
+	test_must_fail git rev-parse refs/heads/foo --
+'
+
+test_done
-- 
2.11.0.157.gd943d85

