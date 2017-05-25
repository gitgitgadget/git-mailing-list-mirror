Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFF820284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036691AbdEYTqr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33260 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036692AbdEYTqn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so39672260wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGirQO6xmxrwvsU4x1ubVVynXObQ6nfbnKl5TUO+mhI=;
        b=ezTUZyLhmqUiIk1Qa509asOS7W0hbItzXm6+FnzX6CP68uJAtC1oEENteVKwlLKlcn
         5G4zFjY9RhUe30SBOhAgiWNnS3CrldExYfRQOwQzhr7k4JmUf/2wEt9im9YkDi5BeTx+
         i6wF3bbPsYqSI45Jyhx2bxqahyGnf50os6KIUx4HizAO4bzO++qC3RM2FfiDznDVs/gS
         tQbGd/emuLlIJ/jIfuCaFB0QEv7axUWTgIiPp10WpNwIlxlb+K1WPmQQuKl97qxLttUK
         YoJX5taC25oCqddc2AWLXBZcT1xqeV0jxENIl82FW2PytIrbrpc28skqwBUhtim1rG1L
         j47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGirQO6xmxrwvsU4x1ubVVynXObQ6nfbnKl5TUO+mhI=;
        b=m/pG7Vi29vGP6AaASlDNfjbuC+LZgE63x/SA3ULFfDOE9IJqngjIOrmheksf8UsOMb
         WH41/4XmdGk+oqJU0uOXzfXWlLTc6eHrXzYDmH0kUfi1+GmfLEWyeTmmjPQJnToiX55J
         qBfXZKH9oPVW3oybnPG/Kf6pnsL7cP/OJbjdzZGkwKFsudWldC4cmJKjBY2JQw5DiM4S
         lBEYNl1LqOU9WXiDJg+OzD4Ryx7KM//ITYojOdCS4Rta36KFUD52TzH0d2OeuPkQZb1Q
         5OCcmHK7o2tMD5+gS1z9l7T0Fj2YIZNXayMF7y/n8JhCpMbRQEoSAroooImEGknqcLrC
         5stg==
X-Gm-Message-State: AODbwcCNzu3N2SWn78OJD0VOLxvPIf3vVVtmawJVxaSQ4lk6rFB3rJ5h
        Lvf0mojnxBU0DwM4SrM=
X-Received: by 10.223.152.233 with SMTP id w96mr20736457wrb.151.1495741601532;
        Thu, 25 May 2017 12:46:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:40 -0700 (PDT)
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
Subject: [PATCH v4 12/31] grep: add a test helper function for less verbose -f \0 tests
Date:   Thu, 25 May 2017 19:45:16 +0000
Message-Id: <20170525194535.9324-13-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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

