Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BA81F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeJ0PET (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33839 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeJ0PET (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id n26-v6so2495117lfl.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMwNaSnlSupVdeK4hXoxnIXFNX4fl1DthIB0l8loZ8Y=;
        b=b4yLroBaZjhFQFE96iJBgXzu3O9p+QYKfp0Wuv8okww4El1AKqZ/JyQr3AVV2j+JVl
         s7ZsqH5zGvzPPGj0URX1wj8ni2nIPbGbhUSQuYiu3bIokqs1KttqqMsoY0Ui5J8H+Det
         vVDsakgo2NroHTtZFE0oADNO2+TMtO29ZAxoh9TW/U9Goj3nU8jFJFJb+lBd4nC0Sv1V
         PeIqLbT+Ju6drHbGRSSP+6OuFkl+OexPNEiNRly2NdIkKPUZHEnOmyb0WUADe5dFzf1E
         EKoMBTuvRbtgP4NRpw3Zt8d/1026Fs1kxp0l4azRaFniamwG7GBj7W/FhZ+mOM+gtPT/
         2BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMwNaSnlSupVdeK4hXoxnIXFNX4fl1DthIB0l8loZ8Y=;
        b=PaBJFDI3z6/O1IwTsh6a+Owkr05OF1pMu2Wg1kON40RngAOlBMrz7aVBHB7MOtsNo2
         p8d8DZ2l/eMapvTDQdlVGo7G75I0EyZ1zkMEQ+tmV2eh+5on4VI/ChqkT1xK25RGCpkP
         +DC2v6vYkCYfbY9tTB0TyvttJ/2ttIT94C34H/9RbSjgqshsb7C4AldgBiIkvtFZJAbg
         7CjfJxJSpgkC+zYYrvhnNzlbMOeA4PzduiwOoCzflclXhxRlpr/67JiMXedoEGblV04F
         A4uRMuAom9CFO5fGzpV0Tlzscv+OP7dX6UiXJDzTWJMlcYaZvlxPhe2Bdj1UCZtsmPkX
         j4kg==
X-Gm-Message-State: AGRZ1gKQAuMML3v1RJDAl7Er75wlzp6Yw7v2arCAY1e040d/JvtAjfAJ
        HkG8YnggcIUsflQBxI3sHripCZBE
X-Google-Smtp-Source: AJdET5dZxWcjvnWpI/Cke4gRBfmi57dpMVA9HjVbFZg1P7QSTrIRFYI/GLGlFs1SnqRC0ZAtWtGy3w==
X-Received: by 2002:a19:1b4d:: with SMTP id b74-v6mr3750360lfb.42.1540621463657;
        Fri, 26 Oct 2018 23:24:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/78] config.txt: move format-config.txt to config/
Date:   Sat, 27 Oct 2018 08:22:56 +0200
Message-Id: <20181027062351.30446-24-pclouds@gmail.com>
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
 Documentation/config.txt                               | 2 +-
 Documentation/{format-config.txt => config/format.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{format-config.txt => config/format.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a225dc530f..3dc2285ba5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -327,7 +327,7 @@ include::config/fastimport.txt[]
 
 include::config/fetch.txt[]
 
-include::format-config.txt[]
+include::config/format.txt[]
 
 include::config/filter.txt[]
 
diff --git a/Documentation/format-config.txt b/Documentation/config/format.txt
similarity index 100%
rename from Documentation/format-config.txt
rename to Documentation/config/format.txt
-- 
2.19.1.647.g708186aaf9

