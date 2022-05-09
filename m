Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FF8C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbiEIR7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiEIR7E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EE2D9EC4
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so28322241ejb.6
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5QMV8MHH+SUmGgoFVYPSFXfGwL7zKLHAWCAS04JXEU=;
        b=PBONiOhndjatsFy9jMyIyD4dEMBbrs2lRpFmJGZb4xKq9Fy0Eibf8kzqF0zbNTUVoE
         vvL4iiB3NM6l9Z9eb7qCXczZSP/as14/jrLwbPKRuQcnpMlpxWbRXP2zo90eMZjDDFR8
         FGbYJDHrFIDMQBfD2MM388AQvUdrsJRiTCKWvK9B/O+L5jcU8ubUbJad9CTecX3DOJHu
         YyhlWldbhYhDc4br3Chzmii7zBYsmxV/AaRSBqJh8pHUHro9n4nOEieQjbgaQf8X85gm
         E4ke0aS60IXxBXwxeqEONZSlTFg9NxXNDM9AmJ0D4hn0oc41ZKQne7wEeY0tpAhlqh7i
         zyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5QMV8MHH+SUmGgoFVYPSFXfGwL7zKLHAWCAS04JXEU=;
        b=P+pY2bJPFMfdWOma8XtC8oURU9wx4GDWWlPVkOXCibtgbyemtWbNgnmkYPlYpWDeJJ
         UQkShEx6dYLfidUJSsVrY+JQXPJY91GoHQtyrjJst7AwEILrwlbR3OIXiknmXnlA7qrT
         dZ/It2Ef4M4L6EvlJhJlQ7/sRih3vp+jfvnts0nhIvHQ5sVK7esyySa8wmCs6oQGFTFJ
         30g/LsSmS33JG19Zv3+Bpo8EU0dH93BfZHDmEowU0+xpP0kcfSJxoSgIE8kB0QNXXNrE
         AVPZFiI4QAwWFbK8ZO54/F7lgi5LDT2Bt+p3HwaaU9pM7yUURC+e4fm/GwqFXsgw39Mi
         zETg==
X-Gm-Message-State: AOAM53350IQ8oO9qliLh2l0S3KkRaWSnHi4qg2IRhVnb02fQT4qZCwO5
        OHEnAxWkZE/+ugXa4YV64/juBJDEC4s=
X-Google-Smtp-Source: ABdhPJwqCDQtPLfxBCzKIjkVwZS3c33bA74LXGwBNyBWPwwzVfl2ahoOJ77QT6rQrbB2tJYDKVFWjw==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr15041352ejc.568.1652118908183;
        Mon, 09 May 2022 10:55:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:07 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 09/15] t0066: rename test directories
Date:   Mon,  9 May 2022 20:51:53 +0300
Message-Id: <20220509175159.2948802-10-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve readability by renaming directories such that their name
correspond to the order they appear in the file. An out of order
naming could suggest that the directory naming plays some role
in how the tests are structured and performed, which is not true.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 198 ++++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 99 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 9b3ce99382..04e51928bc 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -19,96 +19,96 @@ test_expect_success 'iteration of dir with a file' '
 '
 
 test_expect_success 'setup -- dir with a single dir' '
-	mkdir -p dir6/a
+	mkdir -p dir2/a
 '
 test_expect_success 'iteration of dir with a single dir' '
 	cat >expected-out <<-EOF &&
-	[d] (a) [a] ./dir6/a
+	[d] (a) [a] ./dir2/a
 	EOF
 
-	test-tool dir-iterator ./dir6 >actual-out &&
+	test-tool dir-iterator ./dir2 >actual-out &&
 	test_cmp expected-out actual-out
 '
 
 test_expect_success POSIXPERM,SANITY 'setup -- dir w/ single dir w/o perms' '
-	mkdir -p dir13/a
+	mkdir -p dir3/a
 '
 test_expect_success POSIXPERM,SANITY 'iteration of dir w/ dir w/o perms' '
 	cat >expected-out <<-EOF &&
-	[d] (a) [a] ./dir13/a
+	[d] (a) [a] ./dir3/a
 	EOF
 
