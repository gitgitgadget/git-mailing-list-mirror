Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2460B1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfGERHH (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37620 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfGERHG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so10392463wme.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZK6F8I9MMRXb1nyoGtw4TkkqOifbnYF7o0+q1l/W/JM=;
        b=Iz1A6vcQH78syu9yuJQ4RbstvGdo/2dB/C1OkhNKQCJELLHiesnbhFVZsypIGM8/V8
         umWv0vDWaWqVbljFC6u+XjT4LhxcyP5F+bWrmBucfbCJj7CZvEOvE7d1IaVENkrVSFrZ
         QV//7sf2x3rimh6L0zBH22d3hfUSIb3atQlpZb5/yCbcql9Xu8/h78zbt8etUR82AbVp
         6q2dAE0uzs63Xc1yB92OjoZ7m8rNc0c1oxlP+n2SfnIGt2jk2hDBAdv4mdG7gb6NuRcs
         ojbkx2zDy9bIOaGVEMi/os2NG4ns+Jpl8kmjbQTYVer55Z8CqlXFBRS+LTS/lJCEf91e
         nhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZK6F8I9MMRXb1nyoGtw4TkkqOifbnYF7o0+q1l/W/JM=;
        b=WFw9OBNisuRsgTpqFNj7OayoUi9qrPfCX8HaTAWjHsIB1WNAxxf9t5iyUxq7JBxlCQ
         pXU6bWMOEpP5xkyRNEoQoYE+FELcHApfIVL8i1o5T4c4aV3YNHmp2WQMH/63GM9WdIsD
         OqpmOo+5kKcbqDRHjX7SZswE7mWQX4LJnkxFG+em6+FG7he7oY8oH2GUcfC5DFM6utg8
         WH4d5po8YlSN38Zv7rIERwOoMBtrufQdhOf5dFuN6yOWR4sMnTV6PDO3Zv+uL+iV7dG4
         rcLTuMjmo0Q++BsR30GyLlO2Ic87h6//qCUyDh+eeAxNCi4yxGle2AFfe028b8oqE1Bh
         h/Mw==
X-Gm-Message-State: APjAAAVJebecrAASidqc3knfv+8bmeUoS2JDX89F+UagJ1dzBU7D7R0D
        EZENDMXlQzEC4Gv9U4eEcftfBF8d
X-Google-Smtp-Source: APXvYqw0C0Ep35IGaYJeC9UyCqQP/pQHbl00ei+ckdQP/GXpk7FrzAPoEIv4VUIcf0OV5waknhwpYA==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr4055010wmc.145.1562346423996;
        Fri, 05 Jul 2019 10:07:03 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id 2sm7544334wrn.29.2019.07.05.10.07.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:07:03 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 08/14] range-diff: fix function parameter indentation
Date:   Fri,  5 Jul 2019 18:06:24 +0100
Message-Id: <20190705170630.27500-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the indentation of the function parameters for a couple of
functions, to match the style in the rest of the file.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 48b0e1b4ce..9242b8975f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -148,7 +148,7 @@ static int read_patches(const char *range, struct string_list *list)
 }
 
 static int patch_util_cmp(const void *dummy, const struct patch_util *a,
-		     const struct patch_util *b, const char *keydata)
+			  const struct patch_util *b, const char *keydata)
 {
 	return strcmp(a->diff, keydata ? keydata : b->diff);
 }
@@ -373,7 +373,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 }
 
 static void patch_diff(const char *a, const char *b,
-			      struct diff_options *diffopt)
+		       struct diff_options *diffopt)
 {
 	diff_queue(&diff_queued_diff,
 		   get_filespec("a", a), get_filespec("b", b));
-- 
2.22.0.510.g264f2c817a

