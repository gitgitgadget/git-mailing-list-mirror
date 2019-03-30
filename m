Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB9320248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfC3WtW (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37559 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3WtW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so6772091qtn.4
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiCRl9E184AC0nezd5RzjQnNgANF2yTHWJBF21CgeeE=;
        b=oOVuimadWgBDEqVt4D76uqPWVnXeCRE91m08riCw6o7pwOVHjdrosHZqcs928p7Q5u
         dGkW/fcTv098xKBZ2+1JyPUzA7triwxAc4mOInaBI6LiDHesZ1OSD85dUrlA3JV8AZP0
         KUjD9Wsa3le56LcC9gU5B3k0k5EJ6Vd4EdDw6YcjGNA57aXf6LDN6mSiIb4fEjWVXqks
         OJ1IrLNbjS71X264+FoFMTe5rMNrxKQsDwunXkiUMLhNepsA31PFfzn9Wyopw93/h0+C
         UEcYOT1fC27uFYyZR+uxU6EmVJ3+5vdbsp9v6bCT3qzjkUHjQyzKpVQx1oMG7BAGDb1I
         nKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiCRl9E184AC0nezd5RzjQnNgANF2yTHWJBF21CgeeE=;
        b=DzOoWIX/dbC11XKMVJFteXnxHt8nwQvkjCbiqIj8amwEt1GrByaOZgBK+8arl82Np5
         vuGKdWGCt7KfK3VD5T22Yz9DfycOUiSE6R9O1ORtI4KIWtj7uojVY7M1zpjWdmASeA75
         VSTGf3Qj33AC2sBQu6KDo50WzalBaesvZ8vrDitUg5oFPB8d6tAF2uSxAZ3x5MMHVL0Y
         e2nFuZtoDoPllnmUpOqp3lgyVaMCHPtfx3Qlx9STuzbIebe5yBFz7rWuZVP+CdtFwUpe
         aPctUoqkM7dGvB5kNALl/RroNl1xtn5i/o0Es50okh9Oi5DhZ2QnsF6l9uxfSItoRdWk
         81pw==
X-Gm-Message-State: APjAAAWiszCOR3tV/cxBEqy4tmH5H7maYWdNTCrfpHVpTHKAyaeyFGho
        QGKR02LEJ6ALkJg05e9uQZNeEn8axyw=
X-Google-Smtp-Source: APXvYqyeNBXOILhhpBMKhlywru9OPjkLa1yJ8ZWA0cHl3dxt4FytGHyD/5kc2g2nrLBcI6aDSWTE6g==
X-Received: by 2002:ac8:168c:: with SMTP id r12mr48242956qtj.300.1553986160617;
        Sat, 30 Mar 2019 15:49:20 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Alex Riesen <raa.lkml@gmail.com>
Subject: [GSoC][PATCH v5 1/7] clone: test for our behavior on odd objects/* content
Date:   Sat, 30 Mar 2019 19:49:01 -0300
Message-Id: <20190330224907.3277-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
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

