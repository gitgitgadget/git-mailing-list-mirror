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
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F602027E
	for <e@80x24.org>; Sat, 20 May 2017 21:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756484AbdETVnr (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35551 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756469AbdETVnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id g15so4768032wmc.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpOhUxJpNKK7DL7BLTZ2o7Eni0+LDtSXwYhDL0BEBpo=;
        b=k4xgCgqP7qOwrjC5sh4qBwSt2RzZ9nEooarhA6/WjHE2UhvJxsv7LMQeXt7KqadLZo
         5vywE13GhlqVvHrXUUiiWOacXKhU6CZGLe+f7wQJH0UUqoE8WF7yYvaS3BOlsYVbr4Yq
         c9PE/zKSyM6tQQ9dXCRZ+oyiMgzJoprkMhvgCbNr44VWjHHOKLvqUzz32itHg1kA+n1k
         ULdj1V5bLj8FidHgBBN+ZsuCf22jxQ8rlaoG2oaoQdySDj+u5q38LDEtOi5JZjNTxH1v
         4RWGnwKpK+NMWgmZ6sxpLhW9BN2yIolTPJVPT2iYLxgxtJqqu9gYTSSpBGpeRTBsYvIP
         fPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpOhUxJpNKK7DL7BLTZ2o7Eni0+LDtSXwYhDL0BEBpo=;
        b=GpEU12JTQRApAucv6zj6RTh1bWU0CIa9KSGzFE+jOz6jCC6bzSb+14wb7bipcSQ1cA
         1LJVRUnQBwtL9gZ2QWwj709/bgDM5glgPeRI3hqNXZFFabEaX5GOTeSHB6BX/QpVgF94
         vul3Sq/zf43AiNHf8zUBB7Uonfv3Mz1ndP6PvnjJqQUMYId9Y8Vn/XKxElx1FYtyY23B
         xbck+5qXExwA3qHUkOxh+QiIRFn9aeoRCxCWRwcWfBITHsAQeJYR3crKSK7t0bU/ArAS
         wx5HD8iKVv4YBb5tgqTPNo6jGeB+9mWKRryfkzF/Oz7ZA9SrxuoRoIC6OEluwFIJqf2w
         Pk6g==
X-Gm-Message-State: AODbwcDC8yPGI2+2LDX23TofClN8D8PhL7CauFj4pDqELpAn9r2p0JfH
        le9wWVnv6/Cm+Y3YH8M=
X-Received: by 10.28.58.16 with SMTP id h16mr10234332wma.131.1495316614384;
        Sat, 20 May 2017 14:43:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:33 -0700 (PDT)
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
Subject: [PATCH v3 19/30] perf: add a comparison test of log --grep regex engines
Date:   Sat, 20 May 2017 21:42:22 +0000
Message-Id: <20170520214233.7183-20-avarab@gmail.com>
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
basic, extended and perl engines with patterns matching log messages
via --grep=<pattern>.

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux ./run p4220-log-grep-engines.sh
    [...]
    Test                                                  this tree
    ---------------------------------------------------------------------
    4220.1: basic log --grep='how.to'                     6.22(6.00+0.21)
    4220.2: extended log --grep='how.to'                  6.23(5.98+0.23)
    4220.3: perl log --grep='how.to'                      6.07(5.79+0.25)
    4220.5: basic log --grep='^how to'                    6.19(5.93+0.22)
    4220.6: extended log --grep='^how to'                 6.19(5.93+0.23)
    4220.7: perl log --grep='^how to'                     6.14(5.88+0.24)
    4220.9: basic log --grep='[how] to'                   6.96(6.65+0.28)
    4220.10: extended log --grep='[how] to'               6.96(6.69+0.24)
    4220.11: perl log --grep='[how] to'                   6.95(6.58+0.33)
    4220.13: basic log --grep='\(e.t[^ ]*\|v.ry\) rare'   7.10(6.80+0.27)
    4220.14: extended log --grep='(e.t[^ ]*|v.ry) rare'   7.07(6.80+0.26)
    4220.15: perl log --grep='(e.t[^ ]*|v.ry) rare'       7.70(7.46+0.22)
    4220.17: basic log --grep='m\(ú\|u\)lt.b\(æ\|y\)te'   6.12(5.87+0.24)
    4220.18: extended log --grep='m(ú|u)lt.b(æ|y)te'      6.14(5.84+0.26)
    4220.19: perl log --grep='m(ú|u)lt.b(æ|y)te'          6.16(5.93+0.20)

With -i:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_4220_LOG_OPTS=' -i' ./run p4220-log-grep-engines.sh
    [...]
    Test                                                     this tree
    ------------------------------------------------------------------------
    4220.1: basic log -i --grep='how.to'                     6.74(6.41+0.32)
    4220.2: extended log -i --grep='how.to'                  6.78(6.55+0.22)
    4220.3: perl log -i --grep='how.to'                      6.06(5.77+0.28)
    4220.5: basic log -i --grep='^how to'                    6.80(6.57+0.22)
    4220.6: extended log -i --grep='^how to'                 6.83(6.52+0.29)
    4220.7: perl log -i --grep='^how to'                     6.16(5.94+0.20)
    4220.9: basic log -i --grep='[how] to'                   7.87(7.61+0.24)
    4220.10: extended log -i --grep='[how] to'               7.85(7.57+0.27)
    4220.11: perl log -i --grep='[how] to'                   7.03(6.75+0.25)
    4220.13: basic log -i --grep='\(e.t[^ ]*\|v.ry\) rare'   8.68(8.41+0.25)
    4220.14: extended log -i --grep='(e.t[^ ]*|v.ry) rare'   8.80(8.44+0.28)
    4220.15: perl log -i --grep='(e.t[^ ]*|v.ry) rare'       7.85(7.56+0.26)
    4220.17: basic log -i --grep='m\(ú\|u\)lt.b\(æ\|y\)te'   6.94(6.68+0.24)
    4220.18: extended log -i --grep='m(ú|u)lt.b(æ|y)te'      7.04(6.76+0.24)
    4220.19: perl log -i --grep='m(ú|u)lt.b(æ|y)te'          6.26(5.92+0.29)

See commit ("perf: add a comparison test of grep regex engines",
2017-04-19) for details on the machine the above test run was executed
on.

Before commit ("log: make --regexp-ignore-case work with
--perl-regexp", 2017-05-20) this test will almost definitely
fail (depending on the repo) if passed the -i option, since it wasn't
properly supported under PCRE.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p4220-log-grep-engines.sh | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 t/perf/p4220-log-grep-engines.sh

diff --git a/t/perf/p4220-log-grep-engines.sh b/t/perf/p4220-log-grep-engines.sh
new file mode 100755
index 0000000000..02793ac77b
--- /dev/null
+++ b/t/perf/p4220-log-grep-engines.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description="Comparison of git-log's --grep regex engines
+
+Set GIT_PERF_4220_LOG_OPTS in the environment to pass options to
+git-grep. Make sure to include a leading space,
+e.g. GIT_PERF_4220_LOG_OPTS=' -i'. Some options to try:
+
+	-i
+	--invert-grep
+	-i --invert-grep
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
+			pattern=$(echo $pattern | sed 's/\\//g')
+		fi
+		test_perf "$engine log$GIT_PERF_4220_LOG_OPTS --grep='$pattern'" "
+			git -c grep.patternType=$engine log --pretty=format:%h$GIT_PERF_4220_LOG_OPTS --grep='$pattern' >'out.$engine' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for$GIT_PERF_4220_LOG_OPTS '$pattern'" "
+		test_cmp 'out.basic' 'out.extended' &&
+		test_cmp 'out.basic' 'out.perl'
+	"
+done
+
+test_done
-- 
2.13.0.303.g4ebf302169

