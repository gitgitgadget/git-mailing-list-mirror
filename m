Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338E020D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbdDPWVw (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34369 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756674AbdDPWVu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so3870379wmb.1
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iJ86W/2faRk8fIepfFB7ANJqIQGYRwKqmA1+qETelQ=;
        b=YvAibT+MKLW3FCLq0bx4xLB98BO4vPM0rrW/2PDE8NMfxpwmUX0a32ksX7kGNNE3gX
         wur52DlnmNlKxhge90xYRUcEg/aAOVZqtI3BUGSOvOr7RHUF61unRU6ElG2G+qdNJTIn
         Lw2rxJSlI/V4IBufcgL1mQHUesOOkYgldTQjw0Ti9LGauzIL08rbAleIaqlpROezPZWo
         DxYipSyvBMxNDvxS5B6DVWdXyarb2YpfpTb4NNYa7FM3W4PScRGV5moYPNO4H/GB5rE5
         2Dva/qPZFrOLv+EriqV03W4vRnoVB+vLiURnnK9d6T6c5SRsKzMcx0cMR3icaS+cd864
         Nw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iJ86W/2faRk8fIepfFB7ANJqIQGYRwKqmA1+qETelQ=;
        b=RzorWHC/Dp71KIIq5kYE06+2MqkyE40Grm8kTc53XBsa1Ye+P7Nwe0fzl+ZNq1S1n4
         a7rNGkm1JstrOPc5w3gRr8m4xxU0AaPNjwXQrjZ8Yvy6GrdI1UlXmgUq+fey0BIOU94C
         mMeSRKxQH7WeT86/bTIihYO+RyYILZvmaEMuiebY18dtYHB9tsZVL3ant0ybUMMeyxLl
         c1dUBcowkFYHuB+TIrbEbxuWFjQWMu8DNrX2seTsJXsvJ/BBlcBs0FCxxGUJvdEQZyg8
         RNM5XPSdvEqPhmn+GTYJx5QKKPVwaJvP+Op+NoWWOGugExpMIU8lSiBB4D0N9zWerTzQ
         nUbg==
X-Gm-Message-State: AN3rC/4EoIfs7q/FIRzu11AiXRvCABDgGDFi3pKtRsZXuoAkNvQkwSBT
        avQ/3ibiR9hGjw==
X-Received: by 10.28.107.129 with SMTP id a1mr6840170wmi.47.1492381295704;
        Sun, 16 Apr 2017 15:21:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] pack-object & index-pack: add test for --threads warning under NO_PTHREADS
Date:   Sun, 16 Apr 2017 22:21:00 +0000
Message-Id: <20170416222102.2320-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the warning that's emitted when --threads or
pack.threads is provided under NO_PTHREADS. This uses the new PTHREADS
prerequisite.

The assertion for !GETTEXT_POISON in the latter test is currently
redundant, since unlike index-pack the pack-objects warnings aren't
i18n'd. However they might be changed to be i18n'd in the future, and
there's no harm in future-proofing the test.

There's an existing bug in the implementation of pack-objects which
this test currently tests for as-is. Details about the bug & the fix
are included in a follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5300-pack-object.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 43a672c345..6bb6a8981b 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -421,6 +421,40 @@ test_expect_success 'index-pack <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success !PTHREADS,!GETTEXT_POISON 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
+	test_must_fail git index-pack --threads=2 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep "no threads support, ignoring --threads=2" err &&
+	test_must_fail git -c pack.threads=2 index-pack 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep "no threads support, ignoring pack\.threads" err &&
+	test_must_fail git -c pack.threads=2 index-pack --threads=4 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep "no threads support, ignoring --threads=4" err &&
+	grep "no threads support, ignoring pack\.threads" err
+'
+
+test_expect_success !PTHREADS,!GETTEXT_POISON 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
+	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep "no threads support, ignoring --threads" err &&
+	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
+	cat err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep "no threads support, ignoring --threads" err &&
+	grep "no threads support, ignoring pack\.threads" err &&
+	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep "no threads support, ignoring --threads" err &&
+	grep "no threads support, ignoring pack\.threads" err
+'
+
 #
 # WARNING!
 #
-- 
2.11.0

