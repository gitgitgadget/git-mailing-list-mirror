Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5549B1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFRX2r (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:28:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41739 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX2r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:28:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so9751145qkk.8
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjlzvVO1JPURsSOsBfUZv8t0EuqI/VEQjnMH7ttmKVc=;
        b=E0Mdz7UW18ZJ48JxAvwtJp4NG371Ge8QjRCB5ABxZ6yfG4BthuvUXJABE/PMTHHtPl
         6yHgSrIq626ygJrJzEdjpyeIx8U5zeKuOE5l3dwdSAG+C5Y7R89esVMAMZfpXr0hSRI4
         fO+qDiozKkRkshM4MaRRkxmJyoEG4glrumphVVMRfaR5Ej+ZRjfoDoEQDClvScmjbcQW
         vn15OxsXLv2P/7Dwe3oP7VRUtUlZ/QsTF0NiDql/Wjef+GS8XfZip6uOVTD2Z/95k3YS
         SsOyLWJJlJj0X5wBKk5GUglXFJmxu2pN+VuJ/7mD45A10mTV5yZpL9BV2ce4lfY0m3iY
         MI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjlzvVO1JPURsSOsBfUZv8t0EuqI/VEQjnMH7ttmKVc=;
        b=k71/D1fK/u/ii9ylySBqpHNgDftcFYORRz1kMYINd/o1ldgbJqPFfJIwq6P4NKsXfb
         /nf5R7a2hK7+KNAr7AXuU4+z2PH80rf1Zl8yT3CJ+P5ig96bkgLNVpDdkJ3c+0ST6+/8
         7jmWeFKLbWqtPjMzpo12N87qriF+HAEQDmrjOj2miT717Nbw12pbQr52ZGOtFCDOVbDv
         Gs3ALJQHye7Gd9+zbBVCO680ciG9zKzfQ8QGg8yVy4jSzcyPtoXDNU6R3jxAyDVWqLj3
         O9XeFKijiON60NOqeMuU6VwGaOjQaYBsOtgEFAmxgyp/HmNa+f+dwYnEgvIaLwZYzNIm
         VNhQ==
X-Gm-Message-State: APjAAAXz1PD1iUwJbxEj7E5SweblUANi73sTCWLOTfIVQ0CSV6HKVJ1f
        AHCaEtiB+QoJ1IQHFvjSvS9qbCwdweU=
X-Google-Smtp-Source: APXvYqwRGvJXNVW9tcFRMyRaV7Pse7DfBit83htjG+OOK+Uh85wY3V+FsCdRGaHsf2yBz7AE13po8A==
X-Received: by 2002:a37:9ece:: with SMTP id h197mr77790958qke.50.1560900525500;
        Tue, 18 Jun 2019 16:28:45 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.28.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:28:44 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v7 01/10] clone: test for our behavior on odd objects/* content
Date:   Tue, 18 Jun 2019 20:27:38 -0300
Message-Id: <17c0ba24062a61eb7b3a03dc4d5630a64db1e9f9.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add tests for what happens when we perform a local clone on a repo
containing odd files at .git/object directory, such as symlinks to other
dirs, or unknown files.

I'm bending over backwards here to avoid a SHA-1 dependency. See [1]
for an earlier and simpler version that hardcoded SHA-1s.

This behavior has been the same for a *long* time, but hasn't been
tested for.

There's a good post-hoc argument to be made for copying over unknown
things, e.g. I'd like a git version that doesn't know about the
commit-graph to copy it under "clone --local" so a newer git version
can make use of it.

In follow-up commits we'll look at changing some of this behavior, but
for now, let's just assert it as-is so we'll notice what we'll change
later.

1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
[matheus.bernardino: improved and split tests in more than one patch]
Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t5604-clone-reference.sh | 111 +++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 4320082b1b..207650cb95 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -221,4 +221,115 @@ test_expect_success 'clone, dissociate from alternates' '
 	( cd C && git fsck )
 '
 
+test_expect_success 'setup repo with garbage in objects/*' '
+	git init S &&
+	(
+		cd S &&
+		test_commit A &&
+
+		cd .git/objects &&
+		>.some-hidden-file &&
+		>some-file &&
+		mkdir .some-hidden-dir &&
+		>.some-hidden-dir/some-file &&
+		>.some-hidden-dir/.some-dot-file &&
+		mkdir some-dir &&
+		>some-dir/some-file &&
+		>some-dir/.some-dot-file
+	)
+'
+
+test_expect_success 'clone a repo with garbage in objects/*' '
+	for option in --local --no-hardlinks --shared --dissociate
+	do
+		git clone $option S S$option || return 1 &&
+		git -C S$option fsck || return 1
+	done &&
+	find S-* -name "*some*" | sort >actual &&
+	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-file
+	S--dissociate/.git/objects/some-dir
+	S--dissociate/.git/objects/some-dir/.some-dot-file
+	S--dissociate/.git/objects/some-dir/some-file
+	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-file
+	S--local/.git/objects/some-dir
+	S--local/.git/objects/some-dir/.some-dot-file
+	S--local/.git/objects/some-dir/some-file
+	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-file
+	S--no-hardlinks/.git/objects/some-dir
+	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/some-dir/some-file
+	S--no-hardlinks/.git/objects/some-file
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknown files at objects/' '
+	git init T &&
+	(
+		cd T &&
+		git config gc.auto 0 &&
+		test_commit A &&
+		git gc &&
+		test_commit B &&
+
+		cd .git/objects &&
+		mv pack packs &&
+		ln -s packs pack &&
+		find ?? -type d >loose-dirs &&
+		last_loose=$(tail -n 1 loose-dirs) &&
+		rm -f loose-dirs &&
+		mv $last_loose a-loose-dir &&
+		ln -s a-loose-dir $last_loose &&
+		find . -type f | sort >../../../T.objects-files.raw &&
+		echo unknown_content> unknown_file
+	) &&
+	git -C T fsck &&
+	git -C T rev-list --all --objects >T.objects
+'
+
+
+test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files at objects/' '
+	for option in --local --no-hardlinks --shared --dissociate
+	do
+		git clone $option T T$option || return 1 &&
+		git -C T$option fsck || return 1 &&
+		git -C T$option rev-list --all --objects >T$option.objects &&
+		test_cmp T.objects T$option.objects &&
+		(
+			cd T$option/.git/objects &&
+			find . -type f | sort >../../../T$option.objects-files.raw
+		)
+	done &&
+
+	for raw in $(ls T*.raw)
+	do
+		sed -e "s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" -e "/commit-graph/d" \
+		    -e "/multi-pack-index/d" <$raw >$raw.de-sha || return 1
+	done &&
+
+	cat >expected-files <<-EOF &&
+	./Y/Z
+	./Y/Z
+	./a-loose-dir/Z
+	./Y/Z
+	./info/packs
+	./pack/pack-Z.idx
+	./pack/pack-Z.pack
+	./packs/pack-Z.idx
+	./packs/pack-Z.pack
+	./unknown_file
+	EOF
+
+	for option in --local --dissociate --no-hardlinks
+	do
+		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1
+	done &&
+
+	echo ./info/alternates >expected-files &&
+	test_cmp expected-files T--shared.objects-files.raw
+'
+
 test_done
-- 
2.22.0