-	chmod 0 dir13/a &&
+	chmod 0 dir3/a &&
 
-	test-tool dir-iterator ./dir13/ >actual-out &&
+	test-tool dir-iterator ./dir3/ >actual-out &&
 	test_cmp expected-out actual-out &&
 
-	chmod 755 dir13/a
+	chmod 755 dir3/a
 '
 test_expect_success POSIXPERM,SANITY 'pedantic iteration of dir w/ dir w/o perms' '
 	cat >expected-out <<-EOF &&
-	[d] (a) [a] ./dir13/a
+	[d] (a) [a] ./dir3/a
 	dir_iterator_advance failure: EACCES
 	EOF
 
-	chmod 0 dir13/a &&
+	chmod 0 dir3/a &&
 
-	test_must_fail test-tool dir-iterator --pedantic ./dir13/ >actual-out &&
+	test_must_fail test-tool dir-iterator --pedantic ./dir3/ >actual-out &&
 	test_cmp expected-out actual-out &&
 
-	chmod 755 dir13/a
+	chmod 755 dir3/a
 '
 
 test_expect_success 'setup -- dir w/ five files' '
-	mkdir dir14 &&
-	>dir14/a &&
-	>dir14/b &&
-	>dir14/c &&
-	>dir14/d &&
-	>dir14/e
+	mkdir dir4 &&
+	>dir4/a &&
+	>dir4/b &&
+	>dir4/c &&
+	>dir4/d &&
+	>dir4/e
 '
 test_expect_success 'iteration of dir w/ five files' '
 	cat >expected-sorted-out <<-EOF &&
-	[f] (a) [a] ./dir14/a
-	[f] (b) [b] ./dir14/b
-	[f] (c) [c] ./dir14/c
-	[f] (d) [d] ./dir14/d
-	[f] (e) [e] ./dir14/e
+	[f] (a) [a] ./dir4/a
+	[f] (b) [b] ./dir4/b
+	[f] (c) [c] ./dir4/c
+	[f] (d) [d] ./dir4/d
+	[f] (e) [e] ./dir4/e
 	EOF
 
-	test-tool dir-iterator ./dir14 >actual-out &&
+	test-tool dir-iterator ./dir4 >actual-out &&
 	sort actual-out >actual-sorted-out &&
 
 	test_cmp expected-sorted-out actual-sorted-out
 '
 
 test_expect_success 'setup -- dir w/ dir w/ a file' '
-	mkdir -p dir15/a &&
-	>dir15/a/b
+	mkdir -p dir5/a &&
+	>dir5/a/b
 '
 test_expect_success 'iteration of dir w/ dir w/ a file' '
 	cat >expected-out <<-EOF &&
-	[d] (a) [a] ./dir15/a
-	[f] (a/b) [b] ./dir15/a/b
+	[d] (a) [a] ./dir5/a
+	[f] (a/b) [b] ./dir5/a/b
 	EOF
 
-	test-tool dir-iterator ./dir15 >actual-out &&
+	test-tool dir-iterator ./dir5 >actual-out &&
 	test_cmp expected-out actual-out
 '
 
 test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
-	mkdir -p dir2/a/b/c &&
-	>dir2/a/b/c/d
+	mkdir -p dir6/a/b/c &&
+	>dir6/a/b/c/d
 '
 test_expect_success 'dir-iterator should list files in the correct order' '
 	cat >expected-out <<-EOF &&
-	[d] (a) [a] ./dir2/a
-	[d] (a/b) [b] ./dir2/a/b
-	[d] (a/b/c) [c] ./dir2/a/b/c
-	[f] (a/b/c/d) [d] ./dir2/a/b/c/d
+	[d] (a) [a] ./dir6/a
+	[d] (a/b) [b] ./dir6/a/b
+	[d] (a/b/c) [c] ./dir6/a/b/c
+	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
 	EOF
 
-	test-tool dir-iterator ./dir2 >actual-out &&
+	test-tool dir-iterator ./dir6 >actual-out &&
 	test_cmp expected-out actual-out
 '
 
