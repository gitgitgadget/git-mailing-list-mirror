Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4941F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935152AbeF3JJS (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:18 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34375 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934675AbeF3JIm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:42 -0400
Received: by mail-lf0-f53.google.com with SMTP id n96-v6so8462708lfi.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZliiRpHJ86v8RrLRFJ7yL3pEqMKL76HofHFA5qgGmM=;
        b=VD9qu5RmbmrkXBU+l9gI+d/9yoHJ7O9ChDeJxexJ0rDasLg8Gy9LSA/LFPV0ZvVtG0
         wYWMZeCR4l+fd+ChOcZWKrSNiSiladrtE+Ql3Nche8xK+03IpL7gcdQMUJLB9IbyECJZ
         nnm5cHUQJlu5kFrHLDStTJAZqATiR2WiqU7/DjGjPS5xAiT+Etmo1gfY7u4tXlFhW1PX
         oStGT5baItpA4GNFnmTneymgdN0j4rKEvf1DpPYoF7sP20e98bFhwYB04I9jrFlhxmST
         b/tWI/RGbs8v3u/jVZPn+8lLN/oub55pYvxgvNPzOypGJasS9cT6u5OnigndnUQM+S5+
         yxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZliiRpHJ86v8RrLRFJ7yL3pEqMKL76HofHFA5qgGmM=;
        b=R3nE78qddV8+u+pLtQlICMXWoBZQBN6U2le0N6tGWR9hJLaq//eaM0c4ogvixGMVEf
         kLeJ7l1RwyCmswDw11uETKRYBopiJ7T+1aNP+q1P/A7OxnAbnSL8m748iD37wSUrRSmP
         b8ZvMGpVqwU0JfxmjfGMMDlEy6jkPW4HXZeXGfD46lvxudEDnQZO7PQceyvgjUPaO18N
         uJbuy1mAtMxjgMV6385MVWx7fCXegZDKHXcyv4fkE3bVITSMwgHml3Ss4MIFNKF+g4KB
         15umR8euV85A27deJOJOD+jY9AdChNOSWK9f4StCTLwUIxNyoLypI98ejEpAMrqnQnh/
         ua5w==
X-Gm-Message-State: APt69E1WPnT3Z6i1FMJ6uax3Ep6v42WGHaFt2jwkTL2lFAJw2mgbviwB
        FoomXEDX5GSmmSKaGY4vIQHlmg==
X-Google-Smtp-Source: AAOMgpfsYsZFeaYzNEqxaF1sZsWP5HcaASRTGywK6XH4nZZ3hgDFzzw8MiPkuukO1MBvj0DoYYOJfg==
X-Received: by 2002:a19:5c8c:: with SMTP id u12-v6mr9254193lfi.98.1530349720520;
        Sat, 30 Jun 2018 02:08:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/23] exec-cmd.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:09 +0200
Message-Id: <20180630090818.28937-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
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
2.18.0.rc2.476.g39500d3211

