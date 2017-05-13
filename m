Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB8A20188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758863AbdEMXQs (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:48 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35470 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758804AbdEMXQk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:40 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so12532028qke.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Qr1vZk2+c/Yq3tAOE8qivpK1UIudId3tL5xdxr3vTc=;
        b=BF2/aWBYr8gMwE94uWzLKCccz0d6za1XJUjLlo5fgR2ytgEMiP++XzORzPwl4KUvg5
         bMwHOnf7kRFwW5dUdNZMnp2RuqZcytinfLpTkMN8X+9w918/uQ0bvHNsASuW6urmoVrD
         1JdrmThGTDof9XU0wv5adcuf2mgiCap5khGn/R/YOOpCxTLQCAM73k/Y8PrgIGpiP0LI
         p7ANTzA26TBOwjkeOcWBYzqpUg+psWOsvRkPRHEZvHc4tSSM8jvbHU1W6uKgpF/Lk7ea
         2kxAhza7CsArN5KQNJa2sEWAPLV3QJbN3qzpu0AVCCKKI8havUgHHGnASuPB7dPPlH46
         JtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Qr1vZk2+c/Yq3tAOE8qivpK1UIudId3tL5xdxr3vTc=;
        b=imPGZvMQFXNR7hSVE132ttiuKjL70VfE3rUuywdwb5tHLt6ZzJfAWRwN6lYp1HtBfy
         +fjq6KOB1cmaqRf1rrKoEVCQ25PZGekjds7LMhmIQM72BS9MBrNDieC/N5dbmWvsaBvM
         t5v4/7uXjwIQtJ1g9DB1NRLPvsvOdEGrx5JGX5iiyRqVsZCGrHuCBnCYjnVsetYz6Zbg
         inqUdPLSlzfRjirlQnvrSVM9fxGq6NM+/MGN+ddNr4eEzgc7Feqt1XT9zxm+Za0uc7Ae
         +5fo8vf56PJ3ScLQyDuyUN2XE111TcWYf0XbLnZ+AujU4tUTN0PvXNy2vpzvN3WojJZn
         Vt1Q==
X-Gm-Message-State: AODbwcB3lHZfl167gLaYI6q52bO1oOE9WLtBE3zOawf2bVER9Yai/4iq
        T8xgEjtu4ipLvjT5tVA=
X-Received: by 10.55.77.195 with SMTP id a186mr10559822qkb.296.1494717399180;
        Sat, 13 May 2017 16:16:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:38 -0700 (PDT)
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
Subject: [PATCH v2 16/29] perf: add a performance comparison test of grep -G, -E and -P
Date:   Sat, 13 May 2017 23:14:56 +0000
Message-Id: <20170513231509.7834-17-avarab@gmail.com>
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
    -------------------------------------------------------------
    7820.1: basic grep how.to                     0.28(1.27+0.41)
    7820.2: extended grep how.to                  0.29(1.23+0.44)
    7820.3: perl grep how.to                      0.27(1.14+0.47)
    7820.5: basic grep ^how to                    0.28(1.18+0.46)
    7820.6: extended grep ^how to                 0.28(1.25+0.40)
    7820.7: perl grep ^how to                     0.48(2.76+0.40)
    7820.9: basic grep [how] to                   0.42(2.20+0.42)
    7820.10: extended grep [how] to               0.41(2.12+0.50)
    7820.11: perl grep [how] to                   0.48(2.59+0.42)
    7820.13: basic grep \(e.t[^ ]*\|v.ry\) rare   0.55(3.26+0.44)
    7820.14: extended grep (e.t[^ ]*|v.ry) rare   0.54(3.34+0.38)
    7820.15: perl grep (e.t[^ ]*|v.ry) rare       0.88(5.82+0.35)
    7820.17: basic grep m\(ú\|u\)lt.b\(æ\|y\)te   0.29(1.26+0.48)
    7820.18: extended grep m(ú|u)lt.b(æ|y)te      0.29(1.36+0.39)
    7820.19: perl grep m(ú|u)lt.b(æ|y)te          0.32(1.61+0.43)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p7820-grep-engines.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 t/perf/p7820-grep-engines.sh

diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
new file mode 100755
index 0000000000..eb439900f3
--- /dev/null
+++ b/t/perf/p7820-grep-engines.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description="Comparison of git-grep's regex engines"
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
+			pattern=$(echo $pattern | sed 's/\\//g')
+		fi
+		test_perf "$engine grep $pattern" "
+			git -c grep.patternType=$engine grep -- '$pattern' >'out.$engine' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for $pattern" "
+		test_cmp 'out.basic' 'out.extended' &&
+		test_cmp 'out.basic' 'out.perl'
+	"
+done
+
+test_done
-- 
2.11.0

