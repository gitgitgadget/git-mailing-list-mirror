Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B017320284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036730AbdEYTrI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33859 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036721AbdEYTrC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so55398290wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0bvciJ6sGGdvuREzuS/r2mWUEPUpjLFN5bLznF0gBs=;
        b=Yav9V3BU4DhBUiAQasdJ56MZ5m88AP5AqFfvLFDTrSdpMuZX0JF7YT8ErmykYGhIWj
         rjTFlwTdG6cRnbRXWs8NOyLV1SZ1UIeEiw6ZKsFW1ksDubCvycXBRnimz5kkHcaKRwxV
         Yu9IaGPRKzl+BVjfEqfKRa1hmh0W+Eao2mWsDLwOpoMYsQgtt2nqr1jo9uO8xeSjgwGd
         CJRU9cAFLj0T2LgStawfkH+lA5acKLXpWuuaPoXzTpAdyDqbT6gu34zn6b9VH+2RfMFW
         vGmGfyaWrSJHNy2SVglF67BYIAa7jqN9Sh5VlavM8nez6WFXXwSSee7Cl4IHNWTDhxy0
         FunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0bvciJ6sGGdvuREzuS/r2mWUEPUpjLFN5bLznF0gBs=;
        b=AutXwd0Ho37S0/1yhVKU4jDuhSMZTqtD+gJ/juqDEFNtmbSliYVPG9G7JqF1/xIvv0
         eY6U8+LfO4kEctgsBwVYI4keWEXH13h5qPGMxKVunF63hwU4XIbibNFq9tfni/a5Q/qN
         PaTYShckmhXe8dFTuz6BcXLKsjOdvF8hre2LKhNqhz86LdNY8PRHMCT2ZYilk1q/BNbu
         7iGNsYXjnRGyrwLSFEU/NoCchdQ6K0PerA7GLF6K2DckaW4HQLbJ2ZgkqxI5elySFt9k
         OJf2H82D8K4cVkp45FxmSckxUMzNDtlQAc1jC+vSVipVHdoXleXLCmjLzER/GsbzJKsO
         hKCQ==
X-Gm-Message-State: AODbwcD+tWHbN6rzdCVh7ks8cYOJRh9ukKnwZHZJMSlouFMXD8+E0u7d
        Aa8RpX2RlIklyg==
X-Received: by 10.28.191.145 with SMTP id o17mr11678154wmi.20.1495741614884;
        Thu, 25 May 2017 12:46:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:54 -0700 (PDT)
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
Subject: [PATCH v4 17/31] perf: add a comparison test of grep regex engines
Date:   Thu, 25 May 2017 19:45:21 +0000
Message-Id: <20170525194535.9324-18-avarab@gmail.com>
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

Add a very basic performance comparison test comparing the POSIX
basic, extended and perl engines.

In theory the "basic" and "extended" engines should be implemented
using the same underlying code with a slightly different pattern
parser, but some implementations may not do this. Jump through some
slight hoops to test both, which is worthwhile since "basic" is the
default.

Running this on an i7 3.4GHz Linux 4.9.0-2 Debian testing against a
checkout of linux.git & latest upstream PCRE, both PCRE and git
compiled with -O3 using gcc 7.1.1:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux ./run p7820-grep-engines.sh
    [...]
    Test                                            this tree
    ---------------------------------------------------------------
    7820.1: basic grep 'how.to'                     0.34(1.24+0.53)
    7820.2: extended grep 'how.to'                  0.33(1.23+0.45)
    7820.3: perl grep 'how.to'                      0.31(1.05+0.56)
    7820.5: basic grep '^how to'                    0.32(1.24+0.42)
    7820.6: extended grep '^how to'                 0.33(1.20+0.44)
    7820.7: perl grep '^how to'                     0.57(2.67+0.42)
    7820.9: basic grep '[how] to'                   0.51(2.16+0.45)
    7820.10: extended grep '[how] to'               0.49(2.20+0.43)
    7820.11: perl grep '[how] to'                   0.56(2.60+0.43)
    7820.13: basic grep '\(e.t[^ ]*\|v.ry\) rare'   0.66(3.25+0.40)
    7820.14: extended grep '(e.t[^ ]*|v.ry) rare'   0.65(3.19+0.46)
    7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       1.05(5.74+0.34)
    7820.17: basic grep 'm\(ú\|u\)lt.b\(æ\|y\)te'   0.34(1.28+0.47)
    7820.18: extended grep 'm(ú|u)lt.b(æ|y)te'      0.34(1.38+0.38)
    7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.39(1.56+0.44)

