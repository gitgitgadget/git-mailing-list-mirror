Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEEF51F406
	for <e@80x24.org>; Thu, 28 Dec 2017 23:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbdL1X2v (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 18:28:51 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44335 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbdL1X2o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 18:28:44 -0500
Received: by mail-wr0-f195.google.com with SMTP id l41so28224781wre.11
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=k3mGVjuNNm38/hygYfSuvNHrweKA0ax9vZiSlEpKOrIc/Y6nLqG33bWtwszcBBA6Sd
         wgvc1e31x3ZLVNxtJJi6IkT30Gjeh8LsxntaNJPjpc709dNoDG/XHH2P2BvifyyLGh1r
         yLMvxhwyNqp4hX9JkDdpd47DEukJJ2WDIkVWF9B2ieD/s4p/KcDp2/FS1yJpIR+zgWi5
         doKmMDJZIeI8dPIGOAh4JmxUlpBJhgNMmzXL8ne+EMYyVGD15mpNaTsLH0gorXaLSSFU
         7HKoF6Se/O6cP9+fQLaD1Oa0OM0kpms2ckaV0MrUQ1UMcQ6MpErHxZfjKqOkfoMRhh6D
         3f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=j2usCupOjESR6+xLXhGpqBC8fIiw5MeJIffqhtld+XCrHmndZcld12SziGXR4x2A5g
         fUllrYwwYxZQpg9iLWf6q8b0BL5naE+FtPmcaXbSQxtDjLLKsssybQvcogXp0ZbaVrmb
         BlThDZERKfuNWdX+K6ITXJKBuY78sd4DMrfHrLDfjHujnMuuFiBI3srdnV8S3NG5RNDm
         iYsTuKwSqlbahkKhCZOGiyZHYxhDxlULpxFyHWW9izZ6xiO/twn5vnI+OaqMcXiPy87T
         krP+Y9ReAp3nyjIufJ5MFVQnTE1wMia39AK6/aivi5gEF4StMaLNZPdXI2BZOkBZCiyg
         AXLw==
X-Gm-Message-State: AKGB3mInC7fhRpAjXGKupORSdiBpWFFDNs9QoXQseND0AI8Yr6Wld/J+
        9fcWXP9dtzkSST10Et9y0tHlPCDj
X-Google-Smtp-Source: ACJfBouIhYBEE4GQinBsW/PPYs4PWLpCYgM81NCv0SBseUwG9ObbIAplHfodsYZjRfDrE8xbIta7fQ==
X-Received: by 10.223.157.135 with SMTP id p7mr24614280wre.204.1514503722588;
        Thu, 28 Dec 2017 15:28:42 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c53sm23187346wrg.10.2017.12.28.15.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 15:28:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/7] wildmatch test: use a paranoia pattern from nul_match()
Date:   Thu, 28 Dec 2017 23:28:20 +0000
Message-Id: <20171228232823.14450-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171228232823.14450-1-avarab@gmail.com>
References: <20171228232823.14450-1-avarab@gmail.com>
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
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

