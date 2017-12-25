Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E511F424
	for <e@80x24.org>; Mon, 25 Dec 2017 00:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdLYA3A (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:29:00 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42316 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdLYA26 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:28:58 -0500
Received: by mail-wr0-f193.google.com with SMTP id w107so6355750wrb.9
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=LHqOb6eRCeKbsF3lC4xcEfx+XJOmXc85BTNe19ZlAHabul+bIIVE37Kvst/EqhPV2r
         vGJnLJaQgmX9ZhWjSXKBiUalclEdhiRX7VpMqUeY9gTNl4Gcrp90yy2KbHrOw+p0S2E6
         ScP1VtLCpCZg8XlXukL0QhllY19J7rMOrKbFn5u2SeaTpFGT+nRIYdGBkGPEsNWIhEhw
         Ea+O6C+yU03rM7ivpLT0Vkss7o88YgVzVroRqe7YW+HGqJXtSR2sZBiri9bUhVT9aT2a
         p//ORXBtRq+T582qffPmTCxHtHjoqFZPHnNFjDmykgqhbKx0BwEzBTHlpebjc4q7sB+8
         gRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=tGNnudBpwfV7h7bzKKwXLLK8/cLpG6I/M31lJ+feXWosleVnJlYJzNtCh0/Q8j7Hxs
         YMSNT7ZteIGqHnNkmnzMzgAjml2xdRENaONbmNnNqrj2FGhT0e7qO+7WToM6c9aOyHRt
         RpbJP2j+BscVUJJNUucJ8HuAr7MMZPvRdZUV1W61YxvjsT0O6+PXJcd7XnFcBf0S5Ez7
         cjM0uMigOreu++Cp2G+Fna4rKtSoIQx3eiQIy+FVFVXKsE4tGJwNYoQz4ojlcg7a3f8e
         i2GArngA48wumZy+ggch3PSVg3QKRLij6Vgl4d6zHxS6FXLMDAsy0UiCvF0c2Qf26wwF
         QAXA==
X-Gm-Message-State: AKGB3mKMkbKwLmR+ET2di1pDXc8yz9egzzoGzeSHYFuRP0osWhf47N3T
        v9eW8qSBidV8kOlo0wbZal/8i5iK
X-Google-Smtp-Source: ACJfBou+b00n1zYQX+X+Q8Ak2n18yiDNGJW0qK2s3a5IVd7wZ2NsxHUCBPLKyCTqTzK+XAoXfkpRMg==
X-Received: by 10.223.150.108 with SMTP id c41mr21242113wra.119.1514161736671;
        Sun, 24 Dec 2017 16:28:56 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i65sm52923574wme.20.2017.12.24.16.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 16:28:55 -0800 (PST)
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
Subject: [PATCH v2 2/7] wildmatch test: use more standard shell style
Date:   Mon, 25 Dec 2017 00:28:30 +0000
Message-Id: <20171225002835.29005-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the wildmatch test to use more standard shell style, usually we
use "if test" not "if [".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 27fa878f6e..4d589d1f9a 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -5,7 +5,8 @@ test_description='wildmatch tests'
 . ./test-lib.sh
 
 match() {
-	if [ $1 = 1 ]; then
+	if test "$1" = 1
+	then
 		test_expect_success "wildmatch:     match '$3' '$4'" "
 			test-wildmatch wildmatch '$3' '$4'
 		"
@@ -17,7 +18,8 @@ match() {
 }
 
 imatch() {
-	if [ $1 = 1 ]; then
+	if test "$1" = 1
+	then
 		test_expect_success "iwildmatch:    match '$2' '$3'" "
 			test-wildmatch iwildmatch '$2' '$3'
 		"
@@ -29,7 +31,8 @@ imatch() {
 }
 
 pathmatch() {
-	if [ $1 = 1 ]; then
+	if test "$1" = 1
+	then
 		test_expect_success "pathmatch:     match '$2' '$3'" "
 			test-wildmatch pathmatch '$2' '$3'
 		"
-- 
2.15.1.424.g9478a66081

