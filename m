Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CC71F453
	for <e@80x24.org>; Thu,  2 May 2019 14:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEBOsq (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:48:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37062 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:48:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id e2so1145293qtb.4
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiCRl9E184AC0nezd5RzjQnNgANF2yTHWJBF21CgeeE=;
        b=bgApjxZenseEIHl4eeQRSjyEDkka2SJyGGIWrBPEFN5l+auxN3U0gm3F3HfMAMu/un
         sNypCXDiWifd5axDN/Ezzr81b3RxVMlsq1WZld2m1J/L7sQdm9EKSra6lEtXm2dyKEJc
         mlSb9XKQhn6H2DhiIe6aMyV/5tJelbTbbSoGGDiZbUdXc5HZ6Z93q28ULRSvwzfsg1rZ
         KERZ4NIW5KtlaII4gmnLwegri9Hh6Gkb3YxYHjs2TWPt1Yymv/72xXg2TlgPFtWSlzAp
         Bkj6K5mUa/5irVVWvM0f+J/HuKCKKLsWFoEK7dbmp3L8ekfxeZ91ZLgvlmG4gLsJi1hK
         grzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiCRl9E184AC0nezd5RzjQnNgANF2yTHWJBF21CgeeE=;
        b=ous/miQ06NY+PG7Tl45jdZ3j7Qur1Zb549doFLDT3qTLmbxhUbAX29Jl6prThGsm93
         mtI2fL2fCw+DVGPvfZH43xyxhYZmC1LXjcyFsm8F9tkXWxIEDQBiXFjpJKLEJZQmuEib
         A8FbRvPQBj5In7kEeiHCmkgd0CRp5PFxUhRuV2Siqcx8d5B7qIe0IPaTWRwa8okJ3DI6
         xq6xwbfd0MhWBsR+N70KR9ci2c4/UtKuXrww7moJlzmIvnzPC8Q3BqKOIyPxUmlzmFXB
         Kq3fNWDKw95g8GT6+HSXx9cAeyU05q3lqHC8Y36Duj/+8jI/LZrKxDfoY5kSlg+XU7KF
         CXbw==
X-Gm-Message-State: APjAAAVZ1PxVVMEj3xrKnBspK9x6czNCDO1VjJ8uW23Aw1YzIDNuD9r7
        cCeOVcGSUg5WlcvLouvVf1TkqtQL5Qs=
X-Google-Smtp-Source: APXvYqxQinqhAB+oWMZCXgsdGMvny+1/zTQqwhcGpyePkIb//ELVK4P4k/O8FwqhSE4XNgZqE20udQ==
X-Received: by 2002:aed:37e7:: with SMTP id j94mr3390165qtb.381.1556808524625;
        Thu, 02 May 2019 07:48:44 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:48:44 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>
Subject: [GSoC][PATCH v6 01/10] clone: test for our behavior on odd objects/* content
Date:   Thu,  2 May 2019 11:48:20 -0300
Message-Id: <20190502144829.4394-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190502144829.4394-1-matheus.bernardino@usp.br>
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
2.20.1

