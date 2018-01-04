Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139C91F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeADT1q (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:27:46 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46420 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeADT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:27:44 -0500
Received: by mail-wr0-f193.google.com with SMTP id g17so2460425wrd.13
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=srOu7ad8npBwzycvXGrBMqaBPSrTH+eahp3WjVq8WA4riTR0Fx3gmogJ1XZaufrXxK
         lVtJDByUMjXIgCqbD4lyzYCKWik47JyVT3kqqVFI8oA+Idum98vdrIf5ppMY3Cgvtu9Q
         XpkYt+SpTfEzNTJJCkLY5NlIYLKzgnXc4iTDMyc0WRcNN4R/8Ylfi520vOEYJIwUq7iI
         L/V5h/hLGstBO+NOHZwF4BiIWOeaNqDNcyS/WiCQjkhiOE8lxwr8sDD+Tk9aPYWb/mUV
         ECGBFotR9BeI6GiknMjTAy0RnUEIOzcFZQdlM3o4aeWSXUtT1Ub1Z7Un3or3Vr6k6vYZ
         f7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XKk0jwHPM7lQSapfNdtwsqBriQe42B8bEE7PCoAzPXA=;
        b=EdSwO6dljS/NZXdcFBqFEWjom8NBn3tt9bUTy0xDguPK7/Y3NW05KnZjEcka28so14
         eKFIJhWVYkNcJQtPTqvyTVhJhSkF2UTHyFnEzLBgCaFlQ7ZqPoCMUDRgeIShnfhiVLJ7
         6bES8FIb8YMsoWWawSqZQ5IDLiju24Ah6IreJsQkbwfvm95TLm2OLiolLAYq9uz4q+3y
         gcnPXyjnEex+5HhtRqj8qVzd5PIT04Qu980HOpfEhRXzM7WBpGQpnVcbyi3mHdNpc+MU
         04v9FMckDGyAObG8HXjGzdKgn3879NAf6eJUkfwEWP1886Bzpn4dGsAYmHFIwBtAFfsq
         8FpQ==
X-Gm-Message-State: AKGB3mI3VOj0+UYyTyzS1oD05sY/QdSbhL7eDKTjrwnYtXg5SaRlahts
        iyr2njE9X4R942A3+P2rwZYwsuNQ
X-Google-Smtp-Source: ACJfBotIkeGBn1gxeTgf4HfCG58mhT2PGfmbE9lHS4yUfQnT/Dlr40SBj8DRl2XXjw1XcZKHT0JPmA==
X-Received: by 10.223.128.164 with SMTP id 33mr615483wrl.85.1515094062749;
        Thu, 04 Jan 2018 11:27:42 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k19sm2783838wre.92.2018.01.04.11.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 11:27:41 -0800 (PST)
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
Subject: [PATCH v4 3/7] wildmatch test: don't try to vertically align our output
Date:   Thu,  4 Jan 2018 19:26:53 +0000
Message-Id: <20180104192657.28019-4-avarab@gmail.com>
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

Don't try to vertically align the test output, which is futile anyway
under the TAP output where we're going to be emitting a number for
each test without aligning the test count.

This makes subsequent changes of mine where I'm not going to be
aligning this output as I add new tests easier.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4d589d1f9a..19ea64bba9 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -7,11 +7,11 @@ test_description='wildmatch tests'
 match() {
 	if test "$1" = 1
 	then
-		test_expect_success "wildmatch:     match '$3' '$4'" "
+		test_expect_success "wildmatch: match '$3' '$4'" "
 			test-wildmatch wildmatch '$3' '$4'
 		"
 	else
-		test_expect_success "wildmatch:  no match '$3' '$4'" "
+		test_expect_success "wildmatch: no match '$3' '$4'" "
 			! test-wildmatch wildmatch '$3' '$4'
 		"
 	fi
@@ -20,7 +20,7 @@ match() {
 imatch() {
 	if test "$1" = 1
 	then
-		test_expect_success "iwildmatch:    match '$2' '$3'" "
+		test_expect_success "iwildmatch: match '$2' '$3'" "
 			test-wildmatch iwildmatch '$2' '$3'
 		"
 	else
@@ -33,11 +33,11 @@ imatch() {
 pathmatch() {
 	if test "$1" = 1
 	then
-		test_expect_success "pathmatch:     match '$2' '$3'" "
+		test_expect_success "pathmatch: match '$2' '$3'" "
 			test-wildmatch pathmatch '$2' '$3'
 		"
 	else
-		test_expect_success "pathmatch:  no match '$2' '$3'" "
+		test_expect_success "pathmatch: no match '$2' '$3'" "
 			! test-wildmatch pathmatch '$2' '$3'
 		"
 	fi
-- 
2.15.1.424.g9478a66081

