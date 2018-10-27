Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7871F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeJ0PER (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38743 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeJ0PER (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id p86so277128lfg.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+XFLZnp5BL25Y04XsGgpmh/Gy5JJ445VdUSXW0f5Ig=;
        b=iwf2ofY4IYiuHx0fxkzu3M5deeh7GndgA+ppIc0RnIqYCWOknJuWv6hHobsT+xW+0e
         2pKSWK/65TwoOVPtW65qJnGpQu5n8Cn3VanaP9vf4SUnVMtY28nPdc0WP5LEq0+f9oRc
         ly7z7I1KaxDNVebVNA+XNMg0pj5x5Al5eHQJwkVTIScumlVW4bgtNB+e7A8+qln1WUvU
         O/MhTwkoHbM1oZmBe595Ob+qRho6FrbLx14R/0eLBtPmXBzR/6drXknMBYIEw2vNey4B
         E9O6I1cJTRPL1sLySR48fPWB6qkvTMxtH564+Z4hRG6nkj9P7LSxLQgserLuqlWHV92T
         hTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+XFLZnp5BL25Y04XsGgpmh/Gy5JJ445VdUSXW0f5Ig=;
        b=hqmqRFSepKmfLd5PZ/VjmFL1SXRklAwt/AoGw0oKTF5rEdzbQxGhjFBL/BmrLa/OXj
         AyinU0l7hjvjzSuuDW96TqlSrWJzMYlx7DaQshU9VSgJ46uVK43vivs0XHFhqjjKZUFT
         caTYb41gGP9MfmjoeOX8KQDMSOCtC18mxGYp4pivr6wWUNMuNM4mXJgYBtz88qZaRuA/
         5kSoKYoY6zTBvB4pad68tynhK06xIlYQgt7sfr4z/K6bBXCgLKiQQtqqIiLhxOANBara
         H2CApQLpH4F/dm+9+hZ3VfhZjJWLfhURud/r4TXmBgugJ2yfwpEwQkpNKFP2molPXZyH
         1V1A==
X-Gm-Message-State: AGRZ1gIpJnsxifjowFjGPPkKrtdUxdj85+iV0vVrZh6kha1gCi+Jtl71
        /PgFs2fqneGYiaWeQTLVPcL2vbDc
X-Google-Smtp-Source: AJdET5cdthMusNFPhoDpr1F/bi6UW1Tj9NcBXcNIyWUKgnrjVvLQ5SKdc1eMkjR55zaX5qYVwWHvfQ==
X-Received: by 2002:a19:750a:: with SMTP id y10mr3732146lfe.43.1540621461654;
        Fri, 26 Oct 2018 23:24:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/78] config.txt: move fetch-config.txt to config/
Date:   Sat, 27 Oct 2018 08:22:54 +0200
Message-Id: <20181027062351.30446-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt                             | 2 +-
 Documentation/{fetch-config.txt => config/fetch.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{fetch-config.txt => config/fetch.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92bc420245..f85014f803 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -325,7 +325,7 @@ include::config/difftool.txt[]
 
 include::config/fastimport.txt[]
 
-include::fetch-config.txt[]
+include::config/fetch.txt[]
 
 include::format-config.txt[]
 
diff --git a/Documentation/fetch-config.txt b/Documentation/config/fetch.txt
similarity index 100%
rename from Documentation/fetch-config.txt
rename to Documentation/config/fetch.txt
-- 
2.19.1.647.g708186aaf9

