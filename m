Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209871F461
	for <e@80x24.org>; Wed, 10 Jul 2019 23:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfGJX7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 19:59:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43556 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGJX7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 19:59:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so4450818qto.10
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcQ7pP1ZfBMO1uGb5Oe17FrSCskIikm/t2kiS9FywJ8=;
        b=002Ma1gEwiwHoTRj98sw9ysPnGaVz4uOyVSZNuB2gG1G/mxhtdhVizJrL0AZBcKrcA
         gnGwUd7tV+2TC8koaPxaWDkSP4bSFH4osFkQWy7JgjWiaSsfFy0RQA3QrikqZSEt9iLW
         81tLjL/mX+x2ZN2/CskdJC9JGRENpMqvi62mDgihigqx+syDgiNd+DHKTL9e6qc1Ib8V
         A0a26x5SLSEeC5q3KsJqrkwgbulwyITE9un/j6RUKkXvvvW85wJf38hKuE9B3RMfoP9t
         VeNrFjb1qLSLHPCDgzmreCDMZiFygjrhm+AeJnzUKzbrHWZGRhR0YuiaFjknbgOMibZg
         qXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcQ7pP1ZfBMO1uGb5Oe17FrSCskIikm/t2kiS9FywJ8=;
        b=rN/TMzovMYZDvBsFzstTikc+QGUNXqtQ39luKV1Y8C0wxOrOQ59rWOaWkbtuVuYZUi
         fFkJNvcq0QgPupU0Xm9OiXUF7vanmdTSCoGjxVICMpwcPQP7ZxO5+N3ft21X6WunVkMJ
         vketQ36qUtAGluvN0lAgcRiDpI05tL9et952rT0SqYM8zsXBoZp5nGd0AQi6qQHtf938
         kmBX/G7JJzIadnoFOdQ4GZRo+/O/Z/1Ew93GH8GaXH2BeNjxrcFG4KEzZWmsMPVC2/Pq
         fBlXjsbuPxTcsTrnlxf5JXbkRkExi5/lokEmK35LOqqKYoVF2Te1uAxiRwr1FwxWFKzi
         4DyQ==
X-Gm-Message-State: APjAAAUQBoCwrjoeWmDwyPjrMSCTvK886pcfkAh7JoDn8Qc8pume0uDm
        jtJlKWqsgIksZQKFbOMop9flDQ==
X-Google-Smtp-Source: APXvYqwjNdV8o25i/PLwuyYNQW9PD9Dl+8WujHbGzXqBCcihUeMvqqH4jMbf8MC9x7uDP7OHVJT3cw==
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr443881qvd.101.1562803173597;
        Wed, 10 Jul 2019 16:59:33 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.16.59.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 16:59:33 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com, Alex Riesen <raa.lkml@gmail.com>
Subject: [GSoC][PATCH v8 01/10] clone: test for our behavior on odd objects/* content
Date:   Wed, 10 Jul 2019 20:58:55 -0300
Message-Id: <a2016d9d3b8e54ff9b9e6dfbd3ab4ce4a1bf7e4d.1562801254.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
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
index 4320082b1b..11250cab40 100755
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
+		echo unknown_content >unknown_file
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

