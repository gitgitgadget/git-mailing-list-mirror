Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356711F461
	for <e@80x24.org>; Thu, 27 Jun 2019 23:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfF0Xje (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 19:39:34 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39328 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfF0Xjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:33 -0400
Received: by mail-wm1-f41.google.com with SMTP id z23so7218979wma.4
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+qhYDvPBakHIP3UC2hedMaJ5fEjJCaLZvim4xmFh3k=;
        b=IFe2qRv1cigPQSiIcoyYDq6tS5+w52me7W2zhx20kbHmNxWCX7iMyCo3D3ujBm45iR
         DUuuKVEGc9codVOON2jUU0LF+xrHX/AK/PoJnlvU7/ujelP8VAct1hl76tshr8Sz0JLL
         XiLOSAHTpvdFomVlanQKfEzilCB8inbCtfzALZ6Zbi6b+gM2kwLlhIkHPUW+VpPSiS0v
         LAvqrS16O6Y+OMu1kZsoyMLeNdDGlfJ6aHPx4B4HnhkPA+J27yKYCqoTU43LWDzF0u0z
         D9SvYoGK0Zc42qbe/vaZM+GsrcVMmO1komNn9EmJHsE//IK0Qdfo21o6D/++4qTTrRu9
         It7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+qhYDvPBakHIP3UC2hedMaJ5fEjJCaLZvim4xmFh3k=;
        b=t+w0gXn3q6T68gN7WvSRBhCDAF6Md1t5OX2NuOI/5LYdohLOL2SLmCtJovA8vnoTKZ
         I2KZx/uXjJv//EryAvQs6vZutHOuo7M1BzvgPzbwzF6yJSJjZZEIFD62DqeA4Jz7tvMv
         BAy2NMjFIP8YniLsjC6vFL2AGkFuX74p/+Qv8Zlcrard6F8EF5ZPXotYSazOgQRkw2tx
         25R9L5w5OG2+n5N1Twb6iZiS32iPJMyGN+HSKl5tGoVAeHGNmfBbqrtm96efWX6TMwFT
         Uuans8wN9EHXBKLVOnItcc5seD7ZlGT3O2kJWMkBhXqMt2qV/gF4tZFdq+EJOD99Dajp
         rfog==
X-Gm-Message-State: APjAAAVI4jAdEDL+s2JJps7Atw8mGdrVu7KKVTzFjHAcKpve0ZI/DUSo
        9Cu76l72ID8hP87ZxhjcVEtziPwwlEQ=
X-Google-Smtp-Source: APXvYqwY0GkouRSgAT8Z6DuMGf9iUedLjzL0H4GDup/1hKbAjS8ZyWpGEkmJdhwMg2UpPS30r7Yoig==
X-Received: by 2002:a1c:a01a:: with SMTP id j26mr3939076wme.112.1561678769722;
        Thu, 27 Jun 2019 16:39:29 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x16sm720530wmj.4.2019.06.27.16.39.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:39:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] grep tests: move binary pattern tests into their own file
Date:   Fri, 28 Jun 2019 01:39:08 +0200
Message-Id: <20190627233912.7117-6-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190626000329.32475-1-avarab@gmail.com>
References: <20190626000329.32475-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the tests for "-f <file>" where "<file>" contains a NUL byte
pattern into their own file. I added most of these tests in
966be95549 ("grep: add tests to fix blind spots with \0 patterns",
2017-05-20).

