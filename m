Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C341F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeJ0PFD (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36264 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeJ0PFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id s15-v6so3127438lji.3
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVc6mFzrVZfMW1bGolNu2CG8lq3qIiF7T2RJLAhhoTY=;
        b=aXyZeDaHhciFdtfEmI1HbRmto9itJnFUtBW9doQqA+AoDB4jhe/+ZELebnFzeXFgwH
         iZ6g9HdjY+/BsCiReYbFxuHCpVSIH9DIULEsag+L6ICq48/5d1DoLMY9gpPJLyApf2fK
         6aVqu4XK7W2iFzp3WLzYlVEPgYwyxsS1IzJB9iNjM6dO7MuUjCjFZUFBsWvfANopugRe
         tMOueoQVu/cJFN0NvwwWI/kkTwut2y5OBHf/4mfSp4VlR0r4GMN+pqO6bS7aIK+rvjC1
         2aMPByTop9aIif3krmQmsc7rTVpzvixPB+q8L+WhJZGGjxE68Oyf8A4he2f6K2lEORYx
         PqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVc6mFzrVZfMW1bGolNu2CG8lq3qIiF7T2RJLAhhoTY=;
        b=TuUcehiZncxR7klXvZyll3nx2+gD1sVMzfsgC3pbEFb/nhtDXAKgFtxPb0tNNhRhDE
         sVYqzghV4s0djbgtiMAfz8Yc9H4SoS9kPdfzbt+CpZo3JYeCkJHIWhxrtoeGYgadtdG2
         BzVVeGtbyg/2qfkVL31vFxzgHKS8DQsUppMQebra9XXwlM2QYFH9L8g6wfQxsEmtYLAy
         zMO1biEGnakimknz8ng4+LozuFoZr0VRB59zG4A7/ncTlC89pchE8b5LQFbyB/4o/1wX
         p8a/s9ZtQCj13wIYuLxe7p1f4qz3pUnBn4wAQKzIky1rOMHL7bUgUDdCvlL4v93nUjoZ
         iKGg==
X-Gm-Message-State: AGRZ1gJGECTvl6cNEjzIeB4jgDZvpez9i5Aeu1Uv60oLTjhccZ4ZSCuD
        gqFyI0JMi2MP62W42ukAWkzSMFZm
X-Google-Smtp-Source: AJdET5fu1LapW1TruFB2I0O/f53Z5EF6Sb3Pwu9aYXygPCRu0uKCDaFperhvjN2UF9Om+yW/6RGDmg==
X-Received: by 2002:a2e:809a:: with SMTP id i26-v6mr2121973ljg.100.1540621507415;
        Fri, 26 Oct 2018 23:25:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 62/78] config.txt: move sendemail-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:35 +0200
Message-Id: <20181027062351.30446-63-pclouds@gmail.com>
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
 Documentation/config.txt                                     | 2 +-
 Documentation/{sendemail-config.txt => config/sendemail.txt} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{sendemail-config.txt => config/sendemail.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a6ce22a6d9..1c2a6ec3c5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -403,7 +403,7 @@ include::config/rerere.txt[]
 
 include::config/reset.txt[]
 
-include::sendemail-config.txt[]
+include::config/sendemail.txt[]
 
 sequence.editor::
 	Text editor used by `git rebase -i` for editing the rebase instruction file.
diff --git a/Documentation/sendemail-config.txt b/Documentation/config/sendemail.txt
similarity index 100%
rename from Documentation/sendemail-config.txt
rename to Documentation/config/sendemail.txt
-- 
2.19.1.647.g708186aaf9

