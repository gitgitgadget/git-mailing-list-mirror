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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC87201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932333AbdETVna (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35253 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932251AbdETVnW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so4767460wmc.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPdeODsTAEEVdZJdyL+Y2CxoNX/Bhrxr2Ng0OzeuQCI=;
        b=sWgLkYR2J09qrcBol0cJQr5daRUWhm8XGrCJ+GK+Z4RqW7Fn8kAA7ufDkRE6LyeO22
         qZSGbs85mcRBlLAJjYgjmq1L8hBlAHj2tKQLaogwQkLOgKC6O1n6Ak7ZXLyVr5cexbnA
         JYPmx5/mC/49+Z3OI6YabG5TNcQ+hvtNAQDFuaWgScQ9d+9VRXBNDsvQWaDxkJX93e4Y
         g5CbgNlN6pj6i+z2emHpvmQ+a4A733K7pcsZT5kSGmUrhlD+OlbIdEzVSjj5fNLGPfzW
         tEnMQydhv7ojp8EtLL6hFi4b1g/zNT74/+QsUlGiWLUwRC3mwB+Wysg7nIiFjhlyBfbe
         uExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPdeODsTAEEVdZJdyL+Y2CxoNX/Bhrxr2Ng0OzeuQCI=;
        b=n0E7H/BCGd2rJlZCTw/6UgIWna5vvXU0OBDkggCST7jlSo4WIRgLsGugXQEd72osHd
         qzd5VOHo+uXTGqUwOU9h+XOOn8jse3iB5E3Nbrl7qzvJF4R85eOwgoSWDv458LQUzVp+
         4zk480StccRZ0sbmxFNLDX0sJVA3O13EyJ0pSIJwyzBG2SzOxiiz+ScBF5iJLF1YbtHi
         n5Y8Rdo4N/bI33mselpYzpcVQUGtFjFA6x6I63onqoaCtpOmJ+adDKBkYaJU0lIC5U64
         UMHzJ+o6zUWQK0H1OjPrtChdqlJFbS0AH6Rd2YSC1bZRfYigBdWCvxOumSFeQKh3io3S
         8ptQ==
X-Gm-Message-State: AODbwcBLnsCbE2vB+qVHeCxATZLQVf9uwDp+RCFrfEUOqjrM1fp2L6x/
        eOwcdh+CDSK/bg==
X-Received: by 10.28.102.4 with SMTP id a4mr10561536wmc.60.1495316596302;
        Sat, 20 May 2017 14:43:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:15 -0700 (PDT)
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
Subject: [PATCH v3 14/30] grep: add tests to fix blind spots with \0 patterns
Date:   Sat, 20 May 2017 21:42:17 +0000
Message-Id: <20170520214233.7183-15-avarab@gmail.com>
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

Address a big blind spot in the tests for patterns containing \0. The
is_fixed() function considers any string that contains \0 fixed, even
if it contains regular expression metacharacters, those patterns are
currently matched with kwset.

Before this change removing that memchr(s, 0, len) check from
is_fixed() wouldn't change the result of any of the tests, since
regcomp() will happily match the part before the \0.

The kwset path is dependent on whether the the -i flag is on, and
whether the pattern has any non-ASCII characters, but none of this was
tested for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7008-grep-binary.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 20370d6e0c..615e7e0162 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -22,6 +22,18 @@ nul_match () {
 			printf '$pattern' | q_to_nul >f &&
 			test_must_fail git grep -f f $flags a
 		"
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
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $matches" 'false'
 	fi
@@ -98,6 +110,65 @@ nul_match 1 '-Fi' 'YQf'
 nul_match 0 '-Fi' 'YQx'
 nul_match 1 '' 'yQf'
 nul_match 0 '' 'yQx'
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
 
 test_expect_success 'grep respects binary diff attribute' '
 	echo text >t &&
-- 
2.13.0.303.g4ebf302169

