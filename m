Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9C9207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954740AbdDYVGx (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35493 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954728AbdDYVGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id d79so28447776wmi.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpOjmOJFPUuxprfaQeGQxhk4FN0FkR6FQEBd7fmJaNI=;
        b=QbRFGLTi532vdBihpZS5FVR40Ksjh3yRoDJqP3xqQaPLgIyAf7TpgrIh3rBW6kYjTo
         VhgEAPrSh30n0i1w5mCZXWXKm5pYRApCXv/5jqCjYBqzq8IzX/ZTs5fYGvGauzV69L42
         DNbIleAaCj5TdfCsALLZYbc5GbhF8gw/D04KfageJAFV57UMVfDcdtUPDZp9tUK0ttRo
         iS6SbRc2UFUdpLDJK2pkglgs+KD1FLlyzK08dDRr7w+HMj4GJ4mbAmXmvbc9I/Mb3wmk
         XRMbOwjdEB44CDB//lrgxsLC+6xyJtT9489fPxi9yMVuHO0iH8+e3gKITrLV8HViHmL/
         B26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpOjmOJFPUuxprfaQeGQxhk4FN0FkR6FQEBd7fmJaNI=;
        b=LROa/fxakzygCtL1ASbIlQGrz/FhjASAsb5R4EXNG8aCciUX0JO34PkIJkwNbUcp4i
         N/Esp/P7tRpIr2e82rv5iTc6D5/JqvaRk7k5mpgygAEiHcLNm5thBDHzP9Ar1BF52bDV
         dR33dUuKlCzQCCIjLYaTHcrXD3qV2XXotCE50Hg7bb5IiYzmutaAzkBqT41GNmLjhF53
         kFQsRc8LdEdJT/bXEs+6RS6a7jWpVrx1BuXHM77Y2wBrlNqP+KiCQu/tIhDdKMfPbSFS
         LsIX6uwFOy2+ClHdqcM8OgL4XYT97lycwXPhsMvSxGq2KI3z74NwzIAYXUwSS1GJrDXv
         bYXw==
X-Gm-Message-State: AN3rC/5cj3W4BEXFvBoumOEE4bXDdnxgQcud2S/r+AdOSCXhx617oc+F
        Dhv6t1GHT23cu2l2m+s=
X-Received: by 10.28.55.3 with SMTP id e3mr3519485wma.15.1493154405513;
        Tue, 25 Apr 2017 14:06:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:44 -0700 (PDT)
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
Subject: [PATCH v4 15/19] perf: add a performance comparison test of grep -E and -P
Date:   Tue, 25 Apr 2017 21:05:44 +0000
Message-Id: <20170425210548.24612-16-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
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

