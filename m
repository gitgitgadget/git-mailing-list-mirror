Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D7E20248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfCVXW4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:22:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43795 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfCVXW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:22:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so4410309qtc.10
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olCYosCGO89jmuFKSaVOQ23QWeJohzXASwr2uhs0YMQ=;
        b=UEF/vmsLsosXbKEWaCIMO+ayfCmEByfmDceKBl0OofC59pPDrsK11MamZzGbcMa+P2
         nQcNWE/njqf9tBOgrZPOA78ESEWP0PoVN2kjz02UCchA52DiCL+yUrLPIAnAiwN4WlUA
         0PUf+na0wY3FsCqVfBUgRXZDnEY59UPvtnQ3T3gHy1vI0dZ7RPxQX6byUKJLvf6j2dur
         0dO1pfMZFIdQu8bgugHSCa266sEIg9LLDhHlZM/Ty4Y8SHnX9bSY/7eJNbYKqInmOJjt
         LoxngaZui4gTGm7pajlDaQa4SnhBZNMRqEnNfO1SCUNqQHlI7kSuRis2AxJwIQurXoBR
         tayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olCYosCGO89jmuFKSaVOQ23QWeJohzXASwr2uhs0YMQ=;
        b=DN5AGG52Ou+3RHNiBSWxWTdYBOhutAVcYG8LbmnZVbPYnWiRcKnxAk2hRiueyNgnWs
         fxKRZs7qqnW3v7r2yw9/0s65k8EyQc+kfPsO+P5Al1d85BZUvsBqn5LXkF59Z0evisEz
         UD+xHiUVS9SoZ2G1qKl46mcUkwD12ZJZVuoFBx91FiS3ueebjgzLzSpEwF6/1Tl/lb3j
         PBYzK1UnaxGRUOBD4+NhOnQmEPT7C3J6cHbqha7b1iMecjSGESoa9ca/LOCI2pJMhv70
         J/vMHK3Iob3aPA7l0nPXEg+523H2yaWXhogsuxmUuSydwdhfEOgchKQ+Xno+O3Y3JWl8
         ZYPw==
X-Gm-Message-State: APjAAAWG5SZVeaec+uyyCbq3gw4Wz0dmarx329z5ZtLsY3wcye13KwGT
        yQqCGis1WkU3aVXortREFJcJEBGLQPw=
X-Google-Smtp-Source: APXvYqzyyiGhcnjddBA0ckvP/IvhsdNX5dDA2UV5ABZM02AS25rdIV2tp0zObZo6yfMrlrP3N2dyGg==
X-Received: by 2002:a0c:9528:: with SMTP id l37mr10256644qvl.243.1553296974922;
        Fri, 22 Mar 2019 16:22:54 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:22:54 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at .git/objects/
Date:   Fri, 22 Mar 2019 20:22:32 -0300
Message-Id: <20190322232237.13293-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently an odd behaviour when locally clonning a repository
with symlinks at .git/objects: using --no-hardlinks all symlinks are
dereferenced but without it Git will try to hardlink the files with the
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
since the behaviour on GNU/Linux may result in broken symlinks, let's
re-implement it with linkat() instead of link() using a flag to always
follow symlinks and make the hardlink be to the pointed file. With this,
besides standardizing the behaviour, no broken symlinks will be
produced. Also, add tests for symlinked files at .git/objects/.

Note: Git won't create symlinks at .git/objects itself, but it's better
to handle this case and be friendly with users who manually create them.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            |  2 +-
 t/t5604-clone-reference.sh | 26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..b76f33c635 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -443,7 +443,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
 		if (!option_no_hardlinks) {
-			if (!link(src->buf, dest->buf))
+			if (!linkat(AT_FDCWD, src->buf, AT_FDCWD, dest->buf, AT_SYMLINK_FOLLOW))
 				continue;
 			if (option_local > 0)
 				die_errno(_("failed to create link '%s'"), dest->buf);
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 708b1a2c66..76d45f1187 100755
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
@@ -282,10 +282,18 @@ test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknow
 			cd .git/objects &&
 			find ?? -type d >loose-dirs &&
 			last_loose=$(tail -n 1 loose-dirs) &&
-			rm -f loose-dirs &&
 			mv $last_loose a-loose-dir &&
 			ln -s a-loose-dir $last_loose &&
+			first_loose=$(head -n 1 loose-dirs) &&
+			rm -f loose-dirs &&
+			(
+				cd $first_loose &&
+				obj=$(ls *) &&
+				mv $obj ../an-object &&
+				ln -s ../an-object $obj
+			) &&
 			find . -type f | sort >../../../T.objects-files.raw &&
+			find . -type l | sort >../../../T.objects-symlinks.raw &&
 			echo unknown_content> unknown_file
 		)
 	) &&
@@ -294,7 +302,7 @@ test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknow
 '
 
 
-test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files at objects/' '
+test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at objects/' '
 	for option in --local --no-hardlinks --shared --dissociate
 	do
 		git clone $option T T$option || return 1 &&
@@ -303,7 +311,8 @@ test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files a
 		test_cmp T.objects T$option.objects &&
 		(
 			cd T$option/.git/objects &&
-			find . -type f | sort >../../../T$option.objects-files.raw
+			find . -type f | sort >../../../T$option.objects-files.raw &&
+			find . -type l | sort >../../../T$option.objects-symlinks.raw
 		)
 	done &&
 
@@ -317,6 +326,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files a
 	./Y/Z
 	./Y/Z
 	./a-loose-dir/Z
+	./an-object
 	./Y/Z
 	./info/packs
 	./pack/pack-Z.idx
@@ -326,15 +336,17 @@ test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files a
 	./unknown_file
 	EOF
 
-	for option in --local --dissociate --no-hardlinks
+	for option in --local --no-hardlinks --dissociate
 	do
-		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1
+		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1 &&
+		test_must_be_empty T$option.objects-symlinks.raw.de-sha || return 1
 	done &&
 
 	cat >expected-files <<-EOF &&
 	./info/alternates
 	EOF
-	test_cmp expected-files T--shared.objects-files.raw
+	test_cmp expected-files T--shared.objects-files.raw &&
+	test_must_be_empty T--shared.objects-symlinks.raw
 '
 
 test_done
-- 
2.20.1

