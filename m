Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578051F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdL0KUA (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:20:00 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:36639 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdL0KT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:19:59 -0500
Received: by mail-pl0-f44.google.com with SMTP id b12so19227952plm.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gACdTgNFtiwoVdxsaCi/dVcG50doQubfDSfUgxFNBas=;
        b=Q/5ahbOsDIp/+FoV4tc+kKvLtxymUfV/CWsbCOGTOV+3ekjRw2dew4H4NoG5ObIPft
         yagAQdjZd/M5WznLMgXWuA0H01WDz3HilZDLgQIdVhIkR9JBADk/sIbRevcG3O93P8Xy
         ABfv3klvjTAbIB2BXIzW2oz2goapKTcDz8IDM8Ti13g1cGhRKGeRi1jk3qwN6tKc99aC
         QKswDY4b2B7ZtCHQ1pFgTkOp4FEblv98tIeN+qQIJ6wF4zHQWL28PmW+16LmOAgaVo2M
         2+ayiMDOSL2LpVGtkzR3NlO/Le72RLEJDHBGjS/vJngoscncMj6WBt9gYUO37ltg1Cbi
         gZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gACdTgNFtiwoVdxsaCi/dVcG50doQubfDSfUgxFNBas=;
        b=YbvkKs7Z6DaLBrnwv9mEMSW/SvSBYNto8LGoSqppkszRxP1YBoIegozK/7gRySoRfO
         wZANHMGX//uG2q4t89qNbVAQMm31FqHsrOiq2pjJReg1WJuTwa9chDzNr6z4n9vF/bKf
         qNFeXME4kWDQgQYoaBZcSs1giLzHEhMEav55i3G4inSRDS7YQVC+Ru17V9b6pzMFi7wl
         vbSah9S3gkRxrYahUw9lbQpDK/A6Ob0lT4gSR2k7h5vWEHacHK4c2iEHCDiCMhIrYUko
         mSzoYOX/CKhhgTxr1jw+UTNpBSzg39auOBHI5IGVFp2lzXIxKEChUZjfDF6DQfAtvfBz
         CPpw==
X-Gm-Message-State: AKGB3mI3HrCGRscGChUPE1zRGwlhorfZ8xTTjRgiv4BhEYmp2662wwfs
        8lj8Y2OlO+kB4/7l1+xPuYSxRA==
X-Google-Smtp-Source: ACJfBoszqnP9vTjurKHpXXJZjXQ0k22L/mYn7Uy7VEWxXSD1Htnw3R6/eIjDUl0kwTttL3EP+tdfGQ==
X-Received: by 10.84.198.67 with SMTP id o61mr27318501pld.261.1514369998899;
        Wed, 27 Dec 2017 02:19:58 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id 6sm43554426pgf.54.2017.12.27.02.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:19:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:19:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/6] t2203: test status output with porcelain v2 format
Date:   Wed, 27 Dec 2017 17:18:34 +0700
Message-Id: <20171227101839.26427-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171227101839.26427-1-pclouds@gmail.com>
References: <20171226091012.24315-1-pclouds@gmail.com>
 <20171227101839.26427-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2203-add-intent.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 1bdf38e80d..878e73fe98 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -25,6 +25,18 @@ test_expect_success 'git status' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git status with porcelain v2' '
+	git status --porcelain=v2 | grep -v "^?" >actual &&
+	nam1=d00491fd7e5bb6fa28c517a0bb32b8b506539d4d &&
+	nam2=ce013625030ba8dba906f756967f9e9ca394464a &&
+	cat >expect <<-EOF &&
+	1 DA N... 100644 000000 100644 $nam1 $_z40 1.t
+	1 A. N... 000000 100644 100644 $_z40 $nam2 elif
+	1 .A N... 000000 000000 100644 $_z40 $_z40 file
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'check result of "add -N"' '
 	git ls-files -s file >actual &&
 	empty=$(git hash-object --stdin </dev/null) &&
-- 
2.15.0.320.g0453912d77

