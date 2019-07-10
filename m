Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0E51F461
	for <e@80x24.org>; Thu, 11 Jul 2019 00:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfGKAAj (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 20:00:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38952 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGKAAi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 20:00:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so4467383qtu.6
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TA7qLhwVjgT7/njeUhcABACRPDG7IyBV0uSnJgIka+0=;
        b=lYz1Vvn1ABgdlgooOpEjaqM0BTPoM/K66YIOgC0TWF5GpNQs67s0wjNmbfQjsYVBNi
         amwvVA3BicggBGSh7WLJdBRqdwfq6E/3ol72Yn4BbXFJI+1QFg2OhdCRqC9YYb3GUhGm
         Bq31njUI18j9Vm2vDb1Z0PSN2PoZrX5NGSzQ1Ns76kh7+JKYDpQ58hI0zrpIzifgu7IH
         3lWLbTRuT+NJY0UqIknPXx6DwwbU61mZIhxi3lEkqp9QwCHUZFVCLCgj4urigwKOkJrO
         nsZrEPDXS7+0SyC9bqU80m6izoVp6QCRAbVLJfhtZXhzTtvnWVy1xiuu9pLI386ab0Xh
         oW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TA7qLhwVjgT7/njeUhcABACRPDG7IyBV0uSnJgIka+0=;
        b=XWI2duvhnL3WnJWoFPctPoJQQZHk8vDozppIzVSUpQMNoxhwJrlZGPIaMtYkfM8InY
         pVlCGVSjff+nktx3/8NS2FSaG1yN72LwV4HTY19Pj6dvNYwSDYeZRdKPYM3x5URqHGVH
         tAjR7BJseGSABKfR2WhcuNge4uWaecur5jvFrMZ9F3gVHMrWt0V1yg5vRl/9TwtYNFvU
         MSLw3IMv4BHz+6JA7fbf8HqsG89nHs20xX4R++DuyHFNGTYG2dXcVcAPqghLlTEkL0RE
         AHLHDP12X0gHuZm93H9QocE5dgQ+DnqikRmxmFsS2zZU/E2g8E0fm1nMJHOLhPmBGCoL
         GqHw==
X-Gm-Message-State: APjAAAVYEulHhPlC0ch5Yt7btvFsqdu4LpQMoZm1ix5E3hI9dSJWeORa
        XPydzgpBLz59mzyvgMicelaAAA==
X-Google-Smtp-Source: APXvYqyRrRbPKjhKn0qhq6l47wNGeLxYn7BYr93KT7HT8M86MNWvXax/yghxrnx0g0JwgFKQIiGS1w==
X-Received: by 2002:ac8:359a:: with SMTP id k26mr578155qtb.87.1562803237774;
        Wed, 10 Jul 2019 17:00:37 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.17.00.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:00:37 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com, Jeff King <peff@peff.net>
Subject: [GSoC][PATCH v8 10/10] clone: replace strcmp by fspathcmp
Date:   Wed, 10 Jul 2019 20:59:04 -0300
Message-Id: <782ca07eed2c9bac4378e5128ff996b25ed86a43.1562801255.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the use of strcmp by fspathcmp at copy_or_link_directory, which
is more permissive/friendly to case-insensitive file systems.

Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 47cb4a2a8e..8da696ef30 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -444,7 +444,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(iter->relative_path, "info/alternates")) {
+		if (!fspathcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, src_repo);
 			continue;
 		}
-- 
2.22.0

