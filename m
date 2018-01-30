Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA09A1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeA3VWG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:22:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40333 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeA3VWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:22:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id v123so3928979wmd.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8pL8lTvGVhHgiuqfr90dhYAtBbUnyv90saXYvWnlWS4=;
        b=IGnRD6TflLy2xJ/z3jlSb1lxwNBnDek6XBxePhEdJzudJzaENfLXXNQiRSlhbGfmIT
         LmF/RGkAkc0pMrMlVxz5j8edW9NcCGvhzzVoOo5YY3PF89zmGrwyNeKsd5UEtbFC7L26
         bdPznBDlo+Sy2GVSDM1tQOmDmSDTvo5vaBT4fWdYyR+PJSViFORKW6awTbrY6MUpWq/w
         XT+1JzAIc4Mg/OZFJOY3TENoJ97xesZNEZL7yHWSZEb8XDfmj/+Lx3VXE9yzVTm+KMCQ
         vpjyfXUA1+fh+Snfr9xN5k8ch0TbWvl3Epfiq0qlrn20mDtzoA9GnnYneexDUTyf549m
         3kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8pL8lTvGVhHgiuqfr90dhYAtBbUnyv90saXYvWnlWS4=;
        b=TQW/BsbEXB2gY7kNX4d54Q7oqe7Ifuyw9tU4Cjsik5dscPtt0ywBHK97Zh6H9c4m3q
         +9QWgrpbVfI5d5OeQO8Ia9bV1L9x5Nr6VAUhTRVzstyQNt+76IsPb7Sqeoy5sDTfJ9tY
         H+ViP7JNTU4tZtyvQ9HhvdF93X6SJtDj936uus3WOvmrpa3q7Qu51v9ye/XVP3GbOM4F
         oEIXChwTuimAH0qyyes/HdIKGbiuCUk1zEYnB19XLjWirN6bC5uq62p+p8dnb0KMptJg
         J8eyN0iM5K6PZepWEF8s4yAtekmtb0QHcG+bJG0YbjurLQosvrKoJU5BNP99fxGF6/tN
         0Dug==
X-Gm-Message-State: AKwxytdREU2C6LuUm6yzxarAH+St/Rjqf0hjoWVnT6GIjAyDtlfmbIWs
        KBUoa659Wl/SutFky3skFUjoCK1z
X-Google-Smtp-Source: AH8x226VrXZlarLpzKwkVfHv/XsPRmAFy6aWGhy/8IW3MyYEP5OJCpUAb/VURWN02xEbmVTRHUFfAQ==
X-Received: by 10.80.165.97 with SMTP id z30mr54131650edb.66.1517347322104;
        Tue, 30 Jan 2018 13:22:02 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:22:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Kyle J . McKay" <mackyle@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/10] wildmatch test: use test_must_fail, not ! for test-wildmatch
Date:   Tue, 30 Jan 2018 21:21:20 +0000
Message-Id: <20180130212124.2099-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180130212124.2099-1-avarab@gmail.com>
References: <20180130212124.2099-1-avarab@gmail.com>
In-Reply-To: <20180104192657.28019-1-avarab@gmail.com>
References: <20180104192657.28019-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use of ! should be reserved for non-git programs that are assumed not
to fail, see README. With this change only
t/t0110-urlmatch-normalization.sh is still using this anti-pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 2f8a681c72..fe0e5103a3 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -13,7 +13,7 @@ match() {
 	elif test "$1" = 0
 	then
 		test_expect_success "wildmatch: no match '$2' '$3'" "
-			! test-wildmatch wildmatch '$2' '$3'
+			test_must_fail test-wildmatch wildmatch '$2' '$3'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
@@ -29,7 +29,7 @@ imatch() {
 	elif test "$1" = 0
 	then
 		test_expect_success "iwildmatch: no match '$2' '$3'" "
-			! test-wildmatch iwildmatch '$2' '$3'
+			test_must_fail test-wildmatch iwildmatch '$2' '$3'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
@@ -45,7 +45,7 @@ pathmatch() {
 	elif test "$1" = 0
 	then
 		test_expect_success "pathmatch: no match '$2' '$3'" "
-			! test-wildmatch pathmatch '$2' '$3'
+			test_must_fail test-wildmatch pathmatch '$2' '$3'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
-- 
2.15.1.424.g9478a66081

