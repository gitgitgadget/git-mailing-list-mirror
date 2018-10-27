Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAED1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeJ0PEZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44119 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbeJ0PEX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id m18-v6so2471571lfl.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImS/DiZaLtPEcQfWb6DV2gmASA8B97f0zJP9/cvgz9o=;
        b=WjseAaRAjLIhaka2gZ0lTNMoG++qLhvs6ghFd0DiOhtuOwFCnKl8WfqHgqicagIza8
         8AFt2gJjc1Qe7g1iCnHCgaF3srIDiIcS85LNA4XSsU9Jz72geStzVV9AJkofWnQg8Xhx
         p2CgWHp3oFbvB8kdXh1rz3Lt5OQilrq8OUoMC6fr/yN7m+/cwOAsaox3GaVvZQCkWHdx
         BtRzWX5YuvJdAPelZvWxwNZVyyJDQOeU1AykjM04EbOgQmRackSjFzjylj+3CgussmFG
         yUzHLG52AiryD4JfMIY9bPBRZUmQ337SOPBMCFakBKBQKqiDKagVvTXMEHOJBjnqb3YU
         ARMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImS/DiZaLtPEcQfWb6DV2gmASA8B97f0zJP9/cvgz9o=;
        b=qZoFQQOzK8thVZ+HXft/Tke/5g+YX+f1gDHbKZNrPvH5wNMzxEAS8Se2ixvxKFlgwi
         BgeE2JwjAcGy3NyPHZ2uzcoKGzrj+w0w98EJklLgbjaf2kWqbpTB0KJSIBPLrP+kEtNk
         bRDe9g5JUP3JD8/WSr5XTCQTi/gLB+PlBAyUWC+FaLFBJNScwgBdV9f1p+7kaYsG4huK
         jMucTwQ8zTFgJqHYlutN9TEaq7ZhertN/OAow5HWF/Wpyd9JABp/MQyqGGFweBD79Df6
         vPU5VcRZ0zWeMdIX0dcd4cigmCtg7Hojg7WnadlSE2MOxSO5PBQ2+HZONYJwZkj5SgVu
         SX5Q==
X-Gm-Message-State: AGRZ1gLtQJU1rAcgyrHjUSS1WLvhnn5Qy5ZFkZDvIzVKRQ3oTRrar4Xj
        P2CCbKn1MlfSujnmrEyud64jOwBw
X-Google-Smtp-Source: AJdET5cwgCEdIcAA82c9QIJHE9bbZfMpPuypcB4JjnVwGqWjl3fsy3ZGucwb1L3U5YDxCppOX6Rd/A==
X-Received: by 2002:a19:aace:: with SMTP id t197mr1092756lfe.7.1540621467715;
        Fri, 26 Oct 2018 23:24:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 27/78] config.txt: move gitcvs-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:00 +0200
Message-Id: <20181027062351.30446-28-pclouds@gmail.com>
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
 Documentation/{gitcvs-config.txt => config/gitcvs.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{gitcvs-config.txt => config/gitcvs.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dee012a5d5..6f4a66b3f2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -335,7 +335,7 @@ include::config/fsck.txt[]
 
 include::config/gc.txt[]
 
-include::gitcvs-config.txt[]
+include::config/gitcvs.txt[]
 
 gitweb.category::
 gitweb.description::
diff --git a/Documentation/gitcvs-config.txt b/Documentation/config/gitcvs.txt
similarity index 100%
rename from Documentation/gitcvs-config.txt
rename to Documentation/config/gitcvs.txt
-- 
2.19.1.647.g708186aaf9

