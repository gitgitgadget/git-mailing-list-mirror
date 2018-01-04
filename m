Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9242E1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeADT1m (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:27:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32847 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeADT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:27:41 -0500
Received: by mail-wr0-f196.google.com with SMTP id p6so2480994wrd.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=Vqkdz5XuZ2NLVxjDLg+ZOohAxCpP8ft0S2FrdAVsxmvny5XAiJgyhA0OVdqtYlikcH
         DuFinBA9cfdF866qtwjbgfsQIWJCYOucd4M+m/yw3QnWlCWSjR+fzWP+ChalxFtOCVFG
         nQtmZdTiRtlV6/xZqPaZn+Jn/hz7+rWcD5oS27tIf3fgW5og/8cZJVE/NhhOp0L3eJXw
         MC0/ZSPG6gzhIkdTsxY9S0pFzoxNumlAJB+ylGuDw7ZxV2eYYfPgHCNYd4UJD3i+B0+z
         Yc0rpZEdrQxbNfGnpUZGFLZzCAwS5uDYIyYmMpFrOqckFSWB29nVLViJBz2WaoIqyOEi
         QOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=QqDTsM/b+kr10/gtmx/s/HZbdsC8XLHubNKD2AVdfF7PhJIQvKxuneh05YPHUWyEsP
         3tHTzuozCrIxmSXRyWS1yLTcc63+ebZ47JnZiMy3JVCASkpnqiq6jhdQ0JHWRiXqBB2J
         YlIx7ehQg2KYTPasbU89fMHhlBIA11ZrM2Zo0Epn03CAhWpsTi8B9VzWKChmdcchNyNU
         2t6UGGQbPBUi2GkfebBme9EXvn/liRlr/5qAkQKAnGngWwCWEZlQ4RopLLLitIG/kofR
         rlui62/PhFgHxyVwivZ1MWm83mYaab5vGxlyFmUIB2CCuZYsZCDj1WnN78KFf89cxYFl
         r0Bg==
X-Gm-Message-State: AKGB3mL2HnJRwVYS2XoK1NG1e1NK5mFVEgaXbpuuc7e7XYMSmtKBhEmh
        eVcExIK8BMprSFO5n5XC+sDKvU+Z
X-Google-Smtp-Source: ACJfBouwqn5+csJ7lSjSxWnDDWZ/8PsJ7SbTevgcGmavgT7IA5IjCtmFpZYUzhDdJyJaktJTwi3H6w==
X-Received: by 10.223.160.111 with SMTP id l44mr591543wrl.10.1515094059422;
        Thu, 04 Jan 2018 11:27:39 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k19sm2783838wre.92.2018.01.04.11.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 11:27:38 -0800 (PST)
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
Subject: [PATCH v4 2/7] wildmatch test: use more standard shell style
Date:   Thu,  4 Jan 2018 19:26:52 +0000
Message-Id: <20180104192657.28019-3-avarab@gmail.com>
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

