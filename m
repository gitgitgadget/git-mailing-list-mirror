Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30B320284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036719AbdEYTq6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34437 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036692AbdEYTqy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so55397234wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPdeODsTAEEVdZJdyL+Y2CxoNX/Bhrxr2Ng0OzeuQCI=;
        b=n1cRL87sTCODIpSWxPEeQiOwVRqrNgsNueerlOzD2sR0HwwLHiuZhUzrgeV3Ho4cyl
         AMjRm2n1g+VCYpvQZzzdQqDnQaoAOnCjYZbw2D+iQvm9xO3IsILoPd+7PVmY3bhlWHvn
         7PjQFWV3ARs1amwO7JzjXneIQAYFQHVYkr5NjhU/pLatt5IjCB4hRvS6wmV9Nq6Ho0OM
         6ctIrfyuR2h7rWhr16lswjwegvmT03//OrfgNEjDC1yqDtucbf1hOqjY4hXo5ufXmqaB
         AeBohwmKmc5OvkLuHhQFqXlAoE1o1iNt7cUagX2pir0PGrzCg1ApGSkaY6cv6VkEHgl7
         xt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPdeODsTAEEVdZJdyL+Y2CxoNX/Bhrxr2Ng0OzeuQCI=;
        b=iEGQoiHd/ZFePvdB5LRNvYPXokCHR3ZF9NGTaHh0DLDxYW0b4X33w7CifazYx2jIQ/
         PLWmG23DM0NhxH8eXQMOH2jNOHe2nIQ+evo5AjhhlJ3V2TI3KPfJ3TzWHGzfwQDjWWv2
         VE9yq9MBVwSLM8mYvauWBfrP5eOP+2Wt2/4dau/r7jI5XU52472zZV8o+tmqWRRmA0aW
         wXQDnUiK2E+rmf+nrCsDMD3R1kfnuIAK889SkrxRR5M9XRoRmQpv6Lb64R0lhMi94p0j
         ojl8h3lZ5XX6yn8tiWnj1udnqRBgtSU3uosZFU4tZOd71e4NSFl87SZMBBcR5UxPyA2/
         q+ow==
X-Gm-Message-State: AODbwcAR7/XT6baelZybDggIS0stBhEiY/6c61q1tZbMCAaD94GycgIm
        B1p4aZGcfnyt/w/nYcs=
X-Received: by 10.28.144.10 with SMTP id s10mr11869799wmd.62.1495741607110;
        Thu, 25 May 2017 12:46:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:46 -0700 (PDT)
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
Subject: [PATCH v4 14/31] grep: add tests to fix blind spots with \0 patterns
Date:   Thu, 25 May 2017 19:45:18 +0000
Message-Id: <20170525194535.9324-15-avarab@gmail.com>
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

