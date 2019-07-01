Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D601F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfGAVVX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:23 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54131 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:21 -0400
Received: by mail-wm1-f44.google.com with SMTP id x15so885025wmj.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+qhYDvPBakHIP3UC2hedMaJ5fEjJCaLZvim4xmFh3k=;
        b=NiX3ROCLi7BB8KOPDrTXG+SgZSV8LenCF6MfssEHagW2mfdb9CZj9okiDVTncFXEhY
         3bYSH9GjYAFUtVzEGOemKXwXYV5Iaex9ip7XXUYEEcs0i/dq8jOnIKR+SdkoIGVqDGX7
         p/zR6Qc6NKemozffR6te9MSLC4meLspJ55OU1At/AKkC2Dk60GCV2pDSAhl5puJb9r16
         Np7t5x1w/i6Dq++/9LkYjyO0S2HhpQ4nW+Yiu31ECG4SHNkqwYz+xd0ylm2HcGTFy23h
         wmqhu042G5ItFDjo067+gDuZd+1JKxdb/Ub/HSJ3ZYRZvIpVk76+uba2RXg9BVJlXUDM
         67Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+qhYDvPBakHIP3UC2hedMaJ5fEjJCaLZvim4xmFh3k=;
        b=B5tw0nC2lJ8IBwgZgv5skdccBdIBvDXceQ6NAB+0g2I5+Y2IBN9SKi3s3ulChFVSBN
         /xoRcUTLEaaRupz9sQWYqKfCJl32EksV3W1AfD5SuqEB5opwDesOnfzIlo782w0LGokT
         ghAFcAfgHdhYMkq3uu2Q3Eby8JFISttHxPXgf23bHTxIi0i/q1+9yGA+qRGBoV8lODt9
         dV96wG0g5oMccyDimsHEGa6iEWom2sQFbv5Q5pBut0//jdxGqI+hoBjGhDJqPObLFMcY
         G8EWyRdVRQEn80Jl5DBbMNA//VkhWPRltfGQ80p7rF+89NekNt0nwXWGL00gh7tAKIPL
         fTBw==
X-Gm-Message-State: APjAAAUQZ6LRqi/pA2VncKTY4bUplXhfHm24fUxBCrQaM5aQLiefwVsU
        +o24SKjwFEW+qkJjWj72fNXTF7PomrU=
X-Google-Smtp-Source: APXvYqw8Xtl90q1qxtEteel37AzLZvPctsYSwBwx5KCfW350PxyfqeQFOZmnqYP94LCe2CCs4vK9Fg==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr729122wma.46.1562016077824;
        Mon, 01 Jul 2019 14:21:17 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/10] grep tests: move binary pattern tests into their own file
Date:   Mon,  1 Jul 2019 23:20:56 +0200
Message-Id: <20190701212100.27850-7-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
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

