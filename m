Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D088A1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbeADT1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:27:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37321 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeADT1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:27:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so5248073wmd.2
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=PssrmB4F9yaN+qHTiQ14oBdrhsQpd1ReTfB4YTg/anLrq05bOcQLk4cMzV564z/sWO
         w9INh8GJgACqG3m92sj3xC4/Tx9wJvfPMCNX6AFnK6fmH0suat226u6bFYi4FCsmo2An
         29UcjzoZDmRKbEi56AG/ealCRminHXC3m40PBAe46n6EhL9e1A0fbqp3k9P0OCTJ3FTY
         upPF+r0WA5I/V41MCnuFRinh66c6lj1v7NL2bYlpJmeh/Mq4+7+Ic4HcxZ03e9F8/PYg
         0EnrLsmLyVDoDnKNbxskUeXOWsGcSSwTPjl0MagOjR5TeySKZJLEXK24fM6/3S2y5dcj
         zo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=pQLCDcwV7X7SLkaORGd+Fs7XgVTh681IHbeb3yxpE66SOlDg9a6OFDaz1ekG5SpoPi
         +nYb5WiCll2/67A2S85gcctKoooKCR6bYqcAHI2GkS6b5p5Syfsh0XwlJ+gdRBAA2pi2
         6+Hl3T+11id9KHUNG/Kf79LqdEjTI+FUNXVrQciMPWbnuoVmzMPWYWvA11f4gqJw4wlk
         aEfNwTViPDldauaP0SK+QWQHszCsuB1LFGn8YqmrmFwA6aanJ5XOlgRNMCj6/u7wSoy9
         ZJdlmcpmG5/c+r2m1J2hsXhBc2PRssKdcucGzVub6Ps9RGcDZT0D66LPwSg55RpiwYqZ
         hiFg==
X-Gm-Message-State: AKGB3mJ/TFnB4nVbfTiIHrdt1OE8ar/rPhkGtxcjn1xXaKamV/nwvBMb
        mw8FCW5I75vey8e1pfbJM6f2JOPT
X-Google-Smtp-Source: ACJfBovmUipJjX5P4s+fYFfHyxRi8MjDvC4GCtynexrWzCRnllKBYbaBsMPDcXDk7Go9ZWgS/TwkAQ==
X-Received: by 10.28.156.11 with SMTP id f11mr432721wme.11.1515094066453;
        Thu, 04 Jan 2018 11:27:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k19sm2783838wre.92.2018.01.04.11.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 11:27:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/7] wildmatch test: use a paranoia pattern from nul_match()
Date:   Thu,  4 Jan 2018 19:26:54 +0000
Message-Id: <20180104192657.28019-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180104192657.28019-1-avarab@gmail.com>
References: <20180104192657.28019-1-avarab@gmail.com>
In-Reply-To: <20180104115058.GF29210@dinwoodie.org>
References: <20180104115058.GF29210@dinwoodie.org>
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

