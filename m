Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1751F404
	for <e@80x24.org>; Sat, 23 Dec 2017 21:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757219AbdLWVab (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 16:30:31 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41672 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757123AbdLWVa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 16:30:29 -0500
Received: by mail-wr0-f196.google.com with SMTP id p69so21763123wrb.8
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 13:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=sAqzI9b7KpMI5uD5ZNHVUOakAgiNrf6yjF5JEu+IxWaNm2Wwa5KQafuwAKw51sAQC8
         I14+wM8C5Gl3n8yO4gkTX/GFT+tZIEHxfeFZN+zLhTR9yIsWhPQdtwGfIevu49Z9Ggbd
         VLwurUfAgRK8KfpDxDig3mN0nTvWmHh+jpbqhgLcSwRA5Ka/O8NbVB7ZiKNZhBgXwiRh
         vnR+yS7jlsCdvgi46hnokNad3BJPIJlDognNzbB2xPj5N66dvI3Sz0Q2Ia0lK8UTnnns
         NIEjJBhgLhp9t4L15fyyN80h+xpgjXyF6KqJQkOtLhUSoZyYxvjmR14akw+vXb//x7PM
         NeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2/9XnMnCMnc82QOsAk7k3P1m05Maj1z4QMb7qwvNA8=;
        b=s4w3zCqOTGgHFbcTNn2G5V+g+fGU9dGy9ySfotF14EFww3NsJsmF/Ysyv57pzmdSvd
         /e2Rnz4GuOiGVmaWf1eZyz0rS/hCtMPDRjPMHu5I82/swLyF0QKYizWQ89m/GGMhl0Ws
         EdIz0fAEImPBzcLgLaxrMavU+UYybBJa3h76qKzSSAtEH1P80oo8lBYCtrcTztLuCm59
         m7e4MD85rKXuATL4HLfTRrItn3kwZk/LCVSauMIAmhP7LJqzVzB2kMOKqm7TNugZg5yv
         OUxtiq0UBzSMrSSghi99syYGJPExhX0xWvpby90KGV44PkT5mOxIYr8KUftUAV+dUz6B
         b2lQ==
X-Gm-Message-State: AKGB3mImY5HV9/9coQagJSef+KkJYnIxmet3+nXqzEKyatADTc9sn30Q
        Fiwm8n5xmyZtQtfIVE3jv8EV4dZq
X-Google-Smtp-Source: ACJfBosa9mBC2QuTPC+zqkcbPOh+VXiWVjNaSq3pycyK54rqqjfnI/dJ9hvElOq86ojGKG8OccyZ7Q==
X-Received: by 10.223.192.69 with SMTP id c5mr4804505wrf.214.1514064627875;
        Sat, 23 Dec 2017 13:30:27 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c2sm29074950wrc.81.2017.12.23.13.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 13:30:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] wildmatch test: use more standard shell style
Date:   Sat, 23 Dec 2017 21:30:08 +0000
Message-Id: <20171223213012.1962-3-avarab@gmail.com>
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

