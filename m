Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF95E1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 21:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757224AbdLWVaf (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 16:30:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35374 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757173AbdLWVab (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 16:30:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id f9so27307346wmh.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 13:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58GrAWAVbzeyEtulikLAT4Qk3GJmfgWbBjgURIVLFbg=;
        b=XVNjp8q+yMXiNakvzSdLsPtmOLamWXjllWaE4d76JhOtoyBVgEvflBV8eSo1gXrn1t
         dFhBAFdaXmSyDV0TSJVRk1Lca3noGCneRde4bFiaoxLE5XMLqSuj11gj+JAznoekIc9S
         mPpmTnVrYnL0wAVq2/y/weL+GvplU1JT7JRmDcuDaSR05EDG3WHj07xCeVJ7c5JINDVN
         ETij/IZ42H3J0+TBT5vPI2j5OpKYlIk/lVThtPZLZbj00CfyaRBpB+2CRvGFj9d81O2k
         bWn4SObv00vEV+ZqgtiBz+LvPNHIl1DRKHCN9Z4ZEEV6YYGILev5ktHUW9FvD1+bd1FH
         ivCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58GrAWAVbzeyEtulikLAT4Qk3GJmfgWbBjgURIVLFbg=;
        b=Nl2CqbY0hYh51K8/pXpr/ZiI1ZWj3Aov7SyMovUgOcvhKA2MpiDLH24/jP8gtonKRs
         HJHP/WN2FftMjhu9z57jy/Z6/3wFuls9E/DED6xQRufU5eu2PJOBcpdM4CLL5FCUrdVK
         wiFsycKocZ4PjBAWdOHBPbNT2g5dkzY+hR+amsmhdWgUzw2gGzKIzAzEfqZIku/lmv1T
         2IoZwuvM7kNeordGdgGtqO3yKUwU0bkgDESOK4vjn51qyzY7MfBMDoZsMgZjTqxuBUth
         tb//cfUE4H8HmXRcdiq5yyNBxIFp4rXbR+53VCzqY836bjs+jsOwSxckfyWKyAzXUd89
         jEkg==
X-Gm-Message-State: AKGB3mLGco2mH3haoLaDwm46VhrWNDeAaRwzFOWrMLT96QrIFYa2KZw3
        FuSbNweiqooxBMg2dhUADKQOfBrR
X-Google-Smtp-Source: ACJfBov0/YAmL5q5pPOylejC1r3+MQnGJ2+DXQSnfqmgy67WU7BZ+S1oVxLMNPKzWJ38scuLvlT6zg==
X-Received: by 10.28.5.198 with SMTP id 189mr15478602wmf.29.1514064629958;
        Sat, 23 Dec 2017 13:30:29 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c2sm29074950wrc.81.2017.12.23.13.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 13:30:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] wildmatch test: use a paranoia pattern from nul_match()
Date:   Sat, 23 Dec 2017 21:30:09 +0000
Message-Id: <20171223213012.1962-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a pattern from the nul_match() function in t7008-grep-binary.sh to
make sure that we don't just fall through to the "else" if there's an
unknown parameter.

This is something I added in commit 77f6f4406f ("grep: add a test
helper function for less verbose -f \0 tests", 2017-05-20) to grep
tests, which were modeled on these wildmatch tests, and I'm now
porting back to the original wildmatch tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4d589d1f9a..71d6ea0f56 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -10,10 +10,13 @@ match() {
 		test_expect_success "wildmatch:     match '$3' '$4'" "
 			test-wildmatch wildmatch '$3' '$4'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "wildmatch:  no match '$3' '$4'" "
 			! test-wildmatch wildmatch '$3' '$4'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
@@ -23,10 +26,13 @@ imatch() {
 		test_expect_success "iwildmatch:    match '$2' '$3'" "
 			test-wildmatch iwildmatch '$2' '$3'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "iwildmatch: no match '$2' '$3'" "
 			! test-wildmatch iwildmatch '$2' '$3'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
@@ -36,10 +42,13 @@ pathmatch() {
 		test_expect_success "pathmatch:     match '$2' '$3'" "
 			test-wildmatch pathmatch '$2' '$3'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "pathmatch:  no match '$2' '$3'" "
 			! test-wildmatch pathmatch '$2' '$3'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
-- 
2.15.1.424.g9478a66081

