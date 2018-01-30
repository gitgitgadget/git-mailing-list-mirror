Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56981F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeA3VV7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:21:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40314 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeA3VV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:21:58 -0500
Received: by mail-wm0-f65.google.com with SMTP id v123so3928560wmd.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=iCa8tbSwFnYWTlAZkBr77eFPOJGT04iqziFwRLqFYg7Py1APXyY/4FxnrAr69Sc/33
         O63wDEc+dqMMBPHMsjBA89gOwkOeJBr+vGavnfnQ0NWD4Aa9CBH4hySLp46x6Rdfu/Yq
         4riyhBFi2Hdx7BO/q/8cm0bcQokX+oFgOc8vK0WSZAEz1Z8AmpazwT0QZCW/4CI2piSm
         MtFCP1zPO2WdXprSc3Tn046RQ3zN+qrXJsEJlr3lwk1k1iiJbEbUz96jmJCphwT5H5X9
         pTZ7PTa0qbEudiLWO6MfoITOBlDKiJ3I2KoWVcVPg2L3PDeVOwm0SvSMDW3mWkqesMQr
         Adgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=fQMqZWe/dQiXMVC2M5Rnvn7Bhrzg+kNV4k5j+TZOydPqeHrOODBXsx3juGmzLxrbau
         7b9z2qsg/KckBUttn5OCFzNea98Crln0eUEPIEqtJ1mU9DDuZqCK/PhzetenDqDU9Ewz
         HggUDiVm0221xZ5bSXnUPTTaNDXPibkOH0shv9dOJkUh2vLnL3106ed0Oj5ABy3vwL+1
         dEV3QTtYaNsm0rU3zd2/UAuzQAjn1pWh/JGU8x2nMUgXH4wfcBRW+px0+K42XCbGelb8
         CWw7j1n1srJOI1cjfItcBAMetQkb4kHewYo+SgcaZroO7ixKDJDT4mNfzh93a9UdEiwg
         80dg==
X-Gm-Message-State: AKwxytedGuROT50M1I3FWwkRt6vY2DRaxG/eEjI3vxNYyaAz7X6EC0IY
        ZRqfGN5yf7j0xYsvYxN83seULNMp
X-Google-Smtp-Source: AH8x225c8L8SBXmLGvr3GbnmBDgEAg2fGxqOmcCMdaM2RPjXw/MP3v0aPxCFOv9AchEU+JO+tHEbCg==
X-Received: by 10.80.169.61 with SMTP id l58mr53804374edc.257.1517347317159;
        Tue, 30 Jan 2018 13:21:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:21:56 -0800 (PST)
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
Subject: [PATCH v5 04/10] wildmatch test: use a paranoia pattern from nul_match()
Date:   Tue, 30 Jan 2018 21:21:18 +0000
Message-Id: <20180130212124.2099-5-avarab@gmail.com>
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

Use a pattern from the nul_match() function in t7008-grep-binary.sh to
make sure that we don't just fall through to the "else" if there's an
unknown parameter.

This is something I added in commit 77f6f4406f ("grep: add a test
helper function for less verbose -f \0 tests", 2017-05-20) to grep
tests, which were modeled on these wildmatch tests, and I'm now
porting back to the original wildmatch tests.

I am not using the "say '...'; exit 1" pattern from t0000-basic.sh
because if I fail I want to run the rest of the tests (unless under
-i), and doing this makes sure we do that and don't exit right away
without fully reporting our errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 19ea64bba9..9691d8eda3 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -10,10 +10,13 @@ match() {
 		test_expect_success "wildmatch: match '$3' '$4'" "
 			test-wildmatch wildmatch '$3' '$4'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "wildmatch: no match '$3' '$4'" "
 			! test-wildmatch wildmatch '$3' '$4'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
@@ -23,10 +26,13 @@ imatch() {
 		test_expect_success "iwildmatch: match '$2' '$3'" "
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
 		test_expect_success "pathmatch: match '$2' '$3'" "
 			test-wildmatch pathmatch '$2' '$3'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "pathmatch: no match '$2' '$3'" "
 			! test-wildmatch pathmatch '$2' '$3'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
-- 
2.15.1.424.g9478a66081

