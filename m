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
	by dcvr.yhbt.net (Postfix) with ESMTP id 68225201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbdETVnW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35050 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756402AbdETVnG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so4766930wmc.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWbSoTStn2eC5cR4ubzfvIYBJPbaBLJpj7tytsE53xU=;
        b=BqG+tI3ANcnznLT2TlRPgbquoVlub/pWnlmZYTWtjpajz3IG74JNBVUIHsVMS7uGAH
         XdDLEQ1Z2BPTEWBNBU1R6ibdqYHgyN3cxjFanZiXElgy6xJyKqjNZ1l/iNFqZUVcDpDq
         g1yYSv0PBP01lv6MkZPtkczl3SrwnhTBPfNUs0Jxlcm+RcSs5CaXrFZR9i7ruEumLEDD
         87TNkQjgahMUTd26t7h7fukwj5N9Rn+upzWYrAVWiujTHFjiQ4MOQ0QFXS0gq0sKO87K
         CgBLVp6KP47SujC8HxgjVNbXRPrz3GcQyP4h2nw4wVF74ZtejOIg2j6xSHeJImbMlCLn
         ukEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWbSoTStn2eC5cR4ubzfvIYBJPbaBLJpj7tytsE53xU=;
        b=I01fYHU2ge9bn4CxgKxhCSMWV02fd35707TC0GPgRpA5GCtMKeq7UGJ2dSjXV7+dOa
         qwSDZ+ReVDbMb/hrtVCk8soqp6hQ74cwYbvGUPnw9EFBfW0tU72/waRLG7HiSUyIBkIK
         7uSPLZ8+nTV2tmmeNgizaEpX4jGFOT7Mij1nwjSjHZk/tyVdlmHXHPGX5dQWD2g2VhZN
         z/nrxxOx3flp/JgNX1sgR96jPSYEpr9nPquLES7IBoWkF3chnbjHutVsKpatH5vOoRFa
         1u9FLTazYdiGPt8AwjqKpV4gt3fH2qexrE1H+ZDAzuuWnLxd+Zwh3dHo+ngdfSwC1XoU
         CFVA==
X-Gm-Message-State: AODbwcBttDpKUCTfCvkqvNLzrx/xzjxKvVhRz9PzOJ1BgqOQdulmsHXt
        MoEz6+nAmwde2g==
X-Received: by 10.28.20.198 with SMTP id 189mr2237996wmu.17.1495316584745;
        Sat, 20 May 2017 14:43:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:03 -0700 (PDT)
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
Subject: [PATCH v3 09/30] grep: add tests for --threads=N and grep.threads
Date:   Sat, 20 May 2017 21:42:12 +0000
Message-Id: <20170520214233.7183-10-avarab@gmail.com>
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

Add tests for --threads=N being supplied on the command-line, or when
grep.threads=N being supplied in the configuration.

When the threading support was made run-time configurable in commit
89f09dd34e ("grep: add --threads=<num> option and grep.threads
configuration", 2015-12-15) no tests were added for it.

In developing a change to the grep code I was able to make
'--threads=1 <pat>` segfault, while the test suite still passed. This
change fixes that blind spot in the tests.

In addition to asserting that asking for N threads shouldn't segfault,
test that the grep output given any N is the same.

The choice to test only 1..10 as opposed to 1..8 or 1..16 or whatever
is arbitrary. Testing 1..1024 works locally for me (but gets
noticeably slower as more threads are spawned). Given the structure of
the code there's no reason to test an arbitrary number of threads,
only 0, 1 and >=2 are special modes of operation.

A later patch introduces a PTHREADS test prerequisite which is true
under NO_PTHREADS=UnfortunatelyYes, but even under NO_PTHREADS it's
fine to test --threads=N, we'll just ignore it and not use
threading. So these tests also make sense under that mode to assert
that --threads=N without pthreads still returns expected results.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index daa906b9b0..561709ef6a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -775,6 +775,22 @@ test_expect_success 'grep -W with userdiff' '
 	test_cmp expected actual
 '
 
+for threads in $(test_seq 0 10)
+do
+	test_expect_success "grep --threads=$threads & -c grep.threads=$threads" "
+		git grep --threads=$threads . >actual.$threads &&
+		if test $threads -ge 1
+		then
+			test_cmp actual.\$(($threads - 1)) actual.$threads
+		fi &&
+		git -c grep.threads=$threads grep . >actual.$threads &&
+		if test $threads -ge 1
+		then
+			test_cmp actual.\$(($threads - 1)) actual.$threads
+		fi
+	"
+done
+
 test_expect_success 'grep from a subdirectory to search wider area (1)' '
 	mkdir -p s &&
 	(
-- 
2.13.0.303.g4ebf302169

