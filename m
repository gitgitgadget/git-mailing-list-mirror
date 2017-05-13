Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C507320188
	for <e@80x24.org>; Sat, 13 May 2017 23:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758366AbdEMXPx (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:15:53 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36596 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758132AbdEMXPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:15:50 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so12507691qka.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V1ttOHka4AwWeCsOOGcC8WEKsMeXbjQulUxTk4D0hYo=;
        b=A7awPVm9l3Cbr0gLkPaNTSJTGssvxEdDDGHvNqkM2Nz1beUwtWaX2DT3b4o3D8jtkV
         D/srZx1fofSbG+ANDGNbdFa6ebvfV/OesOO/u1UuZcahkPBmSVznGEDQuqnf/F6YMs8E
         PXvnaTuGi/kwVxsNVikevL17DPYxwOSu/8+lKyqjDythbaZe2xRCEFNPOfOo0/2GLjyO
         nGvK8ZZ8S+rGDumBypWURGaZjNOlAQyyvycIIo0wMiiAo0j5F2rodHGbHutv7BLOUr1R
         jaWbhGqrz5KrjT0pYQ5Pl7hRHinN7psMRh3eOqnTKhc1aPhzMTY99LoFDEJ6dUbJHIsf
         bJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V1ttOHka4AwWeCsOOGcC8WEKsMeXbjQulUxTk4D0hYo=;
        b=nVTRPtnwaYmqUs/muFZh2BhmFyyHOtTYgcjgm4Xouj97iqZSphrTnE4IcXwJwfr/zM
         FB1I/SaQI2BgGH4X27DHzhY6XFiRUTBB6Hqvrh4eR7+O5xb3qN5TxSCnUE5unfzmBX3T
         Tn5jncu75Y6oq+UXrOOAGl/YMiR3RQWuNfQXTljC/rNaRxLcL3qrknRfXItPetuc6+xU
         nbRGeur3dgDVO+Jwkx1L/xRqzMVihgDHvR6mLFkQwJTd1opdN1ylfUnqLWYKjgY4hHYW
         x3hK0i3ncOgv7hcSnO8vCosMPKS1lwvWtYlfXBtmsOM+xetyHewjP3m6Xr1bfs6t/Qn9
         sMMw==
X-Gm-Message-State: AODbwcA2AsCQP5fWrZF4T5kUgvGBXDJt6bIfv+ay4TdvNobltrJrYgJO
        eYsKptbQdxGBhg==
X-Received: by 10.55.181.194 with SMTP id e185mr1251386qkf.195.1494717349829;
        Sat, 13 May 2017 16:15:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:15:49 -0700 (PDT)
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
Subject: [PATCH v2 05/29] grep: add a test asserting that --perl-regexp dies when !PCRE
Date:   Sat, 13 May 2017 23:14:45 +0000
Message-Id: <20170513231509.7834-6-avarab@gmail.com>
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

Add a test asserting that when --perl-regexp (and -P for grep) is
given to git-grep & git-log that we die with an error.

In developing the PCRE v2 series I introduced a regression where -P
would (through control-flow fall-through) become synonymous with basic
POSIX matching. I.e. 'git grep -P '[\d]' would match "d" instead of
digits.

The entire test suite would still pass with this serious regression,
since everything that tested for --perl-regexp would be guarded by the
PCRE prerequisite, fix that blind-spot by adding tests under !PCRE
asserting that git must die when given --perl-regexp or -P.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh  |  4 +++-
 t/t7810-grep.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e522a2fcd5..9680dfe400 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -364,7 +364,9 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			git log --pretty=tformat:%s --perl-regexp \
 				--grep="[\d]\|" >actual.perl.long-arg &&
 			test_cmp expect.perl actual.perl.long-arg
-
+		else
+			test_must_fail git log --perl-regexp \
+				--grep="[\d]\|"
 		fi &&
 		test_cmp expect.fixed actual.fixed.long-arg &&
 		test_cmp expect.basic actual.basic.long-arg &&
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index c84c4d99f9..8d69113695 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -281,6 +281,10 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success !PCRE "grep $L with grep.patterntype=perl errors without PCRE" '
+		test_must_fail git -c grep.patterntype=perl grep "foo.*bar"
+	'
+
 	test_expect_success "grep $L with grep.patternType=default and grep.extendedRegexp=true" '
 		echo "${HC}ab:abc" >expected &&
 		git \
@@ -1058,11 +1062,19 @@ test_expect_success PCRE 'grep --perl-regexp pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success !PCRE 'grep --perl-regexp pattern errors without PCRE' '
+	test_must_fail git grep --perl-regexp "foo.*bar"
+'
+
 test_expect_success PCRE 'grep -P pattern' '
 	git grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
+	test_must_fail git grep -P "foo.*bar"
+'
+
 test_expect_success 'grep pattern with grep.extendedRegexp=true' '
 	>empty &&
 	test_must_fail git -c grep.extendedregexp=true \
-- 
2.11.0

