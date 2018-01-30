Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220E41F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeA3VWN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:22:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38576 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeA3VWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:22:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so3931820wme.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ftBZ/f7A47lNfKf6FyAmwxlnz0idVSMWQHxIZBmA2d0=;
        b=eV8KJwsvykJuqb3b8vS8HTHG2EjGeD9A17diMFkzbVShA4u9RfOxZOKCXwBRGzRvMN
         TJjqU2MFb3+ccHvRkGX/FKsfbejEh7VyUqSP83gFW/1YWb85bjm5UKhNWEeaOPkp69EE
         zAM31wzAGLgSvaynLvERMivzjUh7bySiWsMFV3PTUaM25EhZDyuiDQBFzUbhhJI0UAVe
         8T8TfXWlOnqgNQnd8VjnsBDIqjcXvxhEdMQendx/VHjYMVPV5Djd5UchAjCMOjoAieYQ
         O464+s8P1d7OxPpSFERjFBMkTgZja39weYr//gol05Eb+bzCO5IYPeB9Su7D+GspwbBi
         zk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ftBZ/f7A47lNfKf6FyAmwxlnz0idVSMWQHxIZBmA2d0=;
        b=a5nv61w1HWR0gz0sy6F++eFZO3q4BetkbMjWLv/E1mAc8QX1rHgFu47BAt1RxkQxjf
         7xwYV4vzN/UYu3VRSq32R4VUjXldt6hsM8oZxOxOBCHUeN6hvmtdaeqRJ19llJF+Xu/6
         hUsNIKzjoSTmX0NKAcFCPOG9X2MVc+XQW4u6VMUflaIsMg6x4TZmkqmh4WK2Rix+MLya
         QTQDTWL+IuVFWxpliItauJsbloxaW9/hTVbb8I/gB94bWmnbzkI1P3sKrpc+hjI1J+GT
         PfNQOOz25H2F6Kk59cftK3kYnHm39YEkk3kLl8502qE9CQ+n7gFAukVEIhVI0Lk33eiW
         kOug==
X-Gm-Message-State: AKwxyte8d2//R/qtz4R52/GsrVHqheg4MJ5uaipLZixqAhUp5Dr47ldC
        vCdvLThQQxnB3mMFVhftrasUd1nU
X-Google-Smtp-Source: AH8x226KZmtdeSpj2/RyLLlXO2WTjYFv2U850OB6zqp4kfrsKtBzmpRrBTJ3SWZRBoPIUDIt8MlkBg==
X-Received: by 10.80.165.37 with SMTP id y34mr54189976edb.179.1517347329459;
        Tue, 30 Jan 2018 13:22:09 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:22:08 -0800 (PST)
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
Subject: [PATCH v5 09/10] test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
Date:   Tue, 30 Jan 2018 21:21:23 +0000
Message-Id: <20180130212124.2099-10-avarab@gmail.com>
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

Add an EXPENSIVE_ON_WINDOWS prerequisite to mark those tests which are
very expensive to run on Windows, but cheap elsewhere.

Certain tests that heavily stress the filesystem or run a lot of shell
commands are disproportionately expensive on Windows, this
prerequisite will later be used by a tests that runs in 4-8 seconds on
a modern Linux system, but takes almost 10 minutes on Windows.

There's no reason to skip such tests by default on other platforms,
but Windows users shouldn't need to wait around while they finish.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9a0a21f49a..a2703c7d36 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1132,6 +1132,10 @@ test_lazy_prereq EXPENSIVE '
 	test -n "$GIT_TEST_LONG"
 '
 
+test_lazy_prereq EXPENSIVE_ON_WINDOWS '
+	test_have_prereq EXPENSIVE || test_have_prereq !MINGW,!CYGWIN
+'
+
 test_lazy_prereq USR_BIN_TIME '
 	test -x /usr/bin/time
 '
-- 
2.15.1.424.g9478a66081

