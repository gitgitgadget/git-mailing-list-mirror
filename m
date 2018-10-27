Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48EB91F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeJ0PEy (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39221 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeJ0PEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id a28-v6so82749ljd.6
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKiWqzUwcGbaOCev4ng2Lokcv5gnlZdU/uTYCqwnE6w=;
        b=NQFjFp7vogKT3ZU0827O0bXscBtsFuEbtvFgJRPDJEYm7SGrJ6vwpgscM+OGjdu7ld
         xiAlwDWSJ561/6HGPVyulqPBndMoqPj5SHd6lbJ7gdZ8CZQzfXww5qGemo951E0YtYyh
         GRiBfVlkNocbrgdsUEvgikDONl+IRg2UM7IJiV8vKYUDDQMfR0Nbk2mkOJrp3PNe7Wm5
         tiHa21Fg/ui6eyB4oU2uwybR5KLTJPyYnLJTdxAIKIPwaPLfCryRh5gRe82jSRTkffZB
         KlxS1hlLrurwfwgFZ5H9h5TLcGa3YZ3dSNX8VcxhxGWwuqBRJOXYHSgzSROxFG4eoZsq
         V8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKiWqzUwcGbaOCev4ng2Lokcv5gnlZdU/uTYCqwnE6w=;
        b=hIjHgt4kHSHIwC4x1iU+/IgG+fw04PWHSeBXHeIjZOpqKUP6/PRSLZxWvLQD4tk7ZY
         t904gsdz99RdNACkjB23GdfIS21+s73qnuVuczp2Mm5FrxbWVN5Uxub9pi0sjYnHVQ8U
         ea5KnomgZYqxY4vOngjApSxZnHSIXgBwECbWWh3rXP23FkhttWVktbIWpWGs/EkAK2Fx
         wwPj5wW8JcNeNEJ77eB/Kb9zC/pxtqPUxH1rhwY3MWNDzVQDFQ1lCmPaspsQ/5HhcaAg
         9HWMn1GzgjOEOoLAGNYGTn0fdowEx3NU8deFOgOUU04kj+/rcKmJ89yDPi1/VK17af+5
         YJbw==
X-Gm-Message-State: AGRZ1gKFlXMGpGkWhKn0EQywRRQmd5LiWkuUE6tPgAQ1JXUHL4TmgSBq
        y7rS/YwgQVyWaV2fz9UQFZUt+Jmg
X-Google-Smtp-Source: AJdET5dd0FywFNaFv5sRnnojHSMNV/3BqfAXqFgI8/JHTeNPZU8Yyiuqkbxyq2NWONQI0VZ51INKIA==
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr4475501ljj.80.1540621498346;
        Fri, 26 Oct 2018 23:24:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 54/78] config.txt: move push-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:27 +0200
Message-Id: <20181027062351.30446-55-pclouds@gmail.com>
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
 Documentation/config.txt                           | 2 +-
 Documentation/{push-config.txt => config/push.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{push-config.txt => config/push.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9de16a498e..a6934fd87b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -387,7 +387,7 @@ include::config/protocol.txt[]
 
 include::config/pull.txt[]
 
-include::push-config.txt[]
+include::config/push.txt[]
 
 include::rebase-config.txt[]
 
diff --git a/Documentation/push-config.txt b/Documentation/config/push.txt
similarity index 100%
rename from Documentation/push-config.txt
rename to Documentation/config/push.txt
-- 
2.19.1.647.g708186aaf9

