Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3388120248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfBZM2z (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:28:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40544 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZM2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:28:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so1372943wmh.5
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drChVUdJAttsJC1Ix01Y7YRCeQIWY7zQ4NHqldLv2I0=;
        b=vRw0aCfgz/B6dM2dqArcYl0wtrm+T3zG4pvlVZXqomGTLfIbL4YEpKPfaWZZNhs3f8
         J27q3Z81MPRwPFznopYqMM5w2cWzfxuU2zfQLJgYmuac0Q+nyNyCg9v/3PvCnuIEojK0
         /rk/6tqm95CWqo14l+ZDF31fFFGIGj7G/Xh9NY2uG6U3ktg7SeM36nb5mE/0bHkv38gz
         HJxnBEaCygetRSfEfGxuFe5z4Og/RTpiWDFqUZZkEvrLhZDZsfcVWelNP9bwZrDospPP
         IkAssJexy7ikvcosPh5RZ+2sDUQZmaTTkxHDSd4izGt3WDVbHtdkPu8ylFYbpxgqyIDO
         5rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drChVUdJAttsJC1Ix01Y7YRCeQIWY7zQ4NHqldLv2I0=;
        b=Q8xaDfWezK+NhfkDGjtq8vew9IwG+Zgt3c8RqSZYR/LI/U/bTtg2y0q7OLhO/SHYqP
         0HIVjXmA0S+wz24ZJL6sp257Ex5wLlyUSghw8nvV0b4A2dehbtu3ea6LlXocNU9wIJpA
         paGw+g2/GYFiA6Q9e3XLjs5sr8uycHt3FqL/uQ22CUHow7TmGu71M9gB9Shm1LpjR1db
         ZmEctog3w8LzwiWELplzyiugV0ZJMwObntPsYk3bUveE+THfIz5/TgREerZ20wKx1qDk
         Rh68tCrf8fRCbJjhvxnxCJyu44PpJJp/3p4HMhA9KyJWV7CMTia2KuZuRhtsibizmO42
         9Mxg==
X-Gm-Message-State: AHQUAuactVM0AsF/iTrgMp08QIe67VTwNss51T7kGun1BWNXcOlYhNcW
        AOXGkMjy17Wf+9gPFZx8NXf3J8on6Mw=
X-Google-Smtp-Source: AHgI3IaMIelxG6nn0gs2Rr9c/j4DFbxe9GiGG/DX2mKLkdBChd8yK8nzbd2dZGOxq+ldsCnjL+zlyg==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr2491067wma.147.1551184131758;
        Tue, 26 Feb 2019 04:28:51 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm2733165wme.24.2019.02.26.04.28.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Feb 2019 04:28:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 1/5] clone: test for our behavior on odd objects/* content
Date:   Tue, 26 Feb 2019 13:28:25 +0100
Message-Id: <20190226122829.19178-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for what happens when we locally clone .git/objects
directories where some of the loose objects or packs are symlinked, or
when when there's unknown files there.

I'm bending over backwards here to avoid a SHA1 dependency. See [1]
for an earlier and simpler version that hardcoded a SHA-1s.

This behavior has been the same for a *long* time, but hasn't been
tested for.

There's a good post-hoc argument to be made for copying over unknown
things, e.g. I'd like a git version that doesn't know about the
commit-graph to copy it under "clone --local" so a newer git version
can make use of it.

But the behavior showed where with symlinks seems pretty
random. E.g. if "pack" is a symlink we end up with two copies of the
contents, and only transfer some symlinks as-is.

In follow-up commits we'll look at changing some of this behavior, but
for now let's just assert it as-is so we'll notice what we'll change
later.

1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5604-clone-reference.sh | 142 +++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 4320082b1b..cb0dc22d14 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -221,4 +221,146 @@ test_expect_success 'clone, dissociate from alternates' '
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
+test_expect_success SYMLINKS 'setup repo with manually symlinked objects/*' '
+	git init T &&
+	(
+		cd T &&
+		test_commit A &&
+		git gc &&
+		(
+			cd .git/objects &&
+			mv pack packs &&
+			ln -s packs pack
+		) &&
+		test_commit B &&
+		(
+			cd .git/objects &&
+			find ?? -type d >loose-dirs &&
+			last_loose=$(tail -n 1 loose-dirs) &&
+			mv $last_loose a-loose-dir &&
+			ln -s a-loose-dir $last_loose &&
+			first_loose=$(head -n 1 loose-dirs) &&
+			(
+				cd $first_loose &&
+				obj=$(ls *) &&
+				mv $obj ../an-object &&
+				ln -s ../an-object $obj
+			) &&
+			find . -type f | sort >../../../T.objects-files.raw &&
+			find . -type l | sort >../../../T.objects-links.raw
+		)
+	) &&
+	git -C T fsck &&
+	git -C T rev-list --all --objects >T.objects
+'
+
+
+test_expect_success SYMLINKS 'clone repo with symlinked objects/*' '
+	for option in --local --no-hardlinks --shared --dissociate
+	do
+		git clone $option T T$option || return 1 &&
+		git -C T$option fsck || return 1 &&
+		git -C T$option rev-list --all --objects >T$option.objects &&
+		test_cmp T.objects T$option.objects &&
+		(
+			cd T$option/.git/objects &&
+			find . -type f | sort >../../../T$option.objects-files.raw &&
+			find . -type l | sort >../../../T$option.objects-links.raw
+		)
+	done &&
+
+	for raw in $(ls T*.raw)
+	do
+		sed -e "s!/..\$!/X!; s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" <$raw >$raw.de-sha || return 1
+	done &&
+
+	cat >expected-files <<-EOF &&
+	./Y/Z
+	./a-loose-dir/Z
+	./an-object
+	./Y/Z
+	./info/packs
+	./loose-dirs
+	./pack/pack-Z.idx
+	./pack/pack-Z.pack
+	./packs/pack-Z.idx
+	./packs/pack-Z.pack
+	EOF
+	cat >expected-links <<-EOF &&
+	./Y/Z
+	EOF
+	for option in --local --dissociate
+	do
+		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1 &&
+		test_cmp expected-links T$option.objects-links.raw.de-sha || return 1
+	done &&
+
+	cat >expected-files <<-EOF &&
+	./Y/Z
+	./Y/Z
+	./a-loose-dir/Z
+	./an-object
+	./Y/Z
+	./info/packs
+	./loose-dirs
+	./pack/pack-Z.idx
+	./pack/pack-Z.pack
+	./packs/pack-Z.idx
+	./packs/pack-Z.pack
+	EOF
+	test_cmp expected-files T--no-hardlinks.objects-files.raw.de-sha &&
+	test_must_be_empty T--no-hardlinks.objects-links.raw.de-sha &&
+
+	cat >expected-files <<-EOF &&
+	./info/alternates
+	EOF
+	test_cmp expected-files T--shared.objects-files.raw &&
+	test_must_be_empty T--shared.objects-links.raw
+'
+
 test_done
-- 
2.21.0.rc2.261.ga7da99ff1b

