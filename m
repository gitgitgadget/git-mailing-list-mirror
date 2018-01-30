Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47BAB1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeA3VVq (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:21:46 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37079 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbeA3VVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:21:44 -0500
Received: by mail-wm0-f67.google.com with SMTP id v71so3958806wmv.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=R7c3ca3D/xAGs8XlhQaGncHX1atXQM+SY6KuHLWIJb/vBGjARJJ86TSzoWsBryPZD7
         gnfqLLvydJ7Cl/03FrvQLU6B/+y38+T2NTT3QE3r7JGi7qTfXuwDnPTamFjQW3s4gGNZ
         uCo7WHoAPVkEKvXTlTS8X3ybC/JJigzu7PewB7k3iRKO7/Y42AhjZl9op+yp+Fh4pJMQ
         GfwtG+4WKOIQSP2ZbGGf6sp4fm+gm/PJ50g+y7M9VkSxk8bsJPN9jjQxQnMH1wLn9HrZ
         cXnnyvRtANR6C4FerH1yHnKtt6kzJPDX0g4XFf+FrgAqa3mIy7Pf/P01/5qJUgmsrlqA
         haOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=HkmoyVG4wKM/59k/rfjCP7i3ZrxoNI7aNWTnTAb0lh/mFZfWqXAzCTEytXi2kci9wg
         530xEb7MfOvD9El1GoqsZ+034suF2oYOuZ/Jtps/LdsmyDmRB4n48oVByOiIWyV+JwE1
         t4H0Nzmr4Y8tuACUS2QMhoHjAgU1AuehQ6LTC3OwsoNdmMA7RQRaFiVl3XziYLyEo2cO
         kzfR29pqZPOrUIWyvxVhmbbxVdi/jaZoEpE7Ty+hy5LytAvXVDZf6qKCUYjjeOcZvnPX
         um5sr5njmRXkGr9NeSUu6lwbiiKyGF5jCgfIXZyfEG4b6q6s7u6dbMfM0ZmY9qxNUyHQ
         ChMw==
X-Gm-Message-State: AKwxyteoAETkbzUOd2TAjResXxrxINYHXyH27Kj2jmVP7gsY89DCAvSm
        V4CWJsvOnbJyh/PUl434qWi6bFjl
X-Google-Smtp-Source: AH8x226uaCA2BP6BEC9Wak2SNkgw+EkzH2XBLhCFR+6CwP93BMOCSZjz408UxGtdqsLYIaUJM9myBQ==
X-Received: by 10.80.144.196 with SMTP id d4mr53915304eda.164.1517347302903;
        Tue, 30 Jan 2018 13:21:42 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:21:42 -0800 (PST)
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
Subject: [PATCH v5 02/10] wildmatch test: use more standard shell style
Date:   Tue, 30 Jan 2018 21:21:16 +0000
Message-Id: <20180130212124.2099-3-avarab@gmail.com>
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

