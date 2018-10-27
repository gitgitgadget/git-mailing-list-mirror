Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A271F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeJ0PEx (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44836 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so3085192ljc.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/gl0QGtPHkG8s1SAVVrWq2R5FCVwttuxecKisKK8Jw=;
        b=K6y/oRkquM9LxlS78nPEW3fgDp/pJRuNTotUzOA7v+qxf/839P8HrNhIPRqlPSe7b1
         cezx22+sZs3KUBY4GGcAa7xEtHPnMHbQ80WxiFCT5PMZYmeTFxN90PpDq/ADxYEMHfSE
         sv2S47IHADUJbXQCDn95EgfLMjmcZu+I/zDco40w/qB5FWMcF/Oreuf4SgTTIJKvibhk
         i00R3dPmTH8XACml2NTYk6Df9laSeaICXjkuqLxwU2FDGoxNNA+Oz7SiCwpSgLHDcDt6
         Ybl4nH7C/SlFcn55ffTTAk6c/XXqaMJBg+hK1bPwcEHeqhIzDr+FCxKnTDfWpyuseJfZ
         U+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/gl0QGtPHkG8s1SAVVrWq2R5FCVwttuxecKisKK8Jw=;
        b=Mw2BVndWLU/yqGPaLgBMa0pvZydWlB04YJREPNPyjSc67D/kdFwkL1EMxYMzx4jW/E
         Iv/ofz1QKE6rxIMnZwf+ErGTSYJGXSf7iV5AKePc9oMdlWB3x9MiG5K+jCkHzsd9DSxe
         tIn0sT/zwtmSmeFTj543cexkuPYNtF+Rvl5nejwxe3yzIlmi9ItdlF2mejnrbtTZZ2Gw
         ZkRrmWhZGnSAjQPOwS7ZatRVYFAzK7XOVco3N0I9xgOjtH/uK6Tgn+zWOL1IyriKMUvy
         CL4RSm1ZPY9xYsg0nLreNdgxdIya7x0WJjUP/45ZpYFmGz4QP21B5E4/d3z/OMYBnJUY
         JvpQ==
X-Gm-Message-State: AGRZ1gKlmlBelg8U5txLS8otMSit/s7bak8HpLyTi4e2/vC3Mh5GeOwU
        a6P/hGGtDx9d70+3N4VcjsSTj9U1
X-Google-Smtp-Source: AJdET5ficXR5aV+d8EnBeVGOHJryx+viS3Vao5632RRZOrF2lwAYnEyxYl5Z3ZGNUO0jlhUG5wykDw==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr3541857ljb.106.1540621497265;
        Fri, 26 Oct 2018 23:24:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 53/78] config.txt: move pull-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:26 +0200
Message-Id: <20181027062351.30446-54-pclouds@gmail.com>
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
 Documentation/{pull-config.txt => config/pull.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{pull-config.txt => config/pull.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e80148a133..9de16a498e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -385,7 +385,7 @@ include::config/pretty.txt[]
 
 include::config/protocol.txt[]
 
-include::pull-config.txt[]
+include::config/pull.txt[]
 
 include::push-config.txt[]
 
diff --git a/Documentation/pull-config.txt b/Documentation/config/pull.txt
similarity index 100%
rename from Documentation/pull-config.txt
rename to Documentation/config/pull.txt
-- 
2.19.1.647.g708186aaf9

