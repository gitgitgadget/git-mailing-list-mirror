Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB5E1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755251AbdEKJTn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36205 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755246AbdEKJTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so5450684wmu.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7KCNYsY3EUnI1zmv71r5GDmq9rfTPaIh1GETGxDxds=;
        b=BfrVWuC20dyqf0BqM3meOE04EPYZ9jZRnMjUx/5IcHRHJSjA3aHwEeGJ8jL9pJz4Kg
         MIktONJsOsDFRqJ8tldmF1/fvxSGELUo2Y9p68+3CEzef5ZHUeqNTwMPhBmwkA7V3ThM
         KvPZICPaFaEM5b5eB4QTCwkSk7hExo2Z4X7ms4bJLyKzmgh2XNjGNHmNt5JcTHQKApu6
         3EpcAsp/kUiEbs6hDRgOFYTqpRtqtfFdQg03CTzkbG3XBVDhykH8dtgIjYgmH2dojFCi
         rT1Qvl9PzGXQyL5ua76ah4zixxKktQLFIasv+wo7MMu9As9Ca1lINLcoDQVxFkvUkdIn
         bNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7KCNYsY3EUnI1zmv71r5GDmq9rfTPaIh1GETGxDxds=;
        b=TzAMe4/L/GF0X31CgSX+0XKVfcbB9AUhTesUkhhvR6xBx23DO/l0QG8Yjyy3WGd6OU
         PtyNxWw8JF/lngEGERXWfIPtTaF6A9R3XT5xssEYo7Q3X6wG5S455/2V/YnVC8zB48Oq
         gr2O2OgKDxgmIE3/GDPygaHIXIwoNrIr+4Epn+QAY3HPABiNpZ9wzdEt0JbBkzZPjYH2
         ODZZbTnBEZd7xQttf65g8Jhs1I8C2F+gwxCW2bXNpiRSKiA5cHdnjv5me/yaViKuI6tJ
         GIZ+80gZ2AV1SYJ4E8/OoDVxu6D72vQiV21ZMqCIgMCf0nWuGSRVWS9byabiUAbnQnen
         hzrg==
X-Gm-Message-State: AODbwcAwplaWXHLrdlsav06/OfJsrbZnjfqcNcWcrLK6TZU41AJCvl6L
        nMBPx3vfp3x5hg==
X-Received: by 10.80.148.185 with SMTP id s54mr52890eda.34.1494494375120;
        Thu, 11 May 2017 02:19:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:34 -0700 (PDT)
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
Subject: [PATCH 16/29] perf: add a performance comparison test of grep -G, -E and -P
Date:   Thu, 11 May 2017 09:18:16 +0000
Message-Id: <20170511091829.5634-17-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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
    7820.1: basic grep how.to                      0.97(0.80+0.16)
    7820.2: extended grep how.to                   1.03(0.81+0.19)
    7820.3: perl grep how.to                       0.94(0.68+0.24)
    7820.5: basic grep ^how to                     0.97(0.73+0.21)
    7820.6: extended grep ^how to                  0.97(0.74+0.20)
    7820.7: perl grep ^how to                      1.85(1.58+0.23)
    7820.9: basic grep [how] to                    1.72(1.49+0.20)
    7820.10: extended grep [how] to                1.67(1.42+0.23)
    7820.11: perl grep [how] to                    1.81(1.56+0.22)
    7820.13: basic grep \(e.t[^ ]*\|v.ry\) rare    2.38(2.16+0.20)
    7820.14: extended grep (e.t[^ ]*|v.ry) rare    2.42(2.16+0.22)
    7820.15: perl grep (e.t[^ ]*|v.ry) rare        3.58(3.40+0.17)
    7820.17: basic grep m\(ú\|u\)ult.b\(æ\|y\)te   1.04(0.77+0.24)
    7820.18: extended grep m(ú|u)ult.b(æ|y)te      1.03(0.81+0.20)
    7820.19: perl grep m(ú|u)ult.b(æ|y)te          1.23(0.98+0.24)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p7820-grep-engines.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 t/perf/p7820-grep-engines.sh

diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
new file mode 100755
index 0000000000..c99979990e
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
+	'm\(ú\|u\)ult.b\(æ\|y\)te'
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

