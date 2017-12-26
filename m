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
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5B71F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdLZJKf (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:10:35 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:37934 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdLZJKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:10:34 -0500
Received: by mail-pg0-f54.google.com with SMTP id f12so17588631pgo.5
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gACdTgNFtiwoVdxsaCi/dVcG50doQubfDSfUgxFNBas=;
        b=KzzKOyIeEx74rLXHJfSzE24hAPmN7EQJtdOpGOxCD/MioQ47Unqly9fX/CFFYpYf96
         wZT9WV3pATYcPSx9Y//EoCpf3JIpCmHX/xOE2VpmGteasDqYaGbXElsRo1qP03i6MxB+
         aHsv2GsEhHdI8v9CDl1J357L+k/C6dfoa2LV+vcq6dfhKb5OMUqvT9qouTpnRNIz3DYg
         4efo1YohGdx036YcbsOBWEPo0zRswtKsqME/FjZlMTsnU4TwhPmF01dMc2rLitrNQRKM
         DpXD6CmThB781Tb8ysWg+hWg1aq8quy97ICeRdB2leh9u3jmwpGNS4RthyqV13sVAnAO
         qXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gACdTgNFtiwoVdxsaCi/dVcG50doQubfDSfUgxFNBas=;
        b=i1MZfhLKQpVTFmpzEnEDMjvPvAvFYuzsUPtGkjgHES1yb07xFPxVI6YMz2jTWFHWQA
         AY2/A8uxWIGKvAsvSkJ9uCBqZx7MZhYTEFYflaZMQfGcxz0eYU0nm3CqRfj7BO0C7ZJx
         53gxC7awaC/es4lgV9FjZLlLtCXPccTyi9YaCbzPp8mFu0g30T/H3f71vQnPpFtLoVxE
         dosQJf9t9MdWR04uX/43e2ht/p6oDupGstJIGYLwJFo5+aKUGJF82TR3Ev081AIPsxPk
         0218SVrwh0FxxL0NHqDIw4QUTBvPe+1YIuptNIikAWe7XxH1wBfM7gjeI9QEPmP5VIOa
         AkvA==
X-Gm-Message-State: AKGB3mIDT2mO1sBMFSjn6bZQv1mhcxxML4G0ng/suZWF+GvZrzY/TUoM
        +RETjNWM+x9X0V4Ezgu12E0KOA==
X-Google-Smtp-Source: ACJfBouYd6U5PO0e06HMoClzOX5IRGk5sXbtEZ0TbpS3kR4k9jDHMiT8WwVktdM456WfYV3bur7GIg==
X-Received: by 10.98.87.13 with SMTP id l13mr25236499pfb.193.1514279433283;
        Tue, 26 Dec 2017 01:10:33 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id p85sm60971919pfk.147.2017.12.26.01.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:10:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/7] t2203: test status output with porcelain v2 format
Date:   Tue, 26 Dec 2017 16:10:06 +0700
Message-Id: <20171226091012.24315-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171226091012.24315-1-pclouds@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
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

