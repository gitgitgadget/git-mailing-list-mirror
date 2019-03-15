Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C1420248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfCOQAT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:19 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39266 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCOQAS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:18 -0400
Received: by mail-wr1-f46.google.com with SMTP id p8so10135226wrq.6
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFjkF2LYNPVVbotv74/vDyvYfDtYa/Y3+GF/BTRGOVw=;
        b=KGZHEnJP6P1JAXdHtI1M/zPQSpx6aaN/sVHiPkuKJSXOG/LUCzfsu9wS47+BDmdcSg
         7503t4QvHb5QFmr+PyVLTI/WloYuG78CcPaDyvzY8rvhddRI/j0E4gSMHt4C/kj3CCcm
         ZMFrK7LSUPeM0AbyiC5n9OTCxsPZB4bwNlUrpBI8zROMtIYGD5XQl77oA0HuPQFU7HkO
         CE+LnAge5m9N2mchnwG+QJ5xyqcE/px5iDQnTo9QOwRAel0Jmot2dIevvp2eSE9D/96d
         0oB0J85U4PycGOJiesXEdIA9JSS81THARstXAtRElzQiX0JCtN9a9Qut4vPwg0H0go/r
         L5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFjkF2LYNPVVbotv74/vDyvYfDtYa/Y3+GF/BTRGOVw=;
        b=OpjWZJWULHniENhMTriQC3ufsqIZXOOtXt5Rh6NUu3QvzFknXbwW1Fx2y3HMAVAnFy
         KntUq8r3Uh+UNMq3cO/MBehz1WI/ANI0+UjPuEDSXHMlC14hnvbn7yQa6UosWgYvrKyD
         tq0MlB6T0HoGRVB1EqmFQjHVareK09aqbASnlEZ1S/dMzhAg44GMeB80SPVbw6/6799s
         PzyCFDzkm5zDtJKf694buWx7uorRulAMKpoQppNU9dUlOydRP8pmdqHr3I+RIXGR9NRl
         4cUM2wTnEJWTJospTfLUjmH5r0gFY5KpxrrbeEvQuXjtv+BYncvKcb0RY+qOARkfSVm2
         5gCQ==
X-Gm-Message-State: APjAAAXTtTgdlVbDhEyPSXjavM+b6DQtS5pPx5YGOzgADFUNSykwtP5k
        JkmTi4h+qci5sA8cVYVribuamSJZA70=
X-Google-Smtp-Source: APXvYqx1gt2vfNCVcIJP8C2UfyLMZFST3qd21xcbq9dr2utFudJfbHfFAaniqb+z16xBdkfYQf/jig==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr2940606wrv.121.1552665616433;
        Fri, 15 Mar 2019 09:00:16 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/8] reflog tests: make use of "test_config" idiom
Date:   Fri, 15 Mar 2019 16:59:55 +0100
Message-Id: <20190315155959.12390-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a couple of tests that weren't using the helper to use it. This
makes the trailing "--unset" unnecessary.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1410-reflog.sh | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ae8a448e343..42f5ac9ed95 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -232,24 +232,21 @@ test_expect_success '--expire=never' '
 '
 
 test_expect_success 'gc.reflogexpire=never' '
+	test_config gc.reflogexpire never &&
+	test_config gc.reflogexpireunreachable never &&
 
-	git config gc.reflogexpire never &&
-	git config gc.reflogexpireunreachable never &&
 	git reflog expire --verbose --all &&
 	git reflog refs/heads/master >output &&
 	test_line_count = 4 output
 '
 
 test_expect_success 'gc.reflogexpire=false' '
+	test_config gc.reflogexpire false &&
+	test_config gc.reflogexpireunreachable false &&
 
-	git config gc.reflogexpire false &&
-	git config gc.reflogexpireunreachable false &&
 	git reflog expire --verbose --all &&
 	git reflog refs/heads/master >output &&
-	test_line_count = 4 output &&
-
-	git config --unset gc.reflogexpire &&
-	git config --unset gc.reflogexpireunreachable
+	test_line_count = 4 output
 
 '
 
-- 
2.21.0.360.g471c308f928

