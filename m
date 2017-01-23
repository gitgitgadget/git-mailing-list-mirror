Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C04E20AC5
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdAWUft (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:49 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36527 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdAWUfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:47 -0500
Received: by mail-pg0-f51.google.com with SMTP id t6so47711634pgt.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNxTeRaXx3D17N4/bq5t+o/JtV4W+EkDn723n5BizPM=;
        b=C5zPDHGwmc03seGr2jEZ30r69heGHe4QHEumMBrvwEs1DmriWTerdns9PFBNBb/j4i
         vNNGyZix0pxtIoSNLAk0utpzhM9tOdl1nl2T1VekGPIKrMRmjeAkavcjain/lyUkzVwR
         ua+8WJ0WRKjKR0HNDh6x3/9Xglzal3N1q3H3c/UqQkqBuTALPgGbbLQliiEogS7ZxHaP
         6Gyxbk595Yza88hnp1z1BvK8ls7wGm6o97V0hLDS40Xo+Iwdr22YjOTZC1EstkYPkIV3
         I0wkIJ3HjKeM3YgPT2nivMCEiPsM/tIWb4LM1ewBJTacV9F2YUEKOc+REHJzGep/k61d
         D/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNxTeRaXx3D17N4/bq5t+o/JtV4W+EkDn723n5BizPM=;
        b=D6ZOwn0ebI55FXWrZ+lpVirlo9ot/SKJIJoa4eaGfPdHLnGuiyXrS40aiVepBNaZXm
         MxEtrxjg91earKrtVOihZE0GaNDMM39QaHcBn+giNuigNJYIVbO3F2YwvNICmF/hfs0f
         Wi6fwuuK6wW8UqxnFTVkO87fasdC3iWBTy10nL25XSHDULIewI5vehLQg27f2tZErcg+
         wlJEt3Cgk9Flm0sdg1ssHCxmUl+UfretNMOnUqr9R41bFhtY1iHANuEfVoc8k96rbY6o
         zdNGRLjEo7/5puPUSYCkjU9VaVnHnrXd8boH+Aq8EZMzd986BeeLfkbAKl4jBmEgNVcM
         zvwQ==
X-Gm-Message-State: AIkVDXL2JmIPv4s+2J+FMvFyQLsQiYG7BeNABL0qHKxo2xQfZ2QbrjvJhTXj9BTGgCgPmu8T
X-Received: by 10.84.133.69 with SMTP id 63mr42399125plf.97.1485203746021;
        Mon, 23 Jan 2017 12:35:46 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 06/27] attr.c: mark where #if DEBUG ends more clearly
Date:   Mon, 23 Jan 2017 12:35:04 -0800
Message-Id: <20170123203525.185058-7-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 9bdf87a6f..17297fffe 100644
--- a/attr.c
+++ b/attr.c
@@ -469,7 +469,7 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
 #define debug_set(a,b,c,d) do { ; } while (0)
-#endif
+#endif /* DEBUG_ATTR */
 
 static void drop_attr_stack(void)
 {
-- 
2.11.0.483.g087da7b7c-goog

