Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19859201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbdETVnQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36300 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932227AbdETVnN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id k15so23157810wmh.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGirQO6xmxrwvsU4x1ubVVynXObQ6nfbnKl5TUO+mhI=;
        b=MIcKaojZHS2rw0ZOJ94AtS3HzcwFVFGoXHw7d9g7qExvEr6peQGjuSRa4v6htxOvJn
         Rf9yBSdngO+8xdT+PTOw5KUxan50za7qxf9j8P3fyMORL2OqIJSvEFUgrUGQt6+lptzo
         wFKTe67L1OxLaQVafRekjOcAGpnwXQew/N6+ZJOOe2r1olyLEdXo9Qc7WhJwYqpIgpgV
         pajKNfxPvIbQu+bk+qjOBw+9vaQF+n9ErEbRDOER5GECACAV5VDtRttR3DaYTACpCTgL
         he0L2OcvDEx87avnclAhI8QJGv1wHcWOXvC8fjuKunvmaJF9cAWZiBH8sLPomziFxmo+
         e1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGirQO6xmxrwvsU4x1ubVVynXObQ6nfbnKl5TUO+mhI=;
        b=oz98PiYSUJC3aZXTODh7/1oLypxa7bpQSlkqOIcDgL4IkRPOF4ZC7U2TktyQpHNyrA
         Jq7YZ6QM3sgldT/mtOvu6uqqiRuneFznokjqykSIIWkyN7G+rmX7Uy9wQkYQRo80Z/uY
         Tk7ShMKs6srvJb+sJ0QD2ofbAcrfwj2wg6hU6uQVR9pJB19dDeUxWyxQXeri7MUpqO2q
         a6NpbtsA/x5iPljY+VN5NEKzz4AZN6p2tBdXjyu3fgorr9pU0OUfBclyPGYEs4Yf1UzM
         jeUqF8rADuOj6VWSqL4XwBGwiuDrx8Pod9MbeXMNTNY9ytoiViTObQSCa39oGXsbxt0A
         Ul8A==
X-Gm-Message-State: AODbwcDcXMekbuRJ0NrVEqPqthlOi/srEN2oBE/kEypXQhdZZd5PpMYr
        YnHAlAyD3lBgFA==
X-Received: by 10.28.139.18 with SMTP id n18mr22166867wmd.100.1495316591772;
        Sat, 20 May 2017 14:43:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/30] grep: add a test helper function for less verbose -f \0 tests
Date:   Sat, 20 May 2017 21:42:15 +0000
Message-Id: <20170520214233.7183-13-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function to make the tests which check for patterns with
\0 in them more succinct. Right now this isn't a big win, but
subsequent commits will add a lot more of these tests.

The helper is based on the match() function in t3070-wildmatch.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7008-grep-binary.sh | 58 +++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 9c9c378119..df93d8e44c 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -4,6 +4,29 @@ test_description='git grep in binary files'
 
 . ./test-lib.sh
 
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
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $matches" 'false'
+	fi
+}
+
 test_expect_success 'setup' "
 	echo 'binaryQfile' | q_to_nul >a &&
 	git add a &&
@@ -69,35 +92,12 @@ test_expect_failure 'git grep .fi a' '
 	git grep .fi a
 '
 
-test_expect_success 'git grep -F y<NUL>f a' "
-	printf 'yQf' | q_to_nul >f &&
-	git grep -f f -F a
-"
-
-test_expect_success 'git grep -F y<NUL>x a' "
-	printf 'yQx' | q_to_nul >f &&
-	test_must_fail git grep -f f -F a
-"
-
-test_expect_success 'git grep -Fi Y<NUL>f a' "
-	printf 'YQf' | q_to_nul >f &&
-	git grep -f f -Fi a
-"
-
-test_expect_success 'git grep -Fi Y<NUL>x a' "
-	printf 'YQx' | q_to_nul >f &&
-	test_must_fail git grep -f f -Fi a
-"
-
-test_expect_success 'git grep y<NUL>f a' "
-	printf 'yQf' | q_to_nul >f &&
-	git grep -f f a
-"
-
-test_expect_success 'git grep y<NUL>x a' "
-	printf 'yQx' | q_to_nul >f &&
-	test_must_fail git grep -f f a
-"
+nul_match 1 '-F' 'yQf'
+nul_match 0 '-F' 'yQx'
+nul_match 1 '-Fi' 'YQf'
+nul_match 0 '-Fi' 'YQx'
+nul_match 1 '' 'yQf'
+nul_match 0 '' 'yQx'
 
 test_expect_success 'grep respects binary diff attribute' '
 	echo text >t &&
-- 
2.13.0.303.g4ebf302169