Options can also be passed to git-grep via the GIT_PERF_7820_GREP_OPTS
environment variable. There are various modes such as "-v" that have
very different performance profiles, but handling the combinatorial
explosion of testing all those options would make this script much
more complex and harder to maintain. Instead just add the ability to
do one-shot runs with arbitrary options, e.g.:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_7820_GREP_OPTS=" -i" ./run p7820-grep-engines.sh
    [...]
    Test                                               this tree
    ------------------------------------------------------------------
    7820.1: basic grep -i 'how.to'                     0.49(1.72+0.38)
    7820.2: extended grep -i 'how.to'                  0.46(1.64+0.42)
    7820.3: perl grep -i 'how.to'                      0.44(1.45+0.45)
    7820.5: basic grep -i '^how to'                    0.47(1.76+0.38)
    7820.6: extended grep -i '^how to'                 0.47(1.70+0.42)
    7820.7: perl grep -i '^how to'                     0.65(2.72+0.37)
    7820.9: basic grep -i '[how] to'                   0.86(3.64+0.42)
    7820.10: extended grep -i '[how] to'               0.84(3.62+0.46)
    7820.11: perl grep -i '[how] to'                   0.73(3.06+0.39)
    7820.13: basic grep -i '\(e.t[^ ]*\|v.ry\) rare'   1.63(8.13+0.36)
    7820.14: extended grep -i '(e.t[^ ]*|v.ry) rare'   1.64(8.01+0.44)
    7820.15: perl grep -i '(e.t[^ ]*|v.ry) rare'       1.44(6.88+0.44)
    7820.17: basic grep -i 'm\(ú\|u\)lt.b\(æ\|y\)te'   0.66(2.67+0.44)
    7820.18: extended grep -i 'm(ú|u)lt.b(æ|y)te'      0.66(2.67+0.43)
    7820.19: perl grep -i 'm(ú|u)lt.b(æ|y)te'          0.59(2.31+0.37)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p7820-grep-engines.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 t/perf/p7820-grep-engines.sh

diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
new file mode 100755
index 0000000000..62aba19e76
--- /dev/null
+++ b/t/perf/p7820-grep-engines.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description="Comparison of git-grep's regex engines
+
+Set GIT_PERF_7820_GREP_OPTS in the environment to pass options to
+git-grep. Make sure to include a leading space,
+e.g. GIT_PERF_7820_GREP_OPTS=' -i'. Some options to try:
+
+	-i
+	-w
+	-v
+	-vi
+	-vw
+	-viw
+"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+for pattern in \
+	'how.to' \
+	'^how to' \
+	'[how] to' \
+	'\(e.t[^ ]*\|v.ry\) rare' \
+	'm\(ú\|u\)lt.b\(æ\|y\)te'
+do
+	for engine in basic extended perl
+	do
+		if test $engine != "basic"
+		then
+			# Poor man's basic -> extended converter.
+			pattern=$(echo "$pattern" | sed 's/\\//g')
+		fi
+		if test $engine = "perl" && ! test_have_prereq PCRE
+		then
+			prereq="PCRE"
+		else
+			prereq=""
+		fi
+		test_perf $prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" "
+			git -c grep.patternType=$engine grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for$GIT_PERF_7820_GREP_OPTS '$pattern'" '
+		test_cmp out.basic out.extended &&
+		if test_have_prereq PCRE
+		then
+			test_cmp out.basic out.perl
+		fi
+	'
+done
+
+test_done
-- 
2.13.0.303.g4ebf302169

