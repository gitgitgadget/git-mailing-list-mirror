Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EABA1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 12:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeBAMr7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 07:47:59 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41092 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeBAMr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 07:47:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id 141so1730909pgd.8
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJk1G7gNDCtfxklgQJxJRPozpLzCLcNXhsPzf+54Alw=;
        b=nKLjveypWJyHEfKro7bMHId5XzWS6lYtx2i7GLWOCPVgiyDqfwJzV9jjqMnJUX5o6G
         1ugqXVfP2CgIQCq7cMgXW8psLCe5URzadkfqJFxgVWoE5sK6RvpA323w5zFKjdMBFd3b
         6NtbinHILZgFexgxgw+F7Rmij8M29X1FM6qKTZ1JF1XSHybMc2j4VHbBoQrxGDHRL8U0
         rzukxITa7focj4hI6/vWqGkejGttjfg07mJULnnyViGbfL4JD2G2NTQnc1P7yUwab6qS
         Zy72Vz7Yx01tHnAPZRkqGjlw3tgiki+BQrE88z4vGNikacGLpf+ejMziLadXFcRV/8Ve
         HoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJk1G7gNDCtfxklgQJxJRPozpLzCLcNXhsPzf+54Alw=;
        b=DgjoPcRMMepDJfCbjEulLZ8xwN34YY6d+Etae9OTekqfush6nVtq4e7e/y8VKW0sxQ
         nOTU4DahzoIc5puDi2rHJvLxZLaMxcSm+5rzpkcYA0SOm/ihvBuh61oIAE8zdHpGprf/
         d91B4erlYsZr1blNBbca9JKhXtlfD3cb9HMik8jv5Q+5MrOSGKLCR7V9Q8px3luD2tKw
         KqZWHjW+Bk0tSUl/AJ2fMmfFL23NQZmOuCCWi/bTOyalGBtua2B7xNBiAS8uo30VWGiJ
         A2InZwZUApthtpdBUc8h09X0266rUg50hPOcf2bEDPvCrxSUV6cx2WcnsaKWJddlMfuv
         /qZw==
X-Gm-Message-State: AKwxyteI/O7615NH1XDjkErgxxGCVcb5Bo5Dut2lfmw56vmfi5ElrFCW
        sCN3Rt1fdTLA7cHLGk5NB6hFeQ==
X-Google-Smtp-Source: AH8x227+NcvHtuGcEgLzn2HHvs7zI7OxRpQskCeY3l1+iGczvuJrZpGHipBesWGLDmzz8qJlewgsTA==
X-Received: by 10.98.159.139 with SMTP id v11mr36190847pfk.64.1517489278098;
        Thu, 01 Feb 2018 04:47:58 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id y7sm42078151pfe.48.2018.02.01.04.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 04:47:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Feb 2018 19:47:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 0/2] wrap format-patch diffstats around 72 columns
Date:   Thu,  1 Feb 2018 19:47:48 +0700
Message-Id: <20180201124750.15032-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180125115927.16196-1-pclouds@gmail.com>
References: <20180125115927.16196-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes tests in 2/2 that I overlooked (but Jeff didn't). Interdiff:

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 1e62333b46..6e2cf933f7 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -19,17 +19,33 @@ test_expect_success 'preparation' '
 	git commit -m message "$name"
 '
 
+cat >expect72 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+test_expect_success "format-patch: small change with long name gives more space to the name" '
+	git format-patch -1 --stdout >output &&
+	grep " | " output >actual &&
+	test_cmp expect72 actual
+'
+
 while read cmd args
 do
-	cat >expect <<-'EOF'
+	cat >expect80 <<-'EOF'
 	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 	EOF
 	test_expect_success "$cmd: small change with long name gives more space to the name" '
 		git $cmd $args >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp expect80 actual
 	'
+done <<\EOF
+diff HEAD^ HEAD --stat
+show --stat
+log -1 --stat
+EOF
 
+while read cmd args
+do
 	cat >expect <<-'EOF'
 	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 	EOF
@@ -60,7 +76,7 @@ do
 		test_cmp expect actual
 	'
 done <<\EOF
-format-patch --stat=80 -1 --stdout
+format-patch -1 --stdout
 diff HEAD^ HEAD --stat
 show --stat
 log -1 --stat


Nguyễn Thái Ngọc Duy (2):
  format-patch: keep cover-letter diffstat wrapped in 72 columns
  format-patch: reduce patch diffstat width to 72

 builtin/log.c          |  7 ++++++-
 t/t4052-stat-output.sh | 46 ++++++++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 16 deletions(-)

-- 
2.16.1.205.g271f633410

