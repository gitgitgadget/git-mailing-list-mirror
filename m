Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42AB9207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032435AbdDTVZT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:25:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33478 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031507AbdDTVZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:25:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so988513wmb.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpOjmOJFPUuxprfaQeGQxhk4FN0FkR6FQEBd7fmJaNI=;
        b=EusED4/xnVRJOutlctCFLYx4fEwmOS2yJG8I4grMKDGTZ/NJiLvi3KLoFyFh6r/8L6
         9KoPYt5Ke0njlmVCyjY+uhZ33nU1mYyKI0Cl+00/RCsvdiFdqBDxOwLqHTuvi0O1twd/
         Ir4u15xMhqG4j2rClGClKT/7iAryym/6WOGOTUqGUvL/y49rLEIvOLRVlCzhVTemQrh+
         /Yw0LdDlXF8K8uW4TKm4J4dPTg0w39/VvKO1bweS6LHDDoWqN5ERb4GAmH/CU2qAWWof
         IxeZbdEO8h/Ry95OP2HPbIe2KBuvlL1ddBqs5/cj21oKt5I03rK/GKci7mGFjbhnwY1h
         chlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpOjmOJFPUuxprfaQeGQxhk4FN0FkR6FQEBd7fmJaNI=;
        b=o2vYk7+KTpXx53YV4pRGw9sVIaUiDNdd2jC+mkWfUhhfon7uj+xf0bSdsdIzf5e6k0
         QuFs82vwdNYQHWnrlK3Ba4TLY0sKip57Z+bLMb+xM5yMEfoTgCIdk1BsbtbgrqTEaO3G
         hT4E9B6U8C4M+v6H0qYsxRM8jRKIsKPs7+eTbwHzFSVN9fvgsRlkg0GkMe6kFeDcY5X0
         5H8xg999bVH/7nMpYcBNeKooWdzz3YpyJwQxeqJ3mUDz2af2GcDsp8fiDcw251Kp/c4u
         sBtvb52WsqM8NP2lg6zhQBOmBNCGC5czJebUGD0QnxCLOQSjEa//XVZlb7sf6ph+iiaU
         qjkA==
X-Gm-Message-State: AN3rC/7oK+vyf7e932YjegJH+T9LrjAfC+vKAO3OvZgJBRPycM6HBELm
        yxqMnstdSVEElg==
X-Received: by 10.28.129.65 with SMTP id c62mr4940960wmd.79.1492723500000;
        Thu, 20 Apr 2017 14:25:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:58 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/18] perf: add a performance comparison test of grep -E and -P
Date:   Thu, 20 Apr 2017 21:23:41 +0000
Message-Id: <20170420212345.7408-15-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a very basic performance comparison test comparing the POSIX
extended & pcre1 engines.

I'm skipping the "basic" POSIX engine because supporting its alternate
regex syntax is hard, although it would be interesting to test it, at
least under glibc it seems to be an entirely different engine, since
it can have very different performance even for patterns that mean the
same thing under extended and non-extended POSIX regular expression
syntax.

Running this on an i7 3.4GHz Linux 3.16.0-4 Debian testing against a
checkout of linux.git & latest upstream PCRE, both PCRE and git
compiled with -O3:

    $ GIT_PERF_LARGE_REPO=~/g/linux ./run p7820-grep-engines.sh
    [...]
    Test                                                       this tree
    -----------------------------------------------------------------------------
    7820.1: extended with how.to                               0.28(1.23+0.44)
    7820.2: extended with ^how to                              0.26(1.15+0.38)
    7820.3: extended with \w+our\w*                            6.06(38.44+0.35)
    7820.4: extended with -?-?-?-?-?-?-?-?-?-?-?-----------$   0.37(1.57+0.38)
    7820.5: pcre1 with how.to                                  0.26(1.15+0.37)
    7820.6: pcre1 with ^how to                                 0.46(2.66+0.31)
    7820.7: pcre1 with \w+our\w*                               16.42(99.42+0.48)
    7820.8: pcre1 with -?-?-?-?-?-?-?-?-?-?-?-----------$      81.52(275.37+0.41)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p7820-grep-engines.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 t/perf/p7820-grep-engines.sh

diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
new file mode 100755
index 0000000000..5ae42ceccc
--- /dev/null
+++ b/t/perf/p7820-grep-engines.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description="Comparison of git-grep's regex engines"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+for engine in extended pcre1
+do
+	# Patterns stolen from http://sljit.sourceforge.net/pcre.html
+	for pattern in \
+		'how.to' \
+		'^how to' \
+		'\w+our\w*' \
+		'-?-?-?-?-?-?-?-?-?-?-?-----------$'
+	do
+		test_perf "$engine with $pattern" "
+			git -c grep.patternType=$engine grep -- '$pattern' || :
+		"
+	done
+done
+
+test_done
-- 
2.11.0

