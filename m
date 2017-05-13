Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6EF20188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbdEMXQ4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:56 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36806 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758804AbdEMXQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so12509334qka.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEtF9/6/PTWtzo7Wyxi/nurfVSWczGik/x3F9ANtyMY=;
        b=nJEiqZacyWpQYT3pIpfmG2PG8NGL90026Um1T0BRVwSXN6IaHUt8w+VuSzWAIEMH0N
         dxbyhMrvIw4kWIZDDPp7gQKZQ+Q6OxGtuB1tbr4XSQ+SHPBTt5NbuMLwszP50uSKGmPf
         nM5iphVkhO8VKIEzRxskraihA4PZj1uNe9qKuFbH1q0uxdz9rZFYL5pzVJQqWwl5h4zS
         S1sFX3lgtIbCxrWSMohSX/dZS5cK1F5plQlG6WsqcuXzRbIwPb4iBegcUP8p6gq2gvkL
         pGYu6VFBbru9YLvAm9ddaw3LnQLRVuZbZQBmfoW9nLjoeQrTNpPmuctgaqLh/PYN2Va2
         cCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEtF9/6/PTWtzo7Wyxi/nurfVSWczGik/x3F9ANtyMY=;
        b=X7QoQHuKqJUgK4Rl4OAQPsrpx6I6s9gNuMr276Gh4pGSl/dI9KLaOD0M4+Rm5Yj5Mp
         PmPi85J5DbBZ5TJjs3f+YZmEcuiAlNRhfs72vDc3FcyUmpG0m5Oo8Uttp8zlLFKgrk2w
         0dUOoYw7hSyCM2ZCMrhPzV7xNCuwfOFcaf2ut6dSA+XwiclXRC/obJfpgRB09ZavXZJp
         bsqfLyqstLfKpdea4N5IdgWTND6QlQhoqEYw0S2OnvSbAixXqhBTJKFxgzPuGRrVbvaw
         43wcfdVTq3eN3u5vzwFFIEn2O74IgmqvAnOOgDYGK/pDp9xREz2iffP7CRT0XO48hcaw
         JsVg==
X-Gm-Message-State: AODbwcD7BaYj8XBfuML7Altc2IqT5pPF8Eoab8QpC+z/KnU+wJfH63lN
        EawjtepkIkH2tQ==
X-Received: by 10.55.221.8 with SMTP id n8mr9557786qki.103.1494717403495;
        Sat, 13 May 2017 16:16:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:42 -0700 (PDT)
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
Subject: [PATCH v2 17/29] perf: add a performance comparison of fixed-string grep
Date:   Sat, 13 May 2017 23:14:57 +0000
Message-Id: <20170513231509.7834-18-avarab@gmail.com>
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

Add a performance comparison test which compares both case-sensitive &
case-insensitive fixed-string grep, as well as non-ASCII
case-sensitive & case-insensitive grep.

Currently only the "-i æ" performance test doesn't go through the same
kwset.[ch] codepath, see the "Even when -F..." comment in grep.c.

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux ./run p7821-grep-engines-fixed.sh
    ----------------------------------------------
    7821.1: fixed grep int         1.75(1.39+0.34)
    7821.2: basic grep int         1.68(1.38+0.28)
    7821.3: extended grep int      1.75(1.41+0.29)
    7821.4: perl grep int          1.73(1.40+0.30)
    7821.6: fixed grep -i int      1.94(1.54+0.35)
    7821.7: basic grep -i int      1.92(1.57+0.32)
    7821.8: extended grep -i int   1.90(1.54+0.30)
    7821.9: perl grep -i int       1.91(1.53+0.36)
    7821.11: fixed grep æ          1.35(1.14+0.18)
    7821.12: basic grep æ          1.34(1.16+0.16)
    7821.13: extended grep æ       1.33(1.15+0.17)
    7821.14: perl grep æ           1.35(1.12+0.20)
    7821.16: fixed grep -i æ       0.72(0.49+0.22)
    7821.17: basic grep -i æ       0.74(0.49+0.21)
    7821.18: extended grep -i æ    0.72(0.48+0.22)
    7821.19: perl grep -i æ        0.71(0.44+0.23)

I'm planning to make that not be the case, this performance test gives
a baseline for comparing performance before & after any such change.

See commit ("perf: add a performance comparison test of grep -G, -E
and -P", 2017-04-19) for details on the machine the above test run was
executed on.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p7821-grep-engines-fixed.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 t/perf/p7821-grep-engines-fixed.sh

diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
new file mode 100755
index 0000000000..d771cccfdf
--- /dev/null
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description="Comparison of fixed string grep under git-grep's regex engines"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+for args in 'int' '-i int' 'æ' '-i æ'
+do
+	for engine in fixed basic extended perl
+	do
+		test_perf "$engine grep $args" "
+			git -c grep.patternType=$engine grep $args >'out.$engine.$args' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for $args" "
+		test_cmp 'out.fixed.$args' 'out.basic.$args' &&
+		test_cmp 'out.fixed.$args' 'out.extended.$args' &&
+		test_cmp 'out.fixed.$args' 'out.perl.$args'
+	"
+done
+
+test_done
-- 
2.11.0

