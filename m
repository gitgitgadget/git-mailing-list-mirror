Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB18220284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036727AbdEYTrF (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33146 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036720AbdEYTrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id b84so39674084wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1n9l5496A+tym9lfX8oDfh7rIS2TR74jb1dm3k09AA=;
        b=DXGG5UbkDS7UdE60FYOECAfmwXXJCtrwJpkngtFsyQd3YFey6pucCv0VoXKLLyXvMZ
         t9MTPQFOiBPi+f3lSAUzH6F5Qrg8u9qlCgWtbao9P0cN+0u6oDX/JlArEICJ0Wc7f5Ir
         UihBZrq/1OfrHKtOEeqcLSEUA808GWZMayFOf1Afs/EE0E7O1ouCY1eCKf/YQvAJaKn4
         L3fBfFtAviQfaN7kD+VBzM/AYvvgedFvxi14cgTix1oHDTXcCmauuILgTmc8syEpvR7v
         WEPBNC5V4CXPsyNhahpijKr5V6g0TU+OF+Io4FmqWyWRJRMZnctjwPmNtfRnKlB0FXK/
         eucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1n9l5496A+tym9lfX8oDfh7rIS2TR74jb1dm3k09AA=;
        b=Wr43TULdt6vsJgkhqYZdkVXN4mW2dkCVBVi9cPfsmOCCM7PWXbBWvQXHYI/gLBbMXl
         Ef6GO/A1DtsuueOyxFJ6LX7MQPvMOGR6Ndg7pY280KzSBIPze5UmePvcCYtsXdAR7q6O
         GXMgkwC7Sry8u62ikoJ/nrhxFluliSogWgFzYsXs7ib6wgqTbNfwHVbfNumsGue4CU6e
         Acx57Fk2HENJuvkx/G0FHbhz3CGbg1Uit0Zo6AhjovoENzi1NLvm/NkmhPJKafkKlFd6
         xzNpUaxDfEloKhYFERN3jcy+0hgG6Ei08ziJQeyppQmfTCc/6BT09Cwe2zYgNwufO4WP
         31Nw==
X-Gm-Message-State: AODbwcAa2Uk0Vks0yTEa5oYF4qSQooJgO7qz779zVwS0RU7vICaGzTQ7
        i8x2+UeXaOCrspIRWUk=
X-Received: by 10.223.128.80 with SMTP id 74mr30115467wrk.30.1495741618382;
        Thu, 25 May 2017 12:46:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:57 -0700 (PDT)
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
Subject: [PATCH v4 18/31] perf: add a comparison test of grep regex engines with -F
Date:   Thu, 25 May 2017 19:45:22 +0000
Message-Id: <20170525194535.9324-19-avarab@gmail.com>
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

Add a performance comparison test of grep regex engines given fixed
strings.

The current logic in compile_regexp() ignores the engine parameter and
uses kwset() to search for these, so this test shows no difference
between engines right now:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux ./run p7821-grep-engines-fixed.sh
    [...]
    Test                             this tree
    ------------------------------------------------
    7821.1: fixed grep int           0.56(1.67+0.68)
    7821.2: basic grep int           0.57(1.70+0.57)
    7821.3: extended grep int        0.59(1.76+0.51)
    7821.4: perl grep int            1.08(1.71+0.55)
    7821.6: fixed grep uncommon      0.23(0.55+0.50)
    7821.7: basic grep uncommon      0.24(0.55+0.50)
    7821.8: extended grep uncommon   0.26(0.55+0.52)
    7821.9: perl grep uncommon       0.24(0.58+0.47)
    7821.11: fixed grep æ            0.36(1.30+0.42)
    7821.12: basic grep æ            0.36(1.32+0.40)
    7821.13: extended grep æ         0.38(1.30+0.42)
    7821.14: perl grep æ             0.35(1.24+0.48)

Only when run with -i via GIT_PERF_7821_GREP_OPTS=' -i' do we avoid
avoid going through the same kwset.[ch] codepath, see the "Even when
-F..."  comment in grep.c. This only kicks for the non-ASCII case:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_7821_GREP_OPTS=' -i' ./run p7821-grep-engines-fixed.sh
    [...]
    Test                                this tree
    ---------------------------------------------------
    7821.1: fixed grep -i int           0.62(2.10+0.57)
    7821.2: basic grep -i int           0.68(1.90+0.61)
    7821.3: extended grep -i int        0.78(1.94+0.57)
    7821.4: perl grep -i int            0.98(1.78+0.74)
    7821.6: fixed grep -i uncommon      0.24(0.44+0.64)
    7821.7: basic grep -i uncommon      0.25(0.56+0.54)
    7821.8: extended grep -i uncommon   0.27(0.62+0.45)
    7821.9: perl grep -i uncommon       0.24(0.59+0.49)
    7821.11: fixed grep -i æ            0.30(0.96+0.39)
    7821.12: basic grep -i æ            0.27(0.92+0.44)
    7821.13: extended grep -i æ         0.28(0.90+0.46)
    7821.14: perl grep -i æ             0.28(0.74+0.49)

I'm planning to change how fixed-string searching happens. This test
gives a baseline for comparing performance before & after any such
change.

See commit ("perf: add a comparison test of grep regex engines",
2017-04-19) for details on the machine the above test run was executed
on.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p7821-grep-engines-fixed.sh | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100755 t/perf/p7821-grep-engines-fixed.sh

diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
new file mode 100755
index 0000000000..c7ef1e198f
--- /dev/null
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description="Comparison of git-grep's regex engines with -F
+
+Set GIT_PERF_7821_GREP_OPTS in the environment to pass options to
+git-grep. Make sure to include a leading space,
+e.g. GIT_PERF_7821_GREP_OPTS=' -w'. See p7820-grep-engines.sh for more
+options to try.
+"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+for pattern in 'int' 'uncommon' 'æ'
+do
+	for engine in fixed basic extended perl
+	do
+		if test $engine = "perl" && ! test_have_prereq PCRE
+		then
+			prereq="PCRE"
+		else
+			prereq=""
+		fi
+		test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
+			git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for$GIT_PERF_7821_GREP_OPTS $pattern" '
+		test_cmp out.fixed out.basic &&
+		test_cmp out.fixed out.extended &&
+		if test_have_prereq PCRE
+		then
+			test_cmp out.fixed out.perl
+		fi
+	'
+done
+
+test_done
-- 
2.13.0.303.g4ebf302169

