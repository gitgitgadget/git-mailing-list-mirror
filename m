Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCFE1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeJ0PEO (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33028 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbeJ0PEO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id w16-v6so2504194lfc.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NVMum0Q0HoAmXV/kluerySETlzqCfnczC+z2UtP6qo=;
        b=nlHyiW9JbH9CMYWNzpOu8+rXF7ZdzM85B76xwzBkOJyXLCCs6tDQJK1KKciqbIuT0m
         rapfhnnezR8Rz2h38nW+ijfSXXstyiw1jYJPMczNSEX3DP6fYhMHQSkXbkMp/oDNnj0a
         hwlBYJRn2tDqFErL0EyAmIrrOz6cfXFxpf2rsjeM3eAvOK+Dn2OSYzvbokvBUaVA4p7f
         bW2kXzxq2MiqFh4lQidOwlgEbG4+e5GrW8aJCapXqOaBG9qAnP4nSSrQd8qTQorAfT2Z
         cc2ifCss/vjmfQQj7nJfkFdq3SplPuUzhTTRtzVuiTqtG/84bmqVQuLSrDfE80AuL7GT
         9s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NVMum0Q0HoAmXV/kluerySETlzqCfnczC+z2UtP6qo=;
        b=MAwbeeKeLKlJXse35g8yp++Xe9wgmIty9Erkxv8M4th44NfwOJiMSnnORSnlW0Wwk/
         PBsEwB/1lOeqoDEDOb+DnYfYNkGDRXH9Ft88Ng2rgQoLV7NPY5rgKCUYkJg0DwaPbGMv
         KTWcgmuRBM/4tIQXxVnw9IwO1cgyhhWxqjqTAciqd+YhPXh/IEc59HoI3V7YZL7wInNs
         e3EaHsnrYd5CEsY9s49LO3gmETZGeBYOfdvwrzm0I39yJjR7BuUR/QD5KB+dKz4lj6PO
         6zKt3YNmgrAkq/EBcSbJmp5bzskjON/g0xUfuEnwoj7FEmsPJJSp2lhDLJta/9yMHLRZ
         Tvvw==
X-Gm-Message-State: AGRZ1gJkGILLN9lcjHDk9EVr6gR89qfeF7nYF1G4pLtitDPPTZV74mh5
        +iQSG9s2EJq0Whz9XnS2QOWwJ33G
X-Google-Smtp-Source: AJdET5ckHiVEKATgvs6sEJ6EnX7benB4KQAVVGtgCOobD2Chx+V2j6QcUcnPm5Mw477l1wD+CHrtSg==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr3965431lfb.72.1540621458585;
        Fri, 26 Oct 2018 23:24:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/78] config.txt: move diff-config.txt to config/
Date:   Sat, 27 Oct 2018 08:22:51 +0200
Message-Id: <20181027062351.30446-19-pclouds@gmail.com>
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
 Documentation/{diff-config.txt => config/diff.txt} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{diff-config.txt => config/diff.txt} (99%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 83f5ce9056..5693ce7654 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -319,7 +319,7 @@ include::config/credential.txt[]
 
 include::config/completion.txt[]
 
-include::diff-config.txt[]
+include::config/diff.txt[]
 
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
diff --git a/Documentation/diff-config.txt b/Documentation/config/diff.txt
similarity index 99%
rename from Documentation/diff-config.txt
rename to Documentation/config/diff.txt
index 85bca83c30..e4db77bc82 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/config/diff.txt
@@ -177,7 +177,7 @@ diff.tool::
 	Any other value is treated as a custom diff tool and requires
 	that a corresponding difftool.<tool>.cmd variable is defined.
 
-include::mergetools-diff.txt[]
+include::../mergetools-diff.txt[]
 
 diff.indentHeuristic::
 	Set this option to `true` to enable experimental heuristics
-- 
2.19.1.647.g708186aaf9

