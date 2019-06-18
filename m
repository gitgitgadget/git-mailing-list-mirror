Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB861F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfFRX24 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:28:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:28:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so17702684qto.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZeQvGDF6ph32VZaJg9CsEtLW+IEjcr2kE9QW8pbBAQ=;
        b=dEFtLtPkD7PAMvsz4GQOVDyWmz99+nZ26txnEItLxBv1ov92TP0j+ZAodvXJ4xUuDA
         ee/HSKenl9OFLsjMbhE+TXxTzOKEX4wI+/QYPWTqQiGs0nB0WG2xLdIJ4be2YIINFoVg
         494FhHR56MWn4xmiUspgQzX7cOZZg1MlPZV2Xd5R7XGq8zlXcYKIoIw2kLy0t5EujSmz
         x0wi9uzXFJWfA+idxLpk1dcxQgQAS8RBsHYx0cBOF+En+ZlZqYS9+OFRZwZgCX5ucxK6
         jESt5tc3m7+x87PR27MgB9t4bN7Y2yikBEWrep3Kjhz3nx4uEgWTDXZ9aZKq2zA1aTPd
         0qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZeQvGDF6ph32VZaJg9CsEtLW+IEjcr2kE9QW8pbBAQ=;
        b=ek6Diof9bxv7vQNOStr2P0+oiibYlTSZvEMvBnpNz5HLFhEQt9QG2iGqyVX1kmtWeu
         yZUxDGrff+I71FO+LJTr/dQrpMt+1Ric+ddn+anJeCJ0Tzt3tdvESQhoPQ4OfZqAh7SL
         v72DxeV324aLpYhVAVw90abd17H59AydAV5XFXysfloft0DVixJhu2NC4aVWVdyQkh1W
         AUSptlqmfwW56VFrc3z+5BsTxNsss4zBoJJmBFpdTQJuNMx2kIzMxhPofpiJvIshUmsj
         ARGsddZ9FMPy5E3mThk04gEVDi8FOEHTki7RSa7Ji2mIsW/FrTREfy4qRyVsIDj2KxZ1
         c3Eg==
X-Gm-Message-State: APjAAAVjjlZjZB4tQTCkAAdiHxHL3yFMQo7w5mhpnN54uTg1QRM03z4R
        L8yq26JHBm//Roy4nEps6Ej37azx6t4=
X-Google-Smtp-Source: APXvYqw+SAwMxE3e3IIZtPr42Y6AxpxUuLhUUzc/XxuIUKKW8ABsJg0HnLhD8RLeE7IrzPjwDijoGQ==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr59679514qti.72.1560900534757;
        Tue, 18 Jun 2019 16:28:54 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.28.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:28:54 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: [GSoC][PATCH v7 02/10] clone: better handle symlinked files at .git/objects/
Date:   Tue, 18 Jun 2019 20:27:39 -0300
Message-Id: <722350fe00de73d28df1a9c8667c84171aa8c1f5.1560898723.git.matheus.bernardino@usp.br>
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

There is currently an odd behaviour when locally cloning a repository
with symlinks at .git/objects: using --no-hardlinks all symlinks are
dereferenced but without it, Git will try to hardlink the files with the
link() function, which has an OS-specific behaviour on symlinks. On OSX
and NetBSD, it creates a hardlink to the file pointed by the symlink
whilst on GNU/Linux, it creates a hardlink to the symlink itself.

On Manjaro GNU/Linux:
    $ touch a
    $ ln -s a b
    $ link b c
    $ ls -li a b c
    155 [...] a
    156 [...] b -> a
    156 [...] c -> a

But on NetBSD:
    $ ls -li a b c
    2609160 [...] a
    2609164 [...] b -> a
    2609160 [...] c

It's not good to have the result of a local clone to be OS-dependent and
besides that, the current behaviour on GNU/Linux may result in broken
symlinks. So let's standardize this by making the hardlinks always point
to dereferenced paths, instead of the symlinks themselves. Also, add
tests for symlinked files at .git/objects/.

Note: Git won't create symlinks at .git/objects itself, but it's better
to handle this case and be friendly with users who manually create them.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            |  2 +-
 t/t5604-clone-reference.sh | 27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5b9ebe9947..4a0a2455a7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -445,7 +445,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
 		if (!option_no_hardlinks) {
-			if (!link(src->buf, dest->buf))
+			if (!link(real_path(src->buf), dest->buf))
 				continue;
 			if (option_local > 0)
 				die_errno(_("failed to create link '%s'"), dest->buf);
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 207650cb95..0800c3853f 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -266,7 +266,7 @@ test_expect_success 'clone a repo with garbage in objects/*' '
 	test_cmp expected actual
 '
 
-test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknown files at objects/' '
+test_expect_success SYMLINKS 'setup repo with manually symlinked or unknown files at objects/' '
 	git init T &&
 	(
 		cd T &&
@@ -280,10 +280,19 @@ test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknow
 		ln -s packs pack &&
 		find ?? -type d >loose-dirs &&
 		last_loose=$(tail -n 1 loose-dirs) &&
-		rm -f loose-dirs &&
 		mv $last_loose a-loose-dir &&
 		ln -s a-loose-dir $last_loose &&
+		first_loose=$(head -n 1 loose-dirs) &&
+		rm -f loose-dirs &&
+
+		cd $first_loose &&
+		obj=$(ls *) &&
+		mv $obj ../an-object &&
+		ln -s ../an-object $obj &&
+
+		cd ../ &&
 		find . -type f | sort >../../../T.objects-files.raw &&
+		find . -type l | sort >../../../T.objects-symlinks.raw &&
 		echo unknown_content> unknown_file
 	) &&
 	git -C T fsck &&
@@ -291,7 +300,7 @@ test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknow
 '
 
 
-test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files at objects/' '
+test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at objects/' '
 	for option in --local --no-hardlinks --shared --dissociate
 	do
 		git clone $option T T$option || return 1 &&
@@ -300,7 +309,8 @@ test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files a
 		test_cmp T.objects T$option.objects &&
 		(
 			cd T$option/.git/objects &&
-			find . -type f | sort >../../../T$option.objects-files.raw
+			find . -type f | sort >../../../T$option.objects-files.raw &&
+			find . -type l | sort >../../../T$option.objects-symlinks.raw
 		)
 	done &&
 
@@ -314,6 +324,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files a
 	./Y/Z
 	./Y/Z
 	./a-loose-dir/Z
+	./an-object
 	./Y/Z
 	./info/packs
 	./pack/pack-Z.idx
@@ -323,13 +334,15 @@ test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files a
 	./unknown_file
 	EOF
 
-	for option in --local --dissociate --no-hardlinks
+	for option in --local --no-hardlinks --dissociate
 	do
-		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1
+		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1 &&
+		test_must_be_empty T$option.objects-symlinks.raw.de-sha || return 1
 	done &&
 
 	echo ./info/alternates >expected-files &&
-	test_cmp expected-files T--shared.objects-files.raw
+	test_cmp expected-files T--shared.objects-files.raw &&
+	test_must_be_empty T--shared.objects-symlinks.raw
 '
 
 test_done
-- 
2.22.0

