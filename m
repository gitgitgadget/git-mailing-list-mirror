Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5AC1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeGUImB (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:42:01 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42716 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGUImA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:42:00 -0400
Received: by mail-lf1-f42.google.com with SMTP id u202-v6so3235328lff.9
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN598Ih55yvRuh6IXf2Ye5LBO0DPjPbwICJ7YLAL5tA=;
        b=pMaXgKCyXXDE0dKfVwut+xMk15Vlx8HXT/7WDmHsqbgbV65NHvtgk/FBY5tSoUaYjw
         wj0oiUbMiQjgJBrORtrGP9Mi7921IjcJlrWvOf3/71HtFhJRiUyY1rSMzEQybiHQ0Xqc
         HpAFDfalMuXGHb1KItZS6ntMHy6Vs+CS0cul2uNEq5gtu8QmnN+ESDK3dWC5phZn5dxq
         7lcD+c9nrSwt8ANDvAIuuwITHTnHlAAaRS7rfcaHKeqbBADf7k9cxu98b1+RDik6IOSh
         KU6pJTyd1D3uUU6aVDXB2qoZf9bQBCv0PUef2woXBEgGAulmowWalNHh4Mu+uXaxI/uO
         PEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN598Ih55yvRuh6IXf2Ye5LBO0DPjPbwICJ7YLAL5tA=;
        b=A/VWNIn6je1e584NKh16eWAYCTifVdHEP+C/+94IVLL1iJZaePMzFFssflHGCpvpD9
         nf5c1Gm1LhX9OnkIrCM0aMjgUBVfJjj3cTwvJpGRMBox8U5hLY7TEWF5TSQodNj6T0Sw
         6bDjml1q7P/Q54TXCppZvGfrn7EZ0pa5bQOy0wTNYZD7PGnIKx6IxUnxPfjJaAbe72N3
         XxrVAp0d1rYjkRoajsF6hdNrcIlime4GZ/Him18nZU7wQbyRn/Q3SJ0+tnvMvb7ZL8aH
         tIdRZeLoSPWINEKapsniIqx/b5JyFY1bhlrlDeodf/8e+riuU/rJae1zEX1A7tfJuDPw
         cNZg==
X-Gm-Message-State: AOUpUlFppHOwcWvJCu0R6WVNgdvwJG63/2rHcgVFiPMSq75AeF3RNDuh
        bWmH8OapasEeQ2pxRbMlZZI=
X-Google-Smtp-Source: AAOMgpfbkuLwo9wH6/tErvhM4Ls1uiIAtXqB0N8pSwC2eC54ENcaaGI8I6Dgit46ZwQgJUwAubqd6A==
X-Received: by 2002:a19:4ecd:: with SMTP id u74-v6mr2931481lfk.57.1532159410735;
        Sat, 21 Jul 2018 00:50:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 14/23] exec-cmd.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:32 +0200
Message-Id: <20180721074941.14632-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 exec-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec-cmd.c b/exec-cmd.c
index 02d31ee897..4f81f44310 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -358,7 +358,7 @@ int execl_git_cmd(const char *cmd, ...)
 	}
 	va_end(param);
 	if (MAX_ARGS <= argc)
-		return error("too many args to run %s", cmd);
+		return error(_("too many args to run %s"), cmd);
 
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
-- 
2.18.0.656.gda699b98b3

