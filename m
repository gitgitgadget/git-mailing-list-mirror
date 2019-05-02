Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027D71F453
	for <e@80x24.org>; Thu,  2 May 2019 14:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEBOst (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:48:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33202 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:48:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id g7so2811179qtc.0
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFvO4wEM4HMFehMN7DNV1aj2/G+63hcDlFSqqOTdPOs=;
        b=SS36TTaWTdKNzbhk8C2gNx6dXY6wc6DBBxuTjp00jAn8rkTP92jqbSV1aM2fpZvd/S
         vjcMBmwYAXHA8nP2n5451gmnGaa2LYF/vyTcGn8rZkpBBYDo9wicpTA3pZcYlHHS5GC2
         jbYi6ttjASnrZXIOgdPlNomSdXgkFZyUl7smpSHl1AXptoh+GV2P7bKrXWQHSU3fCAfT
         IYe0DjUwY0s6tozAwKYH3XA2O2UwVRXNlCNabWDukAsckbDoxtNb4Oh4BYTXOZEdz2wW
         7H98YLuqykva067GjGxHteeRPtrVAU3FZAtvS7XrASXiOZwIbiVtWtYKTVwIwKkxVGJj
         4oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFvO4wEM4HMFehMN7DNV1aj2/G+63hcDlFSqqOTdPOs=;
        b=CaBlBR0sdSIuKWir4TTTbbl04N1HgxFXs7iiwRqGawaho+mERhuyYv/GJ5kFtz2qQJ
         2CGnL7Ipu23Vfjm1fb8nOyBlrNMTwrCGwM+0kkl1Pp65k3O52d3mOSaLBao7Z2UOHVjz
         uq51VLJGl4hryF8YA0AhY9TZi03z2KqPFRvub+09WTFxPmhcKWYMfPq5gIh5JIBVkxcz
         n116O85xqTdauLueFl0+GoeFYR6PYRLbtUxfkNo0x+tTqgixGGHnEn0vxPWEGgHYeLZK
         pWeHJkAe49RQpp6kty/RHB6dUynUKWeWVnhwn9Ffr2UzUimGEn9OJvTYPzkvFr6Ba6Mm
         bfDw==
X-Gm-Message-State: APjAAAU5iO7jxFbQ9iEcXNaiUjgRkWJZtxbZ8uZOPKd1UiG3P5v4lRky
        ITBloZqJDcT58vYCUVT8Fj7bo+LPmkw=
X-Google-Smtp-Source: APXvYqyeMraZ0JOeuHQNuc8es5HB6IIByCNiQU9c8U0BIvAaGNrgaIVf3ljZ7zhNznswgxnJ5Zxbxw==
X-Received: by 2002:a0c:bd2d:: with SMTP id m45mr3437227qvg.4.1556808528232;
        Thu, 02 May 2019 07:48:48 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:48:47 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH v6 02/10] clone: better handle symlinked files at .git/objects/
Date:   Thu,  2 May 2019 11:48:21 -0300
Message-Id: <20190502144829.4394-3-matheus.bernardino@usp.br>
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
index 50bde99618..d1aba3b13f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -443,7 +443,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
2.20.1