@@ -253,31 +253,31 @@ test_expect_success 'iteration of dir w/ two nested dirs, each w/ file' '
 '
 
 test_expect_success 'setup -- dir w/ complex structure' '
-	mkdir -p dir &&
-	mkdir -p dir/a/b/c/ &&
-	>dir/b &&
-	>dir/c &&
-	mkdir -p dir/d/e/d/ &&
-	>dir/a/b/c/d &&
-	>dir/a/e &&
-	>dir/d/e/d/a
+	mkdir -p dir11 &&
+	mkdir -p dir11/a/b/c/ &&
+	>dir11/b &&
+	>dir11/c &&
+	mkdir -p dir11/d/e/d/ &&
+	>dir11/a/b/c/d &&
+	>dir11/a/e &&
+	>dir11/d/e/d/a
 '
 test_expect_success 'dir-iterator should iterate through all files' '
 	cat >expected-sorted-out <<-EOF &&
-	[d] (a) [a] ./dir/a
-	[d] (a/b) [b] ./dir/a/b
-	[d] (a/b/c) [c] ./dir/a/b/c
-	[d] (d) [d] ./dir/d
-	[d] (d/e) [e] ./dir/d/e
-	[d] (d/e/d) [d] ./dir/d/e/d
-	[f] (a/b/c/d) [d] ./dir/a/b/c/d
-	[f] (a/e) [e] ./dir/a/e
-	[f] (b) [b] ./dir/b
-	[f] (c) [c] ./dir/c
-	[f] (d/e/d/a) [a] ./dir/d/e/d/a
+	[d] (a) [a] ./dir11/a
+	[d] (a/b) [b] ./dir11/a/b
+	[d] (a/b/c) [c] ./dir11/a/b/c
+	[d] (d) [d] ./dir11/d
+	[d] (d/e) [e] ./dir11/d/e
+	[d] (d/e/d) [d] ./dir11/d/e/d
+	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
+	[f] (a/e) [e] ./dir11/a/e
+	[f] (b) [b] ./dir11/b
+	[f] (c) [c] ./dir11/c
+	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
 	EOF
 
-	test-tool dir-iterator ./dir >actual-out &&
+	test-tool dir-iterator ./dir11 >actual-out &&
 	sort actual-out >actual-sorted-out &&
 
 	test_cmp expected-sorted-out actual-sorted-out
@@ -331,93 +331,93 @@ test_expect_success 'begin should fail upon non directory paths' '
 '
 
 test_expect_success POSIXPERM,SANITY 'setup -- dir w/ dir w/o perms w/ file' '
-	mkdir -p dir3/a &&
-	>dir3/a/b
+	mkdir -p dir13/a &&
+	>dir13/a/b
 '
 test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
 	cat >expected-out <<-EOF &&
-	[d] (a) [a] ./dir3/a
+	[d] (a) [a] ./dir13/a
 	EOF
 
-	chmod 0 dir3/a &&
+	chmod 0 dir13/a &&
 
-	test-tool dir-iterator ./dir3 >actual-out &&
+	test-tool dir-iterator ./dir13 >actual-out &&
 	test_cmp expected-out actual-out &&
 
-	chmod 755 dir3/a
+	chmod 755 dir13/a
 '
 test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
 	cat >expected-out <<-EOF &&
-	[d] (a) [a] ./dir3/a
+	[d] (a) [a] ./dir13/a
 	dir_iterator_advance failure: EACCES
 	EOF
 
-	chmod 0 dir3/a &&
+	chmod 0 dir13/a &&
 
-	test_must_fail test-tool dir-iterator --pedantic ./dir3 >actual-out &&
+	test_must_fail test-tool dir-iterator --pedantic ./dir13 >actual-out &&
 	test_cmp expected-out actual-out &&
 
-	chmod 755 dir3/a
+	chmod 755 dir13/a
 '
 
 test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
-	mkdir -p dir4/a &&
-	mkdir -p dir4/b/c &&
-	>dir4/a/d &&
-	ln -s d dir4/a/e &&
-	ln -s ../b dir4/a/f
+	mkdir -p dir14/a &&
+	mkdir -p dir14/b/c &&
+	>dir14/a/d &&
+	ln -s d dir14/a/e &&
+	ln -s ../b dir14/a/f
 '
 test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
 	cat >expected-sorted-out <<-EOF &&