Whether a regex engine supports matching binary content is very
different from whether it matches binary patterns. Since
2f8952250a ("regex: add regexec_buf() that can work on a non
NUL-terminated string", 2016-09-21) we've required REG_STARTEND of our
regex engines so we can match binary content, but only the PCRE v2
engine can sensibly match binary patterns.

Since 9eceddeec6 ("Use kwset in grep", 2011-08-21) we've been punting
patterns containing NUL-byte and considering them fixed, except in
cases where "--ignore-case" is provided and they're non-ASCII, see
5c1ebcca4d ("grep/icase: avoid kwsset on literal non-ascii strings",
2016-06-25). Subsequent commits will change this behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7815-grep-binary.sh         | 101 -----------------------------
 t/t7816-grep-binary-pattern.sh | 114 +++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 101 deletions(-)
 create mode 100755 t/t7816-grep-binary-pattern.sh

diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index 2d87c49b75..90ebb64f46 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -4,41 +4,6 @@ test_description='git grep in binary files'
 
 . ./test-lib.sh
 
-nul_match () {
-	matches=$1
-	flags=$2
-	pattern=$3
-	pattern_human=$(echo "$pattern" | sed 's/Q/<NUL>/g')
-
-	if test "$matches" = 1
-	then
-		test_expect_success "git grep -f f $flags '$pattern_human' a" "
-			printf '$pattern' | q_to_nul >f &&
-			git grep -f f $flags a
-		"
-	elif test "$matches" = 0
-	then
-		test_expect_success "git grep -f f $flags '$pattern_human' a" "
-			printf '$pattern' | q_to_nul >f &&
-			test_must_fail git grep -f f $flags a
-		"
-	elif test "$matches" = T1
-	then
-		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
-			printf '$pattern' | q_to_nul >f &&
-			git grep -f f $flags a
-		"
-	elif test "$matches" = T0
-	then
-		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
-			printf '$pattern' | q_to_nul >f &&
-			test_must_fail git grep -f f $flags a
-		"
-	else
-		test_expect_success "PANIC: Test framework error. Unknown matches value $matches" 'false'
-	fi
-}
-
 test_expect_success 'setup' "
 	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
 	git add a &&
@@ -102,72 +67,6 @@ test_expect_failure 'git grep .fi a' '
 	git grep .fi a
 '
 
-nul_match 1 '-F' 'yQf'
-nul_match 0 '-F' 'yQx'
-nul_match 1 '-Fi' 'YQf'
-nul_match 0 '-Fi' 'YQx'
-nul_match 1 '' 'yQf'
-nul_match 0 '' 'yQx'
-nul_match 1 '' 'æQð'
-nul_match 1 '-F' 'eQm[*]c'
-nul_match 1 '-Fi' 'EQM[*]C'
-
-# Regex patterns that would match but shouldn't with -F
-nul_match 0 '-F' 'yQ[f]'
-nul_match 0 '-F' '[y]Qf'
-nul_match 0 '-Fi' 'YQ[F]'
-nul_match 0 '-Fi' '[Y]QF'
-nul_match 0 '-F' 'æQ[ð]'
-nul_match 0 '-F' '[æ]Qð'
-nul_match 0 '-Fi' 'ÆQ[Ð]'
-nul_match 0 '-Fi' '[Æ]QÐ'
-
-# kwset is disabled on -i & non-ASCII. No way to match non-ASCII \0
-# patterns case-insensitively.
-nul_match T1 '-i' 'ÆQÐ'
-
-# \0 implicitly disables regexes. This is an undocumented internal
-# limitation.
-nul_match T1 '' 'yQ[f]'
-nul_match T1 '' '[y]Qf'
-nul_match T1 '-i' 'YQ[F]'
-nul_match T1 '-i' '[Y]Qf'
-nul_match T1 '' 'æQ[ð]'
-nul_match T1 '' '[æ]Qð'
-nul_match T1 '-i' 'ÆQ[Ð]'
-
-# ... because of \0 implicitly disabling regexes regexes that
-# should/shouldn't match don't do the right thing.
-nul_match T1 '' 'eQm.*cQ'
-nul_match T1 '-i' 'EQM.*cQ'
-nul_match T0 '' 'eQm[*]c'
-nul_match T0 '-i' 'EQM[*]C'
-
-# Due to the REG_STARTEND extension when kwset() is disabled on -i &
-# non-ASCII the string will be matched in its entirety, but the
-# pattern will be cut off at the first \0.
-nul_match 0 '-i' 'NOMATCHQð'
-nul_match T0 '-i' '[Æ]QNOMATCH'
-nul_match T0 '-i' '[æ]QNOMATCH'
-# Matches, but for the wrong reasons, just stops at [æ]
-nul_match 1 '-i' '[Æ]Qð'
-nul_match 1 '-i' '[æ]Qð'
-
-# Ensure that the matcher doesn't regress to something that stops at
-# \0
-nul_match 0 '-F' 'yQ[f]'
-nul_match 0 '-Fi' 'YQ[F]'
-nul_match 0 '' 'yQNOMATCH'
-nul_match 0 '' 'QNOMATCH'
-nul_match 0 '-i' 'YQNOMATCH'
-nul_match 0 '-i' 'QNOMATCH'
-nul_match 0 '-F' 'æQ[ð]'
-nul_match 0 '-Fi' 'ÆQ[Ð]'
-nul_match 0 '' 'yQNÓMATCH'
-nul_match 0 '' 'QNÓMATCH'
-nul_match 0 '-i' 'YQNÓMATCH'
-nul_match 0 '-i' 'QNÓMATCH'
-
 test_expect_success 'grep respects binary diff attribute' '
 	echo text >t &&
 	git add t &&
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
new file mode 100755
index 0000000000..4060dbd679
--- /dev/null
+++ b/t/t7816-grep-binary-pattern.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+
+test_description='git grep with a binary pattern files'
+
+. ./test-lib.sh
+
+nul_match () {
+	matches=$1
+	flags=$2
+	pattern=$3
+	pattern_human=$(echo "$pattern" | sed 's/Q/<NUL>/g')
+
+	if test "$matches" = 1
+	then
+		test_expect_success "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			git grep -f f $flags a
+		"
+	elif test "$matches" = 0
+	then
+		test_expect_success "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			test_must_fail git grep -f f $flags a
+		"
+	elif test "$matches" = T1
+	then
+		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			git grep -f f $flags a
+		"
+	elif test "$matches" = T0
+	then
+		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			test_must_fail git grep -f f $flags a
+		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $matches" 'false'
+	fi
+}
+
+test_expect_success 'setup' "
+	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
+	git add a &&
+	git commit -m.
+"
+
+nul_match 1 '-F' 'yQf'
+nul_match 0 '-F' 'yQx'
+nul_match 1 '-Fi' 'YQf'
+nul_match 0 '-Fi' 'YQx'
+nul_match 1 '' 'yQf'
+nul_match 0 '' 'yQx'
+nul_match 1 '' 'æQð'
+nul_match 1 '-F' 'eQm[*]c'
+nul_match 1 '-Fi' 'EQM[*]C'
+
+# Regex patterns that would match but shouldn't with -F
+nul_match 0 '-F' 'yQ[f]'
+nul_match 0 '-F' '[y]Qf'
+nul_match 0 '-Fi' 'YQ[F]'
+nul_match 0 '-Fi' '[Y]QF'
+nul_match 0 '-F' 'æQ[ð]'
+nul_match 0 '-F' '[æ]Qð'
+nul_match 0 '-Fi' 'ÆQ[Ð]'
+nul_match 0 '-Fi' '[Æ]QÐ'
+
+# kwset is disabled on -i & non-ASCII. No way to match non-ASCII \0
+# patterns case-insensitively.
+nul_match T1 '-i' 'ÆQÐ'
+
+# \0 implicitly disables regexes. This is an undocumented internal
+# limitation.
+nul_match T1 '' 'yQ[f]'
+nul_match T1 '' '[y]Qf'
+nul_match T1 '-i' 'YQ[F]'
+nul_match T1 '-i' '[Y]Qf'
+nul_match T1 '' 'æQ[ð]'
+nul_match T1 '' '[æ]Qð'
+nul_match T1 '-i' 'ÆQ[Ð]'
+
+# ... because of \0 implicitly disabling regexes regexes that
+# should/shouldn't match don't do the right thing.
+nul_match T1 '' 'eQm.*cQ'
+nul_match T1 '-i' 'EQM.*cQ'
+nul_match T0 '' 'eQm[*]c'
+nul_match T0 '-i' 'EQM[*]C'
+
+# Due to the REG_STARTEND extension when kwset() is disabled on -i &
+# non-ASCII the string will be matched in its entirety, but the
+# pattern will be cut off at the first \0.
+nul_match 0 '-i' 'NOMATCHQð'
+nul_match T0 '-i' '[Æ]QNOMATCH'
+nul_match T0 '-i' '[æ]QNOMATCH'
+# Matches, but for the wrong reasons, just stops at [æ]
+nul_match 1 '-i' '[Æ]Qð'
+nul_match 1 '-i' '[æ]Qð'
+
+# Ensure that the matcher doesn't regress to something that stops at
+# \0
+nul_match 0 '-F' 'yQ[f]'
+nul_match 0 '-Fi' 'YQ[F]'
+nul_match 0 '' 'yQNOMATCH'
+nul_match 0 '' 'QNOMATCH'
+nul_match 0 '-i' 'YQNOMATCH'
+nul_match 0 '-i' 'QNOMATCH'
+nul_match 0 '-F' 'æQ[ð]'
+nul_match 0 '-Fi' 'ÆQ[Ð]'
+nul_match 0 '' 'yQNÓMATCH'
+nul_match 0 '' 'QNÓMATCH'
+nul_match 0 '-i' 'YQNÓMATCH'
+nul_match 0 '-i' 'QNÓMATCH'
+
+test_done
-- 
2.22.0.455.g172b71a6c5

