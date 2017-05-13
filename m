Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA42A20188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758808AbdEMXQe (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:34 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36754 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758798AbdEMXQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:29 -0400
Received: by mail-qk0-f196.google.com with SMTP id y128so12508846qka.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abWRfeKlsMeudiWPH2/mDAJeW2HKhRbWqdWyJ7zNtb0=;
        b=HjOWuE7J3qAjfwYPGma0DaY+Kq6gKwoDijzp9Mk+B6o346Wblgq19BononVa7ZV5gk
         QWh0oUx0sVNSYYD+7+dP6IvD8ZJ9sTEzkWgJjAMpe5+gbBIaUNnF5PerjZg0PTsZXmeK
         0ALj+W8+VPb0BUU5BGmqtI9ptZTmbs+mT4qI3RCq6qLH1kOJ1HZnB09q0ER/RLfryEme
         3/i/w4DfZMALNCZHBGQTCw6+8GcMwkvXabHHIrYKmSk4vZUaGkSAIAdKYkKMJDA33V6j
         Ad9pQMif5OsaYBtzQzzcfyXP1BKohbsOToY7w4yJRUVWF2mry2Dd0X75659B25vaWKv9
         TuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abWRfeKlsMeudiWPH2/mDAJeW2HKhRbWqdWyJ7zNtb0=;
        b=TOY3beDrzRh6n8u1ScoVVKxtTbWbmd6S0r0Ko2alwz4Ii1cNbTgFhYCYdvL8xo0POc
         +90Fp5FV2fQR4L5l7TQ929kGCjhzwMumAoWsAxxs1wbhgwV0rrmyp5vDYrX4L3sYGHTc
         qwHqfI9MtArLAb2DV7rsjRFCnq96K7vTPIMWIuNX+GkMf4oNDUm5sDJD5qJrUdrnOh89
         Yd1umeH1kkcvOoowKYOrB1ff07bRIsaLQ4hu83faTBt5B40Nz+4MVzwvdDrGOaQpD2y7
         5ZGkZW0GDi1vR/0ZLXoebrXCiG6kvndmzKqjExoo1eOvPzEcLITCq+rnDUKSqLtSs4jC
         8cjw==
X-Gm-Message-State: AODbwcCRbBOTYEsLCUXbtUAUdbVJA1MHaYGUhosO1cT8Zv1VEKUhzLQm
        MVIdOJwsJoZnuA==
X-Received: by 10.55.20.2 with SMTP id e2mr9618621qkh.15.1494717388738;
        Sat, 13 May 2017 16:16:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:27 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/29] grep: add tests to fix blind spots with \0 patterns
Date:   Sat, 13 May 2017 23:14:53 +0000
Message-Id: <20170513231509.7834-14-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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

Furthermore, the kwset path is dependent on whether the the -i flag is
on, and whether the pattern has any non-ASCII characters, but none of
this was tested for.

See the a previous commit in this series ("grep: add tests to fix
blind spots with \0 patterns", 2017-04-21) for further details &
rationale.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7008-grep-binary.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index e7754c3946..079395ba54 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -22,6 +22,18 @@ nul_match () {
 			printf '$pattern' | q_to_nul >f &&
 			test_must_fail git grep -f f $flags a
 		"
+	elif test "$status" = T1
+	then
+		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			git grep -f f $flags a
+		"
+	elif test "$status" = T0
+	then
+		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
+			printf '$pattern' | q_to_nul >f &&
+			test_must_fail git grep -f f $flags a
+		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown status $status" 'false'
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
2.11.0