-	[d] (a) [a] ./dir4/a
-	[d] (b) [b] ./dir4/b
-	[d] (b/c) [c] ./dir4/b/c
-	[f] (a/d) [d] ./dir4/a/d
-	[s] (a/e) [e] ./dir4/a/e
-	[s] (a/f) [f] ./dir4/a/f
+	[d] (a) [a] ./dir14/a
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[s] (a/e) [e] ./dir14/a/e
+	[s] (a/f) [f] ./dir14/a/f
 	EOF
 
-	test-tool dir-iterator ./dir4 >actual-out &&
+	test-tool dir-iterator ./dir14 >actual-out &&
 	sort actual-out >actual-sorted-out &&
 
 	test_cmp expected-sorted-out actual-sorted-out
 '
 test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
 	cat >expected-sorted-out <<-EOF &&
-	[d] (a) [a] ./dir4/a
-	[d] (a/f) [f] ./dir4/a/f
-	[d] (a/f/c) [c] ./dir4/a/f/c
-	[d] (b) [b] ./dir4/b
-	[d] (b/c) [c] ./dir4/b/c
-	[f] (a/d) [d] ./dir4/a/d
-	[f] (a/e) [e] ./dir4/a/e
+	[d] (a) [a] ./dir14/a
+	[d] (a/f) [f] ./dir14/a/f
+	[d] (a/f/c) [c] ./dir14/a/f/c
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[f] (a/e) [e] ./dir14/a/e
 	EOF
 
-	test-tool dir-iterator --follow-symlinks ./dir4 >actual-out &&
+	test-tool dir-iterator --follow-symlinks ./dir14 >actual-out &&
 	sort actual-out >actual-sorted-out &&
 
 	test_cmp expected-sorted-out actual-sorted-out
 '
 
 test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
-	mkdir -p dir5/a/b &&
-	mkdir -p dir5/a/c &&
-	ln -s ../c dir5/a/b/d &&
-	ln -s ../ dir5/a/b/e &&
-	ln -s ../../ dir5/a/b/f
+	mkdir -p dir15/a/b &&
+	mkdir -p dir15/a/c &&
+	ln -s ../c dir15/a/b/d &&
+	ln -s ../ dir15/a/b/e &&
+	ln -s ../../ dir15/a/b/f
 '
 test_expect_success SYMLINKS 'iteration of dir w/ symlinks w/ cycle' '
 
 	cat >expected-sorted-out <<-EOF &&
-	[d] (a) [a] ./dir5/a
-	[d] (a/b) [b] ./dir5/a/b
-	[d] (a/c) [c] ./dir5/a/c
-	[s] (a/b/d) [d] ./dir5/a/b/d
-	[s] (a/b/e) [e] ./dir5/a/b/e
-	[s] (a/b/f) [f] ./dir5/a/b/f
+	[d] (a) [a] ./dir15/a
+	[d] (a/b) [b] ./dir15/a/b
+	[d] (a/c) [c] ./dir15/a/c
+	[s] (a/b/d) [d] ./dir15/a/b/d
+	[s] (a/b/e) [e] ./dir15/a/b/e
+	[s] (a/b/f) [f] ./dir15/a/b/f
 	EOF
 
-	test-tool dir-iterator ./dir5 >actual-out &&
+	test-tool dir-iterator ./dir15 >actual-out &&
 	sort actual-out >actual-sorted-out &&
 
 	test_cmp expected-sorted-out actual-sorted-out
@@ -430,7 +430,7 @@ test_expect_success SYMLINKS \
 	EOF
 
 	test_must_fail test-tool dir-iterator \
-		--pedantic --follow-symlinks ./dir5 >actual-out &&
+		--pedantic --follow-symlinks ./dir15 >actual-out &&
 	tail -n 1 actual-out >actual-tailed-out &&
 
 	test_cmp expected-tailed-out actual-tailed-out
-- 
2.36.1

