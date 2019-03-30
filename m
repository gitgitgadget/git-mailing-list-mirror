Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6985920248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfC3WtZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38179 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3WtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so6759125qth.5
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axc3ebt8FvJkWFbNG0UQUWu+PmJJC1EyvfpEjBRwsAA=;
        b=RVSaa0MV3nrpP0zKdrcghusTb/AbEqhR8K/QeVDliQGYLXisrR8qrlDr393I+p5fLl
         2jrhi4RlQC4ct1SzpnEK6idMpfn0OgmP6oXT3H8FRBKih88IvkSAesnDGzNutVG/8CmT
         cii21LcxqwSMgfwyc9PkOHyLAO2e1yOCe05MnWg9juvjd4dSKAeTtDYZG6QqJTI0mX5C
         R7Hi8gYgjbn53LKemgvRFWDtqIc72of+1yZ7cDUMshZu+ZVtjoTD63K7DEEccpEI0MrI
         +vxVBXBbw5XHTn8jBB1eJpRQ8jIdcarGWPW1+MQb/YQnDfCAvCVUx5cNox9RjNPli20c
         XpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axc3ebt8FvJkWFbNG0UQUWu+PmJJC1EyvfpEjBRwsAA=;
        b=q+GWB3K01Pem38XokGfHtoAi8X7ehsGsRmuSlrVd2TKT7hM8xbpSI47XWDDYm+NaLg
         LJYoghZzJRqZ1Nr7aQf6SjmEQqODRjsL94DhKqbG+UBm8y3SZCtM6MW0uUafo0UVXwYP
         Bakccih3mjiiAqINYhTuQwrTaRPWcGETqse/DcvHwxHFeCQrAZmmx+NeqZcYqBRI5Deh
         P5kwIT+ntxQMTaTZ0W7suiOujLTaW5QXDd+U03Zr937k5FVcDFNXD9a4ugudei/8wFxN
         bDNi+P/x/dVc4C/z9N6mRAhNZj8+IA2jafphkZBBy0VmlxNcUMFxW9QFRE4xjF9iYhBj
         Z9tg==
X-Gm-Message-State: APjAAAX9c9OHpcjYA4NXcvi5JlUKGqdBhZY8xl4+T+/9WlDuQ2xJa18z
        Gn0ZhhasWlsH6YUjC6p20V+TAA==
X-Google-Smtp-Source: APXvYqzA8UTKuuf7cv7+X3Zb2m8WVmUtDOeK2opoxxj9x1Mbx4zhWg4bbz5ZXhKJnpR/PqmOejx3Wg==
X-Received: by 2002:a0c:c165:: with SMTP id i34mr27486701qvh.6.1553986163849;
        Sat, 30 Mar 2019 15:49:23 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:23 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v5 2/7] clone: better handle symlinked files at .git/objects/
Date:   Sat, 30 Mar 2019 19:49:02 -0300
Message-Id: <20190330224907.3277-3-matheus.bernardino@usp.br>
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
 builtin/clone.c            |  5 ++++-
 t/t5604-clone-reference.sh | 27 ++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..f975b509f1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -443,7 +443,10 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
 		if (!option_no_hardlinks) {
-			if (!link(src->buf, dest->buf))
+			char *resolved_path = real_pathdup(src->buf, 1);
+			int status = link(resolved_path, dest->buf);
+			free(resolved_path);
+			if (!status)
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
2.20.1

