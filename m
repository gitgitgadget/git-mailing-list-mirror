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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B548201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756486AbdETVnm (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33841 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbdETVn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id 6so5753076wrb.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ou95g/MwI2fjU6EWtwVRtu9SjlXjaRBL/9rEbwOTQe0=;
        b=JKCOSCjNlrlG5uAGKijL4KbPWIJ5kSG8pw4B6HhuWoRcUt6vM/sQadeVf6U36Maara
         /ENMDunksCFv5MqoEL2xA1OLt3s3qvGgWaGptffRkgbLHtqKQ/FAKG1S4O8PqWZkj2fT
         AKn9I5NPXIzwkTMhY+JpkT/jxoVW1W2KKxR209riRtfQEV1VJiUgVNk3w8/asQZAQvBv
         Xd3egykODlFqafVVFvaQIZ9x/hNCwbMELbCssYT81quLNEy6oHYBP2mA3InqYJMAWiyE
         lB2J7R4JqEsYOI8oB78USadcmA1pRM4L58ZALaBcIrXifxtV6vp+HyXrv258QoM7S3Jg
         F5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ou95g/MwI2fjU6EWtwVRtu9SjlXjaRBL/9rEbwOTQe0=;
        b=HSc6Jm83RdYUrXjmAhKnDHAHwoggg678RzW5jZ13kHFXHslkK6PqLU2POKjao4tomo
         d2rgXJR/tDjbIaJnYewiKDKavmDcp74dpH/Sj+9EYxlL2zUvuhpCxbz9AJNG98UObCTS
         GbJAMSIpoMyEgqnvzqfKoXcXZlxlrUsXzNxg3GwJJsj5qx68qz2GjDkgs9I/BJ2jko9t
         4EJJhpPBn5hjmwhELcOL5D93EShsMYgN4+PhLv5IFyBSbvBtliuMk+lJ74mQpvC17Tq/
         kUgy5f6xy0xZ/X0aYS/MQOgHeEosaGXduFIPdS6fr3rySloTwUjgI+x55qppGxG/W8lJ
         l4Iw==
X-Gm-Message-State: AODbwcCQIGJcKzzafMKppH9JEe+ufxAUl2M0mim/vT6lDNaMyG/XuSrg
        MCRPahtLPFxQ+A==
X-Received: by 10.223.155.134 with SMTP id d6mr7752748wrc.157.1495316607968;
        Sat, 20 May 2017 14:43:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:27 -0700 (PDT)
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
Subject: [PATCH v3 17/30] perf: add a comparison test of grep regex engines
Date:   Sat, 20 May 2017 21:42:20 +0000
Message-Id: <20170520214233.7183-18-avarab@gmail.com>
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
 t/perf/p7820-grep-engines.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 t/perf/p7820-grep-engines.sh

diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
new file mode 100755
index 0000000000..a3a1b9fa28
--- /dev/null
+++ b/t/perf/p7820-grep-engines.sh
@@ -0,0 +1,47 @@
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
+		test_perf "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" "
+			git -c grep.patternType=$engine grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for$GIT_PERF_7820_GREP_OPTS '$pattern'" "
+		test_cmp 'out.basic' 'out.extended' &&
+		test_cmp 'out.basic' 'out.perl'
+	"
+done
+
+test_done
-- 
2.13.0.303.g4ebf302169

